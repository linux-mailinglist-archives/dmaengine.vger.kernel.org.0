Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2350AD2
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfFXMi2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:38:28 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:56744 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfFXMi1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 08:38:27 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id UceQ2000M3XaVaC01ceQZz; Mon, 24 Jun 2019 14:38:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOEq-0003kT-Gn; Mon, 24 Jun 2019 14:38:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOEq-0005SP-Fh; Mon, 24 Jun 2019 14:38:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: rcar-dmac: Reject zero-length slave DMA requests
Date:   Mon, 24 Jun 2019 14:38:18 +0200
Message-Id: <20190624123818.20919-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

While the .device_prep_slave_sg() callback rejects empty scatterlists,
it still accepts single-entry scatterlists with a zero-length segment.
These may happen if a driver calls dmaengine_prep_slave_single() with a
zero len parameter.  The corresponding DMA request will never complete,
leading to messages like:

    rcar-dmac e7300000.dma-controller: Channel Address Error happen

and DMA timeouts.

Although requesting a zero-length DMA request is a driver bug, rejecting
it early eases debugging.  Note that the .device_prep_dma_memcpy()
callback already rejects requests to copy zero bytes.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Analyzed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
See "[PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues"
(https://lore.kernel.org/linux-renesas-soc/20190624123540.20629-1-geert+renesas@glider.be/)
for the driver fix.

 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 67df54ac329400b7..9c41a4e425759fcc 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1165,7 +1165,7 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
 
 	/* Someone calling slave DMA on a generic channel? */
-	if (rchan->mid_rid < 0 || !sg_len) {
+	if (rchan->mid_rid < 0 || !sg_len || !sg_dma_len(sgl)) {
 		dev_warn(chan->device->dev,
 			 "%s: bad parameter: len=%d, id=%d\n",
 			 __func__, sg_len, rchan->mid_rid);
-- 
2.17.1

