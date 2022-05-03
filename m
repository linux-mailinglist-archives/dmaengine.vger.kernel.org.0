Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24375191FB
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiECXEq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243742AbiECXED (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73D4E6412
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:25 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B2EA8C06;
        Wed,  4 May 2022 01:52:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru B2EA8C06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618324;
        bh=L/ijhvq/jFe/mifKkaYDmhw4Yb3oJDxQ883Lx2E1faI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=aZAv1IH/aur7KOqOZ2IejN/mXKx1yl3u5YqQ7NlxF9hKLs0h4gq1XzeEmyLXmk9iN
         O3zNBUdj5CASBspFKu5pBWBa/23jb0GqkHLt0Gc0dSFe+btSyoY1iEDXdSDcxjqMyr
         VP3hpFi6oUx7iB/TZkol8BEzsyjsgo1y8McrUiAE=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:30 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 18/26] dmaengine: dw-edma: Join Write/Read channels into a single device
Date:   Wed, 4 May 2022 01:50:56 +0300
Message-ID: <20220503225104.12108-19-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Indeed there is no point in such split up because due to multiple reasons.
First of all eDMA read and write channels belong to one physical
controller. Splitting them up illogical. Secondly the channels
differentiating can be done by means of the filtering and the
dma_get_slave_caps() method. Finally having these channels handled
separately not only needlessly complicates the code, but also causes the
DebugFS error printed to console:

>> Debugfs: Directory '1f052000.pcie' with parent 'dmaengine' already present!

So to speak let's join the read/write channels into a single DMA device.
The client drivers will be able to choose the channel with required
capability by getting the DMA slave direction setting. It's default value
is overridden by the dw_edma_device_caps() callback in accordance with the
channel nature.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 116 +++++++++++++++--------------
 drivers/dma/dw-edma/dw-edma-core.h |   5 +-
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e9cb3056b6b7..f5124e7b50cf 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -209,6 +209,24 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 	desc->chunks_alloc--;
 }
 
+static void dw_edma_device_caps(struct dma_chan *dchan,
+				struct dma_slave_caps *caps)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		if (chan->dir == EDMA_DIR_READ)
+			caps->directions = BIT(DMA_DEV_TO_MEM);
+		else
+			caps->directions = BIT(DMA_MEM_TO_DEV);
+	} else {
+		if (chan->dir == EDMA_DIR_WRITE)
+			caps->directions = BIT(DMA_DEV_TO_MEM);
+		else
+			caps->directions = BIT(DMA_MEM_TO_DEV);
+	}
+}
+
 static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
@@ -723,8 +741,7 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 	pm_runtime_put(chan->dw->chip->dev);
 }
 
-static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
-				 u32 wr_alloc, u32 rd_alloc)
+static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
 	struct dw_edma_region *dt_region;
@@ -732,27 +749,15 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 	struct dw_edma_chan *chan;
 	struct dw_edma_irq *irq;
 	struct dma_device *dma;
-	u32 alloc, off_alloc;
-	u32 i, j, cnt;
-	int err = 0;
+	u32 i, ch_cnt;
 	u32 pos;
 
-	if (write) {
-		i = 0;
-		cnt = dw->wr_ch_cnt;
-		dma = &dw->wr_edma;
-		alloc = wr_alloc;
-		off_alloc = 0;
-	} else {
-		i = dw->wr_ch_cnt;
-		cnt = dw->rd_ch_cnt;
-		dma = &dw->rd_edma;
-		alloc = rd_alloc;
-		off_alloc = wr_alloc;
-	}
+	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
+	dma = &dw->dma;
 
 	INIT_LIST_HEAD(&dma->channels);
