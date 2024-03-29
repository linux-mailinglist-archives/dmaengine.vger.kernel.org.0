Return-Path: <dmaengine+bounces-1655-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092CD8917B8
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 12:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6861F22B66
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61936A356;
	Fri, 29 Mar 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnFf6sCp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8F6A33C;
	Fri, 29 Mar 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711678; cv=none; b=DAvDH1FKqV9HJbd6KktzCNy09CvB/Jl6thr+GkEpiUGmvu/ghTAGMUk+m5XWCcEZJAWPvKyOlNjm6sikt3S03I5bVGtUguzkl705Xk4gXVChrzjR8VNcDxh9bPUE1EYk7ppiDRuz3/BCa80hXjx1oc6PQ9T9o1HhN9rlBCoTUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711678; c=relaxed/simple;
	bh=5P0gp1EpCSoVMW4GkSVxaKaRSkZg5tRtSjtFLxyWiTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0eQ/i+vlSZ5uWh4H/o1oTraDRyZ/Vf1EicEiVif+Lvwlgqlw2Cpru86Cwqpfi2ZmbMtb8h2Ul2OKjDagRbTFizwg9fbTuT7sLnRGIejfb2j6TfP/6wQPke0vxeVHn6eYoUi+Q5VDmClkqtH0SUIYosk4XEvUiQnXjo+aYkuMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnFf6sCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1453AC43390;
	Fri, 29 Mar 2024 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711711678;
	bh=5P0gp1EpCSoVMW4GkSVxaKaRSkZg5tRtSjtFLxyWiTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tnFf6sCpUpj156GF6le423PbafCPY81douw8wgZ11WdW7Gbl9iAnbDw+13TPK7Ng+
	 qIqIflmdtzn4M7SBJj6JZhJMj86TUu2kAGzzD99jpjiuOjysWU9YBZbrnm6zEJmc3s
	 PBOW2LL9KmVm7Iypy3tF53NcaVV4nEYxx94Alk/IIWGsM5TxT+X+K+7qMdZuaRcuDc
	 9uxKZ7F1OcIbv5SrbIiD1PZPbdUnZySGoSAybsXs47mFLmxbPX2K+6dDzCvwcJKMI/
	 z4NXwn8WeBs5vJ0ClTPfKNGRBvyV1LDSuZRCiR4l349P5TEU8SER68Dwreh9o5du/U
	 NYkNd18jXX7AA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6CFC6FD1F;
	Fri, 29 Mar 2024 11:27:57 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 29 Mar 2024 19:26:58 +0800
Subject: [PATCH v7 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-loongson1-dma-v7-2-37db58608de5@gmail.com>
References: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
In-Reply-To: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711711676; l=21607;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=dEI4T8FGRfPtEfYeeqn5r4AIbfkEwxBlHrAeygzbpEo=;
 b=STbgyQXZBsjIY/lev7piHZQif73FAgzkLUo2Rcy/DFDXEInHnvloWOESes7zdwbJCmARo17vO
 Wsuen51qIziC+U6ww6mGMZe5hMniUVb06NlajY51Zc/HiQQcd51wV9i
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

This patch adds APB DMA driver for Loongson-1 SoCs.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v7:
- Change the comptible to 'loongson,ls1*-apbdma'
- Update Kconfig and Makefile accordingly
- Rename the file to loongson1-apb-dma.c to keep the consistency

Changes in v6:
- Implement .device_prep_dma_cyclic for Loongson1 audio driver,
- as well as .device_pause and .device_resume.
- Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
- into one page to save memory
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
 drivers/dma/loongson1-apb-dma.c | 665 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 675 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 002a5ec80620..f7b06c4cdf3f 100644
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
index dfd40d14e408..b26f6677978a 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_IDMA64) += idma64.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioat/
 obj-y += idxd/
 obj-$(CONFIG_K3_DMA) += k3dma.o
+obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
 obj-$(CONFIG_LS2X_APB_DMA) += ls2x-apb-dma.o
 obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
