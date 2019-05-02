Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E09611974
	for <lists+dmaengine@lfdr.de>; Thu,  2 May 2019 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEBMzi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 May 2019 08:55:38 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15782 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEBMzi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 May 2019 08:55:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccae8cf0000>; Thu, 02 May 2019 05:55:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 05:55:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 May 2019 05:55:36 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 12:55:36 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 12:55:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 2 May 2019 12:55:35 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ccae8c40000>; Thu, 02 May 2019 05:55:34 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/6] dmaengine: tegra210-adma: prepare for supporting newer Tegra chips
Date:   Thu, 2 May 2019 18:25:12 +0530
Message-ID: <1556801717-31507-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
References: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556801743; bh=p/T1zM9ZfB/1ENPUtGVvaAC9m/z7XqEZjSlRWt5hbSo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=Z6ggIPj3+xtCIewevOVrX0vA/5mHRKTWDN7+ftd2Pto9JCNbdZTW8fIqwTgtkGEYq
         XC84oCJrDOGdTvzmOG2ggBuziomOA+GsLTHHszchxzDzbQ1TitN+21H3epVa/pkCGt
         gBmvpov9y/YswVEnMtCgKPyNr5ao3hVV6G8hgWcI7ihbfZqf/61v73mcaBVwrWQ/5D
         LS6K4NBKFtbHv6vOyRgx7Kf5PMGUpupRIW3pXxbR8C0EnbUUAnShLvDs3DBErNY26D
         HdOcSKOm5Atq2QczBnpMWA3RgoozyywBIx7+71IyX5LXqmQCH6Ep+TPZcUdFsOsmx5
         OUUwqI+FdwGyA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is a preparatory patch to add support for Tegra186 and Tegra194 chips.
Following changes are necessary to make driver code generic.
 * chip_data structure is enhanced to have chip specific details and
   following are the additions to the structure
   * Offset addresses for ADMA global and channel registers
   * Offset values for Tx and Rx channel selection
   * Maximum supported Tx and Rx channels
   * Tx and Rx channel request mask
   * ADMA channel register space size
 * Make use of above chip_data to generalise the driver code

Support for Tegra186 and Tegra194 will be added in subsequent patches of
the series.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 91 ++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 253d312..9aee015 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -36,10 +36,6 @@
 
 #define ADMA_CH_INT_CLEAR				0x1c
 #define ADMA_CH_CTRL					0x24
-#define ADMA_CH_CTRL_TX_REQ(val)			(((val) & 0xf) << 28)
-#define ADMA_CH_CTRL_TX_REQ_MAX				10
-#define ADMA_CH_CTRL_RX_REQ(val)			(((val) & 0xf) << 24)
-#define ADMA_CH_CTRL_RX_REQ_MAX				10
 #define ADMA_CH_CTRL_DIR(val)				(((val) & 0xf) << 12)
 #define ADMA_CH_CTRL_DIR_AHUB2MEM			2
 #define ADMA_CH_CTRL_DIR_MEM2AHUB			4
@@ -57,8 +53,8 @@
 #define ADMA_CH_FIFO_CTRL				0x2c
 #define ADMA_CH_FIFO_CTRL_OVRFW_THRES(val)		(((val) & 0xf) << 24)
 #define ADMA_CH_FIFO_CTRL_STARV_THRES(val)		(((val) & 0xf) << 16)
-#define ADMA_CH_FIFO_CTRL_TX_SIZE(val)			(((val) & 0xf) << 8)
-#define ADMA_CH_FIFO_CTRL_RX_SIZE(val)			((val) & 0xf)
+#define ADMA_CH_FIFO_CTRL_TX_FIFO_SIZE_SHIFT		8
+#define ADMA_CH_FIFO_CTRL_RX_FIFO_SIZE_SHIFT		0
 
 #define ADMA_CH_LOWER_SRC_ADDR				0x34
 #define ADMA_CH_LOWER_TRG_ADDR				0x3c
@@ -68,25 +64,38 @@
 #define ADMA_CH_XFER_STATUS				0x54
 #define ADMA_CH_XFER_STATUS_COUNT_MASK			0xffff
 
