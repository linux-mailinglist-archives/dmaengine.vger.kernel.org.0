Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB456A4256
	for <lists+dmaengine@lfdr.de>; Mon, 27 Feb 2023 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjB0NLJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Feb 2023 08:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjB0NLF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Feb 2023 08:11:05 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E9EE384;
        Mon, 27 Feb 2023 05:11:02 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6E05024E420;
        Mon, 27 Feb 2023 21:10:55 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 21:10:55 +0800
Received: from localhost.localdomain (113.72.145.171) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 21:10:54 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 2/3] dmaengine: dw-axi-dmac: Add support for StarFive JH7110 DMA
Date:   Mon, 27 Feb 2023 21:10:41 +0800
Message-ID: <20230227131042.16125-3-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227131042.16125-1-walker.chen@starfivetech.com>
References: <20230227131042.16125-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA reset operation in device probe and use different configuration
on CH_CFG registers according to match data.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 34 +++++++++++++++++--
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  7 ++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index bf85aa0979ec..400eeef707bf 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -21,10 +21,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -86,7 +88,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
 
 	cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
 		  config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
-	if (chan->chip->dw->hdata->reg_map_8_channels) {
+	if (chan->chip->dw->hdata->reg_map_8_channels &&
+	    !chan->chip->dw->hdata->use_cfg2) {
 		cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
 			 config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
 			 config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
@@ -1142,7 +1145,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	axi_chan_disable(chan);
 
 	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
-					!(val & chan_active), 1000, 10000);
+					!(val & chan_active), 1000, DMAC_TIMEOUT_US);
 	if (ret == -ETIMEDOUT)
 		dev_warn(dchan2dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
@@ -1367,6 +1370,17 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 	return 0;
 }
 
+static int jh7110_rst_init(struct platform_device *pdev)
+{
+	struct reset_control *resets;
+
+	resets = devm_reset_control_array_get_exclusive(&pdev->dev);
+	if (IS_ERR(resets))
+		return PTR_ERR(resets);
+
+	return reset_control_deassert(resets);
+}
+
 static int dw_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -1374,6 +1388,7 @@ static int dw_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
+	const struct axi_dma_chip_config *ccfg;
 	u32 i;
 	int ret;
 
@@ -1416,6 +1431,15 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->cfgr_clk))
 		return PTR_ERR(chip->cfgr_clk);
 
+	ccfg = of_device_get_match_data(&pdev->dev);
+	if (ccfg) {
+		ret = ccfg->rst_init(pdev);
+		if (ret)
+			return ret;
+
+		chip->dw->hdata->use_cfg2 = ccfg->use_cfg2;
+	}
+
 	ret = parse_device_properties(chip);
 	if (ret)
 		return ret;
@@ -1557,9 +1581,15 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
 	SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
 };
 
+static const struct axi_dma_chip_config jh7110_chip_config = {
+	.rst_init = jh7110_rst_init,
+	.use_cfg2 = true,
+};
+
 static const struct of_device_id dw_dma_of_id_table[] = {
 	{ .compatible = "snps,axi-dma-1.01a" },
 	{ .compatible = "intel,kmb-axi-dma" },
+	{ .compatible = "starfive,jh7110-axi-dma", .data = &jh7110_chip_config },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index e9d5eb0fd594..7b404ae9a26a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -21,6 +21,7 @@
 #define DMAC_MAX_CHANNELS	16
 #define DMAC_MAX_MASTERS	2
 #define DMAC_MAX_BLK_SIZE	0x200000
+#define DMAC_TIMEOUT_US		200000
 
 struct dw_axi_dma_hcfg {
 	u32	nr_channels;
@@ -33,6 +34,7 @@ struct dw_axi_dma_hcfg {
 	/* Register map for DMAX_NUM_CHANNELS <= 8 */
 	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
+	bool	use_cfg2;
 };
 
 struct axi_dma_chan {
@@ -72,6 +74,11 @@ struct axi_dma_chip {
 	struct dw_axi_dma	*dw;
 };
 
+struct axi_dma_chip_config {
+	int (*rst_init)(struct platform_device *pdev);
+	bool use_cfg2;
+};
+
 /* LLI == Linked List Item */
 struct __packed axi_dma_lli {
 	__le64		sar;
-- 
2.17.1

