Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B907758283D
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jul 2022 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiG0OIu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jul 2022 10:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiG0OIt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jul 2022 10:08:49 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7081E039;
        Wed, 27 Jul 2022 07:08:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26RE8dx4117654;
        Wed, 27 Jul 2022 09:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658930920;
        bh=W1dpzknazowI4rhkYIG2Xad2ScFgLmm2L+k7NIGb81o=;
        h=From:To:CC:Subject:Date;
        b=NtbMdYHaReBVTbow+qZrqkjLbg+wVW6QqL3SXIu9DndZCShJnH1Ci44E6ZSd4+mWw
         j9qD4pxRBsvA5BZWeEJDzNrNvn9EtzVslHdZQW/QkfpQBrs9nypMGHp7jkBkaNgv24
         Ekbox8zIs3H3Kpi97sE8vE0wxwQqwB2bIozuNlXg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26RE8dlw021427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jul 2022 09:08:39 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Jul 2022 09:08:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Jul 2022 09:08:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26RE8cbm096255;
        Wed, 27 Jul 2022 09:08:38 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <p.yadav@ti.com>,
        <vaishnav.a@ti.com>, <j-keerthy@ti.com>, <m-khayami@ti.com>,
        <stanley_liu@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma: Reset UDMA_CHAN_RT byte counters to prevent overflow
Date:   Wed, 27 Jul 2022 19:38:37 +0530
Message-ID: <20220727140837.25877-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

UDMA_CHAN_RT_*BCNT_REG stores the real-time channel bytecount statistics.
These registers are 32-bit hardware counters and the driver uses these
counters to monitor the operational progress status for a channel, when
transferring more than 4GB of data it was observed that these counters
overflow and completion calculation of a operation gets affected and the
transfer hangs indefinitely.

This commit adds changes to decrease the byte count for every complete
transaction so that these registers never overflow and the proper byte
count statistics is maintained for ongoing transaction by the RT counters.

Earlier uc->bcnt used to maintain a count of the completed bytes at driver
side, since the RT counters maintain the statistics of current transaction
now, the maintenance of uc->bcnt is not necessary.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
V1->V2 :
        * Update bcnt reset based on uc->desc->dir
        * change order of udma_decrement_byte_counters() to before udma_start()
        * update subsystem tag

 drivers/dma/ti/k3-udma.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 2f0d2c68c93c..39b330ada200 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -300,8 +300,6 @@ struct udma_chan {
 
 	struct udma_tx_drain tx_drain;
 
-	u32 bcnt; /* number of bytes completed since the start of the channel */
-
 	/* Channel configuration parameters */
 	struct udma_chan_config config;
 
@@ -757,6 +755,20 @@ static void udma_reset_rings(struct udma_chan *uc)
 	}
 }
 
+static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
+{
+	if (uc->desc->dir == DMA_DEV_TO_MEM && uc->rchan) {
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
+	} else if (uc->tchan) {
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
+		if (!uc->bchan)
+			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
+	}
+}
+
 static void udma_reset_counters(struct udma_chan *uc)
 {
 	u32 val;
@@ -790,8 +802,6 @@ static void udma_reset_counters(struct udma_chan *uc)
 		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
 		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
 	}
-
-	uc->bcnt = 0;
 }
 
 static int udma_reset_chan(struct udma_chan *uc, bool hard)
@@ -1115,7 +1125,7 @@ static void udma_check_tx_completion(struct work_struct *work)
 		if (uc->desc) {
 			struct udma_desc *d = uc->desc;
 
-			uc->bcnt += d->residue;
+			udma_decrement_byte_counters(uc, d->residue);
 			udma_start(uc);
 			vchan_cookie_complete(&d->vd);
 			break;
@@ -1168,7 +1178,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 				vchan_cyclic_callback(&d->vd);
 			} else {
 				if (udma_is_desc_really_done(uc, d)) {
-					uc->bcnt += d->residue;
+					udma_decrement_byte_counters(uc, d->residue);
 					udma_start(uc);
 					vchan_cookie_complete(&d->vd);
 				} else {
@@ -1204,7 +1214,7 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 			vchan_cyclic_callback(&d->vd);
 		} else {
 			/* TODO: figure out the real amount of data */
-			uc->bcnt += d->residue;
+			udma_decrement_byte_counters(uc, d->residue);
 			udma_start(uc);
 			vchan_cookie_complete(&d->vd);
 		}
@@ -3809,7 +3819,6 @@ static enum dma_status udma_tx_status(struct dma_chan *chan,
 			bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
 		}
 
-		bcnt -= uc->bcnt;
 		if (bcnt && !(bcnt % uc->desc->residue))
 			residue = 0;
 		else
-- 
2.17.1

