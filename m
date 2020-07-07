Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA82168D3
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgGGJJq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 05:09:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60484 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgGGJJq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 05:09:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06799hLo049850;
        Tue, 7 Jul 2020 04:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594112983;
        bh=BrdSrBXGmHtZ3PmOrI1bLu05LqBB8fNfc7CyBn4OSVc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vHSMYt0JdFZq8UvQyC5H5tLG45Ced/Zh+SXRNaJDSH9DqSBGoOXF32erVa7DZwMdo
         jvEC3iqYt8Fzq/TCb0v366QOgafefFvH7TKLaPpSIe2+N988hht4zWoK34QjjhrsLz
         aCw7kBTWTfDFdVSfWBjlFUrfDdhFA3cNJUQLPag0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06799hrj036901;
        Tue, 7 Jul 2020 04:09:43 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 04:09:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 04:09:42 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06799RGq052457;
        Tue, 7 Jul 2020 04:09:41 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH 5/5] dmaengine: ti: k3-udma: Use udma_chan instead of tchan/rchan for IO functions
Date:   Tue, 7 Jul 2020 12:10:31 +0300
Message-ID: <20200707091031.10411-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707091031.10411-1-peter.ujfalusi@ti.com>
References: <20200707091031.10411-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the uc->tchan/rchan checks to the IO wrappers itself instead of
calling the functions with tchan/rchan directly.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 163 +++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 85 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7eae3a3d0703..8b9a3829abc2 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -282,51 +282,49 @@ static inline void udma_update_bits(void __iomem *base, int reg,
 }
 
 /* TCHANRT */
-static inline u32 udma_tchanrt_read(struct udma_tchan *tchan, int reg)
+static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
 {
-	if (!tchan)
+	if (!uc || !uc->tchan)
 		return 0;
-	return udma_read(tchan->reg_rt, reg);
+	return udma_read(uc->tchan->reg_rt, reg);
 }
 
-static inline void udma_tchanrt_write(struct udma_tchan *tchan, int reg,
-				      u32 val)
+static inline void udma_tchanrt_write(struct udma_chan *uc, int reg, u32 val)
 {
-	if (!tchan)
+	if (!uc || !uc->tchan)
 		return;
-	udma_write(tchan->reg_rt, reg, val);
+	udma_write(uc->tchan->reg_rt, reg, val);
 }
 
-static inline void udma_tchanrt_update_bits(struct udma_tchan *tchan, int reg,
+static inline void udma_tchanrt_update_bits(struct udma_chan *uc, int reg,
 					    u32 mask, u32 val)
 {
-	if (!tchan)
+	if (!uc || !uc->tchan)
 		return;
-	udma_update_bits(tchan->reg_rt, reg, mask, val);
+	udma_update_bits(uc->tchan->reg_rt, reg, mask, val);
 }
 
 /* RCHANRT */
-static inline u32 udma_rchanrt_read(struct udma_rchan *rchan, int reg)
+static inline u32 udma_rchanrt_read(struct udma_chan *uc, int reg)
 {
-	if (!rchan)
+	if (!uc || !uc->rchan)
 		return 0;
-	return udma_read(rchan->reg_rt, reg);
+	return udma_read(uc->rchan->reg_rt, reg);
 }
 
-static inline void udma_rchanrt_write(struct udma_rchan *rchan, int reg,
-				      u32 val)
+static inline void udma_rchanrt_write(struct udma_chan *uc, int reg, u32 val)
 {
-	if (!rchan)
+	if (!uc || !uc->rchan)
 		return;
-	udma_write(rchan->reg_rt, reg, val);
+	udma_write(uc->rchan->reg_rt, reg, val);
 }
 
-static inline void udma_rchanrt_update_bits(struct udma_rchan *rchan, int reg,
+static inline void udma_rchanrt_update_bits(struct udma_chan *uc, int reg,
 					    u32 mask, u32 val)
 {
-	if (!rchan)
+	if (!uc || !uc->rchan)
 		return;
-	udma_update_bits(rchan->reg_rt, reg, mask, val);
+	udma_update_bits(uc->rchan->reg_rt, reg, mask, val);
 }
 
 static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
@@ -368,7 +366,7 @@ static void udma_dump_chan_stdata(struct udma_chan *uc)
 		for (i = 0; i < 32; i++) {
 			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
 			dev_dbg(dev, "TRT_STDATA[%02d]: 0x%08x\n", i,
-				udma_tchanrt_read(uc->tchan, offset));
+				udma_tchanrt_read(uc, offset));
 		}
 	}
 
@@ -377,7 +375,7 @@ static void udma_dump_chan_stdata(struct udma_chan *uc)
 		for (i = 0; i < 32; i++) {
 			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
 			dev_dbg(dev, "RRT_STDATA[%02d]: 0x%08x\n", i,
-				udma_rchanrt_read(uc->rchan, offset));
+				udma_rchanrt_read(uc, offset));
 		}
 	}
 }
@@ -500,9 +498,9 @@ static bool udma_is_chan_running(struct udma_chan *uc)
 	u32 rrt_ctl = 0;
 
 	if (uc->tchan)
