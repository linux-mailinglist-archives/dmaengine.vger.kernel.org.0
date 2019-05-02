Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D173B1197D
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfEBMzx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 08:55:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17122 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEBMzt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 08:55:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccae8cf0000>; Thu, 02 May 2019 05:55:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 05:55:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 May 2019 05:55:47 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 12:55:46 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 2 May 2019 12:55:46 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ccae8cf0004>; Thu, 02 May 2019 05:55:46 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/6] dmaengine: tegra210-adma: add support for Tegra186/Tegra194
Date:   Thu, 2 May 2019 18:25:14 +0530
Message-ID: <1556801717-31507-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
References: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556801743; bh=7mtsR+WFg5blIIg7MunRDttrtfPeHP9Yge2pSN/ZO9g=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=rDps1gDiSnUv990wMIO1+kXRqeUfCtq9pJeoHoWLrGN3QBpgwEec+AIZB4GptLnn9
         1Ra75Ob6cDOi8F1qXnufu6YWP0TkqHfv1OPDTDoE4ngCoE3wSrRKizzCWEIUReXnJ6
         zxApzavrjmZ7oI4kJEGQ3FhCDV/nChc9JCJ81YiZ8adzR8eibbnLXBsvoL9SmZYYKk
         GsWrAg4bZ7hM8KJCusMBt5oLPAI3gU9gTX/p7I6uzj38cDD3B+UoEDUy4AqpmrUcQC
         piEgvYDIxdGPbHZ9eYX4ftUJV2c8Sn2vpM2Ye22FKibsv5F1p3a7AhjkLyrU0Kjh0z
         xGKqJFRI1Z3yw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Tegra186 specific macro defines and chip_data structure for chip
specific information. New compatibility is added to select relevant
chip details. There is no major change for Tegra194 and hence it can
use the same chip data.

The bits in the BURST_SIZE field of the ADMA CH_CONFIG register are
encoded differently on Tegra186 and Tegra194 compared with Tegra210.
On Tegra210 the bits are encoded as follows ...

 1 = WORD_1
 2 = WORDS_2
 3 = WORDS_4
 4 = WORDS_8
 5 = WORDS_16

Where as on Tegra186 and Tegra194 the bits are encoded as ...

 0 = WORD_1
 1 = WORDS_2
 2 = WORDS_3
 3 = WORDS_4
 4 = WORDS_5
 ...
 15 = WORDS_16

Add helper functions for generating the correct burst size.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 9aee015..115ee10f 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -45,8 +45,8 @@
 #define ADMA_CH_CONFIG					0x28
 #define ADMA_CH_CONFIG_SRC_BUF(val)			(((val) & 0x7) << 28)
 #define ADMA_CH_CONFIG_TRG_BUF(val)			(((val) & 0x7) << 24)
-#define ADMA_CH_CONFIG_BURST_SIZE(val)			(((val) & 0x7) << 20)
-#define ADMA_CH_CONFIG_BURST_16				5
+#define ADMA_CH_CONFIG_BURST_SIZE_SHIFT			20
+#define ADMA_CH_CONFIG_MAX_BURST_SIZE                   16
 #define ADMA_CH_CONFIG_WEIGHT_FOR_WRR(val)		((val) & 0xf)
 #define ADMA_CH_CONFIG_MAX_BUFS				8
 
