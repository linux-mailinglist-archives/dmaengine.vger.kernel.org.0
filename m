Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38CF5284D
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfFYJl4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 05:41:56 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35048 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfFYJlz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 05:41:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BEFDF1A0791;
        Tue, 25 Jun 2019 11:41:52 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6EF501A0793;
        Tue, 25 Jun 2019 11:41:45 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9DF7340318;
        Tue, 25 Jun 2019 17:41:36 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com, angelo@sysam.it
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v5 5/6] dmaengine: fsl-edma: add i.mx7ulp edma2 version support
Date:   Tue, 25 Jun 2019 17:43:23 +0800
Message-Id: <20190625094324.19196-6-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625094324.19196-1-yibin.gong@nxp.com>
References: <20190625094324.19196-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Add edma2 for i.mx7ulp by version v3, since v2 has already
been used by mcf-edma.
The big changes based on v1 are belows:
1. only one dmamux.
2. another clock dma_clk except dmamux clk.
3. 16 independent interrupts instead of only one interrupt for
all channels.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 18 +++++++++++-
 drivers/dma/fsl-edma-common.h |  4 +++
 drivers/dma/fsl-edma.c        | 66 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 44d92c3..6d6d8a4 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -90,6 +90,19 @@ static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 	iowrite8(val8, addr + off);
 }
 
+void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
+		     u32 off, u32 slot, bool enable)
+{
+	u32 val;
+
+	if (enable)
+		val = EDMAMUX_CHCFG_ENBL << 24 | slot;
+	else
+		val = EDMAMUX_CHCFG_DIS;
+
+	iowrite32(val, addr + off * 4);
+}
+
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable)
 {
@@ -103,7 +116,10 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-	mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
+	if (fsl_chan->edma->drvdata->version == v3)
+		mux_configure32(fsl_chan, muxaddr, ch_off, slot, enable);
+	else
+		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
 }
 EXPORT_SYMBOL_GPL(fsl_edma_chan_mux);
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 4e17556..5eaa290 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -125,6 +125,7 @@ struct fsl_edma_chan {
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
+	char				chan_name[16];
 };
 
 struct fsl_edma_desc {
@@ -139,11 +140,13 @@ struct fsl_edma_desc {
 enum edma_version {
 	v1, /* 32ch, Vybrid, mpc57x, etc */
 	v2, /* 64ch Coldfire */
+	v3, /* 32ch, i.mx7ulp */
 };
 
 struct fsl_edma_drvdata {
 	enum edma_version	version;
 	u32			dmamuxs;
+	bool			has_dmaclk;
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
 };
@@ -153,6 +156,7 @@ struct fsl_edma_engine {
 	void __iomem		*membase;
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
+	struct clk		*dmaclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index fcbad6a..05215ab 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -162,6 +162,50 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 	return 0;
 }
 
+static int
+fsl_edma2_irq_init(struct platform_device *pdev,
+		   struct fsl_edma_engine *fsl_edma)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int i, ret, irq;
+	int count;
+
+	count = of_irq_count(np);
+	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
+	if (count <= 2) {
+		dev_err(&pdev->dev, "Interrupts in DTS not correct.\n");
+		return -EINVAL;
+	}
+	/*
+	 * 16 channel independent interrupts + 1 error interrupt on i.mx7ulp.
+	 * 2 channel share one interrupt, for example, ch0/ch16, ch1/ch17...
+	 * For now, just simply request irq without IRQF_SHARED flag, since 16
+	 * channels are enough on i.mx7ulp whose M4 domain own some peripherals.
+	 */
+	for (i = 0; i < count; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return -ENXIO;
+
+		sprintf(fsl_edma->chans[i].chan_name, "eDMA2-CH%02d", i);
+
+		/* The last IRQ is for eDMA err */
+		if (i == count - 1)
+			ret = devm_request_irq(&pdev->dev, irq,
+						fsl_edma_err_handler,
+						0, "eDMA2-ERR", fsl_edma);
+		else
+			ret = devm_request_irq(&pdev->dev, irq,
+						fsl_edma_tx_handler, 0,
+						fsl_edma->chans[i].chan_name,
+						fsl_edma);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void fsl_edma_irq_exit(
 		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
@@ -187,8 +231,16 @@ static struct fsl_edma_drvdata vf610_data = {
 	.setup_irq = fsl_edma_irq_init,
 };
 
+static struct fsl_edma_drvdata imx7ulp_data = {
+	.version = v3,
+	.dmamuxs = 1,
+	.has_dmaclk = true,
+	.setup_irq = fsl_edma2_irq_init,
+};
+
 static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
+	{ .compatible = "fsl,imx7ulp-edma", .data = &imx7ulp_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
@@ -236,6 +288,20 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma_setup_regs(fsl_edma);
 	regs = &fsl_edma->regs;
 
+	if (drvdata->has_dmaclk) {
+		fsl_edma->dmaclk = devm_clk_get(&pdev->dev, "dma");
+		if (IS_ERR(fsl_edma->dmaclk)) {
+			dev_err(&pdev->dev, "Missing DMA block clock.\n");
+			return PTR_ERR(fsl_edma->dmaclk);
+		}
+
+		ret = clk_prepare_enable(fsl_edma->dmaclk);
+		if (ret) {
+			dev_err(&pdev->dev, "DMA clk block failed.\n");
+			return ret;
+		}
+	}
+
 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
 		char clkname[32];
 
-- 
2.7.4

