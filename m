Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E266584197
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiG1OgG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiG1OfN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:35:13 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D23C53D58A
        for <dmaengine@vger.kernel.org>; Thu, 28 Jul 2022 07:34:33 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 20DC25BE3;
        Thu, 28 Jul 2022 17:31:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 20DC25BE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659018685;
        bh=QUxJaR65YdZJGvnt8gY9IQtkvNZZN89V17AaNbVexmY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rdZ9Y32roXVRbqsLM5UC+jWjIUH6bTKQ+7LtCbdl///NLanTINDEY3Ax2gdBqqZ8R
         8YrGRwEbHJZBebXgD9LfZuqqdsP9qA4fNsFBuRoUztScMaG9qgLuMljobtBp6KGKyg
         DqHFQSwkQdGXbDg5T9ufHU9HE2HCsLStnhyhFIH4=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:29:00 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 16/24] dmaengine: dw-edma: Move eDMA data pointer to DebugFS node descriptor
Date:   Thu, 28 Jul 2022 17:28:33 +0300
Message-ID: <20220728142841.12305-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
References: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The last thing that really stops the DebugFS part of the eDMA driver from
supporting the multi-eDMA platform in is keeping the eDMA private data
pointer in the static area of the DebugFS module. Since the DebugFS node
descriptors are now kz-allocated we can freely move that pointer to being
preserved in the descriptors. After the DebugFS initialization procedure
that pointer will be used in the DebugFS files getter to access the common
CSRs space and the context CSRs spin-lock. So the main part of this change
is connected with the DebugFS nodes descriptors initialization macros,
which aside with already defined prototypes now require to have the DW
eDMA private data pointer passed.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 242 +++++++++++------------
 1 file changed, 117 insertions(+), 125 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 1596eedf35c5..e6cf608d121b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -13,53 +13,55 @@
 #include "dw-edma-v0-regs.h"
 #include "dw-edma-core.h"
 
-#define REGS_ADDR(name) \
-	((void __iomem *)&regs->name)
+#define REGS_ADDR(dw, name)							\
+	({									\
+		struct dw_edma_v0_regs __iomem *__regs = (dw)->chip->reg_base;	\
+										\
+		(void __iomem *)&__regs->name;					\
+	})
 
-#define REGS_CH_ADDR(name, _dir, _ch)						\
+#define REGS_CH_ADDR(dw, name, _dir, _ch)					\
 	({									\
 		struct dw_edma_v0_ch_regs __iomem *__ch_regs;			\
 										\
 		if ((dw)->chip->mf == EDMA_MF_EDMA_LEGACY)			\
-			__ch_regs = &regs->type.legacy.ch;			\
+			__ch_regs = REGS_ADDR(dw, type.legacy.ch);		\
 		else if (_dir == EDMA_DIR_READ)					\
-			__ch_regs = &regs->type.unroll.ch[_ch].rd;		\
+			__ch_regs = REGS_ADDR(dw, type.unroll.ch[_ch].rd);	\
 		else								\
-			__ch_regs = &regs->type.unroll.ch[_ch].wr;		\
+			__ch_regs = REGS_ADDR(dw, type.unroll.ch[_ch].wr);	\
 										\
 		(void __iomem *)&__ch_regs->name;				\
 	})
 
