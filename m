Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB4C3186FD
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 10:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBKJVP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 04:21:15 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34190 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230111AbhBKJOM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 04:14:12 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9738640172;
        Thu, 11 Feb 2021 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034784; bh=/npzSvZB4HZzjtUB6OV9ITNpRJsW973D7sOEIOFQQAM=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=KZFSix9+L/hjRmNILFlYQWip2L1DnwKhyjwzYouFpXa6BXejMnhjkLQtknpyuX7dX
         ohr6puu8+jZmOdl/Bdg33o0E2vSL9pKOPDxfHPR37UINUGMYDzU5GVTwXJ3o56bX0C
         hwZpKv47i7bVLyDs8riyFKgYc8SP6HmhHVYEN6BUyw8uBDPqg86s50DTxqxaw+7zOH
         ItDDyyAkWj6w5L1dbITp89TyzaWhMV5SY2JpthPhsXbdDSqsZT0kBZfVPLH7ojfEJK
         Fu+AqQIFT9ikVVTyHqpiVY1oNigrMIFTbXfUJA6w+DjAumCQplUOhJIiX0yhStIrwz
         x94/plvk9mFtA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6E0AAA005D;
        Thu, 11 Feb 2021 09:13:03 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 09/15] dmaengine: dw-edma: Improve the linked list and data blocks definition
Date:   Thu, 11 Feb 2021 10:12:42 +0100
Message-Id: <52812d20d0624b36b92785517b2b61ae9b6cc1ed.1613034728.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the previous implementation the driver assumes that only existed 2
memory spaces that would be equal distributed amount the write/read
channels.

This might not be the case on some other implementations, therefore this
patches changes this requirement so that each write/read channel has
their own linked list and data space well defined, which allows
different sizes and locations.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-core.c |  51 +++++-----
 drivers/dma/dw-edma/dw-edma-core.h |   9 +-
 drivers/dma/dw-edma/dw-edma-pcie.c | 185 ++++++++++++++++++++++++++-----------
 3 files changed, 160 insertions(+), 85 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 5495cf7..48887b5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -81,8 +81,13 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	chunk->ll_region.paddr = dw->ll_region.paddr + chan->ll_off;
