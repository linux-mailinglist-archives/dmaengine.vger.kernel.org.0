Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185CD55FC09
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 11:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiF2Jaa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiF2JaT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 05:30:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 606133A187;
        Wed, 29 Jun 2022 02:30:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 678C91477;
        Wed, 29 Jun 2022 02:30:16 -0700 (PDT)
Received: from usa.arm.com (unknown [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E4C23F792;
        Wed, 29 Jun 2022 02:30:14 -0700 (PDT)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Vivek Gautam <vivek.gautam@arm.com>
Subject: [PATCH] dmaengine: pl330: Set DMA_INTERRUPT capability and add related callback
Date:   Wed, 29 Jun 2022 15:00:03 +0530
Message-Id: <20220629093003.19440-1-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the verification for DMA_INTERRUPT capability added to the dmatest
module, the dmatest fails to start for various channels of pl330 dma
controller. So, set the DMA_INTERRUPT capability and add the required
callback method to set the transaction descriptor flags.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/dma/pl330.c | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 858400e42ec0..b80e48f0970b 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2757,6 +2757,28 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 	return &desc->txd;
 }
 
+static struct dma_async_tx_descriptor *
+pl330_dma_prep_interrupt(struct dma_chan *chan, unsigned long flags)
+{
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	struct dma_pl330_desc *desc;
+
+	if (unlikely(!pch))
+		return NULL;
+
+	desc = pl330_get_desc(pch);
+	if (!desc) {
+		dev_err(pch->dmac->ddma.dev, "%s:%d Unable to fetch desc\n",
+			__func__, __LINE__);
+		return NULL;
+	}
+
+	/* Set the flags that are passed downstream */
+	desc->txd.flags = flags;
+
+	return &desc->txd;
+}
+
 static struct dma_async_tx_descriptor *
 pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 		dma_addr_t src, size_t len, unsigned long flags)
@@ -3111,6 +3133,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	dma_cap_set(DMA_MEMCPY, pd->cap_mask);
+	dma_cap_set(DMA_INTERRUPT, pd->cap_mask);
 	if (pcfg->num_peri) {
 		dma_cap_set(DMA_SLAVE, pd->cap_mask);
 		dma_cap_set(DMA_CYCLIC, pd->cap_mask);
@@ -3121,6 +3144,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_free_chan_resources = pl330_free_chan_resources;
 	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
 	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
+	pd->device_prep_dma_interrupt = pl330_dma_prep_interrupt;
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
 	pd->device_config = pl330_config;
-- 
2.17.1

