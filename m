Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84F2508D8F
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 18:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380712AbiDTQqZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380710AbiDTQqZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 12:46:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F94665F
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650473017; x=1682009017;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7ek2VhTQ29DnmV5aR9eLm+TnJ+DjWoQjxsKitoSnxhQ=;
  b=P2v6EKo/TKBSg/0sNK/QP4lXLiTdMnz26Jk3ABGH3LcPANIUY42jbl3y
   QWnx+WbKrm5xdKSL2l1zvRO+ds13MNKb1i52o+KtFzvLhKMY91QNfHwBC
   v3UgX0Yk1Ww1ycRZgDT7NFXFIlYLjM7Z4Wz9VDdX4Z68vBYwTUIaFcEXy
   BsB9uzXyFl7KdkiGpFTvHtXyZcWnkoG+Uc5YCHNgXnIJqVfVsTsOGXNjZ
   VrT3h1RUx8hfywNpgRfyvsglWu2hiiS7Tvc+BVZYIxKv5WqlQjAeVasbS
   z+8Pjn2puOHrJoOMHfCjtO4XFhYnTVeKjmjf4kFft7kDzeZHvsnMsSkgn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244669163"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="244669163"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 09:43:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="555289744"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 09:43:36 -0700
Subject: [PATCH] dmaengine: idxd: refactor wq driver enable/disable operations
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 20 Apr 2022 09:43:36 -0700
Message-ID: <165047301643.3841827.11222723219862233060.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the core driver operations from wq driver to the drv_enable_wq() and
drv_disable_wq() functions. The move should reduce the wq driver's
knowledge of the core driver operations and prevent code confusion for
future wq drivers.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c   |    6 ++---
 drivers/dma/idxd/device.c |   58 +++++++++++++++++++++++++++++----------------
 drivers/dma/idxd/dma.c    |   38 ++---------------------------
 drivers/dma/idxd/idxd.h   |    2 --
 4 files changed, 43 insertions(+), 61 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index b9b2b4a4124e..b670b75885ad 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -314,7 +314,7 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 
 	mutex_lock(&wq->wq_lock);
 	wq->type = IDXD_WQT_USER;
-	rc = __drv_enable_wq(wq);
+	rc = drv_enable_wq(wq);
 	if (rc < 0)
 		goto err;
 
@@ -329,7 +329,7 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 	return 0;
 
 err_cdev:
-	__drv_disable_wq(wq);
+	drv_disable_wq(wq);
 err:
 	wq->type = IDXD_WQT_NONE;
 	mutex_unlock(&wq->wq_lock);
@@ -342,7 +342,7 @@ static void idxd_user_drv_remove(struct idxd_dev *idxd_dev)
 
 	mutex_lock(&wq->wq_lock);
 	idxd_wq_del_cdev(wq);
-	__drv_disable_wq(wq);
+	drv_disable_wq(wq);
 	wq->type = IDXD_WQT_NONE;
 	mutex_unlock(&wq->wq_lock);
 }
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 4f5c2367ec93..22ad9ee383e2 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1196,6 +1196,9 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
 	struct idxd_irq_entry *ie;
 	int rc;
 
+	if (wq->type != IDXD_WQT_KERNEL)
+		return 0;
+
 	ie = &wq->ie;
 	ie->vector = pci_irq_vector(pdev, ie->id);
 	ie->pasid = device_pasid_enabled(idxd) ? idxd->pasid : INVALID_IOASID;
@@ -1227,7 +1230,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
 	return rc;
 }
 
-int __drv_enable_wq(struct idxd_wq *wq)
+int drv_enable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
@@ -1328,8 +1331,36 @@ int __drv_enable_wq(struct idxd_wq *wq)
 	}
 
 	wq->client_count = 0;
+
+	rc = idxd_wq_request_irq(wq);
+	if (rc < 0) {
+		idxd->cmd_status = IDXD_SCMD_WQ_IRQ_ERR;
+		dev_dbg(dev, "WQ %d irq setup failed: %d\n", wq->id, rc);
+		goto err_irq;
+	}
+
+	rc = idxd_wq_alloc_resources(wq);
+	if (rc < 0) {
+		idxd->cmd_status = IDXD_SCMD_WQ_RES_ALLOC_ERR;
+		dev_dbg(dev, "WQ resource alloc failed\n");
+		goto err_res_alloc;
+	}
+
+	rc = idxd_wq_init_percpu_ref(wq);
+	if (rc < 0) {
+		idxd->cmd_status = IDXD_SCMD_PERCPU_ERR;
+		dev_dbg(dev, "percpu_ref setup failed\n");
+		goto err_ref;
+	}
+
 	return 0;
 
