Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE72805C2
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 12:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbfHCKdO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 06:33:14 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:55441 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388423AbfHCKdO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 06:33:14 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 4663B1033A716;
        Sat,  3 Aug 2019 12:33:12 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id D4ADB618F189;
        Sat,  3 Aug 2019 12:33:11 +0200 (CEST)
X-Mailbox-Line: From 037b83d2ae8aa92448b9d647436012c06f4c0561 Mon Sep 17 00:00:00 2001
Message-Id: <037b83d2ae8aa92448b9d647436012c06f4c0561.1564825752.git.lukas@wunner.de>
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 3 Aug 2019 12:10:00 +0200
Subject: [PATCH 02/10] dmaengine: bcm2835: Allow cyclic transactions without
 interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>, linux-spi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The BCM2835 DMA driver currently requests an interrupt from the
controller regardless whether or not the client has passed in the
DMA_PREP_INTERRUPT flag. This causes unnecessary overhead for cyclic
transactions which do not need an interrupt after each period.

We're about to add such a use case, namely cyclic clearing of the SPI
controller's RX FIFO, so amend the DMA driver to request an interrupt
only if DMA_PREP_INTERRUPT was passed in. Ignore the period_len for
such transactions and set it to the buffer length to make the driver's
calculations work.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Kauer <florian.kauer@koalo.de>
---
 drivers/dma/bcm2835-dma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 523c507ad69e..a65514fcb7f2 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -691,7 +691,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
 	u32 info = BCM2835_DMA_WAIT_RESP;
-	u32 extra = BCM2835_DMA_INT_EN;
+	u32 extra = 0;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -707,6 +707,11 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		return NULL;
 	}
 
+	if (flags & DMA_PREP_INTERRUPT)
+		extra |= BCM2835_DMA_INT_EN;
+	else
+		period_len = buf_len;
+
 	/*
 	 * warn if buf_len is not a multiple of period_len - this may leed
 	 * to unexpected latencies for interrupts and thus audiable clicks
@@ -778,7 +783,10 @@ static int bcm2835_dma_terminate_all(struct dma_chan *chan)
 
 	/* stop DMA activity */
 	if (c->desc) {
-		vchan_terminate_vdesc(&c->desc->vd);
+		if (c->desc->vd.tx.flags & DMA_PREP_INTERRUPT)
+			vchan_terminate_vdesc(&c->desc->vd);
+		else
+			vchan_vdesc_fini(&c->desc->vd);
 		c->desc = NULL;
 		bcm2835_dma_abort(c);
 	}
-- 
2.20.1

