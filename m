Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792D86245AE
	for <lists+dmaengine@lfdr.de>; Thu, 10 Nov 2022 16:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiKJP0j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 10:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKJP00 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 10:26:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7520C3E0AA;
        Thu, 10 Nov 2022 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668093965; x=1699629965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uVEELB1YyqMKjeqG9V1FnQgrVQfJATKXTJhI7/gvIHc=;
  b=lQCBAyK5tAb/0/i/IC3Aqgn2JcgL0UQNv1iTikKTKkos1svGfop8npX4
   AW6/PrMogRMLxMxGqgi12QLFGMrJC98ETH2Tu+OqV5YJpHkQ+Nu8UpDq5
   LGgspsz65fQqOdwvnQucqWHGMDwoGi6x7fKyQZmu1N9YeNjOYw15atgaM
   xnsuRTku4YYlEqQVut/51FADyeqfJLKe1L8LtQn65zTQR7xzyJOfkHjLq
   daCLcumVYS5c8wDUzZ1ktxoFXoOYgqNx6kDI72hWI+9u2/BRN31NSZL6V
   cEdPjqf+r378K9VuTxqJcmkfzRUPS9kSaqrCohHY8x3PbQdUe5O3GJ6L4
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="182897552"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Nov 2022 08:25:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 10 Nov 2022 08:25:40 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 10 Nov 2022 08:25:30 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <lars@metafoo.de>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <green.wan@sifive.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <ldewangan@nvidia.com>, <jonathanh@nvidia.com>,
        <thierry.reding@gmail.com>, <peter.ujfalusi@gmail.com>,
        <michal.simek@xilinx.com>, <tony@atomide.com>,
        <krzysztof.kozlowski@linaro.org>, <trix@redhat.com>,
        <radhey.shyam.pandey@xilinx.com>, <shravya.kumbham@xilinx.com>,
        <harini.katakam@xilinx.com>, <swati.agarwal@amd.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
        <ye.xingchen@zte.com.cn>, <quic_mojha@quicinc.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3] dmaengine: drivers: Use devm_platform_ioremap_resource()
Date:   Thu, 10 Nov 2022 17:25:28 +0200
Message-ID: <20221110152528.7821-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

platform_get_resource() and devm_ioremap_resource() are wrapped up in the
devm_platform_ioremap_resource() helper. Use the helper and get rid of the
local variable for struct resource *. We now have a function call less.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
v3:
- fix errors reported-by lkp@intel.com
- lkp@intel.com built successfully few configs, all should be good now.

