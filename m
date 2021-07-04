Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43D63BADB0
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jul 2021 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhGDPgb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jul 2021 11:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhGDPgb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jul 2021 11:36:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A5C061574;
        Sun,  4 Jul 2021 08:33:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i184so1123545pfc.12;
        Sun, 04 Jul 2021 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GI3UkFSBlHkzW6/IVpElzjLEaMHm10aJpkexaBJwf+g=;
        b=R8UZVvtbjX8zkiEuHrf+/7qrqV+l0zkRq0OiyXv1iQlQZ5VsnPEiGLIwIjf4isqo3U
         mcd1gdZd05su8D6see+YmlzY3uL4VZLWSx7F2emb4Egir/xCfMAbW/Ujd12rqXJx1XWZ
         BDEhqIgXuRYk3zQd3z2F232z8wfjbh0PP0/cVvJi8xWzv68pdseEWFjaxdxldF8iBQoA
         D7tJKnbQUxzq+3IFlpvY4EaG//KaV67S8lSDTmNwlbr/EIGv0BBLJxV+gvuKZH0Wl69k
         fJRPT4jtsuTLQfYfwAvKMRMQkFvdBbxp6VLNoOd+d/MIoXvIKiSgnkLMquElWGKcXFYJ
         j8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GI3UkFSBlHkzW6/IVpElzjLEaMHm10aJpkexaBJwf+g=;
        b=bMFy62dboQ9UvFOnkirCmv1UW1vlqgSpJD05mgB0oW6femI+rZaF6+MOpAMYcHJ9dF
         hiCxWT4E8IxWgIqBDLq/gY8yC2MDlH02pHF/lT/SwxpGs3t1Fx6+kBeol3YYyqylElLU
         jCQxVUH4D7mjdTb/26XrBT/ezkXFkkB7qfwQNpUP48R5Z3sKBLsfa5dvNPYYWmUSpOya
         FoJ5dpumDPbNlOMKO/v2IlvZTOeZoTTj7grXuV2tVOZvrXU9zjZgyGa704aL8uCfG6WO
         6MJWJQ0bxFf9hNRFrQIUVTC2WEjq40v71lh47DTQjct4d+lN4pjXZv5oYI8zLBpwT2P6
         kcHA==
X-Gm-Message-State: AOAM531gt+5k+LqByVqnPA7dQIC5eGbx9dlKYzkqw8U5qEwIZOL9/y7L
        +uAI5PDuxyXnqU+tQe3iCWKybADLwrE=
X-Google-Smtp-Source: ABdhPJwvcjC++ojtcNG17LK4HJF6wSKzfzYzo3NRBzOqLGUGGwevCEzjC3n3R7J6YVlOzaAskN6Xaw==
X-Received: by 2002:a63:f901:: with SMTP id h1mr10905569pgi.69.1625412834946;
        Sun, 04 Jul 2021 08:33:54 -0700 (PDT)
Received: from kelvin-System-Product-Name.lan ([112.45.97.84])
        by smtp.gmail.com with ESMTPSA id n47sm2013818pfv.55.2021.07.04.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 08:33:54 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Date:   Sun,  4 Jul 2021 23:33:14 +0800
Message-Id: <20210704153314.6995-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch adds DMA Engine driver for Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
V4 -> V5:
   Drop superfluous log.
   Fix coding style.
   Submitting next txn as fast as possible.
V3 -> V4:
   Use dma_slave_map to find the proper channel.
   Explicitly call devm_request_irq() and tasklet_kill().
   Fix namespace issue.
   Some minor fixes and cleanups.
V2 -> V3:
   Rename ls1x_dma_filter_fn to ls1x_dma_filter.
V1 -> V2:
   Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
   and rearrange it in alphabetical order in Kconfig and Makefile.
   Fix comment style.
