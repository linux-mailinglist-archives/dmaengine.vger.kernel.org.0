Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5449304425
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbhAZGBY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 01:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbhAYOh3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Jan 2021 09:37:29 -0500
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be [IPv6:2a02:1800:110:4::f00:d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64B7C0617A7
        for <dmaengine@vger.kernel.org>; Mon, 25 Jan 2021 06:36:03 -0800 (PST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4DPXG703QrzMsJqF
        for <dmaengine@vger.kernel.org>; Mon, 25 Jan 2021 15:25:35 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id M2QZ2400D4C55Sk012QZ6m; Mon, 25 Jan 2021 15:24:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l42nA-000eiW-OS; Mon, 25 Jan 2021 15:24:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l42nA-004P5E-7x; Mon, 25 Jan 2021 15:24:32 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/4] dmaengine: rcar-dmac: Add helpers for clearing DMA channel status
Date:   Mon, 25 Jan 2021 15:24:30 +0100
Message-Id: <20210125142431.1049668-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125142431.1049668-1-geert+renesas@glider.be>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extract the code to clear the status of one or all channels into their
own helpers, to prepare for the different handling of the R-Car V3U SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/dma/sh/rcar-dmac.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 537550b4121bbc22..7a0f802c61e5152d 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -336,6 +336,17 @@ static void rcar_dmac_chan_write(struct rcar_dmac_chan *chan, u32 reg, u32 data)
 		writel(data, chan->iomem + reg);
 }
 
+static void rcar_dmac_chan_clear(struct rcar_dmac *dmac,
+				 struct rcar_dmac_chan *chan)
+{
+	rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
+}
+
+static void rcar_dmac_chan_clear_all(struct rcar_dmac *dmac)
+{
+	rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
+}
+
 /* -----------------------------------------------------------------------------
  * Initialization and configuration
  */
@@ -451,7 +462,7 @@ static int rcar_dmac_init(struct rcar_dmac *dmac)
 	u16 dmaor;
 
 	/* Clear all channels and enable the DMAC globally. */
-	rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
+	rcar_dmac_chan_clear_all(dmac);
 	rcar_dmac_write(dmac, RCAR_DMAOR,
 			RCAR_DMAOR_PRI_FIXED | RCAR_DMAOR_DME);
 
@@ -1566,7 +1577,7 @@ static irqreturn_t rcar_dmac_isr_channel(int irq, void *dev)
 		 * because channel is already stopped in error case.
 		 * We need to clear register and check DE bit as recovery.
 		 */
-		rcar_dmac_write(dmac, RCAR_DMACHCLR, 1 << chan->index);
+		rcar_dmac_chan_clear(dmac, chan);
 		rcar_dmac_chcr_de_barrier(chan);
 		reinit = true;
 		goto spin_lock_end;
-- 
2.25.1

