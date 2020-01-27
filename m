Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4814A4D2
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 14:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA0NUf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 08:20:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32878 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgA0NUe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jan 2020 08:20:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKUlr010359;
        Mon, 27 Jan 2020 07:20:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580131230;
        bh=WZX9hw0vJrnRoLJJ8uDBMetTVF4QumnXa6t16GcKdt4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hbfAPkgrrpN9SLEPmiffpjHUzSUK4ArBQUM1sN9Eq8rEC00W9z6w3lYLME7VbXlS8
         5PzM3YHFazw6d8dzul2Rc9/rjRlQg00liI33lukyPDYTlz4LPi9HRAzPbIgFnGCrT8
         ysmw7j+ziWcNavSrqiIImPbeHf+Zei8Q2aPc0niw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKUiS118170;
        Mon, 27 Jan 2020 07:20:30 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 07:20:29 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 07:20:29 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKPa3020427;
        Mon, 27 Jan 2020 07:20:27 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH for-next 1/4] dmaengine: ti: k3-udma: Use ktime/usleep_range based TX completion check
Date:   Mon, 27 Jan 2020 15:21:08 +0200
Message-ID: <20200127132111.20464-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200127132111.20464-1-peter.ujfalusi@ti.com>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

In some cases (McSPI for example) the jiffie and delayed_work based
workaround can cause big throughput drop.

Switch to use ktime/usleep_range based implementation to be able
to sustain speed for PDMA based peripherals.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 80 ++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ea79c2df28e0..fb59c869a6a7 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
@@ -169,7 +170,7 @@ enum udma_chan_state {
 
 struct udma_tx_drain {
 	struct delayed_work work;
-	unsigned long jiffie;
+	ktime_t tstamp;
 	u32 residue;
 };
 
@@ -946,9 +947,10 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
 	peer_bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG);
 	bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_BCNT_REG);
 
+	/* Transfer is incomplete, store current residue and time stamp */
 	if (peer_bcnt < bcnt) {
 		uc->tx_drain.residue = bcnt - peer_bcnt;
-		uc->tx_drain.jiffie = jiffies;
+		uc->tx_drain.tstamp = ktime_get();
 		return false;
 	}
 
@@ -961,35 +963,59 @@ static void udma_check_tx_completion(struct work_struct *work)
 					    tx_drain.work.work);
 	bool desc_done = true;
 	u32 residue_diff;
-	unsigned long jiffie_diff, delay;
+	ktime_t time_diff;
+	unsigned long delay;
+
+	while (1) {
+		if (uc->desc) {
+			/* Get previous residue and time stamp */
+			residue_diff = uc->tx_drain.residue;
+			time_diff = uc->tx_drain.tstamp;
+			/*
+			 * Get current residue and time stamp or see if
+			 * transfer is complete
+			 */
+			desc_done = udma_is_desc_really_done(uc, uc->desc);
+		}
 
-	if (uc->desc) {
-		residue_diff = uc->tx_drain.residue;
-		jiffie_diff = uc->tx_drain.jiffie;
-		desc_done = udma_is_desc_really_done(uc, uc->desc);
-	}
-
-	if (!desc_done) {
-		jiffie_diff = uc->tx_drain.jiffie - jiffie_diff;
-		residue_diff -= uc->tx_drain.residue;
-		if (residue_diff) {
-			/* Try to guess when we should check next time */
-			residue_diff /= jiffie_diff;
-			delay = uc->tx_drain.residue / residue_diff / 3;
-			if (jiffies_to_msecs(delay) < 5)
-				delay = 0;
-		} else {
-			/* No progress, check again in 1 second  */
-			delay = HZ;
+		if (!desc_done) {
+			/*
+			 * Find the time delta and residue delta w.r.t
+			 * previous poll
+			 */
+			time_diff = ktime_sub(uc->tx_drain.tstamp,
+					      time_diff) + 1;
+			residue_diff -= uc->tx_drain.residue;
+			if (residue_diff) {
+				/*
+				 * Try to guess when we should check
+				 * next time by calculating rate at
+				 * which data is being drained at the
+				 * peer device
+				 */
+				delay = (time_diff / residue_diff) *
+					uc->tx_drain.residue;
+			} else {
+				/* No progress, check again in 1 second  */
+				schedule_delayed_work(&uc->tx_drain.work, HZ);
+				break;
+			}
+
+			usleep_range(ktime_to_us(delay),
+				     ktime_to_us(delay) + 10);
+			continue;
 		}
 
-		schedule_delayed_work(&uc->tx_drain.work, delay);
-	} else if (uc->desc) {
-		struct udma_desc *d = uc->desc;
+		if (uc->desc) {
+			struct udma_desc *d = uc->desc;
+
+			uc->bcnt += d->residue;
+			udma_start(uc);
+			vchan_cookie_complete(&d->vd);
+			break;
+		}
 
-		uc->bcnt += d->residue;
-		udma_start(uc);
-		vchan_cookie_complete(&d->vd);
+		break;
 	}
 }
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