@@ -87,6 +87,7 @@ struct tegra_adma;
  * @nr_channels: Number of DMA channels available.
  */
 struct tegra_adma_chip_data {
+	unsigned int (*adma_get_burst_config)(unsigned int burst_size);
 	unsigned int global_reg_offset;
 	unsigned int global_int_clear;
 	unsigned int ch_req_tx_shift;
@@ -489,6 +490,22 @@ static enum dma_status tegra_adma_tx_status(struct dma_chan *dc,
 	return ret;
 }
 
+static unsigned int tegra210_adma_get_burst_config(unsigned int burst_size)
+{
+	if (!burst_size || burst_size > ADMA_CH_CONFIG_MAX_BURST_SIZE)
+		burst_size = ADMA_CH_CONFIG_MAX_BURST_SIZE;
+
+	return fls(burst_size) << ADMA_CH_CONFIG_BURST_SIZE_SHIFT;
+}
+
+static unsigned int tegra186_adma_get_burst_config(unsigned int burst_size)
+{
+	if (!burst_size || burst_size > ADMA_CH_CONFIG_MAX_BURST_SIZE)
+		burst_size = ADMA_CH_CONFIG_MAX_BURST_SIZE;
+
+	return (burst_size - 1) << ADMA_CH_CONFIG_BURST_SIZE_SHIFT;
+}
+
 static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 				      struct tegra_adma_desc *desc,
 				      dma_addr_t buf_addr,
@@ -504,7 +521,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
 		adma_dir = ADMA_CH_CTRL_DIR_MEM2AHUB;
-		burst_size = fls(tdc->sconfig.dst_maxburst);
+		burst_size = tdc->sconfig.dst_maxburst;
 		ch_regs->config = ADMA_CH_CONFIG_SRC_BUF(desc->num_periods - 1);
 		ch_regs->ctrl = ADMA_CH_REG_FIELD_VAL(tdc->sreq_index,
 						      cdata->ch_req_mask,
@@ -514,7 +531,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 
 	case DMA_DEV_TO_MEM:
 		adma_dir = ADMA_CH_CTRL_DIR_AHUB2MEM;
-		burst_size = fls(tdc->sconfig.src_maxburst);
+		burst_size = tdc->sconfig.src_maxburst;
 		ch_regs->config = ADMA_CH_CONFIG_TRG_BUF(desc->num_periods - 1);
 		ch_regs->ctrl = ADMA_CH_REG_FIELD_VAL(tdc->sreq_index,
 						      cdata->ch_req_mask,
@@ -527,13 +544,10 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 		return -EINVAL;
 	}
 
-	if (!burst_size || burst_size > ADMA_CH_CONFIG_BURST_16)
-		burst_size = ADMA_CH_CONFIG_BURST_16;
-
 	ch_regs->ctrl |= ADMA_CH_CTRL_DIR(adma_dir) |
 			 ADMA_CH_CTRL_MODE_CONTINUOUS |
 			 ADMA_CH_CTRL_FLOWCTRL_EN;
-	ch_regs->config |= ADMA_CH_CONFIG_BURST_SIZE(burst_size);
+	ch_regs->config |= cdata->adma_get_burst_config(burst_size);
 	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
 	ch_regs->fifo_ctrl = ADMA_CH_FIFO_CTRL_DEFAULT;
 	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
@@ -671,6 +685,7 @@ static int tegra_adma_runtime_resume(struct device *dev)
 }
 
 static const struct tegra_adma_chip_data tegra210_chip_data = {
+	.adma_get_burst_config  = tegra210_adma_get_burst_config,
 	.global_reg_offset	= 0xc00,
 	.global_int_clear	= 0x20,
 	.ch_req_tx_shift	= 28,
@@ -682,8 +697,22 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.nr_channels		= 22,
 };
 
+static const struct tegra_adma_chip_data tegra186_chip_data = {
+	.adma_get_burst_config  = tegra186_adma_get_burst_config,
+	.global_reg_offset	= 0,
+	.global_int_clear	= 0x402c,
+	.ch_req_tx_shift	= 27,
+	.ch_req_rx_shift	= 22,
+	.ch_base_offset		= 0x10000,
+	.ch_req_mask		= 0x1f,
+	.ch_req_max		= 20,
+	.ch_reg_size		= 0x100,
+	.nr_channels		= 32,
+};
+
 static const struct of_device_id tegra_adma_of_match[] = {
 	{ .compatible = "nvidia,tegra210-adma", .data = &tegra210_chip_data },
+	{ .compatible = "nvidia,tegra186-adma", .data = &tegra186_chip_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_adma_of_match);
-- 
2.7.4