-		trt_ctl = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_CTL_REG);
+		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
 	if (uc->rchan)
-		rrt_ctl = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_CTL_REG);
+		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
 
 	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
 		return true;
@@ -516,15 +514,15 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
 
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
-		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_PEER_RT_EN_REG);
+		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_PEER_RT_EN_REG);
 		pause_mask = UDMA_PEER_RT_EN_PAUSE;
 		break;
 	case DMA_MEM_TO_DEV:
-		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_PEER_RT_EN_REG);
+		val = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_RT_EN_REG);
 		pause_mask = UDMA_PEER_RT_EN_PAUSE;
 		break;
 	case DMA_MEM_TO_MEM:
-		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_CTL_REG);
+		val = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
 		pause_mask = UDMA_CHAN_RT_CTL_PAUSE;
 		break;
 	default:
@@ -658,31 +656,31 @@ static void udma_reset_counters(struct udma_chan *uc)
 	u32 val;
 
 	if (uc->tchan) {
-		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_BCNT_REG);
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_BCNT_REG, val);
+		val = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
 
-		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_SBCNT_REG);
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_SBCNT_REG, val);
+		val = udma_tchanrt_read(uc, UDMA_CHAN_RT_SBCNT_REG);
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
 
-		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_PCNT_REG);
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PCNT_REG, val);
+		val = udma_tchanrt_read(uc, UDMA_CHAN_RT_PCNT_REG);
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_PCNT_REG, val);
 
-		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_PEER_BCNT_REG);
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PEER_BCNT_REG, val);
+		val = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
 	}
 
 	if (uc->rchan) {
-		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_BCNT_REG);
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_BCNT_REG, val);
+		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
 
-		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_SBCNT_REG);
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_SBCNT_REG, val);
+		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_SBCNT_REG);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
 
-		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_PCNT_REG);
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PCNT_REG, val);
+		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_PCNT_REG);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_PCNT_REG, val);
 
-		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_PEER_BCNT_REG);
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PEER_BCNT_REG, val);
+		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
 	}
 
 	uc->bcnt = 0;
@@ -692,16 +690,16 @@ static int udma_reset_chan(struct udma_chan *uc, bool hard)
 {
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG, 0);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_CTL_REG, 0);
 		break;
 	case DMA_MEM_TO_DEV:
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG, 0);
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_CTL_REG, 0);
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG, 0);
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG, 0);
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_CTL_REG, 0);
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_CTL_REG, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -729,7 +727,7 @@ static int udma_reset_chan(struct udma_chan *uc, bool hard)
 		 * the rchan.
 		 */
 		if (uc->config.dir == DMA_DEV_TO_MEM)
-			udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG,
+			udma_rchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
 					   UDMA_CHAN_RT_CTL_EN |
 					   UDMA_CHAN_RT_CTL_TDOWN |
 					   UDMA_CHAN_RT_CTL_FTDOWN);
@@ -806,10 +804,11 @@ static int udma_start(struct udma_chan *uc)
 			if (uc->config.enable_burst)
 				val |= PDMA_STATIC_TR_XY_BURST;
 
-			udma_rchanrt_write(uc->rchan,
-				UDMA_CHAN_RT_PEER_STATIC_TR_XY_REG, val);
+			udma_rchanrt_write(uc,
+					   UDMA_CHAN_RT_PEER_STATIC_TR_XY_REG,
+					   val);
 
-			udma_rchanrt_write(uc->rchan,
+			udma_rchanrt_write(uc,
 				UDMA_CHAN_RT_PEER_STATIC_TR_Z_REG,
 				PDMA_STATIC_TR_Z(uc->desc->static_tr.bstcnt,
 						 match_data->statictr_z_mask));
@@ -819,11 +818,11 @@ static int udma_start(struct udma_chan *uc)
 			       sizeof(uc->static_tr));
 		}
 
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG,
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN);
 
 		/* Enable remote */
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PEER_RT_EN_REG,
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE);
 
 		break;
@@ -838,8 +837,9 @@ static int udma_start(struct udma_chan *uc)
 			if (uc->config.enable_burst)
 				val |= PDMA_STATIC_TR_XY_BURST;
 
-			udma_tchanrt_write(uc->tchan,
-				UDMA_CHAN_RT_PEER_STATIC_TR_XY_REG, val);
+			udma_tchanrt_write(uc,
+					   UDMA_CHAN_RT_PEER_STATIC_TR_XY_REG,
+					   val);
 
 			/* save the current staticTR configuration */
 			memcpy(&uc->static_tr, &uc->desc->static_tr,
@@ -847,17 +847,17 @@ static int udma_start(struct udma_chan *uc)
 		}
 
 		/* Enable remote */
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PEER_RT_EN_REG,
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE);
 
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG,
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN);
 
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG,
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN);
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG,
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN);
 
 		break;
@@ -883,20 +883,20 @@ static int udma_stop(struct udma_chan *uc)
 		if (!uc->cyclic && !uc->desc)
 			udma_push_to_ring(uc, -1);
 
