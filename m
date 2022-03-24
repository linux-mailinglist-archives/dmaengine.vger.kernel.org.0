Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E572A4E9C7D
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbiC1QqI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbiC1QqC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:02 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D8C42124E;
        Mon, 28 Mar 2022 09:44:13 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 77E261E4953;
        Thu, 24 Mar 2022 04:48:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 77E261E4953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086529;
        bh=JZJEWqKdQKr9YbeOdHWYdW7S8s++tuhxSseVhFiJlis=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=OE+34ruEddDfe5ozzL2W92f3nyXDBc7rUdir0Ep/t8inu9R9DYB9c0ELcVuu1gHgb
         UkhLuGYiF65zoei7a2IsN7TiSjB8UvGIXsZ+2I+vhb6tjpn93GSuyKTAQ+aTGSoO2o
         Yq+yLceowDJlBr8KbUYWjiUmmiuibUTTrPbtBs24=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 16/25] dmaengine: dw-edma: Simplify the DebugFS context CSRs init procedure
Date:   Thu, 24 Mar 2022 04:48:27 +0300
Message-ID: <20220324014836.19149-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 84 +++++++++++-------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 7eb0147912fa..b34a68964232 100644
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
+static void dw_edma_debugfs_regs_ch(enum dw_edma_dir edma_dir, u16 ch,
 				    struct dentry *dir)
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
+		CTX_REGISTER(ch_control1, edma_dir, ch),
+		CTX_REGISTER(ch_control2, edma_dir, ch),
+		CTX_REGISTER(transfer_size, edma_dir, ch),
+		CTX_REGISTER(sar.lsb, edma_dir, ch),
+		CTX_REGISTER(sar.msb, edma_dir, ch),
+		CTX_REGISTER(dar.lsb, edma_dir, ch),
+		CTX_REGISTER(dar.msb, edma_dir, ch),
+		CTX_REGISTER(llp.lsb, edma_dir, ch),
+		CTX_REGISTER(llp.msb, edma_dir, ch),
 	};
 	int nr_entries;
 
@@ -191,10 +189,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 
 		ch_dir = debugfs_create_dir(name, regs_dir);
 
-		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].wr, ch_dir);
-
-		lim[0][i].start = &regs->type.unroll.ch[i].wr;
-		lim[0][i].end = &regs->type.unroll.ch[i].padding_1[0];
+		dw_edma_debugfs_regs_ch(EDMA_DIR_WRITE, i, ch_dir);
 	}
 }
 
@@ -256,10 +251,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 
 		ch_dir = debugfs_create_dir(name, regs_dir);
 
-		dw_edma_debugfs_regs_ch(&regs->type.unroll.ch[i].rd, ch_dir);
-
-		lim[1][i].start = &regs->type.unroll.ch[i].rd;
-		lim[1][i].end = &regs->type.unroll.ch[i].padding_2[0];
+		dw_edma_debugfs_regs_ch(EDMA_DIR_READ, i, ch_dir);
 	}
 }
 
-- 
2.35.1

