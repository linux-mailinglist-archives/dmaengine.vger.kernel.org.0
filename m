Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D3717AAD
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 10:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjEaIvJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjEaIua (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 04:50:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 052301B4;
        Wed, 31 May 2023 01:50:23 -0700 (PDT)
Received: from loongson.cn (unknown [223.106.25.146])
        by gateway (Coremail) with SMTP id _____8DxDOtOCndkyugCAA--.2084S3;
        Wed, 31 May 2023 16:50:22 +0800 (CST)
Received: from localhost.localdomain (unknown [223.106.25.146])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxKL1ICndkqxyCAA--.14919S4;
        Wed, 31 May 2023 16:50:21 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Yingkun Meng <mengyingkun@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 2/2] dmaengine: ls2x-apb: new driver for the Loongson LS2X APB DMA controller
Date:   Wed, 31 May 2023 16:50:05 +0800
Message-Id: <f65ebee39b5e1827af08d9e8d1f260928915f9b0.1685448898.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1685448898.git.zhoubinbin@loongson.cn>
References: <cover.1685448898.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxKL1ICndkqxyCAA--.14919S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfXFy3Jw15ZFyfGw4UGrWDtwb_yoW8uFW3to
        Z3urs3ur4rJw1UXrW3Kr4DKFW7ZFyI9wn8A34rArZ09a1DZ3W5Ka4UCrn8Way3tr4akayU
        C3saqwnruF4xZF4rn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8
        JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07j2MKZUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Loongson LS2X APB DMA controller is available on Loongson-2K chips.

It is a single-channel, configurable DMA controller IP core based on the
AXI bus, whose main function is to integrate DMA functionality on a chip
dedicated to carrying data between memory and peripherals in APB bus
(e.g. nand).

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
---
 drivers/dma/Kconfig        |  14 +
 drivers/dma/Makefile       |   1 +
 drivers/dma/ls2x-apb-dma.c | 642 +++++++++++++++++++++++++++++++++++++
 3 files changed, 657 insertions(+)
 create mode 100644 drivers/dma/ls2x-apb-dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f5f422f9b850..c6019cd6c3b3 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -376,6 +376,20 @@ config LPC18XX_DMAMUX
 	  Enable support for DMA on NXP LPC18xx/43xx platforms
 	  with PL080 and multiplexed DMA request lines.
 
+config LS2X_APB_DMA
+	tristate "Loongson LS2X APB DMA support"
+	depends on LOONGARCH || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support for the Loongson LS2X APB DMA controller driver. The
+	  DMA controller is having single DMA channel which can be
+	  configured for different peripherals like audio, nand, sdio
+	  etc which is in APB bus.
+
+	  This DMA controller transfers data from memory to peripheral fifo.
+	  It does not support memory to memory data transfer.
+
 config MCF_EDMA
 	tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
 	depends on M5441x || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a4fd1ce29510..9b28ddb1ea3b 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_INTEL_IOATDMA) += ioat/
 obj-y += idxd/
 obj-$(CONFIG_K3_DMA) += k3dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
+obj-$(CONFIG_LS2X_APB_DMA) += ls2x-apb-dma.o
 obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
 obj-$(CONFIG_MILBEAUT_XDMAC) += milbeaut-xdmac.o
 obj-$(CONFIG_MMP_PDMA) += mmp_pdma.o