v2:
- rebase on dma/next. s3c24xx was removed, thus drop the changes for it.
- collect Acked-by

 drivers/dma/bcm2835-dma.c                      |  4 +---
 drivers/dma/dma-axi-dmac.c                     |  4 +---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  4 +---
 drivers/dma/fsl-edma.c                         |  8 +++-----
 drivers/dma/fsl-qdma.c                         | 10 +++-------
 drivers/dma/idma64.c                           |  4 +---
 drivers/dma/img-mdc-dma.c                      |  4 +---
 drivers/dma/imx-dma.c                          |  4 +---
 drivers/dma/imx-sdma.c                         |  4 +---
 drivers/dma/mcf-edma.c                         |  5 +----
 drivers/dma/mediatek/mtk-hsdma.c               |  4 +---
 drivers/dma/mmp_pdma.c                         |  4 +---
 drivers/dma/mmp_tdma.c                         |  4 +---
 drivers/dma/moxart-dma.c                       |  4 +---
 drivers/dma/mv_xor_v2.c                        |  7 ++-----
 drivers/dma/mxs-dma.c                          |  4 +---
 drivers/dma/nbpfaxi.c                          |  4 +---
 drivers/dma/pxa_dma.c                          |  4 +---
 drivers/dma/qcom/bam_dma.c                     |  4 +---
 drivers/dma/sf-pdma/sf-pdma.c                  |  4 +---
 drivers/dma/sh/usb-dmac.c                      |  4 +---
 drivers/dma/stm32-dmamux.c                     |  4 +---
 drivers/dma/stm32-mdma.c                       |  4 +---
 drivers/dma/sun4i-dma.c                        |  4 +---
 drivers/dma/sun6i-dma.c                        |  4 +---
 drivers/dma/tegra210-adma.c                    |  4 +---
 drivers/dma/ti/cppi41.c                        | 10 +++-------
 drivers/dma/ti/omap-dma.c                      |  4 +---
 drivers/dma/xilinx/zynqmp_dma.c                |  4 +---
 29 files changed, 36 insertions(+), 100 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 630dfbb01a40..0807fb9eb262 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -878,7 +878,6 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
 static int bcm2835_dma_probe(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od;
-	struct resource *res;
 	void __iomem *base;
 	int rc;
 	int i, j;
@@ -902,8 +901,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 
 	dma_set_max_seg_size(&pdev->dev, 0x3FFFFFFF);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f30dabc99795..a812b9b00e6b 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -910,7 +910,6 @@ static int axi_dmac_probe(struct platform_device *pdev)
 {
 	struct dma_device *dma_dev;
 	struct axi_dmac *dmac;
-	struct resource *res;
 	struct regmap *regmap;
 	unsigned int version;
 	int ret;
@@ -925,8 +924,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (dmac->irq == 0)
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmac->base = devm_ioremap_resource(&pdev->dev, res);
+	dmac->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
 
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a183d93bd7e2..3dec8adfc4ea 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1365,7 +1365,6 @@ static int dw_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct axi_dma_chip *chip;
-	struct resource *mem;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
 	u32 i;
@@ -1391,8 +1390,7 @@ static int dw_probe(struct platform_device *pdev)
 	if (chip->irq < 0)
 		return chip->irq;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->regs = devm_ioremap_resource(chip->dev, mem);
+	chip->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 76cbf54aec58..e40769666e39 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -272,7 +272,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	const struct fsl_edma_drvdata *drvdata = NULL;
 	struct fsl_edma_chan *fsl_chan;
 	struct edma_regs *regs;
-	struct resource *res;
 	int len, chans;
 	int ret, i;
 
@@ -298,8 +297,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fsl_edma->membase = devm_ioremap_resource(&pdev->dev, res);
+	fsl_edma->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fsl_edma->membase))
 		return PTR_ERR(fsl_edma->membase);
 
@@ -323,8 +321,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
 		char clkname[32];
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1 + i);
-		fsl_edma->muxbase[i] = devm_ioremap_resource(&pdev->dev, res);
+		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
+								      1 + i);
 		if (IS_ERR(fsl_edma->muxbase[i])) {
 			/* on error: disable all previously enabled clks */
 			fsl_disable_clocks(fsl_edma, i);
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 045ead46ec8f..eddb2688f234 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1119,7 +1119,6 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	int ret, i;
 	int blk_num, blk_off;
 	u32 len, chans, queues;
-	struct resource *res;
 	struct fsl_qdma_chan *fsl_chan;
 	struct fsl_qdma_engine *fsl_qdma;
 	struct device_node *np = pdev->dev.of_node;
@@ -1183,18 +1182,15 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 		if (!fsl_qdma->status[i])
 			return -ENOMEM;
 	}
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fsl_qdma->ctrl_base = devm_ioremap_resource(&pdev->dev, res);
+	fsl_qdma->ctrl_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fsl_qdma->ctrl_base))
 		return PTR_ERR(fsl_qdma->ctrl_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	fsl_qdma->status_base = devm_ioremap_resource(&pdev->dev, res);
+	fsl_qdma->status_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(fsl_qdma->status_base))
 		return PTR_ERR(fsl_qdma->status_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	fsl_qdma->block_base = devm_ioremap_resource(&pdev->dev, res);
+	fsl_qdma->block_base = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(fsl_qdma->block_base))
 		return PTR_ERR(fsl_qdma->block_base);
 	fsl_qdma->queue = fsl_qdma_alloc_queue_resources(pdev, fsl_qdma);
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index c33087c5cd02..cd9622f6e59c 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -627,7 +627,6 @@ static int idma64_platform_probe(struct platform_device *pdev)
 	struct idma64_chip *chip;
 	struct device *dev = &pdev->dev;
 	struct device *sysdev = dev->parent;
