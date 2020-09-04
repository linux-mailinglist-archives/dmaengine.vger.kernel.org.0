Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9AE25D5AA
	for <lists+dmaengine@lfdr.de>; Fri,  4 Sep 2020 12:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgIDKH1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Sep 2020 06:07:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:2059 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDKH0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 4 Sep 2020 06:07:26 -0400
IronPort-SDR: Y7q5KaWfayvJjG61D7tZvLiMdS3wJeYIElQTNTPqJ7E89mJIwwzyEsEwT2ZX7ijjzvfmlvOe4P
 /84L9bwmySCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="158697577"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="158697577"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 03:07:26 -0700
IronPort-SDR: KnAzlR9mPhkMehLOUz3l6m0BcGZeqLbGjTTuYGzmmVGCmw0d7LmjhbhChpKcP0ynuSNQeNDHgo
 2bkvnx20jQVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="342143672"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com) ([10.221.118.135])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2020 03:07:22 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     <dmaengine@vger.kernel.org>
Cc:     <vkoul@kernel.org>, <Eugeniy.Paltsev@synopsys.com>,
        <andriy.shevchenko@intel.com>, <jee.heng.sia@intel.com>
Subject: [PATCH 3/4] dmaengine: dw-axi-dmac: move dma_pool_create() to alloc_chan_resources()
Date:   Fri,  4 Sep 2020 17:51:33 +0800
Message-Id: <1599213094-30144-4-git-send-email-jee.heng.sia@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1599213094-30144-1-git-send-email-jee.heng.sia@intel.com>
References: <1599213094-30144-1-git-send-email-jee.heng.sia@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA memory block is created at driver load time and exist for
device lifetime. Move the dma_pool_create() to the ->chan_resource()
callback function allowing the DMA memory blocks to be created as needed
and destroyed when the channel is freed.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Shevchenko, Andriy <andriy.shevchenko@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 24 +++++++++++++-----------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8cfd645..46e2ba9 100644
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
index 41e775e..f886b2b 100644
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
1.9.1

