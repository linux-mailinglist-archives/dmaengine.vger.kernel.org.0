Return-Path: <dmaengine+bounces-2744-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9893D3AD
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 15:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DAC283306
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CCE17B4F7;
	Fri, 26 Jul 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFD7hbJw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02542070;
	Fri, 26 Jul 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999252; cv=none; b=pvZaxxmNLz/JgCKtE3TQD521x/DtuXAn2D9BMXXsrOXZfSQd+zDewjywImAD7M9M+uyY++pt1bx1bQt5ZXEu54qVkbV15l6WrUHbjeKQw01+w+XPQiUaDa+5udt80cCvXvZLFUtbZlJ6ExhN/XPAosTHIWLnzuVQ/knGXsacmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999252; c=relaxed/simple;
	bh=b5t70qrAysiBqfJCuMd7Fh/BB+qLyuv4odmASlTZ/Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqkoIkk+4WIvO49FgkNzPYsyirotcmBvBZMUaHwR8G/Yf5GhARryx/z6bJksfzhl++4EMgeMc23vpG2yMCvNDYJ/SCjmY3HSsoSMx3rL2BFQFPc6N+KQXN1eIF4v4Fv/2WYTUWyVWULh+Ou1lE+DSfagfzSnHHkbQNkeE8dugOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFD7hbJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16732C4AF0B;
	Fri, 26 Jul 2024 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721999252;
	bh=b5t70qrAysiBqfJCuMd7Fh/BB+qLyuv4odmASlTZ/Ws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EFD7hbJw+ZHFoU9leRW74Yzz3cUZqmX1UCMrx02ltGBNpX8xzr3hBoRSVVb+sKv2R
	 7/FpAtYQq/il4F/55hn7KBl/48oyvPj8Cnb+EYmIYLnwhT1uFlVJzgsb1f/f1pv4go
	 +OHAgXA39ZFektM4gLI0DIOukFHPNtbE9HIuZyKGDNd4qgylO/CjSPM0f1s4qQovTz
	 JykmH/7fojtyFWMHo3E0k+WL99KK4uaUo/wAcaTZgZ+huQgCFkMl4nhnVCvzq4f9ND
	 LSjWF8OHexLOOkSOK2U4XAGpQznE2m1QJ0/AAQB3K6quErKwox+gkLbQQT6Ov5u9ZX
	 PnLZ2rg3RLIeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F37C3DA70;
	Fri, 26 Jul 2024 13:07:32 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 26 Jul 2024 21:06:50 +0800
