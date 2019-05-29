Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB152D88F
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2019 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfE2JHT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 May 2019 05:07:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48182 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfE2JHT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 May 2019 05:07:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1CF741A005A;
        Wed, 29 May 2019 11:07:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 320F91A03CD;
        Wed, 29 May 2019 11:07:10 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 26FF440309;
        Wed, 29 May 2019 17:07:01 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 5/8] dmaengine: fsl-edma: add drvdata for vf610
Date:   Wed, 29 May 2019 17:08:45 +0800
Message-Id: <20190529090848.34350-6-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529090848.34350-1-yibin.gong@nxp.com>
References: <20190529090848.34350-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

There are some differences between vf610 and next i.mx7ulp. Put such
differences into static driver data for distiguish easily in driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 10 ++++++++++
 drivers/dma/fsl-edma.c        | 36 +++++++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 21a9cfd..014ab74 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -7,6 +7,7 @@
 #define _FSL_EDMA_COMMON_H_
 
 #include <linux/dma-direction.h>
+#include <linux/platform_device.h>
 #include "virt-dma.h"
 
 #define EDMA_CR_EDBG		BIT(1)
@@ -140,6 +141,14 @@ enum edma_version {
 	v2, /* 64ch Coldfire */
 };
 
+struct fsl_edma_drvdata {
+	enum edma_version	version;
+	u32	dmamuxs;
+	bool	has_dmaclk;
+	int	(*setup_irq)(struct platform_device *pdev,
+			     struct fsl_edma_engine *fsl_edma);
+};
+
 struct fsl_edma_engine {
 	struct dma_device	dma_dev;
 	void __iomem		*membase;
@@ -147,6 +156,7 @@ struct fsl_edma_engine {
 	struct clk		*muxclk[DMAMUX_NR];
 	u32			dmamux_nr;
 	struct mutex		fsl_edma_mutex;
+	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
 	int			txirq;
 	int			errirq;
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 7b65ef4..cf18301 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -184,16 +184,39 @@ static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 		clk_disable_unprepare(fsl_edma->muxclk[i]);
 }
 
+static struct fsl_edma_drvdata vf610_data = {
+	.version = v1,
+	.dmamuxs = DMAMUX_NR,
+	.has_dmaclk = false,
+	.setup_irq = fsl_edma_irq_init,
+};
+
+static const struct of_device_id fsl_edma_dt_ids[] = {
+	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id =
+			of_match_device(fsl_edma_dt_ids, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma;
+	const struct fsl_edma_drvdata *drvdata = NULL;
 	struct fsl_edma_chan *fsl_chan;
 	struct edma_regs *regs;
 	struct resource *res;
 	int len, chans;
 	int ret, i;
 
+	if (of_id)
+		drvdata = of_id->data;
+	if (!drvdata) {
+		dev_err(&pdev->dev, "unable to find driver data\n");
+		return -EINVAL;
+	}
+
 	ret = of_property_read_u32(np, "dma-channels", &chans);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't get dma-channels.\n");
@@ -205,8 +228,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!fsl_edma)
 		return -ENOMEM;
 
-	fsl_edma->version = v1;
-	fsl_edma->dmamux_nr = DMAMUX_NR;
+	fsl_edma->drvdata = drvdata;
+	fsl_edma->version = drvdata->version;
+	fsl_edma->dmamux_nr = drvdata->dmamuxs;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
 
@@ -264,7 +288,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	}
 
 	edma_writel(fsl_edma, ~0, regs->intl);
-	ret = fsl_edma_irq_init(pdev, fsl_edma);
+	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
 
@@ -383,12 +407,6 @@ static const struct dev_pm_ops fsl_edma_pm_ops = {
 	.resume_early   = fsl_edma_resume_early,
 };
 
-static const struct of_device_id fsl_edma_dt_ids[] = {
-	{ .compatible = "fsl,vf610-edma", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
-
 static struct platform_driver fsl_edma_driver = {
 	.driver		= {
 		.name	= "fsl-edma",
-- 
2.7.4

