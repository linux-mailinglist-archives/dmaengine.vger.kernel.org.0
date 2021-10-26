Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62A43BCA2
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhJZVsD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 17:48:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:53692 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235831AbhJZVsC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Oct 2021 17:48:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253564718"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="253564718"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:45:38 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="572654670"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:45:35 -0700
Subject: [PATCH] dmaengine: idxd: set defaults for wq configs
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 26 Oct 2021 14:45:34 -0700
Message-ID: <163528473483.3926048.7950067926287180976.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add default values for wq size, max_xfer_size and max_batch_size. These
values should provide a general guidance for the wq configuration when
the user does not specify any specific values.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   13 +++++--------
 drivers/dma/idxd/idxd.h   |    4 ++++
 drivers/dma/idxd/init.c   |    4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 1dc5245107df..36e213a8108d 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -390,6 +390,8 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
+	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
+	wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
 }
 
 static void idxd_wq_ref_release(struct percpu_ref *ref)
@@ -839,15 +841,12 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 		wq->wqcfg->bits[i] = ioread32(idxd->reg_base + wq_offset);
 	}
 
+	if (wq->size == 0 && wq->type != IDXD_WQT_NONE)
+		wq->size = WQ_DEFAULT_QUEUE_DEPTH;
+
 	/* byte 0-3 */
 	wq->wqcfg->wq_size = wq->size;
 
-	if (wq->size == 0) {
-		idxd->cmd_status = IDXD_SCMD_WQ_NO_SIZE;
-		dev_warn(dev, "Incorrect work queue size: 0\n");
-		return -EINVAL;
-	}
-
 	/* bytes 4-7 */
 	wq->wqcfg->wq_thresh = wq->threshold;
 
@@ -993,8 +992,6 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 
 		if (!wq->group)
 			continue;
-		if (!wq->size)
-			continue;
 
 		if (wq_shared(wq) && !device_swq_supported(idxd)) {
 			idxd->cmd_status = IDXD_SCMD_WQ_NO_SWQ_SUPPORT;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 51e79201636c..89e98d69115b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -150,6 +150,10 @@ struct idxd_cdev {
 #define WQ_NAME_SIZE   1024
 #define WQ_TYPE_SIZE   10
 
+#define WQ_DEFAULT_QUEUE_DEPTH		16
+#define WQ_DEFAULT_MAX_XFER		SZ_2M
+#define WQ_DEFAULT_MAX_BATCH		32
+
 enum idxd_op_type {
 	IDXD_OP_BLOCK = 0,
 	IDXD_OP_NONBLOCK = 1,
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 912839bf0be3..94ecd4bf0f0e 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -246,8 +246,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		init_waitqueue_head(&wq->err_queue);
 		init_completion(&wq->wq_dead);
 		init_completion(&wq->wq_resurrect);
-		wq->max_xfer_bytes = idxd->max_xfer_bytes;
-		wq->max_batch_size = idxd->max_batch_size;
+		wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
+		wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
 			put_device(conf_dev);


