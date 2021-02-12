Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9820231A3C0
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhBLRjD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 12:39:03 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42794 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231292AbhBLRi5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Feb 2021 12:38:57 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2B98240C6A;
        Fri, 12 Feb 2021 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613151477; bh=A8Wse3dF6p4E6D3udyZg1XfTP61UAWOzGhe1pTgY0mA=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RquOx8R2IzXrLW6KwKjGjrdusUTvxmEiDkL+qVwaJNPBw1/CR9T94nhkAiwdRsT35
         XS76vUumpiLEC2DmdQVydc4qONZmZahsQuvznXq87EQW/tftiZUBV5BQ2dO2wXMVeV
         MHsI3SyWcyXVAQmlqrCNJg8gp3q6a5TIv6K7T/adhHBcIqiPgb53O8EjVLTyeb9v01
         k72ctiB4yrcKO5NAz9xhDN3CEyxBpOg2Hr/agWgTbICw3lf30cSxZ6h7FPWjvGaihD
         YxVzP5KNOsuclZ/rKqAtHbxvsFmbgjpusvs8Lc+1Z9XdSTpcrAO/p1aaIuE2S4BTRX
         5/Rq4PcTuZcFw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id DA4CFA005E;
        Fri, 12 Feb 2021 17:37:55 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 01/15] dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures
Date:   Fri, 12 Feb 2021 18:37:36 +0100
Message-Id: <c4a34dbf58d747ce138e9cb07676b089c383f39f.1613151392.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
References: <cover.1613151392.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add writeq() and readq() for 64 bits architures support.

Supporting these two functions will allow the write or the read of eDMA
64 bits registers at once instead of having two consecutive operations.

Also, this improvement will allow the PCI optimization transaction
messages, which will generate a 64 bits message instead of two messages
of 32 bits.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 254 +++++++++++++++++++++++--------
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  48 +++---
 drivers/dma/dw-edma/dw-edma-v0-regs.h    | 149 +++++++++++++-----
 3 files changed, 326 insertions(+), 125 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 692de47..7888eda 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -28,29 +28,69 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 	return dw->rg_region.vaddr;
 }
 
-#define SET(dw, name, value)				\
+#define SET_32(dw, name, value)				\
 	writel(value, &(__dw_regs(dw)->name))
 
-#define GET(dw, name)					\
+#define GET_32(dw, name)				\
 	readl(&(__dw_regs(dw)->name))
 
