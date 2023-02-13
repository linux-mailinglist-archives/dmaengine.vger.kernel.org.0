Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB6D69470E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Feb 2023 14:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBMNbs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 08:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBMNbr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 08:31:47 -0500
X-Greylist: delayed 416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 05:31:35 PST
Received: from out-250.mta0.migadu.com (out-250.mta0.migadu.com [IPv6:2001:41d0:1004:224b::fa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7C11B55E
        for <dmaengine@vger.kernel.org>; Mon, 13 Feb 2023 05:31:33 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676294687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKup9p/xeA9T5rGgS1Yb0rKEYRpMsoxolsVPXrOhsu4=;
        b=C4U9ouzErs0vO0uuEaMeGd0YZNEvR7OTHIJ2myB3FCbQFUseJxtvXrYmfChgjQP0700xVa
        C6F9FTRIGWJO2tdTl9ryUSQDSE7BQsXJWcM03xDV4pX2Frgi56ehbq5352A66yQotVfqV/
        G0lhhGOc/6U/FNCO9xV4uEltp5jcNOw=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Cai huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 3/4] dmaengine: dw-edma: Add support for native HDMA
Date:   Mon, 13 Feb 2023 21:24:08 +0800
Message-Id: <20230213132411.65524-4-cai.huoqing@linux.dev>
In-Reply-To: <20230213132411.65524-1-cai.huoqing@linux.dev>
References: <20230213132411.65524-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Cai huoqing <cai.huoqing@linux.dev>

Add support for HDMA NATIVE, as long the IP design has set
the compatible register map parameter-HDMA_NATIVE,
which allows compatibility for native HDMA register configuration.

The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
And the native HDMA registers are different from eDMA,
so this patch add support for HDMA NATIVE mode.

HDMA write and read channels operate independently to maximize
the performance of the HDMA read and write data transfer over
the link When you configure the HDMA with multiple read channels,
then it uses a round robin (RR) arbitration scheme to select
the next read channel to be serviced.
The same applies when you have multiple write channels.

The native HDMA driver also supports a maximum of 16 independent
channels (8 write + 8 read), which can run simultaneously.
Both SAR (Source Address Register) and DAR (Destination Address Register)
are alignmented to byte.

Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
---
 drivers/dma/dw-edma/Makefile          |   5 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 315 ++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.h |  17 ++
 drivers/dma/dw-edma/dw-hdma-v0-regs.h | 129 +++++++++++
 4 files changed, 464 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 8d45c0d5689d..b1c91ef2c63d 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
 dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
-dw-edma-objs			:= dw-edma-core.o \
-					dw-edma-v0-core.o $(dw-edma-y)
+dw-edma-objs			:= dw-edma-core.o	\
+				   dw-edma-v0-core.o	\
+				   dw-hdma-v0-core.o $(dw-edma-y)
 obj-$(CONFIG_DW_EDMA_PCIE)	+= dw-edma-pcie.o
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
new file mode 100644
index 000000000000..7e4f98987e29
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Cai Huoqing
+ * Synopsys DesignWare HDMA v0 core
+ */
+
+#include <linux/bitfield.h>
+
+#include "dw-edma-core.h"
+#include "dw-hdma-v0-core.h"
+#include "dw-hdma-v0-regs.h"
+
+enum dw_hdma_control {
+	DW_HDMA_V0_CB					= BIT(0),
+	DW_HDMA_V0_TCB					= BIT(1),
+	DW_HDMA_V0_LLP					= BIT(2),
+	DW_HDMA_V0_LIE					= BIT(3),
+	DW_HDMA_V0_RIE					= BIT(4),
+	DW_HDMA_V0_CCS					= BIT(8),
+	DW_HDMA_V0_LLE					= BIT(9),
+};
+
+static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
+{
+	return dw->chip->reg_base;
+}
+
+static inline struct dw_hdma_v0_ch_regs __iomem *
+__dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
+{
+	if (dir == EDMA_DIR_WRITE)
+		return &(__dw_regs(dw)->ch[ch].wr);
+	else
+		return &(__dw_regs(dw)->ch[ch].rd);
+}
+
+#define SET_CH_32(dw, dir, ch, name, value) \
+	writel(value, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define GET_CH_32(dw, dir, ch, name) \
+	readl(&(__dw_ch_regs(dw, dir, ch)->name))
+
+#define SET_BOTH_CH_32(dw, ch, name, value) \
+	do {					\
+		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_WRITE, ch)->name));		\
+		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_READ, ch)->name));	\
+	} while (0)
+
+/* HDMA management callbacks */
+static void dw_hdma_v0_core_off(struct dw_edma *dw)
+{
+	int id;
+
+	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
+		SET_BOTH_CH_32(dw, id, int_setup,
+			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		SET_BOTH_CH_32(dw, id, int_clear,
+			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		SET_BOTH_CH_32(dw, id, ch_en, 0);
+	}
+}
+
+static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	u32 num_ch = 0;
+	int id;
+
+	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
+		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
+			num_ch++;
+	}
+
+	if (num_ch > HDMA_V0_MAX_NR_CH)
+		num_ch = HDMA_V0_MAX_NR_CH;
+
+	return (u16)num_ch;
+}
+
+static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+	u32 tmp;
+
+	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
+			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
+
+	if (tmp == 1)
+		return DMA_IN_PROGRESS;
+	else if (tmp == 3)
+		return DMA_COMPLETE;
+	else
+		return DMA_ERROR;
+}
+
+static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_STOP_INT_MASK);
+}
+
+static void dw_hdma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_ABORT_INT_MASK);
+}
+
+static u32 dw_hdma_v0_core_status_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	return GET_CH_32(dw, chan->dir, chan->id, int_stat);
+}
+
+static u32 dw_hdma_v0_core_check_done_int(u32 val)
+{
+	return FIELD_GET(HDMA_V0_STOP_INT_MASK, val);
+}
+
+static u32 dw_hdma_v0_core_check_abort_int(u32 val)
+{
+	return FIELD_GET(HDMA_V0_ABORT_INT_MASK, val);
+}
+
+static
+void dw_hdma_v0_core_done_handle(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir)
+{
+	struct dw_edma *dw = dw_irq->dw;
+	unsigned long total, pos, val;
+	unsigned long off, mask;
+
+	if (dir == EDMA_DIR_WRITE) {
+		total = dw->wr_ch_cnt;
+		off = 0;
+		mask = dw_irq->wr_mask;
+	} else {
+		total = dw->rd_ch_cnt;
+		off = dw->wr_ch_cnt;
+		mask = dw_irq->rd_mask;
+	}
+
+	for_each_set_bit(pos, &mask, total) {
+		struct dw_edma_chan *chan = &dw->chan[pos + off];
+
+		val = dw_hdma_v0_core_status_int(chan);
+		if (dw_hdma_v0_core_check_done_int(val))
+			dw_edma_done_interrupt(chan);
+	}
+}
+
+static
+void dw_hdma_v0_core_abort_handle(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir)
+{
+	struct dw_edma *dw = dw_irq->dw;
+	unsigned long total, pos, val;
+	unsigned long off, mask;
+
+	if (dir == EDMA_DIR_WRITE) {
+		total = dw->wr_ch_cnt;
+		off = 0;
+		mask = dw_irq->wr_mask;
+	} else {
+		total = dw->rd_ch_cnt;
+		off = dw->wr_ch_cnt;
+		mask = dw_irq->rd_mask;
+	}
+
+	for_each_set_bit(pos, &mask, total) {
+		struct dw_edma_chan *chan = &dw->chan[pos + off];
+
+		val = dw_hdma_v0_core_status_int(chan);
+		if (dw_hdma_v0_core_check_abort_int(val))
+			dw_edma_abort_interrupt(&dw->chan[pos + off]);
+	}
+}
+
+static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+				     u32 control, u32 size, u64 sar, u64 dar)
+{
+	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+
+	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+
+		lli->control = control;
+		lli->transfer_size = size;
+		lli->sar.reg = sar;
+		lli->dar.reg = dar;
+	} else {
+		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+
+		writel(control, &lli->control);
+		writel(size, &lli->transfer_size);
+		writeq(sar, &lli->sar.reg);
+		writeq(dar, &lli->dar.reg);
+	}
+}
+
+static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+				     int i, u32 control, u64 pointer)
+{
+	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+
+	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+
+		llp->control = control;
+		llp->llp.reg = pointer;
+	} else {
+		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+
+		writel(control, &llp->control);
+		writeq(pointer, &llp->llp.reg);
+	}
+}
+
+static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_burst *child;
+	struct dw_edma_chan *chan = chunk->chan;
+	u32 control = 0, i = 0;
+	int j;
+
+	if (chunk->cb)
+		control = DW_HDMA_V0_CB;
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		if (!j) {
+			control |= DW_HDMA_V0_LIE;
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+				control |= DW_HDMA_V0_RIE;
+		}
+
+		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
+					 child->sar, child->dar);
+	}
+
+	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
+	if (!chunk->cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+}
+
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->dw;
+	u32 tmp;
+
+	dw_hdma_v0_core_write_chunk(chunk);
+
+	if (first) {
+		/* Enable engine */
+		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+		/* Interrupt enable&unmask - done, abort */
+		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) | HDMA_V0_STOP_INT_MASK |
+		      HDMA_V0_ABORT_INT_MASK | HDMA_V0_LOCAL_STOP_INT_EN |
+		      HDMA_V0_LOCAL_STOP_INT_EN;
+		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
+		/* Channel control */
+		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
+		/* Linked list */
+		/* llp is not aligned on 64bit -> keep 32bit accesses */
+		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+			  lower_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+			  upper_32_bits(chunk->ll_region.paddr));
+	}
+	/* Set consumer cycle */
+	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+	/* Doorbell */
+	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+}
+
+static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	/* MSI done addr - low, high */
+	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
+	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
+	/* MSI abort addr - low, high */
+	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
+	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
+	/* config MSI data */
+	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
+}
+
+/* HDMA debugfs callbacks */
+static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
+{
+}
+
+static const struct dw_edma_core_ops hdma_core = {
+	.off = dw_hdma_v0_core_off,
+	.ch_count = dw_hdma_v0_core_ch_count,
+	.ch_status = dw_hdma_v0_core_ch_status,
+	.clear_done_int = dw_hdma_v0_core_clear_done_int,
+	.clear_abort_int = dw_hdma_v0_core_clear_abort_int,
+	.done_handle = dw_hdma_v0_core_done_handle,
+	.abort_handle = dw_hdma_v0_core_abort_handle,
+	.start = dw_hdma_v0_core_start,
+	.ch_config = dw_hdma_v0_core_ch_config,
+	.debugfs_on = dw_hdma_v0_core_debugfs_on,
+};
+
+void dw_hdma_v0_core_register(struct dw_edma *dw)
+{
+	dw->core = &hdma_core;
+}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.h b/drivers/dma/dw-edma/dw-hdma-v0-core.h
new file mode 100644
index 000000000000..c373b4f0bd8a
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Cai Huoqing
+ * Synopsys DesignWare HDMA v0 core
+ *
+ * Author: Cai Huoqing <cai.huoqing@linux.dev>
+ */
+
+#ifndef _DW_HDMA_V0_CORE_H
+#define _DW_HDMA_V0_CORE_H
+
+#include <linux/dma/edma.h>
+
+/* HDMA core register */
+void dw_hdma_v0_core_register(struct dw_edma *dw);
+
+#endif /* _DW_HDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
new file mode 100644
index 000000000000..f6b2bd03060c
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Cai Huoqing
+ * Synopsys DesignWare HDMA v0 reg
+ *
+ * Author: Cai Huoqing <cai.huoqing@linux.dev>
+ */
+
+#ifndef _DW_HDMA_V0_REGS_H
+#define _DW_HDMA_V0_REGS_H
+
+#include <linux/dmaengine.h>
+
+#define HDMA_V0_MAX_NR_CH			8
+#define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
+#define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
+#define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
+#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
+#define HDMA_V0_ABORT_INT_MASK			BIT(2)
+#define HDMA_V0_STOP_INT_MASK			BIT(0)
+#define HDMA_V0_LINKLIST_EN			BIT(0)
+#define HDMA_V0_CONSUMER_CYCLE_STAT		BIT(1)
+#define HDMA_V0_CONSUMER_CYCLE_BIT		BIT(0)
+#define HDMA_V0_DOORBELL_START			BIT(0)
+#define HDMA_V0_CH_STATUS_MASK			GENMASK(1, 0)
+
+struct dw_hdma_v0_ch_regs {
+	u32 ch_en;				/* 0x0000 */
+	u32 doorbell;				/* 0x0004 */
+	u32 prefetch;				/* 0x0008 */
+	u32 handshake;				/* 0x000c */
+	union {
+		u64 reg;			/* 0x0010..0x0014 */
+		struct {
+			u32 lsb;		/* 0x0010 */
+			u32 msb;		/* 0x0014 */
+		};
+	} llp;
+	u32 cycle_sync;				/* 0x0018 */
+	u32 transfer_size;			/* 0x001c */
+	union {
+		u64 reg;			/* 0x0020..0x0024 */
+		struct {
+			u32 lsb;		/* 0x0020 */
+			u32 msb;		/* 0x0024 */
+		};
+	} sar;
+	union {
+		u64 reg;			/* 0x0028..0x002c */
+		struct {
+			u32 lsb;		/* 0x0028 */
+			u32 msb;		/* 0x002c */
+		};
+	} dar;
+
+	u32 watermark_en;			/* 0x0030 */
+	u32	control1;			/* 0x0034 */
+	u32	func_num;			/* 0x0038 */
+	u32	qos;				/* 0x003c */
+	u32	reserved;			/* 0x0040..0x007c */
+	u32 ch_stat;				/* 0x0080 */
+	u32 int_stat;				/* 0x0084 */
+	u32 int_setup;				/* 0x0088 */
+	u32 int_clear;				/* 0x008c */
+	union {
+		u64 reg;			/* 0x0090..0x0094 */
+		struct {
+			u32 lsb;		/* 0x0090 */
+			u32 msb;		/* 0x0094 */
+		};
+	} msi_stop;
+	union {
+		u64 reg;			/* 0x0098..0x009c */
+		struct {
+			u32 lsb;		/* 0x0098 */
+			u32 msb;		/* 0x009c */
+		};
+	} msi_watermark;
+	union {
+		u64 reg;			/* 0x00a0..0x00a4 */
+		struct {
+			u32 lsb;		/* 0x00a0 */
+			u32 msb;		/* 0x00a4 */
+		};
+	} msi_abort;
+	u32	msi_msgdata;			/* 0x00a8 */
+} __packed;
+
+struct dw_hdma_v0_ch {
+	struct dw_hdma_v0_ch_regs wr;		/* 0x0000 */
+	struct dw_hdma_v0_ch_regs rd;		/* 0x0100 */
+} __packed;
+
+struct dw_hdma_v0_regs {
+	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
+} __packed;
+
+struct dw_hdma_v0_lli {
+	u32 control;
+	u32 transfer_size;
+	union {
+		u64 reg;
+		struct {
+			u32 lsb;
+			u32 msb;
+		};
+	} sar;
+	union {
+		u64 reg;
+		struct {
+			u32 lsb;
+			u32 msb;
+		};
+	} dar;
+} __packed;
+
+struct dw_hdma_v0_llp {
+	u32 control;
+	u32 reserved;
+	union {
+		u64 reg;
+		struct {
+			u32 lsb;
+			u32 msb;
+		};
+	} llp;
+} __packed;
+
+#endif /* _DW_HDMA_V0_REGS_H */
-- 
2.34.1

