Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5404510F18D
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2019 21:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfLBUbq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Dec 2019 15:31:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40430 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfLBUbq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Dec 2019 15:31:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB2KVa8I017066;
        Mon, 2 Dec 2019 14:31:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575318696;
        bh=NofGx1mubkA1EF/TY40DJFtjPM3r2emRLLltVThbzP8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mFUq2q2P8wJLFE2MQBK5ogk/TlxF0z+0paKs0DaMBRaVo80E4zrbybKpgt9xkdn0R
         GUXzmnKPT/j2voBnFCODZtQ3Mmgk3IMX27vPLLunqEpmmFQRei4bMqQ4EkdJISVUN2
         kAJkhbwPjp0tmmzqRNQ/nlKJHlhrQKmtVlZohYr0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB2KVaV3116999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Dec 2019 14:31:36 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Dec
 2019 14:31:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Dec 2019 14:31:35 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB2KVOPo106889;
        Mon, 2 Dec 2019 14:31:33 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <vigneshr@ti.com>
Subject: [PATCH 3/3] dmaengine: ti: k3-udma: Fix early TX completion against PDMAs
Date:   Mon, 2 Dec 2019 22:31:28 +0200
Message-ID: <20191202203128.14348-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202203128.14348-1-peter.ujfalusi@ti.com>
References: <0191128105945.13071-1-peter.ujfalusi@ti.com>
 <20191202203128.14348-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the peripheral is disabled (or it is not able to send out data) the
UDMAP will complete a 'short' transfer. In other words: if the amount of
data can fit into PSI-L and PDMA (and peripheral FIFO) then UDMAP will
send out the data and return as the transfer is completed, however the
peripheral did not actually received all the data.

It was wrong to issue a normal teardown on the channel for several reasons:
UDMAP is not processing any packet so it will just return the TDCM and if
the peripheral is not consuming data from PDMA then we will have constant
flood of TDCMs (interrupts).
After the teardown the channel will be in reset state and we would need to
reset the rings as well, but it can not be done in interrupt context.
If the peripheral is just slow to consume data or even there is a delay
between starting the DMA then we will have again issues detecting the
state.

We could set force teardown, but that will make PDMA to discard the data
which is not correct in case of slow or delayed transfer start on the
peripheral.

The only solution is to use a work and check the progress in there after
the descriptor is returned and the UDMA and PDMA counters are not showing
the same number of bytes processed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 74 ++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 3aede5db9604..39ca371a67dd 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -165,10 +165,15 @@ struct udma_desc {
 enum udma_chan_state {
 	UDMA_CHAN_IS_IDLE = 0, /* not active, no teardown is in progress */
 	UDMA_CHAN_IS_ACTIVE, /* Normal operation */
-	UDMA_CHAN_IS_ACTIVE_FLUSH, /* Flushing for delayed tx */
 	UDMA_CHAN_IS_TERMINATING, /* channel is being terminated */
 };
 
+struct udma_tx_drain {
+	struct delayed_work work;
+	unsigned long jiffie;
+	u32 residue;
+};
+
 struct udma_chan {
 	struct virt_dma_chan vc;
 	struct dma_slave_config	cfg;
@@ -193,6 +198,8 @@ struct udma_chan {
 	enum udma_chan_state state;
 	struct completion teardown_completed;
 
+	struct udma_tx_drain tx_drain;
+
 	u32 bcnt; /* number of bytes completed since the start of the channel */
 	u32 in_ring_cnt; /* number of descriptors in flight */
 
@@ -928,22 +935,51 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
 	peer_bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG);
 	bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_BCNT_REG);
 
-	if (peer_bcnt < bcnt)
+	if (peer_bcnt < bcnt) {
+		uc->tx_drain.residue = bcnt - peer_bcnt;
+		uc->tx_drain.jiffie = jiffies;
 		return false;
+	}
 
 	return true;
 }
 
