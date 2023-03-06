Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26756AC888
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCFQqA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCFQoj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534348A59;
        Mon,  6 Mar 2023 08:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121043; x=1709657043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DrUqSl9idHBYe282IvH6p/BoQ7hfz0gQaI8IAIo6Js=;
  b=n5rG56+Ks6lKyITmKjCISHf/yvzGTnkesGKjxr42mtkKuZMgkoHkwoiz
   rcqz66qKWHhzfNWx1pLw53nY4mF1cdLFDNC8qEhuCaWx3CsSV+hv/wQc8
   KVK2orV0gTXhzQ6lVWMzq78tuDJGKf9afAYbVIPpB8zxxFufsm71VK8bj
   96eFgr1hqztQ35VWKzOLKhiQlGPIBpn8vOa5/DVGxao3CTLPETAYQRltC
   QcGKFU3wtgOToh3zGjRVNaIWYyH7ze9eSReOWxr0VOVnHQqoF8col/7Qp
   jfp6t+6FRT79kbjHTDHYbuTLM2iZFkfz2slp4kpntqehU60XWjQZYAUAA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181177"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181177"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504544"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504544"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:58 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 11/16] dmaengine: idxd: process batch descriptor completion record faults
Date:   Mon,  6 Mar 2023 08:31:33 -0800
Message-Id: <20230306163138.587484-12-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230306163138.587484-1-fenghua.yu@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
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
v2:
- Call iommu_access_remote_vm() to copy completion record to user.

 drivers/dma/idxd/idxd.h      |  3 ++
 drivers/dma/idxd/init.c      |  4 ++
 drivers/dma/idxd/irq.c       | 74 ++++++++++++++++++++++++++++--------
 drivers/dma/idxd/registers.h |  4 +-
 include/uapi/linux/idxd.h    |  1 +
 5 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 48cdfd5ee44f..8f3b0fbd04ae 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -261,6 +261,8 @@ struct idxd_driver_data {
 	int compl_size;
 	int align;
 	int evl_cr_off;
+	int cr_status_off;
+	int cr_result_off;
 };
 
 struct idxd_evl {
@@ -274,6 +276,7 @@ struct idxd_evl {
 	u16 size;
 	u16 head;
 	unsigned long *bmap;
+	bool batch_fail[IDXD_MAX_BATCH_IDENT];
 };
 
 struct idxd_evl_fault {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 19324fbc238c..73fb9c74ed20 100644
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
index 24c688f0ca9e..894a73e56cb6 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -226,28 +226,71 @@ static void idxd_evl_fault_work(struct work_struct *work)
 	struct idxd_wq *wq = fault->wq;
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
+	struct idxd_evl *evl = idxd->evl;
 	struct __evl_entry *entry_head = fault->entry;
 	void *cr = (void *)entry_head + idxd->data->evl_cr_off;
-	int cr_size = idxd->data->compl_size, copied;
+	int cr_size = idxd->data->compl_size;
+	u8 *status = (u8 *)cr + idxd->data->cr_status_off;
+	u8 *result = (u8 *)cr + idxd->data->cr_result_off;
+	int copied, copy_size;
+	bool *bf;
 
 	switch (fault->status) {
 	case DSA_COMP_CRA_XLAT:
-	case DSA_COMP_DRAIN_EVL:
-		/*
-		 * Copy completion record to user address space that is found
-		 * by PASID.
-		 */
-		copied = iommu_access_remote_vm(entry_head->pasid,
-						entry_head->fault_addr, cr,
-						cr_size, FOLL_WRITE);
-		if (copied != cr_size) {
-			dev_err(dev, "Failed to write to completion record. (%d:%d)\n",
-				cr_size, copied);
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
 		}
 		break;
+	case DSA_COMP_DRAIN_EVL:
+		copy_size = cr_size;
+		break;
 	default:
-		dev_err(dev, "Unrecognized error code: %#x\n",
-			DSA_COMP_STATUS(entry_head->error));
+		copy_size = 0;
+		dev_err(dev, "Unrecognized error code: %#x\n", fault->status);
+		break;
+	}
+
+	if (copy_size == 0)
+		return;
+
+	/*
+	 * Copy completion record to user address space that is found by PASID.
+	 */
+	copied = iommu_access_remote_vm(entry_head->pasid,
+					entry_head->fault_addr,
+					cr, copy_size, FOLL_WRITE);
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
+		if (copied != copy_size) {
+			dev_err(dev, "Failed to write to batch completion record: (%d:%d)\n",
+				copy_size, copied);
+		}
+		break;
+	case DSA_COMP_DRAIN_EVL:
+		if (copied != copy_size)
+			dev_err(dev, "Failed to write to drain completion record: (%d:%d)\n",
+				copy_size, copied);
 		break;
 	}
 
@@ -266,7 +309,8 @@ static void process_evl_entry(struct idxd_device *idxd,
 	} else {
 		status = DSA_COMP_STATUS(entry_head->error);
 
-		if (status == DSA_COMP_CRA_XLAT || status == DSA_COMP_DRAIN_EVL) {
+		if (status == DSA_COMP_CRA_XLAT || status == DSA_COMP_DRAIN_EVL ||
+		    status == DSA_COMP_BATCH_EVL_ERR) {
 			struct idxd_evl_fault *fault;
 			int ent_size = evl_ent_size(idxd);
 
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 148db94f9373..9f3959d001b6 100644
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
@@ -577,6 +577,8 @@ union evl_status_reg {
 	u64 bits;
 } __packed;
 
+#define IDXD_MAX_BATCH_IDENT	256
+
 struct __evl_entry {
 	u64 rsvd:2;
 	u64 desc_valid:1;
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 76ad71bf751e..606b52e88ce3 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -136,6 +136,7 @@ enum dsa_completion_status {
 	DSA_COMP_HW_ERR_DRB,
 	DSA_COMP_TRANSLATION_FAIL,
 	DSA_COMP_DRAIN_EVL = 0x26,
+	DSA_COMP_BATCH_EVL_ERR,
 };
 
 enum iax_completion_status {
-- 
2.37.1