-#define REGISTER(name) \
-	{ #name, REGS_ADDR(name) }
+#define REGISTER(dw, name) \
+	{ dw, #name, REGS_ADDR(dw, name) }
 
-#define CTX_REGISTER(name, dir, ch) \
-	{ #name, REGS_CH_ADDR(name, dir, ch), dir, ch }
+#define CTX_REGISTER(dw, name, dir, ch) \
+	{ dw, #name, REGS_CH_ADDR(dw, name, dir, ch), dir, ch }
 
-#define WR_REGISTER(name) \
-	{ #name, REGS_ADDR(wr_##name) }
-#define RD_REGISTER(name) \
-	{ #name, REGS_ADDR(rd_##name) }
+#define WR_REGISTER(dw, name) \
+	{ dw, #name, REGS_ADDR(dw, wr_##name) }
+#define RD_REGISTER(dw, name) \
+	{ dw, #name, REGS_ADDR(dw, rd_##name) }
 
-#define WR_REGISTER_LEGACY(name) \
-	{ #name, REGS_ADDR(type.legacy.wr_##name) }
+#define WR_REGISTER_LEGACY(dw, name) \
+	{ dw, #name, REGS_ADDR(dw, type.legacy.wr_##name) }
 #define RD_REGISTER_LEGACY(name) \
-	{ #name, REGS_ADDR(type.legacy.rd_##name) }
+	{ dw, #name, REGS_ADDR(dw, type.legacy.rd_##name) }
 
-#define WR_REGISTER_UNROLL(name) \
-	{ #name, REGS_ADDR(type.unroll.wr_##name) }
-#define RD_REGISTER_UNROLL(name) \
-	{ #name, REGS_ADDR(type.unroll.rd_##name) }
+#define WR_REGISTER_UNROLL(dw, name) \
+	{ dw, #name, REGS_ADDR(dw, type.unroll.wr_##name) }
+#define RD_REGISTER_UNROLL(dw, name) \
+	{ dw, #name, REGS_ADDR(dw, type.unroll.rd_##name) }
 
 #define WRITE_STR				"write"
 #define READ_STR				"read"
 #define CHANNEL_STR				"channel"
 #define REGISTERS_STR				"registers"
 
-static struct dw_edma				*dw;
-static struct dw_edma_v0_regs			__iomem *regs;
-
 struct dw_edma_debugfs_entry {
+	struct dw_edma				*dw;
 	const char				*name;
 	void __iomem				*reg;
 	enum dw_edma_dir			dir;
@@ -69,10 +71,11 @@ struct dw_edma_debugfs_entry {
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
 	struct dw_edma_debugfs_entry *entry = data;
+	struct dw_edma *dw = entry->dw;
 	void __iomem *reg = entry->reg;
 
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
-	    reg >= (void __iomem *)&regs->type.legacy.ch) {
+	    reg >= REGS_ADDR(dw, type.legacy.ch)) {
 		unsigned long flags;
 		u32 viewport_sel;
 
@@ -81,7 +84,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
-		writel(viewport_sel, &regs->type.legacy.viewport_sel);
+		writel(viewport_sel, REGS_ADDR(dw, type.legacy.viewport_sel));
 		*val = readl(reg);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -93,7 +96,8 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_edma_debugfs_u32_get, NULL, "0x%08llx\n");
 
-static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
+static void dw_edma_debugfs_create_x32(struct dw_edma *dw,
+				       const struct dw_edma_debugfs_entry ini[],
 				       int nr_entries, struct dentry *dent)
 {
 	struct dw_edma_debugfs_entry *entries;
@@ -112,62 +116,62 @@ static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
 	}
 }
 
-static void dw_edma_debugfs_regs_ch(enum dw_edma_dir dir, u16 ch,
-				    struct dentry *dent)
+static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
+				    u16 ch, struct dentry *dent)
 {
 	struct dw_edma_debugfs_entry debugfs_regs[] = {
-		CTX_REGISTER(ch_control1, dir, ch),
-		CTX_REGISTER(ch_control2, dir, ch),
-		CTX_REGISTER(transfer_size, dir, ch),
-		CTX_REGISTER(sar.lsb, dir, ch),
-		CTX_REGISTER(sar.msb, dir, ch),
-		CTX_REGISTER(dar.lsb, dir, ch),
-		CTX_REGISTER(dar.msb, dir, ch),
-		CTX_REGISTER(llp.lsb, dir, ch),
-		CTX_REGISTER(llp.msb, dir, ch),
+		CTX_REGISTER(dw, ch_control1, dir, ch),
+		CTX_REGISTER(dw, ch_control2, dir, ch),
+		CTX_REGISTER(dw, transfer_size, dir, ch),
+		CTX_REGISTER(dw, sar.lsb, dir, ch),
+		CTX_REGISTER(dw, sar.msb, dir, ch),
+		CTX_REGISTER(dw, dar.lsb, dir, ch),
+		CTX_REGISTER(dw, dar.msb, dir, ch),
+		CTX_REGISTER(dw, llp.lsb, dir, ch),
+		CTX_REGISTER(dw, llp.msb, dir, ch),
 	};
 	int nr_entries;
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
-	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, dent);
+	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
 }
 
-static void dw_edma_debugfs_regs_wr(struct dentry *dent)
+static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
-		WR_REGISTER(engine_en),
-		WR_REGISTER(doorbell),
-		WR_REGISTER(ch_arb_weight.lsb),
-		WR_REGISTER(ch_arb_weight.msb),
+		WR_REGISTER(dw, engine_en),
+		WR_REGISTER(dw, doorbell),
+		WR_REGISTER(dw, ch_arb_weight.lsb),
+		WR_REGISTER(dw, ch_arb_weight.msb),
 		/* eDMA interrupts registers */
-		WR_REGISTER(int_status),
-		WR_REGISTER(int_mask),
-		WR_REGISTER(int_clear),
-		WR_REGISTER(err_status),
-		WR_REGISTER(done_imwr.lsb),
-		WR_REGISTER(done_imwr.msb),
-		WR_REGISTER(abort_imwr.lsb),
-		WR_REGISTER(abort_imwr.msb),
-		WR_REGISTER(ch01_imwr_data),
-		WR_REGISTER(ch23_imwr_data),
-		WR_REGISTER(ch45_imwr_data),
-		WR_REGISTER(ch67_imwr_data),
-		WR_REGISTER(linked_list_err_en),
+		WR_REGISTER(dw, int_status),
+		WR_REGISTER(dw, int_mask),
+		WR_REGISTER(dw, int_clear),
+		WR_REGISTER(dw, err_status),
+		WR_REGISTER(dw, done_imwr.lsb),
+		WR_REGISTER(dw, done_imwr.msb),
+		WR_REGISTER(dw, abort_imwr.lsb),
+		WR_REGISTER(dw, abort_imwr.msb),
+		WR_REGISTER(dw, ch01_imwr_data),
+		WR_REGISTER(dw, ch23_imwr_data),
+		WR_REGISTER(dw, ch45_imwr_data),
+		WR_REGISTER(dw, ch67_imwr_data),
+		WR_REGISTER(dw, linked_list_err_en),
 	};
 	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
-		WR_REGISTER_UNROLL(engine_chgroup),
-		WR_REGISTER_UNROLL(engine_hshake_cnt.lsb),
-		WR_REGISTER_UNROLL(engine_hshake_cnt.msb),
-		WR_REGISTER_UNROLL(ch0_pwr_en),
-		WR_REGISTER_UNROLL(ch1_pwr_en),
-		WR_REGISTER_UNROLL(ch2_pwr_en),
-		WR_REGISTER_UNROLL(ch3_pwr_en),
-		WR_REGISTER_UNROLL(ch4_pwr_en),
-		WR_REGISTER_UNROLL(ch5_pwr_en),
-		WR_REGISTER_UNROLL(ch6_pwr_en),
-		WR_REGISTER_UNROLL(ch7_pwr_en),
+		WR_REGISTER_UNROLL(dw, engine_chgroup),
+		WR_REGISTER_UNROLL(dw, engine_hshake_cnt.lsb),
+		WR_REGISTER_UNROLL(dw, engine_hshake_cnt.msb),
+		WR_REGISTER_UNROLL(dw, ch0_pwr_en),
+		WR_REGISTER_UNROLL(dw, ch1_pwr_en),
+		WR_REGISTER_UNROLL(dw, ch2_pwr_en),
+		WR_REGISTER_UNROLL(dw, ch3_pwr_en),
+		WR_REGISTER_UNROLL(dw, ch4_pwr_en),
+		WR_REGISTER_UNROLL(dw, ch5_pwr_en),
+		WR_REGISTER_UNROLL(dw, ch6_pwr_en),
+		WR_REGISTER_UNROLL(dw, ch7_pwr_en),
 	};
 	struct dentry *regs_dent, *ch_dent;
 	int nr_entries, i;
@@ -176,11 +180,11 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dent)
 	regs_dent = debugfs_create_dir(WRITE_STR, dent);
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
-	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
+	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dent);
 
 	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
-		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
+		dw_edma_debugfs_create_x32(dw, debugfs_unroll_regs, nr_entries,
 					   regs_dent);
 	}
 
@@ -189,47 +193,47 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dent)
 
 		ch_dent = debugfs_create_dir(name, regs_dent);
 
-		dw_edma_debugfs_regs_ch(EDMA_DIR_WRITE, i, ch_dent);
+		dw_edma_debugfs_regs_ch(dw, EDMA_DIR_WRITE, i, ch_dent);
 	}
 }
 
-static void dw_edma_debugfs_regs_rd(struct dentry *dent)
+static void dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
 		/* eDMA global registers */
-		RD_REGISTER(engine_en),
-		RD_REGISTER(doorbell),
-		RD_REGISTER(ch_arb_weight.lsb),
-		RD_REGISTER(ch_arb_weight.msb),
+		RD_REGISTER(dw, engine_en),
+		RD_REGISTER(dw, doorbell),
+		RD_REGISTER(dw, ch_arb_weight.lsb),
+		RD_REGISTER(dw, ch_arb_weight.msb),
 		/* eDMA interrupts registers */
-		RD_REGISTER(int_status),
-		RD_REGISTER(int_mask),
-		RD_REGISTER(int_clear),
-		RD_REGISTER(err_status.lsb),
-		RD_REGISTER(err_status.msb),
-		RD_REGISTER(linked_list_err_en),
-		RD_REGISTER(done_imwr.lsb),
-		RD_REGISTER(done_imwr.msb),
-		RD_REGISTER(abort_imwr.lsb),
-		RD_REGISTER(abort_imwr.msb),
-		RD_REGISTER(ch01_imwr_data),
-		RD_REGISTER(ch23_imwr_data),
-		RD_REGISTER(ch45_imwr_data),
-		RD_REGISTER(ch67_imwr_data),
+		RD_REGISTER(dw, int_status),
+		RD_REGISTER(dw, int_mask),
+		RD_REGISTER(dw, int_clear),
+		RD_REGISTER(dw, err_status.lsb),
+		RD_REGISTER(dw, err_status.msb),
+		RD_REGISTER(dw, linked_list_err_en),
+		RD_REGISTER(dw, done_imwr.lsb),
+		RD_REGISTER(dw, done_imwr.msb),
+		RD_REGISTER(dw, abort_imwr.lsb),
+		RD_REGISTER(dw, abort_imwr.msb),
+		RD_REGISTER(dw, ch01_imwr_data),
+		RD_REGISTER(dw, ch23_imwr_data),
+		RD_REGISTER(dw, ch45_imwr_data),
+		RD_REGISTER(dw, ch67_imwr_data),
 	};
 	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
 		/* eDMA channel context grouping */
-		RD_REGISTER_UNROLL(engine_chgroup),
-		RD_REGISTER_UNROLL(engine_hshake_cnt.lsb),
-		RD_REGISTER_UNROLL(engine_hshake_cnt.msb),
-		RD_REGISTER_UNROLL(ch0_pwr_en),
-		RD_REGISTER_UNROLL(ch1_pwr_en),
-		RD_REGISTER_UNROLL(ch2_pwr_en),
-		RD_REGISTER_UNROLL(ch3_pwr_en),
-		RD_REGISTER_UNROLL(ch4_pwr_en),
-		RD_REGISTER_UNROLL(ch5_pwr_en),
-		RD_REGISTER_UNROLL(ch6_pwr_en),
-		RD_REGISTER_UNROLL(ch7_pwr_en),
+		RD_REGISTER_UNROLL(dw, engine_chgroup),
+		RD_REGISTER_UNROLL(dw, engine_hshake_cnt.lsb),
+		RD_REGISTER_UNROLL(dw, engine_hshake_cnt.msb),
+		RD_REGISTER_UNROLL(dw, ch0_pwr_en),
+		RD_REGISTER_UNROLL(dw, ch1_pwr_en),
+		RD_REGISTER_UNROLL(dw, ch2_pwr_en),
+		RD_REGISTER_UNROLL(dw, ch3_pwr_en),
+		RD_REGISTER_UNROLL(dw, ch4_pwr_en),
+		RD_REGISTER_UNROLL(dw, ch5_pwr_en),
+		RD_REGISTER_UNROLL(dw, ch6_pwr_en),
+		RD_REGISTER_UNROLL(dw, ch7_pwr_en),
 	};
 	struct dentry *regs_dent, *ch_dent;
 	int nr_entries, i;
@@ -238,11 +242,11 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dent)
 	regs_dent = debugfs_create_dir(READ_STR, dent);
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
-	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
+	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dent);
 
 	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
-		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
+		dw_edma_debugfs_create_x32(dw, debugfs_unroll_regs, nr_entries,
 					   regs_dent);
 	}
 
@@ -251,15 +255,15 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dent)
 
 		ch_dent = debugfs_create_dir(name, regs_dent);
 
