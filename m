Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FB115179
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2019 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLFNyV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Dec 2019 08:54:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53537 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLFNyU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Dec 2019 08:54:20 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1idE3G-0008NA-Nf; Fri, 06 Dec 2019 14:53:46 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1idE3F-0001ED-OZ; Fri, 06 Dec 2019 14:53:45 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/5] dmaengine: virt-dma: Do not call desc_free() under a spin_lock
Date:   Fri,  6 Dec 2019 14:53:41 +0100
Message-Id: <20191206135344.29330-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206135344.29330-1-s.hauer@pengutronix.de>
References: <20191206135344.29330-1-s.hauer@pengutronix.de>
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

vchan_vdesc_fini() shouldn't be called under a spin_lock. This is done
in two places, once in vchan_terminate_vdesc() and once in
vchan_synchronize(). Instead of freeing the vdesc right away, collect
the aborted vdescs on a separate list and free them along with the other
vdescs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/virt-dma.c |  1 +
 drivers/dma/virt-dma.h | 17 +++--------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index ec4adf4260a0..87d5bd53c98b 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -135,6 +135,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	INIT_LIST_HEAD(&vc->desc_submitted);
 	INIT_LIST_HEAD(&vc->desc_issued);
 	INIT_LIST_HEAD(&vc->desc_completed);
+	INIT_LIST_HEAD(&vc->desc_aborted);
 
 	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
 
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 41883ee2c29f..6cae93624f0d 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -31,9 +31,9 @@ struct virt_dma_chan {
 	struct list_head desc_submitted;
 	struct list_head desc_issued;
 	struct list_head desc_completed;
+	struct list_head desc_aborted;
 
 	struct virt_dma_desc *cyclic;
-	struct virt_dma_desc *vd_terminated;
 };
 
 static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
@@ -146,11 +146,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
 {
 	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
 
-	/* free up stuck descriptor */
-	if (vc->vd_terminated)
-		vchan_vdesc_fini(vc->vd_terminated);
+	list_add_tail(&vd->node, &vc->desc_aborted);
 
-	vc->vd_terminated = vd;
 	if (vc->cyclic == vd)
 		vc->cyclic = NULL;
 }
@@ -184,6 +181,7 @@ static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
 	list_splice_tail_init(&vc->desc_submitted, head);
 	list_splice_tail_init(&vc->desc_issued, head);
 	list_splice_tail_init(&vc->desc_completed, head);
+	list_splice_tail_init(&vc->desc_aborted, head);
 }
 
 static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
@@ -212,16 +210,7 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
  */
 static inline void vchan_synchronize(struct virt_dma_chan *vc)
 {
-	unsigned long flags;
-
 	tasklet_kill(&vc->task);
-
-	spin_lock_irqsave(&vc->lock, flags);
-	if (vc->vd_terminated) {
-		vchan_vdesc_fini(vc->vd_terminated);
-		vc->vd_terminated = NULL;
-	}
-	spin_unlock_irqrestore(&vc->lock, flags);
 }
 
 #endif
-- 
2.24.0

