Return-Path: <dmaengine+bounces-6653-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48982B868F0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F173E165C4F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD93002B4;
	Thu, 18 Sep 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0hKYFdK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38502D94B4;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221398; cv=none; b=mPx3ujCNr+CUz9NISn6rUuR6U+E+uSJqFeWDbgrUMT6JJNaPTxNe3ekT9IE28GlPem+D8NDqvFNOd95tTavaVp2Sbew6PSJHGnoS0z/4Sl6LcEFDQ0/C1LE7u83vYWwwOhhegCjOPvBBVbFph8Kg7IrMBZyks3mZ4zuDqpuQFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221398; c=relaxed/simple;
	bh=yNTiQno8EMpzb+4TM3qaxKc6MHmeWetWrmZsuenD5aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWvsf61mw2Z3AGdUNuYWRkNXK+Cx3ZWuB4NAHq/FON0Sr3R5NY5KEbaUKalYIuyQJJhP3/aaM7R5BsSQzUuzl4CC8xy1kmm8K8q9SxnjCZbOZ4R/WdW4QRTPazTOF9mPBGo5szqO5F1X/R5AN9OPw0eNUWSA3jRFosvGcUpYQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0hKYFdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CF80C2BCB1;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221398;
	bh=yNTiQno8EMpzb+4TM3qaxKc6MHmeWetWrmZsuenD5aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c0hKYFdKYKhSlSu/I2sX0hLtIQIIsv/JUCHqpRVYHyIsi03GqQM0MlY2LFU5TIFpA
	 +cugHeUTemcLhwdjTdXLh0qZ20QB1yk1lHhOYJ2Y4lxAv4v0QffDS3Xjunc98afWnw
	 OKl2s7qdmgShl3MO/ml6O8vzLkDZsuewM0OkOtBFntmzSVNmm4f1/+9l7HtWGtFnUY
	 g/BInG5hYatbk2x8UnU9Z4qSFLhQyV3iLFn4K7FPKWv9K65Kwet1ofirh3vRPdIV8O
	 AI+B7RS97WjL2+cxlKc2+ZbnUK7nk5d7XrV8Acs47G0s4EX7Uhsnt33Wyg/+Je9Z8F
	 ImBBppn3rUkOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523E6CAC597;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Fri, 19 Sep 2025 01:48:48 +0700
Subject: [PATCH 08/10] dmaengine: Add RDA IFC driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-rda8810pl-mmc-v1-8-d4f08a05ba4d@mainlining.org>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758221395; l=14920;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=iJgPtPu12ozNppbSOcC9VU0IgABxZvXIWrb3FjIHPOU=;
 b=lUwSgTrYVqNWGOWIoc6XEBBlk+WCXq6r/3mzPM/qenzyQUwim9Yr5n6xtUTj2/b51cSnAYmHj
 Q93fr5lCj5RDF0Y0UqIpdWkaFnp87yqHf1VKOvwUzMFSvTwi4advmjX
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

IFC stands for Intelligent Flow Control, a scatter/gather DMA
controller.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 MAINTAINERS           |   6 +
 drivers/dma/Kconfig   |  10 ++
 drivers/dma/Makefile  |   1 +
 drivers/dma/rda-ifc.c | 450 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 467 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56f9d19fbf421eefffe554987e14604c764daab2..923101a9d6c2edea339d1211b1cfdf4b917d1208 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21424,6 +21424,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
 F:	drivers/clk/rda/clk-rda8810.c
 
+RDA MICRO INTELLIGENT FLOW CONTROLLER DRIVER
+M:	Dang Huynh <dang.huynh@mainlining.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/rda,ifc.yaml
+F:	drivers/dma/rda-ifc.c
+
 RDACM20 Camera Sensor
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b8a74b1798ba1d44b26553990428c065de6fc535..b6b94cb053bd0d6a15d3c603bfab9b515020fad8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -571,6 +571,16 @@ config PLX_DMA
 	  These are exposed via extra functions on the switch's
 	  upstream port. Each function exposes one DMA channel.
 
