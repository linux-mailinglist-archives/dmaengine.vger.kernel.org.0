Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA5D0C53
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfJIKMl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 06:12:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34165 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfJIKMk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 06:12:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so2144895wrp.1;
        Wed, 09 Oct 2019 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzJm8ojiiqQKaDHCAC5kSYywE0ajKFFCejFKHCbgIaM=;
        b=iqHZkqAR/qmWuTOnnaszCWb6jHlSXGp/LaCQ7GUp3oPfHvrvzAKfBWMg4jbeFtarmf
         6rP2tmvLya4UZ6GDOEDmh2SZHJB1XVH4PhxdCOdiTSosVxBFZLHGDVMo50WozE/lFpdq
         1oRQxoFkqVTbaaCZ6R/H4PTHa/aRPlzRS+LDVWMLcVtc0g5DsHXtzbB+k5HiaZgpVvqm
         KEfeHuBfhnQ5YFrFf5wM/S2i2m4iTstRaMB9TIHQcxkEEeJXzaXo9Xz2g/Rky+F7XlBF
         dK9LKgF2i0xs7pnJGOQv+zgELkTGnk1ZDnH3jSqlzv6mzvBRQQX7sN+3GQi+ib5E8hyz
         kAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzJm8ojiiqQKaDHCAC5kSYywE0ajKFFCejFKHCbgIaM=;
        b=mSjJgnteOipH4SktSqrm1QHjngQz9KBZw1lz5cEXsSnrt0C3RKVIHZOjQvemXtioUP
         g5FKE1I45uEgHgafmA6w7B8O02VCJ0nMANfvBJIAHbQc7FthW8LQEN8UcHpP5nNPBmuC
         eHsxKRC69kVZUS+XWUJDIR1axGs7s8YWALKZksa0pN92jay9VsLMDdVlsehlT6QBRwHJ
         6bP8eGGx6IhMsI1raMvqLGXSznXBNQ8p/y1SDzA9DOPAp1XymaF2yrTIhkQmF9Bvf+Yf
         +xA+im6LzG0pQ15dR8FLtIeX+0Ru4oblD0elaemsUwIao69UCftuLz5PeaGpMO8f1FQ1
         9XOg==
X-Gm-Message-State: APjAAAUux2Rw+ZCIA6ozpqSkRXEhGzCkuf2FZI878RNaeYAAxf3t4PPe
        r1lgheZaw6VKv/oQJPk4jLOKG2Ob
X-Google-Smtp-Source: APXvYqxycLjOHgW4HHDfBCjV608wLSgvtqtIqIT30mrvhnTzJ74sS0qnX5LuO9YEsbur61rBIf/iJQ==
X-Received: by 2002:a5d:6304:: with SMTP id i4mr2120343wru.4.1570615957264;
        Wed, 09 Oct 2019 03:12:37 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.46])
        by smtp.googlemail.com with ESMTPSA id c9sm1734065wrt.7.2019.10.09.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:12:36 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        Michael Chen <micchen@altera.com>, devel@driverdev.osuosl.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe
Date:   Wed,  9 Oct 2019 12:12:30 +0200
Message-Id: <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570558807.git.a.gordeev.box@gmail.com>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Support Avalon-MM DMA Interface for PCIe used in hard IPs for
Intel Arria, Cyclone or Stratix FPGAs.

