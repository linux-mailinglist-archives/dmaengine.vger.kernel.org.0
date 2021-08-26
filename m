Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533653F84C4
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 11:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhHZJsg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 05:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbhHZJse (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Aug 2021 05:48:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609BC061757
        for <dmaengine@vger.kernel.org>; Thu, 26 Aug 2021 02:47:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz8-0003ju-3D; Thu, 26 Aug 2021 11:47:46 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz7-0006lo-Bt; Thu, 26 Aug 2021 11:47:45 +0200
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz4-005SjS-A3; Thu, 26 Aug 2021 11:47:42 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, appana.durga.rao@xilinx.com,
        michal.simek@xilinx.com, m.tretter@pengutronix.de,
        kernel@pengutronix.de
Subject: [PATCH 7/7] dmaengine: zynqmp_dma: fix lockdep warning in tasklet
Date:   Thu, 26 Aug 2021 11:47:42 +0200
Message-Id: <20210826094742.1302009-8-m.tretter@pengutronix.de>
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

The tasklet that handles the completed dma transfers uses spin_unlock
for unlocking a spin lock that was previously locked with
spin_lock_irqsave.

This caused the following lockdep warning about an inconsistent lock
state:

	inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.

We must use spin_lock_irqsave, because it is possible to queue DMA
transfers from an irq handler.

Replace the spin_unlock and spin_lock by spin_unlock_irqrestore and
spin_lock_irqsave.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/dma/xilinx/zynqmp_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index ef32f7519e0a..5f5f9e244ec6 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -612,9 +612,9 @@ static void zynqmp_dma_chan_desc_cleanup(struct zynqmp_dma_chan *chan)
 		callback = desc->async_tx.callback;
 		callback_param = desc->async_tx.callback_param;
 		if (callback) {
-			spin_unlock(&chan->lock);
+			spin_unlock_irqrestore(&chan->lock, irqflags);
 			callback(callback_param);
-			spin_lock(&chan->lock);
+			spin_lock_irqsave(&chan->lock, irqflags);
 		}
 
 		/* Run any dependencies, then free the descriptor */
-- 
2.30.2

