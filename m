Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A18B4E9C91
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbiC1QqD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242654AbiC1Qpy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:45:54 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D130A20F75;
        Mon, 28 Mar 2022 09:44:07 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id AEF031E4959;
        Thu, 24 Mar 2022 04:48:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru AEF031E4959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086532;
        bh=+IEDsRaJtaAOEVZuZm2s1zd6/7iKdTGU1JFLulsvSLI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=p48lkGjl46eibcqigaSeooGcXN4oiX+1XKr8udykhWbY8ex1r/lUwcp59IYwaRUBl
         Qy1nG9u0NO4V2EBXDZN/LWdzirJDaNo3cnD5oj1bfw1PWSQL8tdFGADIldlH6NDeZ9
         QQaHR7/ToedaDDQu/AuYbZ2d+/auA43JRGLxzyJk=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:52 +0300
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
Subject: [PATCH 20/25] dmaengine: dw-edma: Use non-atomic io-64 methods
Date:   Thu, 24 Mar 2022 04:48:31 +0300
Message-ID: <20220324014836.19149-21-Sergey.Semin@baikalelectronics.ru>
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

Instead of splitting the 64-bits IOs up into two 32-bits ones it's
possible to use an available set of the non-atomic readq/writeq methods
implemented exactly for such cases. They are defined in the dedicated
header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
if the 64-bits readq/writeq methods are unavailable on some platforms at
consideration, the corresponding drivers can have any of these headers
included and stop locally re-implementing the 64-bits IO accessors taking
into account the non-atomic nature of the included methods. Let's do that
in the DW eDMA driver too. Note by doing so we can discard the
CONFIG_64BIT config ifdefs from the code. Also note that if a platform
doesn't support 64-bit DBI IOs then the corresponding accessors will just
directly call the lo_hi_readq()/lo_hi_writeq() methods.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 71 +++++++++------------------
 1 file changed, 24 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 6b303d5a6b2a..ebb860e19c75 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -8,6 +8,8 @@
 
 #include <linux/bitfield.h>
 
+#include <linux/io-64-nonatomic-lo-hi.h>
+
 #include "dw-edma-core.h"
 #include "dw-edma-v0-core.h"
 #include "dw-edma-v0-regs.h"
@@ -53,8 +55,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 		SET_32(dw, rd_##name, value);		\
 	} while (0)
 
-#ifdef CONFIG_64BIT
-
 #define SET_64(dw, name, value)				\
 	writeq(value, &(__dw_regs(dw)->name))
 
@@ -80,8 +80,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 		SET_64(dw, rd_##name, value);		\
 	} while (0)
 
-#endif /* CONFIG_64BIT */
-
 #define SET_COMPAT(dw, name, value)			\
 	writel(value, &(__dw_regs(dw)->type.unroll.name))
 
@@ -164,14 +162,13 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define SET_LL_32(ll, value) \
 	writel(value, ll)
 
-#ifdef CONFIG_64BIT
-
 static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u64 value, void __iomem *addr)
 {
+	unsigned long flags;
+
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
-		unsigned long flags;
 
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
@@ -181,22 +178,25 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 
 		writel(viewport_sel,
 		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+	}
+
+	if (dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI)
+		lo_hi_writeq(value, addr);
+	else
 		writeq(value, addr);
 
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
-	} else {
-		writeq(value, addr);
-	}
 }
 
 static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			   const void __iomem *addr)
 {
-	u32 value;
+	unsigned long flags;
+	u64 value;
 
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
-		unsigned long flags;
 
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
@@ -206,12 +206,15 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 
 		writel(viewport_sel,
 		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+	}
+
+	if (dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI)
+		value = lo_hi_readq(addr);
+	else
 		value = readq(addr);
 
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
-	} else {
-		value = readq(addr);
-	}
 
 	return value;
 }
@@ -225,8 +228,6 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define SET_LL_64(ll, value) \
 	writeq(value, ll)
 
-#endif /* CONFIG_64BIT */
-
 /* eDMA management callbacks */
 void dw_edma_v0_core_off(struct dw_edma *dw)
 {
@@ -325,19 +326,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		/* Transfer size */
 		SET_LL_32(&lli[i].transfer_size, child->sz);
 		/* SAR */
-		#ifdef CONFIG_64BIT
-			SET_LL_64(&lli[i].sar.reg, child->sar);
-		#else /* CONFIG_64BIT */
-			SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
-			SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
-		#endif /* CONFIG_64BIT */
+		SET_LL_64(&lli[i].sar.reg, child->sar);
 		/* DAR */
-		#ifdef CONFIG_64BIT
-			SET_LL_64(&lli[i].dar.reg, child->dar);
-		#else /* CONFIG_64BIT */
-			SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
-			SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
-		#endif /* CONFIG_64BIT */
+		SET_LL_64(&lli[i].dar.reg, child->dar);
+
 		i++;
 	}
 
@@ -349,12 +341,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	/* Channel control */
 	SET_LL_32(&llp->control, control);
 	/* Linked list */
-	#ifdef CONFIG_64BIT
-		SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
-	#else /* CONFIG_64BIT */
-		SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
-		SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));
-	#endif /* CONFIG_64BIT */
+	SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
 }
 
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -417,18 +404,8 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
-		if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
-		    !IS_ENABLED(CONFIG_64BIT)) {
-			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-				  lower_32_bits(chunk->ll_region.paddr));
-			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-				  upper_32_bits(chunk->ll_region.paddr));
-		} else {
-		#ifdef CONFIG_64BIT
-			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
-				  chunk->ll_region.paddr);
-		#endif
-		}
+		SET_CH_64(dw, chan->dir, chan->id, llp.reg,
+			  chunk->ll_region.paddr);
 	}
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
-- 
2.35.1