-static void udma_flush_tx(struct udma_chan *uc)
+static void udma_check_tx_completion(struct work_struct *work)
 {
-	if (uc->dir != DMA_MEM_TO_DEV)
-		return;
+	struct udma_chan *uc = container_of(work, typeof(*uc),
+					    tx_drain.work.work);
+	bool desc_done = true;
+	u32 residue_diff;
+	unsigned long jiffie_diff, delay;
+
+	if (uc->desc) {
+		residue_diff = uc->tx_drain.residue;
+		jiffie_diff = uc->tx_drain.jiffie;
+		desc_done = udma_is_desc_really_done(uc, uc->desc);
+	}
+
+	if (!desc_done) {
+		jiffie_diff = uc->tx_drain.jiffie - jiffie_diff;
+		residue_diff -= uc->tx_drain.residue;
+		if (residue_diff) {
+			/* Try to guess when we should check next time */
+			residue_diff /= jiffie_diff;
+			delay = uc->tx_drain.residue / residue_diff / 3;
+			if (jiffies_to_msecs(delay) < 5)
+				delay = 0;
+		} else {
+			/* No progress, check again in 1 second  */
+			delay = HZ;
+		}
 
-	uc->state = UDMA_CHAN_IS_ACTIVE_FLUSH;
+		schedule_delayed_work(&uc->tx_drain.work, delay);
+	} else if (uc->desc) {
+		struct udma_desc *d = uc->desc;
 
-	udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
-			   UDMA_CHAN_RT_CTL_EN |
-			   UDMA_CHAN_RT_CTL_TDOWN);
+		uc->bcnt += d->residue;
+		udma_start(uc);
+		vchan_cookie_complete(&d->vd);
+	}
 }
 
 static irqreturn_t udma_ring_irq_handler(int irq, void *data)
@@ -973,11 +1009,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 		if (!uc->desc)
 			udma_start(uc);
 
-		if (uc->state != UDMA_CHAN_IS_ACTIVE_FLUSH)
-			goto out;
-		else if (uc->desc)
-			paddr = udma_curr_cppi5_desc_paddr(uc->desc,
-							   uc->desc->desc_idx);
+		goto out;
 	}
 
 	d = udma_udma_desc_from_paddr(uc, paddr);
@@ -997,7 +1029,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 				vchan_cyclic_callback(&d->vd);
 			}
 		} else {
-			bool desc_done = true;
+			bool desc_done = false;
 
 			if (d == uc->desc) {
 				desc_done = udma_is_desc_really_done(uc, d);
@@ -1006,10 +1038,9 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 					uc->bcnt += d->residue;
 					udma_start(uc);
 				} else {
-					udma_flush_tx(uc);
+					schedule_delayed_work(&uc->tx_drain.work,
+							      0);
 				}
-			} else if (d == uc->terminated_desc) {
-				uc->terminated_desc = NULL;
 			}
 
 			if (desc_done)
@@ -1818,6 +1849,8 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	udma_reset_rings(uc);
 
+	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
+				  udma_check_tx_completion);
 	return 0;
 
 err_irq_free:
@@ -2727,6 +2760,7 @@ static int udma_terminate_all(struct dma_chan *chan)
 		uc->terminated_desc = uc->desc;
 		uc->desc = NULL;
 		uc->terminated_desc->terminated = true;
+		cancel_delayed_work(&uc->tx_drain.work);
 	}
 
 	uc->paused = false;
@@ -2760,6 +2794,7 @@ static void udma_synchronize(struct dma_chan *chan)
 	if (udma_is_chan_running(uc))
 		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
 
+	cancel_delayed_work_sync(&uc->tx_drain.work);
 	udma_reset_rings(uc);
 }
 
@@ -2847,6 +2882,9 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 		udma_reset_rings(uc);
 	}
 
+	cancel_delayed_work_sync(&uc->tx_drain.work);
+	destroy_delayed_work_on_stack(&uc->tx_drain.work);
+
 	if (uc->irq_num_ring > 0) {
 		free_irq(uc->irq_num_ring, uc);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