-	chunk->ll_region.vaddr = dw->ll_region.vaddr + chan->ll_off;
+	if (chan->dir == EDMA_DIR_WRITE) {
+		chunk->ll_region.paddr = dw->ll_region_wr[chan->id].paddr;
+		chunk->ll_region.vaddr = dw->ll_region_wr[chan->id].vaddr;
+	} else {
+		chunk->ll_region.paddr = dw->ll_region_rd[chan->id].paddr;
+		chunk->ll_region.vaddr = dw->ll_region_rd[chan->id].vaddr;
+	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -691,24 +696,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 	struct device *dev = chip->dev;
 	struct dw_edma *dw = chip->dw;
 	struct dw_edma_chan *chan;
-	size_t ll_chunk, dt_chunk;
 	struct dw_edma_irq *irq;
 	struct dma_device *dma;
-	u32 i, j, cnt, ch_cnt;
 	u32 alloc, off_alloc;
+	u32 i, j, cnt;
 	int err = 0;
 	u32 pos;
 
-	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
-	ll_chunk = dw->ll_region.sz;
-	dt_chunk = dw->dt_region.sz;
-
-	/* Calculate linked list chunk for each channel */
-	ll_chunk /= roundup_pow_of_two(ch_cnt);
-
-	/* Calculate linked list chunk for each channel */
-	dt_chunk /= roundup_pow_of_two(ch_cnt);
-
 	if (write) {
 		i = 0;
 		cnt = dw->wr_ch_cnt;
@@ -740,14 +734,14 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
 
-		chan->ll_off = (ll_chunk * i);
-		chan->ll_max = (ll_chunk / EDMA_LL_SZ) - 1;
-
-		chan->dt_off = (dt_chunk * i);
+		if (write)
+			chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
+		else
+			chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
+		chan->ll_max -= 1;
 
-		dev_vdbg(dev, "L. List:\tChannel %s[%u] off=0x%.8lx, max_cnt=%u\n",
-			 write ? "write" : "read", j,
-			 chan->ll_off, chan->ll_max);
+		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
+			 write ? "write" : "read", j, chan->ll_max);
 
 		if (dw->nr_irqs == 1)
 			pos = 0;
@@ -772,12 +766,15 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->vc.desc_free = vchan_free_desc;
 		vchan_init(&chan->vc, dma);
 
-		dt_region->paddr = dw->dt_region.paddr + chan->dt_off;
-		dt_region->vaddr = dw->dt_region.vaddr + chan->dt_off;
-		dt_region->sz = dt_chunk;
-
-		dev_vdbg(dev, "Data:\tChannel %s[%u] off=0x%.8lx\n",
-			 write ? "write" : "read", j, chan->dt_off);
+		if (write) {
+			dt_region->paddr = dw->dt_region_wr[j].paddr;
+			dt_region->vaddr = dw->dt_region_wr[j].vaddr;
+			dt_region->sz = dw->dt_region_wr[j].sz;
+		} else {
+			dt_region->paddr = dw->dt_region_rd[j].paddr;
+			dt_region->vaddr = dw->dt_region_rd[j].vaddr;
+			dt_region->sz = dw->dt_region_rd[j].sz;
+		}
 
 		dw_edma_v0_core_device_config(chan);
 	}
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 650b1c7..cba5436 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -91,11 +91,8 @@ struct dw_edma_chan {
 	int				id;
 	enum dw_edma_dir		dir;
 
-	off_t				ll_off;
 	u32				ll_max;
 
-	off_t				dt_off;
-
 	struct msi_msg			msi;
 
 	enum dw_edma_request		request;
@@ -126,8 +123,10 @@ struct dw_edma {
 	u16				rd_ch_cnt;
 
 	struct dw_edma_region		rg_region;	/* Registers */
-	struct dw_edma_region		ll_region;	/* Linked list */
-	struct dw_edma_region		dt_region;	/* Data */
+	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
+	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
 
 	struct dw_edma_irq		*irq;
 	int				nr_irqs;
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 9e79eb5..a0fa809 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -23,19 +23,28 @@
 #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
 #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
 
+#define DW_BLOCK(a, b, c) \
+	{ \
+		.bar = a, \
+		.off = b, \
+		.sz = c, \
+	},
+
+struct dw_edma_block {
+	enum pci_barno			bar;
+	off_t				off;
+	size_t				sz;
+};
+
 struct dw_edma_pcie_data {
 	/* eDMA registers location */
-	enum pci_barno			rg_bar;
-	off_t				rg_off;
-	size_t				rg_sz;
+	struct dw_edma_block		rg;
 	/* eDMA memory linked list location */
-	enum pci_barno			ll_bar;
-	off_t				ll_off;
-	size_t				ll_sz;
+	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
 	/* eDMA memory data location */
-	enum pci_barno			dt_bar;
-	off_t				dt_off;
-	size_t				dt_sz;
+	struct dw_edma_block		dt_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_block		dt_rd[EDMA_MAX_RD_CH];
 	/* Other */
 	enum dw_edma_map_format		mf;
 	u8				irqs;
@@ -45,22 +54,40 @@ struct dw_edma_pcie_data {
 
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
-	.rg_bar				= BAR_0,
-	.rg_off				= 0x00001000,	/*  4 Kbytes */
-	.rg_sz				= 0x00002000,	/*  8 Kbytes */
+	.rg.bar				= BAR_0,
+	.rg.off				= 0x00001000,	/*  4 Kbytes */
+	.rg.sz				= 0x00002000,	/*  8 Kbytes */
 	/* eDMA memory linked list location */
-	.ll_bar				= BAR_2,
-	.ll_off				= 0x00000000,	/*  0 Kbytes */
-	.ll_sz				= 0x00800000,	/*  8 Mbytes */
+	.ll_wr = {
+		/* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Mbytes */
+		DW_BLOCK(BAR_2, 0x00000000, 0x00200000)
+		/* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Mbytes */
+		DW_BLOCK(BAR_2, 0x00200000, 0x00200000)
+	},
+	.ll_rd = {
+		/* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Mbytes */
+		DW_BLOCK(BAR_2, 0x00400000, 0x00200000)
+		/* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Mbytes */
+		DW_BLOCK(BAR_2, 0x00600000, 0x00200000)
+	},
 	/* eDMA memory data location */
-	.dt_bar				= BAR_2,
-	.dt_off				= 0x00800000,	/*  8 Mbytes */
-	.dt_sz				= 0x03800000,	/* 56 Mbytes */
+	.dt_wr = {
+		/* Channel 0 - BAR 2, offset 8 Mbytes, size 14 Mbytes */
+		DW_BLOCK(BAR_2, 0x00800000, 0x00e00000)
+		/* Channel 1 - BAR 2, offset 22 Mbytes, size 14 Mbytes */
+		DW_BLOCK(BAR_2, 0x01600000, 0x00e00000)
+	},
+	.dt_rd = {
+		/* Channel 0 - BAR 2, offset 36 Mbytes, size 14 Mbytes */
+		DW_BLOCK(BAR_2, 0x02400000, 0x00e00000)
+		/* Channel 1 - BAR 2, offset 50 Mbytes, size 14 Mbytes */
+		DW_BLOCK(BAR_2, 0x03200000, 0x00e00000)
+	},
 	/* Other */
 	.mf				= EDMA_MF_EDMA_UNROLL,
 	.irqs				= 1,
-	.wr_ch_cnt			= 0,
-	.rd_ch_cnt			= 0,
+	.wr_ch_cnt			= 2,
+	.rd_ch_cnt			= 2,
 };
 
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
@@ -96,18 +123,20 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 		return;
 
 	pdata->mf = map;
-	pdata->rg_bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
+	pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
 
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
-	pdata->wr_ch_cnt = FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val);
-	pdata->rd_ch_cnt = FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
+				 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
+				 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
 
 	pci_read_config_dword(pdev, vsec + 0x14, &val);
 	off = val;
 	pci_read_config_dword(pdev, vsec + 0x10, &val);
 	off <<= 32;
 	off |= val;
-	pdata->rg_off = off;
+	pdata->rg.off = off;
 }
 
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
@@ -119,6 +148,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	struct dw_edma *dw;
 	int err, nr_irqs;
+	int i, mask;
 
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
@@ -136,10 +166,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	dw_edma_pcie_get_vsec_dma_data(pdev, &vsec_data);
 
 	/* Mapping PCI BAR regions */
-	err = pcim_iomap_regions(pdev, BIT(vsec_data.rg_bar) |
-				       BIT(vsec_data.ll_bar) |
-				       BIT(vsec_data.dt_bar),
-				 pci_name(pdev));
+	mask = BIT(vsec_data.rg.bar);
+	for (i = 0; i < vsec_data.wr_ch_cnt; i++) {
+		mask |= BIT(vsec_data.ll_wr[i].bar);
+		mask |= BIT(vsec_data.dt_wr[i].bar);
+	}
+	for (i = 0; i < vsec_data.rd_ch_cnt; i++) {
+		mask |= BIT(vsec_data.ll_rd[i].bar);
+		mask |= BIT(vsec_data.dt_rd[i].bar);
+	}
+	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
 		pci_err(pdev, "eDMA BAR I/O remapping failed\n");
 		return err;
@@ -195,30 +231,56 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->id = pdev->devfn;
 	chip->irq = pdev->irq;
 
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg_bar];
-	dw->rg_region.vaddr += vsec_data.rg_off;
-	dw->rg_region.paddr = pdev->resource[vsec_data.rg_bar].start;
-	dw->rg_region.paddr += vsec_data.rg_off;
-	dw->rg_region.sz = vsec_data.rg_sz;
-
-	dw->ll_region.vaddr = pcim_iomap_table(pdev)[vsec_data.ll_bar];
-	dw->ll_region.vaddr += vsec_data.ll_off;
-	dw->ll_region.paddr = pdev->resource[vsec_data.ll_bar].start;
-	dw->ll_region.paddr += vsec_data.ll_off;
-	dw->ll_region.sz = vsec_data.ll_sz;
-
-	dw->dt_region.vaddr = pcim_iomap_table(pdev)[vsec_data.dt_bar];
-	dw->dt_region.vaddr += vsec_data.dt_off;
-	dw->dt_region.paddr = pdev->resource[vsec_data.dt_bar].start;
-	dw->dt_region.paddr += vsec_data.dt_off;
-	dw->dt_region.sz = vsec_data.dt_sz;
-
 	dw->mf = vsec_data.mf;
 	dw->nr_irqs = nr_irqs;
 	dw->ops = &dw_edma_pcie_core_ops;
 	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
 	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	dw->rg_region.vaddr += vsec_data.rg.off;
