Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23DE3071E0
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jan 2021 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhA1Ipr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jan 2021 03:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhA1Ioq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jan 2021 03:44:46 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30DCC061797
        for <dmaengine@vger.kernel.org>; Thu, 28 Jan 2021 00:45:01 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id N8kx2400N4C55Sk018kx72; Thu, 28 Jan 2021 09:44:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l52vB-001JYQ-CR; Thu, 28 Jan 2021 09:44:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l52vA-009O1k-Vs; Thu, 28 Jan 2021 09:44:56 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/4] dmaengine: rcar-dmac: Add for_each_rcar_dmac_chan() helper
Date:   Thu, 28 Jan 2021 09:44:53 +0100
Message-Id: <20210128084455.2237256-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128084455.2237256-1-geert+renesas@glider.be>
References: <20210128084455.2237256-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a helper macro for iterating over all DMAC channels, taking into
account the channel mask.  Use it where appropriate, to simplify code.

Restore "reverse Christmas tree" order of local variables while adding a
new variable.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v3:
  - Add Reviewed-by, Tested-by,
  - Place iterator after container being iterated,

v2:
  - Put the full loop control of for_each_rcar_dmac_chan() on a single
    line, to improve readability.
---
 drivers/dma/sh/rcar-dmac.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 4524718d4f90920e..83c9a5bd1077db3a 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -209,6 +209,10 @@ struct rcar_dmac {
 
 #define to_rcar_dmac(d)		container_of(d, struct rcar_dmac, engine)
 
+#define for_each_rcar_dmac_chan(i, dmac, chan)						\
+	for (i = 0, chan = &(dmac)->channels[0]; i < (dmac)->n_channels; i++, chan++)	\
+		if (!((dmac)->channels_mask & BIT(i))) continue; else
+
 /*
  * struct rcar_dmac_of_data - This driver's OF data
  * @chan_offset_base: DMAC channels base offset
@@ -817,15 +821,11 @@ static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
 
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
+	for_each_rcar_dmac_chan(i, dmac, chan) {
 		/* Stop and reinitialize the channel. */
 		spin_lock_irq(&chan->lock);
 		rcar_dmac_chan_halt(chan);
@@ -1828,9 +1828,10 @@ static int rcar_dmac_probe(struct platform_device *pdev)
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
 
@@ -1916,11 +1917,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&engine->channels);
 
-	for (i = 0; i < dmac->n_channels; ++i) {
-		if (!(dmac->channels_mask & BIT(i)))
-			continue;
-
-		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], data, i);
+	for_each_rcar_dmac_chan(i, dmac, chan) {
+		ret = rcar_dmac_chan_probe(dmac, chan, data, i);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.25.1