-		dw_edma_debugfs_regs_ch(EDMA_DIR_READ, i, ch_dent);
+		dw_edma_debugfs_regs_ch(dw, EDMA_DIR_READ, i, ch_dent);
 	}
 }
 
-static void dw_edma_debugfs_regs(void)
+static void dw_edma_debugfs_regs(struct dw_edma *dw)
 {
 	const struct dw_edma_debugfs_entry debugfs_regs[] = {
-		REGISTER(ctrl_data_arb_prior),
-		REGISTER(ctrl),
+		REGISTER(dw, ctrl_data_arb_prior),
+		REGISTER(dw, ctrl),
 	};
 	struct dentry *regs_dent;
 	int nr_entries;
@@ -267,40 +271,28 @@ static void dw_edma_debugfs_regs(void)
 	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
-	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
+	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dent);
 
-	dw_edma_debugfs_regs_wr(regs_dent);
-	dw_edma_debugfs_regs_rd(regs_dent);
+	dw_edma_debugfs_regs_wr(dw, regs_dent);
+	dw_edma_debugfs_regs_rd(dw, regs_dent);
 }
 
-void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
+void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 {
 	if (!debugfs_initialized())
 		return;
 
-	dw = _dw;
-	if (!dw)
-		return;
-
-	regs = dw->chip->reg_base;
-	if (!regs)
-		return;
-
 	dw->debugfs = debugfs_create_dir(dw->name, NULL);
 
 	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
 	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
 	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
 
-	dw_edma_debugfs_regs();
+	dw_edma_debugfs_regs(dw);
 }
 
-void dw_edma_v0_debugfs_off(struct dw_edma *_dw)
+void dw_edma_v0_debugfs_off(struct dw_edma *dw)
 {
-	dw = _dw;
-	if (!dw)
-		return;
-
 	debugfs_remove_recursive(dw->debugfs);
 	dw->debugfs = NULL;
 }
-- 
2.35.1

