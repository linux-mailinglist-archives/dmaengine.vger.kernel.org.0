Return-Path: <dmaengine+bounces-6573-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B8FB5A2C7
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B6327EAD
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D112F9DAE;
	Tue, 16 Sep 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbmrirpM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8032732B4B1;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=AgXVj2YiLEa1naM7WbCltk8oLwb0ytt2PMiEehObSvb8EW4i9zxUiYpejA4+SbLsS2BICF5pBimQes0+wbE4/uLzZtT+08N8cdZ/5Dvwe+cYVjH8FsxMhgU+c9jnlGryK7Sv1viKPUGQpe3Hnl7cjATCiJtD87Z68x8rxS8NOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=TqR1CWjVL5mDbHU9P1Qh8+Oh41mlkvQF2RUArSi/Vy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXHNsLeG3skZvXBZ9j8wfFs+8dP4FknAQWmgWHDlVvukJo6Juh55mm3MRpeKosaHvRhiKBROGalvtS+zHo40+U2I40t4EiNAQmEHNep+kuoddm7M80vaR1kzTJIa799OYbQclt2NiJcA61EQ6CCGgrsqVD2WlZc8qrCY66pi4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbmrirpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52032C4AF48;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054326;
	bh=TqR1CWjVL5mDbHU9P1Qh8+Oh41mlkvQF2RUArSi/Vy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YbmrirpMxYvcYNhzYCbNyvSrUr0P++UaaQINgoZfl5+RReJPFv/YIQN3qfL8ZoKTF
	 IWbDl/5X0vbGDMY8kAMNMYrlHfN4SjcFdw40cGRvLZ20AFLLTMVFV41s2zkOYtXONy
	 iFh4rx/12xFS/VLxOErWL/Gnw63NGlHQapLmVH0JX3ZRqYtXklSey59N1RGgfeUrvq
	 nygw47mri9TfWHfPPDSkD5r7xfe+fKAHhAD+HeRdM3z8GoDd3CXfnHvdD14xVtnHSS
	 NcdLhoh+eK0QNHs3fGMRSN+dX5bbvSKXstWWXyGzz3BsrTzN13mGSUuqz/csNyPWpf
	 221VpYqOwVPmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44692CAC592;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:19 +0700
Subject: [PATCH 22/25] mmc: host: Add RDA Micro SD/MMC driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-22-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=25605;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=kM52IsCiYRotM7GzUsUvED96oijVZ9O0VQ9eo3hPKnM=;
 b=rMz/A3RkPApebTjBcT5FekA3YZNK3M0XuzxfKpb02/jCjD21PtYt+jtAT3E8bTHXxDrJFaACa
 2Oz3JRC5b1yCajLjs/9SsYDsjdy0F4ylGfxmkby/ZrP2cZWZveotwEW
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

RDA Micro RDA8810PL includes an SD/MMC controller. This controller
supports SD/SDIO/MMC interface.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 MAINTAINERS                |   6 +
 drivers/mmc/host/Kconfig   |  12 +
 drivers/mmc/host/Makefile  |   1 +
 drivers/mmc/host/rda-mmc.c | 853 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 872 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91be43782f4ba8aacb629002d357a66704f10b2b..33e04ce35dcc4cbadd715ec9199f2453237b8002 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21417,6 +21417,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/rda,8810pl-rtc.yaml
 F:	drivers/rtc/rtc-rda.c
 
+RDA MICRO SECURE DIGITAL AND MULTIMEDIA CARD DRIVER
+M:	Dang Huynh <dang.huynh@mainlining.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/rda,mmc.yaml
+F:	drivers/mmc/host/rda-mmc.c
+
 RDACM20 Camera Sensor
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 4afa0130779d97ca9d1c0ed2102b0babdedcaeeb..352a6eb4e30793b7311c7877c238a7fe31121123 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1040,6 +1040,18 @@ config MMC_MTK
 	  This is needed if support for any SD/SDIO/MMC devices is required.
 	  If unsure, say N.
 
