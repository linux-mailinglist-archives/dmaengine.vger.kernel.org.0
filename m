Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F660C793
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiJYJJW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiJYJIU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:08:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00C163399;
        Tue, 25 Oct 2022 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688688; x=1698224688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6ZLNu8tl1Rcoa3xL/hFpsXE0qPVMUTL9nFgGWuNj1M=;
  b=08dzjT7Suv1VLo2HOge4Ht3yH3u/YF2SMQAXi2fl68idrrOkX9gwPUOG
   OsvuoxI/E5Z8slaJVYtCNIZgkSO1GatFBGZHUkTpYJ+AHCzu+Bs/SQzsq
   3TrmPdXOK3DosP8RTO2/7K9b4TvJpGqoUyfm5PZoyqzt9m+hxszcN40+I
   K+Iza4PKdR52hwI8m4ZMGhA93zvIF05UEUO1PEriwAvo9vKCm0zSijQsH
   FvqkTsq61UzMGtJG+hBzVjJnKvwU/z2/pzYkHjxP/tPHPR6opptkBn3EA
   wPzdOpyhZQ6Z9oVzZf0PZuFgzhE8xy2eLYHcmpFt+EcOJuovBZdmPnBEl
   g==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="196910303"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:40 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:38 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 30/32] dmaengine: at_hdmac: Rename "chan_common" to "dma_chan"
Date:   Tue, 25 Oct 2022 12:03:04 +0300
Message-ID: <20221025090306.297886-31-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