-	struct resource *mem;
 	int ret;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
@@ -638,8 +637,7 @@ static int idma64_platform_probe(struct platform_device *pdev)
 	if (chip->irq < 0)
 		return chip->irq;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->regs = devm_ioremap_resource(dev, mem);
+	chip->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index e4ea107ce78c..ad084552640f 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -886,7 +886,6 @@ static int img_mdc_runtime_resume(struct device *dev)
 static int mdc_dma_probe(struct platform_device *pdev)
 {
 	struct mdc_dma *mdma;
-	struct resource *res;
 	unsigned int i;
 	u32 val;
 	int ret;
@@ -898,8 +897,7 @@ static int mdc_dma_probe(struct platform_device *pdev)
 
 	mdma->soc = of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mdma->regs = devm_ioremap_resource(&pdev->dev, res);
+	mdma->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdma->regs))
 		return PTR_ERR(mdma->regs);
 
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 65c6094ce063..80086977973f 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1038,7 +1038,6 @@ static struct dma_chan *imxdma_xlate(struct of_phandle_args *dma_spec,
 static int __init imxdma_probe(struct platform_device *pdev)
 {
 	struct imxdma_engine *imxdma;
-	struct resource *res;
 	int ret, i;
 	int irq, irq_err;
 
@@ -1049,8 +1048,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	imxdma->dev = &pdev->dev;
 	imxdma->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	imxdma->base = devm_ioremap_resource(&pdev->dev, res);
+	imxdma->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imxdma->base))
 		return PTR_ERR(imxdma->base);
 
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fbea5f62dd98..3565066a54f5 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2167,7 +2167,6 @@ static int sdma_probe(struct platform_device *pdev)
 	const char *fw_name;
 	int ret;
 	int irq;
-	struct resource *iores;
 	struct resource spba_res;
 	int i;
 	struct sdma_engine *sdma;
@@ -2190,8 +2189,7 @@ static int sdma_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sdma->regs = devm_ioremap_resource(&pdev->dev, iores);
+	sdma->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sdma->regs))
 		return PTR_ERR(sdma->regs);
 
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
index e12b754e6398..ebd8733f72ad 100644
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -182,7 +182,6 @@ static int mcf_edma_probe(struct platform_device *pdev)
 	struct fsl_edma_engine *mcf_edma;
 	struct fsl_edma_chan *mcf_chan;
 	struct edma_regs *regs;
-	struct resource *res;
 	int ret, i, len, chans;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -210,9 +209,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 
 	mutex_init(&mcf_edma->fsl_edma_mutex);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	mcf_edma->membase = devm_ioremap_resource(&pdev->dev, res);
+	mcf_edma->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mcf_edma->membase))
 		return PTR_ERR(mcf_edma->membase);
 
diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index f7717c44b887..69cc61c0b262 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -896,7 +896,6 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	struct mtk_hsdma_device *hsdma;
 	struct mtk_hsdma_vchan *vc;
 	struct dma_device *dd;
-	struct resource *res;
 	int i, err;
 
 	hsdma = devm_kzalloc(&pdev->dev, sizeof(*hsdma), GFP_KERNEL);
@@ -905,8 +904,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 
 	dd = &hsdma->ddev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hsdma->base = devm_ioremap_resource(&pdev->dev, res);
