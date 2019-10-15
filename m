Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1AD6DDD
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 05:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfJODeF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 23:34:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34936 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfJODeF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 23:34:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so11552945pfw.2;
        Mon, 14 Oct 2019 20:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCD+lS2ayEJ3XQase3HGFE9bUyXoeQO+JUZPuZFg6qM=;
        b=SRTVh6+xNb06Vpw/iIgLl+cGCEm5key34389C3Q2AMeEolRddqELVBd46dKTTISNLq
         pyZc0lsV+1MkaSUdwZZVyColBvNnSDvKUkXEDvNVKAngCmAIHZ5CpnSrPAeJvm8b7O7c
         FSNyUli0UTwhESwJoZls3qNtWhFSZiwhhOsYhVy0NdPZsAYanD9BL2m1ica4KGf1K0uz
         6doCpU4afS6PaHRUxtJIzpdqWe6HKATH0N8tJ3wYEVvv6v8kapCdA4QCex6ivPEwnUsR
         cC35QZsxF0y+/3FRSnd7uW9zj0ZGeNlIOdZI2cJmCYFarPHaMtCnJ3wrqyDsUvyZi0gO
         g5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCD+lS2ayEJ3XQase3HGFE9bUyXoeQO+JUZPuZFg6qM=;
        b=Y1qDtk2SjKkPx+U8AFtktn9hmoTpD3zOnFvT7IOc2Zch3bYz4I/QBYE54Y0RuVosBz
         TpDLE/osCCYxKkU8IlwTfzwewi2ZlLNVBqpl5/DG7u6banVg6/4oUeIEU//cOvzXUVHK
         y9cPVK4XekFQbq71VFZjTT0036WT3GrVxDSCVS+FcXkpuTnv5DnNII4Vw4QXbC17R/HX
         h7fMYliVtAdUpQHuh2TVKX6Gy9W9yTIeCqFIyP1xYOXZEskFGx4Ew//gBtqg94UVk2Jg
         si9QxnAJDN2fJe33FLynPp55PxLD7m3pZp2NEeMoHQ11iPkBbGaxr8cX3UgjkUzbDeVL
         p4aQ==
X-Gm-Message-State: APjAAAV6UqR21PiVctKdkTwrhwFM2fkrSaAthdquLcktL2kKrkqovPG3
        AmVv2eiLhL7mGNyKgU+bZ0Xr1nG0
X-Google-Smtp-Source: APXvYqz5XhZg87rgS1rW1pqFFnUWBzCv4LO5aXXaJm+HCqyPrCQTElfUoIoCRoC5vVyXqZ7LoMEybQ==
X-Received: by 2002:a63:2985:: with SMTP id p127mr2703725pgp.342.1571110443245;
        Mon, 14 Oct 2019 20:34:03 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id b22sm19424268pfo.85.2019.10.14.20.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 20:34:02 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v4 2/2] dmaengine: milbeaut-hdmac: Add HDMAC driver for Milbeaut platforms
Date:   Mon, 14 Oct 2019 22:33:59 -0500
Message-Id: <20191015033359.14925-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015033301.14791-1-jassisinghbrar@gmail.com>
References: <20191015033301.14791-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Driver for Socionext Milbeaut HDMAC controller. The controller has
upto 8 floating channels, that need a predefined slave-id to work
from a set of slaves.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/dma/Kconfig          |  10 +
 drivers/dma/Makefile         |   1 +
 drivers/dma/milbeaut-hdmac.c | 581 +++++++++++++++++++++++++++++++++++
 3 files changed, 592 insertions(+)
 create mode 100644 drivers/dma/milbeaut-hdmac.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 7af874b69ffb..d312ebbafbee 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -342,6 +342,16 @@ config MCF_EDMA
 	  minimal intervention from a host processor.
 	  This module can be found on Freescale ColdFire mcf5441x SoCs.
 
