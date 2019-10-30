Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 826FEE9C57
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2019 14:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfJ3NcU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Oct 2019 09:32:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37539 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3NcU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Oct 2019 09:32:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id q130so2180495wme.2;
        Wed, 30 Oct 2019 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wgb29+gKN9LpPES/xt9L8BumdwolkB9NiF8Qz+lAqUE=;
        b=Vqbw++gGujz7FQcbhh19aaIBdhbZeJBdjyee/WpxrdaenPNvS7uSpqR23nH1fkJtmI
         xyUJJ7GVoT99QdAbiWeqftEJ79wO1WdBbV7pUXGDgVJYRvjTvMij/C5YFy6ppkCLTKnx
         KzyFf8anKBuMdHI4Im/DPOqwVW1L/iMajoM59rXYXQ4zxJDq4Q/8327CDfrU8HPo+pqp
         2huY5kldVZs/eoLdyZSulIS0oODdgX/hzNShwPrYsQzvkoJVK1lToktwU2lbsxbpmav/
         4oOjf/aAX1yLzfLkkOQ48a1gV2RnmMHLuxlNaYt57DVDgWhNFgApScdZKTMNmwlT5SUX
         Jl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wgb29+gKN9LpPES/xt9L8BumdwolkB9NiF8Qz+lAqUE=;
        b=mfMCxHRPIEgkOxjXC3kp+5HO6rasbB0cqfBXINUxrQDvSYXEshoWD7/z9n3kvNbp4b
         dsrCJUYTwTtvgIPTOwNxK9hCLMaNSM3VQei3YoMXz2J9MqUZJOnEZXSgmXf4HauyToFy
         IyVkGADtFa+bCZoz8Hw8fENjYUg2uZvUWCa/M7qLYaX3TUeKhlD9z3j3c9dRMwt5JNea
         3vxOCe9zPoiHyjfNbRqxCgAE67TVF77EJgmHqfEoVg5taro197DDkXKDjXUBJUw8PFP9
         vsPwVllGsrdvPbDG4/pGtWI88W1Ok7bFJ27CYLN6Eaowry9iny06qagFAuLC/8Ry2DR7
         XjWw==
X-Gm-Message-State: APjAAAV7oQrbpS8kQ6x2ewP4KilYW4Mwpv9bo/HY+UBiUPEjXXdDcIs8
        EVOkItNsbAVLB3Zp0VXaeP5K2JspvlE=
X-Google-Smtp-Source: APXvYqyd37am28Fd9c+8CV/mKwBjKiZHVaUS6t/bFV6n2E04E5cHA43lLRU9hHD9rI7QTAXq7Ln6Dw==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr9343911wmh.55.1572442335281;
        Wed, 30 Oct 2019 06:32:15 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.14])
        by smtp.googlemail.com with ESMTPSA id r3sm357348wre.29.2019.10.30.06.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 06:32:14 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        dmaengine@vger.kernel.org
