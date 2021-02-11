Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19D3186F3
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 10:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBKJUB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 04:20:01 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34162 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhBKJOM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 04:14:12 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 202F3400E6;
        Thu, 11 Feb 2021 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034778; bh=gCI3nNoPy8dCurab6Uc+GVpEmLeCzjb3I1ubHtDkaBI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ljjri5wr3r1yiwkiJ30AXutkRnTSy8Fux1QFUQSKRDCG5KRHrgXpYq92/3bxAr1wU
         jzy2PFQd6C5Skt9IbN4GC5fvdV9258YBdH9mtp2E5kfr5ALUW9sHAjLzjXFT9MuiJc
         eoPwje1rblc54O0rINA1JeVHV25RXryNQBV82Tft4F231nmV/h7bd8/DGtyPxj7dGN
         pZA+R5F7pmR2PgFuXPbVZH25Dv56Cge3VyhceRRfHYgUfKzKgIlf0WwvqVewYg1uUt
         52AWVsfUdnYV6DgjpYdqKJQrHxl4J8Y/zvmt/OwQuOJmh3I0ZoBvDMr0MDTOpjMu3x
         DSfUrLxRy/ajg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id E6D06A005D;
        Thu, 11 Feb 2021 09:12:56 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 03/15] dmaengine: dw-edma: Add support for the HDMA feature
Date:   Thu, 11 Feb 2021 10:12:36 +0100
Message-Id: <7d871631910ce66cb310b16c98632f41114576a3.1613034728.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for the HDMA feature.

This new feature enables the current eDMA IP to use a deeper prefetch
of the linked list, which reduces the algorithm execution latency
observed when loading the elements of the list, causing more stable
and higher data transfer.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.h       | 10 ++++----
 drivers/dma/dw-edma/dw-edma-pcie.c       | 23 ++++++++---------
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 42 +++++++++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  9 +++----
 4 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 31fc50d..3f9593e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -21,9 +21,10 @@ enum dw_edma_dir {
 	EDMA_DIR_READ
 };
 
-enum dw_edma_mode {
-	EDMA_MODE_LEGACY = 0,
-	EDMA_MODE_UNROLL
+enum dw_edma_map_format {
+	EDMA_MF_EDMA_LEGACY = 0x0,
+	EDMA_MF_EDMA_UNROLL = 0x1,
+	EDMA_MF_HDMA_COMPAT = 0x5
 };
 
 enum dw_edma_request {
@@ -123,8 +124,7 @@ struct dw_edma {
 	struct dw_edma_irq		*irq;
 	int				nr_irqs;
 
-	u32				version;
-	enum dw_edma_mode		mode;
+	enum dw_edma_map_format		mf;
 
 	struct dw_edma_chan		*chan;
 	const struct dw_edma_core_ops	*ops;
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1eafc60..c130549 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -30,8 +30,7 @@ struct dw_edma_pcie_data {
 	off_t				dt_off;
 	size_t				dt_sz;
 	/* Other */
-	u32				version;
-	enum dw_edma_mode		mode;
+	enum dw_edma_map_format		mf;
 	u8				irqs;
 };
 
@@ -49,8 +48,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.dt_off				= 0x00800000,	/*  8 Mbytes */
 	.dt_sz				= 0x03800000,	/* 56 Mbytes */
 	/* Other */
-	.version			= 0,
-	.mode				= EDMA_MODE_UNROLL,
+	.mf				= EDMA_MF_EDMA_UNROLL,
 	.irqs				= 1,
 };
 
@@ -69,8 +67,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	const struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
-	int err, nr_irqs;
 	struct dw_edma *dw;
+	int err, nr_irqs;
 
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
@@ -157,16 +155,19 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	dw->dt_region.paddr += pdata->dt_off;
 	dw->dt_region.sz = pdata->dt_sz;
 
-	dw->version = pdata->version;
-	dw->mode = pdata->mode;
+	dw->mf = pdata->mf;
 	dw->nr_irqs = nr_irqs;
 	dw->ops = &dw_edma_pcie_core_ops;
 
 	/* Debug info */
-	pci_dbg(pdev, "Version:\t%u\n", dw->version);
-
-	pci_dbg(pdev, "Mode:\t%s\n",
-		dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
+	if (dw->mf == EDMA_MF_EDMA_LEGACY)
+		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
+	else if (dw->mf == EDMA_MF_EDMA_UNROLL)
+		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
+	else if (dw->mf == EDMA_MF_HDMA_COMPAT)
+		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
+	else
+		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 		pdata->rg_bar, pdata->rg_off, pdata->rg_sz,
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 7888eda..5b0541a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -96,7 +96,7 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 static inline struct dw_edma_v0_ch_regs __iomem *
 __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 {
-	if (dw->mode == EDMA_MODE_LEGACY)
+	if (dw->mf == EDMA_MF_EDMA_LEGACY)
 		return &(__dw_regs(dw)->type.legacy.ch);
 
 	if (dir == EDMA_DIR_WRITE)
@@ -108,7 +108,7 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u32 value, void __iomem *addr)
 {
-	if (dw->mode == EDMA_MODE_LEGACY) {
+	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -133,7 +133,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 {
 	u32 value;
 
-	if (dw->mode == EDMA_MODE_LEGACY) {
+	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -365,6 +365,42 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	if (first) {
 		/* Enable engine */
 		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
+		if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+			switch (chan->id) {
+			case 0:
+				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
+					      BIT(0));
+				break;
+			case 1:
+				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
+					      BIT(0));
+				break;
+			case 2:
+				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
+					      BIT(0));
+				break;
+			case 3:
+				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
+					      BIT(0));
+				break;
+			case 4:
+				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
+					      BIT(0));
+				break;
+			case 5:
+				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
+					      BIT(0));
+				break;
+			case 6:
+				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
+					      BIT(0));
+				break;
+			case 7:
+				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
+					      BIT(0));
+				break;
+			}
+		}
 		/* Interrupt unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index a5e2783..157dfc2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -55,7 +55,7 @@ struct debugfs_entries {
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
 	void __iomem *reg = (void __force __iomem *)data;
-	if (dw->mode == EDMA_MODE_LEGACY &&
+	if (dw->mf == EDMA_MF_EDMA_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
 		void __iomem *ptr = &regs->type.legacy.ch;
 		u32 viewport_sel = 0;
@@ -174,7 +174,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mode == EDMA_MODE_UNROLL) {
+	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -243,7 +243,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mode == EDMA_MODE_UNROLL) {
+	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -297,8 +297,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!base_dir)
 		return;
 
-	debugfs_create_u32("version", 0444, base_dir, &dw->version);
-	debugfs_create_u32("mode", 0444, base_dir, &dw->mode);
+	debugfs_create_u32("mf", 0444, base_dir, &dw->mf);
 	debugfs_create_u16("wr_ch_cnt", 0444, base_dir, &dw->wr_ch_cnt);
 	debugfs_create_u16("rd_ch_cnt", 0444, base_dir, &dw->rd_ch_cnt);
 
-- 
2.7.4