+	hsdma->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hsdma->base))
 		return PTR_ERR(hsdma->base);
 
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index e8d71b35593e..ebdfdcbb4f7a 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1022,7 +1022,6 @@ static int mmp_pdma_probe(struct platform_device *op)
 	struct mmp_pdma_device *pdev;
 	const struct of_device_id *of_id;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
-	struct resource *iores;
 	int i, ret, irq = 0;
 	int dma_channels = 0, irq_num = 0;
 	const enum dma_slave_buswidth widths =
@@ -1037,8 +1036,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 
 	spin_lock_init(&pdev->phy_lock);
 
-	iores = platform_get_resource(op, IORESOURCE_MEM, 0);
-	pdev->base = devm_ioremap_resource(pdev->dev, iores);
+	pdev->base = devm_platform_ioremap_resource(op, 0);
 	if (IS_ERR(pdev->base))
 		return PTR_ERR(pdev->base);
 
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index a262e0eb4cc9..e956702932aa 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -639,7 +639,6 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 	enum mmp_tdma_type type;
 	const struct of_device_id *of_id;
 	struct mmp_tdma_device *tdev;
-	struct resource *iores;
 	int i, ret;
 	int irq = 0, irq_num = 0;
 	int chan_num = TDMA_CHANNEL_NUM;
@@ -663,8 +662,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 			irq_num++;
 	}
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tdev->base = devm_ioremap_resource(&pdev->dev, iores);
+	tdev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tdev->base))
 		return PTR_ERR(tdev->base);
 
diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 7459382a8353..7565ad98ba66 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -563,7 +563,6 @@ static int moxart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct resource *res;
 	void __iomem *dma_base_addr;
 	int ret, i;
 	unsigned int irq;
@@ -580,8 +579,7 @@ static int moxart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dma_base_addr = devm_ioremap_resource(dev, res);
+	dma_base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dma_base_addr))
 		return PTR_ERR(dma_base_addr);
 
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 113834e1167b..89790beba305 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -714,7 +714,6 @@ static int mv_xor_v2_resume(struct platform_device *dev)
 static int mv_xor_v2_probe(struct platform_device *pdev)
 {
 	struct mv_xor_v2_device *xor_dev;
-	struct resource *res;
 	int i, ret = 0;
 	struct dma_device *dma_dev;
 	struct mv_xor_v2_sw_desc *sw_desc;
@@ -726,13 +725,11 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 	if (!xor_dev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xor_dev->dma_base = devm_ioremap_resource(&pdev->dev, res);
+	xor_dev->dma_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xor_dev->dma_base))
 		return PTR_ERR(xor_dev->dma_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	xor_dev->glob_base = devm_ioremap_resource(&pdev->dev, res);
+	xor_dev->glob_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(xor_dev->glob_base))
 		return PTR_ERR(xor_dev->glob_base);
 
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index dc147cc2436e..acc4d53e4630 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -746,7 +746,6 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct mxs_dma_type *dma_type;
 	struct mxs_dma_engine *mxs_dma;
-	struct resource *iores;
 	int ret, i;
 
 	mxs_dma = devm_kzalloc(&pdev->dev, sizeof(*mxs_dma), GFP_KERNEL);
@@ -763,8 +762,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->type = dma_type->type;
 	mxs_dma->dev_id = dma_type->id;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mxs_dma->base = devm_ioremap_resource(&pdev->dev, iores);
+	mxs_dma->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mxs_dma->base))
 		return PTR_ERR(mxs_dma->base);
 
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index a7063e9cd551..e72e8c10355e 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1294,7 +1294,6 @@ static int nbpf_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct nbpf_device *nbpf;
 	struct dma_device *dma_dev;
-	struct resource *iomem;
 	const struct nbpf_config *cfg;
 	int num_channels;
 	int ret, irq, eirq, i;