+err_ref:
+	idxd_wq_free_resources(wq);
+err_res_alloc:
+	idxd_wq_free_irq(wq);
+err_irq:
+	idxd_wq_unmap_portal(wq);
 err_map_portal:
 	rc = idxd_wq_disable(wq, false);
 	if (rc < 0)
@@ -1338,17 +1369,7 @@ int __drv_enable_wq(struct idxd_wq *wq)
 	return rc;
 }
 
-int drv_enable_wq(struct idxd_wq *wq)
-{
-	int rc;
-
-	mutex_lock(&wq->wq_lock);
-	rc = __drv_enable_wq(wq);
-	mutex_unlock(&wq->wq_lock);
-	return rc;
-}
-
-void __drv_disable_wq(struct idxd_wq *wq)
+void drv_disable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
@@ -1359,21 +1380,16 @@ void __drv_disable_wq(struct idxd_wq *wq)
 		dev_warn(dev, "Clients has claim on wq %d: %d\n",
 			 wq->id, idxd_wq_refcount(wq));
 
+	idxd_wq_free_resources(wq);
 	idxd_wq_unmap_portal(wq);
-
 	idxd_wq_drain(wq);
 	idxd_wq_reset(wq);
-
+	percpu_ref_exit(&wq->wq_active);
+	idxd_wq_free_irq(wq);
+	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
 
-void drv_disable_wq(struct idxd_wq *wq)
-{
-	mutex_lock(&wq->wq_lock);
-	__drv_disable_wq(wq);
-	mutex_unlock(&wq->wq_lock);
-}
-
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 {
 	struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 644114465b33..950f06c8aad5 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -291,34 +291,13 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 	mutex_lock(&wq->wq_lock);
 	wq->type = IDXD_WQT_KERNEL;
 
-	rc = __drv_enable_wq(wq);
+	rc = drv_enable_wq(wq);
 	if (rc < 0) {
 		dev_dbg(dev, "Enable wq %d failed: %d\n", wq->id, rc);
 		rc = -ENXIO;
 		goto err;
 	}
 
-	rc = idxd_wq_request_irq(wq);
-	if (rc < 0) {
-		idxd->cmd_status = IDXD_SCMD_WQ_IRQ_ERR;
-		dev_dbg(dev, "WQ %d irq setup failed: %d\n", wq->id, rc);
-		goto err_irq;
-	}
-
-	rc = idxd_wq_alloc_resources(wq);
-	if (rc < 0) {
-		idxd->cmd_status = IDXD_SCMD_WQ_RES_ALLOC_ERR;
-		dev_dbg(dev, "WQ resource alloc failed\n");
-		goto err_res_alloc;
-	}
-
-	rc = idxd_wq_init_percpu_ref(wq);
-	if (rc < 0) {
-		idxd->cmd_status = IDXD_SCMD_PERCPU_ERR;
-		dev_dbg(dev, "percpu_ref setup failed\n");
-		goto err_ref;
-	}
-
 	rc = idxd_register_dma_channel(wq);
 	if (rc < 0) {
 		idxd->cmd_status = IDXD_SCMD_DMA_CHAN_ERR;
@@ -331,14 +310,7 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 	return 0;
 
 err_dma:
-	__idxd_wq_quiesce(wq);
-	percpu_ref_exit(&wq->wq_active);
-err_ref:
-	idxd_wq_free_resources(wq);
-err_res_alloc:
-	idxd_wq_free_irq(wq);
-err_irq:
-	__drv_disable_wq(wq);
+	drv_disable_wq(wq);
 err:
 	wq->type = IDXD_WQT_NONE;
 	mutex_unlock(&wq->wq_lock);
@@ -352,11 +324,7 @@ static void idxd_dmaengine_drv_remove(struct idxd_dev *idxd_dev)
 	mutex_lock(&wq->wq_lock);
 	__idxd_wq_quiesce(wq);
 	idxd_unregister_dma_channel(wq);
-	idxd_wq_free_resources(wq);
-	__drv_disable_wq(wq);
-	percpu_ref_exit(&wq->wq_active);
-	idxd_wq_free_irq(wq);
-	wq->type = IDXD_WQT_NONE;
+	drv_disable_wq(wq);
 	mutex_unlock(&wq->wq_lock);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index da72eb15f610..8e03fb548d13 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -559,9 +559,7 @@ void idxd_unregister_idxd_drv(void);
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
 void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
-int __drv_enable_wq(struct idxd_wq *wq);
 void drv_disable_wq(struct idxd_wq *wq);
-void __drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);


