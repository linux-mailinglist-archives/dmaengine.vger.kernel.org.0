Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D47120301
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 11:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfLPKyP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 05:54:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43365 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfLPKyO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Dec 2019 05:54:14 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0L-0001da-9N; Mon, 16 Dec 2019 11:53:33 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0I-0005tD-Ct; Mon, 16 Dec 2019 11:53:30 +0100
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
Subject: [PATCH 4/9] dmaengine: virt-dma: Do not call desc_free() under a spin_lock
Date:   Mon, 16 Dec 2019 11:53:23 +0100
Message-Id: <20191216105328.15198-5-s.hauer@pengutronix.de>
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

vchan_vdesc_fini() shouldn't be called under a spin_lock. This is done
in two places, once in vchan_terminate_vdesc() and once in
vchan_synchronize(). Instead of freeing the vdesc right away, collect
the aborted vdescs on a separate list and free them along with the other
vdescs. The terminated descs are also freed in vchan_synchronize as done
before this patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/virt-dma.c |  1 +
 drivers/dma/virt-dma.h | 18 +++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 7ba712888ac7..26e08c7a7465 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -138,6 +138,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	INIT_LIST_HEAD(&vc->desc_submitted);
 	INIT_LIST_HEAD(&vc->desc_issued);
 	INIT_LIST_HEAD(&vc->desc_completed);
+	INIT_LIST_HEAD(&vc->desc_terminated);
 
 	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
 
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index ab158bac03a7..e213137b6bc1 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -31,9 +31,9 @@ struct virt_dma_chan {
 	struct list_head desc_submitted;
 	struct list_head desc_issued;
 	struct list_head desc_completed;
+	struct list_head desc_terminated;
 
 	struct virt_dma_desc *cyclic;
-	struct virt_dma_desc *vd_terminated;
 };
 
 static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
@@ -141,11 +141,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
 {
 	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
 
-	/* free up stuck descriptor */
-	if (vc->vd_terminated)
-		vchan_vdesc_fini(vc->vd_terminated);
+	list_add_tail(&vd->node, &vc->desc_terminated);
 
-	vc->vd_terminated = vd;
 	if (vc->cyclic == vd)
 		vc->cyclic = NULL;
 }
@@ -179,6 +176,7 @@ static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
 	list_splice_tail_init(&vc->desc_submitted, head);
 	list_splice_tail_init(&vc->desc_issued, head);
 	list_splice_tail_init(&vc->desc_completed, head);
+	list_splice_tail_init(&vc->desc_terminated, head);
 }
 
 static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
@@ -207,16 +205,18 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
  */
 static inline void vchan_synchronize(struct virt_dma_chan *vc)
 {
+	LIST_HEAD(head);
 	unsigned long flags;
 
 	tasklet_kill(&vc->task);
 
 	spin_lock_irqsave(&vc->lock, flags);
-	if (vc->vd_terminated) {
-		vchan_vdesc_fini(vc->vd_terminated);
-		vc->vd_terminated = NULL;
-	}
+
+	list_splice_tail_init(&vc->desc_terminated, &head);
+
 	spin_unlock_irqrestore(&vc->lock, flags);
+
+	vchan_dma_desc_free_list(vc, &head);
 }
 
 #endif
-- 
2.24.0