diff --git a/drivers/dma/ls2x-apb-dma.c b/drivers/dma/ls2x-apb-dma.c
new file mode 100644
index 000000000000..f7d37c05d8ed
--- /dev/null
+++ b/drivers/dma/ls2x-apb-dma.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for the Loongson LS2X APB DMA Controller
+ *
+ * Copyright (C) 2017-2023 Loongson Corporation
+ */
+
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+
+#include "dmaengine.h"
+#include "virt-dma.h"
+
+/* Global Configuration Register */
+#define LDMA_ORDER_ERG		0x0
+
+/* Bitfield definitions */
+
+/* Bitfields in Global Configuration Register */
+#define LDMA_64BIT_EN		BIT(0) /* 1: 64 bit support */
+#define LDMA_UNCOHERENT_EN	BIT(1) /* 0: cache, 1: uncache */
+#define LDMA_ASK_VALID		BIT(2)
+#define LDMA_START		BIT(3) /* DMA start operation */
+#define LDMA_STOP		BIT(4) /* DMA stop operation */
+#define LDMA_ASK_ADDR_MASK	GENMASK(63, 5) /* Ask Addr Mask */
+
+/* Bitfields in ndesc_addr field of HW decriptor */
+#define LDMA_DESC_EN		BIT(0) /*1: The next descriptor is valid */
+#define LDMA_DESC_ADDR_LOW	GENMASK(31, 1)
+
+/* Bitfields in cmd field of HW decriptor */
+#define LDMA_INT		BIT(1) /* Enable DMA interrupts */
+#define LDMA_DATA_DIRECTION	BIT(12) /* 1: write to device, 0: read from device */
+
+/*--  descriptors  -----------------------------------------------------*/
+
+/**
+ * struct ls2x_dma_hw_desc - DMA HW descriptor
+ * @ndesc_addr: the next descriptor low address.
+ * @mem_addr: memory low address.
+ * @apb_addr: device buffer address.
+ * @len: length of a piece of carried content, in words.
+ * @step_len: length between two moved memory data blocks.
+ * @step_times: number of blocks to be carried in a single DMA operation.
+ * @cmd: descriptor command or state.
+ * @stats: DMA status.
+ * @high_ndesc_addr: the next descriptor high address.
+ * @high_mem_addr: memory high address.
+ * @reserved: reserved
+ */
+struct ls2x_dma_hw_desc {
+	u32 ndesc_addr;
+	u32 mem_addr;
+	u32 apb_addr;
+	u32 len;
+	u32 step_len;
+	u32 step_times;
+	u32 cmd;
+	u32 stats;
+	u32 high_ndesc_addr;
+	u32 high_mem_addr;
+	u32 reserved[2];
+};
+
+/**
+ * struct ls2x_dma_sg - ls2x dma scatter gather entry
+ * @hw: the pointer to DMA HW descriptor.
+ * @llp: physical address of the DMA HW descriptor.
+ * @phys: destination or source address(mem).
+ * @len: number of Bytes to read.
+ */
+struct ls2x_dma_sg {
+	struct ls2x_dma_hw_desc	*hw;
+	dma_addr_t		llp;
+	dma_addr_t		phys;
+	u32			len;
+};
+
+/**
+ * struct ls2x_dma_desc - software descriptor
+ * @vdesc: pointer to the virtual dma descriptor.
+ * @cyclic: flag to dma cyclic
+ * @sglen: number of sg entries.
+ * @direction: transfer direction, to or from device.
+ * @status: dma controller status.
+ * @sg: array of sgs.
+ */
+struct ls2x_dma_desc {
+	struct virt_dma_desc		vdesc;
+	bool				cyclic;
+	u32				sglen;
+	enum dma_transfer_direction	direction;
+	enum dma_status			status;
+	struct ls2x_dma_sg		sg[];
+};
+
+/*--  Channels  --------------------------------------------------------*/
+
+/**
+ * struct ls2x_dma_chan - internal representation of an LS2X APB DMA channel
+ * @vchan: virtual dma channel entry.
+ * @desc: pointer to the ls2x sw dma descriptor.
+ * @pool: hw desc table
+ * @sconfig: configuration for slave transfers, passed via .device_config
+ */
+struct ls2x_dma_chan {
+	struct virt_dma_chan	vchan;
+	struct ls2x_dma_desc	*desc;
+	void			*pool;
+	struct dma_slave_config	sconfig;
+};
+
+/*--  Controller  ------------------------------------------------------*/
+
+/**
+ * struct ls2x_dma_priv - LS2X APB DMAC specific information
+ * @ddev: dmaengine dma_device object members
+ * @irq: irq line
+ * @regs: memory mapped register base
+ * @lchan: channel to store ls2x_dma_chan structures
+ */
+struct ls2x_dma_priv {
+	struct dma_device	ddev;
+	int			irq;
+	void __iomem		*regs;
+	struct ls2x_dma_chan	lchan;
+};
+
+/*--  Helper functions  ------------------------------------------------*/
+
+static inline struct ls2x_dma_desc *to_ldma_desc(struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct ls2x_dma_desc, vdesc);
+}
+
+static inline struct ls2x_dma_chan *to_ldma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct ls2x_dma_chan, vchan.chan);
+}
+
+static inline struct ls2x_dma_priv *to_ldma_priv(struct dma_device *ddev)
+{
+	return container_of(ddev, struct ls2x_dma_priv, ddev);
+}
+
+static struct device *chan2dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
+static void ls2x_dma_desc_free(struct virt_dma_desc *vdesc)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(vdesc->tx.chan);
+	struct ls2x_dma_desc *desc = to_ldma_desc(vdesc);
+	int i;
+
+	for (i = 0; i < desc->sglen; i++) {
+		if (desc->sg[i].hw)
+			dma_pool_free(lchan->pool, desc->sg[i].hw,
+				      desc->sg[i].llp);
+	}
+
+	kfree(desc);
+}
+
+static void ls2x_dma_write_cmd(struct ls2x_dma_chan *lchan, bool cmd)
+{
+	u64 val = 0;
+	struct ls2x_dma_priv *priv = to_ldma_priv(lchan->vchan.chan.device);
+
+	val = readq(priv->regs + LDMA_ORDER_ERG) & LDMA_ASK_ADDR_MASK;
+	val |= LDMA_64BIT_EN | cmd;
+	writeq(val, priv->regs + LDMA_ORDER_ERG);
+}
+
+static void ls2x_dma_start_transfer(struct ls2x_dma_chan *lchan)
+{
+	struct ls2x_dma_priv *priv = to_ldma_priv(lchan->vchan.chan.device);
+	struct ls2x_dma_sg *ldma_sg;
+	struct virt_dma_desc *vdesc;
+	u64 val;
+
+	/* Get the next descriptor */
+	vdesc = vchan_next_desc(&lchan->vchan);
+	if (!vdesc) {
+		lchan->desc = NULL;
+		return;
+	}
+
+	list_del(&vdesc->node);
+	lchan->desc = to_ldma_desc(vdesc);
+	ldma_sg = &lchan->desc->sg[0];
+
+	/* Start DMA */
+	writeq(0, priv->regs + LDMA_ORDER_ERG);
+	val = (ldma_sg->llp & LDMA_ASK_ADDR_MASK) | LDMA_64BIT_EN | LDMA_START;
+	writeq(val, priv->regs + LDMA_ORDER_ERG);
+}
+
+static void ls2x_dma_fill_desc(struct ls2x_dma_chan *lchan, u32 i,
+			       struct ls2x_dma_desc *desc)
+{
+	struct ls2x_dma_sg *ldma_sg = &desc->sg[i];
+
+	ldma_sg->hw->mem_addr = lower_32_bits(ldma_sg->phys);
+	ldma_sg->hw->high_mem_addr = upper_32_bits(ldma_sg->phys);
+	/* Word count register takes input in words */
+	ldma_sg->hw->len = ldma_sg->len >> 2;
+	ldma_sg->hw->step_len = 0;
+	ldma_sg->hw->step_times = 1;
+
+	if (desc->direction == DMA_MEM_TO_DEV) {
+		ldma_sg->hw->cmd = LDMA_INT | LDMA_DATA_DIRECTION;
+		ldma_sg->hw->apb_addr = lchan->sconfig.dst_addr;
+	} else {
+		ldma_sg->hw->cmd = LDMA_INT;
+		ldma_sg->hw->apb_addr = lchan->sconfig.src_addr;
+	}
+
+	/* lets make a link list */
+	if (i) {
+		desc->sg[i - 1].hw->ndesc_addr = ldma_sg->llp | LDMA_DESC_EN;
+		desc->sg[i - 1].hw->high_ndesc_addr = upper_32_bits(ldma_sg->llp);
+	}
+}
+
+/*--  DMA Engine API  --------------------------------------------------*/
+
+/**
+ * ls2x_dma_alloc_chan_resources - allocate resources for DMA channel
+ * @chan: allocate descriptor resources for this channel
+ *
+ * return - the number of allocated descriptors
+ */
+static int ls2x_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+
+	/* Create a pool of consistent memory blocks for hardware descriptors */
+	lchan->pool = dma_pool_create(dev_name(chan2dev(chan)),
+				      chan->device->dev, PAGE_SIZE,
+				      __alignof__(struct ls2x_dma_hw_desc), 0);
+	if (!lchan->pool) {
+		dev_err(chan2dev(chan), "No memory for descriptors\n");
+		return -ENOMEM;
+	}
+
+	return 1;
+}
+
+/**
+ * ls2x_dma_free_chan_resources - free all channel resources
+ * @chan: DMA channel
+ */
+static void ls2x_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+
+	vchan_free_chan_resources(to_virt_chan(chan));
+	dma_pool_destroy(lchan->pool);
+	lchan->pool = NULL;
+}
+
+/**
+ * ls2x_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
+ * @chan: DMA channel
+ * @sgl: scatterlist to transfer to/from
+ * @sg_len: number of entries in @scatterlist
+ * @direction: DMA direction
+ * @flags: tx descriptor status flags
+ * @context: transaction context (ignored)
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor *
+ls2x_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		       u32 sg_len, enum dma_transfer_direction direction,
+		       unsigned long flags, void *context)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+	struct ls2x_dma_desc *desc;
+	struct scatterlist *sg;
+	int i;
+
+	if (unlikely(!sg_len || !is_slave_direction(direction)))
+		return NULL;
+
+	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
+	if (!desc)
+		return NULL;
+	desc->sglen = sg_len;
+	desc->direction = direction;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		struct ls2x_dma_sg *ldma_sg = &desc->sg[i];
+
+		/* Allocate DMA capable memory for hardware descriptor */
+		ldma_sg->hw = dma_pool_alloc(lchan->pool, GFP_NOWAIT, &ldma_sg->llp);
+		if (!ldma_sg->hw) {
+			desc->sglen = i;
+			ls2x_dma_desc_free(&desc->vdesc);
+			return NULL;
+		}
+
+		ldma_sg->phys = sg_dma_address(sg);
+		ldma_sg->len = sg_dma_len(sg);
+
+		ls2x_dma_fill_desc(lchan, i, desc);
+	}
+
+	/* Setting the last descriptor enable bit */
+	desc->sg[sg_len - 1].hw->ndesc_addr &= ~LDMA_DESC_EN;
+	desc->status = DMA_IN_PROGRESS;
+
+	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
+}
+
+/**
+ * ls2x_dma_prep_dma_cyclic - prepare the cyclic DMA transfer
+ * @chan: the DMA channel to prepare
+ * @buf_addr: physical DMA address where the buffer starts
+ * @buf_len: total number of bytes for the entire buffer
+ * @period_len: number of bytes for each period
+ * @direction: transfer direction, to or from device
+ * @flags: tx descriptor status flags
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor *
+ls2x_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+			 size_t period_len, enum dma_transfer_direction direction,
+			 unsigned long flags)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+	struct ls2x_dma_desc *desc;
+	u32 periods;
+	int i;
+
+	if (unlikely(!buf_len || !period_len))
+		return NULL;
+
+	if (unlikely(!is_slave_direction(direction)))
+		return NULL;
+
+	periods = buf_len / period_len;
+	desc = kzalloc(struct_size(desc, sg, periods), GFP_ATOMIC);
+	if (!desc)
+		return NULL;
+	desc->sglen = periods;
+	desc->direction = direction;
+
+	/* Build cyclic linked list */
+	for (i = 0; i < periods; i++) {
+		struct ls2x_dma_sg *ldma_sg = &desc->sg[i];
+
+		/* Allocate DMA capable memory for hardware descriptor */
+		ldma_sg->hw = dma_pool_alloc(lchan->pool, GFP_NOWAIT, &ldma_sg->llp);
+		if (!ldma_sg->hw) {
+			desc->sglen = i;
+			ls2x_dma_desc_free(&desc->vdesc);
+			return NULL;
+		}
+
+		ldma_sg->phys = buf_addr + period_len * i;
+		ldma_sg->len = period_len;
+
+		ls2x_dma_fill_desc(lchan, i, desc);
+	}
+
+	/* Lets make a cyclic list */
+	desc->sg[periods - 1].hw->ndesc_addr = desc->sg[0].llp | LDMA_DESC_EN;
+	desc->sg[periods - 1].hw->high_ndesc_addr = upper_32_bits(desc->sg[0].llp);
+	desc->cyclic = true;
+	desc->status = DMA_IN_PROGRESS;
+
+	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
+}
+
+static int ls2x_dma_slave_config(struct dma_chan *chan,
+				 struct dma_slave_config *config)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+
+	memcpy(&lchan->sconfig, config, sizeof(*config));
+	return 0;
+}
+
+/**
+ * ls2x_dma_issue_pending - push pending transactions to the hardware
+ * @chan: channel
+ *
+ * When this function is called, all pending transactions are pushed to the
+ * hardware and executed.
+ */
+static void ls2x_dma_issue_pending(struct dma_chan *chan)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&lchan->vchan.lock, flags);
+	if (vchan_issue_pending(&lchan->vchan) && !lchan->desc)
+		ls2x_dma_start_transfer(lchan);
+	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
+}
+
+/**
+ * ls2x_dma_terminate_all - terminate all transactions
+ * @chan: channel
+ *
+ * Stops all DMA transactions.
+ */
+static int ls2x_dma_terminate_all(struct dma_chan *chan)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&lchan->vchan.lock, flags);
+	/* Setting stop cmd */
+	ls2x_dma_write_cmd(lchan, LDMA_STOP);
+	if (lchan->desc) {
+		vchan_terminate_vdesc(&lchan->desc->vdesc);
+		lchan->desc = NULL;
+	}
+
+	vchan_get_all_descriptors(&lchan->vchan, &head);
+	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
+
+	vchan_dma_desc_free_list(&lchan->vchan, &head);
+	return 0;
+}
+
+/**
+ * ls2x_dma_synchronize - Synchronizes the termination of transfers to the
+ * current context.
+ * @chan: channel
+ */
+static void ls2x_dma_synchronize(struct dma_chan *chan)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+
+	vchan_synchronize(&lchan->vchan);
+}
+
+static int ls2x_dma_pause(struct dma_chan *chan)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&lchan->vchan.lock, flags);
+	if (lchan->desc && lchan->desc->status == DMA_IN_PROGRESS) {
+		ls2x_dma_write_cmd(lchan, LDMA_STOP);
+		lchan->desc->status = DMA_PAUSED;
+	}
+	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
+
+	return 0;
+}
+
+static int ls2x_dma_resume(struct dma_chan *chan)
+{
+	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&lchan->vchan.lock, flags);
+	if (lchan->desc && lchan->desc->status == DMA_PAUSED) {
+		lchan->desc->status = DMA_IN_PROGRESS;
+		ls2x_dma_write_cmd(lchan, LDMA_START);
+	}
+	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
+
+	return 0;
+}
+
+/**
+ * of_ls2x_dma_xlate - Translation function
+ * @dma_spec: Pointer to DMA specifier as found in the device tree
+ * @ofdma: Pointer to DMA controller data
+ *
+ * Return: DMA channel pointer on success and NULL on error
+ */
+static struct dma_chan *of_ls2x_dma_xlate(struct of_phandle_args *dma_spec,
+					  struct of_dma *ofdma)
+{
+	struct ls2x_dma_priv *priv = ofdma->of_dma_data;
+	struct ls2x_dma_chan *lchan;
+
+	/* We are single channel DMA, just get the channel from priv. */
+	lchan = &priv->lchan;
+	if (!lchan)
+		return NULL;
+
+	return dma_get_slave_channel(&lchan->vchan.chan);
+}
+
+/**
+ * ls2x_dma_isr - LS2X DMA Interrupt handler
+ * @irq: IRQ number
+ * @data: Pointer to ls2x_dma_priv
+ *
+ * Return: IRQ_HANDLED/IRQ_NONE
+ */
+static irqreturn_t ls2x_dma_isr(int irq, void *dev_id)
+{
+	struct ls2x_dma_priv *priv = dev_id;
+	struct ls2x_dma_chan *lchan = &priv->lchan;
+	struct ls2x_dma_desc *desc;
+
+	spin_lock(&lchan->vchan.lock);
+	desc = lchan->desc;
+	if (desc) {
+		if (desc->cyclic) {
+			vchan_cyclic_callback(&desc->vdesc);
+		} else {
+			desc->status = DMA_COMPLETE;
+			vchan_cookie_complete(&desc->vdesc);
+			ls2x_dma_start_transfer(lchan);
+		}
+
+		/* ls2x_dma_start_transfer() updates lchan->desc */
+		if (lchan->desc == NULL)
+			ls2x_dma_write_cmd(lchan, LDMA_STOP);
+	}
+	spin_unlock(&lchan->vchan.lock);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ls2x_dma_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * Return: '0' on success and failure value on error
+ */
+static int ls2x_dma_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct dma_device *ddev;
+	struct ls2x_dma_priv *priv;
+	struct ls2x_dma_chan *lchan;
+	struct device *dev = &pdev->dev;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->regs))
+		return dev_err_probe(dev, PTR_ERR(priv->regs),
+				     "devm_platform_ioremap_resource failed.\n");
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return dev_err_probe(dev, priv->irq, "platform_get_irq failed.\n");
+
+	ret = devm_request_irq(dev, priv->irq, ls2x_dma_isr,
+			       IRQF_TRIGGER_RISING, dev_name(&pdev->dev), priv);
+	if (ret)
+		return dev_err_probe(dev, priv->irq, "devm_request_irq failed.\n");
+
+	/* Initialize channels related values */
+	INIT_LIST_HEAD(&priv->ddev.channels);
+	lchan = &priv->lchan;
+	lchan->vchan.desc_free = ls2x_dma_desc_free;
+	vchan_init(&lchan->vchan, &priv->ddev);
+
+	ddev = &priv->ddev;
+	ddev->dev = dev;
+	dma_cap_zero(ddev->cap_mask);
+	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
+	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
+
+	ddev->device_alloc_chan_resources = ls2x_dma_alloc_chan_resources;
+	ddev->device_free_chan_resources = ls2x_dma_free_chan_resources;
+	ddev->device_tx_status = dma_cookie_status;
+	ddev->device_issue_pending = ls2x_dma_issue_pending;
+	ddev->device_prep_slave_sg = ls2x_dma_prep_slave_sg;
+	ddev->device_prep_dma_cyclic = ls2x_dma_prep_dma_cyclic;
+	ddev->device_config = ls2x_dma_slave_config;
+	ddev->device_terminate_all = ls2x_dma_terminate_all;
+	ddev->device_synchronize = ls2x_dma_synchronize;
+	ddev->device_pause = ls2x_dma_pause;
+	ddev->device_resume = ls2x_dma_resume;
+
+	ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+
+	ret = dma_async_device_register(&priv->ddev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				"LS2X APB DMA driver registration failed.\n");
+
+	ret = of_dma_controller_register(dev->of_node, of_ls2x_dma_xlate, priv);
+	if (ret < 0) {
+		dma_async_device_unregister(&priv->ddev);
+		return dev_err_probe(dev, ret,
+				"LS2X APB DMA OF registration failed.\n");
+	}
+	platform_set_drvdata(pdev, priv);
+
+	dev_info(dev, "Loongson LS2X APB DMA driver registered successfully.\n");
+	return ret;
+}
+
+static int ls2x_dma_remove(struct platform_device *pdev)
+{
+	struct ls2x_dma_priv *priv = platform_get_drvdata(pdev);
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&priv->ddev);
+
+	return 0;
+}
+
+static const struct of_device_id ls2x_dma_of_match_table[] = {
+	{ .compatible = "loongson,ls2k1000-apbdma" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls2x_dma_dt_ids);
+
+static struct platform_driver ls2x_dmac_driver = {
+	.probe		= ls2x_dma_probe,
+	.remove		= ls2x_dma_remove,
+	.driver = {
+		.name	= "ls2x-apbdma",
+		.of_match_table	= ls2x_dma_of_match_table,
+	},
+};
+module_platform_driver(ls2x_dmac_driver);
+
+MODULE_DESCRIPTION("Loongson LS2X APB DMA Controller driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
+MODULE_LICENSE("GPL");
-- 
2.39.1

