Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAA2D878
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2019 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfE2JHM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 May 2019 05:07:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47846 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfE2JHL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 May 2019 05:07:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC31B1A025A;
        Wed, 29 May 2019 11:07:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4608A1A11C4;
        Wed, 29 May 2019 11:07:03 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 07158402F1;
        Wed, 29 May 2019 17:06:55 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 1/8] dmaengine: fsl-edma: add dmamux_nr for next version
Date:   Wed, 29 May 2019 17:08:41 +0800
Message-Id: <20190529090848.34350-2-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529090848.34350-1-yibin.gong@nxp.com>
References: <20190529090848.34350-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Next version of edma such as edmav2 on i.mx7ulp has only one dmamux.
Add dmamux_nr instead of static macro define 'DMAMUX_NR'. No any
function change here.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.h |  1 +
 drivers/dma/fsl-edma.c        | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index c53f76e..21a9cfd 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -145,6 +145,7 @@ struct fsl_edma_engine {
 	void __iomem		*membase;
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
+	u32			dmamux_nr;
 	struct mutex		fsl_edma_mutex;
 	u32			n_chans;
 	int			txirq;
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index d641ef8..7b65ef4 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -96,7 +96,7 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
 	struct dma_chan *chan, *_chan;
 	struct fsl_edma_chan *fsl_chan;
-	unsigned long chans_per_mux = fsl_edma->n_chans / DMAMUX_NR;
+	unsigned long chans_per_mux = fsl_edma->n_chans / fsl_edma->dmamux_nr;
 
 	if (dma_spec->args_count != 2)
 		return NULL;
@@ -206,6 +206,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fsl_edma->version = v1;
+	fsl_edma->dmamux_nr = DMAMUX_NR;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
 
@@ -217,7 +218,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma_setup_regs(fsl_edma);
 	regs = &fsl_edma->regs;
 
-	for (i = 0; i < DMAMUX_NR; i++) {
+	for (i = 0; i < fsl_edma->dmamux_nr; i++) {
 		char clkname[32];
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1 + i);
@@ -295,7 +296,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+		fsl_disable_clocks(fsl_edma, fsl_edma->dmamux_nr);
 		return ret;
 	}
 
@@ -304,7 +305,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+		fsl_disable_clocks(fsl_edma, fsl_edma->dmamux_nr);
 		return ret;
 	}
 
@@ -323,7 +324,7 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-	fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+	fsl_disable_clocks(fsl_edma, fsl_edma->dmamux_nr);
 
 	return 0;
 }
-- 
2.7.4