+config MMC_RDA
+	tristate "RDA Micro SD/MMC Card Interface support"
+	depends on ARCH_RDA
+	depends on COMMON_CLK
+	depends on HAS_DMA
+	help
+	  This selects the RDA Micro Secure digital and Multimedia card interface. The
+	  controller supports SD/SDIO/MMC interface.
+	  If you have a board with RDA SoC and it uses this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_MICROCHIP_PIC32
 	tristate "Microchip PIC32MZDA SDHCI support"
 	depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 5057fea8afb696e210e465a6a2aafc68adad7854..d819e18a478e35cb7de6d67b1cf827e1b3d09815 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_MMC_ALCOR)	+= alcor.o
 obj-$(CONFIG_MMC_MTK)		+= mtk-sd.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_OMAP_HS)	+= omap_hsmmc.o
+obj-$(CONFIG_MMC_RDA)		+= rda-mmc.o
 obj-$(CONFIG_MMC_ATMELMCI)	+= atmel-mci.o
 obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
 obj-$(CONFIG_MMC_MVSDIO)	+= mvsdio.o
diff --git a/drivers/mmc/host/rda-mmc.c b/drivers/mmc/host/rda-mmc.c
new file mode 100644
index 0000000000000000000000000000000000000000..1767d387bc482694fa9935bc59ceba7e2a8a7535
--- /dev/null
+++ b/drivers/mmc/host/rda-mmc.c
@@ -0,0 +1,853 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SD/MMC driver for RDA Micro platform
+ *
+ * Copyright (C) 2013 RDA Microelectronics Inc.
+ * Copyright (c) 2025 Dang Huynh <dang.huynh@mainlining.org>
+ */
+
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/iopoll.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/debugfs.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+
+/* Registers Definitions */
+#define SDMMC_REG_CTRL 0x0
+#define SDMMC_REG_FIFO_TXRX 0x8
+#define SDMMC_REG_CONFIG 0x800
+#define SDMMC_REG_STATUS 0x804
+#define SDMMC_REG_CMD_INDEX 0x808
+#define SDMMC_REG_CMD_ARG 0x80C
+#define SDMMC_REG_RESP_INDEX 0x810
+#define SDMMC_REG_RESP_ARG3 0x814
+#define SDMMC_REG_RESP_ARG2 0x818
+#define SDMMC_REG_RESP_ARG1 0x81C
+#define SDMMC_REG_RESP_ARG0 0x820
+#define SDMMC_REG_DATA_WIDTH 0x824
+#define SDMMC_REG_BLOCK_SIZE 0x828
+#define SDMMC_REG_BLOCK_COUNT 0x82C
+#define SDMMC_REG_INT_STATUS 0x830
+#define SDMMC_REG_INT_MASK 0x834
+#define SDMMC_REG_INT_CLEAR 0x838
+#define SDMMC_REG_TRANS_SPEED 0x83C
+#define SDMMC_REG_MCLK_ADJUST 0x840
+
+/* Bits def */
+/* CTRL */
+#define SDMMC_CTRL_ENDIAN GENMASK(2, 0)
+#define SDMMC_CTRL_SOFTRST_L BIT(3)
+
+/* CONFIG */
+#define SDMMC_CFG_SENDCMD BIT(0)
+#define SDMMC_CFG_SUSPEND BIT(1)
+#define SDMMC_CFG_RSP_EN BIT(4)
+#define SDMMC_CFG_RSP_SEL GENMASK(6, 5)
+#define SDMMC_CFG_RD_WT_EN BIT(8)
+#define SDMMC_CFG_RD_WT_SEL BIT(9)
+#define SDMMC_CFG_S_M_SEL BIT(10)
+#define SDMMC_CFG_AUTO_FLAG_EN BIT(16)
+#define SDMMC_CFG_SAMPLE_EDGE_SEL_FALL_EN BIT(17)
+
+/* STATUS */
+#define SDMMC_STATUS_NOTOVER BIT(0)
+#define SDMMC_STATUS_BUSY BIT(1)
+#define SDMMC_STATUS_DLBUSY BIT(2)
+#define SDMMC_STATUS_SUSPEND BIT(3)
+#define SDMMC_STATUS_RSP_ERR BIT(8)
+#define SDMMC_STATUS_NO_RSP_ERR BIT(9)
+#define SDMMC_STATUS_CRC_STATUS GENMASK(14, 12)
+#define SDMMC_STATUS_DATA_ERROR GENMASK(23, 16)
+#define SDMMC_STATUS_DAT3_VAL BIT(24)
+
+/* INTERRUPTS */
+/* Mask and Clear */
+#define SDMMC_INT_NO_RSP BIT(0)
+#define SDMMC_INT_RSP_ERR BIT(1)
+#define SDMMC_INT_RD_ERR BIT(2)
+#define SDMMC_INT_WR_ERR BIT(3)
+#define SDMMC_INT_DAT_OVER BIT(4)
+#define SDMMC_INT_TXDMA_DONE BIT(5)
+#define SDMMC_INT_RXDMA_DONE BIT(6)
+#define SDMMC_INT_SDIO BIT(7)
+
+#define SDMMC_MCLK_INVERT BIT(4)
+#define SDMMC_MCLK_DISABLE BIT(5)
+
+struct rda_mmc_host {
+	struct device *dev;
+
+	struct mmc_host *mmc;
+	struct mmc_request *mrq;
+
+	unsigned int clock;
+	unsigned int bus_width;
+	unsigned int power_mode;
+	struct regulator *vmmc;
+
+	void __iomem *base;
+	int irq;
+
+	struct clk *clk;
+	struct reset_control *reset;
+
+	dma_cookie_t dma_cookie;
+	struct dma_chan *dma_tx;
+	struct dma_chan *dma_rx;
+
+	bool sdio_irq;
+	bool sdio_irq_trigger;
+
+	spinlock_t lock;
+	struct completion c;
+
+	/* device tree properties */
+	bool mclk_inv;
+	u8 mclk_adj;
+};
+
+static int rda_mmc_hw_init(struct rda_mmc_host *priv)
+{
+	void __iomem *base = priv->base;
+
+	disable_irq(priv->irq);
+
+	writel(FIELD_PREP(SDMMC_CTRL_ENDIAN, 1) | SDMMC_CTRL_SOFTRST_L,
+			base + SDMMC_REG_CTRL);
+	writel(SDMMC_INT_RD_ERR | SDMMC_INT_WR_ERR | SDMMC_INT_DAT_OVER,
+			base + SDMMC_REG_INT_MASK);
+	writel(0xFFFFFFFF, base + SDMMC_REG_INT_CLEAR);
+
+	enable_irq(priv->irq);
+
+	return 0;
+}
+
+static void rda_mmc_reset(struct rda_mmc_host *priv)
+{
+	reset_control_assert(priv->reset);
+	mdelay(1);
+	reset_control_deassert(priv->reset);
+	mdelay(1);
+}
+
+static void rda_mmc_recv_resp(struct mmc_host *host, struct mmc_command *cmd)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	struct device *dev = mmc_dev(host);
+	void __iomem *base = priv->base;
+	u32 status;
+	int ret;
+
+	/* If the controller is busy, wait until it finishes */
+	ret = readl_poll_timeout(base + SDMMC_REG_STATUS, status,
+			!(status & SDMMC_STATUS_NOTOVER), 50, 1000 * 1000);
+	if (ret) {
+		dev_err(dev, "Timed out waiting for the controller\n");
+		cmd->error = ret;
+		return;
+	}
+
+	if (status & SDMMC_STATUS_NO_RSP_ERR)
+		return;
+
+	if (status & SDMMC_STATUS_RSP_ERR) {
+		cmd->error = -EILSEQ;
+		return;
+	}
+
+	if (mmc_resp_type(cmd) & MMC_RSP_R2) {
+		cmd->resp[0] = readl_relaxed(base + SDMMC_REG_RESP_ARG3);
+		cmd->resp[1] = readl_relaxed(base + SDMMC_REG_RESP_ARG2);
+		cmd->resp[2] = readl_relaxed(base + SDMMC_REG_RESP_ARG1);
+		cmd->resp[3] = readl_relaxed(base + SDMMC_REG_RESP_ARG0) << 1;
+	} else {
+		cmd->resp[0] = readl_relaxed(base + SDMMC_REG_RESP_ARG3);
+	}
+
+	dev_dbg(dev, "response: resp[0] = 0x%x, resp[1] = 0x%x, resp[2] = 0x%x, resp[3] = 0x%x\n",
+			cmd->resp[0], cmd->resp[1], cmd->resp[2], cmd->resp[3]);
+}
+
+static inline struct dma_chan *rda_mmc_get_dma_chan(struct rda_mmc_host *priv,
+		struct mmc_data *data)
+{
+	if (data->flags & MMC_DATA_WRITE)
+		return priv->dma_tx;
+	else
+		return priv->dma_rx;
+}
+
+static int rda_mmc_send_data(struct mmc_host *host, struct mmc_data *data)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	struct device *dev = mmc_dev(host);
+	struct dma_slave_config slave_config;
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *chan;
+	int ret;
+
+	if (!data) {
+		dev_err(dev, "No MMC request or data\n");
+		goto fail;
+	}
+
+	if (data->flags & MMC_DATA_WRITE) {
+		slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		slave_config.direction = DMA_MEM_TO_DEV;
+	} else {
+		slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		slave_config.direction = DMA_DEV_TO_MEM;
+	}
+
+	data->sg_count = dma_map_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
+	if (data->sg_count == 0) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	chan = rda_mmc_get_dma_chan(priv, data);
+
+	ret = dmaengine_slave_config(chan, &slave_config);
+	if (ret) {
+		dev_err(dev, "Failed to configure DMAC\n");
+		goto fail_dma;
+	}
+
+	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_count,
+			slave_config.direction, DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(dev, "Failed to allocate DMA descriptor\n");
+		goto fail_dma;
+	}
+
+	priv->dma_cookie = dmaengine_submit(desc);
+	if (!priv->dma_cookie) {
+		dev_err(dev, "Failed to submit DMA request\n");
+		goto fail_dma;
+	}
+
+	dma_async_issue_pending(chan);
+
+	return 0;
+
+fail_dma:
+	dma_unmap_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
+fail:
+	return -EINVAL;
+}
+
+static int rda_mmc_prepare_data(struct mmc_host *host, struct mmc_command *cmd,
+		struct mmc_data *data, u32 *cfg)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	struct device *dev = mmc_dev(host);
+	void __iomem *base = priv->base;
+	int hw_blksz = 2; /* 1 word */
+	int i = 0;
+
+	/* If we're still here, we'll assume there's data ops */
+	*cfg |= SDMMC_CFG_RD_WT_EN;
+
+	/* Tell the controller we have a write operation */
+	if (data->flags & MMC_DATA_WRITE)
+		*cfg |= SDMMC_CFG_RD_WT_SEL;
+
+	/* Multiple data read/write */
+	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
+		*cfg |= SDMMC_CFG_S_M_SEL;
+
+		/*
+		 * Tell the controller to automatically issue CMD12 when the last block
+		 * transfer is completed on non-SDIO cards.
+		 */
+		if (!mmc_card_sdio(host->card))
+			*cfg |= SDMMC_CFG_AUTO_FLAG_EN;
+	}
+
+	/* Blocksize on this IP is calculated by how many words are requested */
+	if (data->blksz > 4) {
+		for (i = 4; i < data->blksz; i <<= 1)
+			hw_blksz++;
+	}
+
+	if (unlikely(hw_blksz > 11)) {
+		dev_err(dev, "Requested %d but hardware can only support 11!\n", hw_blksz);
+		return -EINVAL;
+	}
+
+	writel_relaxed(data->blocks, base + SDMMC_REG_BLOCK_COUNT);
+	writel_relaxed(hw_blksz, base + SDMMC_REG_BLOCK_SIZE);
+
+	return 0;
+}
+
+static int rda_mmc_send_cmd(struct mmc_host *host, struct mmc_command *cmd,
+		struct mmc_data *data)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	void __iomem *base = priv->base;
+	u32 cfg = SDMMC_CFG_SENDCMD;
+	int ret;
+
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_R2:
+		cfg |= SDMMC_CFG_RSP_EN | FIELD_PREP(SDMMC_CFG_RSP_SEL, 2);
+		break;
+	case MMC_RSP_R3:
+		cfg |= SDMMC_CFG_RSP_EN | FIELD_PREP(SDMMC_CFG_RSP_SEL, 1);
+		break;
+	default:
+		cfg |= SDMMC_CFG_RSP_EN;
+		break;
+	}
+
+	/* No data */
+	if (!data)
+		goto send_to_soc;
+
+	/* Data operations */
+	ret = rda_mmc_prepare_data(host, cmd, data, &cfg);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = rda_mmc_send_data(host, data);
+	if (ret < 0)
+		return -EINVAL;
+
+send_to_soc:
+	writel(cmd->opcode, base + SDMMC_REG_CMD_INDEX);
+	writel(cmd->arg, base + SDMMC_REG_CMD_ARG);
+	writel(cfg, base + SDMMC_REG_CONFIG);
+
+	dev_dbg(priv->dev, "mmc_resp_type = %d, cmd->opcode = 0x%x, cmd->arg = 0x%x - cfg: 0x%x\n",
+			mmc_resp_type(cmd), cmd->opcode, cmd->arg, cfg);
+
+	rda_mmc_recv_resp(host, cmd);
+
+	return 0;
+}
+
+/*
+ * Once data transfer failed (or aborted), the controller needs to be
+ * cleaned up.
+ */
+static void rda_mmc_data_abort(struct mmc_host *host, struct mmc_request *mrq)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	struct device *dev = mmc_dev(host);
+	void __iomem *base = priv->base;
+	struct mmc_command stop;
+	int ret;
+
+	writel_relaxed(0, base + SDMMC_REG_BLOCK_COUNT);
+	writel_relaxed(0, base + SDMMC_REG_BLOCK_SIZE);
+
+	if (!host->card)
+		return;
+
+	/*
+	 * Issue a stop command first, because if the controller timed out,
+	 * it'll not return an IRQ or any indicator.
+	 */
+	if (!mmc_card_sdio(host->card)) {
+		if (!mrq->stop) {
+			stop.opcode = MMC_STOP_TRANSMISSION;
+			stop.arg = 0;
+			stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+			ret = rda_mmc_send_cmd(host, &stop, NULL);
+		} else {
+			ret = rda_mmc_send_cmd(host, mrq->stop, NULL);
+		}
+
+		if (ret < 0)
+			dev_err(dev, "Failed to send stop command\n");
+	}
+}
+
+static void rda_mmc_request(struct mmc_host *host, struct mmc_request *req)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	struct device *dev = mmc_dev(host);
+	struct mmc_data *data = NULL;
+	struct dma_chan *chan;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	WARN_ON(priv->mrq);
+	priv->mrq = req;
+
+	if (req->data) {
+		dev_dbg(dev, "Block size = %d - Blocks = %d - Offset: %d - Length: %d\n",
+				req->data->blksz, req->data->blocks,
+				req->data->sg->offset, req->data->sg->length);
+		data = req->data;
+	}
+
+	if (rda_mmc_send_cmd(host, req->cmd, data) < 0) {
+		req->cmd->error = -EINVAL;
+		if (data)
+			req->data->error = -EINVAL;
+
+		goto done_irqunlock;
+	}
+
+	/* Interrupt will pick up on this */
+	if (!data)
+		goto done_irqunlock;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	/*
+	 * On a data operation, we rely on our interrupt to tell us
+	 * when the transmission is finished (or failed).
+	 *
+	 * However with this IP, if the operation timed out, it will
+	 * not trigger an IRQ and we'll not return.
+	 */
+	if (data) {
+		if (wait_for_completion_timeout(&priv->c,
+					msecs_to_jiffies(5000)) == 0) {
+			spin_lock_irqsave(&priv->lock, flags);
+			priv->mrq = NULL;
+
+			dma_unmap_sg(dev, data->sg, data->sg_len,
+					mmc_get_dma_dir(data));
+
+			chan = rda_mmc_get_dma_chan(priv, data);
+
+			dmaengine_terminate_sync(chan);
+			rda_mmc_data_abort(host, req);
+
+			req->cmd->error = -ETIMEDOUT;
+			req->data->error = -ETIMEDOUT;
+			goto done_irqunlock;
+		}
+	}
+
+	return;
+
+done_irqunlock:
+	priv->mrq = NULL;
+	spin_unlock_irqrestore(&priv->lock, flags);
+	mmc_request_done(host, req);
+}
+
+static void rda_mmc_set_ios(struct mmc_host *host, struct mmc_ios *ios)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	struct device *dev = mmc_dev(host);
+	void __iomem *base = priv->base;
+	unsigned long mclk_rate;
+	unsigned int clk_div;
+	unsigned long flags;
+	u32 reg_mclk = 0;
+	int ret;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	if (priv->bus_width != ios->bus_width) {
+		priv->bus_width = ios->bus_width;
+		writel(BIT(priv->bus_width), base + SDMMC_REG_DATA_WIDTH);
+	}
+
+	if (priv->power_mode != ios->power_mode) {
+		priv->power_mode = ios->power_mode;
+		if (priv->power_mode == MMC_POWER_UP) {
+			ret = regulator_enable(priv->vmmc);
+			if (ret)
+				dev_err(dev, "Failed to turn on vmmc\n");
+		} else if (priv->power_mode == MMC_POWER_OFF) {
+			ret = regulator_disable(priv->vmmc);
+			if (ret)
+				dev_err(dev, "Failed to turn off vmmc\n");
+		}
+	}
+
+	if (priv->clock != ios->clock) {
+		priv->clock = ios->clock;
+		if (ios->clock) {
+			/* trans speed  */
+			mclk_rate = clk_get_rate(priv->clk);
+			if (mclk_rate == 0) {
+				dev_err(dev, "Invalid APB clock rate\n");
+				goto bailout;
+			}
+
+			clk_div = mclk_rate / (2 * ios->clock);
+			if (mclk_rate % (2 * ios->clock))
+				clk_div++;
+
+			if (clk_div >= 1)
+				clk_div -= 1;
+
+			if (clk_div > 255)
+				clk_div = 255;
+
+			/* mclk adjust */
+			if (priv->mclk_inv)
+				reg_mclk = SDMMC_MCLK_INVERT;
+
+			reg_mclk |= priv->mclk_adj;
+
+			writel_relaxed(clk_div, base + SDMMC_REG_TRANS_SPEED);
+			writel_relaxed(reg_mclk, base + SDMMC_REG_MCLK_ADJUST);
+
+			dev_dbg(dev, "set clk = %d - mclk = %ld - divider = %d\n",
+					ios->clock, mclk_rate, clk_div);
+		} else {
+			writel_relaxed(SDMMC_MCLK_DISABLE, base + SDMMC_REG_MCLK_ADJUST);
+		}
+	}
+
+bailout:
+	dev_dbg(dev, "buswidth=%d, clock=%d, power=%d\n",
+			ios->bus_width, ios->clock, ios->power_mode);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void rda_mmc_crc_status(struct mmc_host *host)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	struct device *dev = mmc_dev(host);
+	void __iomem *base = priv->base;
+	const char *crc_error;
+	u32 status;
+
+	status = readl_relaxed(base + SDMMC_REG_STATUS);
+
+	switch (FIELD_GET(SDMMC_STATUS_CRC_STATUS, status)) {
+	case 0b101:
+		crc_error = "Transmission Error";
+		break;
+	case 0b010:
+		crc_error = "Transmission Right";
+		break;
+	case 0b111:
+		crc_error = "Flash Programming Error";
+		break;
+	default:
+		crc_error = "Unknown";
+		break;
+	}
+
+	dev_err(dev, "CRC Error: %s - DATA_ERROR: 0x%lx\n", crc_error,
+			FIELD_GET(SDMMC_STATUS_DATA_ERROR, status));
+}
+
+static irqreturn_t rda_mmc_irq(int irq, void *dev_id)
+{
+	struct rda_mmc_host *priv = dev_id;
+	struct mmc_host *host = mmc_from_priv(priv);
+	struct device *dev = mmc_dev(host);
+	void __iomem *base = priv->base;
+	struct mmc_request *mrq;
+	u32 status;
+	irqreturn_t irqret = IRQ_NONE;
+
+	status = readl(base + SDMMC_REG_INT_STATUS);
+	writel((status & 0xFF), base + SDMMC_REG_INT_CLEAR);
+
+	dev_dbg(dev, "IRQ requested - status: 0x%x\n", status);
+
+	if (!priv->mrq || !priv->mrq->data)
+		goto irq_done;
+
+	mrq = priv->mrq;
+
+	if (mrq->data && ((status & SDMMC_INT_RD_ERR) || (status & SDMMC_INT_WR_ERR)))
+		mrq->data->error = -EILSEQ;
+
+	if (priv->sdio_irq && (status & SDMMC_INT_SDIO))
+		priv->sdio_irq_trigger = true;
+
+	irqret = IRQ_WAKE_THREAD;
+
+	/* We got an error, no need to do the additional checks */
+	if (mrq->data->error)
+		goto irq_done;
+
+	/*
+	 * If we don't have any error but DAT_OVER isn't triggered, then we'll assume
+	 * that we got an unexpected IRQ (during a data transfer)
+	 */
+	if (!mrq->data->error && !(status & SDMMC_INT_DAT_OVER))
+		irqret = IRQ_HANDLED;
+
+irq_done:
+	if (irqret == IRQ_NONE)
+		dev_info(dev,
+			"Unexpected IRQ - was a data transfer requested? IRQ: 0x%x\n", status);
+
+	return irqret;
+}
+
+static irqreturn_t rda_mmc_irq_fn(int irq, void *dev_id)
+{
+	struct rda_mmc_host *priv = dev_id;
+	struct mmc_host *host = mmc_from_priv(priv);
+	struct device *dev = mmc_dev(host);
+	struct mmc_request *mrq;
+	struct dma_chan *chan;
+	struct dma_tx_state state;
+	enum dma_status dma_status;
+	unsigned long flags;
+
+	if (WARN_ON(!priv->mrq))
+		return IRQ_NONE;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	mrq = priv->mrq;
+
+	if (mrq->data) {
+		chan = rda_mmc_get_dma_chan(priv, mrq->data);
+
+		if (mrq->data->error) {
+			mrq->data->bytes_xfered = 0;
+			rda_mmc_crc_status(host);
+			dmaengine_terminate_sync(chan);
+			rda_mmc_data_abort(host, mrq);
+		} else {
+			mrq->data->bytes_xfered =
+				mrq->data->blocks * mrq->data->blksz;
+
+			/*
+			 * With this IP, just because a TXDMA/RXDMA interrupt is triggered,
+			 * doesn't mean the MMC is fully processed.
+			 */
+			dma_status = dmaengine_tx_status(chan, priv->dma_cookie, &state);
+			dev_dbg(mmc_dev(host), "DMA Status: %d\n", dma_status);
+			if (dma_status != DMA_COMPLETE) {
+				dev_err(dev, "Transmit IRQ triggered but DMA is not finished\n");
+				mrq->data->error = -ETIMEDOUT;
+				mrq->data->bytes_xfered = 0;
+				dmaengine_terminate_sync(chan);
+				rda_mmc_data_abort(host, mrq);
+			}
+		}
+
+		/*
+		 * Since we told the controller to automatically send a stop command,
+		 * we don't have to send a stop command here.
+		 */
+		dma_unmap_sg(dev, mrq->data->sg, mrq->data->sg_len,
+				mmc_get_dma_dir(mrq->data));
+		dmaengine_terminate_sync(chan);
+	}
+
+	priv->mrq = NULL;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	complete(&priv->c);
+	mmc_request_done(host, mrq);
+
+	if (priv->sdio_irq && priv->sdio_irq_trigger)
+		mmc_signal_sdio_irq(host);
+
+	return IRQ_HANDLED;
+}
+
+static int rda_mmc_card_busy(struct mmc_host *host)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	void __iomem *base = priv->base;
+	u32 status = readl(base + SDMMC_REG_STATUS);
+
+	return (status & SDMMC_STATUS_DLBUSY);
+}
+
+static void rda_mmc_sdio_enable_irq(struct mmc_host *host, int enable)
+{
+	struct rda_mmc_host *priv = mmc_priv(host);
+	void __iomem *base = priv->base;
+	u32 intmask = readl(base + SDMMC_REG_INT_MASK);
+
+	if (enable) {
+		intmask |= SDMMC_INT_SDIO;
+		priv->sdio_irq = true;
+	} else {
+		intmask &= ~SDMMC_INT_SDIO;
+		priv->sdio_irq = false;
+	}
+
+	priv->sdio_irq_trigger = false;
+
+	writel(intmask, base + SDMMC_REG_INT_MASK);
+}
+
+static const struct mmc_host_ops rda_mmc_ops = {
+	.request = rda_mmc_request,
+	.set_ios = rda_mmc_set_ios,
+	.get_cd = mmc_gpio_get_cd,
+	.get_ro = mmc_gpio_get_ro,
+	.card_busy = rda_mmc_card_busy,
+	.enable_sdio_irq = rda_mmc_sdio_enable_irq,
+};
+
+static void rda_mmc_of_parse(struct device_node *np, struct rda_mmc_host *priv)
+{
+	bool mclk_inv = false;
+	u8 mclk_adj = 1;
+
+	if (of_property_present(np, "rda,mclk-inv"))
+		mclk_inv = true;
+
+	of_property_read_u8(np, "rda,mclk-adj", &mclk_adj);
+
+	priv->mclk_inv = mclk_inv;
+	priv->mclk_adj = mclk_adj;
+}
+
+static int rda_mmc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rda_mmc_host *priv;
+	struct mmc_host *mmc;
+	struct clk *clk;
+	struct reset_control *reset;
+	struct dma_chan *tx, *rx;
+	struct regulator *vmmc;
+	void __iomem *base;
+	int irq;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "Cannot get iomap\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Cannot get IRQ: %d\n", irq);
+
+	clk = devm_clk_get_enabled(dev, "apb");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock device\n");
+
+	vmmc = devm_regulator_get(dev, "vmmc");
+	if (IS_ERR(vmmc))
+		return dev_err_probe(dev, PTR_ERR(vmmc), "Failed to obtain regulator\n");
+
+	reset = devm_reset_control_get_by_index(dev, 0);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset), "Failed to obtain reset\n");
+
+	tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(tx))
+		return dev_err_probe(dev, PTR_ERR(tx), "Failed to request tx channel\n");
+
+	rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(rx))
+		return dev_err_probe(dev, PTR_ERR(rx), "Failed to request rx channel\n");
+
+	mmc = devm_mmc_alloc_host(dev, sizeof(*priv));
+	if (IS_ERR(mmc)) {
+		dev_err(dev, "Cannot allocate memory for MMC\n");
+		ret = PTR_ERR(mmc);
+		goto fail_release_dma;
+	}
+
+	priv = mmc_priv(mmc);
+	priv->dev = dev;
+	priv->base = base;
+	priv->irq = irq;
+	priv->clk = clk;
+	priv->reset = reset;
+	priv->dma_tx = tx;
+	priv->dma_rx = rx;
+	priv->vmmc = vmmc;
+	spin_lock_init(&priv->lock);
+	init_completion(&priv->c);
+
+	mmc->ops = &rda_mmc_ops;
+
+	mmc->max_segs = 1;
+	mmc->max_blk_size = 4096;
+	mmc->max_blk_count = 0xFFFF;
+	mmc->max_req_size = 0xFFFF;
+	mmc->max_seg_size = 0xFFFF;
+
+	mmc->f_min = 1000000;
+	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+
+	rda_mmc_of_parse(dev->of_node, priv);
+
+	ret = mmc_of_parse(mmc);
+	if (ret) {
+		dev_err(dev, "Failed to parse device tree: %d\n", ret);
+		goto fail_release_dma;
+	}
+
+	rda_mmc_reset(priv);
+	rda_mmc_hw_init(priv);
+
+	priv->bus_width = -1;
+
+	ret = devm_request_threaded_irq(dev, irq, rda_mmc_irq, rda_mmc_irq_fn,
+			IRQF_ONESHOT, mmc_hostname(mmc), priv);
+	if (ret) {
+		dev_err(dev, "Failed to request IRQ: %d\n", ret);
+		goto fail_release_dma;
+	}
+
+	ret = mmc_add_host(mmc);
+	if (ret) {
+		dev_err(dev, "Failed to add MMC host: %d\n", ret);
+		goto fail_release_dma;
+	}
+
+	platform_set_drvdata(pdev, mmc);
+	return 0;
+
+fail_release_dma:
+	dma_release_channel(rx);
+	dma_release_channel(tx);
+	return ret;
+}
+
+static void rda_mmc_remove(struct platform_device *pdev)
+{
+	struct rda_mmc_host *host = platform_get_drvdata(pdev);
+
+	mmc_remove_host(host->mmc);
+	dma_release_channel(host->dma_rx);
+	dma_release_channel(host->dma_tx);
+}
+
+static const struct of_device_id rda_mmc_dt_ids[] = {
+	{ .compatible = "rda,8810pl-mmc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rda_mmc_dt_ids);
+
+static struct platform_driver rda_mmc_driver = {
+	.probe		= rda_mmc_probe,
+	.remove		= rda_mmc_remove,
+	.driver		= {
+		.name	= "rda-mmc",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = rda_mmc_dt_ids,
+	},
+};
+module_platform_driver(rda_mmc_driver);
+
+MODULE_AUTHOR("Dang Huynh <dang.huynh@mainlining.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MMC/SD driver for RDA platform");
+MODULE_ALIAS("platform:rda-mmc");

-- 
2.51.0