-#define SET_RW(dw, dir, name, value)			\
+#define SET_RW_32(dw, dir, name, value)			\
 	do {						\
 		if ((dir) == EDMA_DIR_WRITE)		\
-			SET(dw, wr_##name, value);	\
+			SET_32(dw, wr_##name, value);	\
 		else					\
-			SET(dw, rd_##name, value);	\
+			SET_32(dw, rd_##name, value);	\
 	} while (0)
 
-#define GET_RW(dw, dir, name)				\
+#define GET_RW_32(dw, dir, name)			\
 	((dir) == EDMA_DIR_WRITE			\
-	  ? GET(dw, wr_##name)				\
-	  : GET(dw, rd_##name))
+	  ? GET_32(dw, wr_##name)			\
+	  : GET_32(dw, rd_##name))
 
-#define SET_BOTH(dw, name, value)			\
+#define SET_BOTH_32(dw, name, value)			\
 	do {						\
-		SET(dw, wr_##name, value);		\
-		SET(dw, rd_##name, value);		\
+		SET_32(dw, wr_##name, value);		\
+		SET_32(dw, rd_##name, value);		\
+	} while (0)
+
+#ifdef CONFIG_64BIT
+
+#define SET_64(dw, name, value)				\
+	writeq(value, &(__dw_regs(dw)->name))
+
+#define GET_64(dw, name)				\
+	readq(&(__dw_regs(dw)->name))
+
+#define SET_RW_64(dw, dir, name, value)			\
+	do {						\
+		if ((dir) == EDMA_DIR_WRITE)		\
+			SET_64(dw, wr_##name, value);	\
+		else					\
+			SET_64(dw, rd_##name, value);	\
+	} while (0)
+
+#define GET_RW_64(dw, dir, name)			\
+	((dir) == EDMA_DIR_WRITE			\
+	  ? GET_64(dw, wr_##name)			\
+	  : GET_64(dw, rd_##name))
+
+#define SET_BOTH_64(dw, name, value)			\
+	do {						\
+		SET_64(dw, wr_##name, value);		\
+		SET_64(dw, rd_##name, value);		\
+	} while (0)
+
+#endif /* CONFIG_64BIT */
+
+#define SET_COMPAT(dw, name, value)			\
+	writel(value, &(__dw_regs(dw)->type.unroll.name))
+
+#define SET_RW_COMPAT(dw, dir, name, value)		\
+	do {						\
+		if ((dir) == EDMA_DIR_WRITE)		\
+			SET_COMPAT(dw, wr_##name, value); \
+		else					\
+			SET_COMPAT(dw, rd_##name, value); \
 	} while (0)
 
 static inline struct dw_edma_v0_ch_regs __iomem *
@@ -115,21 +155,86 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	return value;
 }
 
-#define SET_CH(dw, dir, ch, name, value) \
+#define SET_CH_32(dw, dir, ch, name, value) \
 	writel_ch(dw, dir, ch, value, &(__dw_ch_regs(dw, dir, ch)->name))
 
-#define GET_CH(dw, dir, ch, name) \
+#define GET_CH_32(dw, dir, ch, name) \
 	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
 
-#define SET_LL(ll, value) \
+#define SET_LL_32(ll, value) \
 	writel(value, ll)
 
+#ifdef CONFIG_64BIT
+
+static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+			     u64 value, void __iomem *addr)
+{
+	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
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
+		writeq(value, addr);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+	} else {
+		writeq(value, addr);
+	}
+}
+
+static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+			   const void __iomem *addr)
+{
+	u32 value;
+
+	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
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
+		value = readq(addr);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+	} else {
+		value = readq(addr);
+	}
+
+	return value;
+}
+
+#define SET_CH_64(dw, dir, ch, name, value) \
+	writeq_ch(dw, dir, ch, value, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define GET_CH_64(dw, dir, ch, name) \
+	readq_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
+
+#define SET_LL_64(ll, value) \
+	writeq(value, ll)
+
+#endif /* CONFIG_64BIT */
+
 /* eDMA management callbacks */
 void dw_edma_v0_core_off(struct dw_edma *dw)
 {
-	SET_BOTH(dw, int_mask, EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
-	SET_BOTH(dw, int_clear, EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
-	SET_BOTH(dw, engine_en, 0);
+	SET_BOTH_32(dw, int_mask,
+		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
+	SET_BOTH_32(dw, int_clear,
+		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
+	SET_BOTH_32(dw, engine_en, 0);
 }
 
 u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
@@ -137,9 +242,11 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 	u32 num_ch;
 
 	if (dir == EDMA_DIR_WRITE)
-		num_ch = FIELD_GET(EDMA_V0_WRITE_CH_COUNT_MASK, GET(dw, ctrl));
+		num_ch = FIELD_GET(EDMA_V0_WRITE_CH_COUNT_MASK,
+				   GET_32(dw, ctrl));
 	else
-		num_ch = FIELD_GET(EDMA_V0_READ_CH_COUNT_MASK, GET(dw, ctrl));
+		num_ch = FIELD_GET(EDMA_V0_READ_CH_COUNT_MASK,
+				   GET_32(dw, ctrl));
 
 	if (num_ch > EDMA_V0_MAX_NR_CH)
 		num_ch = EDMA_V0_MAX_NR_CH;
@@ -153,7 +260,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 	u32 tmp;
 
 	tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
-			GET_CH(dw, chan->dir, chan->id, ch_control1));
+			GET_CH_32(dw, chan->dir, chan->id, ch_control1));
 
 	if (tmp == 1)
 		return DMA_IN_PROGRESS;
@@ -167,26 +274,28 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->chip->dw;
 
-	SET_RW(dw, chan->dir, int_clear,
-	       FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
+	SET_RW_32(dw, chan->dir, int_clear,
+		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
 }
 
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->chip->dw;
 
-	SET_RW(dw, chan->dir, int_clear,
-	       FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
+	SET_RW_32(dw, chan->dir, int_clear,
+		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
 }
 
 u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
 {
-	return FIELD_GET(EDMA_V0_DONE_INT_MASK, GET_RW(dw, dir, int_status));
+	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
+			 GET_RW_32(dw, dir, int_status));
 }
 
 u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
 {
-	return FIELD_GET(EDMA_V0_ABORT_INT_MASK, GET_RW(dw, dir, int_status));
+	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
+			 GET_RW_32(dw, dir, int_status));
 }
 
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
@@ -209,15 +318,23 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
 
 		/* Channel control */
-		SET_LL(&lli[i].control, control);
+		SET_LL_32(&lli[i].control, control);
 		/* Transfer size */
-		SET_LL(&lli[i].transfer_size, child->sz);
-		/* SAR - low, high */
-		SET_LL(&lli[i].sar_low, lower_32_bits(child->sar));
-		SET_LL(&lli[i].sar_high, upper_32_bits(child->sar));
-		/* DAR - low, high */
-		SET_LL(&lli[i].dar_low, lower_32_bits(child->dar));
-		SET_LL(&lli[i].dar_high, upper_32_bits(child->dar));
+		SET_LL_32(&lli[i].transfer_size, child->sz);
+		/* SAR */
+		#ifdef CONFIG_64BIT
+			SET_LL_64(&lli[i].sar.reg, child->sar);
+		#else /* CONFIG_64BIT */
+			SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
+			SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
+		#endif /* CONFIG_64BIT */
+		/* DAR */
+		#ifdef CONFIG_64BIT
+			SET_LL_64(&lli[i].dar.reg, child->dar);
+		#else /* CONFIG_64BIT */
+			SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
+			SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
+		#endif /* CONFIG_64BIT */
 		i++;
 	}
 
@@ -227,10 +344,14 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		control |= DW_EDMA_V0_CB;
 
 	/* Channel control */
-	SET_LL(&llp->control, control);
-	/* Linked list  - low, high */
-	SET_LL(&llp->llp_low, lower_32_bits(chunk->ll_region.paddr));
-	SET_LL(&llp->llp_high, upper_32_bits(chunk->ll_region.paddr));
+	SET_LL_32(&llp->control, control);
+	/* Linked list */
+	#ifdef CONFIG_64BIT
+		SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
+	#else /* CONFIG_64BIT */
+		SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
+		SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));
+	#endif /* CONFIG_64BIT */
 }
 
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -243,28 +364,33 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 
 	if (first) {
 		/* Enable engine */
-		SET_RW(dw, chan->dir, engine_en, BIT(0));
+		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
 		/* Interrupt unmask - done, abort */
-		tmp = GET_RW(dw, chan->dir, int_mask);
+		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW(dw, chan->dir, int_mask, tmp);
+		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
-		tmp = GET_RW(dw, chan->dir, linked_list_err_en);
+		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW(dw, chan->dir, linked_list_err_en, tmp);
+		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
 		/* Channel control */
-		SET_CH(dw, chan->dir, chan->id, ch_control1,
-		       (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
-		/* Linked list - low, high */
-		SET_CH(dw, chan->dir, chan->id, llp_low,
-		       lower_32_bits(chunk->ll_region.paddr));
-		SET_CH(dw, chan->dir, chan->id, llp_high,
-		       upper_32_bits(chunk->ll_region.paddr));
+		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
+		/* Linked list */
+		#ifdef CONFIG_64BIT
+			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
+				  chunk->ll_region.paddr);
+		#else /* CONFIG_64BIT */
+			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+				  lower_32_bits(chunk->ll_region.paddr));
+			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+				  upper_32_bits(chunk->ll_region.paddr));
+		#endif /* CONFIG_64BIT */
 	}
 	/* Doorbell */
-	SET_RW(dw, chan->dir, doorbell,
-	       FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+	SET_RW_32(dw, chan->dir, doorbell,
+		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
 
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
@@ -273,31 +399,31 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 	u32 tmp = 0;
 
 	/* MSI done addr - low, high */
-	SET_RW(dw, chan->dir, done_imwr_low, chan->msi.address_lo);
-	SET_RW(dw, chan->dir, done_imwr_high, chan->msi.address_hi);
+	SET_RW_32(dw, chan->dir, done_imwr.lsb, chan->msi.address_lo);
+	SET_RW_32(dw, chan->dir, done_imwr.msb, chan->msi.address_hi);
 	/* MSI abort addr - low, high */
-	SET_RW(dw, chan->dir, abort_imwr_low, chan->msi.address_lo);
-	SET_RW(dw, chan->dir, abort_imwr_high, chan->msi.address_hi);
+	SET_RW_32(dw, chan->dir, abort_imwr.lsb, chan->msi.address_lo);
+	SET_RW_32(dw, chan->dir, abort_imwr.msb, chan->msi.address_hi);
 	/* MSI data - low, high */
 	switch (chan->id) {
 	case 0:
 	case 1:
-		tmp = GET_RW(dw, chan->dir, ch01_imwr_data);
+		tmp = GET_RW_32(dw, chan->dir, ch01_imwr_data);
 		break;
 
 	case 2:
 	case 3:
-		tmp = GET_RW(dw, chan->dir, ch23_imwr_data);
+		tmp = GET_RW_32(dw, chan->dir, ch23_imwr_data);
 		break;
 
 	case 4:
 	case 5:
-		tmp = GET_RW(dw, chan->dir, ch45_imwr_data);
+		tmp = GET_RW_32(dw, chan->dir, ch45_imwr_data);
 		break;
 
 	case 6:
 	case 7:
-		tmp = GET_RW(dw, chan->dir, ch67_imwr_data);
+		tmp = GET_RW_32(dw, chan->dir, ch67_imwr_data);
 		break;
 	}
 
@@ -316,22 +442,22 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 	switch (chan->id) {
 	case 0:
 	case 1:
-		SET_RW(dw, chan->dir, ch01_imwr_data, tmp);
+		SET_RW_32(dw, chan->dir, ch01_imwr_data, tmp);
 		break;
 
 	case 2:
 	case 3:
-		SET_RW(dw, chan->dir, ch23_imwr_data, tmp);
+		SET_RW_32(dw, chan->dir, ch23_imwr_data, tmp);
 		break;
 
 	case 4:
 	case 5:
-		SET_RW(dw, chan->dir, ch45_imwr_data, tmp);
+		SET_RW_32(dw, chan->dir, ch45_imwr_data, tmp);
 		break;
 
 	case 6:
 	case 7:
-		SET_RW(dw, chan->dir, ch67_imwr_data, tmp);
+		SET_RW_32(dw, chan->dir, ch67_imwr_data, tmp);
 		break;
 	}
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 6f62711..a5e2783 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -114,12 +114,12 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 		REGISTER(ch_control1),
 		REGISTER(ch_control2),
 		REGISTER(transfer_size),
-		REGISTER(sar_low),
-		REGISTER(sar_high),
-		REGISTER(dar_low),
-		REGISTER(dar_high),
-		REGISTER(llp_low),
-		REGISTER(llp_high),
+		REGISTER(sar.lsb),
+		REGISTER(sar.msb),
+		REGISTER(dar.lsb),
+		REGISTER(dar.msb),
+		REGISTER(llp.lsb),
+		REGISTER(llp.msb),
 	};
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
@@ -132,17 +132,17 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 		/* eDMA global registers */
 		WR_REGISTER(engine_en),
 		WR_REGISTER(doorbell),
-		WR_REGISTER(ch_arb_weight_low),
-		WR_REGISTER(ch_arb_weight_high),
+		WR_REGISTER(ch_arb_weight.lsb),
+		WR_REGISTER(ch_arb_weight.msb),
 		/* eDMA interrupts registers */
 		WR_REGISTER(int_status),
 		WR_REGISTER(int_mask),
 		WR_REGISTER(int_clear),
 		WR_REGISTER(err_status),
-		WR_REGISTER(done_imwr_low),
-		WR_REGISTER(done_imwr_high),
-		WR_REGISTER(abort_imwr_low),
-		WR_REGISTER(abort_imwr_high),
+		WR_REGISTER(done_imwr.lsb),
+		WR_REGISTER(done_imwr.msb),
+		WR_REGISTER(abort_imwr.lsb),
+		WR_REGISTER(abort_imwr.msb),
 		WR_REGISTER(ch01_imwr_data),
 		WR_REGISTER(ch23_imwr_data),
 		WR_REGISTER(ch45_imwr_data),
@@ -152,8 +152,8 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 	const struct debugfs_entries debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
 		WR_REGISTER_UNROLL(engine_chgroup),
-		WR_REGISTER_UNROLL(engine_hshake_cnt_low),
-		WR_REGISTER_UNROLL(engine_hshake_cnt_high),
+		WR_REGISTER_UNROLL(engine_hshake_cnt.lsb),
+		WR_REGISTER_UNROLL(engine_hshake_cnt.msb),
 		WR_REGISTER_UNROLL(ch0_pwr_en),
 		WR_REGISTER_UNROLL(ch1_pwr_en),
 		WR_REGISTER_UNROLL(ch2_pwr_en),
@@ -200,19 +200,19 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 		/* eDMA global registers */
 		RD_REGISTER(engine_en),
 		RD_REGISTER(doorbell),
-		RD_REGISTER(ch_arb_weight_low),
-		RD_REGISTER(ch_arb_weight_high),
+		RD_REGISTER(ch_arb_weight.lsb),
+		RD_REGISTER(ch_arb_weight.msb),
 		/* eDMA interrupts registers */
 		RD_REGISTER(int_status),
 		RD_REGISTER(int_mask),
 		RD_REGISTER(int_clear),
-		RD_REGISTER(err_status_low),
-		RD_REGISTER(err_status_high),
+		RD_REGISTER(err_status.lsb),
+		RD_REGISTER(err_status.msb),
 		RD_REGISTER(linked_list_err_en),
-		RD_REGISTER(done_imwr_low),
-		RD_REGISTER(done_imwr_high),
-		RD_REGISTER(abort_imwr_low),
-		RD_REGISTER(abort_imwr_high),
+		RD_REGISTER(done_imwr.lsb),
+		RD_REGISTER(done_imwr.msb),
+		RD_REGISTER(abort_imwr.lsb),
+		RD_REGISTER(abort_imwr.msb),
 		RD_REGISTER(ch01_imwr_data),
 		RD_REGISTER(ch23_imwr_data),
 		RD_REGISTER(ch45_imwr_data),
@@ -221,8 +221,8 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 	const struct debugfs_entries debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
 		RD_REGISTER_UNROLL(engine_chgroup),
-		RD_REGISTER_UNROLL(engine_hshake_cnt_low),
-		RD_REGISTER_UNROLL(engine_hshake_cnt_high),
+		RD_REGISTER_UNROLL(engine_hshake_cnt.lsb),
+		RD_REGISTER_UNROLL(engine_hshake_cnt.msb),
 		RD_REGISTER_UNROLL(ch0_pwr_en),
 		RD_REGISTER_UNROLL(ch1_pwr_en),
 		RD_REGISTER_UNROLL(ch2_pwr_en),
diff --git a/drivers/dma/dw-edma/dw-edma-v0-regs.h b/drivers/dma/dw-edma/dw-edma-v0-regs.h
index dfd70e2..d07151d 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-regs.h
@@ -28,30 +28,55 @@ struct dw_edma_v0_ch_regs {
 	u32 ch_control1;				/* 0x000 */
 	u32 ch_control2;				/* 0x004 */
 	u32 transfer_size;				/* 0x008 */
-	u32 sar_low;					/* 0x00c */
-	u32 sar_high;					/* 0x010 */
-	u32 dar_low;					/* 0x014 */
-	u32 dar_high;					/* 0x018 */
-	u32 llp_low;					/* 0x01c */
-	u32 llp_high;					/* 0x020 */
-};
+	union {
+		u64 reg;				/* 0x00c..0x010 */
+		struct {
+			u32 lsb;			/* 0x00c */
+			u32 msb;			/* 0x010 */
+		};
+	} sar;
+	union {
+		u64 reg;				/* 0x014..0x018 */
+		struct {
+			u32 lsb;			/* 0x014 */
+			u32 msb;			/* 0x018 */
+		};
+	} dar;
+	union {
+		u64 reg;				/* 0x01c..0x020 */
+		struct {
+			u32 lsb;			/* 0x01c */
+			u32 msb;			/* 0x020 */
+		};
+	} llp;
+} __packed;
 
 struct dw_edma_v0_ch {
 	struct dw_edma_v0_ch_regs wr;			/* 0x200 */
 	u32 padding_1[55];				/* [0x224..0x2fc] */
 	struct dw_edma_v0_ch_regs rd;			/* 0x300 */
 	u32 padding_2[55];				/* [0x324..0x3fc] */
-};
+} __packed;
 
 struct dw_edma_v0_unroll {
 	u32 padding_1;					/* 0x0f8 */
 	u32 wr_engine_chgroup;				/* 0x100 */
 	u32 rd_engine_chgroup;				/* 0x104 */
-	u32 wr_engine_hshake_cnt_low;			/* 0x108 */
-	u32 wr_engine_hshake_cnt_high;			/* 0x10c */
+	union {
+		u64 reg;				/* 0x108..0x10c */
+		struct {
+			u32 lsb;			/* 0x108 */
+			u32 msb;			/* 0x10c */
+		};
+	} wr_engine_hshake_cnt;
 	u32 padding_2[2];				/* [0x110..0x114] */
-	u32 rd_engine_hshake_cnt_low;			/* 0x118 */
-	u32 rd_engine_hshake_cnt_high;			/* 0x11c */
+	union {
+		u64 reg;				/* 0x120..0x124 */
+		struct {
+			u32 lsb;			/* 0x120 */
+			u32 msb;			/* 0x124 */
+		};
+	} rd_engine_hshake_cnt;
 	u32 padding_3[2];				/* [0x120..0x124] */
 	u32 wr_ch0_pwr_en;				/* 0x128 */
 	u32 wr_ch1_pwr_en;				/* 0x12c */
@@ -72,12 +97,12 @@ struct dw_edma_v0_unroll {
 	u32 rd_ch7_pwr_en;				/* 0x184 */
 	u32 padding_5[30];				/* [0x188..0x1fc] */
 	struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	/* [0x200..0x1120] */
-};
+} __packed;
 
 struct dw_edma_v0_legacy {
 	u32 viewport_sel;				/* 0x0f8 */
 	struct dw_edma_v0_ch_regs ch;			/* [0x100..0x120] */
-};
+} __packed;
 
 struct dw_edma_v0_regs {
 	/* eDMA global registers */
@@ -87,14 +112,24 @@ struct dw_edma_v0_regs {
 	u32 wr_engine_en;				/* 0x00c */
 	u32 wr_doorbell;				/* 0x010 */
 	u32 padding_2;					/* 0x014 */
-	u32 wr_ch_arb_weight_low;			/* 0x018 */
-	u32 wr_ch_arb_weight_high;			/* 0x01c */
+	union {
+		u64 reg;				/* 0x018..0x01c */
+		struct {
+			u32 lsb;			/* 0x018 */
+			u32 msb;			/* 0x01c */
+		};
+	} wr_ch_arb_weight;
 	u32 padding_3[3];				/* [0x020..0x028] */
 	u32 rd_engine_en;				/* 0x02c */
 	u32 rd_doorbell;				/* 0x030 */
 	u32 padding_4;					/* 0x034 */
-	u32 rd_ch_arb_weight_low;			/* 0x038 */
-	u32 rd_ch_arb_weight_high;			/* 0x03c */
+	union {
+		u64 reg;				/* 0x038..0x03c */
+		struct {
+			u32 lsb;			/* 0x038 */
+			u32 msb;			/* 0x03c */
+		};
+	} rd_ch_arb_weight;
 	u32 padding_5[3];				/* [0x040..0x048] */
 	/* eDMA interrupts registers */
 	u32 wr_int_status;				/* 0x04c */
@@ -102,10 +137,20 @@ struct dw_edma_v0_regs {
 	u32 wr_int_mask;				/* 0x054 */
 	u32 wr_int_clear;				/* 0x058 */
 	u32 wr_err_status;				/* 0x05c */
-	u32 wr_done_imwr_low;				/* 0x060 */
-	u32 wr_done_imwr_high;				/* 0x064 */
-	u32 wr_abort_imwr_low;				/* 0x068 */
-	u32 wr_abort_imwr_high;				/* 0x06c */
+	union {
+		u64 reg;				/* 0x060..0x064 */
+		struct {
+			u32 lsb;			/* 0x060 */
+			u32 msb;			/* 0x064 */
+		};
+	} wr_done_imwr;
+	union {
+		u64 reg;				/* 0x068..0x06c */
+		struct {
+			u32 lsb;			/* 0x068 */
+			u32 msb;			/* 0x06c */
+		};
+	} wr_abort_imwr;
 	u32 wr_ch01_imwr_data;				/* 0x070 */
 	u32 wr_ch23_imwr_data;				/* 0x074 */
 	u32 wr_ch45_imwr_data;				/* 0x078 */
@@ -118,15 +163,30 @@ struct dw_edma_v0_regs {
 	u32 rd_int_mask;				/* 0x0a8 */
 	u32 rd_int_clear;				/* 0x0ac */
 	u32 padding_10;					/* 0x0b0 */
-	u32 rd_err_status_low;				/* 0x0b4 */
-	u32 rd_err_status_high;				/* 0x0b8 */
+	union {
+		u64 reg;				/* 0x0b4..0x0b8 */
+		struct {
+			u32 lsb;			/* 0x0b4 */
+			u32 msb;			/* 0x0b8 */
+		};
+	} rd_err_status;
 	u32 padding_11[2];				/* [0x0bc..0x0c0] */
 	u32 rd_linked_list_err_en;			/* 0x0c4 */
 	u32 padding_12;					/* 0x0c8 */
-	u32 rd_done_imwr_low;				/* 0x0cc */
-	u32 rd_done_imwr_high;				/* 0x0d0 */
-	u32 rd_abort_imwr_low;				/* 0x0d4 */
-	u32 rd_abort_imwr_high;				/* 0x0d8 */
+	union {
+		u64 reg;				/* 0x0cc..0x0d0 */
+		struct {
+			u32 lsb;			/* 0x0cc */
+			u32 msb;			/* 0x0d0 */
+		};
+	} rd_done_imwr;
+	union {
+		u64 reg;				/* 0x0d4..0x0d8 */
+		struct {
+			u32 lsb;			/* 0x0d4 */
+			u32 msb;			/* 0x0d8 */
+		};
+	} rd_abort_imwr;
 	u32 rd_ch01_imwr_data;				/* 0x0dc */
 	u32 rd_ch23_imwr_data;				/* 0x0e0 */
 	u32 rd_ch45_imwr_data;				/* 0x0e4 */
@@ -137,22 +197,37 @@ struct dw_edma_v0_regs {
 		struct dw_edma_v0_legacy legacy;	/* [0x0f8..0x120] */
 		struct dw_edma_v0_unroll unroll;	/* [0x0f8..0x1120] */
 	} type;
-};
+} __packed;
 
 struct dw_edma_v0_lli {
 	u32 control;
 	u32 transfer_size;
-	u32 sar_low;
-	u32 sar_high;
-	u32 dar_low;
-	u32 dar_high;
-};
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
 
 struct dw_edma_v0_llp {
 	u32 control;
 	u32 reserved;
-	u32 llp_low;
-	u32 llp_high;
-};
+	union {
+		u64 reg;
+		struct {
+			u32 lsb;
+			u32 msb;
+		};
+	} llp;
+} __packed;
 
 #endif /* _DW_EDMA_V0_REGS_H */
-- 
2.7.4