CC: Michael Chen <micchen@altera.com>
CC: devel@driverdev.osuosl.org
CC: dmaengine@vger.kernel.org

Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
---
 drivers/dma/Kconfig              |   2 +
 drivers/dma/Makefile             |   1 +
 drivers/dma/avalon/Kconfig       |  88 +++++++
 drivers/dma/avalon/Makefile      |   6 +
 drivers/dma/avalon/avalon-core.c | 432 +++++++++++++++++++++++++++++++
 drivers/dma/avalon/avalon-core.h |  90 +++++++
 drivers/dma/avalon/avalon-hw.c   | 212 +++++++++++++++
 drivers/dma/avalon/avalon-hw.h   |  86 ++++++
 drivers/dma/avalon/avalon-pci.c  | 150 +++++++++++
 9 files changed, 1067 insertions(+)
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
index 000000000000..09e0773fcdb2
--- /dev/null
+++ b/drivers/dma/avalon/Kconfig
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Avalon DMA engine
+#
+# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+#
+config AVALON_DMA
+	tristate "Intel Avalon-MM DMA Interface for PCIe"
+	depends on PCI
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  This selects a driver for Avalon-MM DMA Interface for PCIe
+	  hard IP block used in Intel Arria, Cyclone or Stratix FPGAs.
+
+if AVALON_DMA
+
+config AVALON_DMA_MASK_WIDTH
+	int "Avalon DMA streaming and coherent bitmask width"
+	range 0 64
+	default 64
+	help
+	  Width of bitmask for streaming and coherent DMA operations
+
+config AVALON_DMA_CTRL_BASE
+	hex "Avalon DMA controllers base"
+	default "0x00000000"
+
+config AVALON_DMA_RD_EP_DST_LO
+	hex "Avalon DMA read controller base low"
+	default "0x80000000"
+	help
+	  Specifies the lower 32-bits of the base address of the read
+	  status and descriptor table in the Root Complex memory.
+
+config AVALON_DMA_RD_EP_DST_HI
+	hex "Avalon DMA read controller base high"
+	default "0x00000000"
+	help
+	  Specifies the upper 32-bits of the base address of the read
+	  status and descriptor table in the Root Complex memory.
+
+config AVALON_DMA_WR_EP_DST_LO
+	hex "Avalon DMA write controller base low"
+	default "0x80002000"
+	help
+	  Specifies the lower 32-bits of the base address of the write
+	  status and descriptor table in the Root Complex memory.
+
+config AVALON_DMA_WR_EP_DST_HI
+	hex "Avalon DMA write controller base high"
+	default "0x00000000"
+	help
+	  Specifies the upper 32-bits of the base address of the write
+	  status and descriptor table in the Root Complex memory.
+
+config AVALON_DMA_PCI_VENDOR_ID
+	hex "PCI vendor ID"
+	default "0x1172"
+
+config AVALON_DMA_PCI_DEVICE_ID
+	hex "PCI device ID"
+	default "0xe003"
+
+config AVALON_DMA_PCI_BAR
+	int "PCI device BAR the Avalon DMA controller is mapped to"
+	range 0 5
+	default 0
+	help
+	  Number of PCI BAR the DMA controller is mapped to
+
+config AVALON_DMA_PCI_MSI_COUNT_ORDER
+	int "Count of MSIs the PCI device provides (order)"
+	range 0 5
+	default 5
+	help
+	  Number of vectors the PCI device uses in multiple MSI mode.
+	  This number is provided as the power of two.
+
+config AVALON_DMA_PCI_MSI_VECTOR
+	int "Vector number the DMA controller is mapped to"
+	range 0 31
+	default 0
+	help
+	  Number of MSI vector the DMA controller is mapped to in
+	  multiple MSI mode.
+
+endif
diff --git a/drivers/dma/avalon/Makefile b/drivers/dma/avalon/Makefile
new file mode 100644
index 000000000000..4b5278d12f86
--- /dev/null
+++ b/drivers/dma/avalon/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_AVALON_DMA)	+= avalon-dma.o
+
+avalon-dma-objs			:= avalon-hw.o \
+				   avalon-core.o \
+				   avalon-pci.o
diff --git a/drivers/dma/avalon/avalon-core.c b/drivers/dma/avalon/avalon-core.c
new file mode 100644
index 000000000000..c8357596b58f
--- /dev/null
+++ b/drivers/dma/avalon/avalon-core.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
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
+#define DMA_MASK_WIDTH		CONFIG_AVALON_DMA_MASK_WIDTH
+
+static int setup_dma_descs(struct dma_desc *dma_descs,
+			   struct avalon_dma_desc *desc)
+{
+	struct scatterlist *sg_stop;
+	unsigned int sg_set;
+	int ret;
+
+	ret = setup_descs_sg(dma_descs, 0,
+			     desc->direction,
+			     desc->dev_addr,
+			     desc->sg, desc->sg_len,
+			     desc->sg_curr, desc->sg_offset,
+			     &sg_stop, &sg_set);
+	BUG_ON(!ret);
+	if (ret > 0) {
+		if (sg_stop == desc->sg_curr) {
+			desc->sg_offset += sg_set;
+		} else {
+			desc->sg_curr = sg_stop;
+			desc->sg_offset = sg_set;
+		}
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
+		ep_dst_hi = AVALON_DMA_RD_EP_DST_HI;
+		ep_dst_lo = AVALON_DMA_RD_EP_DST_LO;
+
+		__last_id = &hw->h2d_last_id;
+	} else if (desc->direction == DMA_FROM_DEVICE) {
+		__table = &hw->dma_desc_table_wr;
+
+		ctrl_off = AVALON_DMA_WR_CTRL_OFFSET;
+
+		ep_dst_hi = AVALON_DMA_WR_EP_DST_HI;
+		ep_dst_lo = AVALON_DMA_WR_EP_DST_LO;
+
+		__last_id = &hw->d2h_last_id;
+	} else {
+		BUG();
+	}
+
+	table = __table->cpu_addr;
+	memset(&table->flags, 0, sizeof(table->flags));
+
+	nr_descs = setup_dma_descs(table->descs, desc);
+	if (WARN_ON(nr_descs < 1))
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
+	struct scatterlist *sg_curr = desc->sg_curr;
+	unsigned int sg_len = sg_dma_len(sg_curr);
+
+	if (!sg_is_last(sg_curr))
+		return false;
+
+	BUG_ON(desc->sg_offset > sg_len);
+	if (desc->sg_offset < sg_len)
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
+	spinlock_t *lock = &chan->vchan.lock;
+	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
+	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
+	struct avalon_dma_desc *desc;
+	struct virt_dma_desc *vdesc;
+	bool rd_done;
+	bool wr_done;
+
+	spin_lock(lock);
+
+	rd_done = (hw->h2d_last_id < 0);
+	wr_done = (hw->d2h_last_id < 0);
+
+	if (rd_done && wr_done) {
+		spin_unlock(lock);
+		return IRQ_NONE;
+	}
+
+	do {
+		if (!rd_done && rd_flags[hw->h2d_last_id])
+			rd_done = true;
+
+		if (!wr_done && wr_flags[hw->d2h_last_id])
+			wr_done = true;
+	} while (!rd_done || !wr_done);
+
+	hw->h2d_last_id = -1;
+	hw->d2h_last_id = -1;
+
+	BUG_ON(!chan->active_desc);
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
+	if (chan->active_desc) {
+		BUG_ON(desc != chan->active_desc);
+		start_dma_xfer(hw, desc);
+	}
+
+	spin_unlock(lock);
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
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(DMA_MASK_WIDTH));
+	if (ret)
+		goto dma_set_mask_err;
+
+	hw->dma_desc_table_rd.cpu_addr = dma_alloc_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		&hw->dma_desc_table_rd.dma_addr,
+		GFP_KERNEL);
+	if (!hw->dma_desc_table_rd.cpu_addr) {
+		ret = -ENOMEM;
+		goto alloc_rd_dma_table_err;
+	}
+
+	hw->dma_desc_table_wr.cpu_addr = dma_alloc_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		&hw->dma_desc_table_wr.dma_addr,
+		GFP_KERNEL);
+	if (!hw->dma_desc_table_wr.cpu_addr) {
+		ret = -ENOMEM;
+		goto alloc_wr_dma_table_err;
+	}
+
+	ret = request_irq(irq, avalon_dma_interrupt, IRQF_SHARED,
+			  INTERRUPT_NAME, adma);
+	if (ret)
+		goto req_irq_err;
+
+	return 0;
+
+req_irq_err:
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		hw->dma_desc_table_wr.cpu_addr,
+		hw->dma_desc_table_wr.dma_addr);
+
+alloc_wr_dma_table_err:
+	dma_free_coherent(
+		dev,
+		sizeof(struct dma_desc_table),
+		hw->dma_desc_table_rd.cpu_addr,
+		hw->dma_desc_table_rd.dma_addr);
+
+alloc_rd_dma_table_err:
+dma_set_mask_err:
+	return ret;
+}
+
+static void avalon_dma_term(struct avalon_dma *adma)
+{
+	struct avalon_dma_chan *chan = &adma->chan;
+	struct avalon_dma_hw *hw = &chan->hw;
+	struct device *dev = adma->dev;
+
+	free_irq(adma->irq, (void *)adma);
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
+	gfp_t gfp_flags = in_interrupt() ? GFP_NOWAIT : GFP_KERNEL;
+	dma_addr_t dev_addr;
+
+	if (direction == DMA_MEM_TO_DEV)
+		dev_addr = chan->dst_addr;
+	else if (direction == DMA_DEV_TO_MEM)
+		dev_addr = chan->src_addr;
+	else
+		return NULL;
+
+	desc = kzalloc(sizeof(*desc), gfp_flags);
+	if (!desc)
+		return NULL;
+
+	desc->direction = direction;
+	desc->dev_addr	= dev_addr;
+	desc->sg	= sg;
+	desc->sg_len	= sg_len;
+	desc->sg_curr	= sg;
+	desc->sg_offset	= 0;
+
+	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
+}
+
+static void avalon_dma_issue_pending(struct dma_chan *dma_chan)
+{
+	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
+	struct avalon_dma_hw *hw = &chan->hw;
+	spinlock_t *lock = &chan->vchan.lock;
+	struct avalon_dma_desc *desc;
+	struct virt_dma_desc *vdesc;
+	unsigned long flags;
+
+	spin_lock_irqsave(lock, flags);
+
+	if (!vchan_issue_pending(&chan->vchan))
+		goto out;
+
+	/*
+	 * Do nothing if a DMA transmission is currently active.
+	 * BOTH read and write status must be checked here!
+	 */
+	if (hw->d2h_last_id < 0 && hw->h2d_last_id < 0) {
+		BUG_ON(chan->active_desc);
+
+		vdesc = vchan_next_desc(&chan->vchan);
+		BUG_ON(!vdesc);
+		desc = to_avalon_dma_desc(vdesc);
+
+		if (start_dma_xfer(hw, desc))
+			goto out;
+
+		chan->active_desc = desc;
+	} else {
+		BUG_ON(!chan->active_desc);
+	}
+
+out:
+	spin_unlock_irqrestore(lock, flags);
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
+		goto avalon_init_err;
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
+	chan->vchan.desc_free = avalon_dma_desc_free;
+	vchan_init(&chan->vchan, dma_dev);
+
+	ret = dma_async_device_register(dma_dev);
+	if (ret)
+		goto dma_dev_reg;
+
+	return adma;
+
+dma_dev_reg:
+avalon_init_err:
+	kfree(adma);
+
+	return NULL;
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
index 000000000000..07a68c4d228f
--- /dev/null
+++ b/drivers/dma/avalon/avalon-core.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_CORE_H__
+#define __AVALON_CORE_H__
+
+#include <linux/interrupt.h>
+#include <linux/dma-direction.h>
+
+#include "../virt-dma.h"
+
+struct avalon_dma_desc {
+	struct virt_dma_desc	vdesc;
+
+	enum dma_data_direction	direction;
+
+	dma_addr_t		dev_addr;
+
+	struct scatterlist	*sg;
+	unsigned int		sg_len;
+
+	struct scatterlist	*sg_curr;
+	unsigned int		sg_offset;
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
index 000000000000..1210b0791a97
--- /dev/null
+++ b/drivers/dma/avalon/avalon-hw.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/delay.h>
+
+#include "avalon-hw.h"
+
+#define DMA_DESC_MAX	AVALON_DMA_DESC_NUM
+
+static void setup_desc(struct dma_desc *desc, u32 desc_id,
+		       u64 dest, u64 src, u32 size)
+{
+	BUG_ON(!size);
+	WARN_ON(!IS_ALIGNED(size, sizeof(u32)));
+	BUG_ON(desc_id > (DMA_DESC_MAX - 1));
+
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
+	if (direction == DMA_TO_DEVICE) {
+		src = host_addr;
+		dest = dev_addr;
+	} else if (direction == DMA_FROM_DEVICE) {
+		src = dev_addr;
+		dest = host_addr;
+	} else {
+		BUG();
+		return -EINVAL;
+	}
+
+	if (unlikely(desc_id > DMA_DESC_MAX - 1)) {
+		BUG();
+		return -EINVAL;
+	}
+
+	if (WARN_ON(!len))
+		return -EINVAL;
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
+		   struct scatterlist *__sg, unsigned int __sg_len,
+		   struct scatterlist *sg_start, unsigned int sg_offset,
+		   struct scatterlist **_sg_stop, unsigned int *_sg_set)
+{
+	struct scatterlist *sg;
+	dma_addr_t sg_addr;
+	unsigned int sg_len;
+	unsigned int sg_set;
+	int nr_descs = 0;
+	int ret;
+	int i;
+
+	/*
+	 * Find the SGE that the previous xfer has stopped on -
+	 * it should exist.
+	 */
+	for_each_sg(__sg, sg, __sg_len, i) {
+		if (sg == sg_start)
+			break;
+
+		dev_addr += sg_dma_len(sg);
+	}
+
+	if (WARN_ON(i >= __sg_len))
+		return -EINVAL;
+
+	/*
+	 * The offset can not be longer than the SGE length.
+	 */
+	sg_len = sg_dma_len(sg);
+	if (WARN_ON(sg_len < sg_offset))
+		return -EINVAL;
+
+	/*
+	 * Skip the starting SGE if it has been fully transmitted.
+	 */
+	if (sg_offset == sg_len) {
+		if (WARN_ON(sg_is_last(sg)))
+			return -EINVAL;
+
+		dev_addr += sg_len;
+		sg_offset = 0;
+
+		i++;
+		sg = sg_next(sg);
+	}
+
+	/*
+	 * Setup as many SGEs as the controller is able to transmit.
+	 */
+	BUG_ON(i >= __sg_len);
+	for (; i < __sg_len; i++) {
+		sg_addr = sg_dma_address(sg);
+		sg_len = sg_dma_len(sg);
+
+		if (sg_offset) {
+			if (unlikely(sg_len <= sg_offset)) {
+				BUG();
+				return -EINVAL;
+			}
+
+			dev_addr += sg_offset;
+			sg_addr += sg_offset;
+			sg_len -= sg_offset;
+
+			sg_offset = 0;
+		}
+
+		ret = setup_descs(descs, desc_id, direction,
+				  dev_addr, sg_addr, sg_len, &sg_set);
+		if (ret < 0)
+			return ret;
+
+		if (unlikely((desc_id + ret > DMA_DESC_MAX) ||
+			     (nr_descs + ret > DMA_DESC_MAX))) {
+			BUG();
+			return -ENOMEM;
+		}
+
+		nr_descs += ret;
+		desc_id += ret;
+
+		if (desc_id >= DMA_DESC_MAX)
+			break;
+
+		if (unlikely(sg_len != sg_set)) {
+			BUG();
+			return -EINVAL;
+		}
+
+		if (sg_is_last(sg))
+			break;
+
+		descs += ret;
+		dev_addr += sg_len;
+
+		sg = sg_next(sg);
+	}
+
+	/*
+	 * Remember the SGE that next transmission should be started from
+	 */
+	BUG_ON(!sg);
+	*_sg_stop = sg;
+	*_sg_set = sg_set;
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
index 000000000000..4a6c441e009e
--- /dev/null
+++ b/drivers/dma/avalon/avalon-hw.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Avalon DMA engine
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef __AVALON_HW_H__
+#define __AVALON_HW_H__
+
+#include <linux/dma-direction.h>
+#include <linux/scatterlist.h>
+
+#define AVALON_DMA_DESC_NUM		128
+
+#define AVALON_DMA_FIXUP_SIZE		0x100
+#define AVALON_DMA_MAX_TANSFER_SIZE	(0x100000 - AVALON_DMA_FIXUP_SIZE)
+
+#define AVALON_DMA_CTRL_BASE		CONFIG_AVALON_DMA_CTRL_BASE
+#define AVALON_DMA_RD_CTRL_OFFSET	0x0
+#define AVALON_DMA_WR_CTRL_OFFSET	0x100
+
+#define AVALON_DMA_RD_EP_DST_LO		CONFIG_AVALON_DMA_RD_EP_DST_LO
+#define AVALON_DMA_RD_EP_DST_HI		CONFIG_AVALON_DMA_RD_EP_DST_HI
+#define AVALON_DMA_WR_EP_DST_LO		CONFIG_AVALON_DMA_WR_EP_DST_LO
+#define AVALON_DMA_WR_EP_DST_HI		CONFIG_AVALON_DMA_WR_EP_DST_HI
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
+static inline u32 __av_read32(void __iomem *base,
+			      size_t ctrl_off,
+			      size_t reg_off)
+{
+	size_t offset = AVALON_DMA_CTRL_BASE + ctrl_off + reg_off;
+
+	return ioread32(base + offset);
+}
+
+static inline void __av_write32(u32 value,
+				void __iomem *base,
+				size_t ctrl_off,
+				size_t reg_off)
+{
+	size_t offset = AVALON_DMA_CTRL_BASE + ctrl_off + reg_off;
+
+	iowrite32(value, base + offset);
+}
+
+#define av_read32(b, o, r) \
+	__av_read32(b, o, offsetof(struct dma_ctrl, r))
+#define av_write32(v, b, o, r) \
+	__av_write32(v, b, o, offsetof(struct dma_ctrl, r))
+
+int setup_descs_sg(struct dma_desc *descs, unsigned int desc_id,
+		   enum dma_data_direction direction,
+		   dma_addr_t dev_addr,
+		   struct scatterlist *__sg, unsigned int __sg_len,
+		   struct scatterlist *sg_start, unsigned int sg_offset,
+		   struct scatterlist **_sg_stop, unsigned int *_sg_set);
+
+void start_xfer(void __iomem *base, size_t ctrl_off,
+		u32 rc_src_hi, u32 rc_src_lo,
+		u32 ep_dst_hi, u32 ep_dst_lo,
+		int last_id);
+#endif
diff --git a/drivers/dma/avalon/avalon-pci.c b/drivers/dma/avalon/avalon-pci.c
new file mode 100644
index 000000000000..68546204b8eb
--- /dev/null
+++ b/drivers/dma/avalon/avalon-pci.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Avalon DMA driver
+ *
+ * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "avalon-core.h"
+
+#define DRIVER_NAME		"avalon-dma"
+
+#define PCI_BAR			CONFIG_AVALON_DMA_PCI_BAR
+#define PCI_MSI_VECTOR		CONFIG_AVALON_DMA_PCI_MSI_VECTOR
+#define PCI_MSI_COUNT		BIT(CONFIG_AVALON_DMA_PCI_MSI_COUNT_ORDER)
+
+#define AVALON_DMA_PCI_VENDOR_ID	CONFIG_AVALON_DMA_PCI_VENDOR_ID
+#define AVALON_DMA_PCI_DEVICE_ID	CONFIG_AVALON_DMA_PCI_DEVICE_ID
+
+static int init_interrupts(struct pci_dev *pci_dev)
+{
+	int ret;
+
+	ret = pci_alloc_irq_vectors(pci_dev,
+				    PCI_MSI_COUNT, PCI_MSI_COUNT,
+				    PCI_IRQ_MSI);
+	if (ret < 0) {
+		goto msi_err;
+	} else if (ret != PCI_MSI_COUNT) {
+		ret = -ENOSPC;
+		goto nr_msi_err;
+	}
+
+	ret = pci_irq_vector(pci_dev, PCI_MSI_VECTOR);
+	if (ret < 0)
+		goto vec_err;
+
+	return ret;
+
+vec_err:
+nr_msi_err:
+	pci_disable_msi(pci_dev);
+
+msi_err:
+	return ret;
+}
+
+static void term_interrupts(struct pci_dev *pci_dev)
+{
+	pci_disable_msi(pci_dev);
+}
+
+static int __init avalon_pci_probe(struct pci_dev *pci_dev,
+				   const struct pci_device_id *id)
+{
+	void *adma;
+	void __iomem *regs;
+	int ret;
+
+	ret = pci_enable_device(pci_dev);
+	if (ret)
+		goto enable_err;
+
+	ret = pci_request_regions(pci_dev, DRIVER_NAME);
+	if (ret)
+		goto reg_err;
+
+	regs = pci_ioremap_bar(pci_dev, PCI_BAR);
+	if (!regs) {
+		ret = -ENOMEM;
+		goto ioremap_err;
+	}
+
+	ret = init_interrupts(pci_dev);
+	if (ret < 0)
+		goto int_err;
+
+	adma = avalon_dma_register(&pci_dev->dev, regs, ret);
+	if (IS_ERR(adma)) {
+		ret = PTR_ERR(adma);
+		goto dma_err;
+	}
+
+	pci_set_master(pci_dev);
+	pci_set_drvdata(pci_dev, adma);
+
+	return 0;
+
+dma_err:
+	term_interrupts(pci_dev);
+
+int_err:
+	pci_iounmap(pci_dev, regs);
+
+ioremap_err:
+	pci_release_regions(pci_dev);
+
+reg_err:
+	pci_disable_device(pci_dev);
+
+enable_err:
+	return ret;
+}
+
+static void __exit avalon_pci_remove(struct pci_dev *pci_dev)
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
+static struct pci_device_id pci_ids[] = {
+	{ PCI_DEVICE(AVALON_DMA_PCI_VENDOR_ID, AVALON_DMA_PCI_DEVICE_ID) },
+	{ 0 }
+};
+
+static struct pci_driver dma_driver_ops = {
+	.name		= DRIVER_NAME,
+	.id_table	= pci_ids,
+	.probe		= avalon_pci_probe,
+	.remove		= avalon_pci_remove,
+};
+
+static int __init avalon_drv_init(void)
+{
+	return pci_register_driver(&dma_driver_ops);
+}
+
+static void __exit avalon_drv_exit(void)
+{
+	pci_unregister_driver(&dma_driver_ops);
+}
+
+module_init(avalon_drv_init);
+module_exit(avalon_drv_exit);
+
+MODULE_AUTHOR("Alexander Gordeev <a.gordeev.box@gmail.com>");
+MODULE_DESCRIPTION("Avalon-MM DMA Interface for PCIe");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(pci, pci_ids);
-- 
2.23.0

