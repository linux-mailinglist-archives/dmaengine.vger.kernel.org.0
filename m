Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505852B01BE
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 10:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgKLJIM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 04:08:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:52954 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbgKLJG2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Nov 2020 04:06:28 -0500
IronPort-SDR: texm07aLpBqAmYZhx1l0UYvBk7jfWIios1ilNZMZlnmvULn+hd3UTfhqhINYyHMLlJOretI+m1
 7pPm14vxo0hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="166773021"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="166773021"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 01:06:27 -0800
IronPort-SDR: 06d0hxJv8HH5xxknkF202v3LNOzLbBFI1iHHIrqO5K4TE/h3PQyEOCjGw68Ik99cqC9R6Zgcmj
 Pl+x0YlHs0/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="360911500"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2020 01:06:22 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 03/15] dmaengine: dw-axi-dmac: move dma_pool_create() to alloc_chan_resources()
Date:   Thu, 12 Nov 2020 16:49:41 +0800
Message-Id: <20201112084953.21629-4-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201112084953.21629-1-jee.heng.sia@intel.com>
References: <20201112084953.21629-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA memory block is created at driver load time and exist for
device lifetime. Move the dma_pool_create() to the ->chan_resource()
callback function allowing the DMA memory blocks to be created as needed
and destroyed when the channel is freed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 24 ++++++++++---------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8cfd645479e1..46e2ba978e20 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -216,11 +216,10 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 static struct axi_dma_lli *axi_desc_get(struct axi_dma_chan *chan,
 					dma_addr_t *addr)
 {
-	struct dw_axi_dma *dw = chan->chip->dw;
 	struct axi_dma_lli *lli;
 	dma_addr_t phys;
 
-	lli = dma_pool_zalloc(dw->desc_pool, GFP_NOWAIT, &phys);
+	lli = dma_pool_zalloc(chan->desc_pool, GFP_NOWAIT, &phys);
 	if (unlikely(!lli)) {
 		dev_err(chan2dev(chan), "%s: not enough descriptors available\n",
 			axi_chan_name(chan));
@@ -236,14 +235,13 @@ static struct axi_dma_lli *axi_desc_get(struct axi_dma_chan *chan,
 static void axi_desc_put(struct axi_dma_desc *desc)
 {
 	struct axi_dma_chan *chan = desc->chan;
-	struct dw_axi_dma *dw = chan->chip->dw;
 	int count = atomic_read(&chan->descs_allocated);
 	struct axi_dma_hw_desc *hw_desc;
 	int descs_put;
 
 	for (descs_put = 0; descs_put < count; descs_put++) {
 		hw_desc = &desc->hw_desc[descs_put];
-		dma_pool_free(dw->desc_pool, hw_desc->lli, hw_desc->llp);
+		dma_pool_free(chan->desc_pool, hw_desc->lli, hw_desc->llp);
 	}
 
 	kfree(desc->hw_desc);
@@ -360,6 +358,15 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 		return -EBUSY;
 	}
 
+	/* LLI address must be aligned to a 64-byte boundary */
+	chan->desc_pool = dma_pool_create(dev_name(chan2dev(chan)),
+					  chan->chip->dev,
+					  sizeof(struct axi_dma_lli),
+					  64, 0);
+	if (!chan->desc_pool) {
+		dev_err(chan2dev(chan), "No memory for descriptors\n");
+		return -ENOMEM;
+	}
 	dev_vdbg(dchan2dev(dchan), "%s: allocating\n", axi_chan_name(chan));
 
 	pm_runtime_get(chan->chip->dev);
@@ -381,6 +388,8 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
 
 	vchan_free_chan_resources(&chan->vc);
 
+	dma_pool_destroy(chan->desc_pool);
+	chan->desc_pool = NULL;
 	dev_vdbg(dchan2dev(dchan),
 		 "%s: free resources, descriptor still allocated: %u\n",
 		 axi_chan_name(chan), atomic_read(&chan->descs_allocated));
@@ -896,13 +905,6 @@ static int dw_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Lli address must be aligned to a 64-byte boundary */
-	dw->desc_pool = dmam_pool_create(KBUILD_MODNAME, chip->dev,
-					 sizeof(struct axi_dma_lli), 64, 0);
-	if (!dw->desc_pool) {
-		dev_err(chip->dev, "No memory for descriptors dma pool\n");
-		return -ENOMEM;
-	}
 
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 41e775e6e593..f886b2bb75de 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -39,6 +39,7 @@ struct axi_dma_chan {
 	u8				id;
 	atomic_t			descs_allocated;
 
+	struct dma_pool			*desc_pool;
 	struct virt_dma_chan		vc;
 
 	struct axi_dma_desc		*desc;
@@ -49,7 +50,6 @@ struct axi_dma_chan {
 struct dw_axi_dma {
 	struct dma_device	dma;
 	struct dw_axi_dma_hcfg	*hdata;
-	struct dma_pool		*desc_pool;
 
 	/* channels */
 	struct axi_dma_chan	*chan;
-- 
2.18.0

