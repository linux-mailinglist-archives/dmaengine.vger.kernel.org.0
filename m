Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF7367CAA
	for <lists+dmaengine@lfdr.de>; Thu, 22 Apr 2021 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhDVIjM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 04:39:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34520 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235421AbhDVIjM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Apr 2021 04:39:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB6531A1A46;
        Thu, 22 Apr 2021 10:38:36 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DA401A1A4F;
        Thu, 22 Apr 2021 10:38:34 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D288A40340;
        Thu, 22 Apr 2021 10:38:27 +0200 (CEST)
From:   Guanhua Gao <guanhua.gao@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>, Yi Zhao <yi.zhao@nxp.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guanhua Gao <guanhua.gao@nxp.com>
Subject: [PATCH v2 3/3] dmaengine: fsl-dpaa2-qdma: Remove the macro of DPDMAI_MAX_QUEUE_NUM
Date:   Thu, 22 Apr 2021 16:44:48 +0800
Message-Id: <20210422084448.962-1-guanhua.gao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The max number of queue supported by DPAA2 qdma is determined
by the number of CPUs. Due to the number of CPUs are different
in different LS2 platforms, we remove the macro of
DPDMAI_MAX_QUEUE_NUM which is defined 8.

Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
---
Change in v2:
 - Add new patch.

 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 43 +++++++++++++++++++++----
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h |  4 +--
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h     |  5 ---
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 86c7ec5dc74e..3875fbb9fac3 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -314,6 +314,8 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 	struct dpaa2_qdma_priv_per_prio *ppriv;
 	struct device *dev = &ls_dev->dev;
 	struct dpaa2_qdma_priv *priv;
+	struct dpdmai_rx_queue_attr *rx_queue_attr;
+	struct dpdmai_tx_queue_attr *tx_queue_attr;
 	int err = -EINVAL;
 	int i;
 
@@ -335,33 +337,51 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 				    &priv->dpdmai_attr);
 	if (err) {
 		dev_err(dev, "dpdmai_get_attributes() failed\n");
-		goto exit;
+		goto err_get_attr;
 	}
 
 	priv->num_pairs = priv->dpdmai_attr.num_of_queues;
+	rx_queue_attr = kcalloc(priv->num_pairs, sizeof(*rx_queue_attr),
+				GFP_KERNEL);
+	if (!rx_queue_attr) {
+		err = -ENOMEM;
+		goto err_get_attr;
+	}
+	priv->rx_queue_attr = rx_queue_attr;
+
+	tx_queue_attr = kcalloc(priv->num_pairs, sizeof(*tx_queue_attr),
+				GFP_KERNEL);
+	if (!tx_queue_attr) {
+		err = -ENOMEM;
+		goto err_tx_queue;
+	}
+	priv->tx_queue_attr = tx_queue_attr;
+
 	ppriv = kcalloc(priv->num_pairs, sizeof(*ppriv), GFP_KERNEL);
 	if (!ppriv) {
 		err = -ENOMEM;
-		goto exit;
+		goto err_ppriv;
 	}
 	priv->ppriv = ppriv;
 
 	for (i = 0; i < priv->num_pairs; i++) {
 		err = dpdmai_get_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
-					  i, 0, &priv->rx_queue_attr[i]);
+					  i, 0, priv->rx_queue_attr + i);
 		if (err) {
 			dev_err(dev, "dpdmai_get_rx_queue() failed\n");
 			goto exit;
 		}
-		ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
+		ppriv->rsp_fqid = ((struct dpdmai_rx_queue_attr *)
+				   (priv->rx_queue_attr + i))->fqid;
 
 		err = dpdmai_get_tx_queue(priv->mc_io, 0, ls_dev->mc_handle,
-					  i, 0, &priv->tx_queue_attr[i]);
+					  i, 0, priv->tx_queue_attr + i);
 		if (err) {
 			dev_err(dev, "dpdmai_get_tx_queue() failed\n");
 			goto exit;
 		}
-		ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
+		ppriv->req_fqid = ((struct dpdmai_tx_queue_attr *)
+				   (priv->tx_queue_attr + i))->fqid;
 		ppriv->prio = DPAA2_QDMA_DEFAULT_PRIORITY;
 		ppriv->priv = priv;
 		ppriv->chan_id = i;
@@ -370,6 +390,12 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
 
 	return 0;
 exit:
+	kfree(ppriv);
+err_ppriv:
+	kfree(priv->tx_queue_attr);
+err_tx_queue:
+	kfree(priv->rx_queue_attr);
+err_get_attr:
 	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
 	return err;
 }
@@ -733,6 +759,8 @@ static int dpaa2_qdma_probe(struct fsl_mc_device *dpdmai_dev)
 	dpaa2_dpmai_store_free(priv);
 	dpaa2_dpdmai_dpio_free(priv);
 err_dpio_setup:
+	kfree(priv->rx_queue_attr);
+	kfree(priv->tx_queue_attr);
 	kfree(priv->ppriv);
 	dpdmai_close(priv->mc_io, 0, dpdmai_dev->mc_handle);
 err_dpdmai_setup:
@@ -763,6 +791,9 @@ static int dpaa2_qdma_remove(struct fsl_mc_device *ls_dev)
 	dpaa2_dpdmai_free_channels(dpaa2_qdma);
 
 	dma_async_device_unregister(&dpaa2_qdma->dma_dev);
+	kfree(priv->rx_queue_attr);
+	kfree(priv->tx_queue_attr);
+	kfree(priv->ppriv);
 	kfree(priv);
 	kfree(dpaa2_qdma);
 
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
index 0a405fb13452..38aed372214e 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
@@ -123,8 +123,8 @@ struct dpaa2_qdma_priv {
 	struct dpaa2_qdma_engine	*dpaa2_qdma;
 	struct dpaa2_qdma_priv_per_prio	*ppriv;
 
-	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
-	struct dpdmai_tx_queue_attr tx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
+	struct dpdmai_rx_queue_attr *rx_queue_attr;
+	struct dpdmai_tx_queue_attr *tx_queue_attr;
 };
 
 struct dpaa2_qdma_priv_per_prio {
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
index 0a87d37f7a92..f3a3eac97400 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
@@ -51,11 +51,6 @@
  * Contains initialization APIs and runtime control APIs for DPDMAI
  */
 
-/*
- * Maximum number of Tx/Rx queues per DPDMAI object
- */
-#define DPDMAI_MAX_QUEUE_NUM	8
-
 /**
  * Maximum number of Tx/Rx priorities per DPDMAI object
  */
-- 
2.25.1

