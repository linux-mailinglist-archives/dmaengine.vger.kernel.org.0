Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3069765C408
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbjACQfa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjACQfU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB492C9
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763719; x=1704299719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VkxiOJPfPUavkRcBR4r+LhPVqKHrXVEXq3scumGO7s=;
  b=nXBPBCN9KXJ1rp8hqaMk2p8OpGSqXRo8DZfjgIB8fH2t26MQ5Dv78eSW
   bNGEPvLoHayPe4vqFCuVa9qMWavuPOq/DLsD8kJ3NBSE4LRHMxyVXhzvP
   ivEeHpPIvFjc+gRdBtBkYG1lMNVmoauWPUOOHNnN9PQYHQiZgUpMptc9O
   RMzAVU3aMPuqdf/LLXy+nMtZ1Ah3YPBjN/LIdXtAMPvSd9Skx8jvyia6c
   EDj3zzy0NjjdMnC0p97CeimzSe3TLE/mnz2i1X50fDgCOUJ5CM5iZUN0P
   m9gBuqUhT6Lu1apWL2A7tJ53K8yMECEkEZD4qLMGdiMDwxGfPCWzZaLQ7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072337"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072337"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858553"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858553"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:15 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 12/17] dmaengine: idxd: process batch descriptor completion record faults
Date:   Tue,  3 Jan 2023 08:35:00 -0800
Message-Id: <20230103163505.1569356-13-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103163505.1569356-1-fenghua.yu@intel.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add event log processing for faulting of user batch descriptor completion
record.

When encountering an event log entry for a page fault on a completion
record, the driver is expected to do the following:
1. If the "first error in batch" bit in event log entry error info is
set, discard any previously recorded errors associated with the
"batch identifier".
2. Fix the page fault according to the fault address in the event log. If
successful, write the completion record to the fault address in user space.
3. If an error is encountered while writing the completion record and it is
associated to a descriptor in the batch, the driver associates the error
with the batch identifier of the event log entry and tracks it until the
event log entry for the corresponding batch desc is encountered.

While processing an event log entry for a batch descriptor with error
indicating that one or more descs in the batch had event log entries,
the driver will do the following before writing the batch completion
record:
1. If the status field of the completion record is 0x1, the driver will
change it to error code 0x5 (one or more operations in batch completed
with status not successful) and changes the result field to 1.
2. If the status is error code 0x6 (page fault on batch descriptor list
address), change the result field to 1.
3. If status is any other value, the completion record is not changed.
4. Clear the recorded error in preparation for next batch with same batch
identifier.

The result field is for user software to determine whether to set the
"Batch Error" flag bit in the descriptor for continuation of partial
batch descriptor completion. See DSA spec 2.0 for additional information.

