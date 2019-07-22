Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9561270001
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 14:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfGVMqn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 08:46:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfGVMqn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 08:46:43 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M4K2r-1hpGix19KD-000MNv; Mon, 22 Jul 2019 14:46:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <jpinto@synopsys.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [v2] dmaengine: dw-edma: fix endianess confusion
Date:   Mon, 22 Jul 2019 14:44:45 +0200
Message-Id: <20190722124457.1093886-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190722124457.1093886-1-arnd@arndb.de>
References: <20190722124457.1093886-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d5Lm4PYixfA8pbB02g2GgIjlRZdQahOKJAn4tWmkzSjHCHZz+0c
 mGByyd10vU6PjkFtT1c9Tv8zXEsWOBlurLMYYOe42GCRa3RycR4Fs37aYZDPSiXmWn+Uu+y
 jv1BzF7UXgTBBv8JeWwEGrn15D6CtjU7Sh1iDVnb2VD2B5ZqQQ8/PBuFNJDPaDvbiQjMSdB
 9GCuhCcNGKxdwrlC6eD+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rySnjGhQpRQ=:wCX8tZwzY2BNeINq7MDHz8
 eUWe8HmswCc/zzGV8LbVpGXmOdN8AiOSUYnJ/nbNtrDJTJkGPC4OvD2O8mKTvWEY62iC+diqy
 DEYWROsD7mOAClAHGC7Vx6X9G7FqiEkAqTu2uNvkVwCWm3mjAT6iYuM6S+vKn56XXr6ZXtQWx
 YQZDeE1OfsTwjbH1b2aY51w88Tw8BvRgI0jZPr4uYOD2SB3cagIwaV2sLhno2KPwvwtt85oLE
 yus0TuRnN3ANz+EzbHQdUDV1xH28sOcN4S+JoqcdKmFeI9pLowxMW0XfCQNTPD6Mcv0Hz4t9x
 bIzmnNMCm4Yg3ULjB9KGlW02Erv9aelWqImrQlmDY/Q/w4op1YjS7L0asNeGiWI/hnCo61/Jw
 q3W/EqMUXL6GDxFdZLYh3EsKXhqZufsS3DlmQYiEpiaVzVec59sfrcDR88OfqsCIyt+NGzWbg
 SYrzk95YQgr9gssxV9wL/ujvECJ4tT6M49KjHCv4dFcQ/FXPMMHBtLwhEN5nYXoptuZXsMSaE
 Qg1lQ+FaW9c1CRN88DrMqxK6NrhaJ3SnHGkbZHIr9gDCk94CsWkgndUPYNHjhq2Xop98taXB8
 ljnxDhYUrpyPA5xt0dZ0zw74ou+Ifzsme2o/CbblGO/t6D0C1d8+x7YjZD0nGRBzZPb3ewyev
 Z9IoZ0JI5XrwozWgfpigS83KIk8fzHiAT21na6CxnVeYx/8FGKkKy39ONRJVi8ytXxsk8wAse
 lljaNp6U10E0LI2vRY0A+2uG+jqcqFhgaJJ6eQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When building with 'make C=1', sparse reports an endianess bug:

drivers/dma/dw-edma/dw-edma-v0-debugfs.c:60:30: warning: cast removes address space of expression
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type in argument 1 (different address spaces)
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const volatile [noderef] <asn:2>*addr
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] ptr
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type in argument 1 (different address spaces)
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const volatile [noderef] <asn:2>*addr
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] ptr
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type in argument 1 (different address spaces)
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const volatile [noderef] <asn:2>*addr
drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] ptr

The current code is clearly wrong, as it passes an endian-swapped word
into a register function where it gets swapped again. Just pass the variables
directly into lower_32_bits()/upper_32_bits().

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Link: https://lore.kernel.org/lkml/20190617131820.2470686-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: remove unneeded local variables
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 97e3fd41c8a8..692de47b1670 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -195,7 +195,6 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	struct dw_edma_v0_lli __iomem *lli;
 	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
-	u64 sar, dar, addr;
 	int j;
 
 	lli = chunk->ll_region.vaddr;
@@ -214,13 +213,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		/* Transfer size */
 		SET_LL(&lli[i].transfer_size, child->sz);
 		/* SAR - low, high */
-		sar = cpu_to_le64(child->sar);
-		SET_LL(&lli[i].sar_low, lower_32_bits(sar));
-		SET_LL(&lli[i].sar_high, upper_32_bits(sar));
+		SET_LL(&lli[i].sar_low, lower_32_bits(child->sar));
+		SET_LL(&lli[i].sar_high, upper_32_bits(child->sar));
 		/* DAR - low, high */
-		dar = cpu_to_le64(child->dar);
-		SET_LL(&lli[i].dar_low, lower_32_bits(dar));
-		SET_LL(&lli[i].dar_high, upper_32_bits(dar));
+		SET_LL(&lli[i].dar_low, lower_32_bits(child->dar));
+		SET_LL(&lli[i].dar_high, upper_32_bits(child->dar));
 		i++;
 	}
 
@@ -232,9 +229,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	/* Channel control */
 	SET_LL(&llp->control, control);
 	/* Linked list  - low, high */
-	addr = cpu_to_le64(chunk->ll_region.paddr);
-	SET_LL(&llp->llp_low, lower_32_bits(addr));
-	SET_LL(&llp->llp_high, upper_32_bits(addr));
+	SET_LL(&llp->llp_low, lower_32_bits(chunk->ll_region.paddr));
+	SET_LL(&llp->llp_high, upper_32_bits(chunk->ll_region.paddr));
 }
 
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -242,7 +238,6 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->chip->dw;
 	u32 tmp;
-	u64 llp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
@@ -262,9 +257,10 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH(dw, chan->dir, chan->id, ch_control1,
 		       (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list - low, high */
-		llp = cpu_to_le64(chunk->ll_region.paddr);
-		SET_CH(dw, chan->dir, chan->id, llp_low, lower_32_bits(llp));
-		SET_CH(dw, chan->dir, chan->id, llp_high, upper_32_bits(llp));
+		SET_CH(dw, chan->dir, chan->id, llp_low,
+		       lower_32_bits(chunk->ll_region.paddr));
+		SET_CH(dw, chan->dir, chan->id, llp_high,
+		       upper_32_bits(chunk->ll_region.paddr));
 	}
 	/* Doorbell */
 	SET_RW(dw, chan->dir, doorbell,
-- 
2.20.0

