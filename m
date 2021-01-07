Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712B72ED68F
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jan 2021 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbhAGSQh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jan 2021 13:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbhAGSQ2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jan 2021 13:16:28 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64087C0612A2
        for <dmaengine@vger.kernel.org>; Thu,  7 Jan 2021 10:15:29 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id DuFT240034C55Sk01uFTHy; Thu, 07 Jan 2021 19:15:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxZok-001v2o-PA; Thu, 07 Jan 2021 19:15:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxZok-008AYy-ED; Thu, 07 Jan 2021 19:15:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan() helper
Date:   Thu,  7 Jan 2021 19:15:22 +0100
Message-Id: <20210107181524.1947173-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107181524.1947173-1-geert+renesas@glider.be>
References: <20210107181524.1947173-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add and helper macro for iterating over all DMAC channels, taking into
account the channel mask.  Use it where appropriate, to simplify code.

Restore "reverse Christmas tree" order of local variables while adding a
new variable.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index a57705356e8bb796..71cdaf446fcaeba5 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -209,6 +209,11 @@ struct rcar_dmac {
 
 #define to_rcar_dmac(d)		container_of(d, struct rcar_dmac, engine)
 
+#define for_each_rcar_dmac_chan(i, chan, dmac)				 \
+	for (i = 0, chan = &(dmac)->channels[0]; i < (dmac)->n_channels; \
+	     i++, chan++)						 \
+		if (!((dmac)->channels_mask & BIT(i))) continue; else
+
 /*
  * struct rcar_dmac_of_data - This driver's OF data
  * @chan_offset_base: DMAC channels base offset
@@ -817,15 +822,11 @@ static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
 
 static void rcar_dmac_stop_all_chan(struct rcar_dmac *dmac)
 {
+	struct rcar_dmac_chan *chan;
 	unsigned int i;
 
 	/* Stop all channels. */
-	for (i = 0; i < dmac->n_channels; ++i) {
-		struct rcar_dmac_chan *chan = &dmac->channels[i];
-
-		if (!(dmac->channels_mask & BIT(i)))
-			continue;
-
+	for_each_rcar_dmac_chan(i, chan, dmac) {
 		/* Stop and reinitialize the channel. */
 		spin_lock_irq(&chan->lock);
 		rcar_dmac_chan_halt(chan);
@@ -1828,9 +1829,10 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES |
 		DMA_SLAVE_BUSWIDTH_8_BYTES | DMA_SLAVE_BUSWIDTH_16_BYTES |
 		DMA_SLAVE_BUSWIDTH_32_BYTES | DMA_SLAVE_BUSWIDTH_64_BYTES;
+	const struct rcar_dmac_of_data *data;
+	struct rcar_dmac_chan *chan;
 	struct dma_device *engine;
 	struct rcar_dmac *dmac;
-	const struct rcar_dmac_of_data *data;
 	unsigned int i;
 	int ret;
 
@@ -1916,11 +1918,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&engine->channels);
 
-	for (i = 0; i < dmac->n_channels; ++i) {
-		if (!(dmac->channels_mask & BIT(i)))
-			continue;
-
-		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], data, i);
+	for_each_rcar_dmac_chan(i, chan, dmac) {
+		ret = rcar_dmac_chan_probe(dmac, chan, data, i);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.25.1

