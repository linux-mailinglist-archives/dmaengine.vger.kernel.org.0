Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF5ABAD32D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfIIGfj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 02:35:39 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:61519 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727174AbfIIGfj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 02:35:39 -0400
X-IronPort-AV: E=Sophos;i="5.64,483,1559487600"; 
   d="scan'208";a="25872153"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Sep 2019 15:35:36 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D5DE041A59F7;
        Mon,  9 Sep 2019 15:35:35 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vinod.koul@intel.com
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 4/4] dmaengine: rcar-dmac: Add dma-channel-mask property support
Date:   Mon,  9 Sep 2019 15:34:52 +0900
Message-Id: <1568010892-17606-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds dma-channel-mask property support not to reserve
some DMA channels for some reasons. (for example: a heterogeneous
CPU uses it.)

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 542786d..f06016d 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -203,7 +203,7 @@ struct rcar_dmac {
 
 	unsigned int n_channels;
 	struct rcar_dmac_chan *channels;
-	unsigned int channels_mask;
+	u32 channels_mask;
 
 	DECLARE_BITMAP(modules, 256);
 };
@@ -1810,7 +1810,15 @@ static int rcar_dmac_parse_of(struct device *dev, struct rcar_dmac *dmac)
 		return -EINVAL;
 	}
 
+	/*
+	 * If the driver is unable to read dma-channel-mask property,
+	 * the driver assumes that it can use all channels.
+	 */
 	dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);
+	of_property_read_u32(np, "dma-channel-mask", &dmac->channels_mask);
+
+	/* If the property has out-of-channel mask, this driver clears it */
+	dmac->channels_mask &= GENMASK(dmac->n_channels - 1, 0);
 
 	return 0;
 }
-- 
2.7.4