@@ -1318,8 +1317,7 @@ static int nbpf_probe(struct platform_device *pdev)
 	dma_dev = &nbpf->dma_dev;
 	dma_dev->dev = dev;
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nbpf->base = devm_ioremap_resource(dev, iomem);
+	nbpf->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(nbpf->base))
 		return PTR_ERR(nbpf->base);
 
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 22a392fe6d32..1b046d9a3a26 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1346,7 +1346,6 @@ static int pxad_probe(struct platform_device *op)
 	const struct of_device_id *of_id;
 	const struct dma_slave_map *slave_map = NULL;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
-	struct resource *iores;
 	int ret, dma_channels = 0, nb_requestors = 0, slave_map_cnt = 0;
 	const enum dma_slave_buswidth widths =
 		DMA_SLAVE_BUSWIDTH_1_BYTE   | DMA_SLAVE_BUSWIDTH_2_BYTES |
@@ -1358,8 +1357,7 @@ static int pxad_probe(struct platform_device *op)
 
 	spin_lock_init(&pdev->phy_lock);
 
-	iores = platform_get_resource(op, IORESOURCE_MEM, 0);
-	pdev->base = devm_ioremap_resource(&op->dev, iores);
+	pdev->base = devm_platform_ioremap_resource(op, 0);
 	if (IS_ERR(pdev->base))
 		return PTR_ERR(pdev->base);
 
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 2ff787df513e..1e47d27e1f81 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1237,7 +1237,6 @@ static int bam_dma_probe(struct platform_device *pdev)
 {
 	struct bam_device *bdev;
 	const struct of_device_id *match;
-	struct resource *iores;
 	int ret, i;
 
 	bdev = devm_kzalloc(&pdev->dev, sizeof(*bdev), GFP_KERNEL);
@@ -1254,8 +1253,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 	bdev->layout = match->data;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bdev->regs = devm_ioremap_resource(&pdev->dev, iores);
+	bdev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bdev->regs))
 		return PTR_ERR(bdev->regs);
 
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6b524eb6bcf3..d7d2dacac830 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -494,7 +494,6 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 static int sf_pdma_probe(struct platform_device *pdev)
 {
 	struct sf_pdma *pdma;
-	struct resource *res;
 	int ret, n_chans;
 	const enum dma_slave_buswidth widths =
 		DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
@@ -519,8 +518,7 @@ static int sf_pdma_probe(struct platform_device *pdev)
 
 	pdma->n_chans = n_chans;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pdma->membase = devm_ioremap_resource(&pdev->dev, res);
+	pdma->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdma->membase))
 		return PTR_ERR(pdma->membase);
 
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 5edaeb89d1e6..b14cf350b669 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -768,7 +768,6 @@ static int usb_dmac_probe(struct platform_device *pdev)
 	const enum dma_slave_buswidth widths = USB_DMAC_SLAVE_BUSWIDTH;
 	struct dma_device *engine;
 	struct usb_dmac *dmac;
-	struct resource *mem;
 	unsigned int i;
 	int ret;
 
@@ -789,8 +788,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Request resources. */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmac->iomem = devm_ioremap_resource(&pdev->dev, mem);
+	dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dmac->iomem))
 		return PTR_ERR(dmac->iomem);
 
diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index ee3cbbf51006..46b884d46188 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -179,7 +179,6 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct device_node *dma_node;
 	struct stm32_dmamux_data *stm32_dmamux;
-	struct resource *res;
 	void __iomem *iomem;
 	struct reset_control *rst;
 	int i, count, ret;
@@ -238,8 +237,7 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	}
 	pm_runtime_get_noresume(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iomem = devm_ioremap_resource(&pdev->dev, res);
+	iomem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(iomem))
 		return PTR_ERR(iomem);
 
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index b9d4c843635f..84e7f4f4a800 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1580,7 +1580,6 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	struct stm32_mdma_device *dmadev;
 	struct dma_device *dd;
 	struct device_node *of_node;
-	struct resource *res;
 	struct reset_control *rst;
 	u32 nr_channels, nr_requests;
 	int i, count, ret;
