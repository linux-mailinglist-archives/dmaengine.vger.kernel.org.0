Return-Path: <dmaengine+bounces-7645-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 889D7CC18E8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 09:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F68F30122C2
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD5348469;
	Tue, 16 Dec 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgPDpyWz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A2348456;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872202; cv=none; b=IZSkdsyYCpZXjocAQrdVBG+w0xNeDM1+ZRIe3Chp7SjcyrlosBVtFg+2xAGG9FtUHq5rnHrT8P1wu1sbV9VptaZZb0L69256m8BI9+EskIcHB8PrYyxDqGAYafDJVz5NTZ6PL7ZXjFZSeySe7bTs+z+ZYGEicDyo6JClkTtOlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872202; c=relaxed/simple;
	bh=13Iow72BE0Dh5vPaSgEuZSob4H4qkGWNZ+Fa/Y5tZZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fx870ogjS1vRpTlX4wDKym8M1AUB/EKqd92iZu1oe1MDBc78U4Zs/iXkXC9r0eaTvom1WoqJx3J/W650YP4AGqTWcXqDuEQGPlolOwwF6Ev/waTFbPER1QDILn4s7IRVQVI4t5+0rAvJmoZZZJoVWqHk/Z48mCIakrwOC5dlNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgPDpyWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 594FCC113D0;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872201;
	bh=13Iow72BE0Dh5vPaSgEuZSob4H4qkGWNZ+Fa/Y5tZZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZgPDpyWz23sRjPMlIrUt2Os89OGD8FTsJ/7IN6T9TGiNdD8AK3U+NjOnD7cEHre7f
	 yRvuXK1EXySBW/Oxw8pmMBjRgMz+XfAAArTUzDVzXnBaCjajdhW/1oxCDHHgFGi1UY
	 9TJMSEXYjurWYa4p+2fU1PJ7u/Teat2Yrgqnlmc6fCR06mdlSczBnMTR+wgu492voz
	 CX3XYa+G/dHUMUwO8uogpKzUJYhMfFMqe3NhMBPRCubliJ79+LvHS6015iWE7shjwX
	 9pK/rGaFmmyR9osaZLfQ3QbWn56lOFH6awJFuY8PnUeqcOJ8NkwsI/+pqptuJYhSZ+
	 ra0y1fmCGTnNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B3BD5B16C;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 16 Dec 2025 08:03:18 +0000
Subject: [PATCH 2/3] dma: amlogic: Add general DMA driver for SoCs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-amlogic-dma-v1-2-e289e57e96a7@amlogic.com>
References: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
In-Reply-To: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765872198; l=19175;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=5z0UO9EA2klunxl5LHlWYHBSMIh8pOWVjCJDpy+YMcM=;
 b=/gyWo6V1AlVUrWmq01HP+8cgs+s/HyzsLb5rIP26Z5JfSvgySOkBueFXsW53JesFbGUnEnIKN
 BVArxJpu3c0CQ5KyDYIMjY6xNu4VhNp+iAwEV9ARGXl2N3vl0wmvzFq
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic SoCs include a general-purpose DMA controller that can be used
by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
is associated with a dedicated DMA channel in hardware.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/dma/Kconfig       |   8 +
 drivers/dma/Makefile      |   1 +
 drivers/dma/amlogic-dma.c | 567 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 576 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8bb0a119ecd4..fc7f70e22c22 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -85,6 +85,14 @@ config AMCC_PPC440SPE_ADMA
 	help
 	  Enable support for the AMCC PPC440SPe RAID engines.
 
+config AMLOGIC_DMA
+	tristate "Amlogic genneral DMA support"
+	depends on ARCH_MESON
+	select DMA_ENGINE
+	select REGMAP_MMIO
+	help
+	  Enable support for the Amlogic general DMA engines.
+
 config APPLE_ADMAC
 	tristate "Apple ADMAC support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a54d7688392b..fc28dade5b69 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
 obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
+obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
 obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
 obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
