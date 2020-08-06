Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6023E35A
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 22:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHFU7f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 16:59:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56602 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFU7f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Aug 2020 16:59:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 076AnV9p040546;
        Thu, 6 Aug 2020 05:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596710971;
        bh=/TAJIpYqryMmmTpOr2TbNaq9wdkP1C9Qtn8+dcFlgos=;
        h=From:To:CC:Subject:Date;
        b=kCEoiLXsM48Apv1lOQICiH+Ru4e5lLNVgwWRBgob4HWjO97V++CzXICYyZ+FlsPv8
         4AAsd9btlfYgbCPWTAlb3cvZP1LJJ/muzgdhn9l6A6ddyXxwQ/7//65itD7w9+TXfi
         hs0U5LKQiNSBxyaq4HEpqZYn7QUT1Xm2TTjRykME=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 076AnUw6059545;
        Thu, 6 Aug 2020 05:49:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 6 Aug
 2020 05:49:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 6 Aug 2020 05:49:30 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 076AnSCZ111264;
        Thu, 6 Aug 2020 05:49:29 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: of-dma: Fix of_dma_router_xlate's of_dma_xlate handling
Date:   Thu, 6 Aug 2020 13:49:28 +0300
Message-ID: <20200806104928.25975-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

of_dma_xlate callback can return ERR_PTR as well NULL in case of failure.

If error code is returned (not NULL) then the route should be released and
the router should not be registered for the channel.

Fixes: 56f13c0d9524c ("dmaengine: of_dma: Support for DMA routers")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/of-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 863f2aaf5c8f..8a4f608904b9 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -71,12 +71,12 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 
 	chan = ofdma_target->of_dma_xlate(&dma_spec_target, ofdma_target);
-	if (chan) {
-		chan->router = ofdma->dma_router;
-		chan->route_data = route_data;
-	} else {
+	if (IS_ERR_OR_NULL(chan)) {
 		ofdma->dma_router->route_free(ofdma->dma_router->dev,
 					      route_data);
+	} else {
+		chan->router = ofdma->dma_router;
+		chan->route_data = route_data;
 	}
 
 	/*
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

