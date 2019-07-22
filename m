Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB466FFFE
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGVMqO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 08:46:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34029 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfGVMqO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 08:46:14 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MMGAg-1i6fPV2DsE-00JGyq; Mon, 22 Jul 2019 14:45:59 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <jpinto@synopsys.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] [v2] dmaengine: dw-edma: fix __iomem type confusion
Date:   Mon, 22 Jul 2019 14:44:44 +0200
Message-Id: <20190722124457.1093886-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190722124457.1093886-1-arnd@arndb.de>
References: <20190722124457.1093886-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CUzC51gD/pkxLL6rYsN7M8PznQGFd5ynDXR2kYavwG45F9zD91i
 FyvlnwmEgAY3EVIM7aXOIfilGAVhlJDMzKvPy6m04fVLIyQUozZ1V22/X0URZqK7Q2Xm93o
 Pow5Rr7ap1DmGGKEOcSj8v2PwiKxSs0rnXrwRx7iZtHQVuPBzNXfXXUGTcOPn4nuCSDZ091
 V0SJE9hLlSDvpXtiI+cwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KuWggqzc3/E=:CEP5ANgAb2P750zS6NP5oL
 tTzimiVBjXgBqjW1W2OSPQpTfZFlsH+Cq5wkCJz386WI3IgoGE4AhmK6a2EUQ8T1RpFi0GxTB
 7NMyjXq3zrtD3X9CtmTiS/OsV88k88H5A7u75qPQWu6fFbvPR1BKl4WxweHzCpuOVG4Y6NJ9Q
 wvdyaHb8S1vlbXterhZDMqTUDcIpBk/4M1hKuiZOvKersb4DJ1LiTMuAvbwl/vU9IExm8Zbvp
 DHMKomysdumegGTsGCTFJwq66pPnktKwO5Hu9Lh8KEtqSIfhjO3WsR919ruRW5g/yj8SYDi1N
 yFQQL1gw5GkAbIKobOVF9Y4/ElOrFIXHh/Rz55xgPjSo0BAKjyeV1SiOo/VkGyj907WO+PyMJ
 zPCZ/8jSjd5J+YzwxPoDRmqi+5mQ9Ukn7RmpOTgQZKI5Uh6f97rI7enixOXszPQJoHYxBSqmC
 peL/BRVY30zIDkoa6srrC0aFNM5luyyGZObNaHhcA8FN+DOfgIYWsNMg+PkItJBHxbULm1NTD
 B74klrxJowpMo5gK4PnUz63hlBZSjbpgHgRWOt4VxVpf2prgW/hI4qKsiHNDu5OfG0kx01qfw
 HsL8YRtU99xCe2KeX2IHWHtJPihs2qKmMu4VxSTMoHaO1y7HArCB/UIIhStX+k1q7kqvNHoLT
 jng0juRefTEpHFIMWB8vG/45OU4Qmxb9ZDZVj4Z9gPI5NDhK8VYFc+Dntm0ecbAWN20cobay3
 LbvLeJkfvMrVxhtLmSUjHEBGw7XYBnKAZugMgQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The new driver mixes up dma_addr_t and __iomem pointers, which results
in warnings on some 32-bit architectures, like:

drivers/dma/dw-edma/dw-edma-v0-core.c: In function '__dw_regs':
drivers/dma/dw-edma/dw-edma-v0-core.c:28:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  return (struct dw_edma_v0_regs __iomem *)dw->rg_region.vaddr;

Make it use __iomem pointers consistently here, and avoid using dma_addr_t
for __iomem tokens altogether.

A small complication here is the debugfs code, which passes an __iomem
token as the private data for debugfs files, requiring the use of
extra __force.

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Link: https://lore.kernel.org/lkml/20190617131918.2518727-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: whitespace fixes
---
 drivers/dma/dw-edma/dw-edma-core.h       |  2 +-
 drivers/dma/dw-edma/dw-edma-pcie.c       | 18 ++++++++--------
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 10 ++++-----
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 27 ++++++++++++------------
 4 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index b6cc90cbc9dc..4e5f9f6e901b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -50,7 +50,7 @@ struct dw_edma_burst {
 
 struct dw_edma_region {
 	phys_addr_t			paddr;
-	dma_addr_t			vaddr;
+	void				__iomem *vaddr;
 	size_t				sz;
 };
 
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 4c96e1c948f2..dc85f55e1bb8 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -130,19 +130,19 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->id = pdev->devfn;
 	chip->irq = pdev->irq;
 
-	dw->rg_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->rg_bar];
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
 	dw->rg_region.vaddr += pdata->rg_off;
 	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
 	dw->rg_region.paddr += pdata->rg_off;
 	dw->rg_region.sz = pdata->rg_sz;
 
-	dw->ll_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->ll_bar];
+	dw->ll_region.vaddr = pcim_iomap_table(pdev)[pdata->ll_bar];
 	dw->ll_region.vaddr += pdata->ll_off;
 	dw->ll_region.paddr = pdev->resource[pdata->ll_bar].start;
 	dw->ll_region.paddr += pdata->ll_off;
 	dw->ll_region.sz = pdata->ll_sz;
 
