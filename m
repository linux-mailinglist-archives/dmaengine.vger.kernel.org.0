Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C61100153
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfKRJd3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 04:33:29 -0500
Received: from smtp2.axis.com ([195.60.68.18]:34531 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfKRJd3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Nov 2019 04:33:29 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Nov 2019 04:33:28 EST
IronPort-SDR: /ZR5xX+73d/C8ro/l/i8tfrG/O4pT9ZCbVHflRFTpnylxq8+Qpgra+nV9eGfx1ngB/G5XziGfW
 +HcDcr3mGC5AwP3aDQLe3IE6pC+5SPJIqljZAymuL5qPdRWDxsJYfK2iuza5RBkvUwQM0jog6Q
 oj0/Bk42qrkA63XsowN8VcCTyFatGZhwP3Ro6O6+RvOcw99SEec6Vi9eRmVRRwUPTfYwkTSGdC
 Aqtwk9d7ETdnLJOaXRMasCWFNUeLgn058RHzk2qwwl2dtKQzxjOqkUN4S417VKPaVuLdtHg+F3
 ccU=
X-IronPort-AV: E=Sophos;i="5.68,319,1569276000"; 
   d="scan'208";a="2531062"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] serial: pl011: Fix DMA ->flush_buffer()
Date:   Mon, 18 Nov 2019 10:25:47 +0100
Message-Id: <20191118092547.32135-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PL011's ->flush_buffer() implementation releases and reacquires the port
lock.  Due to a race condition here, data can end up being added to the
circular buffer but neither being discarded nor being sent out.  This
leads to, for example, tcdrain(2) waiting indefinitely.

Process A                       Process B

uart_flush_buffer()
 - acquire lock
 - circ_clear
 - pl011_flush_buffer()
 -- release lock
 -- dmaengine_terminate_all()

                                uart_write()
                                - acquire lock
                                - add chars to circ buffer
                                - start_tx()
                                -- start DMA
                                - release lock

 -- acquire lock
 -- turn off DMA
 -- release lock

                                // Data in circ buffer but DMA is off

According to the comment in the code, the releasing of the lock around
dmaengine_terminate_all() is to avoid a deadlock with the DMA engine
callback.  However, since the time this code was written, the DMA engine
API documentation seems to have been clarified to say that
dmaengine_terminate_all() (in the identically implemented but
differently named dmaengine_terminate_async() variant) does not wait for
any running complete callback to be completed and can even be called
from a complete callback.  So there is no possibility of deadlock if the
DMA engine driver implements this API correctly.

So we should be able to just remove this release and reacquire of the
lock to prevent the aforementioned race condition.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/tty/serial/amba-pl011.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3a7d1a66f79c..b0b689546395 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -813,10 +813,8 @@ __acquires(&uap->port.lock)
 	if (!uap->using_tx_dma)
 		return;
 
-	/* Avoid deadlock with the DMA engine callback */
-	spin_unlock(&uap->port.lock);
-	dmaengine_terminate_all(uap->dmatx.chan);
-	spin_lock(&uap->port.lock);
+	dmaengine_terminate_async(uap->dmatx.chan);
+
 	if (uap->dmatx.queued) {
 		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
 			     DMA_TO_DEVICE);
-- 
2.20.0

