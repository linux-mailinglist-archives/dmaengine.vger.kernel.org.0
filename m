Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4784C4572E
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfFNIPs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 04:15:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58752 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfFNIPr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 04:15:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 348EC2005DC;
        Fri, 14 Jun 2019 10:15:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5B6F2005D2;
        Fri, 14 Jun 2019 10:15:38 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 99E0040310;
        Fri, 14 Jun 2019 16:15:31 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com, angelo@sysam.it
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v4 1/6] dmaengine: fsl-edma: add drvdata for fsl-edma
Date:   Fri, 14 Jun 2019 16:17:19 +0800
Message-Id: <20190614081724.13366-2-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614081724.13366-1-yibin.gong@nxp.com>
References: <20190614081724.13366-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

There are some differences between vf610 and next i.mx7ulp. Put such
differences into static driver data for distiguish easily at driver
level. Change mcf-edma accordingly.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 29 +++++++++++++++--------------
 drivers/dma/fsl-edma-common.h | 10 +++++++++-
 drivers/dma/fsl-edma.c        | 43 ++++++++++++++++++++++++++++++-------------
 drivers/dma/mcf-edma.c        | 11 ++++++++---
 4 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 680b2a0..07d9689 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -47,7 +47,7 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
-	if (fsl_chan->edma->version == v1) {
+	if (fsl_chan->edma->drvdata->version == v1) {
 		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
 		edma_writeb(fsl_chan->edma, ch, regs->serq);
 	} else {
@@ -64,7 +64,7 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
-	if (fsl_chan->edma->version == v1) {
+	if (fsl_chan->edma->drvdata->version == v1) {
 		edma_writeb(fsl_chan->edma, ch, regs->cerq);
 		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
 	} else {
@@ -83,8 +83,9 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 	void __iomem *muxaddr;
 	unsigned int chans_per_mux, ch_off;
+	u32 dmamux_nr = fsl_chan->edma->drvdata->dmamuxs;
 
-	chans_per_mux = fsl_chan->edma->n_chans / DMAMUX_NR;
+	chans_per_mux = fsl_chan->edma->n_chans / dmamux_nr;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
@@ -647,28 +648,28 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 	edma->regs.erql = edma->membase + EDMA_ERQ;
 	edma->regs.eeil = edma->membase + EDMA_EEI;
 
-	edma->regs.serq = edma->membase + ((edma->version == v1) ?
+	edma->regs.serq = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_SERQ : EDMA64_SERQ);
-	edma->regs.cerq = edma->membase + ((edma->version == v1) ?
+	edma->regs.cerq = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_CERQ : EDMA64_CERQ);
-	edma->regs.seei = edma->membase + ((edma->version == v1) ?
+	edma->regs.seei = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_SEEI : EDMA64_SEEI);
-	edma->regs.ceei = edma->membase + ((edma->version == v1) ?
+	edma->regs.ceei = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_CEEI : EDMA64_CEEI);
-	edma->regs.cint = edma->membase + ((edma->version == v1) ?
+	edma->regs.cint = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_CINT : EDMA64_CINT);
-	edma->regs.cerr = edma->membase + ((edma->version == v1) ?
+	edma->regs.cerr = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_CERR : EDMA64_CERR);
-	edma->regs.ssrt = edma->membase + ((edma->version == v1) ?
+	edma->regs.ssrt = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_SSRT : EDMA64_SSRT);
-	edma->regs.cdne = edma->membase + ((edma->version == v1) ?
+	edma->regs.cdne = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_CDNE : EDMA64_CDNE);
-	edma->regs.intl = edma->membase + ((edma->version == v1) ?
+	edma->regs.intl = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_INTR : EDMA64_INTL);
-	edma->regs.errl = edma->membase + ((edma->version == v1) ?
+	edma->regs.errl = edma->membase + ((edma->drvdata->version == v1) ?
 			EDMA_ERR : EDMA64_ERRL);
 
-	if (edma->version == v2) {
+	if (edma->drvdata->version == v2) {
 		edma->regs.erqh = edma->membase + EDMA64_ERQH;
 		edma->regs.eeih = edma->membase + EDMA64_EEIH;
 		edma->regs.errh = edma->membase + EDMA64_ERRH;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index c53f76e..4e17556 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -7,6 +7,7 @@
 #define _FSL_EDMA_COMMON_H_
 
 #include <linux/dma-direction.h>
+#include <linux/platform_device.h>
 #include "virt-dma.h"
 
 #define EDMA_CR_EDBG		BIT(1)
@@ -140,17 +141,24 @@ enum edma_version {
 	v2, /* 64ch Coldfire */
 };
 
+struct fsl_edma_drvdata {
+	enum edma_version	version;
+	u32			dmamuxs;
+	int			(*setup_irq)(struct platform_device *pdev,
+					     struct fsl_edma_engine *fsl_edma);
+};
+
 struct fsl_edma_engine {
 	struct dma_device	dma_dev;
 	void __iomem		*membase;
 	void __iomem		*muxbase[DMAMUX_NR];
 	struct clk		*muxclk[DMAMUX_NR];
 	struct mutex		fsl_edma_mutex;
+	const struct fsl_edma_drvdata *drvdata;
 	u32			n_chans;
 	int			txirq;
 	int			errirq;
 	bool			big_endian;
-	enum edma_version	version;
 	struct edma_regs	regs;
 	struct fsl_edma_chan	chans[];
 };
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 0ddad3a..fcbad6a 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -92,7 +92,8 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 	struct fsl_edma_engine *fsl_edma = ofdma->of_dma_data;
 	struct dma_chan *chan, *_chan;
 	struct fsl_edma_chan *fsl_chan;
-	unsigned long chans_per_mux = fsl_edma->n_chans / DMAMUX_NR;
+	u32 dmamux_nr = fsl_edma->drvdata->dmamuxs;
+	unsigned long chans_per_mux = fsl_edma->n_chans / dmamux_nr;
 
 	if (dma_spec->args_count != 2)
 		return NULL;
@@ -180,16 +181,38 @@ static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 		clk_disable_unprepare(fsl_edma->muxclk[i]);
 }
 
+static struct fsl_edma_drvdata vf610_data = {
+	.version = v1,
+	.dmamuxs = DMAMUX_NR,
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
@@ -201,7 +224,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!fsl_edma)
 		return -ENOMEM;
 
-	fsl_edma->version = v1;
+	fsl_edma->drvdata = drvdata;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
 
@@ -213,7 +236,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma_setup_regs(fsl_edma);
 	regs = &fsl_edma->regs;
 
-	for (i = 0; i < DMAMUX_NR; i++) {
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
 		char clkname[32];
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1 + i);
@@ -259,7 +282,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	}
 
 	edma_writel(fsl_edma, ~0, regs->intl);
-	ret = fsl_edma_irq_init(pdev, fsl_edma);
+	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
 
@@ -291,7 +314,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -300,7 +323,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -319,7 +342,7 @@ static int fsl_edma_remove(struct platform_device *pdev)
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-	fsl_disable_clocks(fsl_edma, DMAMUX_NR);
+	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 
 	return 0;
 }
@@ -378,12 +401,6 @@ static const struct dev_pm_ops fsl_edma_pm_ops = {
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
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
index 7de54b2f..e15bd15 100644
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -164,6 +164,11 @@ static void mcf_edma_irq_free(struct platform_device *pdev,
 		free_irq(irq, mcf_edma);
 }
 
+static struct fsl_edma_drvdata mcf_data = {
+	.version = v2,
+	.setup_irq = mcf_edma_irq_init,
+};
+
 static int mcf_edma_probe(struct platform_device *pdev)
 {
 	struct mcf_edma_platform_data *pdata;
@@ -187,8 +192,8 @@ static int mcf_edma_probe(struct platform_device *pdev)
 
 	mcf_edma->n_chans = chans;
 
-	/* Set up version for ColdFire edma */
-	mcf_edma->version = v2;
+	/* Set up drvdata for ColdFire edma */
+	mcf_edma->drvdata = &mcf_data;
 	mcf_edma->big_endian = 1;
 
 	if (!mcf_edma->n_chans) {
@@ -223,7 +228,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 	iowrite32(~0, regs->inth);
 	iowrite32(~0, regs->intl);
 
-	ret = mcf_edma_irq_init(pdev, mcf_edma);
+	ret = mcf_edma->drvdata->setup_irq(pdev, mcf_edma);
 	if (ret)
 		return ret;
 
-- 
2.7.4