If no error has been recorded for the batch, the batch completion record is
written to user space as is.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/idxd.h      |  3 ++
 drivers/dma/idxd/init.c      |  4 +++
 drivers/dma/idxd/irq.c       | 60 ++++++++++++++++++++++++++++++------
 drivers/dma/idxd/registers.h |  4 ++-
 include/uapi/linux/idxd.h    |  1 +
 5 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 61c0616828c0..00edf68e3528 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -260,6 +260,8 @@ struct idxd_driver_data {
 	int compl_size;
 	int align;
 	int evl_cr_off;
+	int cr_status_off;
+	int cr_result_off;
 };
 
 struct idxd_evl {
@@ -273,6 +275,7 @@ struct idxd_evl {
 	u16 size;
 	u16 head;
 	unsigned long *bmap;
+	bool batch_fail[IDXD_MAX_BATCH_IDENT];
 };
 
 struct idxd_evl_fault {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index c0fffc31c6e4..ddb9b13f3c3c 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -48,6 +48,8 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.align = 32,
 		.dev_type = &dsa_device_type,
 		.evl_cr_off = offsetof(struct dsa_evl_entry, cr),
+		.cr_status_off = offsetof(struct dsa_completion_record, status),
+		.cr_result_off = offsetof(struct dsa_completion_record, result),
 	},
 	[IDXD_TYPE_IAX] = {
 		.name_prefix = "iax",
@@ -56,6 +58,8 @@ static struct idxd_driver_data idxd_driver_data[] = {
 		.align = 64,
 		.dev_type = &iax_device_type,
 		.evl_cr_off = offsetof(struct iax_evl_entry, cr),
+		.cr_status_off = offsetof(struct iax_completion_record, status),
+		.cr_result_off = offsetof(struct iax_completion_record, error_code),
 	},
 };
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 44b5ed808b31..18245f82d367 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -226,11 +226,15 @@ static void idxd_evl_fault_work(struct work_struct *work)
 	struct idxd_wq *wq = fault->wq;
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
+	struct idxd_evl *evl = idxd->evl;
 	struct mm_struct *mm;
-	int copied;
+	int copied, copy_size;
 	struct __evl_entry *entry_head = fault->entry;
 	void *cr = (void *)entry_head + idxd->data->evl_cr_off;
 	int cr_size = idxd->data->compl_size;
+	u8 *status = (u8 *)cr + idxd->data->cr_status_off;
+	u8 *result = (u8 *)cr + idxd->data->cr_result_off;
+	bool *bf;
 
 	mm = iommu_sva_find(entry_head->pasid);
 	if (IS_ERR_OR_NULL(mm)) {
@@ -242,16 +246,53 @@ static void idxd_evl_fault_work(struct work_struct *work)
 
 	switch (fault->status) {
 	case DSA_COMP_CRA_XLAT:
+		if (entry_head->batch && entry_head->first_err_in_batch)
+			evl->batch_fail[entry_head->batch_id] = false;
+
+		copy_size = cr_size;
+		break;
+	case DSA_COMP_BATCH_EVL_ERR:
+		bf = &evl->batch_fail[entry_head->batch_id];
+
+		copy_size = entry_head->rcr || *bf ? cr_size : 0;
+		if (*bf) {
+			if (*status == DSA_COMP_SUCCESS)
+				*status = DSA_COMP_BATCH_FAIL;
+			*result = 1;
+			*bf = false;
+		}
+		break;
 	case DSA_COMP_DRAIN_EVL:
-		copied = access_remote_vm(mm, entry_head->fault_addr, cr, cr_size,
-					  FOLL_WRITE | FOLL_REMOTE);
-		if (copied != cr_size)
-			dev_err(dev, "Failed to write to completion record. (%d:%d)\n",
-				cr_size, copied);
+		copy_size = cr_size;
 		break;
 	default:
-		dev_err(dev, "Unrecognized error code: %#x\n",
-			DSA_COMP_STATUS(entry_head->error));
+		copy_size = 0;
+		dev_err(dev, "Unrecognized error code: %#x\n", fault->status);
+		break;
+	}
+
+	if (copy_size)
+		copied = access_remote_vm(mm, entry_head->fault_addr, cr, copy_size,
+					  FOLL_WRITE | FOLL_REMOTE);
+
+	switch (fault->status) {
+	case DSA_COMP_CRA_XLAT:
+		if (copied != copy_size) {
+			dev_err(dev, "Failed to write to completion record: (%d:%d)\n",
+				copy_size, copied);
+			if (entry_head->batch)
+				evl->batch_fail[entry_head->batch_id] = true;
+		}
+		break;
+	case DSA_COMP_BATCH_EVL_ERR:
+		if (copied != copy_size)
+			dev_err(dev, "Failed to write to batch completion record: (%d:%d)\n",
+				copy_size, copied);
+		break;
+	case DSA_COMP_DRAIN_EVL:
+		if (copied != copy_size)
+			dev_err(dev, "Failed to write to drain completion record: (%d:%d)\n",
+				copy_size, copied);
 		break;
 	}
 
@@ -271,7 +312,8 @@ static void process_evl_entry(struct idxd_device *idxd,
 	} else {
 		status = DSA_COMP_STATUS(entry_head->error);
 
-		if (status == DSA_COMP_CRA_XLAT || status == DSA_COMP_DRAIN_EVL) {
+		if (status == DSA_COMP_CRA_XLAT || status == DSA_COMP_DRAIN_EVL ||
+		    status == DSA_COMP_BATCH_EVL_ERR) {
 			struct idxd_evl_fault *fault;
 			int ent_size = evl_ent_size(idxd);
 
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index a3c56847b38a..a772116b4c0d 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -35,7 +35,7 @@ union gen_cap_reg {
 		u64 drain_readback:1;
 		u64 rsvd2:3;
 		u64 evl_support:2;
-		u64 rsvd4:1;
+		u64 batch_continuation:1;
 		u64 max_xfer_shift:5;
 		u64 max_batch_shift:4;
 		u64 max_ims_mult:6;
@@ -556,6 +556,8 @@ union evl_status_reg {
 	u64 bits;
 } __packed;
 
+#define IDXD_MAX_BATCH_IDENT	256
+
 struct __evl_entry {
 	u64 rsvd:2;
 	u64 desc_valid:1;
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 37732016f3b0..2645fa8662cc 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -134,6 +134,7 @@ enum dsa_completion_status {
 	DSA_COMP_HW_ERR_DRB,
 	DSA_COMP_TRANSLATION_FAIL,
 	DSA_COMP_DRAIN_EVL = 0x26,
+	DSA_COMP_BATCH_EVL_ERR,
 };
 
 enum iax_completion_status {
-- 
2.32.0

