Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9834E7B1C14
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjI1MU2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjI1MU1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 08:20:27 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2BC1A7;
        Thu, 28 Sep 2023 05:20:20 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57de9237410so1617258eaf.0;
        Thu, 28 Sep 2023 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695903619; x=1696508419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0ObWSCrEKMqZKVtScnUbho+gsXpuFOGTcqdGB5Z+Hg=;
        b=Xb3gi/RVtLI6E6kE/Z4XQMzllcok9O1nq47MCLUlhrSD4fPtHHU6Hzgd80BQiutmho
         UX17effwGXAIEcDLTl2yNCOP7Rva9KOD3c0cd40zq489sWMy//HlW4myVjqI6oQyBjyU
         Jcb8URCe5lqzHNJzWXS3E1y6ozlFY2qL0w0ipDcskW6sjEh6j+QlQtS6bxnpNYUicF5q
         mVzi2iiUlr34b5PFSurwEOoKNDAoSQQFO3JgaiS/auGTBuEBwE8e7GqVl4awcnhTSvUX
         ilFdNTNLQtd4VoAIFv4kWl+IKT3ro/jC8yuMynJp1d2gwgVk7A4lApPGfvK2/8TJ9gYu
         qvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695903619; x=1696508419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0ObWSCrEKMqZKVtScnUbho+gsXpuFOGTcqdGB5Z+Hg=;
        b=WN0sjWWrRHm/9aZY+npirbi0E8hJHUneA7dTapcRQRdJ7cSAVsnJU1AAjovzRP89bZ
         VJx9KJDY8+L3/i9gyTZwaenxmQmU+WyK855/P0BZk6O/P99gZuCauX1WbsO6bB9xbax7
         yKJNsUEQ3oMNHCZJZnZ1XzlI2Av5y0frm7rny3XFHr5YopADfdrXLmQ7b24eLXCLAvnX
         AHrdVWvGE9+dWZUWh52J0cTDzK1fBaEObxjwYzS8+JrqTh7Sf0gk07QmqhUtZnGnFxHU
         DdwDZTVEu6+0GVqXqJbhlZhrmBlxGOyAVA/CU18pjYe2D4vELrA7hWi5t6KHMrGMNadg
         sHaw==
X-Gm-Message-State: AOJu0YxxMNOzkUtcW1S4jAX77p+fG1P9e0y80z+iJ+NKIVyCzKsvdoYy
        VRTn0OC6bxIv1oj/K1PJknp3D3ArjIAZJA==
X-Google-Smtp-Source: AGHT+IEOwycpQuGsaBls70n2VSgzcyDQMXisMvep4XTBdanDt3iqltVELfZ169Ek3d7PHOYjQxkOFg==
X-Received: by 2002:a05:6358:725:b0:142:fd2b:da2e with SMTP id e37-20020a056358072500b00142fd2bda2emr908499rwj.31.1695903619507;
        Thu, 28 Sep 2023 05:20:19 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006933f85bc29sm2183219pfd.111.2023.09.28.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:20:19 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v5 2/2] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Date:   Thu, 28 Sep 2023 20:19:53 +0800
Message-Id: <20230928121953.524608-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928121953.524608-1-keguang.zhang@gmail.com>
References: <20230928121953.524608-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds DMA Engine driver for Loongson1 SoCs.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V4 -> V5:
   Add DT support
   Use DT data instead of platform data
   Use chan_id of struct dma_chan instead of own id
   Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
   Update the author information to my official name
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

 drivers/dma/Kconfig         |   9 +
 drivers/dma/Makefile        |   1 +
 drivers/dma/loongson1-dma.c | 492 ++++++++++++++++++++++++++++++++++++
 3 files changed, 502 insertions(+)
 create mode 100644 drivers/dma/loongson1-dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 4ccae1a3b884..0b0d5c61b4a0 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -369,6 +369,15 @@ config K3_DMA
 	  Support the DMA engine for Hisilicon K3 platform
 	  devices.
 
+config LOONGSON1_DMA
+	tristate "Loongson1 DMA support"
+	depends on MACH_LOONGSON32
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  This selects support for the DMA controller in Loongson1 SoCs,
+	  which is required by Loongson1 NAND and AC97 support.
+
 config LPC18XX_DMAMUX
 	bool "NXP LPC18xx/43xx DMA MUX for PL080"
 	depends on ARCH_LPC18XX || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 83553a97a010..887103db5ee3 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_INTEL_IDMA64) += idma64.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioat/
 obj-y += idxd/
 obj-$(CONFIG_K3_DMA) += k3dma.o
+obj-$(CONFIG_LOONGSON1_DMA) += loongson1-dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
 obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
 obj-$(CONFIG_MILBEAUT_XDMAC) += milbeaut-xdmac.o
diff --git a/drivers/dma/loongson1-dma.c b/drivers/dma/loongson1-dma.c
new file mode 100644
index 000000000000..b589103d5ae0
--- /dev/null
+++ b/drivers/dma/loongson1-dma.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DMA Driver for Loongson-1 SoC
+ *
+ * Copyright (C) 2015-2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/dmapool.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
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
+#define LS1X_DMA_MAX_CHANNELS	3
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
+	void __iomem *reg_base;
+	int irq;
+
+	struct ls1x_dma_desc *desc;
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
+static struct ls1x_dma_desc *ls1x_dma_alloc_desc(struct ls1x_dma_chan *chan,
+						 int sg_len)
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
+	val |= dchan->chan_id;
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
+	dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel %d\n", irq,
+		dchan->chan_id);
+	if (!chan->desc) {
+		dev_warn(chan2dev(dchan),
+			 "DMA IRQ with no active descriptor on channel %d\n",
+			 dchan->chan_id);
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
+			       0, irqname, chan);
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
+static int ls1x_dma_remove(struct platform_device *pdev)
+{
+	struct ls1x_dma *dma = platform_get_drvdata(pdev);
+	int i;
+
+	of_dma_controller_free(pdev->dev.of_node);
+
+	for (i = 0; i < dma->nr_chans; i++)
+		ls1x_dma_chan_remove(dma, i);
+
+	return 0;
+}
+
+static const struct of_device_id ls1x_dma_match[] = {
+	{ .compatible = "loongson,ls1b-dma" },
+	{ .compatible = "loongson,ls1c-dma" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_dma_match);
+
+static struct platform_driver ls1x_dma_driver = {
+	.probe	= ls1x_dma_probe,
+	.remove	= ls1x_dma_remove,
+	.driver	= {
+		.name	= "ls1x-dma",
+		.of_match_table = ls1x_dma_match,
+	},
+};
+
+module_platform_driver(ls1x_dma_driver);
+
+MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson-1 DMA driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2

