Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D29C5876E1
	for <lists+dmaengine@lfdr.de>; Tue,  2 Aug 2022 07:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiHBFsu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Aug 2022 01:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHBFst (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Aug 2022 01:48:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B41A3A8;
        Mon,  1 Aug 2022 22:48:47 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2725mb6Q009641;
        Tue, 2 Aug 2022 00:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659419317;
        bh=8qM0HaK1XtUl0gg6PEXng5wHvX129CzzCPUs4eaT/jw=;
        h=From:To:CC:Subject:Date;
        b=mI94A7TEM3lg1NBqeHQoLngtkqSkV0EVdqOBxx2Bf+RyxLRCO90EMrdUhs+mMSAyZ
         VXSlko1mxJkEuY4T80ExIofjgbYlBZagHIewT5Cb6m7it/gSo2TfjyWHo2Mm/OQ+Wt
         OCURb0fEjrrWZxcflQsy09TVc0JyNK5/8Gz8diPk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2725mbTl025204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Aug 2022 00:48:37 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 2
 Aug 2022 00:48:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 2 Aug 2022 00:48:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2725mZnR018555;
        Tue, 2 Aug 2022 00:48:36 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <vaishnav.a@ti.com>,
        <j-keerthy@ti.com>, <m-khayami@ti.com>, <stanley_liu@ti.com>
Subject: [PATCH v3] dmaengine: ti: k3-udma: Reset UDMA_CHAN_RT byte counters to prevent overflow
Date:   Tue, 2 Aug 2022 11:18:35 +0530
Message-ID: <20220802054835.19482-1-vaishnav.a@ti.com>
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
V2->V3 :
		* Remove unnecessary checks for uc->tchan and uc->rchan in 
		udma_decrement_byte_counters()
V1->V2 :
		* Update bcnt reset based on uc->desc->dir
		* change order of udma_decrement_byte_counters() to before udma_start()
		* update subsystem tag

 drivers/dma/ti/k3-udma.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 2f0d2c68c93c..fcfcde947b30 100644
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
+	if (uc->desc->dir == DMA_DEV_TO_MEM) {
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
+	} else {
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