+	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
+	dw->rg_region.paddr += vsec_data.rg.off;
+	dw->rg_region.sz = vsec_data.rg.sz;
+
+	for (i = 0; i < dw->wr_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
+		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
+		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
+		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
+
+		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
+		ll_region->vaddr += ll_block->off;
+		ll_region->paddr = pdev->resource[ll_block->bar].start;
+		ll_region->paddr += ll_block->off;
+		ll_region->sz = ll_block->sz;
+
+		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
+		dt_region->vaddr += dt_block->off;
+		dt_region->paddr = pdev->resource[dt_block->bar].start;
+		dt_region->paddr += dt_block->off;
+		dt_region->sz = dt_block->sz;
+	}
+
+	for (i = 0; i < dw->rd_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
+		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
+		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
+		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
+
+		ll_region->vaddr = pcim_iomap_table(pdev)[ll_block->bar];
+		ll_region->vaddr += ll_block->off;
+		ll_region->paddr = pdev->resource[ll_block->bar].start;
+		ll_region->paddr += ll_block->off;
+		ll_region->sz = ll_block->sz;
+
+		dt_region->vaddr = pcim_iomap_table(pdev)[dt_block->bar];
+		dt_region->vaddr += dt_block->off;
+		dt_region->paddr = pdev->resource[dt_block->bar].start;
+		dt_region->paddr += dt_block->off;
+		dt_region->sz = dt_block->sz;
+	}
+
 	/* Debug info */
 	if (dw->mf == EDMA_MF_EDMA_LEGACY)
 		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
@@ -230,16 +292,33 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		vsec_data.rg_bar, vsec_data.rg_off, vsec_data.rg_sz,
+		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
 		dw->rg_region.vaddr, &dw->rg_region.paddr);
 
-	pci_dbg(pdev, "L. List:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		vsec_data.ll_bar, vsec_data.ll_off, vsec_data.ll_sz,
-		dw->ll_region.vaddr, &dw->ll_region.paddr);
 
-	pci_dbg(pdev, "Data:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-		vsec_data.dt_bar, vsec_data.dt_off, vsec_data.dt_sz,
-		dw->dt_region.vaddr, &dw->dt_region.paddr);
+	for (i = 0; i < dw->wr_ch_cnt; i++) {
+		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+			i, vsec_data.ll_wr[i].bar,
+			vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
+			dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
+
+		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+			i, vsec_data.dt_wr[i].bar,
+			vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
+			dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
+	}
+
+	for (i = 0; i < dw->rd_ch_cnt; i++) {
+		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+			i, vsec_data.ll_rd[i].bar,
+			vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
+			dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
+
+		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+			i, vsec_data.dt_rd[i].bar,
+			vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
+			dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
+	}
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
 
-- 
2.7.4

