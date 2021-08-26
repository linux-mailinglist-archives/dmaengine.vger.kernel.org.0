Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A75E3F84C3
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbhHZJsg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbhHZJse (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Aug 2021 05:48:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F2C0613C1
        for <dmaengine@vger.kernel.org>; Thu, 26 Aug 2021 02:47:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz8-0003jt-20; Thu, 26 Aug 2021 11:47:46 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz7-0006lp-Bu; Thu, 26 Aug 2021 11:47:45 +0200
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz4-005SjP-9j; Thu, 26 Aug 2021 11:47:42 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, appana.durga.rao@xilinx.com,
        michal.simek@xilinx.com, m.tretter@pengutronix.de,
        kernel@pengutronix.de
Subject: [PATCH 6/7] dmaengine: zynqmp_dma: refine dma descriptor locking
Date:   Thu, 26 Aug 2021 11:47:41 +0200
Message-Id: <20210826094742.1302009-7-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826094742.1302009-1-m.tretter@pengutronix.de>
References: <20210826094742.1302009-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The descriptor lists are locked for the entire tasklet that completes
the descriptors. This is not necessary, because the lock actually only
protects the descriptor lists.

Make the spin lock more fine-grained and only protect functions that
actually operate on the descriptor lists. This decreases the time when
the lock is held.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/dma/xilinx/zynqmp_dma.c | 35 ++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f98ef5fe4902..ef32f7519e0a 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -601,6 +601,9 @@ static void zynqmp_dma_start_transfer(struct zynqmp_dma_chan *chan)
 static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
 {
 	struct zynqmp_dma_desc_sw *desc, *next;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&chan->lock, irqflags);
 
 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
 		dma_async_tx_callback callback;
@@ -617,6 +620,8 @@ static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
 		/* Run any dependencies, then free the descriptor */
 		zynqmp_dma_free_descriptor(chan, desc);
 	}
+
+	spin_unlock_irqrestore(&chan->lock, irqflags);
 }
 
 /**
@@ -656,9 +661,13 @@ static void zynqmp_dma_issue_pending(struct dma_chan *dchan)
  */
 static void zynqmp_dma_free_descriptors(struct zynqmp_dma_chan *chan)
 {
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&chan->lock, irqflags);
 	zynqmp_dma_free_desc_list(chan, &chan->active_list);
 	zynqmp_dma_free_desc_list(chan, &chan->pending_list);
 	zynqmp_dma_free_desc_list(chan, &chan->done_list);
+	spin_unlock_irqrestore(&chan->lock, irqflags);
 }
 
 /**
@@ -668,11 +677,8 @@ static void zynqmp_dma_free_descriptors(struct zynqmp_dma_chan *chan)
 static void zynqmp_dma_free_chan_resources(struct dma_chan *dchan)
 {
 	struct zynqmp_dma_chan *chan = to_chan(dchan);
-	unsigned long irqflags;
 
-	spin_lock_irqsave(&chan->lock, irqflags);
 	zynqmp_dma_free_descriptors(chan);
-	spin_unlock_irqrestore(&chan->lock, irqflags);
 	dma_free_coherent(chan->dev,
 		(2 * ZYNQMP_DMA_DESC_SIZE(chan) * ZYNQMP_DMA_NUM_DESCS),
 		chan->desc_pool_v, chan->desc_pool_p);
@@ -687,11 +693,16 @@ static void zynqmp_dma_free_chan_resources(struct dma_chan *dchan)
  */
 static void zynqmp_dma_reset(struct zynqmp_dma_chan *chan)
 {
+	unsigned long irqflags;
+
 	writel(ZYNQMP_DMA_IDS_DEFAULT_MASK, chan->regs + ZYNQMP_DMA_IDS);
 
+	spin_lock_irqsave(&chan->lock, irqflags);
 	zynqmp_dma_complete_descriptor(chan);
+	spin_unlock_irqrestore(&chan->lock, irqflags);
 	zynqmp_dma_chan_desc_cleanup(chan);
 	zynqmp_dma_free_descriptors(chan);
+
 	zynqmp_dma_init(chan);
 }
 
@@ -747,28 +758,27 @@ static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
 	u32 count;
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&chan->lock, irqflags);
-
 	if (chan->err) {
 		zynqmp_dma_reset(chan);
 		chan->err = false;
-		goto unlock;
+		return;
 	}
 
+	spin_lock_irqsave(&chan->lock, irqflags);
 	count = readl(chan->regs + ZYNQMP_DMA_IRQ_DST_ACCT);
-
 	while (count) {
 		zynqmp_dma_complete_descriptor(chan);
 		count--;
 	}
+	spin_unlock_irqrestore(&chan->lock, irqflags);
 
 	zynqmp_dma_chan_desc_cleanup(chan);
 
-	if (chan->idle)
+	if (chan->idle) {
+		spin_lock_irqsave(&chan->lock, irqflags);
 		zynqmp_dma_start_transfer(chan);
-
-unlock:
-	spin_unlock_irqrestore(&chan->lock, irqflags);
+		spin_unlock_irqrestore(&chan->lock, irqflags);
+	}
 }
 
 /**
@@ -780,12 +790,9 @@ static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
 static int zynqmp_dma_device_terminate_all(struct dma_chan *dchan)
 {
 	struct zynqmp_dma_chan *chan = to_chan(dchan);
-	unsigned long irqflags;
 
-	spin_lock_irqsave(&chan->lock, irqflags);
 	writel(ZYNQMP_DMA_IDS_DEFAULT_MASK, chan->regs + ZYNQMP_DMA_IDS);
 	zynqmp_dma_free_descriptors(chan);
-	spin_unlock_irqrestore(&chan->lock, irqflags);
 
 	return 0;
 }
-- 
2.30.2