-		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PEER_RT_EN_REG,
+		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE |
 				   UDMA_PEER_RT_EN_TEARDOWN);
 		break;
 	case DMA_MEM_TO_DEV:
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PEER_RT_EN_REG,
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE |
 				   UDMA_PEER_RT_EN_FLUSH);
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG,
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN |
 				   UDMA_CHAN_RT_CTL_TDOWN);
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG,
+		udma_tchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN |
 				   UDMA_CHAN_RT_CTL_TDOWN);
 		break;
@@ -936,8 +936,8 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
 	    uc->config.dir != DMA_MEM_TO_DEV)
 		return true;
 
-	peer_bcnt = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_PEER_BCNT_REG);
-	bcnt = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_BCNT_REG);
+	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
+	bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
 
 	/* Transfer is incomplete, store current residue and time stamp */
 	if (peer_bcnt < bcnt) {
@@ -2736,30 +2736,27 @@ static enum dma_status udma_tx_status(struct dma_chan *chan,
 		u32 delay = 0;
 
 		if (uc->desc->dir == DMA_MEM_TO_DEV) {
-			bcnt = udma_tchanrt_read(uc->tchan,
-						 UDMA_CHAN_RT_SBCNT_REG);
+			bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_SBCNT_REG);
 
 			if (uc->config.ep_type != PSIL_EP_NATIVE) {
-				peer_bcnt = udma_tchanrt_read(uc->tchan,
+				peer_bcnt = udma_tchanrt_read(uc,
 						UDMA_CHAN_RT_PEER_BCNT_REG);
 
 				if (bcnt > peer_bcnt)
 					delay = bcnt - peer_bcnt;
 			}
 		} else if (uc->desc->dir == DMA_DEV_TO_MEM) {
-			bcnt = udma_rchanrt_read(uc->rchan,
-						 UDMA_CHAN_RT_BCNT_REG);
+			bcnt = udma_rchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
 
 			if (uc->config.ep_type != PSIL_EP_NATIVE) {
-				peer_bcnt = udma_rchanrt_read(uc->rchan,
+				peer_bcnt = udma_rchanrt_read(uc,
 						UDMA_CHAN_RT_PEER_BCNT_REG);
 
 				if (peer_bcnt > bcnt)
 					delay = peer_bcnt - bcnt;
 			}
 		} else {
-			bcnt = udma_tchanrt_read(uc->tchan,
-						 UDMA_CHAN_RT_BCNT_REG);
+			bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
 		}
 
 		bcnt -= uc->bcnt;
@@ -2792,19 +2789,17 @@ static int udma_pause(struct dma_chan *chan)
 	/* pause the channel */
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
-		udma_rchanrt_update_bits(uc->rchan,
-					 UDMA_CHAN_RT_PEER_RT_EN_REG,
+		udma_rchanrt_update_bits(uc, UDMA_CHAN_RT_PEER_RT_EN_REG,
 					 UDMA_PEER_RT_EN_PAUSE,
 					 UDMA_PEER_RT_EN_PAUSE);
 		break;
 	case DMA_MEM_TO_DEV:
-		udma_tchanrt_update_bits(uc->tchan,
-					 UDMA_CHAN_RT_PEER_RT_EN_REG,
+		udma_tchanrt_update_bits(uc, UDMA_CHAN_RT_PEER_RT_EN_REG,
 					 UDMA_PEER_RT_EN_PAUSE,
 					 UDMA_PEER_RT_EN_PAUSE);
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_tchanrt_update_bits(uc->tchan, UDMA_CHAN_RT_CTL_REG,
+		udma_tchanrt_update_bits(uc, UDMA_CHAN_RT_CTL_REG,
 					 UDMA_CHAN_RT_CTL_PAUSE,
 					 UDMA_CHAN_RT_CTL_PAUSE);
 		break;
@@ -2822,18 +2817,16 @@ static int udma_resume(struct dma_chan *chan)
 	/* resume the channel */
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
-		udma_rchanrt_update_bits(uc->rchan,
-					 UDMA_CHAN_RT_PEER_RT_EN_REG,
+		udma_rchanrt_update_bits(uc, UDMA_CHAN_RT_PEER_RT_EN_REG,
 					 UDMA_PEER_RT_EN_PAUSE, 0);
 
 		break;
 	case DMA_MEM_TO_DEV:
-		udma_tchanrt_update_bits(uc->tchan,
-					 UDMA_CHAN_RT_PEER_RT_EN_REG,
+		udma_tchanrt_update_bits(uc, UDMA_CHAN_RT_PEER_RT_EN_REG,
 					 UDMA_PEER_RT_EN_PAUSE, 0);
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_tchanrt_update_bits(uc->tchan, UDMA_CHAN_RT_CTL_REG,
+		udma_tchanrt_update_bits(uc, UDMA_CHAN_RT_CTL_REG,
 					 UDMA_CHAN_RT_CTL_PAUSE, 0);
 		break;
 	default:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