-#define ADMA_GLOBAL_CMD					0xc00
-#define ADMA_GLOBAL_SOFT_RESET				0xc04
-#define ADMA_GLOBAL_INT_CLEAR				0xc20
-#define ADMA_GLOBAL_CTRL				0xc24
-
-#define ADMA_CH_REG_OFFSET(a)				(a * 0x80)
+#define ADMA_GLOBAL_CMD					0x00
+#define ADMA_GLOBAL_SOFT_RESET				0x04
 
 #define ADMA_CH_FIFO_CTRL_DEFAULT	(ADMA_CH_FIFO_CTRL_OVRFW_THRES(1) | \
-					 ADMA_CH_FIFO_CTRL_STARV_THRES(1) | \
-					 ADMA_CH_FIFO_CTRL_TX_SIZE(3)     | \
-					 ADMA_CH_FIFO_CTRL_RX_SIZE(3))
+					 ADMA_CH_FIFO_CTRL_STARV_THRES(1))
+
+#define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
+
 struct tegra_adma;
 
 /*
  * struct tegra_adma_chip_data - Tegra chip specific data
+ * @global_reg_offset: Register offset of DMA global register.
+ * @global_int_clear: Register offset of DMA global interrupt clear.
+ * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
+ * @ch_req_rx_shift: Register offset for AHUB receive channel select.
+ * @ch_base_offset: Reister offset of DMA channel registers.
+ * @ch_req_mask: Mask for Tx or Rx channel select.
+ * @ch_req_max: Maximum number of Tx or Rx channels available.
+ * @ch_reg_size: Size of DMA channel register space.
  * @nr_channels: Number of DMA channels available.
  */
 struct tegra_adma_chip_data {
-	int nr_channels;
+	unsigned int global_reg_offset;
+	unsigned int global_int_clear;
+	unsigned int ch_req_tx_shift;
+	unsigned int ch_req_rx_shift;
+	unsigned int ch_base_offset;
+	unsigned int ch_req_mask;
+	unsigned int ch_req_max;
+	unsigned int ch_reg_size;
+	unsigned int nr_channels;
 };
 
 /*
@@ -148,18 +157,20 @@ struct tegra_adma {
 	/* Used to store global command register state when suspending */
 	unsigned int			global_cmd;
 
+	const struct tegra_adma_chip_data *cdata;
+
 	/* Last member of the structure */
 	struct tegra_adma_chan		channels[0];
 };
 
 static inline void tdma_write(struct tegra_adma *tdma, u32 reg, u32 val)
 {
-	writel(val, tdma->base_addr + reg);
+	writel(val, tdma->base_addr + tdma->cdata->global_reg_offset + reg);
 }
 
 static inline u32 tdma_read(struct tegra_adma *tdma, u32 reg)
 {
-	return readl(tdma->base_addr + reg);
+	return readl(tdma->base_addr + tdma->cdata->global_reg_offset + reg);
 }
 
 static inline void tdma_ch_write(struct tegra_adma_chan *tdc, u32 reg, u32 val)
@@ -209,14 +220,16 @@ static int tegra_adma_init(struct tegra_adma *tdma)
 	int ret;
 
 	/* Clear any interrupts */
-	tdma_write(tdma, ADMA_GLOBAL_INT_CLEAR, 0x1);
+	tdma_write(tdma, tdma->cdata->global_int_clear, 0x1);
 
 	/* Assert soft reset */
 	tdma_write(tdma, ADMA_GLOBAL_SOFT_RESET, 0x1);
 
 	/* Wait for reset to clear */
 	ret = readx_poll_timeout(readl,
-				 tdma->base_addr + ADMA_GLOBAL_SOFT_RESET,
+				 tdma->base_addr +
+				 tdma->cdata->global_reg_offset +
+				 ADMA_GLOBAL_SOFT_RESET,
 				 status, status == 0, 20, 10000);
 	if (ret)
 		return ret;
