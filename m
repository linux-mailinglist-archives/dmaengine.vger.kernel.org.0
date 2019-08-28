Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2BD3A0095
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 13:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfH1LPk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 07:15:40 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:61955 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726341AbfH1LPk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Aug 2019 07:15:40 -0400
X-IronPort-AV: E=Sophos;i="5.64,440,1559487600"; 
   d="scan'208";a="25148807"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Aug 2019 20:15:37 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F8C342296E7;
        Wed, 28 Aug 2019 20:15:37 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] dmaengine: rcar-dmac: Add dma-channel-mask property support
Date:   Wed, 28 Aug 2019 20:13:55 +0900
Message-Id: <1566990835-27028-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1566990835-27028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds dma-channel-mask property support not to reserve
some DMA channels for some reasons. (for example: a heterogeneous
CPU uses it.)

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 204160e..bae0fe8 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1806,7 +1806,17 @@ static int rcar_dmac_parse_of(struct device *dev, struct rcar_dmac *dmac)
 		return -EINVAL;
 	}
 
-	dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);
+	/*
+	 * If the driver is unable to read dma-channel-mask property,
+	 * the driver assumes that it can use all channels.
+	 */
+	ret = of_property_read_u32(np, "dma-channel-mask",
+				   &dmac->channels_mask);
+	if (ret < 0)
+		dmac->channels_mask = GENMASK(dmac->n_channels - 1, 0);
+
+	/* If the property has out-of-channel mask, this driver clears it */
+	dmac->channels_mask &= GENMASK(dmac->n_channels - 1, 0);
 
 	return 0;
 }
-- 
2.7.4