Subject: [PATCH v10 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA
 driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-loongson1-dma-v10-2-31bf095a6fa6@gmail.com>
References: <20240726-loongson1-dma-v10-0-31bf095a6fa6@gmail.com>
In-Reply-To: <20240726-loongson1-dma-v10-0-31bf095a6fa6@gmail.com>
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721999250; l=22145;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=UeihO/Qh5DlqwuAYMwU95WoRUAcqnTPC8GHkJzI9SJE=;
 b=xnAQa2hXVVGHQrC7qnNVB315JfQIherbtV+KG95StnHv7wnjEMyPE0lY/5swKzr3RX9pXJ7za
 TTEHY3anWMSCNQCkHq7BRRtQWr91tMcAtCyw7c+kUqKN/jcARy0R++H
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

This patch adds APB DMA driver for Loongson-1 SoCs.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v10:
- Implement the hwdescs by link list to eliminate the limitation of the desc number.
- Add the prefix 'LS1X_' for all registers and their bits.
- Drop the macros: chan_readl() and chan_writel().
- Use %pad for printing a dma_addr_t type.
- Some minor fixes.

Changes in v9:
- Fix all the errors and warnings when building with W=1 and C=1

Changes in v8:
- None

Changes in v7:
- Change the comptible to 'loongson,ls1*-apbdma'
- Update Kconfig and Makefile accordingly
- Rename the file to loongson1-apb-dma.c to keep the consistency

Changes in v6:
- Implement .device_prep_dma_cyclic for Loongson1 audio driver,
  as well as .device_pause and .device_resume.
- Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
  into one page to save memory
- Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
- Drop dma_slave_config structure
- Use .remove_new instead of .remove
- Use KBUILD_MODNAME for the driver name
- Improve the debug information

Changes in v5:
- Add DT support
- Use DT data instead of platform data
- Use chan_id of struct dma_chan instead of own id
- Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
- Update the author information to my official name

Changes in v4:
- Use dma_slave_map to find the proper channel.
- Explicitly call devm_request_irq() and tasklet_kill().
- Fix namespace issue.
- Some minor fixes and cleanups.

Changes in v3:
- Rename ls1x_dma_filter_fn to ls1x_dma_filter.

Changes in v2:
- Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
- and rearrange it in alphabetical order in Kconfig and Makefile.
- Fix comment style.
---
 drivers/dma/Kconfig             |   9 +
 drivers/dma/Makefile            |   1 +
 drivers/dma/loongson1-apb-dma.c | 675 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 685 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cc0a62c34861..4a1912744c45 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -369,6 +369,15 @@ config K3_DMA
 	  Support the DMA engine for Hisilicon K3 platform
 	  devices.
 
+config LOONGSON1_APB_DMA
+	tristate "Loongson1 APB DMA support"
+	depends on MACH_LOONGSON32 || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  This selects support for the APB DMA controller in Loongson1 SoCs,
+	  which is required by Loongson1 NAND and audio support.
+
 config LPC18XX_DMAMUX
 	bool "NXP LPC18xx/43xx DMA MUX for PL080"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 374ea98faf43..c3180f4800a6 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_INTEL_IDMA64) += idma64.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioat/
 obj-y += idxd/
 obj-$(CONFIG_K3_DMA) += k3dma.o
+obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
 obj-$(CONFIG_LS2X_APB_DMA) += ls2x-apb-dma.o
 obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-dma.c