diff --git a/drivers/dma/loongson1-apb-dma.c b/drivers/dma/loongson1-apb-dma.c
new file mode 100644
index 000000000000..d474a2601e6e
--- /dev/null
+++ b/drivers/dma/loongson1-apb-dma.c
@@ -0,0 +1,665 @@
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
+#define DMA_CTRL			0x0
+
+/* DMA Control Register Bits */
+#define DMA_STOP			BIT(4)
+#define DMA_START			BIT(3)
+#define DMA_ASK_VALID			BIT(2)
+
+#define DMA_ADDR_MASK			GENMASK(31, 6)
+
+/* DMA Next Field Bits */
+#define DMA_NEXT_VALID			BIT(0)
+
+/* DMA Command Field Bits */
+#define DMA_RAM2DEV			BIT(12)
+#define DMA_INT				BIT(1)
+#define DMA_INT_MASK			BIT(0)
+
+#define LS1X_DMA_MAX_CHANNELS		3
+
+/* Size of allocations for hardware descriptors */
+#define LS1X_DMA_DESCS_SIZE		PAGE_SIZE
+#define LS1X_DMA_MAX_DESC		\
+	(LS1X_DMA_DESCS_SIZE / sizeof(struct ls1x_dma_hwdesc))
+
+struct ls1x_dma_hwdesc {
+	u32 next;		/* next descriptor address */
+	u32 saddr;		/* memory DMA address */
+	u32 daddr;		/* device DMA address */
+	u32 length;
+	u32 stride;
+	u32 cycles;
+	u32 cmd;
+	u32 stats;
+};
+
+struct ls1x_dma_desc {
+	struct virt_dma_desc vdesc;
+	enum dma_transfer_direction dir;
+	enum dma_transaction_type type;
+	unsigned int bus_width;
+
+	unsigned int nr_descs;	/* number of descriptors */
+
+	struct ls1x_dma_hwdesc *hwdesc;
+	dma_addr_t hwdesc_phys;
+};
+
+struct ls1x_dma_chan {
+	struct virt_dma_chan vchan;
+	struct dma_pool *desc_pool;
+	phys_addr_t src_addr;
+	phys_addr_t dst_addr;
+	enum dma_slave_buswidth src_addr_width;
+	enum dma_slave_buswidth dst_addr_width;
+
+	void __iomem *reg_base;
+	int irq;
+
+	struct ls1x_dma_desc *desc;
+
+	struct ls1x_dma_hwdesc *curr_hwdesc;
+	dma_addr_t curr_hwdesc_phys;
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
+/* macros for registers read/write */
+#define chan_readl(chan, off)		\
+	readl((chan)->reg_base + (off))
+
+#define chan_writel(chan, off, val)	\
+	writel((val), (chan)->reg_base + (off))
+
+static inline struct device *chan2dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
+static inline int ls1x_dma_query(struct ls1x_dma_chan *chan,
+				 dma_addr_t *hwdesc_phys)
+{
+	struct dma_chan *dchan = &chan->vchan.chan;
+	int val, ret;
+
+	val = *hwdesc_phys & DMA_ADDR_MASK;
+	val |= DMA_ASK_VALID;
+	val |= dchan->chan_id;
+	chan_writel(chan, DMA_CTRL, val);
+	ret = readl_poll_timeout_atomic(chan->reg_base + DMA_CTRL, val,
+					!(val & DMA_ASK_VALID), 0, 3000);
+	if (ret)
+		dev_err(chan2dev(dchan), "failed to query DMA\n");
+
+	return ret;
+}
+
+static inline int ls1x_dma_start(struct ls1x_dma_chan *chan,
+				 dma_addr_t *hwdesc_phys)
+{
+	struct dma_chan *dchan = &chan->vchan.chan;
+	int val, ret;
+
+	dev_dbg(chan2dev(dchan), "cookie=%d, starting hwdesc=%x\n",
+		dchan->cookie, *hwdesc_phys);
+
+	val = *hwdesc_phys & DMA_ADDR_MASK;
+	val |= DMA_START;
+	val |= dchan->chan_id;
+	chan_writel(chan, DMA_CTRL, val);
+	ret = readl_poll_timeout(chan->reg_base + DMA_CTRL, val,
+				 !(val & DMA_START), 0, 3000);
+	if (ret)
+		dev_err(chan2dev(dchan), "failed to start DMA\n");
+
+	return ret;
+}
+
+static inline void ls1x_dma_stop(struct ls1x_dma_chan *chan)
+{
+	chan_writel(chan, DMA_CTRL, chan_readl(chan, DMA_CTRL) | DMA_STOP);
+}
+
+static void ls1x_dma_free_chan_resources(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+
+	dma_free_coherent(chan2dev(dchan), sizeof(struct ls1x_dma_hwdesc),
+			  chan->curr_hwdesc, chan->curr_hwdesc_phys);
+	vchan_free_chan_resources(&chan->vchan);
+	dma_pool_destroy(chan->desc_pool);
+	chan->desc_pool = NULL;
+}
+
+static int ls1x_dma_alloc_chan_resources(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+
+	chan->desc_pool = dma_pool_create(dma_chan_name(dchan),
+					  chan2dev(dchan),
+					  sizeof(struct ls1x_dma_hwdesc),
+					  __alignof__(struct ls1x_dma_hwdesc),
+					  0);
+	if (!chan->desc_pool)
+		return -ENOMEM;
+
+	/* allocate memory for querying current HW descriptor */
+	dma_set_coherent_mask(chan2dev(dchan), DMA_BIT_MASK(32));
+	chan->curr_hwdesc = dma_alloc_coherent(chan2dev(dchan),
+					       sizeof(struct ls1x_dma_hwdesc),
+					       &chan->curr_hwdesc_phys,
+					       GFP_KERNEL);
+	if (!chan->curr_hwdesc)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
+{
+	struct ls1x_dma_desc *desc = to_ls1x_dma_desc(vdesc);
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(vdesc->tx.chan);
+
+	dma_pool_free(chan->desc_pool, desc->hwdesc, desc->hwdesc_phys);
+	chan->desc = NULL;
+	kfree(desc);
+}
+
+static struct ls1x_dma_desc *
+ls1x_dma_alloc_desc(struct dma_chan *dchan, int sg_len,
+		    enum dma_transfer_direction direction,
+		    enum dma_transaction_type type)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct ls1x_dma_desc *desc;
+
+	if (sg_len > LS1X_DMA_MAX_DESC) {
+		dev_err(chan2dev(dchan), "sg_len %u exceeds limit %lu",
+			sg_len, LS1X_DMA_MAX_DESC);
+		return NULL;
+	}
+
+	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	/* allocate HW descriptors */
+	desc->hwdesc = dma_pool_zalloc(chan->desc_pool, GFP_NOWAIT,
+				       &desc->hwdesc_phys);
+	if (!desc->hwdesc) {
+		dev_err(chan2dev(dchan), "failed to alloc HW descriptors\n");
+		ls1x_dma_free_desc(&desc->vdesc);
+		return NULL;
+	}
+
+	desc->dir = direction;
+	desc->type = type;
+	desc->nr_descs = sg_len;
+
+	return desc;
+}
+
+static int ls1x_dma_setup_hwdescs(struct dma_chan *dchan,
+				  struct ls1x_dma_desc *desc,
+				  struct scatterlist *sgl, unsigned int sg_len)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	dma_addr_t next_hwdesc_phys = desc->hwdesc_phys;
+
+	struct scatterlist *sg;
+	unsigned int dev_addr, cmd, i;
+
+	switch (desc->dir) {
+	case DMA_MEM_TO_DEV:
+		dev_addr = chan->dst_addr;
+		desc->bus_width = chan->dst_addr_width;
+		cmd = DMA_RAM2DEV | DMA_INT;
+		break;
+	case DMA_DEV_TO_MEM:
+		dev_addr = chan->src_addr;
+		desc->bus_width = chan->src_addr_width;
+		cmd = DMA_INT;
+		break;
+	default:
+		dev_err(chan2dev(dchan), "unsupported DMA direction: %s\n",
+			dmaengine_get_direction_text(desc->dir));
+		return -EINVAL;
+	}
+
+	/* setup HW descriptors */
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t buf_addr = sg_dma_address(sg);
+		size_t buf_len = sg_dma_len(sg);
+		struct ls1x_dma_hwdesc *hwdesc = &desc->hwdesc[i];
+
+		if (!is_dma_copy_aligned(dchan->device, buf_addr, 0, buf_len)) {
+			dev_err(chan2dev(dchan), "buffer is not aligned!\n");
+			return -EINVAL;
+		}
+
+		hwdesc->saddr = buf_addr;
+		hwdesc->daddr = dev_addr;
+		hwdesc->length = buf_len / desc->bus_width;
+		hwdesc->stride = 0;
+		hwdesc->cycles = 1;
+		hwdesc->cmd = cmd;
+
+		if (i) {
+			next_hwdesc_phys += sizeof(*hwdesc);
+			desc->hwdesc[i - 1].next = next_hwdesc_phys
+			    | DMA_NEXT_VALID;
+		}
+	}
+
+	if (desc->type == DMA_CYCLIC)
+		desc->hwdesc[i - 1].next = desc->hwdesc_phys | DMA_NEXT_VALID;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		struct ls1x_dma_hwdesc *hwdesc = &desc->hwdesc[i];
+
+		print_hex_dump_debug("HW DESC: ", DUMP_PREFIX_OFFSET, 16, 4,
+				     hwdesc, sizeof(*hwdesc), false);
+	}
+
+	return 0;
+}
+
+static struct dma_async_tx_descriptor *
+ls1x_dma_prep_slave_sg(struct dma_chan *dchan,
+		       struct scatterlist *sgl, unsigned int sg_len,
+		       enum dma_transfer_direction direction,
+		       unsigned long flags, void *context)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct ls1x_dma_desc *desc;
+
+	dev_dbg(chan2dev(dchan), "sg_len=%u flags=0x%lx dir=%s\n",
+		sg_len, flags, dmaengine_get_direction_text(direction));
+
+	desc = ls1x_dma_alloc_desc(dchan, sg_len, direction, DMA_SLAVE);
+	if (!desc)
+		return NULL;
+
+	if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, sg_len)) {
+		ls1x_dma_free_desc(&desc->vdesc);
+		return NULL;
+	}
+
+	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
+}
+
+static struct dma_async_tx_descriptor *
+ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan,
+			 dma_addr_t buf_addr, size_t buf_len, size_t period_len,
+			 enum dma_transfer_direction direction,
+			 unsigned long flags)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct ls1x_dma_desc *desc;
+	struct scatterlist *sgl;
+	unsigned int sg_len;
+	unsigned int i;
+
+	dev_dbg(chan2dev(dchan),
+		"buf_len=%d period_len=%zu flags=0x%lx dir=%s\n", buf_len,
+		period_len, flags, dmaengine_get_direction_text(direction));
+
+	sg_len = buf_len / period_len;
+	desc = ls1x_dma_alloc_desc(dchan, sg_len, direction, DMA_CYCLIC);
+	if (!desc)
+		return NULL;
+
+	/* allocate the scatterlist */
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
+	if (ls1x_dma_setup_hwdescs(dchan, desc, sgl, sg_len)) {
+		ls1x_dma_free_desc(&desc->vdesc);
+		return NULL;
+	}
+
+	kfree(sgl);
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
+	ret = ls1x_dma_query(chan, &chan->curr_hwdesc_phys);
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
+	ret = ls1x_dma_start(chan, &chan->curr_hwdesc_phys);
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	return ret;
+}
+
+static int ls1x_dma_terminate_all(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	ls1x_dma_stop(chan);
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
+	enum dma_status status;
+	size_t bytes = 0;
+	unsigned long flags;
+
+	status = dma_cookie_status(dchan, cookie, state);
+	if (status == DMA_COMPLETE)
+		return status;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	vdesc = vchan_find_desc(&chan->vchan, cookie);
+	if (chan->desc && cookie == chan->desc->vdesc.tx.cookie) {
+		struct ls1x_dma_desc *desc = chan->desc;
+		int i;
+
+		if (ls1x_dma_query(chan, &chan->curr_hwdesc_phys))
+			return status;
+
+		/* locate the current HW descriptor */
+		for (i = 0; i < desc->nr_descs; i++)
+			if (desc->hwdesc[i].next == chan->curr_hwdesc->next)
+				break;
+
+		/* count the residues */
+		for (; i < desc->nr_descs; i++)
+			bytes += desc->hwdesc[i].length * desc->bus_width;
+
+		dma_set_residue(state, bytes);
+	}
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
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
+	if (vchan_issue_pending(&chan->vchan) && !chan->desc) {
+		vdesc = vchan_next_desc(&chan->vchan);
+		if (!vdesc) {
+			chan->desc = NULL;
+			return;
+		}
+		chan->desc = to_ls1x_dma_desc(vdesc);
+		ls1x_dma_start(chan, &chan->desc->hwdesc_phys);
+	}
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+}
+
+static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
+{
+	struct ls1x_dma_chan *chan = data;
+	struct ls1x_dma_desc *desc = chan->desc;
+	struct dma_chan *dchan = &chan->vchan.chan;
+
+	if (!desc) {
+		dev_warn(chan2dev(dchan),
+			 "IRQ %d with no active descriptor on channel %d\n",
+			 irq, dchan->chan_id);
+		return IRQ_NONE;
+	}
+
+	dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel %d\n", irq,
+		dchan->chan_id);
+
+	spin_lock(&chan->vchan.lock);
+
+	if (desc->type == DMA_CYCLIC) {
+		vchan_cyclic_callback(&desc->vdesc);
+	} else {
+		list_del(&desc->vdesc.node);
+		vchan_cookie_complete(&desc->vdesc);
+		chan->desc = NULL;
+	}
+
+	spin_unlock(&chan->vchan.lock);
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
+		return dev_err_probe(dev, ret,
+				     "failed to request IRQ %u!\n", chan->irq);
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
+	    BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+	    BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	ddev->max_sg_burst = LS1X_DMA_MAX_DESC;
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
+	ret =
+	    of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id,
+				       ddev);
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
+	{ .compatible = "loongson,ls1c-apbdma" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_dma_match);
+
+static struct platform_driver ls1x_dma_driver = {
+	.probe = ls1x_dma_probe,
+	.remove_new = ls1x_dma_remove,
+	.driver	= {
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
2.40.1



