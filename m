Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE259C77C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 20:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiHVSzE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiHVSyY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 14:54:24 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86A2A40E12;
        Mon, 22 Aug 2022 11:54:02 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9A588DA8;
        Mon, 22 Aug 2022 21:57:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9A588DA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194632;
        bh=Gkk7/wuRGiJqLIFB/dQGceCCDwcGwRLJqDMhy3IdGqc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=l0dF9GlTZS8HSL5nxJ2MGiF9fZtvLT764BthkMc8m0MgXqch2w5xhlhahrVojjxKr
         KIligtziQEe00jizewsPBo+OT1xKvqmdz+gYiUittYKs4YzA9TYsLV1tsKM3JyGw7C
         4ETWc06/kDiDeJY0e33mTj205Lk5BLTUNKmUEY0M=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:53:58 +0300
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
Subject: [PATCH RESEND v5 15/24] dmaengine: dw-edma: Simplify the DebugFS context CSRs init procedure
Date:   Mon, 22 Aug 2022 21:53:23 +0300
Message-ID: <20220822185332.26149-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW eDMA v4.70a and older have the read and write channels context CSRs
indirectly accessible. It means the CSRs like Channel Control, Xfer size,
SAR, DAR and LLP address are accessed over at a fixed MMIO address, but
their reference to the corresponding channel is determined by the Viewport
CSR. In order to have a coherent access to these registers the CSR IOs are
supposed to be protected with a spin-lock. DW eDMA v4.80a and newer
normally have unrolled Read/Write channel context registers. That is all
CSRs denoted before are directly mapped in the controller MMIO space.

Since both normal and viewport-based registers are exposed via the DebugFS
nodes, the original code author decided to implement an algorithm based on
the unrolled CSRs mapping with the viewport addresses recalculation if
it's required. The problem is that such implementation turned to be first
unscalable (supports a platform with only single eDMA available since a
base address statically preserved) and second needlessly overcomplicated
(it loops over all Rd/Wr context addresses and re-calculates the viewport
base address on each DebugFS node access). The algorithm can be greatly
simplified just by adding the channel ID and it's direction fields in the
eDMA DebugFS node descriptor. These new parameters can be used to find a
CSR offset within the corresponding channel registers space. The DW eDMA
DebugFS node getter afterwards will also use them in order to activate the
respective context CSRs viewport before reading data from the specified
register. In case of the unrolled version of the CSRs mapping there won't
be any spin-lock taken/released, no viewport activation as before this
modification.

Note this modification fixes the REGISTER() macros using an externally
defined local variable. The same problem with the rest of the macro will
be fixed in the next commit.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 84 +++++++++++-------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 7bb3363b40e4..1596eedf35c5 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -15,9 +15,27 @@
 
 #define REGS_ADDR(name) \
 	((void __iomem *)&regs->name)
