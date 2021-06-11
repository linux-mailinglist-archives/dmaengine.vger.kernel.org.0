Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01C3A4157
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 13:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhFKLi4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 07:38:56 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:25640 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230514AbhFKLiy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 07:38:54 -0400
X-IronPort-AV: E=Sophos;i="5.83,265,1616425200"; 
   d="scan'208";a="84098798"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Jun 2021 20:36:55 +0900
Received: from localhost.localdomain (unknown [10.226.92.121])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 52A43401C57D;
        Fri, 11 Jun 2021 20:36:53 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/5] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Date:   Fri, 11 Jun 2021 12:36:40 +0100
Message-Id: <20210611113642.18457-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA Controller driver for RZ/G2L SoC.

Based on the work done by Chris Brandt for RZ/A DMA driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/Kconfig   |    8 +
 drivers/dma/sh/Makefile  |    1 +
 drivers/dma/sh/rz-dmac.c | 1050 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1059 insertions(+)
 create mode 100644 drivers/dma/sh/rz-dmac.c

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 13437323a85b..280a6d359e36 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -47,3 +47,11 @@ config RENESAS_USB_DMAC
 	help
 	  This driver supports the USB-DMA controller found in the Renesas
 	  SoCs.
+
+config RZ_DMAC
+	tristate "Renesas RZ/G2L Controller"
+	depends on ARCH_R9A07G044 || COMPILE_TEST
+	select RENESAS_DMA
+	help
+	  This driver supports the general purpose DMA controller found in the
+	  Renesas RZ/G2L SoC variants.
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 112fbd22bb3f..9b2927f543bf 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_SH_DMAE) += shdma.o
 
 obj-$(CONFIG_RCAR_DMAC) += rcar-dmac.o
 obj-$(CONFIG_RENESAS_USB_DMAC) += usb-dmac.o
