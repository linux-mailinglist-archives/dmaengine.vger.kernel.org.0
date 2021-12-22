Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1263147D131
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 12:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhLVLpZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 06:45:25 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:11649 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232268AbhLVLpY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 06:45:24 -0500
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000"; 
   d="scan'208";a="104359104"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 20:45:23 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3B06B42E47B8;
        Wed, 22 Dec 2021 20:45:23 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] dmaengine: rcar-dmac: Add support for R-Car S4-8
Date:   Wed, 22 Dec 2021 20:45:07 +0900
Message-Id: <20211222114507.1252947-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222114507.1252947-1-yoshihiro.shimoda.uh@renesas.com>
References: <20211222114507.1252947-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for R-Car S4-8. We can reuse R-Car V3U code so that
renames variable names as "gen4".

Note that some registers of R-Car V3U do not exist on R-Car S4-8,
but none of them are used by the driver for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 5c7716fd6bc5..481f45c77ce1 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -236,7 +236,7 @@ struct rcar_dmac_of_data {
 #define RCAR_DMAOR_PRI_ROUND_ROBIN	(3 << 8)
 #define RCAR_DMAOR_AE			(1 << 2)
 #define RCAR_DMAOR_DME			(1 << 0)
-#define RCAR_DMACHCLR			0x0080	/* Not on R-Car V3U */
+#define RCAR_DMACHCLR			0x0080	/* Not on R-Car Gen4 */
 #define RCAR_DMADPSEC			0x00a0
 
 #define RCAR_DMASAR			0x0000
@@ -299,8 +299,8 @@ struct rcar_dmac_of_data {
 #define RCAR_DMAFIXDAR			0x0014
 #define RCAR_DMAFIXDPBASE		0x0060
 
-/* For R-Car V3U */
-#define RCAR_V3U_DMACHCLR		0x0100
+/* For R-Car Gen4 */
+#define RCAR_GEN4_DMACHCLR		0x0100
 
 /* Hardcode the MEMCPY transfer size to 4 bytes. */
 #define RCAR_DMAC_MEMCPY_XFER_SIZE	4
@@ -345,7 +345,7 @@ static void rcar_dmac_chan_clear(struct rcar_dmac *dmac,
 				 struct rcar_dmac_chan *chan)
 {
 	if (dmac->chan_base)
-		rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
+		rcar_dmac_chan_write(chan, RCAR_GEN4_DMACHCLR, 1);
 	else
 		rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
 }
@@ -357,7 +357,7 @@ static void rcar_dmac_chan_clear_all(struct rcar_dmac *dmac)
 
 	if (dmac->chan_base) {
 		for_each_rcar_dmac_chan(i, dmac, chan)
-			rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
+			rcar_dmac_chan_write(chan, RCAR_GEN4_DMACHCLR, 1);
 	} else {
 		rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
 	}
@@ -2009,7 +2009,7 @@ static const struct rcar_dmac_of_data rcar_dmac_data = {
 	.chan_offset_stride	= 0x80,
 };
 
-static const struct rcar_dmac_of_data rcar_v3u_dmac_data = {
+static const struct rcar_dmac_of_data rcar_gen4_dmac_data = {
 	.chan_offset_base	= 0x0,
 	.chan_offset_stride	= 0x1000,
 };
@@ -2018,9 +2018,12 @@ static const struct of_device_id rcar_dmac_of_ids[] = {
 	{
 		.compatible = "renesas,rcar-dmac",
 		.data = &rcar_dmac_data,
+	}, {
+		.compatible = "renesas,rcar-gen4-dmac",
+		.data = &rcar_gen4_dmac_data,
 	}, {
 		.compatible = "renesas,dmac-r8a779a0",
-		.data = &rcar_v3u_dmac_data,
+		.data = &rcar_gen4_dmac_data,
 	},
 	{ /* Sentinel */ }
 };
-- 
2.25.1