"chan_common" was misleading and did not suggest that's actually
a struct dma_chan underneath. Rename it so that readers can follow the
code easier. One may see some checks when running checkpatch. Those have
nothing to do with the rename and will be addressed in a further patch.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 62 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index b2619600f68a..e39b9b47234a 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -252,7 +252,7 @@ enum atc_status {
 
 /**
  * struct at_dma_chan - internal representation of an Atmel HDMAC channel
- * @chan_common: common dmaengine channel object members
+ * @dma_chan: common dmaengine channel object members
  * @device: parent device
  * @ch_regs: memory mapped register base
  * @mask: channel index in a mask
@@ -272,7 +272,7 @@ enum atc_status {
  * @free_list: list of descriptors usable by the channel
  */
 struct at_dma_chan {
-	struct dma_chan		chan_common;
+	struct dma_chan		dma_chan;
 	struct at_dma		*device;
 	void __iomem		*ch_regs;
 	u8			mask;
@@ -300,7 +300,7 @@ struct at_dma_chan {
 
 static inline struct at_dma_chan *to_at_dma_chan(struct dma_chan *dchan)
 {
-	return container_of(dchan, struct at_dma_chan, chan_common);
+	return container_of(dchan, struct at_dma_chan, dma_chan);
 }
 
 /*
@@ -382,15 +382,15 @@ static struct device *chan2dev(struct dma_chan *chan)
 #if defined(VERBOSE_DEBUG)
 static void vdbg_dump_regs(struct at_dma_chan *atchan)
 {
-	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
+	struct at_dma	*atdma = to_at_dma(atchan->dma_chan.device);
 
-	dev_err(chan2dev(&atchan->chan_common),
+	dev_err(chan2dev(&atchan->dma_chan),
 		"  channel %d : imr = 0x%x, chsr = 0x%x\n",
-		atchan->chan_common.chan_id,
+		atchan->dma_chan.chan_id,
 		dma_readl(atdma, EBCIMR),
 		dma_readl(atdma, CHSR));
 
-	dev_err(chan2dev(&atchan->chan_common),
+	dev_err(chan2dev(&atchan->dma_chan),
 		"  channel: s0x%x d0x%x ctrl0x%x:0x%x cfg0x%x l0x%x\n",
 		channel_readl(atchan, SADDR),
 		channel_readl(atchan, DADDR),
@@ -405,7 +405,7 @@ static void vdbg_dump_regs(struct at_dma_chan *atchan) {}
 
 static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
 {
-	dev_crit(chan2dev(&atchan->chan_common),
+	dev_crit(chan2dev(&atchan->dma_chan),
 		 "desc: s%pad d%pad ctrl0x%x:0x%x l%pad\n",
 		 &lli->saddr, &lli->daddr,
 		 lli->ctrla, lli->ctrlb, &lli->dscr);
@@ -442,7 +442,7 @@ static void atc_disable_chan_irq(struct at_dma *atdma, int chan_id)
  */
 static inline int atc_chan_is_enabled(struct at_dma_chan *atchan)
 {
-	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
+	struct at_dma	*atdma = to_at_dma(atchan->dma_chan.device);
 
 	return !!(dma_readl(atdma, CHSR) & atchan->mask);
 }
@@ -603,16 +603,16 @@ static struct at_desc *atc_desc_get(struct at_dma_chan *atchan)
 			ret = desc;
 			break;
 		}
-		dev_dbg(chan2dev(&atchan->chan_common),
+		dev_dbg(chan2dev(&atchan->dma_chan),
 				"desc %p not ACKed\n", desc);
 	}
 	spin_unlock_irqrestore(&atchan->lock, flags);
-	dev_vdbg(chan2dev(&atchan->chan_common),
+	dev_vdbg(chan2dev(&atchan->dma_chan),
 		"scanned %u descriptors on freelist\n", i);
 
 	/* no more descriptor available in initial pool: create one more */
 	if (!ret)
-		ret = atc_alloc_descriptor(&atchan->chan_common, GFP_NOWAIT);
+		ret = atc_alloc_descriptor(&atchan->dma_chan, GFP_NOWAIT);
 
 	return ret;
 }
@@ -630,11 +630,11 @@ static void atc_desc_put(struct at_dma_chan *atchan, struct at_desc *desc)
 
 		spin_lock_irqsave(&atchan->lock, flags);
 		list_for_each_entry(child, &desc->tx_list, desc_node)
-			dev_vdbg(chan2dev(&atchan->chan_common),
+			dev_vdbg(chan2dev(&atchan->dma_chan),
 					"moving child desc %p to freelist\n",
 					child);
 		list_splice_init(&desc->tx_list, &atchan->free_list);
-		dev_vdbg(chan2dev(&atchan->chan_common),
+		dev_vdbg(chan2dev(&atchan->dma_chan),
 			 "moving desc %p to freelist\n", desc);
 		list_add(&desc->desc_node, &atchan->free_list);
 		spin_unlock_irqrestore(&atchan->lock, flags);
@@ -673,13 +673,13 @@ static void atc_desc_chain(struct at_desc **first, struct at_desc **prev,
  */
 static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
 {
-	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
+	struct at_dma	*atdma = to_at_dma(atchan->dma_chan.device);
 
 	/* ASSERT:  channel is idle */
 	if (atc_chan_is_enabled(atchan)) {
-		dev_err(chan2dev(&atchan->chan_common),
+		dev_err(chan2dev(&atchan->dma_chan),
 			"BUG: Attempted to start non-idle channel\n");
-		dev_err(chan2dev(&atchan->chan_common),
+		dev_err(chan2dev(&atchan->dma_chan),
 			"  channel: s0x%x d0x%x ctrl0x%x:0x%x l0x%x\n",
 			channel_readl(atchan, SADDR),
 			channel_readl(atchan, DADDR),
@@ -905,10 +905,10 @@ static void
 atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
 {
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
-	struct at_dma			*atdma = to_at_dma(atchan->chan_common.device);
+	struct at_dma			*atdma = to_at_dma(atchan->dma_chan.device);
 	unsigned long flags;
 
-	dev_vdbg(chan2dev(&atchan->chan_common),
+	dev_vdbg(chan2dev(&atchan->dma_chan),
 		"descriptor %u complete\n", txd->cookie);
 
 	spin_lock_irqsave(&atchan->lock, flags);
@@ -951,7 +951,7 @@ static void atc_advance_work(struct at_dma_chan *atchan)
 	struct at_desc *desc;
 	unsigned long flags;
 
-	dev_vdbg(chan2dev(&atchan->chan_common), "advance_work\n");
+	dev_vdbg(chan2dev(&atchan->dma_chan), "advance_work\n");
 
 	spin_lock_irqsave(&atchan->lock, flags);
 	if (atc_chan_is_enabled(atchan) || list_empty(&atchan->active_list))
@@ -1010,9 +1010,9 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 	 * controller flagged an error instead of scribbling over
 	 * random memory locations.
 	 */
-	dev_crit(chan2dev(&atchan->chan_common),
+	dev_crit(chan2dev(&atchan->dma_chan),
 			"Bad descriptor submitted for DMA!\n");
-	dev_crit(chan2dev(&atchan->chan_common),
+	dev_crit(chan2dev(&atchan->dma_chan),
 			"  cookie: %d\n", bad_desc->txd.cookie);
 	atc_dump_lli(atchan, &bad_desc->lli);
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
@@ -1031,7 +1031,7 @@ static void atc_handle_cyclic(struct at_dma_chan *atchan)
 	struct at_desc			*first = atc_first_active(atchan);
 	struct dma_async_tx_descriptor	*txd = &first->txd;
 
-	dev_vdbg(chan2dev(&atchan->chan_common),
+	dev_vdbg(chan2dev(&atchan->dma_chan),
 			"new cyclic period llp 0x%08x\n",
 			channel_readl(atchan, DSCR));
 
@@ -1825,7 +1825,7 @@ static int atc_pause(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	int			chan_id = atchan->chan_common.chan_id;
+	int			chan_id = atchan->dma_chan.chan_id;
 	unsigned long		flags;
 
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
@@ -1844,7 +1844,7 @@ static int atc_resume(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	int			chan_id = atchan->chan_common.chan_id;
+	int			chan_id = atchan->dma_chan.chan_id;
 	unsigned long		flags;
 
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
@@ -1866,7 +1866,7 @@ static int atc_terminate_all(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	int			chan_id = atchan->chan_common.chan_id;
+	int			chan_id = atchan->dma_chan.chan_id;
 	unsigned long		flags;
 
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
@@ -2305,9 +2305,9 @@ static int __init at_dma_probe(struct platform_device *pdev)
 
 		atchan->mem_if = AT_DMA_MEM_IF;
 		atchan->per_if = AT_DMA_PER_IF;
-		atchan->chan_common.device = &atdma->dma_device;
-		dma_cookie_init(&atchan->chan_common);
-		list_add_tail(&atchan->chan_common.device_node,
+		atchan->dma_chan.device = &atdma->dma_device;
+		dma_cookie_init(&atchan->dma_chan);
+		list_add_tail(&atchan->dma_chan.device_node,
 				&atdma->dma_device.channels);
 
 		atchan->ch_regs = atdma->regs + ch_regs(i);
@@ -2455,7 +2455,7 @@ static int at_dma_prepare(struct device *dev)
 
 static void atc_suspend_cyclic(struct at_dma_chan *atchan)
 {
-	struct dma_chan	*chan = &atchan->chan_common;
+	struct dma_chan	*chan = &atchan->dma_chan;
 
 	/* Channel should be paused by user
 	 * do it anyway even if it is not done already */
@@ -2496,7 +2496,7 @@ static int at_dma_suspend_noirq(struct device *dev)
 
 static void atc_resume_cyclic(struct at_dma_chan *atchan)
 {
-	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
+	struct at_dma	*atdma = to_at_dma(atchan->dma_chan.device);
 
 	/* restore channel status for cyclic descriptors list:
 	 * next descriptor in the cyclic list at the time of suspend */
-- 
2.25.1

