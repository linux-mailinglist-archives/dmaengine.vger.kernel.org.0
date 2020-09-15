Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D21C26B080
	for <lists+dmaengine@lfdr.de>; Wed, 16 Sep 2020 00:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgIOWMt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Sep 2020 18:12:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60022 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgIOQmO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Sep 2020 12:42:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FGfxId105841;
        Tue, 15 Sep 2020 11:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600188119;
        bh=tTmPCwqRfmvgpzkRiQk3JseeSp0Po4Mic5Xi+11jGFw=;
        h=From:To:CC:Subject:Date;
        b=jMbZnOZSXqhaGC7Sj+hUtUnMRXerscAZYD68xFmTlAbIGsd4dy95ALq1bb/MWvaNT
         XHNuDI10+ZaizxPccUY4jokdv8r2hQiH4wrZGUT25Q+tK4KLZpAr1bFQ2KU+PSmRAa
         pLs6uy4owxDaZotSf8yEUXwTpRoQwNejmu3+CR9I=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FGfxrA089950;
        Tue, 15 Sep 2020 11:41:59 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 11:41:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 11:41:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FGfwP8008323;
        Tue, 15 Sep 2020 11:41:58 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma-glue: fix channel enable functions
Date:   Tue, 15 Sep 2020 19:41:49 +0300
Message-ID: <20200915164149.22123-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Now the K3 UDMA glue layer enable functions perform RMW operation on UDMA
RX/TX RT_CTL registers to set EN bit and enable channel, which is
incorrect, because only EN bit has to be set in those registers to enable
channel (all other bits should be cleared 0).
More over, this causes issues when bootloader leaves UDMA channel RX/TX
RT_CTL registers in incorrect state - TDOWN bit set, for example. As
result, UDMA channel will just perform teardown right after it's enabled.

Hence, fix it by writing correct values (EN=1) directly in UDMA channel
RX/TX RT_CTL registers in k3_udma_glue_enable_tx/rx_chn() functions.

Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index dc03880f021a..37d706cf3ba9 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -370,7 +370,6 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_pop_tx_chn);
 
 int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
-	u32 txrt_ctl;
 	int ret;
 
 	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
@@ -383,15 +382,11 @@ int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 
 	tx_chn->psil_paired = true;
 
-	txrt_ctl = UDMA_PEER_RT_EN_ENABLE;
 	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
-			    txrt_ctl);
+			    UDMA_PEER_RT_EN_ENABLE);
 
-	txrt_ctl = xudma_tchanrt_read(tx_chn->udma_tchanx,
-				      UDMA_CHAN_RT_CTL_REG);
-	txrt_ctl |= UDMA_CHAN_RT_CTL_EN;
 	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
-			    txrt_ctl);
+			    UDMA_CHAN_RT_CTL_EN);
 
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn en");
 	return 0;
@@ -1059,7 +1054,6 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_rx_flow_disable);
 
 int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 {
-	u32 rxrt_ctl;
 	int ret;
 
 	if (rx_chn->remote)
@@ -1078,11 +1072,8 @@ int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 
 	rx_chn->psil_paired = true;
 
-	rxrt_ctl = xudma_rchanrt_read(rx_chn->udma_rchanx,
-				      UDMA_CHAN_RT_CTL_REG);
-	rxrt_ctl |= UDMA_CHAN_RT_CTL_EN;
 	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
-			    rxrt_ctl);
+			    UDMA_CHAN_RT_CTL_EN);
 
 	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
 			    UDMA_PEER_RT_EN_ENABLE);
-- 
2.17.1

