Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85DD1202FB
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 11:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLPKxv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 05:53:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59057 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfLPKxu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Dec 2019 05:53:50 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0L-0001dY-9U; Mon, 16 Dec 2019 11:53:33 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0I-0005t7-BW; Mon, 16 Dec 2019 11:53:30 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Green Wan <green.wan@sifive.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/9] dmaengine: virt-dma: Add missing locking
Date:   Mon, 16 Dec 2019 11:53:21 +0100
Message-Id: <20191216105328.15198-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216105328.15198-1-s.hauer@pengutronix.de>
References: <20191216105328.15198-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Originally freeing descriptors was split into a locked and an unlocked
part. The locked part in vchan_get_all_descriptors() collected all
descriptors on a separate list_head. This was done to allow iterating
over that new list in vchan_dma_desc_free_list() without a lock held.

This became broken in 13bb26ae8850 ("dmaengine: virt-dma: don't always
free descriptor upon completion"). With this commit
vchan_dma_desc_free_list() no longer exclusively operates on the
separate list, but starts to put descriptors which can be reused back on
&vc->desc_allocated. This list operation should have been locked, but
wasn't.
In the mean time drivers started to call vchan_dma_desc_free_list() with
their lock held so that we now have the situation that
vchan_dma_desc_free_list() is called locked from some drivers and
unlocked from others.
To clean this up we have to do two things:

1. Add missing locking in vchan_dma_desc_free_list()
2. Make sure drivers call vchan_dma_desc_free_list() unlocked

This needs to be done atomically, so in this patch the locking is added
and all drivers are fixed.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |  8 ++-----
 drivers/dma/mediatek/mtk-uart-apdma.c         |  3 ++-
 drivers/dma/owl-dma.c                         |  3 ++-
 drivers/dma/s3c24xx-dma.c                     | 22 +++++++++----------
 drivers/dma/sf-pdma/sf-pdma.c                 |  4 ++--
 drivers/dma/sun4i-dma.c                       |  3 ++-
 drivers/dma/virt-dma.c                        |  4 ++++
 7 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a1ce307c502f..14c1ac26f866 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -636,14 +636,10 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 	vchan_get_all_descriptors(&chan->vc, &head);
 
-	/*
-	 * As vchan_dma_desc_free_list can access to desc_allocated list
-	 * we need to call it in vc.lock context.
-	 */
-	vchan_dma_desc_free_list(&chan->vc, &head);
-
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
+	vchan_dma_desc_free_list(&chan->vc, &head);
+
 	dev_vdbg(dchan2dev(dchan), "terminated: %s\n", axi_chan_name(chan));
 
 	return 0;
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index c20e6bd4e298..29f1223b285a 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -430,9 +430,10 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 	vchan_get_all_descriptors(&c->vc, &head);
-	vchan_dma_desc_free_list(&c->vc, &head);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
+	vchan_dma_desc_free_list(&c->vc, &head);
+
 	return 0;
 }
 
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 023f951189a7..c683051257fd 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -674,10 +674,11 @@ static int owl_dma_terminate_all(struct dma_chan *chan)
 	}
 
 	vchan_get_all_descriptors(&vchan->vc, &head);
-	vchan_dma_desc_free_list(&vchan->vc, &head);
 
 	spin_unlock_irqrestore(&vchan->vc.lock, flags);
 
+	vchan_dma_desc_free_list(&vchan->vc, &head);
+
 	return 0;
 }
 
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 43da8eeb18ef..1ed5dc1f597c 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -519,15 +519,6 @@ static void s3c24xx_dma_start_next_txd(struct s3c24xx_dma_chan *s3cchan)
 	s3c24xx_dma_start_next_sg(s3cchan, txd);
 }
 
-static void s3c24xx_dma_free_txd_list(struct s3c24xx_dma_engine *s3cdma,
-				struct s3c24xx_dma_chan *s3cchan)
-{
-	LIST_HEAD(head);
-
-	vchan_get_all_descriptors(&s3cchan->vc, &head);
-	vchan_dma_desc_free_list(&s3cchan->vc, &head);
-}
-
 /*
  * Try to allocate a physical channel.  When successful, assign it to
  * this virtual channel, and initiate the next descriptor.  The
@@ -709,8 +700,9 @@ static int s3c24xx_dma_terminate_all(struct dma_chan *chan)
 {
 	struct s3c24xx_dma_chan *s3cchan = to_s3c24xx_dma_chan(chan);
 	struct s3c24xx_dma_engine *s3cdma = s3cchan->host;
+	LIST_HEAD(head);
 	unsigned long flags;
-	int ret = 0;
+	int ret;
 
 	spin_lock_irqsave(&s3cchan->vc.lock, flags);
 
@@ -734,7 +726,15 @@ static int s3c24xx_dma_terminate_all(struct dma_chan *chan)
 	}
 
 	/* Dequeue jobs not yet fired as well */
-	s3c24xx_dma_free_txd_list(s3cdma, s3cchan);
+
+	vchan_get_all_descriptors(&s3cchan->vc, &head);
+
+	spin_unlock_irqrestore(&s3cchan->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&s3cchan->vc, &head);
+
+	return 0;
+
 unlock:
 	spin_unlock_irqrestore(&s3cchan->vc.lock, flags);
 
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 465256fe8b1f..6d0bec947636 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -155,9 +155,9 @@ static void sf_pdma_free_chan_resources(struct dma_chan *dchan)
 	kfree(chan->desc);
 	chan->desc = NULL;
 	vchan_get_all_descriptors(&chan->vchan, &head);
-	vchan_dma_desc_free_list(&chan->vchan, &head);
 	sf_pdma_disclaim_chan(chan);
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+	vchan_dma_desc_free_list(&chan->vchan, &head);
 }
 
 static size_t sf_pdma_desc_residue(struct sf_pdma_chan *chan,
@@ -220,8 +220,8 @@ static int sf_pdma_terminate_all(struct dma_chan *dchan)
 	chan->desc = NULL;
 	chan->xfer_err = false;
 	vchan_get_all_descriptors(&chan->vchan, &head);
-	vchan_dma_desc_free_list(&chan->vchan, &head);
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+	vchan_dma_desc_free_list(&chan->vchan, &head);
 
 	return 0;
 }
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index e397a50058c8..4e1575e731d8 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -885,12 +885,13 @@ static int sun4i_dma_terminate_all(struct dma_chan *chan)
 	}
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
-	vchan_dma_desc_free_list(&vchan->vc, &head);
 	/* Clear these so the vchan is usable again */
 	vchan->processing = NULL;
 	vchan->pchan = NULL;
 	spin_unlock_irqrestore(&vchan->vc.lock, flags);
 
+	vchan_dma_desc_free_list(&vchan->vc, &head);
+
 	return 0;
 }
 
diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index ec4adf4260a0..660267ca5e42 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -116,7 +116,11 @@ void vchan_dma_desc_free_list(struct virt_dma_chan *vc, struct list_head *head)
 
 	list_for_each_entry_safe(vd, _vd, head, node) {
 		if (dmaengine_desc_test_reuse(&vd->tx)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&vc->lock, flags);
 			list_move_tail(&vd->node, &vc->desc_allocated);
+			spin_unlock_irqrestore(&vc->lock, flags);
 		} else {
 			dev_dbg(vc->chan.device->dev, "txd %p: freeing\n", vd);
 			list_del(&vd->node);
-- 
2.24.0

