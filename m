Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300776DB54D
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDGUcI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjDGUbf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF51C140;
        Fri,  7 Apr 2023 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899492; x=1712435492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=weIoFwPmDBgK/Kz633bx40JkpnSzh85lXO3LAWwlT/Q=;
  b=RhJQ2kaeAQbHp9z7ANhRbQ+NbpQBlszMpRi3S40q7VE+I4wr00lz5yTm
   h+PBh8iMOS5gGFVoZPhy8kpnryhILV/WL3f9kG/ggrzLqSHdclkTQjltf
   mAAkzpX/usw0M0IHJz4HJ4nPd0g0F1VL8F6kAUVkq2MWgTympOUJMY4CS
   hMPfx1UbW+c3jQsN8EjHiEgv/yA1ft2EMoQ5aouOhMiLmU/v/aiJsyBH6
   U78CC9zYCpkj7YwIw4yULnGbO17yp1FC83FhC7SmFsVQzs/j1DVAXVdpD
   TT//LhSNh60OdIfjyaX/dH3TfL4Q0otPk1lHRSmz1dpkz4ynBNzYF7ify
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196876"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125897"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125897"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:27 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 12/16] dmaengine: idxd: add per file user counters for completion record faults
Date:   Fri,  7 Apr 2023 13:31:39 -0700
Message-Id: <20230407203143.2189681-13-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add counters per opened file for the char device in order to keep track how
many completion record faults occurred and how many of those faults failed
the writeback by the driver after attempt to fault in the page. The
counters are managed by xarray that associates the PASID with
struct idxd_user_context.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v3:
- Move majority of the xarry code to patch 8 which implements new function
  idxd_copy_cr() since the function needs the xarry to maintain and find
  mm by wq and PASID. Only keep the user counters related xarry code here.
 drivers/dma/idxd/cdev.c | 18 ++++++++++++++++++
 drivers/dma/idxd/idxd.h |  7 +++++++
 drivers/dma/idxd/irq.c  |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0a51c33198f6..5c8e964e671b 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -39,6 +39,7 @@ struct idxd_user_context {
 	struct mm_struct *mm;
 	unsigned int flags;
 	struct iommu_sva *sva;
+	u64 counters[COUNTER_MAX];
 };
 
 static void idxd_cdev_dev_release(struct device *dev)
@@ -84,6 +85,23 @@ static void idxd_xa_pasid_remove(struct idxd_user_context *ctx)
 	mutex_unlock(&wq->uc_lock);
 }
 
+void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index)
+{
+	struct idxd_user_context *ctx;
+
+	if (index >= COUNTER_MAX)
+		return;
+
+	mutex_lock(&wq->uc_lock);
+	ctx = xa_load(&wq->upasid_xa, pasid);
+	if (!ctx) {
+		mutex_unlock(&wq->uc_lock);
+		return;
+	}
+	ctx->counters[index]++;
+	mutex_unlock(&wq->uc_lock);
+}
+
 static int idxd_cdev_open(struct inode *inode, struct file *filp)
 {
 	struct idxd_user_context *ctx;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 4c4baa80c731..9fb26d017285 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -127,6 +127,12 @@ struct idxd_pmu {
 
 #define IDXD_MAX_PRIORITY	0xf
 
+enum {
+	COUNTER_FAULTS = 0,
+	COUNTER_FAULT_FAILS,
+	COUNTER_MAX
+};
+
 enum idxd_wq_state {
 	IDXD_WQ_DISABLED = 0,
 	IDXD_WQ_ENABLED,
@@ -713,6 +719,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq);
 void idxd_wq_del_cdev(struct idxd_wq *wq);
 int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
 		 void *buf, int len);
+void idxd_user_counter_increment(struct idxd_wq *wq, u32 pasid, int index);
 
 /* perfmon */
 #if IS_ENABLED(CONFIG_INTEL_IDXD_PERFMON)
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index c660d63a3eb8..f4b0f59c95ba 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -240,6 +240,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 			evl->batch_fail[entry_head->batch_id] = false;
 
 		copy_size = cr_size;
+		idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULTS);
 		break;
 	case DSA_COMP_BATCH_EVL_ERR:
 		bf = &evl->batch_fail[entry_head->batch_id];
@@ -251,6 +252,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 			*result = 1;
 			*bf = false;
 		}
+		idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULTS);
 		break;
 	case DSA_COMP_DRAIN_EVL:
 		copy_size = cr_size;
@@ -282,6 +284,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 	switch (fault->status) {
 	case DSA_COMP_CRA_XLAT:
 		if (copied != copy_size) {
+			idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULT_FAILS);
 			dev_dbg_ratelimited(dev, "Failed to write to completion record: (%d:%d)\n",
 					    copy_size, copied);
 			if (entry_head->batch)
@@ -290,6 +293,7 @@ static void idxd_evl_fault_work(struct work_struct *work)
 		break;
 	case DSA_COMP_BATCH_EVL_ERR:
 		if (copied != copy_size) {
+			idxd_user_counter_increment(wq, entry_head->pasid, COUNTER_FAULT_FAILS);
 			dev_dbg_ratelimited(dev, "Failed to write to batch completion record: (%d:%d)\n",
 					    copy_size, copied);
 		}
-- 
2.37.1