+obj-$(CONFIG_RZ_DMAC) += rz-dmac.o
diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
new file mode 100644
index 000000000000..87a902ba3cfa
--- /dev/null
+++ b/drivers/dma/sh/rz-dmac.c
@@ -0,0 +1,1050 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L Controller Driver
+ *
+ * Based on imx-dma.c
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ * Copyright 2010 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ * Copyright 2012 Javier Martin, Vista Silicon <javier.martin@vista-silicon.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "../dmaengine.h"
+
+struct rz_dmac_slave_config {
+	u32 mid_rid;
+	dma_addr_t addr;
+	u32 chcfg;
+};
+
+enum  rz_dmac_prep_type {
+	RZ_DMAC_DESC_MEMCPY,
+	RZ_DMAC_DESC_SLAVE_SG,
+};
+
+struct rz_lmdesc {
+	u32 header;
+	u32 sa;
+	u32 da;
+	u32 tb;
+	u32 chcfg;
+	u32 chitvl;
+	u32 chext;
+	u32 nxla;
+};
+
+struct rz_dmac_desc {
+	struct list_head node;
+	struct dma_async_tx_descriptor desc;
+	enum dma_status status;
+	dma_addr_t src;
+	dma_addr_t dest;
+	size_t len;
+	enum dma_transfer_direction direction;
+	enum rz_dmac_prep_type type;
+	/* For memcpy */
+	unsigned int config_port;
+	unsigned int config_mem;
+	/* For slave sg */
+	struct scatterlist *sg;
+	unsigned int sgcount;
+};
+
+struct rz_dmac_channel {
+	struct rz_dmac_engine *rzdma;
+	unsigned int index;
+	int irq;
+
+	spinlock_t lock;
+	struct list_head ld_free;
+	struct list_head ld_queue;
+	struct list_head ld_active;
+
+	int descs_allocated;
+	enum dma_slave_buswidth word_size;
+	dma_addr_t per_address;
+	struct dma_chan chan;
+	struct dma_async_tx_descriptor desc;
+	enum dma_status status;
+
+	const struct rz_dmac_slave_config *slave;
+	void __iomem *ch_base;
+	void __iomem *ch_cmn_base;
+
+	struct {
+		struct rz_lmdesc *base;
+		struct rz_lmdesc *head;
+		struct rz_lmdesc *tail;
+		int valid;
+		dma_addr_t base_dma;
+	} lmdesc;
+
+	u32 chcfg;
+	u32 chctrl;
+
+	struct {
+		int issue;
+		int prep_slave_sg;
+	} stat;
+};
+
+#define to_rz_dmac_chan(c) container_of(c, struct rz_dmac_channel, chan)
+
+struct rz_dmac_engine {
+	struct dma_device dma_device;
+	struct device_dma_parameters dma_parms;
+	struct device *dev;
+	void __iomem *base;
+	void __iomem *ext_base;
+
+	spinlock_t lock;
+	struct rz_dmac_channel *channel;
+	unsigned int n_channels;
+	struct rz_dmac_slave_config *slave;
+	int slave_num;
+};
+
+/* -----------------------------------------------------------------------------
+ * Registers
+ */
+
+#define CHSTAT				0x0024
+#define CHCTRL				0x0028
+#define CHCFG				0x002c
+#define CHITVL				0x0030
+#define CHEXT				0x0034
+#define NXLA				0x0038
+#define CRLA				0x003c
+
+#define DCTRL				0x0000
+#define DSTAT_EN			0x0010
+#define DSTAT_ER			0x0014
+#define DSTAT_END			0x0018
+#define DSTAT_TC			0x001c
+#define DSTAT_SUS			0x0020
+
+#define EACH_CHANNEL_OFFSET		0x0040
+#define CHANNEL_0_7_OFFSET		0x0000
+#define CHANNEL_0_7_COMMON_BASE		0x0300
+#define CHANNEL_8_15_OFFSET		0x0400
+#define CHANNEL_8_15_COMMON_BASE	0x0700
+
+#define CHSTAT_TC			BIT(6)
+#define CHSTAT_END			BIT(5)
+#define CHSTAT_ER			BIT(4)
+#define CHSTAT_EN			BIT(0)
+
+#define CHCTRL_CLRINTMSK		BIT(17)
+#define CHCTRL_SETINTMSK		BIT(16)
+#define CHCTRL_CLRSUS			BIT(9)
+#define CHCTRL_SETSUS			BIT(8)
+#define CHCTRL_CLRTC			BIT(6)
+#define CHCTRL_CLREND			BIT(5)
+#define CHCTRL_CLRRQ			BIT(4)
+#define CHCTRL_SWRST			BIT(3)
+#define CHCTRL_STG			BIT(2)
+#define CHCTRL_CLREN			BIT(1)
+#define CHCTRL_SETEN			BIT(0)
+#define CHCTRL_DEFAULT			(CHCTRL_CLRINTMSK | CHCTRL_CLRSUS | \
+					 CHCTRL_CLRTC |	CHCTRL_CLREND | \
+					 CHCTRL_CLRRQ | CHCTRL_SWRST | \
+					 CHCTRL_CLREN)
+
+#define CHCFG_DMS			BIT(31)
+#define CHCFG_DEM			BIT(24)
+#define CHCFG_DAD			BIT(21)
+#define CHCFG_SAD			BIT(20)
+#define CHCFG_SEL(bits)			((bits) & 0x07)
+#define CHCFG_MEM_COPY			(0x80400008)
+
+#define DCTRL_LVINT			BIT(1)
+#define DCTRL_PR			BIT(0)
+#define DCTRL_DEFAULT			(DCTRL_LVINT | DCTRL_PR)
+
+/* LINK MODE DESCRIPTOR */
+#define HEADER_DIM			BIT(3)
+#define HEADER_WBD			BIT(2)
+#define HEADER_LE			BIT(1)
+#define HEADER_LV			BIT(0)
+
+#define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
+#define DMAC_NR_LMDESC			64
+
+/* -----------------------------------------------------------------------------
+ * Device access
+ */
+
+static void rz_dmac_writel(struct rz_dmac_engine *rzdma, unsigned int val,
+			   unsigned int offset)
+{
+	writel(val, rzdma->base + offset);
+}
+
+static void rz_dmac_ext_writel(struct rz_dmac_engine *rzdma, unsigned int val,
+			       unsigned int offset)
+{
+	writel(val, rzdma->ext_base + offset);
+}
+
+static u32 rz_dmac_ext_readl(struct rz_dmac_engine *rzdma, unsigned int offset)
+{
+	return readl(rzdma->ext_base + offset);
+}
+
+static void rz_dmac_ch_writel(struct rz_dmac_channel *channel, unsigned int val,
+			      unsigned int offset, int which)
+{
+	if (which)
+		writel(val, channel->ch_base + offset);
+	else
+		writel(val, channel->ch_cmn_base + offset);
+}
+
+static u32 rz_dmac_ch_readl(struct rz_dmac_channel *channel,
+			    unsigned int offset, int which)
+{
+	if (which)
+		return readl(channel->ch_base + offset);
+	else
+		return readl(channel->ch_cmn_base + offset);
+}
+
+/* -----------------------------------------------------------------------------
+ * Initialization
+ */
+
+static void rz_lmdesc_setup(struct rz_dmac_channel *channel,
+			    struct rz_lmdesc *lmdesc)
+{
+	u32 nxla;
+
+	channel->lmdesc.base = lmdesc;
+	channel->lmdesc.head = lmdesc;
+	channel->lmdesc.tail = lmdesc;
+	channel->lmdesc.valid = 0;
+	nxla = channel->lmdesc.base_dma;
+	while (lmdesc < (channel->lmdesc.base + (DMAC_NR_LMDESC - 1))) {
+		lmdesc->header = 0;
+		nxla += sizeof(*lmdesc);
+		lmdesc->nxla = nxla;
+		lmdesc++;
+	}
+
+	lmdesc->header = 0;
+	lmdesc->nxla = channel->lmdesc.base_dma;
+}
+
+/* -----------------------------------------------------------------------------
+ * Descriptors submission
+ */
+
+static dma_cookie_t rz_dmac_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct dma_chan *chan = tx->chan;
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	dma_cookie_t cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&channel->lock, flags);
+	list_move_tail(channel->ld_free.next, &channel->ld_queue);
+	cookie = dma_cookie_assign(tx);
+	spin_unlock_irqrestore(&channel->lock, flags);
+
+	return cookie;
+}
+
+/* -----------------------------------------------------------------------------
+ * Descriptors preparation
+ */
+
+static void lmdesc_recycle(struct rz_dmac_channel *channel)
+{
+	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
+
+	while (!(lmdesc->header & HEADER_LV)) {
+		lmdesc->header = 0;
+		channel->lmdesc.valid--;
+		lmdesc++;
+		if (lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
+			lmdesc = channel->lmdesc.base;
+	}
+	channel->lmdesc.head = lmdesc;
+}
+
+static void rz_dmac_enable_hw(struct rz_dmac_desc *d)
+{
+	struct dma_chan *chan = d->desc.chan;
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+	unsigned long flags;
+	u32 nxla;
+	u32 chctrl;
+	u32 chstat;
+
+	dev_dbg(rzdma->dev, "%s channel %d\n", __func__, channel->index);
+
+	local_irq_save(flags);
+
+	lmdesc_recycle(channel);
+
+	nxla = channel->lmdesc.base_dma +
+		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
+					     channel->lmdesc.base));
+
+	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
+	if (!(chstat & CHSTAT_EN)) {
+		chctrl = (channel->chctrl | CHCTRL_SETEN);
+		rz_dmac_ch_writel(channel, nxla, NXLA, 1);
+		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
+		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
+		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
+	}
+
+	local_irq_restore(flags);
+}
+
+static void rz_dmac_disable_hw(struct rz_dmac_channel *channel)
+{
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+	unsigned long flags;
+
+	dev_dbg(rzdma->dev, "%s channel %d\n", __func__, channel->index);
+
+	local_irq_save(flags);
+	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+	local_irq_restore(flags);
+}
+
+static void set_dmars_register(struct rz_dmac_engine *rzdma, int nr, u32 dmars)
+{
+	u32 dmars_offset = (nr / 2) * 4;
+	u32 dmars32;
+
+	dmars32 = rz_dmac_ext_readl(rzdma, dmars_offset);
+	if (nr % 2) {
+		dmars32 &= 0x0000ffff;
+		dmars32 |= dmars << 16;
+	} else {
+		dmars32 &= 0xffff0000;
+		dmars32 |= dmars;
+	}
+
+	rz_dmac_ext_writel(rzdma, dmars32, dmars_offset);
+}
+
+static const struct rz_dmac_slave_config *
+dma_find_slave(const struct rz_dmac_slave_config *slave, int slave_num,
+	       u32 mid_rid)
+{
+	int i;
+
+	for (i = 0; i < slave_num; i++) {
+		const struct rz_dmac_slave_config *t = &slave[i];
+
+		if (mid_rid == t->mid_rid)
+			return t;
+	}
+
+	return NULL;
+}
+
+static void prepare_desc_for_memcpy(struct rz_dmac_desc *d)
+{
+	struct dma_chan *chan = d->desc.chan;
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
+	u32 chcfg = CHCFG_MEM_COPY;
+	u32 dmars = 0;
+
+	lmdesc = channel->lmdesc.tail;
+
+	/* prepare descriptor */
+	lmdesc->sa = d->src;
+	lmdesc->da = d->dest;
+	lmdesc->tb = d->len;
+	lmdesc->chcfg = chcfg;
+	lmdesc->chitvl = 0;
+	lmdesc->chext = 0;
+	lmdesc->header = HEADER_LV;
+
+	set_dmars_register(rzdma, channel->index, dmars);
+
+	channel->chcfg = chcfg;
+	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
+}
+
+static void prepare_descs_for_slave_sg(struct rz_dmac_desc *d)
+{
+	struct dma_chan *chan = d->desc.chan;
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+	struct rz_lmdesc *lmdesc;
+	const struct rz_dmac_slave_config *slave = channel->slave;
+	struct scatterlist *sg, *sgl = d->sg;
+	unsigned int i, sg_len = d->sgcount;
+	u32 chcfg;
+
+	chcfg = channel->slave->chcfg | (CHCFG_SEL(channel->index) | CHCFG_DEM |
+					 CHCFG_DMS);
+
+	if (d->direction == DMA_DEV_TO_MEM)
+		chcfg |= CHCFG_SAD;
+	else
+		chcfg |= CHCFG_DAD;
+
+	channel->chcfg = chcfg;
+	channel->per_address = slave->addr;
+
+	/* Prepare descriptors */
+	lmdesc = channel->lmdesc.tail;
+
+	for (i = 0, sg = sgl; i < sg_len; i++, sg = sg_next(sg)) {
+		if (d->direction == DMA_DEV_TO_MEM) {
+			lmdesc->sa = channel->per_address;
+			lmdesc->da = sg_dma_address(sg);
+		} else {
+			lmdesc->sa = sg_dma_address(sg);
+			lmdesc->da = channel->per_address;
+		}
+
+		lmdesc->tb = sg_dma_len(sg);
+		lmdesc->chitvl = 0;
+		lmdesc->chext = 0;
+		if (i == (sg_len - 1)) {
+			lmdesc->chcfg = (chcfg & ~CHCFG_DEM);
+			lmdesc->header = HEADER_LV;
+		} else {
+			lmdesc->chcfg = chcfg;
+			lmdesc->header = HEADER_LV;
+		}
+		if (++lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
+			lmdesc = channel->lmdesc.base;
+	}
+
+	channel->lmdesc.tail = lmdesc;
+
+	set_dmars_register(rzdma, channel->index, slave->mid_rid);
+	channel->chctrl = CHCTRL_SETEN;
+}
+
+static int rz_dmac_xfer_desc(struct rz_dmac_desc *d)
+{
+	/* Configure and enable */
+	switch (d->type) {
+	case RZ_DMAC_DESC_MEMCPY:
+		prepare_desc_for_memcpy(d);
+		break;
+
+	case RZ_DMAC_DESC_SLAVE_SG:
+		prepare_descs_for_slave_sg(d);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	rz_dmac_enable_hw(d);
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------------
+ * DMA engine operations
+ */
+static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+	const struct rz_dmac_slave_config *slave = rzdma->slave;
+	const struct rz_dmac_slave_config *hit;
+	int slave_num = rzdma->slave_num;
+	u32 *mid_rid = chan->private;
+
+	if (mid_rid) {
+		hit = dma_find_slave(slave, slave_num, *mid_rid);
+		if (!hit)
+			return -ENODEV;
+		channel->slave = hit;
+	}
+
+	while (channel->descs_allocated < RZ_DMAC_MAX_CHAN_DESCRIPTORS) {
+		struct rz_dmac_desc *desc;
+
+		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+		if (!desc)
+			break;
+		memset(&desc->desc, 0, sizeof(struct dma_async_tx_descriptor));
+		dma_async_tx_descriptor_init(&desc->desc, chan);
+		desc->desc.tx_submit = rz_dmac_tx_submit;
+		desc->desc.flags = DMA_CTRL_ACK;
+		desc->status = DMA_COMPLETE;
+
+		list_add_tail(&desc->node, &channel->ld_free);
+		channel->descs_allocated++;
+	}
+
+	if (!channel->descs_allocated)
+		return -ENOMEM;
+
+	return channel->descs_allocated;
+}
+
+static struct dma_async_tx_descriptor *
+rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+			size_t len, unsigned long flags)
+{
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+	struct rz_dmac_desc *desc;
+
+	dev_dbg(rzdma->dev, "%s channel: %d src=0x%llx dst=0x%llx len=%ld\n",
+		__func__, channel->index, src, dest, len);
+
+	if (list_empty(&channel->ld_free))
+		return NULL;
+
+	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+
+	desc->type = RZ_DMAC_DESC_MEMCPY;
+	desc->src = src;
+	desc->dest = dest;
+	desc->len = len;
+	desc->direction = DMA_MEM_TO_MEM;
+	desc->desc.callback = NULL;
+	desc->desc.callback_param = NULL;
+
+	return &desc->desc;
+}
+
+static struct dma_async_tx_descriptor *
+rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		      unsigned int sg_len,
+		      enum dma_transfer_direction direction,
+		      unsigned long flags, void *context)
+{
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct scatterlist *sg;
+	int i, dma_length = 0;
+	struct rz_dmac_desc *desc;
+
+	if (list_empty(&channel->ld_free))
+		return NULL;
+
+	desc = list_first_entry(&channel->ld_free, struct rz_dmac_desc, node);
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_length += sg_dma_len(sg);
+	}
+
+	desc->type = RZ_DMAC_DESC_SLAVE_SG;
+	desc->sg = sgl;
+	desc->sgcount = sg_len;
+	desc->len = dma_length;
+	desc->direction = direction;
+
+	if (direction == DMA_DEV_TO_MEM)
+		desc->src = channel->per_address;
+	else
+		desc->dest = channel->per_address;
+
+	desc->desc.callback = NULL;
+	desc->desc.callback_param = NULL;
+
+	return &desc->desc;
+}
+
+static int rz_dmac_config(struct dma_chan *chan,
+			  struct dma_slave_config *config)
+{
+	struct rz_dmac_channel *rzdmac = to_rz_dmac_chan(chan);
+
+	if (config->direction == DMA_DEV_TO_MEM) {
+		rzdmac->per_address = config->src_addr;
+		rzdmac->word_size = config->src_addr_width;
+	} else {
+		rzdmac->per_address = config->dst_addr;
+		rzdmac->word_size = config->dst_addr_width;
+	}
+
+	return 0;
+}
+
+static void rz_dmac_free_chan_resources(struct dma_chan *chan)
+{
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
+	struct rz_dmac_desc *desc, *_desc;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&channel->lock, flags);
+
+	for (i = 0; i < DMAC_NR_LMDESC; i++)
+		lmdesc[i].header = 0;
+
+	rz_dmac_disable_hw(channel);
+	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
+	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
+
+	spin_unlock_irqrestore(&channel->lock, flags);
+
+	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
+		kfree(desc);
+		channel->descs_allocated--;
+	}
+
+	INIT_LIST_HEAD(&channel->ld_free);
+}
+
+static int rz_dmac_terminate_all(struct dma_chan *chan)
+{
+	struct rz_dmac_channel *rzdmac = to_rz_dmac_chan(chan);
+	struct rz_dmac_engine *rzdma = rzdmac->rzdma;
+	unsigned long flags;
+
+	rz_dmac_disable_hw(rzdmac);
+	spin_lock_irqsave(&rzdma->lock, flags);
+	list_splice_tail_init(&rzdmac->ld_active, &rzdmac->ld_free);
+	list_splice_tail_init(&rzdmac->ld_queue, &rzdmac->ld_free);
+	spin_unlock_irqrestore(&rzdma->lock, flags);
+
+	return 0;
+}
+
+static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	return dma_cookie_status(chan, cookie, txstate);
+}
+
+static void rz_dmac_issue_pending(struct dma_chan *chan)
+{
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+	struct rz_dmac_desc *desc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&channel->lock, flags);
+
+	if (!list_empty(&channel->ld_queue)) {
+		desc = list_first_entry(&channel->ld_queue,
+					struct rz_dmac_desc, node);
+
+		if (rz_dmac_xfer_desc(desc) < 0) {
+			dev_warn(rzdma->dev, "ch: %d couldn't issue DMA xfer\n",
+				 channel->index);
+		} else {
+			list_move_tail(channel->ld_queue.next,
+				       &channel->ld_active);
+		}
+	}
+
+	spin_unlock_irqrestore(&channel->lock, flags);
+}
+
+/* -----------------------------------------------------------------------------
+ * IRQ handling
+ */
+
+static void dma_irq_handle_channel(struct rz_dmac_channel *channel)
+{
+	u32 chstat, chctrl;
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+
+	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
+	if (chstat & CHSTAT_ER) {
+		dev_err(rzdma->dev, "DMAC err CHSTAT_%d = %08X\n",
+			channel->index, chstat);
+		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+		goto done;
+	}
+
+	chctrl = rz_dmac_ch_readl(channel, CHCTRL, 1);
+	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
+done:
+	return;
+}
+
+static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
+{
+	struct rz_dmac_channel *channel = dev_id;
+
+	if (channel) {
+		dma_irq_handle_channel(channel);
+		return IRQ_WAKE_THREAD;
+	}
+	/* handle DMAERR irq */
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
+{
+	struct rz_dmac_channel *channel = dev_id;
+	struct rz_dmac_desc *desc = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&channel->lock, flags);
+
+	if (list_empty(&channel->ld_active)) {
+		/* Someone might have called terminate all */
+		goto out;
+	}
+
+	desc = list_first_entry(&channel->ld_active, struct rz_dmac_desc, node);
+
+	dma_cookie_complete(&desc->desc);
+	list_move_tail(channel->ld_active.next, &channel->ld_free);
+
+	if (!list_empty(&channel->ld_queue)) {
+		desc = list_first_entry(&channel->ld_queue, struct rz_dmac_desc,
+					node);
+		if (rz_dmac_xfer_desc(desc) == 0)
+			list_move_tail(channel->ld_queue.next,
+				       &channel->ld_active);
+	}
+out:
+	spin_unlock_irqrestore(&channel->lock, flags);
+	if (desc)
+		dmaengine_desc_get_callback_invoke(&desc->desc, NULL);
+
+	return IRQ_HANDLED;
+}
+
+/* -----------------------------------------------------------------------------
+ * OF xlate and channel filter
+ */
+
+static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg)
+{
+	struct rz_dmac_channel *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac_engine *rzdma = channel->rzdma;
+	struct of_phandle_args *dma_spec = arg;
+	const struct rz_dmac_slave_config *hit;
+	u32 mid_rid = dma_spec->args[0];
+
+	hit = dma_find_slave(rzdma->slave, rzdma->slave_num, mid_rid);
+	if (hit)
+		channel->slave = hit;
+
+	return hit;
+}
+
+static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
+{
+	dma_cap_mask_t mask;
+
+	if (dma_spec->args_count != 1)
+		return NULL;
+
+	/* Only slave DMA channels can be allocated via DT */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	return dma_request_channel(mask, rz_dmac_chan_filter, dma_spec);
+}
+
+/* -----------------------------------------------------------------------------
+ * Probe and remove
+ */
+
+static int rz_dmac_chan_probe(struct rz_dmac_engine *rzdma, unsigned int index)
+{
+	struct platform_device *pdev = to_platform_device(rzdma->dev);
+	struct rz_dmac_channel *channel = &rzdma->channel[index];
+	char pdev_irqname[5];
+	struct rz_lmdesc *lmdesc;
+	char *irqname;
+	int ret;
+
+	channel->rzdma = rzdma;
+	channel->index = index;
+
+	spin_lock_init(&channel->lock);
+
+	INIT_LIST_HEAD(&channel->ld_queue);
+	INIT_LIST_HEAD(&channel->ld_free);
+	INIT_LIST_HEAD(&channel->ld_active);
+
+	/* Request the channel interrupt. */
+	sprintf(pdev_irqname, "ch%u", index);
+	channel->irq = platform_get_irq_byname(pdev, pdev_irqname);
+	if (channel->irq < 0) {
+		dev_err(rzdma->dev, "no IRQ specified for channel %u\n", index);
+		return -ENODEV;
+	}
+
+	irqname = devm_kasprintf(rzdma->dev, GFP_KERNEL, "%s:%u",
+				 dev_name(rzdma->dev), index);
+	if (!irqname)
+		return -ENOMEM;
+
+	ret = devm_request_threaded_irq(rzdma->dev, channel->irq,
+					rz_dmac_irq_handler,
+					rz_dmac_irq_handler_thread, 0,
+					irqname, channel);
+	if (ret) {
+		dev_err(rzdma->dev, "request IRQ failed%u (%d)\n",
+			channel->irq, ret);
+		return ret;
+	}
+
+	channel->chan.device = &rzdma->dma_device;
+	dma_cookie_init(&channel->chan);
+
+	/* Set io base address for each channel */
+	if (index < 8) {
+		channel->ch_base = rzdma->base + CHANNEL_0_7_OFFSET +
+			EACH_CHANNEL_OFFSET * index;
+		channel->ch_cmn_base = rzdma->base + CHANNEL_0_7_COMMON_BASE;
+	} else {
+		channel->ch_base = rzdma->base + CHANNEL_8_15_OFFSET +
+			EACH_CHANNEL_OFFSET * (index - 8);
+		channel->ch_cmn_base = rzdma->base + CHANNEL_8_15_COMMON_BASE;
+	}
+	/* Allocate descriptors */
+	lmdesc = dma_alloc_coherent(&pdev->dev,
+				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
+				    &channel->lmdesc.base_dma, GFP_KERNEL);
+	if (!lmdesc) {
+		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
+		return -ENOMEM;
+	}
+	rz_lmdesc_setup(channel, lmdesc);
+
+	/* Add the channel to the DMAC list */
+	list_add_tail(&channel->chan.device_node,
+		      &rzdma->dma_device.channels);
+
+	/* Initialize register for each channel */
+	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+
+	return 0;
+}
+
+#define RZ_DMAC_MAX_CHANNELS	16
+
+static int rz_dmac_parse_of(struct device *dev, struct rz_dmac_engine *rzdma)
+{
+	struct device_node *np = dev->of_node;
+	u32 *dmacfg;
+	int i = 0;
+	int n_slaves;
+	int ret;
+
+	ret = of_property_read_u32(np, "dma-channels", &rzdma->n_channels);
+	if (ret < 0) {
+		dev_err(dev, "unable to read dma-channels property\n");
+		return ret;
+	}
+
+	if (rzdma->n_channels <= 0 ||
+	    rzdma->n_channels > RZ_DMAC_MAX_CHANNELS) {
+		dev_err(dev, "invalid number of channels %u\n",
+			rzdma->n_channels);
+		return -EINVAL;
+	}
+
+	n_slaves = of_property_count_elems_of_size(np,
+						   "renesas,rz-dmac-slavecfg",
+						   3 * sizeof(u32));
+	if (n_slaves < 0) {
+		dev_warn(dev, "No setting for slave found or %s\n",
+			 "rz-dmac-slavecfg property is not multiple of 3");
+		n_slaves = 0;
+		goto done;
+	}
+
+	rzdma->slave = devm_kzalloc(dev,
+				    sizeof(struct rz_dmac_slave_config) * n_slaves,
+				    GFP_KERNEL);
+	if (!rzdma->slave)
+		return -ENOMEM;
+
+	dmacfg = kcalloc(n_slaves, sizeof(u32), GFP_KERNEL);
+	if (!dmacfg)
+		return -ENOMEM;
+
+	if (of_property_read_u32_array(np, "renesas,rz-dmac-slavecfg",
+				       dmacfg, n_slaves * 3)) {
+		dev_err(dev, "unable to read rz-dmac-slavecfg property\n");
+		kfree(dmacfg);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < n_slaves; i++) {
+		rzdma->slave[i].mid_rid	= *dmacfg++;
+		rzdma->slave[i].addr = *dmacfg++;
+		rzdma->slave[i].chcfg = *dmacfg++;
+	}
+
+	kfree(dmacfg);
+done:
+	rzdma->slave_num = n_slaves;
+
+	return 0;
+}
+
+static int rz_dmac_probe(struct platform_device *pdev)
+{
+	const char *irqname = "error";
+	struct rz_dmac_engine *rzdma;
+	int channel_num;
+	int ret, i;
+	int irq;
+
+	rzdma = devm_kzalloc(&pdev->dev, sizeof(*rzdma), GFP_KERNEL);
+	if (!rzdma)
+		return -ENOMEM;
+
+	rzdma->dev = &pdev->dev;
+	rzdma->dma_device.dev = &pdev->dev;
+	platform_set_drvdata(pdev, rzdma);
+
+	ret = rz_dmac_parse_of(&pdev->dev, rzdma);
+	if (ret < 0)
+		return ret;
+
+	channel_num = rzdma->n_channels;
+
+	/* Request resources */
+	rzdma->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rzdma->base))
+		return PTR_ERR(rzdma->base);
+
+	rzdma->ext_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(rzdma->ext_base))
+		return PTR_ERR(rzdma->ext_base);
+
+	/* Register interrupt handler for error */
+	irq = platform_get_irq_byname(pdev, irqname);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no error IRQ specified\n");
+		return -ENODEV;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
+			       irqname, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
+			irq, ret);
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&rzdma->dma_device.channels);
+	dma_cap_set(DMA_SLAVE, rzdma->dma_device.cap_mask);
+	dma_cap_set(DMA_MEMCPY, rzdma->dma_device.cap_mask);
+	spin_lock_init(&rzdma->lock);
+
+	rzdma->channel = devm_kzalloc(&pdev->dev,
+				      sizeof(struct rz_dmac_channel) * channel_num,
+				      GFP_KERNEL);
+	if (!rzdma->channel)
+		return -ENOMEM;
+
+	for (i = 0; i < channel_num; i++) {
+		ret = rz_dmac_chan_probe(rzdma, i);
+		if (ret < 0)
+			goto err;
+	}
+
+	/* Register the DMAC as a DMA provider for DT. */
+	if (of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
+				       NULL) < 0)
+		dev_err(&pdev->dev, "unable to register as provider for DT\n");
+
+	/* Initialize register for all channels */
+	rz_dmac_writel(rzdma, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
+	rz_dmac_writel(rzdma, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
+
+	rzdma->dma_device.device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
+	rzdma->dma_device.device_free_chan_resources = rz_dmac_free_chan_resources;
+	rzdma->dma_device.device_tx_status = rz_dmac_tx_status;
+	rzdma->dma_device.device_prep_slave_sg = rz_dmac_prep_slave_sg;
+	rzdma->dma_device.device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
+	rzdma->dma_device.device_config = rz_dmac_config;
+	rzdma->dma_device.device_terminate_all = rz_dmac_terminate_all;
+	rzdma->dma_device.device_issue_pending = rz_dmac_issue_pending;
+
+	rzdma->dma_device.copy_align = 0;
+	rzdma->dma_device.dev->dma_parms = &rzdma->dma_parms;
+	dma_set_max_seg_size(rzdma->dma_device.dev, 0xffffff);
+
+	ret = dma_async_device_register(&rzdma->dma_device);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register\n");
+		goto dma_register_err;
+	}
+	return 0;
+
+dma_register_err:
+	of_dma_controller_free(pdev->dev.of_node);
+err:
+	channel_num = i ? i - 1 : 0;
+	for (i = 0; i < channel_num; i++) {
+		struct rz_dmac_channel *channel = &rzdma->channel[i];
+
+		dma_free_coherent(NULL,
+				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
+				  channel->lmdesc.base,
+				  channel->lmdesc.base_dma);
+	}
+
+	return ret;
+}
+
+static int rz_dmac_remove(struct platform_device *pdev)
+{
+	struct rz_dmac_engine *rzdma = platform_get_drvdata(pdev);
+	int i, channel_num = rzdma->n_channels;
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&rzdma->dma_device);
+
+	/* free allocated resources */
+	for (i = 0; i < channel_num; i++) {
+		struct rz_dmac_channel *channel = &rzdma->channel[i];
+
+		dma_free_coherent(NULL,
+				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
+				  channel->lmdesc.base,
+				  channel->lmdesc.base_dma);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_rz_dmac_match[] = {
+	{ .compatible = "renesas,rz-dmac", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
+
+static struct platform_driver rz_dmac_driver = {
+	.driver		= {
+		.name	= "rz-dmac",
+		.of_match_table = of_rz_dmac_match,
+	},
+	.probe		= rz_dmac_probe,
+	.remove		= rz_dmac_remove,
+};
+
+module_platform_driver(rz_dmac_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/G2L DMA Controller Driver");
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

