Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A738963A375
	for <lists+dmaengine@lfdr.de>; Mon, 28 Nov 2022 09:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiK1IuU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Nov 2022 03:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiK1IuT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Nov 2022 03:50:19 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346DF13D04;
        Mon, 28 Nov 2022 00:50:18 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AS8o68r018476;
        Mon, 28 Nov 2022 02:50:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669625406;
        bh=DQNrsU8IiF8WI8UQ+e/aChGxFx+bAZOLsI3Y9apKOzc=;
        h=From:To:CC:Subject:Date;
        b=fy5+Mq9nsFr6T6OUFkaP/Fi3oBSllu2f2Zzm8ZcCy/k4fKqeVqh+TGXA6in0Z+HK4
         Ofm8oLtsIZIn1T29d6zEWb4y03FwAkMUnRaSIj+8HxHG04NH6AVD3r4qUbIGGT2NLL
         qbw3Ys1qvYCTDU0cZye5nae+lk3lNMxYXSz31p1A=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AS8o6l8052213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Nov 2022 02:50:06 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 28
 Nov 2022 02:50:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 28 Nov 2022 02:50:06 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AS8o5UB016193;
        Mon, 28 Nov 2022 02:50:06 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <vkoul@kernel.org>, <peter.ujfalusi@gmail.com>
CC:     <vaishnav.a@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Do conditional decrement of UDMA_CHAN_RT_PEER_BCNT_REG
Date:   Mon, 28 Nov 2022 14:20:05 +0530
Message-ID: <20221128085005.489964-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PSIL_EP_NATIVE endpoints may not have PEER registers for BCNT and thus
udma_decrement_byte_counters() should not try to decrement these counters.
This fixes the issue of crypto IPERF testing where the client side (EVM)
hangs without transfer of packets to the server side, seen since this
function was added.

Fixes: 7c94dcfa8fcf ("dmaengine: ti: k3-udma: Reset UDMA_CHAN_RT byte counters to prevent overflow")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/dma/ti/k3-udma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..4c62274e0b33 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -762,11 +762,12 @@ static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
 	if (uc->desc->dir == DMA_DEV_TO_MEM) {
 		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
 		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
-		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
+		if (uc->config.ep_type != PSIL_EP_NATIVE)
+			udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
 	} else {
 		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
 		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
-		if (!uc->bchan)
+		if (!uc->bchan && uc->config.ep_type != PSIL_EP_NATIVE)
 			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
 	}
 }
-- 
2.25.1