new file mode 100644
index 000000000000..f5674f0255cb
--- /dev/null
+++ b/drivers/dma/loongson1-apb-dma.c
@@ -0,0 +1,675 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Loongson-1 APB DMA Controller
+ *
+ * Copyright (C) 2015-2024 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "dmaengine.h"
+#include "virt-dma.h"
+
+/* Loongson-1 DMA Control Register */
+#define LS1X_DMA_CTRL		0x0
+
+/* DMA Control Register Bits */
+#define LS1X_DMA_STOP		BIT(4)
+#define LS1X_DMA_START		BIT(3)
+#define LS1X_DMA_ASK_VALID	BIT(2)
+
+#define LS1X_DMA_ADDR_MASK	GENMASK(31, 6)
+
+/* DMA Next Field Bits */
+#define LS1X_DMA_NEXT_VALID	BIT(0)
+
+/* DMA Command Field Bits */
+#define LS1X_DMA_RAM2DEV	BIT(12)
+#define LS1X_DMA_INT		BIT(1)
+#define LS1X_DMA_INT_MASK	BIT(0)
+
+#define LS1X_DMA_MAX_CHANNELS	3
+#define LS1X_DMA_LLI_ALIGNMENT	(~LS1X_DMA_ADDR_MASK + 1)
+
+enum ls1x_dmadesc_offsets {
+	LS1X_DMADESC_NEXT = 0,
+	LS1X_DMADESC_SADDR,
+	LS1X_DMADESC_DADDR,
+	LS1X_DMADESC_LENGTH,
+	LS1X_DMADESC_STRIDE,
+	LS1X_DMADESC_CYCLES,
+	LS1X_DMADESC_CMD,
+	LS1X_DMADESC_SIZE
+};
+
+struct ls1x_dma_lli {
+	unsigned int hw[LS1X_DMADESC_SIZE];
+	dma_addr_t phys;
+	struct list_head node;
+} __aligned(LS1X_DMA_LLI_ALIGNMENT);
+
+struct ls1x_dma_desc {
+	struct virt_dma_desc vdesc;
+	struct list_head lli_list;
+};
+
+struct ls1x_dma_chan {
+	struct virt_dma_chan vchan;
+	struct dma_pool *lli_pool;
+	phys_addr_t src_addr;
+	phys_addr_t dst_addr;
+	enum dma_slave_buswidth src_addr_width;
+	enum dma_slave_buswidth dst_addr_width;
+	unsigned int bus_width;
+	bool is_cyclic;
+
+	void __iomem *reg_base;
+	int irq;
+
+	struct ls1x_dma_lli *curr_lli;
+};
+
+struct ls1x_dma {
+	struct dma_device ddev;
+	void __iomem *reg_base;
+
+	unsigned int nr_chans;
+	struct ls1x_dma_chan chan[];
+};
+
+#define to_ls1x_dma_chan(dchan)		\
+	container_of(dchan, struct ls1x_dma_chan, vchan.chan)
+
+#define to_ls1x_dma_desc(vd)		\
+	container_of(vd, struct ls1x_dma_desc, vdesc)
+
+static inline struct device *chan2dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
+static inline int ls1x_dma_query(struct ls1x_dma_chan *chan,
+				 dma_addr_t *lli_phys)
+{
+	struct dma_chan *dchan = &chan->vchan.chan;
+	int val, ret;
+
+	val = *lli_phys & LS1X_DMA_ADDR_MASK;
+	val |= LS1X_DMA_ASK_VALID;
+	val |= dchan->chan_id;
+	writel(val, chan->reg_base + LS1X_DMA_CTRL);
+	ret = readl_poll_timeout_atomic(chan->reg_base + LS1X_DMA_CTRL, val,
+					!(val & LS1X_DMA_ASK_VALID), 0, 3000);
+	if (ret)
+		dev_err(chan2dev(dchan), "failed to query DMA\n");
+
+	return ret;
+}
+
+static inline int ls1x_dma_start(struct ls1x_dma_chan *chan,
+				 dma_addr_t *lli_phys)
+{
+	struct dma_chan *dchan = &chan->vchan.chan;
+	int val, ret;
+
+	val = *lli_phys & LS1X_DMA_ADDR_MASK;
+	val |= LS1X_DMA_START;
+	val |= dchan->chan_id;
+	writel(val, chan->reg_base + LS1X_DMA_CTRL);
+	ret = readl_poll_timeout(chan->reg_base + LS1X_DMA_CTRL, val,
+				 !(val & LS1X_DMA_START), 0, 3000);
+	if (!ret)
+		dev_dbg(chan2dev(dchan), "start DMA with lli_phys=%pad\n",
+			lli_phys);
+	else
+		dev_err(chan2dev(dchan), "failed to start DMA\n");
+
+	return ret;
+}
+
+static inline void ls1x_dma_stop(struct ls1x_dma_chan *chan)
+{
+	int val = readl(chan->reg_base + LS1X_DMA_CTRL);
+
+	writel(val | LS1X_DMA_STOP, chan->reg_base + LS1X_DMA_CTRL);
+}
+
+static void ls1x_dma_free_chan_resources(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+
+	dma_free_coherent(chan2dev(dchan), sizeof(struct ls1x_dma_lli),
+			  chan->curr_lli, chan->curr_lli->phys);
+	vchan_free_chan_resources(&chan->vchan);
+	dma_pool_destroy(chan->lli_pool);
+	chan->lli_pool = NULL;
+}
+
+static int ls1x_dma_alloc_chan_resources(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	dma_addr_t phys;
+
+	chan->lli_pool = dma_pool_create(dma_chan_name(dchan), chan2dev(dchan),
+					 sizeof(struct ls1x_dma_lli),
+					 __alignof__(struct ls1x_dma_lli), 0);
+	if (!chan->lli_pool)
+		return -ENOMEM;
+
+	/* allocate memory for querying the current lli */
+	dma_set_coherent_mask(chan2dev(dchan), DMA_BIT_MASK(32));
+	chan->curr_lli = dma_alloc_coherent(chan2dev(dchan),
+					    sizeof(struct ls1x_dma_lli), &phys,
+					    GFP_KERNEL);
+	if (!chan->curr_lli) {
+		dma_pool_destroy(chan->lli_pool);
+		return -ENOMEM;
+	}
+	chan->curr_lli->phys = phys;
+
+	return 0;
+}
+
+static inline void ls1x_dma_free_lli(struct ls1x_dma_chan *chan,
+				     struct ls1x_dma_lli *lli)
+{
+	list_del(&lli->node);
+	dma_pool_free(chan->lli_pool, lli, lli->phys);
+}
+
+static int ls1x_dma_alloc_llis(struct dma_chan *dchan,
+			       struct ls1x_dma_desc *desc,
+			       struct scatterlist *sgl, unsigned int sg_len,
+			       enum dma_transfer_direction dir, bool is_cyclic)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct ls1x_dma_lli *lli, *prev = NULL, *first = NULL;
+	struct list_head *pos = NULL;
+	struct scatterlist *sg;
+	unsigned int dev_addr, cmd, i;
+
+	switch (dir) {
+	case DMA_MEM_TO_DEV:
+		dev_addr = chan->dst_addr;
+		chan->bus_width = chan->dst_addr_width;
+		cmd = LS1X_DMA_RAM2DEV | LS1X_DMA_INT;
+		break;
+	case DMA_DEV_TO_MEM:
+		dev_addr = chan->src_addr;
+		chan->bus_width = chan->src_addr_width;
+		cmd = LS1X_DMA_INT;
+		break;
+	default:
+		dev_err(chan2dev(dchan), "unsupported DMA direction: %s\n",
+			dmaengine_get_direction_text(dir));
+		return -EINVAL;
+	}
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t buf_addr = sg_dma_address(sg);
+		size_t buf_len = sg_dma_len(sg);
+		dma_addr_t phys;
+
+		if (!is_dma_copy_aligned(dchan->device, buf_addr, 0, buf_len)) {
+			dev_err(chan2dev(dchan), "buffer is not aligned\n");
+			return -EINVAL;
+		}
+
+		/* allocate HW descriptors */
+		lli = dma_pool_zalloc(chan->lli_pool, GFP_NOWAIT, &phys);
+		if (!lli) {
+			dev_err(chan2dev(dchan), "failed to alloc lli %u\n", i);
+			return -ENOMEM;
+		}
+
+		/* setup HW descriptors */
+		lli->phys = phys;
+		lli->hw[LS1X_DMADESC_SADDR] = buf_addr;
+		lli->hw[LS1X_DMADESC_DADDR] = dev_addr;
+		lli->hw[LS1X_DMADESC_LENGTH] = buf_len / chan->bus_width;
+		lli->hw[LS1X_DMADESC_STRIDE] = 0;
+		lli->hw[LS1X_DMADESC_CYCLES] = 1;
+		lli->hw[LS1X_DMADESC_CMD] = cmd;
+
+		if (prev)
+			prev->hw[LS1X_DMADESC_NEXT] =
+			    lli->phys | LS1X_DMA_NEXT_VALID;
+		prev = lli;
+
+		if (!first)
+			first = lli;
+
+		list_add_tail(&lli->node, &desc->lli_list);
+	}
+
+	if (is_cyclic) {
+		lli->hw[LS1X_DMADESC_NEXT] = first->phys | LS1X_DMA_NEXT_VALID;
+		chan->is_cyclic = is_cyclic;
+	}
+
+	list_for_each(pos, &desc->lli_list) {
+		lli = list_entry(pos, struct ls1x_dma_lli, node);
+		print_hex_dump_debug("LLI: ", DUMP_PREFIX_OFFSET, 16, 4,
+				     lli, sizeof(*lli), false);
+	}
+
+	return 0;
+}
+
+static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
+{
+	struct ls1x_dma_desc *desc = to_ls1x_dma_desc(vdesc);
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(vdesc->tx.chan);
+	struct ls1x_dma_lli *lli, *_lli;
+
+	list_for_each_entry_safe(lli, _lli, &desc->lli_list, node)
+		ls1x_dma_free_lli(chan, lli);
+
+	kfree(desc);
+}
+
+static struct ls1x_dma_desc *ls1x_dma_alloc_desc(void)
+{
+	struct ls1x_dma_desc *desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	INIT_LIST_HEAD(&desc->lli_list);
+
+	return desc;
+}
+
+static struct dma_async_tx_descriptor *
+ls1x_dma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+		       unsigned int sg_len, enum dma_transfer_direction dir,
+		       unsigned long flags, void *context)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct ls1x_dma_desc *desc;
+
+	dev_dbg(chan2dev(dchan), "sg_len=%u flags=0x%lx dir=%s\n",
+		sg_len, flags, dmaengine_get_direction_text(dir));
+
+	desc = ls1x_dma_alloc_desc();
+	if (!desc)
+		return NULL;
+
+	if (ls1x_dma_alloc_llis(dchan, desc, sgl, sg_len, dir, false)) {
+		ls1x_dma_free_desc(&desc->vdesc);
+		return NULL;
+	}
+
+	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
+}
+
+static struct dma_async_tx_descriptor *
+ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
+			 size_t buf_len, size_t period_len,
+			 enum dma_transfer_direction dir, unsigned long flags)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct ls1x_dma_desc *desc;
+	struct scatterlist *sgl;
+	unsigned int sg_len;
+	unsigned int i;
+	int ret;
+
+	dev_dbg(chan2dev(dchan),
+		"buf_len=%zu period_len=%zu flags=0x%lx dir=%s\n",
+		buf_len, period_len, flags, dmaengine_get_direction_text(dir));
+
+	desc = ls1x_dma_alloc_desc();
+	if (!desc)
+		return NULL;
+
+	/* allocate the scatterlist */
+	sg_len = buf_len / period_len;
+	sgl = kmalloc_array(sg_len, sizeof(*sgl), GFP_NOWAIT);
+	if (!sgl)
+		return NULL;
+
+	sg_init_table(sgl, sg_len);
+	for (i = 0; i < sg_len; ++i) {
+		sg_set_page(&sgl[i], pfn_to_page(PFN_DOWN(buf_addr)),
+			    period_len, offset_in_page(buf_addr));
+		sg_dma_address(&sgl[i]) = buf_addr;
+		sg_dma_len(&sgl[i]) = period_len;
+		buf_addr += period_len;
+	}
+
+	ret = ls1x_dma_alloc_llis(dchan, desc, sgl, sg_len, dir, true);
+	kfree(sgl);
+	if (ret) {
+		ls1x_dma_free_desc(&desc->vdesc);
+		return NULL;
+	}
+
+	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
+}
+
+static int ls1x_dma_slave_config(struct dma_chan *dchan,
+				 struct dma_slave_config *config)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+
+	chan->src_addr = config->src_addr;
+	chan->src_addr_width = config->src_addr_width;
+	chan->dst_addr = config->dst_addr;
+	chan->dst_addr_width = config->dst_addr_width;
+
+	return 0;
+}
+
+static int ls1x_dma_pause(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	/* save the current lli */
+	ret = ls1x_dma_query(chan, &chan->curr_lli->phys);
+	if (!ret)
+		ls1x_dma_stop(chan);
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	return ret;
+}
+
+static int ls1x_dma_resume(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	ret = ls1x_dma_start(chan, &chan->curr_lli->phys);
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	return ret;
+}
+
+static int ls1x_dma_terminate_all(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct virt_dma_desc *vdesc;
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	ls1x_dma_stop(chan);
+	vdesc = vchan_next_desc(&chan->vchan);
+	if (vdesc)
+		vchan_terminate_vdesc(vdesc);
+	vchan_get_all_descriptors(&chan->vchan, &head);
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	vchan_dma_desc_free_list(&chan->vchan, &head);
+
+	return 0;
+}
+
+static enum dma_status ls1x_dma_tx_status(struct dma_chan *dchan,
+					  dma_cookie_t cookie,
+					  struct dma_tx_state *state)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct virt_dma_desc *vdesc;
+	unsigned long flags;
+	enum dma_status status;
+	size_t bytes = 0;
+
+	status = dma_cookie_status(dchan, cookie, state);
+	if (status == DMA_COMPLETE)
+		return status;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+
+	vdesc = vchan_find_desc(&chan->vchan, cookie);
+	if (vdesc) {
+		struct ls1x_dma_desc *desc = to_ls1x_dma_desc(vdesc);
+		struct ls1x_dma_lli *lli;
+		dma_addr_t next_phys;
+
+		/* get the current lli */
+		if (ls1x_dma_query(chan, &chan->curr_lli->phys)) {
+			spin_unlock_irqrestore(&chan->vchan.lock, flags);
+			return status;
+		}
+		next_phys = chan->curr_lli->hw[LS1X_DMADESC_NEXT];
+
+		/* locate the current lli */
+		list_for_each_entry(lli, &desc->lli_list, node)
+			if (lli->hw[LS1X_DMADESC_NEXT] == next_phys)
+				break;
+
+		dev_dbg(chan2dev(dchan), "current lli_phys=%pad", &lli->phys);
+
+		/* count the residues */
+		list_for_each_entry_from(lli, &desc->lli_list, node)
+			bytes += lli->hw[LS1X_DMADESC_LENGTH] * chan->bus_width;
+	}
+
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	dma_set_residue(state, bytes);
+
+	return status;
+}
+
+static void ls1x_dma_issue_pending(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct virt_dma_desc *vdesc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+
+	if (vchan_issue_pending(&chan->vchan)) {
+		vdesc = vchan_next_desc(&chan->vchan);
+		if (vdesc) {
+			struct ls1x_dma_desc *desc = to_ls1x_dma_desc(vdesc);
+			struct ls1x_dma_lli *lli;
+
+			lli = list_first_entry(&desc->lli_list,
+					       struct ls1x_dma_lli, node);
+			ls1x_dma_start(chan, &lli->phys);
+		}
+	}
+
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+}
+
+static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
+{
+	struct ls1x_dma_chan *chan = data;
+	struct dma_chan *dchan = &chan->vchan.chan;
+	struct virt_dma_desc *vdesc;
+
+	spin_lock(&chan->vchan.lock);
+
+	vdesc = vchan_next_desc(&chan->vchan);
+	if (!vdesc) {
+		spin_unlock(&chan->vchan.lock);
+		dev_warn(chan2dev(dchan),
+			 "IRQ %d with no active descriptor on channel %d\n",
+			 irq, dchan->chan_id);
+		return IRQ_NONE;
+	}
+
+	if (chan->is_cyclic) {
+		vchan_cyclic_callback(vdesc);
+	} else {
+		list_del(&vdesc->node);
+		vchan_cookie_complete(vdesc);
+	}
+
+	spin_unlock(&chan->vchan.lock);
+
+	dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel %d\n", irq,
+		dchan->chan_id);
+
+	return IRQ_HANDLED;
+}
+
+static int ls1x_dma_chan_probe(struct platform_device *pdev,
+			       struct ls1x_dma *dma, int chan_id)
+{
+	struct device *dev = &pdev->dev;
+	struct ls1x_dma_chan *chan = &dma->chan[chan_id];
+	char pdev_irqname[4];
+	char *irqname;
+	int ret;
+
+	sprintf(pdev_irqname, "ch%u", chan_id);
+	chan->irq = platform_get_irq_byname(pdev, pdev_irqname);
+	if (chan->irq < 0)
+		return -ENODEV;
+
+	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
+				 dev_name(dev), pdev_irqname);
+	if (!irqname)
+		return -ENOMEM;
+
+	ret = devm_request_irq(dev, chan->irq, ls1x_dma_irq_handler,
+			       IRQF_SHARED, irqname, chan);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request IRQ %u\n",
+				     chan->irq);
+
+	chan->reg_base = dma->reg_base;
+	chan->vchan.desc_free = ls1x_dma_free_desc;
+	vchan_init(&chan->vchan, &dma->ddev);
+	dev_info(dev, "%s (irq %d) initialized\n", pdev_irqname, chan->irq);
+
+	return 0;
+}
+
+static void ls1x_dma_chan_remove(struct ls1x_dma *dma, int chan_id)
+{
+	struct device *dev = dma->ddev.dev;
+	struct ls1x_dma_chan *chan = &dma->chan[chan_id];
+
+	devm_free_irq(dev, chan->irq, chan);
+	list_del(&chan->vchan.chan.device_node);
+	tasklet_kill(&chan->vchan.task);
+}
+
+static int ls1x_dma_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dma_device *ddev;
+	struct ls1x_dma *dma;
+	int nr_chans, ret, i;
+
+	nr_chans = platform_irq_count(pdev);
+	if (nr_chans <= 0)
+		return nr_chans;
+	if (nr_chans > LS1X_DMA_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL,
+				     "nr_chans=%d exceeds the maximum\n",
+				     nr_chans);
+
+	dma = devm_kzalloc(dev, struct_size(dma, chan, nr_chans), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	/* initialize DMA device */
+	dma->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dma->reg_base))
+		return PTR_ERR(dma->reg_base);
+
+	ddev = &dma->ddev;
+	ddev->dev = dev;
+	ddev->copy_align = DMAENGINE_ALIGN_4_BYTES;
+	ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+				BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+				BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+				BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+				BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	ddev->device_alloc_chan_resources = ls1x_dma_alloc_chan_resources;
+	ddev->device_free_chan_resources = ls1x_dma_free_chan_resources;
+	ddev->device_prep_slave_sg = ls1x_dma_prep_slave_sg;
+	ddev->device_prep_dma_cyclic = ls1x_dma_prep_dma_cyclic;
+	ddev->device_config = ls1x_dma_slave_config;
+	ddev->device_pause = ls1x_dma_pause;
+	ddev->device_resume = ls1x_dma_resume;
+	ddev->device_terminate_all = ls1x_dma_terminate_all;
+	ddev->device_tx_status = ls1x_dma_tx_status;
+	ddev->device_issue_pending = ls1x_dma_issue_pending;
+
+	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
+	INIT_LIST_HEAD(&ddev->channels);
+
+	/* initialize DMA channels */
+	for (i = 0; i < nr_chans; i++) {
+		ret = ls1x_dma_chan_probe(pdev, dma, i);
+		if (ret)
+			return ret;
+	}
+	dma->nr_chans = nr_chans;
+
+	ret = dmaenginem_async_device_register(ddev);
+	if (ret) {
+		dev_err(dev, "failed to register DMA device! %d\n", ret);
+		return ret;
+	}
+
+	ret = of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id,
+					 ddev);
+	if (ret) {
+		dev_err(dev, "failed to register DMA controller! %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, dma);
+	dev_info(dev, "Loongson1 DMA driver registered\n");
+
+	return 0;
+}
+
+static void ls1x_dma_remove(struct platform_device *pdev)
+{
+	struct ls1x_dma *dma = platform_get_drvdata(pdev);
+	int i;
+
+	of_dma_controller_free(pdev->dev.of_node);
+
+	for (i = 0; i < dma->nr_chans; i++)
+		ls1x_dma_chan_remove(dma, i);
+}
+
+static const struct of_device_id ls1x_dma_match[] = {
+	{ .compatible = "loongson,ls1b-apbdma" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_dma_match);
+
+static struct platform_driver ls1x_dma_driver = {
+	.probe = ls1x_dma_probe,
+	.remove_new = ls1x_dma_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = ls1x_dma_match,
+	},
+};
+
+module_platform_driver(ls1x_dma_driver);
+
+MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson-1 APB DMA Controller driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0



