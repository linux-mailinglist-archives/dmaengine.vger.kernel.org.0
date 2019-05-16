Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E220BA4
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2019 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfEPPyD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 May 2019 11:54:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18311 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPPyD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 May 2019 11:54:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdd87710000>; Thu, 16 May 2019 08:53:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 May 2019 08:54:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 May 2019 08:54:02 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 15:54:02 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 15:54:02 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 15:54:02 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdd87980003>; Thu, 16 May 2019 08:54:01 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/3] dmaengine: tegra210-adma: Fix channel FIFO configuration
Date:   Thu, 16 May 2019 16:53:53 +0100
Message-ID: <1558022034-19911-3-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558022034-19911-1-git-send-email-jonathanh@nvidia.com>
References: <1558022034-19911-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558022001; bh=IsB45IpbY0HzseeDxzxT7UJ6yhNhFRRD1P0aoi9id7Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bJYZcQ3esC1q2VvpccIQUCuKCaD5OclNPxvbMaUiEMfKFGT8JkKVZcwbJTLApdbui
         tDesL6DXYV5PUqXWb++RvYpv/M62jtzlFQTa65WDpgZ8rMijI9b7J9A+pRE0sYa5dt
         oGDm9vWN8HOK+DBc2Tzq6I0LUpTf8WpmTVyQ6gvKPckplJVgCUSJcrkEdEjvEmp16P
         Z0ya22VLszey8ejzmcCNNsVHM+4xcb5qk1DNtsXSG3EyR2+4diUjfHkb/pJX7BAAAG
         o5rsFfy1Kzf54lZUkt0UpMOvOYF6MwBf9QnpFaC07zn/BzrSQxD2WBodkY8hALy52+
         b3VlEC00KpLOA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit ded1f3db4cd6 ("dmaengine: tegra210-adma: prepare for supporting
newer Tegra chips") removed the default settings DMA channel RX and TX
FIFO sizes and this is breaking DMA transfers. The intention was to
move the default settings to the chip specific data structure because
this commit was preparing for adding support for Tegra186 where the
fields for the FIFO CTRL register are slightly different.

Fix the configuration of the FIFO sizes by adding default values for
the FIFO CTRL register for both Tegra210 and Tegra186 and store the
values in the chip specific structure.

Fixes: ded1f3db4cd6 ("dmaengine: tegra210-adma: prepare for supporting newer Tegra chips")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 3ec3d71acd25..3f50fd11c380 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -53,10 +53,14 @@
 #define ADMA_CH_CONFIG_MAX_BUFS				8
 
 #define ADMA_CH_FIFO_CTRL				0x2c
-#define ADMA_CH_FIFO_CTRL_OVRFW_THRES(val)		(((val) & 0xf) << 24)
-#define ADMA_CH_FIFO_CTRL_STARV_THRES(val)		(((val) & 0xf) << 16)
-#define ADMA_CH_FIFO_CTRL_TX_FIFO_SIZE_SHIFT		8
-#define ADMA_CH_FIFO_CTRL_RX_FIFO_SIZE_SHIFT		0
+#define TEGRA210_ADMA_CH_FIFO_CTRL_OFLWTHRES(val)	(((val) & 0xf) << 24)
+#define TEGRA210_ADMA_CH_FIFO_CTRL_STRVTHRES(val)	(((val) & 0xf) << 16)
+#define TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0xf) << 8)
+#define TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0xf)
+#define TEGRA186_ADMA_CH_FIFO_CTRL_OFLWTHRES(val)	(((val) & 0x1f) << 24)
+#define TEGRA186_ADMA_CH_FIFO_CTRL_STRVTHRES(val)	(((val) & 0x1f) << 16)
+#define TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0x1f) << 8)
+#define TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0x1f)
 
 #define ADMA_CH_LOWER_SRC_ADDR				0x34
 #define ADMA_CH_LOWER_TRG_ADDR				0x3c
@@ -71,8 +75,15 @@
 
 #define TEGRA_ADMA_BURST_COMPLETE_TIME			20
 
-#define ADMA_CH_FIFO_CTRL_DEFAULT	(ADMA_CH_FIFO_CTRL_OVRFW_THRES(1) | \
-					 ADMA_CH_FIFO_CTRL_STARV_THRES(1))
+#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_OFLWTHRES(1) | \
+				    TEGRA210_ADMA_CH_FIFO_CTRL_STRVTHRES(1) | \
+				    TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
+				    TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(3))
+
+#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_OFLWTHRES(1) | \
+				    TEGRA186_ADMA_CH_FIFO_CTRL_STRVTHRES(1) | \
+				    TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
+				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
 
 #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
 
@@ -85,6 +96,7 @@ struct tegra_adma;
  * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
  * @ch_req_rx_shift: Register offset for AHUB receive channel select.
  * @ch_base_offset: Reister offset of DMA channel registers.
+ * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
  * @ch_req_mask: Mask for Tx or Rx channel select.
  * @ch_req_max: Maximum number of Tx or Rx channels available.
  * @ch_reg_size: Size of DMA channel register space.
@@ -97,6 +109,7 @@ struct tegra_adma_chip_data {
 	unsigned int ch_req_tx_shift;
 	unsigned int ch_req_rx_shift;
 	unsigned int ch_base_offset;
+	unsigned int ch_fifo_ctrl;
 	unsigned int ch_req_mask;
 	unsigned int ch_req_max;
 	unsigned int ch_reg_size;
@@ -600,7 +613,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 			 ADMA_CH_CTRL_FLOWCTRL_EN;
 	ch_regs->config |= cdata->adma_get_burst_config(burst_size);
 	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
-	ch_regs->fifo_ctrl = ADMA_CH_FIFO_CTRL_DEFAULT;
+	ch_regs->fifo_ctrl = cdata->ch_fifo_ctrl;
 	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
 
 	return tegra_adma_request_alloc(tdc, direction);
@@ -784,6 +797,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.ch_req_tx_shift	= 28,
 	.ch_req_rx_shift	= 24,
 	.ch_base_offset		= 0,
+	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0xf,
 	.ch_req_max		= 10,
 	.ch_reg_size		= 0x80,
@@ -797,6 +811,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.ch_req_tx_shift	= 27,
 	.ch_req_rx_shift	= 22,
 	.ch_base_offset		= 0x10000,
+	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0x1f,
 	.ch_req_max		= 20,
 	.ch_reg_size		= 0x100,
-- 
2.7.4

