Return-Path: <dmaengine+bounces-380-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920738060B5
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 22:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478EE1F215B2
	for <lists+dmaengine@lfdr.de>; Tue,  5 Dec 2023 21:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53236E5B2;
	Tue,  5 Dec 2023 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqgUlcfI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809D1BF;
	Tue,  5 Dec 2023 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701811551; x=1733347551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhufnybaqleN+T6plx9jtkzsJg7omi60wVl+3lfrIE4=;
  b=fqgUlcfI42zR+8rl3dCtzA21IWksdOPH0BHpmEQ5TtgZPOURjCZ5XmDM
   y7ffTdmzWMtCVFdK/H8yON8TcvKVy45f3kIVlHzvD3hPPn3s0mBOTPtJo
   mhDBQb9pdfBqXSt0YY16LBlIJ0v9wRNtgjgdmdNSPWDYvVVqYUZaalw8Y
   4DAPSuQuNwo49pegcP/vUG5Pnvd9BdMvuIMBa7jWW0vgtKjIAmFkWYJWX
   SUzSPwkphP7Yt4cMhlO+gEWSBxHHmRMvvsjLKRJD4JG75c0GnWER5VK7P
   dNFTOqygXeCkFCoWe/0ECWViBrdogc6gL5BkfrYgF6glwbihbgtEEsrfv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396751591"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="396751591"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="19102561"
Received: from jsamonte-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.71.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:25:45 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com,
	vkoul@kernel.org
Cc: dave.jiang@intel.com,
	tony.luck@intel.com,
	wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	kanchana.p.sridhar@intel.com,
	vinodh.gopal@intel.com,
	giovanni.cabiddu@intel.com,
	pavel@ucw.cz,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v12 02/14] dmaengine: idxd: Rename drv_enable/disable_wq to idxd_drv_enable/disable_wq, and export
Date: Tue,  5 Dec 2023 15:25:18 -0600
Message-Id: <20231205212530.285671-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
References: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename drv_enable_wq and drv_disable_wq to idxd_drv_enable_wq and
idxd_drv_disable_wq respectively, so that they're no longer too
generic to be exported.  This also matches existing naming within the
idxd driver.

And to allow idxd sub-drivers to enable and disable wqs, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/idxd/cdev.c   | 6 +++---
 drivers/dma/idxd/device.c | 6 ++++--
 drivers/dma/idxd/dma.c    | 6 +++---
 drivers/dma/idxd/idxd.h   | 4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0423655f5a88..1d918d45d9f6 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -550,7 +550,7 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	wq->type = IDXD_WQT_USER;
-	rc = drv_enable_wq(wq);
+	rc = idxd_drv_enable_wq(wq);
 	if (rc < 0)
 		goto err;
 
@@ -565,7 +565,7 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 	return 0;
 
 err_cdev:
-	drv_disable_wq(wq);
+	idxd_drv_disable_wq(wq);
 err:
 	destroy_workqueue(wq->wq);
 	wq->type = IDXD_WQT_NONE;
@@ -580,7 +580,7 @@ static void idxd_user_drv_remove(struct idxd_dev *idxd_dev)
 
 	mutex_lock(&wq->wq_lock);
 	idxd_wq_del_cdev(wq);
-	drv_disable_wq(wq);
+	idxd_drv_disable_wq(wq);
 	wq->type = IDXD_WQT_NONE;
 	destroy_workqueue(wq->wq);
 	wq->wq = NULL;
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 8f754f922217..feca8534a1c5 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1350,7 +1350,7 @@ int idxd_wq_request_irq(struct idxd_wq *wq)
 	return rc;
 }
 
-int drv_enable_wq(struct idxd_wq *wq)
+int idxd_drv_enable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
@@ -1482,8 +1482,9 @@ int drv_enable_wq(struct idxd_wq *wq)
 err:
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(idxd_drv_enable_wq, IDXD);
 
-void drv_disable_wq(struct idxd_wq *wq)
+void idxd_drv_disable_wq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
@@ -1503,6 +1504,7 @@ void drv_disable_wq(struct idxd_wq *wq)
 	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
+EXPORT_SYMBOL_NS_GPL(idxd_drv_disable_wq, IDXD);
 
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 {
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 47a01893cfdb..e7043e235408 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -314,7 +314,7 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 
 	wq->type = IDXD_WQT_KERNEL;
 
-	rc = drv_enable_wq(wq);
+	rc = idxd_drv_enable_wq(wq);
 	if (rc < 0) {
 		dev_dbg(dev, "Enable wq %d failed: %d\n", wq->id, rc);
 		rc = -ENXIO;
@@ -333,7 +333,7 @@ static int idxd_dmaengine_drv_probe(struct idxd_dev *idxd_dev)
 	return 0;
 
 err_dma:
-	drv_disable_wq(wq);
+	idxd_drv_disable_wq(wq);
 err:
 	wq->type = IDXD_WQT_NONE;
 	mutex_unlock(&wq->wq_lock);
@@ -347,7 +347,7 @@ static void idxd_dmaengine_drv_remove(struct idxd_dev *idxd_dev)
 	mutex_lock(&wq->wq_lock);
 	__idxd_wq_quiesce(wq);
 	idxd_unregister_dma_channel(wq);
-	drv_disable_wq(wq);
+	idxd_drv_disable_wq(wq);
 	mutex_unlock(&wq->wq_lock);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index e541d19f14d0..ae3be5cb2ee3 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -685,8 +685,8 @@ void idxd_unmask_error_interrupts(struct idxd_device *idxd);
 /* device control */
 int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
 void idxd_device_drv_remove(struct idxd_dev *idxd_dev);
-int drv_enable_wq(struct idxd_wq *wq);
-void drv_disable_wq(struct idxd_wq *wq);
+int idxd_drv_enable_wq(struct idxd_wq *wq);
+void idxd_drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
-- 
2.34.1


