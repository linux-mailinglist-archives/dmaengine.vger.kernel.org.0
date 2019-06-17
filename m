Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692CB483B8
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2019 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfFQNSl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jun 2019 09:18:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37963 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNSk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jun 2019 09:18:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mr8O8-1iNUXv3NpO-00oGh7; Mon, 17 Jun 2019 15:18:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <jpinto@synopsys.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: dw-edma: fix endianess confusion
Date:   Mon, 17 Jun 2019 15:17:47 +0200
Message-Id: <20190617131820.2470686-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p+geUhUKUL4f7OK8tQ8WVGihl7gqGQ8A5Om6QbTe94rGzYUI3OC
 j1A/ZIE+nVkjxefutzqeNH9cbslliG3a6aFWhIhHMchrbR+KanWlva5YZ7GSP+OlUj6Dx6U
 0u2zzgeaJAG/xWPM/cfiw9608DlyTADCLPGnzlRX49jd812jkyfkZrtBqGOs6xi6c+jLSdM
 6iKxsH6MqqIAtPftzZTFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TvcX8HMw+Ds=:ArVJLvBLX1DRseC9uzoY+e
 IcdmIMaz3365BI1ioZBRrPk43bTokjURNnuOphu8v7HP2Wj6rqxdNoG4HBdHT0KdgvZdOi8oq
 SvYa/+pgxFPO9FRQQXDq62WCF2c2Te+jWooSMz4zrJ4mjKwuPQFAiFYfuL/EOzuWpHHb2hCTN
 +uz8nQ7fa2O1bKyfmzxCZpgFaY9WRL+idrcrCCp8WyfXZSGVZzAOTvQzse4MR+CS1zEN0cx2W
 zJ/AVsn95/ZMj37iImv64udP2NmPnx6Ls43Nt6Xian/byYkpRzAC00zXVsYS/hNs9uy0ebVLj
 1PDY5vX1//zZXKGMjBUbzMJJoZpgqRUlZSNQInqAdcguTcVz+B7ow0xPQFiv1rl5pbskyEyli
 rNuzh1UB8hiaOrNKO29J/rvWWeVs+dbeCvaNqVp/k4szOmDyMT0jNs8J0zADJvOjJl4M8we1h
 W0tMwIUkFajDp8S0Yn7mkIR7LI8kdHQyBaMAzh8Xhl13LloDi1BRtkdhSpBcIulY1J2x8kwUq
 6g8zWDlH0X5nvV50YxuER7u0ibsDY3amZvcgVFcT4Ea/v6PEmeNCY/yqDDnfAybJJ9VRwfFHl
 Hw+F3LoxpYVTTfgnFcLdae04bcGl81z7eW/g/9NHoM/vi+qiEjwcuLM1w24S0ccEaEIMakB0Y
 Bc4DoNpkZicbBdLH2c+yAp/6E6yGMtbJIa7EkaHZ72RsVdpVlt3Zm8uMNBy7SXCc3XDUYPlOp
 Bp+u2ZO63eeJThX6NvRz5FmnmlL/uAgi4mwGkD9A8hpBkzrV3m3ewy64cfA=
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
into a register function where it gets swapped again. I assume that this
was simply ported from a non-Linux OS, and the swap was done incorrectly.
Replace it with a cast to uintptr_t.

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 97e3fd41c8a8..d670ebcc37b3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -195,7 +195,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	struct dw_edma_v0_lli __iomem *lli;
 	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
-	u64 sar, dar, addr;
+	uintptr_t sar, dar, addr;
 	int j;
 
 	lli = chunk->ll_region.vaddr;
@@ -214,11 +214,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		/* Transfer size */
 		SET_LL(&lli[i].transfer_size, child->sz);
 		/* SAR - low, high */
-		sar = cpu_to_le64(child->sar);
+		sar = (uintptr_t)child->sar;
 		SET_LL(&lli[i].sar_low, lower_32_bits(sar));
 		SET_LL(&lli[i].sar_high, upper_32_bits(sar));
 		/* DAR - low, high */
-		dar = cpu_to_le64(child->dar);
+		dar = (uintptr_t)child->dar;
 		SET_LL(&lli[i].dar_low, lower_32_bits(dar));
 		SET_LL(&lli[i].dar_high, upper_32_bits(dar));
 		i++;
@@ -232,7 +232,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	/* Channel control */
 	SET_LL(&llp->control, control);
 	/* Linked list  - low, high */
-	addr = cpu_to_le64(chunk->ll_region.paddr);
+	addr = (uintptr_t)chunk->ll_region.paddr;
 	SET_LL(&llp->llp_low, lower_32_bits(addr));
 	SET_LL(&llp->llp_high, upper_32_bits(addr));
 }
@@ -262,7 +262,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH(dw, chan->dir, chan->id, ch_control1,
 		       (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list - low, high */
-		llp = cpu_to_le64(chunk->ll_region.paddr);
+		llp = (uintptr_t)chunk->ll_region.paddr;
 		SET_CH(dw, chan->dir, chan->id, llp_low, lower_32_bits(llp));
 		SET_CH(dw, chan->dir, chan->id, llp_high, upper_32_bits(llp));
 	}
-- 
2.20.0

