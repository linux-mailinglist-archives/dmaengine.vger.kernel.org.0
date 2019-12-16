Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C71202FC
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2019 11:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLPKx7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 05:53:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40647 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLPKx6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Dec 2019 05:53:58 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0L-0001dX-9V; Mon, 16 Dec 2019 11:53:33 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1igo0I-0005t4-Am; Mon, 16 Dec 2019 11:53:30 +0100
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
Subject: [PATCH 1/9] dmaengine: bcm2835: do not call vchan_vdesc_fini() with lock held
Date:   Mon, 16 Dec 2019 11:53:20 +0100
Message-Id: <20191216105328.15198-2-s.hauer@pengutronix.de>
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

vchan_vdesc_fini() can't be called locked. Instead, call
vchan_terminate_vdesc() which delays the freeing of the descriptor to
vchan_synchronize().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/bcm2835-dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index e4c593f48575..4768ef26013b 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -797,10 +797,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 
 	/* stop DMA activity */
 	if (c->desc) {
-		if (c->desc->vd.tx.flags & DMA_PREP_INTERRUPT)
-			vchan_terminate_vdesc(&c->desc->vd);
-		else
-			vchan_vdesc_fini(&c->desc->vd);
+		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc = NULL;
 		bcm2835_dma_abort(c);
 	}
-- 
2.24.0