@@ -236,13 +249,13 @@ static int tegra_adma_request_alloc(struct tegra_adma_chan *tdc,
 	if (tdc->sreq_reserved)
 		return tdc->sreq_dir == direction ? 0 : -EINVAL;
 
+	if (sreq_index > tdma->cdata->ch_req_max) {
+		dev_err(tdma->dev, "invalid DMA request\n");
+		return -EINVAL;
+	}
+
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
-		if (sreq_index > ADMA_CH_CTRL_TX_REQ_MAX) {
-			dev_err(tdma->dev, "invalid DMA request\n");
-			return -EINVAL;
-		}
-
 		if (test_and_set_bit(sreq_index, &tdma->tx_requests_reserved)) {
 			dev_err(tdma->dev, "DMA request reserved\n");
 			return -EINVAL;
@@ -250,11 +263,6 @@ static int tegra_adma_request_alloc(struct tegra_adma_chan *tdc,
 		break;
 
 	case DMA_DEV_TO_MEM:
-		if (sreq_index > ADMA_CH_CTRL_RX_REQ_MAX) {
-			dev_err(tdma->dev, "invalid DMA request\n");
-			return -EINVAL;
-		}
-
 		if (test_and_set_bit(sreq_index, &tdma->rx_requests_reserved)) {
 			dev_err(tdma->dev, "DMA request reserved\n");
 			return -EINVAL;
@@ -487,6 +495,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 				      enum dma_transfer_direction direction)
 {
 	struct tegra_adma_chan_regs *ch_regs = &desc->ch_regs;
+	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
 	unsigned int burst_size, adma_dir;
 
 	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
@@ -497,7 +506,9 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 		adma_dir = ADMA_CH_CTRL_DIR_MEM2AHUB;
 		burst_size = fls(tdc->sconfig.dst_maxburst);
 		ch_regs->config = ADMA_CH_CONFIG_SRC_BUF(desc->num_periods - 1);
-		ch_regs->ctrl = ADMA_CH_CTRL_TX_REQ(tdc->sreq_index);
+		ch_regs->ctrl = ADMA_CH_REG_FIELD_VAL(tdc->sreq_index,
+						      cdata->ch_req_mask,
+						      cdata->ch_req_tx_shift);
 		ch_regs->src_addr = buf_addr;
 		break;
 
@@ -505,7 +516,9 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 		adma_dir = ADMA_CH_CTRL_DIR_AHUB2MEM;
 		burst_size = fls(tdc->sconfig.src_maxburst);
 		ch_regs->config = ADMA_CH_CONFIG_TRG_BUF(desc->num_periods - 1);
-		ch_regs->ctrl = ADMA_CH_CTRL_RX_REQ(tdc->sreq_index);
+		ch_regs->ctrl = ADMA_CH_REG_FIELD_VAL(tdc->sreq_index,
+						      cdata->ch_req_mask,
+						      cdata->ch_req_rx_shift);
 		ch_regs->trg_addr = buf_addr;
 		break;
 
@@ -658,7 +671,15 @@ static int tegra_adma_runtime_resume(struct device *dev)
 }
 
 static const struct tegra_adma_chip_data tegra210_chip_data = {
-	.nr_channels = 22,
+	.global_reg_offset	= 0xc00,
+	.global_int_clear	= 0x20,
+	.ch_req_tx_shift	= 28,
+	.ch_req_rx_shift	= 24,
+	.ch_base_offset		= 0,
+	.ch_req_mask		= 0xf,
+	.ch_req_max		= 10,
+	.ch_reg_size		= 0x80,
+	.nr_channels		= 22,
 };
 
 static const struct of_device_id tegra_adma_of_match[] = {
@@ -687,6 +708,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	tdma->dev = &pdev->dev;
+	tdma->cdata = cdata;
 	tdma->nr_channels = cdata->nr_channels;
 	platform_set_drvdata(pdev, tdma);
 
@@ -715,7 +737,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	for (i = 0; i < tdma->nr_channels; i++) {
 		struct tegra_adma_chan *tdc = &tdma->channels[i];
 
-		tdc->chan_addr = tdma->base_addr + ADMA_CH_REG_OFFSET(i);
+		tdc->chan_addr = tdma->base_addr + cdata->ch_base_offset
+				 + (cdata->ch_reg_size * i);
 
 		tdc->irq = of_irq_get(pdev->dev.of_node, i);
 		if (tdc->irq <= 0) {
-- 
2.7.4