new file mode 100644
index 000000000000..40099002d558
--- /dev/null
+++ b/drivers/dma/amlogic-dma.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2025 Amlogic, Inc. All rights reserved
+ * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
+ */
+
+#include <linux/init.h>
+#include <linux/bitfield.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/list.h>
+#include <linux/regmap.h>
+#include <asm/irq.h>
+#include "dmaengine.h"
+
+#define RCH_REG_BASE		0x0
+#define WCH_REG_BASE		0x2000
+/*
+ * Each rch (read from memory) REG offset  Rch_offset 0x0 each channel total 0x40
+ * rch addr = DMA_base + Rch_offset+ chan_id * 0x40 + reg_offset
+ */
+#define RCH_READY		0x0
+#define RCH_STATUS		0x4
+#define RCH_CFG			0x8
+#define CFG_CLEAR		BIT(25)
+#define CFG_PAUSE		BIT(26)
+#define CFG_ENABLE		BIT(27)
+#define CFG_DONE		BIT(28)
+#define RCH_ADDR		0xc
+#define RCH_LEN			0x10
+#define RCH_RD_LEN		0x14
+#define RCH_PRT			0x18
+#define RCH_SYCN_STAT		0x1c
+#define RCH_ADDR_LOW		0x20
+#define RCH_ADDR_HIGH		0x24
+/* if work on 64, it work with RCH_PRT */
+#define RCH_PTR_HIGH		0x28
+
+/*
+ * Each wch (write to memory) REG offset  Wch_offset 0x2000 each channel total 0x40
+ * wch addr = DMA_base + Wch_offset+ chan_id * 0x40 + reg_offset
+ */
+#define WCH_READY		0x0
+#define WCH_TOTAL_LEN		0x4
+#define WCH_CFG			0x8
+#define WCH_ADDR		0xc
+#define WCH_LEN			0x10
+#define WCH_RD_LEN		0x14
+#define WCH_PRT			0x18
+#define WCH_CMD_CNT		0x1c
+#define WCH_ADDR_LOW		0x20
+#define WCH_ADDR_HIGH		0x24
+/* if work on 64, it work with RCH_PRT */
+#define WCH_PTR_HIGH		0x28
+
+/* DMA controller reg */
+#define RCH_INT_MASK		0x1000
+#define WCH_INT_MASK		0x1004
+#define CLEAR_W_BATCH		0x1014
+#define CLEAR_RCH		0x1024
+#define CLEAR_WCH		0x1028
+#define RCH_ACTIVE		0x1038
+#define WCH_ACTIVE		0x103C
+#define RCH_DONE		0x104C
+#define WCH_DONE		0x1050
+#define RCH_ERR			0x1060
+#define RCH_LEN_ERR		0x1064
+#define WCH_ERR			0x1068
+#define DMA_BATCH_END		0x1078
+#define WCH_EOC_DONE		0x1088
+#define WDMA_RESP_ERR		0x1098
+#define UPT_PKT_SYNC		0x10A8
+#define RCHN_CFG		0x10AC
+#define WCHN_CFG		0x10B0
+#define MEM_PD_CFG		0x10B4
+#define MEM_BUS_CFG		0x10B8
+#define DMA_GMV_CFG		0x10BC
+#define DMA_GMR_CFG		0x10C0
+
+#define DMA_MAX_LINK		8
+#define MAX_CHAN_ID		32
+#define SG_MAX_LEN		((1 << 27) - 1)
+
+struct aml_dma_sg_link {
+#define LINK_LEN		GENMASK(26, 0)
+#define LINK_IRQ		BIT(27)
+#define LINK_EOC		BIT(28)
+#define LINK_LOOP		BIT(29)
+#define LINK_ERR		BIT(30)
+#define LINK_OWNER		BIT(31)
+	u32 ctl;
+	u64 address;
+	u32 revered;
+} __packed;
+
+struct aml_dma_chan {
+	struct dma_chan			chan;
+	struct dma_async_tx_descriptor	desc;
+	struct aml_dma_dev		*aml_dma;
+	struct aml_dma_sg_link		*sg_link;
+	dma_addr_t			sg_link_phys;
+	int				sg_link_cnt;
+	int				data_len;
+	enum dma_status			status;
+	enum dma_transfer_direction	direction;
+	int				chan_id;
+	/* reg_base (direction + chan_id) */
+	int				reg_offs;
+};
+
+struct aml_dma_dev {
+	struct dma_device		dma_device;
+	void __iomem			*base;
+	struct regmap			*regmap;
+	struct clk			*clk;
+	int				irq;
+	struct platform_device		*pdev;
+	struct aml_dma_chan		*aml_rch[MAX_CHAN_ID];
+	struct aml_dma_chan		*aml_wch[MAX_CHAN_ID];
+	unsigned int			chan_nr;
+	unsigned int			chan_used;
+	struct aml_dma_chan		aml_chans[]__counted_by(chan_ns);
+};
+
+static struct aml_dma_chan *to_aml_dma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct aml_dma_chan, chan);
+}
+
+static dma_cookie_t aml_dma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	return dma_cookie_assign(tx);
+}
+
+static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+
+	aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev,
+					       sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
+					       &aml_chan->sg_link_phys, GFP_KERNEL);
+	if (!aml_chan->sg_link)
+		return  -ENOMEM;
+
+	/* offset is the same RCH_CFG and WCH_CFG */
+	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
+	aml_chan->status = DMA_COMPLETE;
+	dma_async_tx_descriptor_init(&aml_chan->desc, chan);
+	aml_chan->desc.tx_submit = aml_dma_tx_submit;
+	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
+
+	return 0;
+}
+
+static void aml_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+
+	aml_chan->status = DMA_COMPLETE;
+	dma_free_coherent(aml_dma->dma_device.dev,
+			  sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
+			  aml_chan->sg_link, aml_chan->sg_link_phys);
+}
+
+/* DMA transfer state  update how many data reside it */
+static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	u32 residue, done;
+
+	regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
+	residue = aml_chan->data_len - done;
+	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
+			 residue);
+
+	return aml_chan->status;
+}
+
+static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
+		(struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	struct aml_dma_sg_link *sg_link;
+	struct scatterlist *sg;
+	int idx = 0;
+	u32 reg, chan_id;
+	u32 i;
+
+	if (aml_chan->direction != direction) {
+		dev_err(aml_dma->dma_device.dev, "direction not support\n");
+		return NULL;
+	}
+
+	switch (aml_chan->status) {
+	case DMA_IN_PROGRESS:
+		/* support multiple prep before pending */
+		idx = aml_chan->sg_link_cnt;
+
+		break;
+	case DMA_COMPLETE:
+		aml_chan->data_len = 0;
+		chan_id = aml_chan->chan_id;
+		reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
+		regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
+
+		break;
+	default:
+		dev_err(aml_dma->dma_device.dev, "status error\n");
+		return NULL;
+	}
+
+	if (sg_len + idx > DMA_MAX_LINK) {
+		dev_err(aml_dma->dma_device.dev,
+			"maximum number of sg exceeded: %d > %d\n",
+			sg_len, DMA_MAX_LINK);
+		aml_chan->status = DMA_ERROR;
+		return NULL;
+	}
+
+	aml_chan->status = DMA_IN_PROGRESS;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		if (sg_dma_len(sg) > SG_MAX_LEN) {
+			dev_err(aml_dma->dma_device.dev,
+				"maximum bytes exceeded: %d > %d\n",
+				sg_dma_len(sg), SG_MAX_LEN);
+			aml_chan->status = DMA_ERROR;
+			return NULL;
+		}
+		sg_link = &aml_chan->sg_link[idx++];
+		/* set dma address and len  to sglink*/
+		sg_link->address = sg->dma_address;
+		sg_link->ctl = FIELD_PREP(LINK_LEN, sg_dma_len(sg));
+
+		aml_chan->data_len += sg_dma_len(sg);
+	}
+	aml_chan->sg_link_cnt = idx;
+
+	return &aml_chan->desc;
+}
+
+static int aml_dma_pause_chan(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+
+	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
+	aml_chan->status = DMA_PAUSED;
+
+	return 0;
+}
+
+static int aml_dma_resume_chan(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+
+	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, 0);
+	aml_chan->status = DMA_IN_PROGRESS;
+
+	return 0;
+}
+
+static int aml_dma_terminate_all(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	int chan_id = aml_chan->chan_id;
+
+	aml_dma_pause_chan(chan);
+	regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
+
+	if (aml_chan->direction == DMA_MEM_TO_DEV)
+		regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), BIT(chan_id));
+	else if (aml_chan->direction == DMA_DEV_TO_MEM)
+		regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), BIT(chan_id));
+
+	aml_chan->status = DMA_COMPLETE;
+
+	return 0;
+}
+
+static void aml_dma_enable_chan(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	struct aml_dma_sg_link *sg_link;
+	int chan_id = aml_chan->chan_id;
+	int idx = aml_chan->sg_link_cnt - 1;
+
+	/* the last sg set eoc flag */
+	sg_link = &aml_chan->sg_link[idx];
+	sg_link->ctl |= LINK_EOC;
+	dma_wmb();
+	if (aml_chan->direction == DMA_MEM_TO_DEV) {
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
+			     aml_chan->sg_link_phys);
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_chan->data_len);
+		regmap_update_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id), 0);
+		/* for rch (tx) need set cfg 0 to trigger start */
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, 0);
+	} else if (aml_chan->direction == DMA_DEV_TO_MEM) {
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR,
+			     aml_chan->sg_link_phys);
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_LEN, aml_chan->data_len);
+		regmap_update_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id), 0);
+	}
+}
+
+static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
+{
+	struct aml_dma_dev *aml_dma = dev_id;
+	struct aml_dma_chan *aml_chan;
+	u32 done, eoc_done, err, err_l, end;
+	int i = 0;
+
+	/* deal with rch normal complete and error */
+	regmap_read(aml_dma->regmap, RCH_DONE, &done);
+	regmap_read(aml_dma->regmap, RCH_ERR, &err);
+	regmap_read(aml_dma->regmap, RCH_LEN_ERR, &err_l);
+	err = err | err_l;
+
+	done = done | err;
+
+	i = 0;
+	while (done) {
+		if (done & 1) {
+			aml_chan = aml_dma->aml_rch[i];
+			regmap_write(aml_dma->regmap, CLEAR_RCH, BIT(aml_chan->chan_id));
+			if (!aml_chan) {
+				dev_err(aml_dma->dma_device.dev, "idx %d rch not initialized\n", i);
+				continue;
+			}
+			aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
+			/* Make sure to use this for initialization */
+			if (aml_chan->desc.cookie >= DMA_MIN_COOKIE)
+				dma_cookie_complete(&aml_chan->desc);
+			dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
+		}
+		i++;
+		done = done >> 1;
+	}
+
+	/* deal with wch normal complete and error */
+	regmap_read(aml_dma->regmap, DMA_BATCH_END, &end);
+	if (end)
+		regmap_write(aml_dma->regmap, CLEAR_W_BATCH, end);
+
+	regmap_read(aml_dma->regmap, WCH_DONE, &done);
+	regmap_read(aml_dma->regmap, WCH_EOC_DONE, &eoc_done);
+	done = done | eoc_done;
+
+	regmap_read(aml_dma->regmap, WCH_ERR, &err);
+	regmap_read(aml_dma->regmap, WDMA_RESP_ERR, &err_l);
+	err = err | err_l;
+
+	done = done | err;
+	i = 0;
+	while (done) {
+		if (done & 1) {
+			aml_chan = aml_dma->aml_wch[i];
+			regmap_write(aml_dma->regmap, CLEAR_WCH, BIT(aml_chan->chan_id));
+			if (!aml_chan) {
+				dev_err(aml_dma->dma_device.dev, "idx %d wch not initialized\n", i);
+				continue;
+			}
+			aml_chan->status = (err & (1 << i)) ? DMA_ERROR : DMA_COMPLETE;
+			if (aml_chan->desc.cookie >= DMA_MIN_COOKIE)
+				dma_cookie_complete(&aml_chan->desc);
+			dmaengine_desc_get_callback_invoke(&aml_chan->desc, NULL);
+		}
+		i++;
+		done = done >> 1;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct dma_chan *aml_of_dma_xlate(struct of_phandle_args *dma_spec, struct of_dma *ofdma)
+{
+	struct aml_dma_dev *aml_dma = (struct aml_dma_dev *)ofdma->of_dma_data;
+	struct aml_dma_chan *aml_chan = NULL;
+	u32 type;
+	u32 phy_chan_id;
+
+	if (dma_spec->args_count != 2)
+		return NULL;
+
+	type = dma_spec->args[0];
+	phy_chan_id = dma_spec->args[1];
+
+	if (phy_chan_id >= MAX_CHAN_ID)
+		return NULL;
+
+	if (type == 0) {
+		aml_chan = aml_dma->aml_rch[phy_chan_id];
+		if (!aml_chan) {
+			if (aml_dma->chan_used >= aml_dma->chan_nr) {
+				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
+				return NULL;
+			}
+			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
+			aml_dma->chan_used++;
+			aml_chan->direction = DMA_MEM_TO_DEV;
+			aml_chan->chan_id = phy_chan_id;
+			aml_chan->reg_offs = RCH_REG_BASE + 0x40 * aml_chan->chan_id;
+			aml_dma->aml_rch[phy_chan_id] = aml_chan;
+		}
+	} else if (type == 1) {
+		aml_chan = aml_dma->aml_wch[phy_chan_id];
+		if (!aml_chan) {
+			if (aml_dma->chan_used >= aml_dma->chan_nr) {
+				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
+				return NULL;
+			}
+			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
+			aml_dma->chan_used++;
+			aml_chan->direction = DMA_DEV_TO_MEM;
+			aml_chan->chan_id = phy_chan_id;
+			aml_chan->reg_offs = WCH_REG_BASE + 0x40 * aml_chan->chan_id;
+			aml_dma->aml_wch[phy_chan_id] = aml_chan;
+		}
+	} else {
+		dev_err(aml_dma->dma_device.dev, "type %d not supported\n", type);
+		return NULL;
+	}
+
+	return dma_get_slave_channel(&aml_chan->chan);
+}
+
+static int aml_dma_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct dma_device *dma_dev;
+	struct aml_dma_dev *aml_dma;
+	int ret, i, len;
+	u32 chan_nr;
+
+	const struct regmap_config aml_regmap_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.max_register = 0x3000,
+	};
+
+	ret = of_property_read_u32(np, "dma-channels", &chan_nr);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
+
+	len = sizeof(*aml_dma) + sizeof(struct aml_dma_chan) * chan_nr;
+	aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	if (!aml_dma)
+		return -ENOMEM;
+
+	aml_dma->chan_nr = chan_nr;
+
+	aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(aml_dma->base))
+		return PTR_ERR(aml_dma->base);
+
+	aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
+						&aml_regmap_config);
+	if (IS_ERR_OR_NULL(aml_dma->regmap))
+		return PTR_ERR(aml_dma->regmap);
+
+	aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(aml_dma->clk))
+		return PTR_ERR(aml_dma->clk);
+
+	aml_dma->irq = platform_get_irq(pdev, 0);
+
+	aml_dma->pdev = pdev;
+	aml_dma->dma_device.dev = &pdev->dev;
+
+	dma_dev = &aml_dma->dma_device;
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	/* Initialize channel parameters */
+	for (i = 0; i < chan_nr; i++) {
+		struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
+
+		aml_chan->aml_dma = aml_dma;
+		aml_chan->chan.device = &aml_dma->dma_device;
+		dma_cookie_init(&aml_chan->chan);
+
+		/* Add the channel to aml_chan list */
+		list_add_tail(&aml_chan->chan.device_node,
+			      &aml_dma->dma_device.channels);
+	}
+	aml_dma->chan_used = 0;
+
+	dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
+
+	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+	dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
+	dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
+	dma_dev->device_tx_status = aml_dma_tx_status;
+	dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
+
+	dma_dev->device_pause = aml_dma_pause_chan;
+	dma_dev->device_resume = aml_dma_resume_chan;
+	dma_dev->device_terminate_all = aml_dma_terminate_all;
+	dma_dev->device_issue_pending = aml_dma_enable_chan;
+	/* PIO 4 bytes and I2C 1 byte */
+	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_1_BYTE);
+	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	ret = dmaenginem_async_device_register(dma_dev);
+	if (ret)
+		return ret;
+
+	ret = of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
+	if (ret)
+		return ret;
+
+	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
+	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
+
+	ret = devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), aml_dma);
+	if (ret)
+		return ret;
+
+	dev_info(aml_dma->dma_device.dev, "initialized\n");
+
+	return 0;
+}
+
+static const struct of_device_id aml_dma_ids[] = {
+	{ .compatible = "amlogic,general-dma", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, aml_dma_ids);
+
+static struct platform_driver aml_dma_driver = {
+	.probe = aml_dma_probe,
+	.driver		= {
+		.name	= "aml-dma",
+		.of_match_table = aml_dma_ids,
+	},
+};
+
+module_platform_driver(aml_dma_driver);
+
+MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
+MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
+MODULE_ALIAS("platform:aml-dma");
+MODULE_LICENSE("GPL");

-- 
2.52.0