Subject: [PATCH v4 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe
Date:   Wed, 30 Oct 2019 14:32:09 +0100
Message-Id: <d5301a136caa6cd1cfcfedf31e426a18a7c05c12.1572441900.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572441900.git.a.gordeev.box@gmail.com>
References: <cover.1572441900.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Support Avalon-MM DMA Interface for PCIe used in hard IPs for
Intel Arria, Cyclone or Stratix FPGAs.

CC: dmaengine@vger.kernel.org

Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
---
 drivers/dma/Kconfig              |   2 +
 drivers/dma/Makefile             |   1 +
 drivers/dma/avalon/Kconfig       |  15 +
 drivers/dma/avalon/Makefile      |  12 +
 drivers/dma/avalon/avalon-core.c | 477 +++++++++++++++++++++++++++++++
 drivers/dma/avalon/avalon-core.h |  93 ++++++
 drivers/dma/avalon/avalon-hw.c   | 187 ++++++++++++
 drivers/dma/avalon/avalon-hw.h   |  86 ++++++
 drivers/dma/avalon/avalon-pci.c  | 145 ++++++++++
 9 files changed, 1018 insertions(+)
 create mode 100644 drivers/dma/avalon/Kconfig
 create mode 100644 drivers/dma/avalon/Makefile
 create mode 100644 drivers/dma/avalon/avalon-core.c
 create mode 100644 drivers/dma/avalon/avalon-core.h
 create mode 100644 drivers/dma/avalon/avalon-hw.c
 create mode 100644 drivers/dma/avalon/avalon-hw.h
 create mode 100644 drivers/dma/avalon/avalon-pci.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 7af874b69ffb..f6f43480a4a4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -669,6 +669,8 @@ source "drivers/dma/sh/Kconfig"
 
 source "drivers/dma/ti/Kconfig"
 
+source "drivers/dma/avalon/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index f5ce8665e944..fd7e11417b73 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
 obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
+obj-$(CONFIG_AVALON_DMA) += avalon/
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/avalon/Kconfig b/drivers/dma/avalon/Kconfig
new file mode 100644
index 000000000000..b8cbb6fc04db
--- /dev/null
+++ b/drivers/dma/avalon/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2019, The Linux Foundation. All rights reserved.
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+# Avalon DMA engine
+#
+config AVALON_DMA
+	tristate "Intel Avalon-MM DMA Interface for PCIe"
+	depends on PCI
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  This selects a driver for Avalon-MM DMA Interface for PCIe
+	  hard IP block used in Intel Arria, Cyclone or Stratix FPGAs.
diff --git a/drivers/dma/avalon/Makefile b/drivers/dma/avalon/Makefile
new file mode 100644
index 000000000000..483a31f0a289
--- /dev/null
+++ b/drivers/dma/avalon/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2019, The Linux Foundation. All rights reserved.
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+# Avalon DMA engine
+#
+obj-$(CONFIG_AVALON_DMA)	+= avalon-dma.o
+
+avalon-dma-objs			:= avalon-hw.o \
+				   avalon-core.o \
+				   avalon-pci.o
diff --git a/drivers/dma/avalon/avalon-core.c b/drivers/dma/avalon/avalon-core.c
new file mode 100644
index 000000000000..ab1d0612f74e
--- /dev/null
+++ b/drivers/dma/avalon/avalon-core.c
@@ -0,0 +1,477 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA engine
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+
+#include "avalon-hw.h"
+#include "avalon-core.h"
+
+#define INTERRUPT_NAME		"avalon_dma"
+
+static unsigned int dma_mask_width = 64;
+module_param(dma_mask_width, uint, 0644);
+MODULE_PARM_DESC(dma_mask_width, "Avalon DMA bitmask width (default: 64)");
+
+unsigned long ctrl_base;
+module_param(ctrl_base, ulong, 0644);
+MODULE_PARM_DESC(ctrl_base, "Avalon DMA controller base (default: 0)");
+
+static unsigned int rd_ep_dst_lo = 0x80000000;
+module_param(rd_ep_dst_lo, uint, 0644);
+MODULE_PARM_DESC(rd_ep_dst_lo,
+		 "Read status and desc table low (default: 0x80000000)");
+
+static unsigned int rd_ep_dst_hi = 0;
+module_param(rd_ep_dst_hi, uint, 0644);
+MODULE_PARM_DESC(rd_ep_dst_hi,
+		 "Read status and desc table hi (default: 0)");
+
+static unsigned int wr_ep_dst_lo = 0x80002000;
+module_param(wr_ep_dst_lo, uint, 0644);
+MODULE_PARM_DESC(wr_ep_dst_lo,
+		 "Write status and desc table low (default: 0x80002000)");
+
+static unsigned int wr_ep_dst_hi = 0;
+module_param(wr_ep_dst_hi, uint, 0644);
+MODULE_PARM_DESC(wr_ep_dst_hi,
+		 "Write status and desc table hi (default: 0)");
+
+static int setup_dma_descs(struct dma_desc *dma_descs,
+			   struct avalon_dma_desc *desc)
+{
+	unsigned int seg_stop;
+	unsigned int seg_set;
+	int ret;
+
+	ret = setup_descs_sg(dma_descs, 0,
+			     desc->direction,
+			     desc->dev_addr,
+			     desc->seg, desc->nr_segs,
+			     desc->seg_curr, desc->seg_off,
+			     &seg_stop, &seg_set);
+	if (ret < 0)
+		return ret;
+
+	if (seg_stop == desc->seg_curr) {
+		desc->seg_off += seg_set;
+	} else {
+		desc->seg_curr = seg_stop;
+		desc->seg_off = seg_set;
+	}
+
+	return ret;
+}
+
+static int start_dma_xfer(struct avalon_dma_hw *hw,
+			  struct avalon_dma_desc *desc)
+{
+	size_t ctrl_off;
+	struct __dma_desc_table *__table;
+	struct dma_desc_table *table;
+	u32 rc_src_hi, rc_src_lo;
+	u32 ep_dst_lo, ep_dst_hi;
+	int last_id, *__last_id;
+	int nr_descs;
+
+	if (desc->direction == DMA_TO_DEVICE) {
+		__table = &hw->dma_desc_table_rd;
+
+		ctrl_off = AVALON_DMA_RD_CTRL_OFFSET;
+
+		ep_dst_hi = rd_ep_dst_hi;
+		ep_dst_lo = rd_ep_dst_lo;
+
+		__last_id = &hw->h2d_last_id;
+	} else if (desc->direction == DMA_FROM_DEVICE) {
+		__table = &hw->dma_desc_table_wr;
+
+		ctrl_off = AVALON_DMA_WR_CTRL_OFFSET;
+
+		ep_dst_hi = wr_ep_dst_hi;
+		ep_dst_lo = wr_ep_dst_lo;
+
+		__last_id = &hw->d2h_last_id;
+	} else {
+		return -EINVAL;
+	}
+
+	table = __table->cpu_addr;
+	memset(&table->flags, 0, sizeof(table->flags));
+
+	nr_descs = setup_dma_descs(table->descs, desc);
+	if (nr_descs < 0)
+		return nr_descs;
+
+	last_id = nr_descs - 1;
+	*__last_id = last_id;
+
+	rc_src_hi = __table->dma_addr >> 32;
+	rc_src_lo = (u32)__table->dma_addr;
+
+	start_xfer(hw->regs, ctrl_off,
+		   rc_src_hi, rc_src_lo,
+		   ep_dst_hi, ep_dst_lo,
+		   last_id);
+
+	return 0;
+}
+
+static bool is_desc_complete(struct avalon_dma_desc *desc)
+{
+	if (desc->seg_curr < (desc->nr_segs - 1))
+		return false;
+
+	if (desc->seg_off < desc->seg[desc->seg_curr].dma_len)
+		return false;
+
+	return true;
+}
+
+static irqreturn_t avalon_dma_interrupt(int irq, void *dev_id)
+{
+	struct avalon_dma *adma = (struct avalon_dma *)dev_id;
+	struct avalon_dma_chan *chan = &adma->chan;
+	struct avalon_dma_hw *hw = &chan->hw;
+	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
+	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
+	struct avalon_dma_desc *desc;
+	struct virt_dma_desc *vdesc;
+	bool rd_done;
+	bool wr_done;
+
+	spin_lock(&chan->vchan.lock);
+
+	rd_done = (hw->h2d_last_id < 0);
+	wr_done = (hw->d2h_last_id < 0);
+
+	if (rd_done && wr_done) {
+		spin_unlock(&chan->vchan.lock);
+		return IRQ_NONE;
+	}
+
+	/*
+	 * The Intel documentation claims "The Descriptor Controller
+	 * writes a 1 to the done bit of the status DWORD to indicate
+	 * successful completion. The Descriptor Controller also sends
+	 * an MSI interrupt for the final descriptor. After receiving
+	 * this MSI, host software can poll the done bit to determine
+	 * status."
+	 *
+	 * The above could be read like MSI interrupt might be delivered
+	 * before the corresponding done bit is set. But in reality it
+	 * does not happen at all (or happens really rare). So put here
+	 * the done bit polling, just in case.
+	 */
+	do {
+		if (!rd_done && rd_flags[hw->h2d_last_id])
+			rd_done = true;
+		if (!wr_done && wr_flags[hw->d2h_last_id])
+			wr_done = true;
+		cpu_relax();
+	} while (!rd_done || !wr_done);
+
+	hw->h2d_last_id = -1;
+	hw->d2h_last_id = -1;
+
+	desc = chan->active_desc;
+
+	if (is_desc_complete(desc)) {
+		list_del(&desc->vdesc.node);
+		vchan_cookie_complete(&desc->vdesc);
+
+		desc->direction = DMA_NONE;
+
+		vdesc = vchan_next_desc(&chan->vchan);
+		if (vdesc) {
+			desc = to_avalon_dma_desc(vdesc);
+			chan->active_desc = desc;
+		} else {
+			chan->active_desc = NULL;
+		}
+	}
+
+	if (chan->active_desc)
+		start_dma_xfer(hw, desc);
+
+	spin_unlock(&chan->vchan.lock);
+
+	return IRQ_HANDLED;
+}
+
+static int avalon_dma_terminate_all(struct dma_chan *dma_chan)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(dma_chan);
+
+	vchan_free_chan_resources(vchan);
+
+	return 0;
+}
+
+static void avalon_dma_synchronize(struct dma_chan *dma_chan)
+{
+	struct virt_dma_chan *vchan = to_virt_chan(dma_chan);
+
+	vchan_synchronize(vchan);
+}
+
+static int avalon_dma_init(struct avalon_dma *adma,
+			   struct device *dev,
+			   void __iomem *regs,
+			   unsigned int irq)
+{
+	struct avalon_dma_chan *chan = &adma->chan;
+	struct avalon_dma_hw *hw = &chan->hw;
+	int ret;
+
+	adma->dev		= dev;
+	adma->irq		= irq;
+
+	chan->active_desc	= NULL;
+
+	hw->regs		= regs;
+	hw->h2d_last_id		= -1;
+	hw->d2h_last_id		= -1;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_mask_width));
+	if (ret)
+		return ret;
+
+	hw->dma_desc_table_rd.cpu_addr = dma_alloc_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		&hw->dma_desc_table_rd.dma_addr,
+		GFP_KERNEL);
+	if (!hw->dma_desc_table_rd.cpu_addr)
+		return -ENOMEM;
+
+	hw->dma_desc_table_wr.cpu_addr = dma_alloc_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		&hw->dma_desc_table_wr.dma_addr,
+		GFP_KERNEL);
+	if (!hw->dma_desc_table_wr.cpu_addr) {
+		ret = -ENOMEM;
+		goto free_table_rd;
+	}
+
+	ret = request_irq(irq, avalon_dma_interrupt, IRQF_SHARED,
+			  INTERRUPT_NAME, adma);
+	if (ret)
+		goto free_table_wr;
+
+	return 0;
+
+free_table_wr:
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		hw->dma_desc_table_wr.cpu_addr,
+		hw->dma_desc_table_wr.dma_addr);
+
+free_table_rd:
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		hw->dma_desc_table_rd.cpu_addr,
+		hw->dma_desc_table_rd.dma_addr);
+
+	return ret;
+}
+
+static void avalon_dma_term(struct avalon_dma *adma)
+{
+	struct avalon_dma_chan *chan = &adma->chan;
+	struct avalon_dma_hw *hw = &chan->hw;
+	struct device *dev = adma->dev;
+
+	free_irq(adma->irq, adma);
+
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		hw->dma_desc_table_rd.cpu_addr,
+		hw->dma_desc_table_rd.dma_addr);
+
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		hw->dma_desc_table_wr.cpu_addr,
+		hw->dma_desc_table_wr.dma_addr);
+}
+
+static int avalon_dma_device_config(struct dma_chan *dma_chan,
+				    struct dma_slave_config *config)
+{
+	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
+
+	if (!IS_ALIGNED(config->src_addr, sizeof(u32)) ||
+	    !IS_ALIGNED(config->dst_addr, sizeof(u32)))
+		return -EINVAL;
+
+	chan->src_addr = config->src_addr;
+	chan->dst_addr = config->dst_addr;
+
+	return 0;
+}
+
+static struct dma_async_tx_descriptor *
+avalon_dma_prep_slave_sg(struct dma_chan *dma_chan,
+			 struct scatterlist *sg, unsigned int sg_len,
+			 enum dma_transfer_direction direction,
+			 unsigned long flags, void *context)
+{
+	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
+	struct avalon_dma_desc *desc;
+	dma_addr_t dev_addr;
+	int i;
+
+	if (direction == DMA_MEM_TO_DEV)
+		dev_addr = chan->dst_addr;
+	else if (direction == DMA_DEV_TO_MEM)
+		dev_addr = chan->src_addr;
+	else
+		return NULL;
+
+	desc = kzalloc(struct_size(desc, seg, sg_len), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->direction = direction;
+	desc->dev_addr	= dev_addr;
+	desc->seg_curr	= 0;
+	desc->seg_off	= 0;
+	desc->nr_segs	= sg_len;
+
+	for (i = 0; i < sg_len; i++) {
+		struct dma_segment *seg = &desc->seg[i];
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		unsigned int dma_len = sg_dma_len(sg);
+
+		if (!IS_ALIGNED(dma_addr, sizeof(u32)) ||
+		    !IS_ALIGNED(dma_len, sizeof(u32)))
+			return NULL;
+
+		seg->dma_addr = dma_addr;
+		seg->dma_len = dma_len;
+
+		sg = sg_next(sg);
+	}
+
+	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
+}
+
+static void avalon_dma_issue_pending(struct dma_chan *dma_chan)
+{
+	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
+	struct avalon_dma_hw *hw = &chan->hw;
+	struct avalon_dma_desc *desc;
+	struct virt_dma_desc *vdesc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+
+	if (!vchan_issue_pending(&chan->vchan))
+		goto out;
+
+	/*
+	 * Do nothing if a DMA transmission is currently active.
+	 * BOTH read and write status must be checked here!
+	 */
+	if (hw->d2h_last_id < 0 && hw->h2d_last_id < 0) {
+		if (chan->active_desc)
+			goto out;
+
+		vdesc = vchan_next_desc(&chan->vchan);
+		desc = to_avalon_dma_desc(vdesc);
+		chan->active_desc = desc;
+
+		if (start_dma_xfer(hw, desc))
+			goto out;
+	}
+
+out:
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+}
+
+static void avalon_dma_desc_free(struct virt_dma_desc *vdesc)
+{
+	struct avalon_dma_desc *desc = to_avalon_dma_desc(vdesc);
+
+	kfree(desc);
+}
+
+struct avalon_dma *avalon_dma_register(struct device *dev,
+				       void __iomem *regs,
+				       unsigned int irq)
+{
+	struct avalon_dma *adma;
+	struct avalon_dma_chan *chan;
+	struct dma_device *dma_dev;
+	int ret;
+
+	adma = kzalloc(sizeof(*adma), GFP_KERNEL);
+	if (!adma)
+		return ERR_PTR(-ENOMEM);
+
+	ret = avalon_dma_init(adma, dev, regs, irq);
+	if (ret)
+		goto err;
+
+	dev->dma_parms = &adma->dma_parms;
+	dma_set_max_seg_size(dev, UINT_MAX);
+
+	dma_dev = &adma->dma_dev;
+	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+
+	dma_dev->device_tx_status = dma_cookie_status;
+	dma_dev->device_prep_slave_sg = avalon_dma_prep_slave_sg;
+	dma_dev->device_issue_pending = avalon_dma_issue_pending;
+	dma_dev->device_terminate_all = avalon_dma_terminate_all;
+	dma_dev->device_synchronize = avalon_dma_synchronize;
+	dma_dev->device_config = avalon_dma_device_config;
+
+	dma_dev->dev = dev;
+	dma_dev->chancnt = 1;
+
+	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	chan = &adma->chan;
+	chan->src_addr = -1;
+	chan->dst_addr = -1;
+	chan->vchan.desc_free = avalon_dma_desc_free;
+
+	vchan_init(&chan->vchan, dma_dev);
+
+	ret = dma_async_device_register(dma_dev);
+	if (ret)
+		goto err;
+
+	return adma;
+
+err:
+	kfree(adma);
+
+	return ERR_PTR(ret);
+}
+
+void avalon_dma_unregister(struct avalon_dma *adma)
+{
+	dmaengine_terminate_sync(&adma->chan.vchan.chan);
+	dma_async_device_unregister(&adma->dma_dev);
+
+	avalon_dma_term(adma);
+
+	kfree(adma);
+}
diff --git a/drivers/dma/avalon/avalon-core.h b/drivers/dma/avalon/avalon-core.h
new file mode 100644
index 000000000000..ce67db35d684
--- /dev/null
+++ b/drivers/dma/avalon/avalon-core.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA engine
+ */
+#ifndef __AVALON_CORE_H__
+#define __AVALON_CORE_H__
+
+#include <linux/interrupt.h>
+#include <linux/dma-direction.h>
+
+#include "../virt-dma.h"
+
+#include "avalon-hw.h"
+
+struct avalon_dma_desc {
+	struct virt_dma_desc	vdesc;
+
+	enum dma_data_direction	direction;
+
+	dma_addr_t		dev_addr;
+
+	unsigned int		seg_curr;
+	unsigned int		seg_off;
+
+	unsigned int		nr_segs;
+	struct dma_segment	seg[];
+};
+
+struct avalon_dma_hw {
+	struct __dma_desc_table {
+		struct dma_desc_table *cpu_addr;
+		dma_addr_t dma_addr;
+	} dma_desc_table_rd, dma_desc_table_wr;
+
+	int			h2d_last_id;
+	int			d2h_last_id;
+
+	void __iomem		*regs;
+};
+
+struct avalon_dma_chan {
+	struct virt_dma_chan	vchan;
+
+	dma_addr_t		src_addr;
+	dma_addr_t		dst_addr;
+
+	struct avalon_dma_hw	hw;
+
+	struct avalon_dma_desc	*active_desc;
+};
+
+struct avalon_dma {
+	struct device		*dev;
+	unsigned int		irq;
+
+	struct avalon_dma_chan	chan;
+	struct dma_device	dma_dev;
+	struct device_dma_parameters dma_parms;
+};
+
+static inline
+struct avalon_dma_chan *to_avalon_dma_chan(struct dma_chan *dma_chan)
+{
+	return container_of(dma_chan, struct avalon_dma_chan, vchan.chan);
+}
+
+static inline
+struct avalon_dma_desc *to_avalon_dma_desc(struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct avalon_dma_desc, vdesc);
+}
+
+static inline
+struct avalon_dma *chan_to_avalon_dma(struct avalon_dma_chan *chan)
+{
+	return container_of(chan, struct avalon_dma, chan);
+}
+
+static inline
+__iomem void *__iomem avalon_dma_mmio(struct avalon_dma *adma)
+{
+	return adma->chan.hw.regs;
+}
+
+struct avalon_dma *avalon_dma_register(struct device *dev,
+				       void __iomem *regs,
+				       unsigned int irq);
+void avalon_dma_unregister(struct avalon_dma *adma);
+
+#endif
diff --git a/drivers/dma/avalon/avalon-hw.c b/drivers/dma/avalon/avalon-hw.c
new file mode 100644
index 000000000000..1d22d0c48eca
--- /dev/null
+++ b/drivers/dma/avalon/avalon-hw.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA engine
+ */
+#include <linux/kernel.h>
+
+#include "avalon-hw.h"
+
+#define DMA_DESC_MAX		AVALON_DMA_DESC_NUM
+
+static void setup_desc(struct dma_desc *desc, u32 desc_id,
+		       u64 dest, u64 src, u32 size)
+{
+	desc->src_lo = cpu_to_le32(src & 0xfffffffful);
+	desc->src_hi = cpu_to_le32((src >> 32));
+	desc->dst_lo = cpu_to_le32(dest & 0xfffffffful);
+	desc->dst_hi = cpu_to_le32((dest >> 32));
+	desc->ctl_dma_len = cpu_to_le32((size >> 2) | (desc_id << 18));
+	desc->reserved[0] = cpu_to_le32(0x0);
+	desc->reserved[1] = cpu_to_le32(0x0);
+	desc->reserved[2] = cpu_to_le32(0x0);
+}
+
+static
+int setup_descs(struct dma_desc *descs, unsigned int desc_id,
+		enum dma_data_direction direction,
+		dma_addr_t dev_addr, dma_addr_t host_addr, unsigned int len,
+		unsigned int *_set)
+{
+	int nr_descs = 0;
+	unsigned int set = 0;
+	dma_addr_t src;
+	dma_addr_t dest;
+
+	if (desc_id >= DMA_DESC_MAX)
+		return -EINVAL;
+
+	if (direction == DMA_TO_DEVICE) {
+		src = host_addr;
+		dest = dev_addr;
+	} else {
+		src = dev_addr;
+		dest = host_addr;
+	}
+
+	while (len) {
+		unsigned int xfer_len = min_t(unsigned int, len, AVALON_DMA_MAX_TANSFER_SIZE);
+
+		setup_desc(descs, desc_id, dest, src, xfer_len);
+
+		set += xfer_len;
+
+		nr_descs++;
+		if (nr_descs >= DMA_DESC_MAX)
+			break;
+
+		desc_id++;
+		if (desc_id >= DMA_DESC_MAX)
+			break;
+
+		descs++;
+
+		dest += xfer_len;
+		src += xfer_len;
+
+		len -= xfer_len;
+	}
+
+	*_set = set;
+
+	return nr_descs;
+}
+
+int setup_descs_sg(struct dma_desc *descs, unsigned int desc_id,
+		   enum dma_data_direction direction,
+		   dma_addr_t dev_addr,
+		   struct dma_segment *seg, unsigned int nr_segs,
+		   unsigned int seg_start, unsigned int seg_off,
+		   unsigned int *seg_stop, unsigned int *seg_set)
+{
+	unsigned int set = -1;
+	int nr_descs = 0;
+	int ret;
+	int i;
+
+	if (seg_start >= nr_segs)
+		return -EINVAL;
+	if ((direction != DMA_TO_DEVICE) && (direction != DMA_FROM_DEVICE))
+		return -EINVAL;
+
+	/*
+	 * Skip all SGEs that have been fully transmitted.
+	 */
+	for (i = 0; i < seg_start; i++)
+		dev_addr += seg[i].dma_len;
+
+	/*
+	 * Skip the current SGE if it has been fully transmitted.
+	 */
+	if (seg[i].dma_len == seg_off) {
+		dev_addr += seg_off;
+		seg_off = 0;
+		i++;
+	}
+
+	/*
+	 * Setup as many SGEs as the controller is able to transmit.
+	 */
+	for (; i < nr_segs; i++) {
+		dma_addr_t dma_addr = seg[i].dma_addr;
+		unsigned int dma_len = seg[i].dma_len;
+
+		/*
+		 * The offset can not be longer than the SGE length.
+		 */
+		if (dma_len < seg_off)
+			return -EINVAL;
+
+		if (seg_off) {
+			dev_addr += seg_off;
+			dma_addr += seg_off;
+			dma_len -= seg_off;
+
+			seg_off = 0;
+		}
+
+		ret = setup_descs(descs, desc_id, direction,
+				  dev_addr, dma_addr, dma_len, &set);
+		if (ret < 0)
+			return ret;
+
+		if ((desc_id + ret > DMA_DESC_MAX) ||
+		    (nr_descs + ret > DMA_DESC_MAX))
+			return -EINVAL;
+
+		nr_descs += ret;
+		desc_id += ret;
+
+		/*
+		 * Stop when descriptor table entries are exhausted.
+		 */
+		if (desc_id == DMA_DESC_MAX)
+			break;
+
+		/*
+		 * The descriptor table still has free entries, thus
+		 * the current SGE should have fit.
+		 */
+		if (dma_len != set)
+			return -EINVAL;
+
+		if (i >= nr_segs - 1)
+			break;
+
+		descs += ret;
+		dev_addr += dma_len;
+	}
+
+	/*
+	 * Remember the SGE that next transmission should be started from.
+	 */
+	if (nr_descs) {
+		*seg_stop = i;
+		*seg_set = set;
+	} else {
+		*seg_stop = seg_start;
+		*seg_set = seg_off;
+	}
+
+	return nr_descs;
+}
+
+void start_xfer(void __iomem *base, size_t ctrl_off,
+		u32 rc_src_hi, u32 rc_src_lo,
+		u32 ep_dst_hi, u32 ep_dst_lo,
+		int last_id)
+{
+	av_write32(rc_src_hi, base, ctrl_off, rc_src_hi);
+	av_write32(rc_src_lo, base, ctrl_off, rc_src_lo);
+	av_write32(ep_dst_hi, base, ctrl_off, ep_dst_hi);
+	av_write32(ep_dst_lo, base, ctrl_off, ep_dst_lo);
+	av_write32(last_id, base, ctrl_off, table_size);
+	av_write32(last_id, base, ctrl_off, last_ptr);
+}
diff --git a/drivers/dma/avalon/avalon-hw.h b/drivers/dma/avalon/avalon-hw.h
new file mode 100644
index 000000000000..18e495b28f99
--- /dev/null
+++ b/drivers/dma/avalon/avalon-hw.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA engine
+ */
+#ifndef __AVALON_HW_H__
+#define __AVALON_HW_H__
+
+#include <linux/dma-direction.h>
+#include <linux/io.h>
+
+#define AVALON_DMA_DESC_NUM		128
+
+#define AVALON_DMA_FIXUP_SIZE		0x100
+#define AVALON_DMA_MAX_TANSFER_SIZE	(0x100000 - AVALON_DMA_FIXUP_SIZE)
+
+#define AVALON_DMA_RD_CTRL_OFFSET	0x0
+#define AVALON_DMA_WR_CTRL_OFFSET	0x100
+
+extern unsigned long ctrl_base;
+
+static inline
+u32 __av_read32(void __iomem *base, size_t ctrl_off, size_t reg_off)
+{
+	size_t offset = ctrl_base + ctrl_off + reg_off;
+
+	return ioread32(base + offset);
+}
+
+static inline
+void __av_write32(u32 val,
+		  void __iomem *base, size_t ctrl_off, size_t reg_off)
+{
+	size_t offset = ctrl_base + ctrl_off + reg_off;
+
+	iowrite32(val, base + offset);
+}
+
+#define av_read32(b, o, r) \
+	__av_read32(b, o, offsetof(struct dma_ctrl, r))
+#define av_write32(v, b, o, r) \
+	__av_write32(v, b, o, offsetof(struct dma_ctrl, r))
+
+struct dma_ctrl {
+	u32 rc_src_lo;
+	u32 rc_src_hi;
+	u32 ep_dst_lo;
+	u32 ep_dst_hi;
+	u32 last_ptr;
+	u32 table_size;
+	u32 control;
+} __packed;
+
+struct dma_desc {
+	u32 src_lo;
+	u32 src_hi;
+	u32 dst_lo;
+	u32 dst_hi;
+	u32 ctl_dma_len;
+	u32 reserved[3];
+} __packed;
+
+struct dma_desc_table {
+	u32 flags[AVALON_DMA_DESC_NUM];
+	struct dma_desc descs[AVALON_DMA_DESC_NUM];
+} __packed;
+
+struct dma_segment {
+	dma_addr_t	dma_addr;
+	unsigned int	dma_len;
+};
+
+int setup_descs_sg(struct dma_desc *descs, unsigned int desc_id,
+		   enum dma_data_direction direction,
+		   dma_addr_t dev_addr,
+		   struct dma_segment *seg, unsigned int nr_segs,
+		   unsigned int seg_start, unsigned int sg_off,
+		   unsigned int *seg_stop, unsigned int *seg_set);
+
+void start_xfer(void __iomem *base, size_t ctrl_off,
+		u32 rc_src_hi, u32 rc_src_lo,
+		u32 ep_dst_hi, u32 ep_dst_lo,
+		int last_id);
+#endif
diff --git a/drivers/dma/avalon/avalon-pci.c b/drivers/dma/avalon/avalon-pci.c
new file mode 100644
index 000000000000..701ecb419097
--- /dev/null
+++ b/drivers/dma/avalon/avalon-pci.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ *
+ * Avalon DMA driver
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "avalon-core.h"
+
+#define DRIVER_NAME "avalon-dma"
+
+static unsigned int pci_bar = 0;
+module_param(pci_bar, uint, 0644);
+MODULE_PARM_DESC(pci_bar,
+		 "PCI BAR number the controller is mapped to (default: 0)");
+
+static unsigned int pci_msi_vector = 0;
+module_param(pci_msi_vector, uint, 0644);
+MODULE_PARM_DESC(pci_msi_vector,
+		 "MSI vector number used for the controller (default: 0)");
+
+static unsigned int pci_msi_count_order = 5;
+module_param(pci_msi_count_order, uint, 0644);
+MODULE_PARM_DESC(pci_msi_count_order,
+		 "Number of MSI vectors (order) device uses (default: 5)");
+
+static int init_interrupts(struct pci_dev *pci_dev)
+{
+	unsigned int nr_vecs = BIT(pci_msi_count_order);
+	int ret;
+
+	ret = pci_alloc_irq_vectors(pci_dev, nr_vecs, nr_vecs, PCI_IRQ_MSI);
+	if (ret < 0) {
+		return ret;
+
+	} else if (ret != nr_vecs) {
+		ret = -ENOSPC;
+		goto disable_msi;
+	}
+
+	ret = pci_irq_vector(pci_dev, pci_msi_vector);
+	if (ret < 0)
+		goto disable_msi;
+
+	return ret;
+
+disable_msi:
+	pci_disable_msi(pci_dev);
+
+	return ret;
+}
+
+static void term_interrupts(struct pci_dev *pci_dev)
+{
+	pci_disable_msi(pci_dev);
+}
+
+static int avalon_pci_probe(struct pci_dev *pci_dev,
+			    const struct pci_device_id *id)
+{
+	void *adma;
+	void __iomem *regs;
+	int ret;
+
+	ret = pci_enable_device(pci_dev);
+	if (ret)
+		return ret;
+
+	ret = pci_request_regions(pci_dev, DRIVER_NAME);
+	if (ret)
+		goto disable_device;
+
+	regs = pci_ioremap_bar(pci_dev, pci_bar);
+	if (!regs) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+
+	ret = init_interrupts(pci_dev);
+	if (ret < 0)
+		goto unmap_bars;
+
+	adma = avalon_dma_register(&pci_dev->dev, regs, ret);
+	if (IS_ERR(adma)) {
+		ret = PTR_ERR(adma);
+		goto terminate_interrupts;
+	}
+
+	pci_set_master(pci_dev);
+	pci_set_drvdata(pci_dev, adma);
+
+	return 0;
+
+terminate_interrupts:
+	term_interrupts(pci_dev);
+
+unmap_bars:
+	pci_iounmap(pci_dev, regs);
+
+release_regions:
+	pci_release_regions(pci_dev);
+
+disable_device:
+	pci_disable_device(pci_dev);
+
+	return ret;
+}
+
+static void avalon_pci_remove(struct pci_dev *pci_dev)
+{
+	void *adma = pci_get_drvdata(pci_dev);
+	void __iomem *regs = avalon_dma_mmio(adma);
+
+	pci_set_drvdata(pci_dev, NULL);
+
+	avalon_dma_unregister(adma);
+	term_interrupts(pci_dev);
+
+	pci_iounmap(pci_dev, regs);
+	pci_release_regions(pci_dev);
+	pci_disable_device(pci_dev);
+}
+
+static struct pci_device_id avalon_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALTERA, 0xe003) },
+	{ 0 }
+};
+
+static struct pci_driver avalon_pci_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= avalon_pci_ids,
+	.probe		= avalon_pci_probe,
+	.remove		= avalon_pci_remove,
+};
+
+module_pci_driver(avalon_pci_driver);
+
+MODULE_AUTHOR("Alexander Gordeev <a.gordeev.box@gmail.com>");
+MODULE_DESCRIPTION("Avalon-MM DMA Interface for PCIe");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(pci, avalon_pci_ids);
-- 
2.23.0