+config RDA_IFC
+	bool "RDA IFC support"
+	depends on ARCH_RDA || COMPILE_TEST
+	select DMA_ENGINE
+	help
+	  Support RDA Intelligent Flow Controller for RDA Micro SoC.
+	  The Intelligent Flow Controller is a scatter/gather DMA controller.
+
+	  If unsure, say N.
+
 config SOPHGO_CV1800B_DMAMUX
 	tristate "Sophgo CV1800/SG2000 series SoC DMA multiplexer support"
 	depends on MFD_SYSCON
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a54d7688392b1a0e956fa5d23633507f52f017d9..40f6c61dcce739f3ffd064fbdc23388cfca83184 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_PL330_DMA) += pl330.o
 obj-$(CONFIG_PLX_DMA) += plx_dma.o
 obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
 obj-$(CONFIG_PXA_DMA) += pxa_dma.o
+obj-$(CONFIG_RDA_IFC) += rda-ifc.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SF_PDMA) += sf-pdma/
 obj-$(CONFIG_SOPHGO_CV1800B_DMAMUX) += cv1800b-dmamux.o
diff --git a/drivers/dma/rda-ifc.c b/drivers/dma/rda-ifc.c
new file mode 100644
index 0000000000000000000000000000000000000000..ff7f59876a5895fbdc1adf584e11519bcfcfdb11
--- /dev/null
+++ b/drivers/dma/rda-ifc.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RDA Micro Intelligent Flow Controller
+ *
+ * Copyright (C) 2013 RDA Microelectronics Inc.
+ * Copyright (C) 2025 Dang Huynh <dang.huynh@mainlining.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/scatterlist.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include "dmaengine.h"
+
+#include <dt-bindings/dma/rda-ifc.h>
+
+/* Registers */
+#define IFC_REG_GET_CH 0x0
+#define IFC_REG_DMA_STATUS 0x4
+#define IFC_REG_DEBUG_STATUS 0x8
+
+/* Channel registers */
+#define IFC_REG_SG_CONTROL 0x0
+#define IFC_REG_SG_STATUS 0x4
+#define IFC_REG_SG_START_ADDR 0x8
+#define IFC_REG_SG_TC 0xC
+
+#define IFC_REG_CH_RFSPI_CONTROL 0x80
+#define IFC_REG_CH_RFSPI_STATUS 0x84
+#define IFC_REG_CH_RFSPI_START_ADDR 0x88
+#define IFC_REG_CH_RFSPI_END_ADDR 0x8C
+#define IFC_REG_CH_RFSPI_TC 0x90
+
+/* Bits */
+/* DMA_STATUS */
+#define IFC_DMA_CH_ENABLE GENMASK(8, 0)
+#define IFC_DMA_CH_BUSY GENMASK(23, 16)
+/* DEBUG_STATUS */
+#define IFC_DBG_STATUS BIT(0)
+/* CONTROL */
+#define IFC_CTL_ENABLE BIT(0)
+#define IFC_CTL_DISABLE BIT(1)
+#define IFC_CTL_CH_RD_HW_EXCH BIT(2)
+#define IFC_CTL_CH_WR_HW_EXCH BIT(3)
+#define IFC_CTL_AUTODISABLE BIT(4)
+#define IFC_CTL_SIZE GENMASK(7, 5) /* byte: 0 - halfword: 1 - word: 2 */
+#define IFC_CTL_REQ_SRC GENMASK(15, 8)
+#define IFC_CTL_FLUSH BIT(16)
+#define IFC_CTL_SG_NUM GENMASK(24, 17)
+/* STATUS */
+#define IFC_STATUS_ENABLE BIT(0)
+#define IFC_STATUS_FIFO_EMPTY BIT(4)
+
+/*
+ * An available IFC channel can be obtained by reading IFC_REG_GET_CH register,
+ * if no channel are available the register reads 0xF.
+ *
+ * Memory map for each channel (starts at 0x10):
+ *
+ * [IFC_REG_SG_CONTROL]
+ * [IFC_REG_SG_STATUS]
+ * [IFC_REG_SG_START_ADDR] (1st sg_table)
+ * [IFC_REG_SG_TC]
+ * ...
+ *
+ * Depends on the hardware, it might support more than one sg table. If it
+ * does, the next sg table is right next to previous table.
+ *
+ * The next channel is right after the memory map above.
+ *
+ * The DMA channel MUST be disabled after the transaction is done or some IP
+ * might misbehaves.
+ */
+
+struct rda_ifc_chan {
+	struct rda_ifc *rda_ifc;
+	void __iomem *chan_base;
+	spinlock_t lock;
+
+	struct dma_chan chan;
+	unsigned int request_id;
+
+	enum dma_transfer_direction direction;
+	struct dma_slave_config sconfig;
+	struct dma_async_tx_descriptor tx;
+};
+
+struct rda_ifc {
+	struct device *dev;
+	void __iomem *base;
+
+	struct dma_device ddev;
+
+	int sg_max;
+	int max_chan;
+	struct rda_ifc_chan channels[] __counted_by(max_chan);
+};
+
+struct rda_ifc_platinfo {
+	int sg_max;
+	int std_channb;
+};
+
+static struct rda_ifc_chan *to_ifc_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct rda_ifc_chan, chan);
+}
+
+static int rda_ifc_device_config(struct dma_chan *chan, struct dma_slave_config *config)
+{
+	struct rda_ifc_chan *ifc_chan = to_ifc_chan(chan);
+
+	ifc_chan->direction = (ifc_chan->request_id & 1) ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
+	memcpy(&ifc_chan->sconfig, config, sizeof(*config));
+
+	return 0;
+}
+
+static void rda_ifc_issue_pending(struct dma_chan *chan)
+{
+	struct rda_ifc_chan *ifc_chan = to_ifc_chan(chan);
+	unsigned long flags;
+	u32 control;
+
+	spin_lock_irqsave(&ifc_chan->lock, flags);
+
+	control = readl(ifc_chan->chan_base);
+	control |= IFC_CTL_ENABLE;
+	writel(control, ifc_chan->chan_base);
+
+	spin_unlock_irqrestore(&ifc_chan->lock, flags);
+}
+
+static dma_cookie_t rda_ifc_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	return dma_cookie_assign(tx);
+}
+
+static struct dma_async_tx_descriptor *rda_ifc_prep_slave_sg(struct dma_chan *chan,
+		struct scatterlist *sgl, unsigned int sg_len,
+		enum dma_transfer_direction direction, unsigned long dma_flags,
+		void *context)
+{
+	struct rda_ifc_chan *ifc_chan = to_ifc_chan(chan);
+	struct rda_ifc *ifc = ifc_chan->rda_ifc;
+	struct device *dev = dmaengine_get_dma_device(chan);
+	struct scatterlist *sg;
+	unsigned long flags;
+	u32 control = 0;
+	int width;
+	int i;
+
+	if (sg_len > ifc->sg_max) {
+		dev_err(dev, "sg_len %d overflowed (max sg %d)\n",
+				sg_len, ifc->sg_max);
+		return NULL;
+	}
+
+	if (direction != ifc_chan->direction) {
+		dev_err(dev, "Inconsistent transfer direction\n");
+		return NULL;
+	}
+
+	spin_lock_irqsave(&ifc_chan->lock, flags);
+
+	if (ifc_chan->direction == DMA_DEV_TO_MEM)
+		width = ifc_chan->sconfig.src_addr_width;
+	else
+		width = ifc_chan->sconfig.dst_addr_width;
+
+	switch (width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		control |= FIELD_PREP(IFC_CTL_SIZE, 0);
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		control |= FIELD_PREP(IFC_CTL_SIZE, 1);
+		break;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		control |= FIELD_PREP(IFC_CTL_SIZE, 2);
+		break;
+	default:
+		return NULL;
+	}
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		if (!IS_ALIGNED(sg_dma_address(sg), width)) {
+			dev_err(dev, "Unaligned DMA address\n");
+			spin_unlock_irqrestore(&ifc_chan->lock, flags);
+			return NULL;
+		}
+
+		writel(sg_dma_address(sg), ifc_chan->chan_base + IFC_REG_SG_START_ADDR + (8 * i));
+		writel(sg_dma_len(sg), ifc_chan->chan_base + IFC_REG_SG_TC + (8 * i));
+	}
+
+	control |= FIELD_PREP(IFC_CTL_REQ_SRC, ifc_chan->request_id) |
+		IFC_CTL_CH_RD_HW_EXCH |
+		FIELD_PREP(IFC_CTL_SG_NUM, sg_len-1);
+	writel(control, ifc_chan->chan_base);
+
+	spin_unlock_irqrestore(&ifc_chan->lock, flags);
+
+	dma_async_tx_descriptor_init(&ifc_chan->tx, chan);
+	ifc_chan->tx.tx_submit = rda_ifc_tx_submit;
+
+	return &ifc_chan->tx;
+}
+
+static enum dma_status rda_ifc_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
+		struct dma_tx_state *tx_state)
+{
+	struct rda_ifc_chan *ifc_chan = to_ifc_chan(chan);
+	enum dma_status dmaret;
+	unsigned long flags;
+	u32 status;
+	int residue = 0;
+	int tmp_residue = 0;
+	int i;
+
+	dmaret = dma_cookie_status(chan, cookie, tx_state);
+	if (!tx_state || (dmaret == DMA_COMPLETE))
+		return dmaret;
+
+	spin_lock_irqsave(&ifc_chan->lock, flags);
+
+	status = readl(ifc_chan->chan_base + 4);
+
+	if (status & IFC_STATUS_FIFO_EMPTY)
+		dmaret = DMA_COMPLETE;
+	else
+		dmaret = DMA_IN_PROGRESS;
+
+	if (dmaret == DMA_IN_PROGRESS) {
+		/* gather residue from all sg */
+		for (i = 0; i < ifc_chan->rda_ifc->sg_max; i++) {
+			tmp_residue = readl(ifc_chan->chan_base + 12 + (8 * i));
+			residue += tmp_residue;
+		}
+
+		dma_set_residue(tx_state, residue);
+	}
+
+	spin_unlock_irqrestore(&ifc_chan->lock, flags);
+
+	return dmaret;
+}
+
+static int rda_ifc_terminate_all(struct dma_chan *chan)
+{
+	struct rda_ifc_chan *ifc_chan = to_ifc_chan(chan);
+	struct device *dev = dmaengine_get_dma_device(chan);
+	unsigned long flags;
+	u32 status, control;
+	int ret;
+	int i;
+
+	spin_lock_irqsave(&ifc_chan->lock, flags);
+
+	status = readl(ifc_chan->chan_base + 4);
+
+	/* Flush operation only supports read requests */
+	if (ifc_chan->direction == DMA_DEV_TO_MEM) {
+		if (status & IFC_STATUS_FIFO_EMPTY)
+			goto clear_chan;
+
+		control = readl(ifc_chan->chan_base);
+		control |= IFC_CTL_FLUSH;
+		writel(control, ifc_chan->chan_base);
+
+		ret = readl_poll_timeout(ifc_chan->chan_base + 4, status,
+				(status & IFC_STATUS_FIFO_EMPTY), 100, 1000*1000);
+		if (ret < 0)
+			dev_err(dev, "Timed out flushing FIFO\n");
+	}
+
+clear_chan:
+	control = readl(ifc_chan->chan_base);
+	control |= IFC_CTL_DISABLE;
+	writel(control, ifc_chan->chan_base);
+
+	for (i = 0; i < ifc_chan->rda_ifc->sg_max; i++)
+		writel(0, ifc_chan->chan_base + 12 + (8 * i));
+
+	spin_unlock_irqrestore(&ifc_chan->lock, flags);
+	return 0;
+}
+
+static int rda_ifc_chan_init(struct rda_ifc *ifc, struct dma_device *ddev,
+		int id)
+{
+	struct rda_ifc_chan *chan = &ifc->channels[id];
+
+	spin_lock_init(&chan->lock);
+	chan->rda_ifc = ifc;
+	chan->chan.chan_id = id;
+	chan->chan.device = &ifc->ddev;
+	chan->chan_base = ifc->base + 0x10 + (id * (8 + (8 * ifc->sg_max)));
+
+	list_add_tail(&chan->chan.device_node, &ddev->channels);
+	return 0;
+}
+
+static int rda_ifc_ddev_init(struct rda_ifc *ifc, struct dma_device *ddev)
+{
+	int ret;
+	int i;
+
+	dma_cap_zero(ddev->cap_mask);
+	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
+	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
+
+	/* IFC maximum segment size is 32 MB */
+	dma_set_max_seg_size(ddev->dev, 0x1FFFFFF);
+	dma_set_mask_and_coherent(ddev->dev, DMA_BIT_MASK(32));
+
+	/* IFC supports 8-bit and 32-bit transfers */
+	ddev->copy_align = DMAENGINE_ALIGN_4_BYTES;
+	ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+		BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+		BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
+
+	ddev->device_config = rda_ifc_device_config;
+	ddev->device_issue_pending = rda_ifc_issue_pending;
+	ddev->device_prep_slave_sg = rda_ifc_prep_slave_sg;
+	ddev->device_terminate_all = rda_ifc_terminate_all;
+	ddev->device_tx_status = rda_ifc_tx_status;
+	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	INIT_LIST_HEAD(&ddev->channels);
+	for (i = 0; i < ifc->max_chan; i++) {
+		ret = rda_ifc_chan_init(ifc, ddev, i);
+		if (ret)
+			return ret;
+	}
+	ddev->chancnt = i;
+
+	return 0;
+}
+
+static struct dma_chan *rda_ifc_xlate(struct of_phandle_args *dma_spec,
+		struct of_dma *of_dma)
+{
+	struct rda_ifc *ifc = of_dma->of_dma_data;
+	struct rda_ifc_chan *ifc_chan;
+	struct dma_chan *chan;
+	unsigned int request;
+
+	if (dma_spec->args_count != 1)
+		return NULL;
+
+	request = dma_spec->args[0];
+	if (request >= IFC_NO_REQUEST)
+		return NULL;
+
+	chan = dma_get_any_slave_channel(&ifc->ddev);
+	if (!chan)
+		return NULL;
+
+	ifc_chan = to_ifc_chan(chan);
+	ifc_chan->request_id = request;
+
+	return chan;
+}
+
+static int rda_ifc_probe(struct platform_device *pdev)
+{
+	const struct rda_ifc_platinfo *platinfo;
+	struct rda_ifc *ifc;
+	struct dma_device *ddev;
+	int ret;
+
+	platinfo = of_device_get_match_data(&pdev->dev);
+	if (!platinfo)
+		return -EINVAL;
+
+	ifc = devm_kzalloc(&pdev->dev,
+			struct_size(ifc, channels, platinfo->std_channb),
+			GFP_KERNEL);
+	if (!ifc)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allocate memory\n");
+
+	ifc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ifc->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ifc->base), "Cannot get base address\n");
+
+	ifc->max_chan = platinfo->std_channb;
+	ifc->sg_max = platinfo->sg_max;
+
+	ddev = &ifc->ddev;
+	ddev->dev = &pdev->dev;
+	ret = rda_ifc_ddev_init(ifc, ddev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, ifc);
+
+	ret = dma_async_device_register(ddev);
+	if (ret)
+		return ret;
+
+	ret = of_dma_controller_register(pdev->dev.of_node, rda_ifc_xlate, ifc);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Cannot register DMA controller\n");
+
+	return 0;
+}
+
+static void rda_ifc_remove(struct platform_device *pdev)
+{
+	struct rda_ifc *ifc = platform_get_drvdata(pdev);
+
+	dma_async_device_unregister(&ifc->ddev);
+	of_dma_controller_free(pdev->dev.of_node);
+}
+
+static const struct rda_ifc_platinfo rda8810pl_data = {
+	.sg_max = 1,
+	.std_channb = 7
+};
+
+static const struct of_device_id rda_ifc_of_match[] = {
+	{ .compatible = "rda,8810pl-ifc", .data = &rda8810pl_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rda_ifc_of_match);
+
+static struct platform_driver rda_ifc_driver = {
+	.probe = rda_ifc_probe,
+	.remove = rda_ifc_remove,
+	.driver = {
+		.name = "rda-ifc",
+		.of_match_table = rda_ifc_of_match,
+	},
+};
+module_platform_driver(rda_ifc_driver);
+
+MODULE_AUTHOR("Dang Huynh <dang.huynh@mainlining.org>");
+MODULE_DESCRIPTION("RDA IFC driver");
+MODULE_LICENSE("GPL");

-- 
2.51.0



