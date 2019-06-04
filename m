Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04D6348AC
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfFDN3f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 09:29:35 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:53168 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727515AbfFDN3c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jun 2019 09:29:32 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 847A8C1F3D;
        Tue,  4 Jun 2019 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559654982; bh=+psuigVn6pLF3tBaAMTb3uMBXCvoCDrS4qE5P0FwKKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NbLvxoxe6hesyhZBizjlRqzm7FV942oawoL8ijIwrhdWoIc7TKkIA0n/k0p7nUjUb
         1ZjkfXHSxLR+XcrflGwV9BRcGfn5Y3/Zq/3/B8BmDTbsiS58Kpfaa8iCUp8BH9xdMa
         0vS5hnBs1vlfdb4pUacVwcmB5LZjN/1HwEYYm0lchctx53O2JeOqgNKQlYOP361IDf
         2icGCn9Qro7Q2xOSK96hnhVxkn3KsuolqckRVlulVVOvOJZvhGiibOGmCflFvwfGPi
         7/Oow4E7nvE9oECJuKSsUJEzKduaB3iQtitqUoSfeWXYYYV4JHeEekJjgNM+wZqNxp
         ps0i+dgj/HRtw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4A69FA0232;
        Tue,  4 Jun 2019 13:29:29 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 0E27C3FACD;
        Tue,  4 Jun 2019 15:29:29 +0200 (CEST)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 2/6] dmaengine: Add Synopsys eDMA IP version 0 support
Date:   Tue,  4 Jun 2019 15:29:23 +0200
Message-Id: <ee9a58c18ad036f77559ec020487b1774576f46a.1559654565.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for the eDMA IP version 0 driver for both register maps (legacy
and unroll).

The legacy register mapping was the initial implementation, which consisted
in having all registers belonging to channels multiplexed, which could be
change anytime (which could led a race-condition) by view port register
(access to only one channel available each time).

This register mapping is not very effective and efficient in a multithread
environment, which has led to the development of unroll registers mapping,
which consists of having all channels registers accessible any time by
spreading all channels registers by an offset between them.

This version supports a maximum of 16 independent channels (8 write +
8 read), which can run simultaneously.

Implements a scatter-gather transfer through a linked list, where the size
of linked list depends on the allocated memory divided equally among all
channels.

Each linked list descriptor can transfer from 1 byte to 4 Gbytes and is
alignmented to DWORD.

Both SAR (Source Address Register) and DAR (Destination Address Register)
are alignmented to byte.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Joao Pinto <jpinto@synopsys.com>
---
Changes:
v1 -> v2:
 - Rebased to v5.2-rc1

 drivers/dma/dw-edma/Makefile          |   3 +-
 drivers/dma/dw-edma/dw-edma-core.c    |   1 +
 drivers/dma/dw-edma/dw-edma-v0-core.c | 352 ++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.h |  28 +++
 drivers/dma/dw-edma/dw-edma-v0-regs.h | 158 +++++++++++++++
 5 files changed, 541 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.c
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-core.h
 create mode 100644 drivers/dma/dw-edma/dw-edma-v0-regs.h

diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
index 3224010..01c7c63 100644
--- a/drivers/dma/dw-edma/Makefile
+++ b/drivers/dma/dw-edma/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
-dw-edma-objs			:= dw-edma-core.o
+dw-edma-objs			:= dw-edma-core.o \
+					dw-edma-v0-core.o
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c9d032f..60d6a46 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 
 #include "dw-edma-core.h"