---
 drivers/dma/Kconfig         |   9 +
 drivers/dma/Makefile        |   1 +
 drivers/dma/loongson1-dma.c | 505 ++++++++++++++++++++++++++++++++++++
 3 files changed, 515 insertions(+)
 create mode 100644 drivers/dma/loongson1-dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6ab9d9a488a6..b3ceeae61483 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -343,6 +343,15 @@ config K3_DMA
 	  Support the DMA engine for Hisilicon K3 platform
 	  devices.
 
+config LOONGSON1_DMA
+	tristate "Loongson1 DMA support"
+	depends on MACH_LOONGSON32
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  This selects support for the DMA controller in Loongson1 SoCs,
+	  and is required by Loongson1 NAND controller and AC97 support.
+
 config LPC18XX_DMAMUX
 	bool "NXP LPC18xx/43xx DMA MUX for PL080"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index aa69094e3547..6d54e485036e 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_INTEL_IOATDMA) += ioat/
 obj-$(CONFIG_INTEL_IDXD) += idxd/
 obj-$(CONFIG_INTEL_IOP_ADMA) += iop-adma.o
 obj-$(CONFIG_K3_DMA) += k3dma.o
+obj-$(CONFIG_LOONGSON1_DMA) += loongson1-dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
 obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
 obj-$(CONFIG_MILBEAUT_XDMAC) += milbeaut-xdmac.o