+
+#define REGS_CH_ADDR(name, _dir, _ch)						\
+	({									\
+		struct dw_edma_v0_ch_regs __iomem *__ch_regs;			\
+										\
+		if ((dw)->chip->mf == EDMA_MF_EDMA_LEGACY)			\
+			__ch_regs = &regs->type.legacy.ch;			\
+		else if (_dir == EDMA_DIR_READ)					\
+			__ch_regs = &regs->type.unroll.ch[_ch].rd;		\
+		else								\
+			__ch_regs = &regs->type.unroll.ch[_ch].wr;		\
+										\
+		(void __iomem *)&__ch_regs->name;				\
+	})
+
 #define REGISTER(name) \
 	{ #name, REGS_ADDR(name) }
 
+#define CTX_REGISTER(name, dir, ch) \
+	{ #name, REGS_CH_ADDR(name, dir, ch), dir, ch }
+
 #define WR_REGISTER(name) \
 	{ #name, REGS_ADDR(wr_##name) }
 #define RD_REGISTER(name) \
@@ -41,14 +59,11 @@
 static struct dw_edma				*dw;
 static struct dw_edma_v0_regs			__iomem *regs;
 
-static struct {
-	void					__iomem *start;
-	void					__iomem *end;
-} lim[2][EDMA_V0_MAX_NR_CH];
-
 struct dw_edma_debugfs_entry {
 	const char				*name;
 	void __iomem				*reg;
+	enum dw_edma_dir			dir;
+	u16					ch;
 };
 
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
@@ -58,33 +73,16 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
-		void __iomem *ptr = &regs->type.legacy.ch;
-		u32 viewport_sel = 0;
 		unsigned long flags;
-		u16 ch;
-
-		for (ch = 0; ch < dw->wr_ch_cnt; ch++)
-			if (lim[0][ch].start >= reg && reg < lim[0][ch].end) {
-				ptr += (reg - lim[0][ch].start);
-				goto legacy_sel_wr;
-			}
-
-		for (ch = 0; ch < dw->rd_ch_cnt; ch++)
-			if (lim[1][ch].start >= reg && reg < lim[1][ch].end) {
-				ptr += (reg - lim[1][ch].start);
-				goto legacy_sel_rd;
-			}
-
-		return 0;
-legacy_sel_rd:
-		viewport_sel = BIT(31);
-legacy_sel_wr:
-		viewport_sel |= FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
+		u32 viewport_sel;
+
+		viewport_sel = entry->dir == EDMA_DIR_READ ? BIT(31) : 0;
+		viewport_sel |= FIELD_PREP(EDMA_V0_VIEWPORT_MASK, entry->ch);
 
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
 		writel(viewport_sel, &regs->type.legacy.viewport_sel);
-		*val = readl(ptr);
+		*val = readl(reg);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
 	} else {
@@ -114,19 +112,19 @@ static void dw_edma_debugfs_create_x32(const struct dw_edma_debugfs_entry ini[],
 	}
 }
 
-static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
+static void dw_edma_debugfs_regs_ch(enum dw_edma_dir dir, u16 ch,
 				    struct dentry *dent)
 {
-	const struct dw_edma_debugfs_entry debugfs_regs[] = {
-		REGISTER(ch_control1),
-		REGISTER(ch_control2),
-		REGISTER(transfer_size),
-		REGISTER(sar.lsb),
-		REGISTER(sar.msb),
-		REGISTER(dar.lsb),
-		REGISTER(dar.msb),
-		REGISTER(llp.lsb),
-		REGISTER(llp.msb),
+	struct dw_edma_debugfs_entry debugfs_regs[] = {
+		CTX_REGISTER(ch_control1, dir, ch),
+		CTX_REGISTER(ch_control2, dir, ch),
+		CTX_REGISTER(transfer_size, dir, ch),
+		CTX_REGISTER(sar.lsb, dir, ch),
+		CTX_REGISTER(sar.msb, dir, ch),
+		CTX_REGISTER(dar.lsb, dir, ch),
+		CTX_REGISTER(dar.msb, dir, ch),
+		CTX_REGISTER(llp.lsb, dir, ch),
+		CTX_REGISTER(llp.msb, dir, ch),
 	};
 	int nr_entries;
 
@@ -191,10 +189,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dent)
 
 		ch_dent = debugfs_create_dir(name, regs_dent);
 
-		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dent);
-
-		lim[0][i].start = &regs->type.unroll.ch[i].wr;
-		lim[0][i].end = &regs->type.unroll.ch[i].padding_1[0];
+		dw_edma_debugfs_regs_ch(EDMA_DIR_WRITE, i, ch_dent);
 	}
 }
 
@@ -256,10 +251,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dent)
 
 		ch_dent = debugfs_create_dir(name, regs_dent);
 
-		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dent);
-
-		lim[1][i].start = &regs->type.unroll.ch[i].rd;
-		lim[1][i].end = &regs->type.unroll.ch[i].padding_2[0];
+		dw_edma_debugfs_regs_ch(EDMA_DIR_READ, i, ch_dent);
 	}
 }
 
-- 
2.35.1