-	for (j = 0; (alloc || dw->nr_irqs == 1) && j < cnt; j++, i++) {
+
+	for (i = 0; i < ch_cnt; i++) {
 		chan = &dw->chan[i];
 
 		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
@@ -762,52 +767,62 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 		chan->vc.chan.private = dt_region;
 
 		chan->dw = dw;
-		chan->id = j;
-		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
+
+		if (i < dw->wr_ch_cnt) {
+			chan->id = i;
+			chan->dir = EDMA_DIR_WRITE;
+		} else {
+			chan->id = i - dw->wr_ch_cnt;
+			chan->dir = EDMA_DIR_READ;
+		}
+
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
 
-		if (write)
-			chan->ll_max = (chip->ll_region_wr[j].sz / EDMA_LL_SZ);
+		if (chan->dir == EDMA_DIR_WRITE)
+			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
 		else
-			chan->ll_max = (chip->ll_region_rd[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
 		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
-			 write ? "write" : "read", j, chan->ll_max);
+			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
+			 chan->id, chan->ll_max);
 
 		if (dw->nr_irqs == 1)
 			pos = 0;
+		else if (chan->dir == EDMA_DIR_WRITE)
+			pos = chan->id % wr_alloc;
 		else
-			pos = off_alloc + (j % alloc);
+			pos = wr_alloc + chan->id % rd_alloc;
 
 		irq = &dw->irq[pos];
 
-		if (write)
-			irq->wr_mask |= BIT(j);
+		if (chan->dir == EDMA_DIR_WRITE)
+			irq->wr_mask |= BIT(chan->id);
 		else
-			irq->rd_mask |= BIT(j);
+			irq->rd_mask |= BIT(chan->id);
 
 		irq->dw = dw;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
-			 write ? "write" : "read", j,
+			 chan->dir == EDMA_DIR_WRITE  ? "write" : "read", chan->id,
 			 chan->msi.address_hi, chan->msi.address_lo,
 			 chan->msi.data);
 
 		chan->vc.desc_free = vchan_free_desc;
 		vchan_init(&chan->vc, dma);
 
-		if (write) {
-			dt_region->paddr = chip->dt_region_wr[j].paddr;
-			dt_region->vaddr = chip->dt_region_wr[j].vaddr;
-			dt_region->sz = chip->dt_region_wr[j].sz;
+		if (chan->dir == EDMA_DIR_WRITE) {
+			dt_region->paddr = chip->dt_region_wr[chan->id].paddr;
+			dt_region->vaddr = chip->dt_region_wr[chan->id].vaddr;
+			dt_region->sz = chip->dt_region_wr[chan->id].sz;
 		} else {
-			dt_region->paddr = chip->dt_region_rd[j].paddr;
-			dt_region->vaddr = chip->dt_region_rd[j].vaddr;
-			dt_region->sz = chip->dt_region_rd[j].sz;
+			dt_region->paddr = chip->dt_region_rd[chan->id].paddr;
+			dt_region->vaddr = chip->dt_region_rd[chan->id].vaddr;
+			dt_region->sz = chip->dt_region_rd[chan->id].sz;
 		}
 
 		dw_edma_v0_core_device_config(chan);
@@ -819,7 +834,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
 	dma_cap_set(DMA_INTERLEAVE, dma->cap_mask);
-	dma->directions = BIT(write ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV);
+	dma->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
@@ -828,6 +843,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 	dma->dev = chip->dev;
 	dma->device_alloc_chan_resources = dw_edma_alloc_chan_resources;
 	dma->device_free_chan_resources = dw_edma_free_chan_resources;
+	dma->device_caps = dw_edma_device_caps;
 	dma->device_config = dw_edma_device_config;
 	dma->device_pause = dw_edma_device_pause;
 	dma->device_resume = dw_edma_device_resume;
@@ -841,9 +857,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 	dma_set_max_seg_size(dma->dev, U32_MAX);
 
 	/* Register DMA device */
-	err = dma_async_device_register(dma);
-
-	return err;
+	return dma_async_device_register(dma);
 }
 
 static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
@@ -988,13 +1002,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (err)
 		return err;
 
-	/* Setup write channels */
-	err = dw_edma_channel_setup(dw, true, wr_alloc, rd_alloc);
-	if (err)
-		goto err_irq_free;
-
-	/* Setup read channels */
-	err = dw_edma_channel_setup(dw, false, wr_alloc, rd_alloc);
+	/* Setup write/read channels */
+	err = dw_edma_channel_setup(dw, wr_alloc, rd_alloc);
 	if (err)
 		goto err_irq_free;
 
@@ -1034,15 +1043,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	pm_runtime_disable(dev);
 
 	/* Deregister eDMA device */
-	dma_async_device_unregister(&dw->wr_edma);
-	list_for_each_entry_safe(chan, _chan, &dw->wr_edma.channels,
-				 vc.chan.device_node) {
-		tasklet_kill(&chan->vc.task);
-		list_del(&chan->vc.chan.device_node);
-	}
-
-	dma_async_device_unregister(&dw->rd_edma);
-	list_for_each_entry_safe(chan, _chan, &dw->rd_edma.channels,
+	dma_async_device_unregister(&dw->dma);
+	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
 				 vc.chan.device_node) {
 		tasklet_kill(&chan->vc.task);
 		list_del(&chan->vc.chan.device_node);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 85df2d511907..b576a8fff45a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -98,10 +98,9 @@ struct dw_edma_irq {
 struct dw_edma {
 	char				name[20];
 
-	struct dma_device		wr_edma;
-	u16				wr_ch_cnt;
+	struct dma_device		dma;
 
-	struct dma_device		rd_edma;
+	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
 
 	struct dw_edma_irq		*irq;
-- 
2.35.1

