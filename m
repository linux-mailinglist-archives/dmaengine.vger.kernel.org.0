Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51F6B7ED4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCMRHG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjCMRGc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:06:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0E7EA30;
        Mon, 13 Mar 2023 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678727157; x=1710263157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6O21OYN8R4QD9eH6uwFxO2gXmvwc5fLcx9/yhaQdohw=;
  b=YfG7+H8MchtpTYfna+umjLumC6XG4aYFLgDAohDV/3KXgBeySc4xOjx3
   Qm++S2MVlEgp5yH/qXNYykY4CGIhPpygk6qjv9JFIkTv/YUgVewUDbKXo
   nxv843/APhtxcLh/g39gzm3H9X+6qpsLUUVDp0jKEtxHSLFSJ4Z23FIcE
   xpq3J5Qxt0l8DqMAd6MyU4SeqZJwrOpKQIgLkgKD5MX3x9kGuwO84g47h
   LvWIiWFiLLqFJuDiPu47gq8kSnfKFWbIwQXXMRwRChAPvgPifxyaMVbDG
   FzGiigfjQ/d99eJVvFgL4kAHNq/IuZ7Mo71U53DakMzFioUaaLCoWCGTQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334679676"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334679676"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708950936"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708950936"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 10:02:41 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 11/16] dmaengine: idxd: process batch descriptor completion record faults
Date:   Mon, 13 Mar 2023 10:02:14 -0700
Message-Id: <20230313170219.1956012-12-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230313170219.1956012-1-fenghua.yu@intel.com>
References: <20230313170219.1956012-1-fenghua.yu@intel.com>
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
v3:
- Call new function idxd_copy_cr().

v2:
- Call iommu_access_remote_vm() to copy completion record to user.
 drivers/dma/idxd/idxd.h      |  3 ++
 drivers/dma/idxd/init.c      |  4 ++
 drivers/dma/idxd/irq.c       | 74 ++++++++++++++++++++++++++++--------
 drivers/dma/idxd/registers.h |  4 +-
 include/uapi/linux/idxd.h    |  1 +
 5 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 3963c83165a6..4c4baa80c731 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -265,6 +265,8 @@ struct idxd_driver_data {
 	int compl_size;
 	int align;
 	int evl_cr_off;
+	int cr_status_off;
+	int cr_result_off;
 };
 
 struct idxd_evl {
@@ -278,6 +280,7 @@ struct idxd_evl {
 	u16 size;
 	u16 head;
 	unsigned long *bmap;
+	bool batch_fail[IDXD_MAX_BATCH_IDENT];
 };
 
 struct idxd_evl_fault {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index be4f3676e1a6..9b3e7f0770d1 100644
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
index a428d89de077..155c1970497f 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -225,28 +225,71 @@ static void idxd_evl_fault_work(struct work_struct *work)
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
-		 * Copy completion record to fault_addr in user address space
-		 * that is found by wq and PASID.
-		 */
-		copied = idxd_copy_cr(wq, entry_head->pasid,
-				      entry_head->fault_addr,
-				      cr, cr_size);
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
+	 * Copy completion record to fault_addr in user address space
+	 * that is found by wq and PASID.
+	 */
+	copied = idxd_copy_cr(wq, entry_head->pasid, entry_head->fault_addr,
+			      cr, copy_size);
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
 
@@ -265,7 +308,8 @@ static void process_evl_entry(struct idxd_device *idxd,
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

