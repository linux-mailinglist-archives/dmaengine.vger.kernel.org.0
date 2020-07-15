Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26F220D90
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgGONBd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 09:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGONBd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 09:01:33 -0400
Received: from localhost.localdomain (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A59220657;
        Wed, 15 Jul 2020 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594818092;
        bh=SZ93HvN5hT6+SbAbEMCbWN+cCEkXYiCiaxjJCORj4vA=;
        h=From:To:Cc:Subject:Date:From;
        b=mFkrVXx991rb6Q2Vgw0Woxo9kEiRRm1FatgxdV6hQS+atmhVJff5VMbjD85Wuve8/
         BEx8NtB50ySWa5YVzAd/brMyKLe1yDOiSMYIb8zBp2ReOMvxZMlMKqHnvXxYfnzprH
         l4jZo7RviEbInXImJgWynSLywuBbXe7ZLaS+ZK94=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: remove always true comparisons
Date:   Wed, 15 Jul 2020 18:31:22 +0530
Message-Id: <20200715130122.39873-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

sdmac->event_id0 is of type unsigned int and hence can never be less
than zero. Driver compares this at couple of places with greater than or
equal to zero, these are always true so should be dropped

drivers/dma/imx-sdma.c:1336:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
drivers/dma/imx-sdma.c:1637:23: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b8cfc9d5f1a2..4f8d8f5e1132 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1333,8 +1333,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_channel_synchronize(chan);
 
-	if (sdmac->event_id0 >= 0)
-		sdma_event_disable(sdmac, sdmac->event_id0);
+	sdma_event_disable(sdmac, sdmac->event_id0);
 	if (sdmac->event_id1)
 		sdma_event_disable(sdmac, sdmac->event_id1);
 
@@ -1634,11 +1633,9 @@ static int sdma_config(struct dma_chan *chan,
 	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
 
 	/* Set ENBLn earlier to make sure dma request triggered after that */
-	if (sdmac->event_id0 >= 0) {
-		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
-			return -EINVAL;
-		sdma_event_enable(sdmac, sdmac->event_id0);
-	}
+	if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
+		return -EINVAL;
+	sdma_event_enable(sdmac, sdmac->event_id0);
 
 	if (sdmac->event_id1) {
 		if (sdmac->event_id1 >= sdmac->sdma->drvdata->num_events)
-- 
2.26.2