-	dw->dt_region.vaddr = (dma_addr_t)pcim_iomap_table(pdev)[pdata->dt_bar];
+	dw->dt_region.vaddr = pcim_iomap_table(pdev)[pdata->dt_bar];
 	dw->dt_region.vaddr += pdata->dt_off;
 	dw->dt_region.paddr = pdev->resource[pdata->dt_bar].start;
 	dw->dt_region.paddr += pdata->dt_off;
@@ -158,17 +158,17 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	pci_dbg(pdev, "Mode:\t%s\n",
 		dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
 
-	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 		pdata->rg_bar, pdata->rg_off, pdata->rg_sz,
-		&dw->rg_region.vaddr, &dw->rg_region.paddr);
+		dw->rg_region.vaddr, &dw->rg_region.paddr);
 
-	pci_dbg(pdev, "L. List:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+	pci_dbg(pdev, "L. List:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 		pdata->ll_bar, pdata->ll_off, pdata->ll_sz,
-		&dw->ll_region.vaddr, &dw->ll_region.paddr);
+		dw->ll_region.vaddr, &dw->ll_region.paddr);
 
-	pci_dbg(pdev, "Data:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%pa, p=%pa)\n",
+	pci_dbg(pdev, "Data:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 		pdata->dt_bar, pdata->dt_off, pdata->dt_sz,
-		&dw->dt_region.vaddr, &dw->dt_region.paddr);
+		dw->dt_region.vaddr, &dw->dt_region.paddr);
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 8a3180ed49a6..97e3fd41c8a8 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,7 +25,7 @@ enum dw_edma_control {
 
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
-	return (struct dw_edma_v0_regs __iomem *)dw->rg_region.vaddr;
+	return dw->rg_region.vaddr;
 }
 
 #define SET(dw, name, value)				\
@@ -192,13 +192,13 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
-	struct dw_edma_v0_lli *lli;
-	struct dw_edma_v0_llp *llp;
+	struct dw_edma_v0_lli __iomem *lli;
+	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
 	u64 sar, dar, addr;
 	int j;
 
-	lli = (struct dw_edma_v0_lli *)chunk->ll_region.vaddr;
+	lli = chunk->ll_region.vaddr;
 
 	if (chunk->cb)
 		control = DW_EDMA_V0_CB;
@@ -224,7 +224,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		i++;
 	}
 
-	llp = (struct dw_edma_v0_llp *)&lli[i];
+	llp = (void __iomem *)&lli[i];
 	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 5728b6fe938c..42739508c0d8 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -14,7 +14,7 @@
 #include "dw-edma-core.h"
 
 #define REGS_ADDR(name) \
-	((dma_addr_t *)&regs->name)
+	((void __force *)&regs->name)
 #define REGISTER(name) \
 	{ #name, REGS_ADDR(name) }
 
@@ -40,11 +40,11 @@
 
 static struct dentry				*base_dir;
 static struct dw_edma				*dw;
-static struct dw_edma_v0_regs			*regs;
+static struct dw_edma_v0_regs			__iomem *regs;
 
 static struct {
-	void					*start;
-	void					*end;
+	void					__iomem *start;
+	void					__iomem *end;
 } lim[2][EDMA_V0_MAX_NR_CH];
 
 struct debugfs_entries {
@@ -54,22 +54,23 @@ struct debugfs_entries {
 
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
+	void __iomem *reg = (void __force __iomem *)data;
 	if (dw->mode == EDMA_MODE_LEGACY &&
-	    data >= (void *)&regs->type.legacy.ch) {
-		void *ptr = (void *)&regs->type.legacy.ch;
+	    reg >= (void __iomem *)&regs->type.legacy.ch) {
+		void __iomem *ptr = &regs->type.legacy.ch;
 		u32 viewport_sel = 0;
 		unsigned long flags;
 		u16 ch;
 
 		for (ch = 0; ch < dw->wr_ch_cnt; ch++)
-			if (lim[0][ch].start >= data && data < lim[0][ch].end) {
-				ptr += (data - lim[0][ch].start);
+			if (lim[0][ch].start >= reg && reg < lim[0][ch].end) {
+				ptr += (reg - lim[0][ch].start);
 				goto legacy_sel_wr;
 			}
 
 		for (ch = 0; ch < dw->rd_ch_cnt; ch++)
-			if (lim[1][ch].start >= data && data < lim[1][ch].end) {
-				ptr += (data - lim[1][ch].start);
+			if (lim[1][ch].start >= reg && reg < lim[1][ch].end) {
+				ptr += (reg - lim[1][ch].start);
 				goto legacy_sel_rd;
 			}
 
@@ -86,7 +87,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
 	} else {
-		*val = readl(data);
+		*val = readl(reg);
 	}
 
 	return 0;
@@ -105,7 +106,7 @@ static void dw_edma_debugfs_create_x32(const struct debugfs_entries entries[],
 	}
 }
 
-static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs *regs,
+static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 				    struct dentry *dir)
 {
 	int nr_entries;
@@ -288,7 +289,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!dw)
 		return;
 
-	regs = (struct dw_edma_v0_regs *)dw->rg_region.vaddr;
+	regs = dw->rg_region.vaddr;
 	if (!regs)
 		return;
 
-- 
2.20.0