+config MILBEAUT_HDMAC
+	tristate "Milbeaut AHB DMA support"
+	depends on ARCH_MILBEAUT || COMPILE_TEST
+	depends on OF
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Say yes here to support the Socionext Milbeaut
+	  HDMAC device.
+
 config MMP_PDMA
 	bool "MMP PDMA support"
 	depends on ARCH_MMP || ARCH_PXA || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index f5ce8665e944..5f0df3611414 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_INTEL_IOP_ADMA) += iop-adma.o
 obj-$(CONFIG_INTEL_MIC_X100_DMA) += mic_x100_dma.o
 obj-$(CONFIG_K3_DMA) += k3dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
+obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
 obj-$(CONFIG_MMP_PDMA) += mmp_pdma.o
 obj-$(CONFIG_MMP_TDMA) += mmp_tdma.o
 obj-$(CONFIG_MOXART_DMA) += moxart-dma.o
diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
new file mode 100644
index 000000000000..2bb33535ab9e
--- /dev/null
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2019 Linaro Ltd.
+// Copyright (C) 2019 Socionext Inc.
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/bitfield.h>
+
+#include "virt-dma.h"
+
+#define MLB_HDMAC_DMACR		0x0	/* global */
+#define MLB_HDMAC_DE		BIT(31)
+#define MLB_HDMAC_DS		BIT(30)
+#define MLB_HDMAC_PR		BIT(28)
+#define MLB_HDMAC_DH		GENMASK(27, 24)
+
+#define MLB_HDMAC_CH_STRIDE	0x10
+
+#define MLB_HDMAC_DMACA		0x0	/* channel */
+#define MLB_HDMAC_EB		BIT(31)
+#define MLB_HDMAC_PB		BIT(30)
+#define MLB_HDMAC_ST		BIT(29)
+#define MLB_HDMAC_IS		GENMASK(28, 24)
+#define MLB_HDMAC_BT		GENMASK(23, 20)
+#define MLB_HDMAC_BC		GENMASK(19, 16)
+#define MLB_HDMAC_TC		GENMASK(15, 0)
+#define MLB_HDMAC_DMACB		0x4
+#define MLB_HDMAC_TT		GENMASK(31, 30)
+#define MLB_HDMAC_MS		GENMASK(29, 28)
+#define MLB_HDMAC_TW		GENMASK(27, 26)
+#define MLB_HDMAC_FS		BIT(25)
+#define MLB_HDMAC_FD		BIT(24)
+#define MLB_HDMAC_RC		BIT(23)
+#define MLB_HDMAC_RS		BIT(22)
+#define MLB_HDMAC_RD		BIT(21)
+#define MLB_HDMAC_EI		BIT(20)
+#define MLB_HDMAC_CI		BIT(19)
+#define HDMAC_PAUSE		0x7
+#define MLB_HDMAC_SS		GENMASK(18, 16)
+#define MLB_HDMAC_SP		GENMASK(15, 12)
+#define MLB_HDMAC_DP		GENMASK(11, 8)
+#define MLB_HDMAC_DMACSA	0x8
+#define MLB_HDMAC_DMACDA	0xc
+
+#define MLB_HDMAC_BUSWIDTHS		(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+					BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+					BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
+
+struct milbeaut_hdmac_desc {
+	struct virt_dma_desc vd;
+	struct scatterlist *sgl;
+	unsigned int sg_len;
+	unsigned int sg_cur;
+	enum dma_transfer_direction dir;
+};
+
+struct milbeaut_hdmac_chan {
+	struct virt_dma_chan vc;
+	struct milbeaut_hdmac_device *mdev;
+	struct milbeaut_hdmac_desc *md;
+	void __iomem *reg_ch_base;
+	unsigned int slave_id;
+	struct dma_slave_config	cfg;
+};
+
+struct milbeaut_hdmac_device {
+	struct dma_device ddev;
+	struct clk *clk;
+	void __iomem *reg_base;
+	struct milbeaut_hdmac_chan channels[0];
+};
+
+static struct milbeaut_hdmac_chan *
+to_milbeaut_hdmac_chan(struct virt_dma_chan *vc)
+{
+	return container_of(vc, struct milbeaut_hdmac_chan, vc);
+}
+
+static struct milbeaut_hdmac_desc *
+to_milbeaut_hdmac_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct milbeaut_hdmac_desc, vd);
+}
+
+/* mc->vc.lock must be held by caller */
+static struct milbeaut_hdmac_desc *
+milbeaut_hdmac_next_desc(struct milbeaut_hdmac_chan *mc)
+{
+	struct virt_dma_desc *vd;
+
+	vd = vchan_next_desc(&mc->vc);
+	if (!vd) {
+		mc->md = NULL;
+		return NULL;
+	}
+
+	list_del(&vd->node);
+
+	mc->md = to_milbeaut_hdmac_desc(vd);
+
+	return mc->md;
+}
+
+/* mc->vc.lock must be held by caller */
+static void milbeaut_chan_start(struct milbeaut_hdmac_chan *mc,
+				struct milbeaut_hdmac_desc *md)
+{
+	struct scatterlist *sg;
+	u32 cb, ca, src_addr, dest_addr, len;
+	u32 width, burst;
+
+	sg = &md->sgl[md->sg_cur];
+	len = sg_dma_len(sg);
+
+	cb = MLB_HDMAC_CI | MLB_HDMAC_EI;
+	if (md->dir == DMA_MEM_TO_DEV) {
+		cb |= MLB_HDMAC_FD;
+		width = mc->cfg.dst_addr_width;
+		burst = mc->cfg.dst_maxburst;
+		src_addr = sg_dma_address(sg);
+		dest_addr = mc->cfg.dst_addr;
+	} else {
+		cb |= MLB_HDMAC_FS;
+		width = mc->cfg.src_addr_width;
+		burst = mc->cfg.src_maxburst;
+		src_addr = mc->cfg.src_addr;
+		dest_addr = sg_dma_address(sg);
+	}
+	cb |= FIELD_PREP(MLB_HDMAC_TW, (width >> 1));
+	cb |= FIELD_PREP(MLB_HDMAC_MS, 2);
+
+	writel_relaxed(MLB_HDMAC_DE, mc->mdev->reg_base + MLB_HDMAC_DMACR);
+	writel_relaxed(src_addr, mc->reg_ch_base + MLB_HDMAC_DMACSA);
+	writel_relaxed(dest_addr, mc->reg_ch_base + MLB_HDMAC_DMACDA);
+	writel_relaxed(cb, mc->reg_ch_base + MLB_HDMAC_DMACB);
+
+	ca = FIELD_PREP(MLB_HDMAC_IS, mc->slave_id);
+	if (burst == 16)
+		ca |= FIELD_PREP(MLB_HDMAC_BT, 0xf);
+	else if (burst == 8)
+		ca |= FIELD_PREP(MLB_HDMAC_BT, 0xd);
+	else if (burst == 4)
+		ca |= FIELD_PREP(MLB_HDMAC_BT, 0xb);
+	burst *= width;
+	ca |= FIELD_PREP(MLB_HDMAC_TC, (len / burst - 1));
+	writel_relaxed(ca, mc->reg_ch_base + MLB_HDMAC_DMACA);
+	ca |= MLB_HDMAC_EB;
+	writel_relaxed(ca, mc->reg_ch_base + MLB_HDMAC_DMACA);
+}
+
+/* mc->vc.lock must be held by caller */
+static void milbeaut_hdmac_start(struct milbeaut_hdmac_chan *mc)
+{
+	struct milbeaut_hdmac_desc *md;
+
+	md = milbeaut_hdmac_next_desc(mc);
+	if (md)
+		milbeaut_chan_start(mc, md);
+}
+
+static irqreturn_t milbeaut_hdmac_interrupt(int irq, void *dev_id)
+{
+	struct milbeaut_hdmac_chan *mc = dev_id;
+	struct milbeaut_hdmac_desc *md;
+	u32 val;
+
+	spin_lock(&mc->vc.lock);
+
+	/* Ack and Disable irqs */
+	val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACB);
+	val &= ~(FIELD_PREP(MLB_HDMAC_SS, HDMAC_PAUSE));
+	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACB);
+	val &= ~MLB_HDMAC_EI;
+	val &= ~MLB_HDMAC_CI;
+	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACB);
+
+	md = mc->md;
+	if (!md)
+		goto out;
+
+	md->sg_cur++;
+
+	if (md->sg_cur >= md->sg_len) {
+		vchan_cookie_complete(&md->vd);
+		md = milbeaut_hdmac_next_desc(mc);
+		if (!md)
+			goto out;
+	}
+
+	milbeaut_chan_start(mc, md);
+
+out:
+	spin_unlock(&mc->vc.lock);
+	return IRQ_HANDLED;
+}
+
+static void milbeaut_hdmac_free_chan_resources(struct dma_chan *chan)
+{
+	vchan_free_chan_resources(to_virt_chan(chan));
+}
+
+static int
+milbeaut_hdmac_chan_config(struct dma_chan *chan, struct dma_slave_config *cfg)
+{
+	struct virt_dma_chan *vc = to_virt_chan(chan);
+	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+
+	spin_lock(&mc->vc.lock);
+	mc->cfg = *cfg;
+	spin_unlock(&mc->vc.lock);
+
+	return 0;
+}
+
+static int milbeaut_hdmac_chan_pause(struct dma_chan *chan)
+{
+	struct virt_dma_chan *vc = to_virt_chan(chan);
+	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	u32 val;
+
+	spin_lock(&mc->vc.lock);
+	val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
+	val |= MLB_HDMAC_PB;
+	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
+	spin_unlock(&mc->vc.lock);
+
+	return 0;
+}
+
+static int milbeaut_hdmac_chan_resume(struct dma_chan *chan)
+{
+	struct virt_dma_chan *vc = to_virt_chan(chan);
+	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	u32 val;
+
+	spin_lock(&mc->vc.lock);
+	val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
+	val &= ~MLB_HDMAC_PB;
+	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
+	spin_unlock(&mc->vc.lock);
+
+	return 0;
+}
+
+static struct dma_async_tx_descriptor *
+milbeaut_hdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			     unsigned int sg_len,
+			     enum dma_transfer_direction direction,
+			     unsigned long flags, void *context)
+{
+	struct virt_dma_chan *vc = to_virt_chan(chan);
+	struct milbeaut_hdmac_desc *md;
+	int i;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	md = kzalloc(sizeof(*md), GFP_NOWAIT);
+	if (!md)
+		return NULL;
+
+	md->sgl = kzalloc(sizeof(*sgl) * sg_len, GFP_NOWAIT);
+	if (!md->sgl) {
+		kfree(md);
+		return NULL;
+	}
+
+	for (i = 0; i < sg_len; i++)
+		md->sgl[i] = sgl[i];
+
+	md->sg_len = sg_len;
+	md->dir = direction;
+
+	return vchan_tx_prep(vc, &md->vd, flags);
+}
+
+static int milbeaut_hdmac_terminate_all(struct dma_chan *chan)
+{
+	struct virt_dma_chan *vc = to_virt_chan(chan);
+	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	unsigned long flags;
+	u32 val;
+
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&vc->lock, flags);
+
+	val = readl_relaxed(mc->reg_ch_base + MLB_HDMAC_DMACA);
+	val &= ~MLB_HDMAC_EB; /* disable the channel */
+	writel_relaxed(val, mc->reg_ch_base + MLB_HDMAC_DMACA);
+
+	if (mc->md) {
+		vchan_terminate_vdesc(&mc->md->vd);
+		mc->md = NULL;
+	}
+
+	vchan_get_all_descriptors(vc, &head);
+
+	spin_unlock_irqrestore(&vc->lock, flags);
+
+	vchan_dma_desc_free_list(vc, &head);
+
+	return 0;
+}
+
+static void milbeaut_hdmac_synchronize(struct dma_chan *chan)
+{
+	vchan_synchronize(to_virt_chan(chan));
+}
+
+static enum dma_status milbeaut_hdmac_tx_status(struct dma_chan *chan,
+						dma_cookie_t cookie,
+						struct dma_tx_state *txstate)
+{
+	struct virt_dma_chan *vc;
+	struct virt_dma_desc *vd;
+	struct milbeaut_hdmac_chan *mc;
+	struct milbeaut_hdmac_desc *md = NULL;
+	enum dma_status stat;
+	unsigned long flags;
+	int i;
+
+	stat = dma_cookie_status(chan, cookie, txstate);
+	/* Return immediately if we do not need to compute the residue. */
+	if (stat == DMA_COMPLETE || !txstate)
+		return stat;
+
+	vc = to_virt_chan(chan);
+
+	spin_lock_irqsave(&vc->lock, flags);
+
+	mc = to_milbeaut_hdmac_chan(vc);
+
+	/* residue from the on-flight chunk */
+	if (mc->md && mc->md->vd.tx.cookie == cookie) {
+		struct scatterlist *sg;
+		u32 done;
+
+		md = mc->md;
+		sg = &md->sgl[md->sg_cur];
+
+		if (md->dir == DMA_DEV_TO_MEM)
+			done = readl_relaxed(mc->reg_ch_base
+					     + MLB_HDMAC_DMACDA);
+		else
+			done = readl_relaxed(mc->reg_ch_base
+					     + MLB_HDMAC_DMACSA);
+		done -= sg_dma_address(sg);
+
+		txstate->residue = -done;
+	}
+
+	if (!md) {
+		vd = vchan_find_desc(vc, cookie);
+		if (vd)
+			md = to_milbeaut_hdmac_desc(vd);
+	}
+
+	if (md) {
+		/* residue from the queued chunks */
+		for (i = md->sg_cur; i < md->sg_len; i++)
+			txstate->residue += sg_dma_len(&md->sgl[i]);
+	}
+
+	spin_unlock_irqrestore(&vc->lock, flags);
+
+	return stat;
+}
+
+static void milbeaut_hdmac_issue_pending(struct dma_chan *chan)
+{
+	struct virt_dma_chan *vc = to_virt_chan(chan);
+	struct milbeaut_hdmac_chan *mc = to_milbeaut_hdmac_chan(vc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vc->lock, flags);
+
+	if (vchan_issue_pending(vc) && !mc->md)
+		milbeaut_hdmac_start(mc);
+
+	spin_unlock_irqrestore(&vc->lock, flags);
+}
+
+static void milbeaut_hdmac_desc_free(struct virt_dma_desc *vd)
+{
+	struct milbeaut_hdmac_desc *md = to_milbeaut_hdmac_desc(vd);
+
+	kfree(md->sgl);
+	kfree(md);
+}
+
+static struct dma_chan *
+milbeaut_hdmac_xlate(struct of_phandle_args *dma_spec, struct of_dma *of_dma)
+{
+	struct milbeaut_hdmac_device *mdev = of_dma->of_dma_data;
+	struct milbeaut_hdmac_chan *mc;
+	struct virt_dma_chan *vc;
+	struct dma_chan *chan;
+
+	if (dma_spec->args_count != 1)
+		return NULL;
+
+	chan = dma_get_any_slave_channel(&mdev->ddev);
+	if (!chan)
+		return NULL;
+
+	vc = to_virt_chan(chan);
+	mc = to_milbeaut_hdmac_chan(vc);
+	mc->slave_id = dma_spec->args[0];
+
+	return chan;
+}
+
+static int milbeaut_hdmac_chan_init(struct platform_device *pdev,
+				    struct milbeaut_hdmac_device *mdev,
+				    int chan_id)
+{
+	struct device *dev = &pdev->dev;
+	struct milbeaut_hdmac_chan *mc = &mdev->channels[chan_id];
+	char *irq_name;
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, chan_id);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ number for ch%d\n",
+			chan_id);
+		return irq;
+	}
+
+	irq_name = devm_kasprintf(dev, GFP_KERNEL, "milbeaut-hdmac-%d",
+				  chan_id);
+	if (!irq_name)
+		return -ENOMEM;
+
+	ret = devm_request_irq(dev, irq, milbeaut_hdmac_interrupt,
+			       IRQF_SHARED, irq_name, mc);
+	if (ret)
+		return ret;
+
+	mc->mdev = mdev;
+	mc->reg_ch_base = mdev->reg_base + MLB_HDMAC_CH_STRIDE * (chan_id + 1);
+	mc->vc.desc_free = milbeaut_hdmac_desc_free;
+	vchan_init(&mc->vc, &mdev->ddev);
+
+	return 0;
+}
+
+static int milbeaut_hdmac_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct milbeaut_hdmac_device *mdev;
+	struct dma_device *ddev;
+	int nr_chans, ret, i;
+
+	nr_chans = platform_irq_count(pdev);
+	if (nr_chans < 0)
+		return nr_chans;
+
+	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
+			    GFP_KERNEL);
+	if (!mdev)
+		return -ENOMEM;
+
+	mdev->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mdev->reg_base))
+		return PTR_ERR(mdev->reg_base);
+
+	mdev->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(mdev->clk)) {
+		dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(mdev->clk);
+	}
+
+	ret = clk_prepare_enable(mdev->clk);
+	if (ret)
+		return ret;
+
+	ddev = &mdev->ddev;
+	ddev->dev = dev;
+	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
+	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
+	ddev->src_addr_widths = MLB_HDMAC_BUSWIDTHS;
+	ddev->dst_addr_widths = MLB_HDMAC_BUSWIDTHS;
+	ddev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
+	ddev->device_free_chan_resources = milbeaut_hdmac_free_chan_resources;
+	ddev->device_config = milbeaut_hdmac_chan_config;
+	ddev->device_pause = milbeaut_hdmac_chan_pause;
+	ddev->device_resume = milbeaut_hdmac_chan_resume;
+	ddev->device_prep_slave_sg = milbeaut_hdmac_prep_slave_sg;
+	ddev->device_terminate_all = milbeaut_hdmac_terminate_all;
+	ddev->device_synchronize = milbeaut_hdmac_synchronize;
+	ddev->device_tx_status = milbeaut_hdmac_tx_status;
+	ddev->device_issue_pending = milbeaut_hdmac_issue_pending;
+	INIT_LIST_HEAD(&ddev->channels);
+
+	for (i = 0; i < nr_chans; i++) {
+		ret = milbeaut_hdmac_chan_init(pdev, mdev, i);
+		if (ret)
+			goto disable_clk;
+	}
+
+	ret = dma_async_device_register(ddev);
+	if (ret)
+		goto disable_clk;
+
+	ret = of_dma_controller_register(dev->of_node,
+					 milbeaut_hdmac_xlate, mdev);
+	if (ret)
+		goto unregister_dmac;
+
+	platform_set_drvdata(pdev, mdev);
+
+	return 0;
+
+unregister_dmac:
+	dma_async_device_unregister(ddev);
+disable_clk:
+	clk_disable_unprepare(mdev->clk);
+
+	return ret;
+}
+
+static int milbeaut_hdmac_remove(struct platform_device *pdev)
+{
+	struct milbeaut_hdmac_device *mdev = platform_get_drvdata(pdev);
+	struct dma_chan *chan;
+	int ret;
+
+	/*
+	 * Before reaching here, almost all descriptors have been freed by the
+	 * ->device_free_chan_resources() hook. However, each channel might
+	 * be still holding one descriptor that was on-flight at that moment.
+	 * Terminate it to make sure this hardware is no longer running. Then,
+	 * free the channel resources once again to avoid memory leak.
+	 */
+	list_for_each_entry(chan, &mdev->ddev.channels, device_node) {
+		ret = dmaengine_terminate_sync(chan);
+		if (ret)
+			return ret;
+		milbeaut_hdmac_free_chan_resources(chan);
+	}
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&mdev->ddev);
+	clk_disable_unprepare(mdev->clk);
+
+	return 0;
+}
+
+static const struct of_device_id milbeaut_hdmac_match[] = {
+	{ .compatible = "socionext,milbeaut-m10v-hdmac" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, milbeaut_hdmac_match);
+
+static struct platform_driver milbeaut_hdmac_driver = {
+	.probe = milbeaut_hdmac_probe,
+	.remove = milbeaut_hdmac_remove,
+	.driver = {
+		.name = "milbeaut-m10v-hdmac",
+		.of_match_table = milbeaut_hdmac_match,
+	},
+};
+module_platform_driver(milbeaut_hdmac_driver);
+
+MODULE_DESCRIPTION("Milbeaut HDMAC DmaEngine driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