@@ -1622,8 +1621,7 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 				       count);
 	dmadev->nr_ahb_addr_masks = count;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmadev->base = devm_ioremap_resource(&pdev->dev, res);
+	dmadev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dmadev->base))
 		return PTR_ERR(dmadev->base);
 
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index f291b1b4db32..e86c8829513a 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1144,15 +1144,13 @@ static irqreturn_t sun4i_dma_interrupt(int irq, void *dev_id)
 static int sun4i_dma_probe(struct platform_device *pdev)
 {
 	struct sun4i_dma_dev *priv;
-	struct resource *res;
 	int i, j, ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index b7557f437936..2f4bf72e7769 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1283,7 +1283,6 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct sun6i_dma_dev *sdc;
-	struct resource *res;
 	int ret, i;
 
 	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
@@ -1294,8 +1293,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	if (!sdc->cfg)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sdc->base = devm_ioremap_resource(&pdev->dev, res);
+	sdc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sdc->base))
 		return PTR_ERR(sdc->base);
 
diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index ae39b52012b2..d1a84483f627 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -837,7 +837,6 @@ static int tegra_adma_probe(struct platform_device *pdev)
 {
 	const struct tegra_adma_chip_data *cdata;
 	struct tegra_adma *tdma;
-	struct resource	*res;
 	int ret, i;
 
 	cdata = of_device_get_match_data(&pdev->dev);
@@ -857,8 +856,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	tdma->nr_channels = cdata->nr_channels;
 	platform_set_drvdata(pdev, tdma);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tdma->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index 695915dba707..c3555cfb0681 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -1039,7 +1039,6 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	struct cppi41_dd *cdd;
 	struct device *dev = &pdev->dev;
 	const struct cppi_glue_infos *glue_info;
-	struct resource *mem;
 	int index;
 	int irq;
 	int ret;
@@ -1072,18 +1071,15 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	if (index < 0)
 		return index;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	cdd->ctrl_mem = devm_ioremap_resource(dev, mem);
+	cdd->ctrl_mem = devm_platform_ioremap_resource(pdev, index);
 	if (IS_ERR(cdd->ctrl_mem))
 		return PTR_ERR(cdd->ctrl_mem);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
-	cdd->sched_mem = devm_ioremap_resource(dev, mem);
+	cdd->sched_mem = devm_platform_ioremap_resource(pdev, index + 1);
 	if (IS_ERR(cdd->sched_mem))
 		return PTR_ERR(cdd->sched_mem);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, index + 2);
-	cdd->qmgr_mem = devm_ioremap_resource(dev, mem);
+	cdd->qmgr_mem = devm_platform_ioremap_resource(pdev, index + 2);
 	if (IS_ERR(cdd->qmgr_mem))
 		return PTR_ERR(cdd->qmgr_mem);
 
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 27f5019bdc1e..02e1c08c596d 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1658,7 +1658,6 @@ static int omap_dma_probe(struct platform_device *pdev)
 {
 	const struct omap_dma_config *conf;
 	struct omap_dmadev *od;
-	struct resource *res;
 	int rc, i, irq;
 	u32 val;
 
@@ -1666,8 +1665,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (!od)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	od->base = devm_ioremap_resource(&pdev->dev, res);
+	od->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(od->base))
 		return PTR_ERR(od->base);
 
diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 21472a5d7636..ce359058c638 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -890,7 +890,6 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 			   struct platform_device *pdev)
 {
 	struct zynqmp_dma_chan *chan;
-	struct resource *res;
 	struct device_node *node = pdev->dev.of_node;
 	int err;
 
@@ -900,8 +899,7 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 	chan->dev = zdev->dev;
 	chan->zdev = zdev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chan->regs = devm_ioremap_resource(&pdev->dev, res);
+	chan->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chan->regs))
 		return PTR_ERR(chan->regs);
 
-- 
2.25.1

