Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D373071E2
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jan 2021 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhA1IqR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jan 2021 03:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhA1Ipz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jan 2021 03:45:55 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C355EC0617AA
        for <dmaengine@vger.kernel.org>; Thu, 28 Jan 2021 00:45:01 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id N8kx2400T4C55Sk018kx74; Thu, 28 Jan 2021 09:44:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l52vB-001JYR-E9; Thu, 28 Jan 2021 09:44:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l52vB-009O1q-0i; Thu, 28 Jan 2021 09:44:57 +0100
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
Subject: [PATCH v3 3/4] dmaengine: rcar-dmac: Add helpers for clearing DMA channel status
Date:   Thu, 28 Jan 2021 09:44:54 +0100
Message-Id: <20210128084455.2237256-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128084455.2237256-1-geert+renesas@glider.be>
References: <20210128084455.2237256-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extract the code to clear the status of one or all channels into their
own helpers, to prepare for the different handling of the R-Car V3U SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v3:
  - Add Reviewed-by, Tested-by,

v2:
  - No changes.
---
 drivers/dma/sh/rcar-dmac.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 83c9a5bd1077db3a..37e3c6890f8670da 100644
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