diff --git a/drivers/dma/loongson1-dma.c b/drivers/dma/loongson1-dma.c
new file mode 100644
index 000000000000..5623563c5413
--- /dev/null
+++ b/drivers/dma/loongson1-dma.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DMA Driver for Loongson 1 SoC
+ *
+ * Copyright (C) 2015-2021 Zhang, Keguang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/dmapool.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dma.h>
+
+#include "dmaengine.h"
+#include "virt-dma.h"
+
+/* Loongson 1 DMA Register Definitions */
+#define LS1X_DMA_CTRL		0x0
+
+/* DMA Control Register Bits */
+#define LS1X_DMA_STOP		BIT(4)
+#define LS1X_DMA_START		BIT(3)
+
+#define LS1X_DMA_ADDR_MASK	GENMASK(31, 6)
+
+/* DMA Command Register Bits */
+#define LS1X_DMA_RAM2DEV		BIT(12)
+#define LS1X_DMA_TRANS_OVER		BIT(3)
+#define LS1X_DMA_SINGLE_TRANS_OVER	BIT(2)
+#define LS1X_DMA_INT			BIT(1)
+#define LS1X_DMA_INT_MASK		BIT(0)
+
+struct ls1x_dma_lli {
+	u32 next;		/* next descriptor address */
+	u32 saddr;		/* memory DMA address */
+	u32 daddr;		/* device DMA address */
+	u32 length;
+	u32 stride;
+	u32 cycles;
+	u32 cmd;
+} __aligned(64);
+
+struct ls1x_dma_hwdesc {
+	struct ls1x_dma_lli *lli;
+	dma_addr_t phys;
+};
+
+struct ls1x_dma_desc {
+	struct virt_dma_desc vdesc;
+	struct ls1x_dma_chan *chan;
+
+	enum dma_transfer_direction dir;
+	enum dma_transaction_type type;
+
+	unsigned int nr_descs;	/* number of descriptors */
+	unsigned int nr_done;	/* number of completed descriptors */
+	struct ls1x_dma_hwdesc hwdesc[];	/* DMA coherent descriptors */
+};
+
+struct ls1x_dma_chan {
+	struct virt_dma_chan vchan;
+	struct dma_pool *desc_pool;
+	struct dma_slave_config cfg;
+
+	unsigned int id;
+	void __iomem *reg_base;
+	unsigned int irq;
+
+	struct ls1x_dma_desc *desc;
+};
+
+struct ls1x_dma {
+	struct dma_device ddev;
+	struct clk *clk;
+	void __iomem *reg_base;
+
+	unsigned int nr_chans;
+	struct ls1x_dma_chan chan[];
+};
+
+#define to_ls1x_dma_chan(dchan)		\
+	container_of(dchan, struct ls1x_dma_chan, vchan.chan)
+
+#define to_ls1x_dma_desc(vdesc)		\
+	container_of(vdesc, struct ls1x_dma_desc, vdesc)
+
+/* macros for registers read/write */
+#define chan_readl(chan, off)		\
+	readl((chan)->reg_base + (off))
+
+#define chan_writel(chan, off, val)	\
+	writel((val), (chan)->reg_base + (off))
+
+static bool ls1x_dma_filter(struct dma_chan *chan, void *param);
+
+static inline struct device *chan2dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
+static void ls1x_dma_free_chan_resources(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+
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
+					  dchan->device->dev,
+					  sizeof(struct ls1x_dma_lli),
+					  __alignof__(struct ls1x_dma_lli), 0);
+	if (!chan->desc_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
+{
+	struct ls1x_dma_desc *desc = to_ls1x_dma_desc(vdesc);
+
+	if (desc->nr_descs) {
+		unsigned int i = desc->nr_descs;
+		struct ls1x_dma_hwdesc *hwdesc;
+
+		do {
+			hwdesc = &desc->hwdesc[--i];
+			dma_pool_free(desc->chan->desc_pool, hwdesc->lli,
+				      hwdesc->phys);
+		} while (i);
+	}
+
+	kfree(desc);
+}
+
+static struct ls1x_dma_desc *ls1x_dma_alloc_desc(struct ls1x_dma_chan *chan, int sg_len)
+{
+	struct ls1x_dma_desc *desc;
+
+	desc = kzalloc(struct_size(desc, hwdesc, sg_len), GFP_NOWAIT);
+
+	return desc;
+}
+
+static struct dma_async_tx_descriptor *
+ls1x_dma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+		       unsigned int sg_len,
+		       enum dma_transfer_direction direction,
+		       unsigned long flags, void *context)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	struct dma_slave_config *cfg = &chan->cfg;
+	struct ls1x_dma_desc *desc;
+	struct scatterlist *sg;
+	unsigned int dev_addr, bus_width, cmd, i;
+
+	if (!is_slave_direction(direction)) {
+		dev_err(chan2dev(dchan), "invalid DMA direction!\n");
+		return NULL;
+	}
+
+	dev_dbg(chan2dev(dchan), "sg_len=%d, dir=%s, flags=0x%lx\n", sg_len,
+		direction == DMA_MEM_TO_DEV ? "to device" : "from device",
+		flags);
+
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		dev_addr = cfg->dst_addr;
+		bus_width = cfg->dst_addr_width;
+		cmd = LS1X_DMA_RAM2DEV | LS1X_DMA_INT;
+		break;
+	case DMA_DEV_TO_MEM:
+		dev_addr = cfg->src_addr;
+		bus_width = cfg->src_addr_width;
+		cmd = LS1X_DMA_INT;
+		break;
+	default:
+		dev_err(chan2dev(dchan),
+			"unsupported DMA transfer direction! %d\n", direction);
+		return NULL;
+	}
+
+	/* allocate DMA descriptor */
+	desc = ls1x_dma_alloc_desc(chan, sg_len);
+	if (!desc)
+		return NULL;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t buf_addr = sg_dma_address(sg);
+		size_t buf_len = sg_dma_len(sg);
+		struct ls1x_dma_hwdesc *hwdesc = &desc->hwdesc[i];
+		struct ls1x_dma_lli *lli;
+
+		if (!is_dma_copy_aligned(dchan->device, buf_addr, 0, buf_len)) {
+			dev_err(chan2dev(dchan), "%s: buffer is not aligned!\n",
+				__func__);
+			goto err;
+		}
+
+		/* allocate HW DMA descriptors */
+		lli = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT,
+				     &hwdesc->phys);
+		if (!lli) {
+			dev_err(chan2dev(dchan),
+				"%s: failed to alloc HW DMA descriptor!\n",
+				__func__);
+			goto err;
+		}
+		hwdesc->lli = lli;
+
+		/* config HW DMA descriptors */
+		lli->saddr = buf_addr;
+		lli->daddr = dev_addr;
+		lli->length = buf_len / bus_width;
+		lli->stride = 0;
+		lli->cycles = 1;
+		lli->cmd = cmd;
+		lli->next = 0;
+
+		if (i)
+			desc->hwdesc[i - 1].lli->next = hwdesc->phys;
+
+		dev_dbg(chan2dev(dchan),
+			"hwdesc=%px, saddr=%08x, daddr=%08x, length=%u\n",
+			hwdesc, buf_addr, dev_addr, buf_len);
+	}
+
+	/* config DMA descriptor */
+	desc->chan = chan;
+	desc->dir = direction;
+	desc->type = DMA_SLAVE;
+	desc->nr_descs = sg_len;
+	desc->nr_done = 0;
+
+	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
+err:
+	desc->nr_descs = i;
+	ls1x_dma_free_desc(&desc->vdesc);
+	return NULL;
+}
+
+static int ls1x_dma_slave_config(struct dma_chan *dchan,
+				 struct dma_slave_config *config)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+
+	chan->cfg = *config;
+
+	return 0;
+}
+
+static int ls1x_dma_terminate_all(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+
+	chan_writel(chan, LS1X_DMA_CTRL,
+		    chan_readl(chan, LS1X_DMA_CTRL) | LS1X_DMA_STOP);
+	chan->desc = NULL;
+	vchan_get_all_descriptors(&chan->vchan, &head);
+
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	vchan_dma_desc_free_list(&chan->vchan, &head);
+
+	return 0;
+}
+
+static void ls1x_dma_trigger(struct ls1x_dma_chan *chan)
+{
+	struct dma_chan *dchan = &chan->vchan.chan;
+	struct ls1x_dma_desc *desc;
+	struct virt_dma_desc *vdesc;
+	unsigned int val;
+
+	vdesc = vchan_next_desc(&chan->vchan);
+	if (!vdesc) {
+		chan->desc = NULL;
+		return;
+	}
+	chan->desc = desc = to_ls1x_dma_desc(vdesc);
+
+	dev_dbg(chan2dev(dchan), "cookie=%d, %u descs, starting hwdesc=%px\n",
+		dchan->cookie, desc->nr_descs, &desc->hwdesc[0]);
+
+	val = desc->hwdesc[0].phys & LS1X_DMA_ADDR_MASK;
+	val |= chan->id;
+	val |= LS1X_DMA_START;
+	chan_writel(chan, LS1X_DMA_CTRL, val);
+}
+
+static void ls1x_dma_issue_pending(struct dma_chan *dchan)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+
+	if (vchan_issue_pending(&chan->vchan) && !chan->desc)
+		ls1x_dma_trigger(chan);
+
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+}
+
+static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
+{
+	struct ls1x_dma_chan *chan = data;
+	struct dma_chan *dchan = &chan->vchan.chan;
+
+	dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel %d\n", irq, chan->id);
+	if (!chan->desc) {
+		dev_warn(chan2dev(dchan),
+			 "DMA IRQ with no active descriptor on channel %d\n", chan->id);
+		return IRQ_NONE;
+	}
+
+	spin_lock(&chan->vchan.lock);
+
+	if (chan->desc->type == DMA_CYCLIC) {
+		vchan_cyclic_callback(&chan->desc->vdesc);
+	} else {
+		list_del(&chan->desc->vdesc.node);
+		vchan_cookie_complete(&chan->desc->vdesc);
+		chan->desc = NULL;
+	}
+
+	ls1x_dma_trigger(chan);
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
+	char *irq_name;
+	int ret;
+
+	chan->irq = platform_get_irq(pdev, chan_id);
+	if (chan->irq < 0) {
+		dev_err(dev, "failed to get IRQ %d!\n", chan->irq);
+		return ret;
+	}
+
+	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%u",
+				  dev_name(dev), chan_id);
+	if (!irq_name)
+		return -ENOMEM;
+
+	ret = devm_request_irq(dev, chan->irq, ls1x_dma_irq_handler,
+			       IRQF_SHARED, irq_name, chan);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ %u!\n", chan->irq);
+		return ret;
+	}
+
+	chan->id = chan_id;
+	chan->reg_base = dma->reg_base;
+	chan->vchan.desc_free = ls1x_dma_free_desc;
+	vchan_init(&chan->vchan, &dma->ddev);
+	dev_info(dev, "channel %d (irq %d) initialized\n", chan->id, chan->irq);
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
+	struct plat_ls1x_dma *pdata;
+	struct dma_device *ddev;
+	struct ls1x_dma *dma;
+	int nr_chans, ret, i;
+
+	pdata = dev_get_platdata(dev);
+	if (!pdata) {
+		dev_err(dev, "platform data missing!\n");
+		return -EINVAL;
+	}
+
+	nr_chans = platform_irq_count(pdev);
+	if (nr_chans <= 0)
+		return nr_chans;
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
+	ddev->copy_align = DMAENGINE_ALIGN_16_BYTES;
+	ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	ddev->device_alloc_chan_resources = ls1x_dma_alloc_chan_resources;
+	ddev->device_free_chan_resources = ls1x_dma_free_chan_resources;
+	ddev->device_prep_slave_sg = ls1x_dma_prep_slave_sg;
+	ddev->device_config = ls1x_dma_slave_config;
+	ddev->device_terminate_all = ls1x_dma_terminate_all;
+	ddev->device_tx_status = dma_cookie_status;
+	ddev->device_issue_pending = ls1x_dma_issue_pending;
+	ddev->filter.map = pdata->slave_map;
+	ddev->filter.mapcnt = pdata->slavecnt;
+	ddev->filter.fn = ls1x_dma_filter;
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
+	dma->clk = devm_clk_get(dev, pdev->name);
+	if (IS_ERR(dma->clk)) {
+		dev_err(dev, "failed to get %s clock!\n", pdev->name);
+		return PTR_ERR(dma->clk);
+	}
+	clk_prepare_enable(dma->clk);
+
+	ret = dma_async_device_register(ddev);
+	if (ret) {
+		dev_err(dev, "failed to register DMA device! %d\n", ret);
+		clk_disable_unprepare(dma->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, dma);
+	dev_info(dev, "Loongson1 DMA driver registered\n");
+
+	return 0;
+}
+
+static int ls1x_dma_remove(struct platform_device *pdev)
+{
+	struct ls1x_dma *dma = platform_get_drvdata(pdev);
+	int i;
+
+	dma_async_device_unregister(&dma->ddev);
+	clk_disable_unprepare(dma->clk);
+	for (i = 0; i < dma->nr_chans; i++)
+		ls1x_dma_chan_remove(dma, i);
+
+	return 0;
+}
+
+static struct platform_driver ls1x_dma_driver = {
+	.probe	= ls1x_dma_probe,
+	.remove	= ls1x_dma_remove,
+	.driver	= {
+		.name	= "ls1x-dma",
+	},
+};
+
+module_platform_driver(ls1x_dma_driver);
+
+static bool ls1x_dma_filter(struct dma_chan *dchan, void *param)
+{
+	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
+	unsigned int chan_id = (unsigned int)param;
+
+	if (dchan->device->dev->driver != &ls1x_dma_driver.driver)
+		return false;
+
+	return chan_id == chan->id;
+}
+
+MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson1 DMA driver");
+MODULE_LICENSE("GPL");

base-commit: 8d11cfb0c37547bd6b1cdc7c2653c1e6b5ec5abb
-- 
2.30.2