+#include "dw-edma-v0-core.h"
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
new file mode 100644
index 0000000..a38c473
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA v0 core
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#include <linux/bitfield.h>
+
+#include "dw-edma-core.h"
+#include "dw-edma-v0-core.h"
+#include "dw-edma-v0-regs.h"
+#include "dw-edma-v0-debugfs.h"
+
+enum dw_edma_control {
+	DW_EDMA_V0_CB					= BIT(0),
+	DW_EDMA_V0_TCB					= BIT(1),
+	DW_EDMA_V0_LLP					= BIT(2),
+	DW_EDMA_V0_LIE					= BIT(3),
+	DW_EDMA_V0_RIE					= BIT(4),
+	DW_EDMA_V0_CCS					= BIT(8),
+	DW_EDMA_V0_LLE					= BIT(9),
+};
+
+static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
+{
+	return (struct dw_edma_v0_regs __iomem *)dw->rg_region.vaddr;
+}
+
+#define SET(dw, name, value)				\
+	writel(value, &(__dw_regs(dw)->name))
+
+#define GET(dw, name)					\
+	readl(&(__dw_regs(dw)->name))
+
+#define SET_RW(dw, dir, name, value)			\
+	do {						\
+		if ((dir) == EDMA_DIR_WRITE)		\
+			SET(dw, wr_##name, value);	\
+		else					\
+			SET(dw, rd_##name, value);	\
+	} while (0)
+
+#define GET_RW(dw, dir, name)				\
+	((dir) == EDMA_DIR_WRITE			\
+	  ? GET(dw, wr_##name)				\
+	  : GET(dw, rd_##name))
+
+#define SET_BOTH(dw, name, value)			\
+	do {						\
+		SET(dw, wr_##name, value);		\
+		SET(dw, rd_##name, value);		\
+	} while (0)
+
+static inline struct dw_edma_v0_ch_regs __iomem *
+__dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
+{
+	if (dw->mode == EDMA_MODE_LEGACY)
+		return &(__dw_regs(dw)->type.legacy.ch);
+
+	if (dir == EDMA_DIR_WRITE)
+		return &__dw_regs(dw)->type.unroll.ch[ch].wr;
+
+	return &__dw_regs(dw)->type.unroll.ch[ch].rd;
+}
+
+static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+			     u32 value, void __iomem *addr)
+{
+	if (dw->mode == EDMA_MODE_LEGACY) {
+		u32 viewport_sel;
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
+		viewport_sel = FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
+		if (dir == EDMA_DIR_READ)
+			viewport_sel |= BIT(31);
+
+		writel(viewport_sel,
+		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		writel(value, addr);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+	} else {
+		writel(value, addr);
+	}
+}
+
+static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+			   const void __iomem *addr)
+{
+	u32 value;
+
+	if (dw->mode == EDMA_MODE_LEGACY) {
+		u32 viewport_sel;
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
+		viewport_sel = FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
+		if (dir == EDMA_DIR_READ)
+			viewport_sel |= BIT(31);
+
+		writel(viewport_sel,
+		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		value = readl(addr);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+	} else {
+		value = readl(addr);
+	}
+
+	return value;
+}
+
+#define SET_CH(dw, dir, ch, name, value) \
+	writel_ch(dw, dir, ch, value, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define GET_CH(dw, dir, ch, name) \
+	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define SET_LL(ll, value) \
+	writel(value, ll)
+
+/* eDMA management callbacks */
+void dw_edma_v0_core_off(struct dw_edma *dw)
+{
+	SET_BOTH(dw, int_mask, EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
+	SET_BOTH(dw, int_clear, EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
+	SET_BOTH(dw, engine_en, 0);
+}
+
+u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	u32 num_ch;
+
+	if (dir == EDMA_DIR_WRITE)
+		num_ch = FIELD_GET(EDMA_V0_WRITE_CH_COUNT_MASK, GET(dw, ctrl));
+	else
+		num_ch = FIELD_GET(EDMA_V0_READ_CH_COUNT_MASK, GET(dw, ctrl));
+
+	if (num_ch > EDMA_V0_MAX_NR_CH)
+		num_ch = EDMA_V0_MAX_NR_CH;
+
+	return (u16)num_ch;
+}
+
+enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+	u32 tmp;
+
+	tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
+			GET_CH(dw, chan->dir, chan->id, ch_control1));
+
+	if (tmp == 1)
+		return DMA_IN_PROGRESS;
+	else if (tmp == 3)
+		return DMA_COMPLETE;
+	else
+		return DMA_ERROR;
+}
+
+void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+
+	SET_RW(dw, chan->dir, int_clear,
+	       FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
+}
+
+void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+
+	SET_RW(dw, chan->dir, int_clear,
+	       FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
+}
+
+u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	return FIELD_GET(EDMA_V0_DONE_INT_MASK, GET_RW(dw, dir, int_status));
+}
+
+u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	return FIELD_GET(EDMA_V0_ABORT_INT_MASK, GET_RW(dw, dir, int_status));
+}
+
+static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_burst *child;
+	struct dw_edma_v0_lli *lli;
+	struct dw_edma_v0_llp *llp;
+	u32 control = 0, i = 0;
+	u64 sar, dar, addr;
+	int j;
+
+	lli = (struct dw_edma_v0_lli *)chunk->ll_region.vaddr;
+
+	if (chunk->cb)
+		control = DW_EDMA_V0_CB;
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		if (!j)
+			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
+
+		/* Channel control */
+		SET_LL(&lli[i].control, control);
+		/* Transfer size */
+		SET_LL(&lli[i].transfer_size, child->sz);
+		/* SAR - low, high */
+		sar = cpu_to_le64(child->sar);
+		SET_LL(&lli[i].sar_low, lower_32_bits(sar));
+		SET_LL(&lli[i].sar_high, upper_32_bits(sar));
+		/* DAR - low, high */
+		dar = cpu_to_le64(child->dar);
+		SET_LL(&lli[i].dar_low, lower_32_bits(dar));
+		SET_LL(&lli[i].dar_high, upper_32_bits(dar));
+		i++;
+	}
+
+	llp = (struct dw_edma_v0_llp *)&lli[i];
+	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
+	if (!chunk->cb)
+		control |= DW_EDMA_V0_CB;
+
+	/* Channel control */
+	SET_LL(&llp->control, control);
+	/* Linked list  - low, high */
+	addr = cpu_to_le64(chunk->ll_region.paddr);
+	SET_LL(&llp->llp_low, lower_32_bits(addr));
+	SET_LL(&llp->llp_high, upper_32_bits(addr));
+}
+
+void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->chip->dw;
+	u32 tmp;
+	u64 llp;
+
+	dw_edma_v0_core_write_chunk(chunk);
+
+	if (first) {
+		/* Enable engine */
+		SET_RW(dw, chan->dir, engine_en, BIT(0));
+		/* Interrupt unmask - done, abort */
+		tmp = GET_RW(dw, chan->dir, int_mask);
+		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		SET_RW(dw, chan->dir, int_mask, tmp);
+		/* Linked list error */
+		tmp = GET_RW(dw, chan->dir, linked_list_err_en);
+		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
+		SET_RW(dw, chan->dir, linked_list_err_en, tmp);
+		/* Channel control */
+		SET_CH(dw, chan->dir, chan->id, ch_control1,
+		       (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+		/* Linked list - low, high */
+		llp = cpu_to_le64(chunk->ll_region.paddr);
+		SET_CH(dw, chan->dir, chan->id, llp_low, lower_32_bits(llp));
+		SET_CH(dw, chan->dir, chan->id, llp_high, upper_32_bits(llp));
+	}
+	/* Doorbell */
+	SET_RW(dw, chan->dir, doorbell,
+	       FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+}
+
+int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->chip->dw;
+	u32 tmp = 0;
+
+	/* MSI done addr - low, high */
+	SET_RW(dw, chan->dir, done_imwr_low, chan->msi.address_lo);
+	SET_RW(dw, chan->dir, done_imwr_high, chan->msi.address_hi);
+	/* MSI abort addr - low, high */
+	SET_RW(dw, chan->dir, abort_imwr_low, chan->msi.address_lo);
+	SET_RW(dw, chan->dir, abort_imwr_high, chan->msi.address_hi);
+	/* MSI data - low, high */
+	switch (chan->id) {
+	case 0:
+	case 1:
+		tmp = GET_RW(dw, chan->dir, ch01_imwr_data);
+		break;
+
+	case 2:
+	case 3:
+		tmp = GET_RW(dw, chan->dir, ch23_imwr_data);
+		break;
+
+	case 4:
+	case 5:
+		tmp = GET_RW(dw, chan->dir, ch45_imwr_data);
+		break;
+
+	case 6:
+	case 7:
+		tmp = GET_RW(dw, chan->dir, ch67_imwr_data);
+		break;
+	}
+
+	if (chan->id & BIT(0)) {
+		/* Channel odd {1, 3, 5, 7} */
+		tmp &= EDMA_V0_CH_EVEN_MSI_DATA_MASK;
+		tmp |= FIELD_PREP(EDMA_V0_CH_ODD_MSI_DATA_MASK,
+				  chan->msi.data);
+	} else {
+		/* Channel even {0, 2, 4, 6} */
+		tmp &= EDMA_V0_CH_ODD_MSI_DATA_MASK;
+		tmp |= FIELD_PREP(EDMA_V0_CH_EVEN_MSI_DATA_MASK,
+				  chan->msi.data);
+	}
+
+	switch (chan->id) {
+	case 0:
+	case 1:
+		SET_RW(dw, chan->dir, ch01_imwr_data, tmp);
+		break;
+
+	case 2:
+	case 3:
+		SET_RW(dw, chan->dir, ch23_imwr_data, tmp);
+		break;
+
+	case 4:
+	case 5:
+		SET_RW(dw, chan->dir, ch45_imwr_data, tmp);
+		break;
+
+	case 6:
+	case 7:
+		SET_RW(dw, chan->dir, ch67_imwr_data, tmp);
+		break;
+	}
+
+	return 0;
+}
+
+/* eDMA debugfs callbacks */
+void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
+{
+}
+
+void dw_edma_v0_core_debugfs_off(void)
+{
+}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
new file mode 100644
index 0000000..abae152
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA v0 core
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#ifndef _DW_EDMA_V0_CORE_H
+#define _DW_EDMA_V0_CORE_H
+
+#include <linux/dma/edma.h>
+
+/* eDMA management callbacks */
+void dw_edma_v0_core_off(struct dw_edma *chan);
+u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
+enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
+void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
+void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
+u32 dw_edma_v0_core_status_done_int(struct dw_edma *chan, enum dw_edma_dir dir);
+u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir);
+void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
+int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
+/* eDMA debug fs callbacks */
+void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
+void dw_edma_v0_core_debugfs_off(void);
+
+#endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-regs.h b/drivers/dma/dw-edma/dw-edma-v0-regs.h
new file mode 100644
index 0000000..cd64768
--- /dev/null
+++ b/drivers/dma/dw-edma/dw-edma-v0-regs.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare eDMA v0 core
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#ifndef _DW_EDMA_V0_REGS_H
+#define _DW_EDMA_V0_REGS_H
+
+#include <linux/dmaengine.h>
+
+#define EDMA_V0_MAX_NR_CH				8
+#define EDMA_V0_VIEWPORT_MASK				GENMASK(2, 0)
+#define EDMA_V0_DONE_INT_MASK				GENMASK(7, 0)
+#define EDMA_V0_ABORT_INT_MASK				GENMASK(23, 16)
+#define EDMA_V0_WRITE_CH_COUNT_MASK			GENMASK(3, 0)
+#define EDMA_V0_READ_CH_COUNT_MASK			GENMASK(19, 16)
+#define EDMA_V0_CH_STATUS_MASK				GENMASK(6, 5)
+#define EDMA_V0_DOORBELL_CH_MASK			GENMASK(2, 0)
+#define EDMA_V0_LINKED_LIST_ERR_MASK			GENMASK(7, 0)
+
+#define EDMA_V0_CH_ODD_MSI_DATA_MASK			GENMASK(31, 16)
+#define EDMA_V0_CH_EVEN_MSI_DATA_MASK			GENMASK(15, 0)
+
+struct dw_edma_v0_ch_regs {
+	u32 ch_control1;				/* 0x000 */
+	u32 ch_control2;				/* 0x004 */
+	u32 transfer_size;				/* 0x008 */
+	u32 sar_low;					/* 0x00c */
+	u32 sar_high;					/* 0x010 */
+	u32 dar_low;					/* 0x014 */
+	u32 dar_high;					/* 0x018 */
+	u32 llp_low;					/* 0x01c */
+	u32 llp_high;					/* 0x020 */
+};
+
+struct dw_edma_v0_ch {
+	struct dw_edma_v0_ch_regs wr;			/* 0x200 */
+	u32 padding_1[55];				/* [0x224..0x2fc] */
+	struct dw_edma_v0_ch_regs rd;			/* 0x300 */
+	u32 padding_2[55];				/* [0x224..0x2fc] */
+};
+
+struct dw_edma_v0_unroll {
+	u32 padding_1;					/* 0x0f8 */
+	u32 wr_engine_chgroup;				/* 0x100 */
+	u32 rd_engine_chgroup;				/* 0x104 */
+	u32 wr_engine_hshake_cnt_low;			/* 0x108 */
+	u32 wr_engine_hshake_cnt_high;			/* 0x10c */
+	u32 padding_2[2];				/* [0x110..0x114] */
+	u32 rd_engine_hshake_cnt_low;			/* 0x118 */
+	u32 rd_engine_hshake_cnt_high;			/* 0x11c */
+	u32 padding_3[2];				/* [0x120..0x124] */
+	u32 wr_ch0_pwr_en;				/* 0x128 */
+	u32 wr_ch1_pwr_en;				/* 0x12c */
+	u32 wr_ch2_pwr_en;				/* 0x130 */
+	u32 wr_ch3_pwr_en;				/* 0x134 */
+	u32 wr_ch4_pwr_en;				/* 0x138 */
+	u32 wr_ch5_pwr_en;				/* 0x13c */
+	u32 wr_ch6_pwr_en;				/* 0x140 */
+	u32 wr_ch7_pwr_en;				/* 0x144 */
+	u32 padding_4[8];				/* [0x148..0x164] */
+	u32 rd_ch0_pwr_en;				/* 0x168 */
+	u32 rd_ch1_pwr_en;				/* 0x16c */
+	u32 rd_ch2_pwr_en;				/* 0x170 */
+	u32 rd_ch3_pwr_en;				/* 0x174 */
+	u32 rd_ch4_pwr_en;				/* 0x178 */
+	u32 rd_ch5_pwr_en;				/* 0x18c */
+	u32 rd_ch6_pwr_en;				/* 0x180 */
+	u32 rd_ch7_pwr_en;				/* 0x184 */
+	u32 padding_5[30];				/* [0x188..0x1fc] */
+	struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	/* [0x200..0x1120] */
+};
+
+struct dw_edma_v0_legacy {
+	u32 viewport_sel;				/* 0x0f8 */
+	struct dw_edma_v0_ch_regs ch;			/* [0x100..0x120] */
+};
+
+struct dw_edma_v0_regs {
+	/* eDMA global registers */
+	u32 ctrl_data_arb_prior;			/* 0x000 */
+	u32 padding_1;					/* 0x004 */
+	u32 ctrl;					/* 0x008 */
+	u32 wr_engine_en;				/* 0x00c */
+	u32 wr_doorbell;				/* 0x010 */
+	u32 padding_2;					/* 0x014 */
+	u32 wr_ch_arb_weight_low;			/* 0x018 */
+	u32 wr_ch_arb_weight_high;			/* 0x01c */
+	u32 padding_3[3];				/* [0x020..0x028] */
+	u32 rd_engine_en;				/* 0x02c */
+	u32 rd_doorbell;				/* 0x030 */
+	u32 padding_4;					/* 0x034 */
+	u32 rd_ch_arb_weight_low;			/* 0x038 */
+	u32 rd_ch_arb_weight_high;			/* 0x03c */
+	u32 padding_5[3];				/* [0x040..0x048] */
+	/* eDMA interrupts registers */
+	u32 wr_int_status;				/* 0x04c */
+	u32 padding_6;					/* 0x050 */
+	u32 wr_int_mask;				/* 0x054 */
+	u32 wr_int_clear;				/* 0x058 */
+	u32 wr_err_status;				/* 0x05c */
+	u32 wr_done_imwr_low;				/* 0x060 */
+	u32 wr_done_imwr_high;				/* 0x064 */
+	u32 wr_abort_imwr_low;				/* 0x068 */
+	u32 wr_abort_imwr_high;				/* 0x06c */
+	u32 wr_ch01_imwr_data;				/* 0x070 */
+	u32 wr_ch23_imwr_data;				/* 0x074 */
+	u32 wr_ch45_imwr_data;				/* 0x078 */
+	u32 wr_ch67_imwr_data;				/* 0x07c */
+	u32 padding_7[4];				/* [0x080..0x08c] */
+	u32 wr_linked_list_err_en;			/* 0x090 */
+	u32 padding_8[3];				/* [0x094..0x09c] */
+	u32 rd_int_status;				/* 0x0a0 */
+	u32 padding_9;					/* 0x0a4 */
+	u32 rd_int_mask;				/* 0x0a8 */
+	u32 rd_int_clear;				/* 0x0ac */
+	u32 padding_10;					/* 0x0b0 */
+	u32 rd_err_status_low;				/* 0x0b4 */
+	u32 rd_err_status_high;				/* 0x0b8 */
+	u32 padding_11[2];				/* [0x0bc..0x0c0] */
+	u32 rd_linked_list_err_en;			/* 0x0c4 */
+	u32 padding_12;					/* 0x0c8 */
+	u32 rd_done_imwr_low;				/* 0x0cc */
+	u32 rd_done_imwr_high;				/* 0x0d0 */
+	u32 rd_abort_imwr_low;				/* 0x0d4 */
+	u32 rd_abort_imwr_high;				/* 0x0d8 */
+	u32 rd_ch01_imwr_data;				/* 0x0dc */
+	u32 rd_ch23_imwr_data;				/* 0x0e0 */
+	u32 rd_ch45_imwr_data;				/* 0x0e4 */
+	u32 rd_ch67_imwr_data;				/* 0x0e8 */
+	u32 padding_13[4];				/* [0x0ec..0x0f8] */
+	/* eDMA channel context grouping */
+	union dw_edma_v0_type {
+		struct dw_edma_v0_legacy legacy;	/* [0x0f8..0x120] */
+		struct dw_edma_v0_unroll unroll;	/* [0x0f8..0x1120] */
+	} type;
+};
+
+struct dw_edma_v0_lli {
+	u32 control;
+	u32 transfer_size;
+	u32 sar_low;
+	u32 sar_high;
+	u32 dar_low;
+	u32 dar_high;
+};
+
+struct dw_edma_v0_llp {
+	u32 control;
+	u32 reserved;
+	u32 llp_low;
+	u32 llp_high;
+};
+
+#endif /* _DW_EDMA_V0_REGS_H */
-- 
2.7.4

