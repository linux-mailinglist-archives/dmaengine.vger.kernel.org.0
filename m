Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21F66A096
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjAMRYv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 12:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjAMRX6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 12:23:58 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B73AAA4C76;
        Fri, 13 Jan 2023 09:14:46 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0CC5EE0F2E;
        Fri, 13 Jan 2023 20:14:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=xwrX2CJwXgu9NK+0jPpfr/nr+KNd7GkCfwDXnZ+Uokg=; b=PXj6idbH/IvY
        xuffg7gBsbIitzLYe/VnAVqneU7Oj1Zqxa4PJQ8NMfWgbCNdriWWUkqK6+VEo5BQ
        qmkcg2SW3dtE92bRnvnc/9jb0EAsuE7tBaTBRLLQH7ispUWRoHRdFSDXTC2X8xni
        qyOzTPGqge+5jfyAyEmoYYCZkSfBch8=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id E1432E0F13;
        Fri, 13 Jan 2023 20:14:36 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 20:14:36 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 23/27] dmaengine: dw-edma: Add mem-mapped LL-entries support
Date:   Fri, 13 Jan 2023 20:14:05 +0300
Message-ID: <20230113171409.30470-24-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.26]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently the DW eDMA driver only supports the linked lists memory
allocated locally with respect to the remote eDMA engine setup. It means
the linked lists will be accessible by the CPU via the MMIO space only. If
eDMA is embedded into the DW PCIe Root Ports or local End-points (which
support will be added in one of the following up commits) the linked lists
are supposed to be allocated in the CPU memory. In that case the
LL-entries can be directly accessed meanwhile the former case implies
using the MMIO-accessors for that.

In order to have both cases supported by the driver the dw_edma_region
descriptor should be fixed to contain the MMIO-backed and just
memory-based virtual addresses. The linked lists initialization procedure
will use one of them depending on the eDMA device nature. If the eDMA
engine is embedded into the local DW PCIe RP/EP controllers then the list
entries will be directly accessed by referencing the corresponding
structure fields.  Otherwise the MMIO accessors usage will be preserved.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v9:
- This is a new patch added on v9 stage of the series.
---
 drivers/dma/dw-edma/dw-edma-pcie.c    | 32 ++++++-------
 drivers/dma/dw-edma/dw-edma-v0-core.c | 69 +++++++++++++++++----------
 include/linux/dma/edma.h              |  5 +-
 3 files changed, 64 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3f9dadc73854..2b40f2b44f5e 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -240,20 +240,20 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
 
-		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
-		if (!ll_region->vaddr)
+		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
+		if (!ll_region->vaddr.io)
 			return -ENOMEM;
 
-		ll_region->vaddr += ll_block->off;
+		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
-		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
-		if (!dt_region->vaddr)
+		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
+		if (!dt_region->vaddr.io)
 			return -ENOMEM;
 
-		dt_region->vaddr += dt_block->off;
+		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
@@ -265,20 +265,20 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
 
-		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
-		if (!ll_region->vaddr)
+		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
+		if (!ll_region->vaddr.io)
 			return -ENOMEM;
 
-		ll_region->vaddr += ll_block->off;
+		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
-		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
-		if (!dt_region->vaddr)
+		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
+		if (!dt_region->vaddr.io)
 			return -ENOMEM;
 
-		dt_region->vaddr += dt_block->off;
+		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
@@ -303,24 +303,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_wr[i].bar,
 			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
-			chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
+			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_wr[i].bar,
 			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
-			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
+			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
 	}
 
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_rd[i].bar,
 			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
-			chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
+			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_rd[i].bar,
 			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
-			chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
+			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
 	}
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 51a34b43434c..7df833873a19 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -159,9 +159,6 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define GET_CH_32(dw, dir, ch, name) \
 	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
 
-#define SET_LL_32(ll, value) \
-	writel(value, ll)
-
 static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u64 value, void __iomem *addr)
 {
@@ -219,9 +216,6 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define GET_CH_64(dw, dir, ch, name) \
 	readq_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
 
-#define SET_LL_64(ll, value) \
-	writeq(value, ll)
-
 /* eDMA management callbacks */
 void dw_edma_v0_core_off(struct dw_edma *dw)
 {
@@ -293,17 +287,53 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
 			 GET_RW_32(dw, dir, int_status));
 }
 
+static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+				     u32 control, u32 size, u64 sar, u64 dar)
+{
+	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+
+	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+
+		lli->control = control;
+		lli->transfer_size = size;
+		lli->sar.reg = sar;
+		lli->dar.reg = dar;
+	} else {
+		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+
+		writel(control, &lli->control);
+		writel(size, &lli->transfer_size);
+		writeq(sar, &lli->sar.reg);
+		writeq(dar, &lli->dar.reg);
+	}
+}
+
+static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+				     int i, u32 control, u64 pointer)
+{
+	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+
+	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+
+		llp->control = control;
+		llp->llp.reg = pointer;
+	} else {
+		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+
+		writel(control, &llp->control);
+		writeq(pointer, &llp->llp.reg);
+	}
+}
+
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_v0_lli __iomem *lli;
-	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
 	int j;
 
-	lli = chunk->ll_region.vaddr;
-
 	if (chunk->cb)
 		control = DW_EDMA_V0_CB;
 
@@ -315,27 +345,16 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
 				control |= DW_EDMA_V0_RIE;
 		}
-		/* Channel control */
-		SET_LL_32(&lli[i].control, control);
-		/* Transfer size */
-		SET_LL_32(&lli[i].transfer_size, child->sz);
-		/* SAR */
-		SET_LL_64(&lli[i].sar.reg, child->sar);
-		/* DAR */
-		SET_LL_64(&lli[i].dar.reg, child->dar);
-
-		i++;
+
+		dw_edma_v0_write_ll_data(chunk, i++, control, child->sz,
+					 child->sar, child->dar);
 	}
 
-	llp = (void __iomem *)&lli[i];
 	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	/* Channel control */
-	SET_LL_32(&llp->control, control);
-	/* Linked list */
-	SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 9d44da4aa59d..08833f12b386 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -19,7 +19,10 @@ struct dw_edma;
 
 struct dw_edma_region {
 	u64		paddr;
-	void __iomem	*vaddr;
+	union {
+		void		*mem;
+		void __iomem	*io;
+	} vaddr;
 	size_t		sz;
 };
 
-- 
2.39.0


