Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3353216A1A
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGGKW6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 06:22:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49028 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGGKW6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 06:22:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 067AMt2Z100849;
        Tue, 7 Jul 2020 05:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594117375;
        bh=XLVHWMeRuL4e2B/3uHWBoeHZfmzhF0fHVVDQki/BWPI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C/eKwayT9bLMvrrUeTVZapybjiTr0Tj5ErrhCkXH6ReEr7yJbWrZnm709AAMy5NAq
         wftAzq+PSDNT+Zw96fyUhAPffpZEF3QUm61didx6tK843aRoHzhVpqERxDO1FM9fLP
         1FSGT8C4k62g2bs8OgqutT5ZIGGmgQI0zcoN6Y2E=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067AMtmo012147;
        Tue, 7 Jul 2020 05:22:55 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 05:22:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 05:22:55 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067AMmae054798;
        Tue, 7 Jul 2020 05:22:53 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 3/5] dmaengine: ti: k3-udma: Use common defines for TCHANRT/RCHANRT registers
Date:   Tue, 7 Jul 2020 13:23:50 +0300
Message-ID: <20200707102352.28773-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707102352.28773-1-peter.ujfalusi@ti.com>
References: <20200707102352.28773-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The register offsets and functions are the same among TCHAN and RCHAN.
Use generic, common names for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c |  79 ++++++++++++-----------
 drivers/dma/ti/k3-udma.c      | 114 +++++++++++++++++-----------------
 drivers/dma/ti/k3-udma.h      |  61 +++++++-----------
 3 files changed, 115 insertions(+), 139 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 64c8955e0cf1..d66ed18303a4 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -186,17 +186,17 @@ static void k3_udma_glue_dump_tx_rt_chn(struct k3_udma_glue_tx_channel *chn,
 	struct device *dev = chn->common.dev;
 
 	dev_dbg(dev, "=== dump ===> %s\n", mark);
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_CTL_REG,
-		xudma_tchanrt_read(chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG));
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_PEER_RT_EN_REG,
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_CTL_REG,
+		xudma_tchanrt_read(chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_PEER_RT_EN_REG,
 		xudma_tchanrt_read(chn->udma_tchanx,
-				   UDMA_TCHAN_RT_PEER_RT_EN_REG));
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_PCNT_REG,
-		xudma_tchanrt_read(chn->udma_tchanx, UDMA_TCHAN_RT_PCNT_REG));
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_BCNT_REG,
-		xudma_tchanrt_read(chn->udma_tchanx, UDMA_TCHAN_RT_BCNT_REG));
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_TCHAN_RT_SBCNT_REG,
-		xudma_tchanrt_read(chn->udma_tchanx, UDMA_TCHAN_RT_SBCNT_REG));
+				   UDMA_CHAN_RT_PEER_RT_EN_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_PCNT_REG,
+		xudma_tchanrt_read(chn->udma_tchanx, UDMA_CHAN_RT_PCNT_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_BCNT_REG,
+		xudma_tchanrt_read(chn->udma_tchanx, UDMA_CHAN_RT_BCNT_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_SBCNT_REG,
+		xudma_tchanrt_read(chn->udma_tchanx, UDMA_CHAN_RT_SBCNT_REG));
 }
 
 static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
@@ -389,14 +389,13 @@ int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 	u32 txrt_ctl;
 
 	txrt_ctl = UDMA_PEER_RT_EN_ENABLE;
-	xudma_tchanrt_write(tx_chn->udma_tchanx,
-			    UDMA_TCHAN_RT_PEER_RT_EN_REG,
+	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
 			    txrt_ctl);
 
 	txrt_ctl = xudma_tchanrt_read(tx_chn->udma_tchanx,
-				      UDMA_TCHAN_RT_CTL_REG);
+				      UDMA_CHAN_RT_CTL_REG);
 	txrt_ctl |= UDMA_CHAN_RT_CTL_EN;
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG,
+	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
 			    txrt_ctl);
 
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn en");
@@ -408,10 +407,10 @@ void k3_udma_glue_disable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn dis1");
 
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG, 0);
+	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG, 0);
 
 	xudma_tchanrt_write(tx_chn->udma_tchanx,
-			    UDMA_TCHAN_RT_PEER_RT_EN_REG, 0);
+			    UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn dis2");
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_disable_tx_chn);
@@ -424,14 +423,14 @@ void k3_udma_glue_tdown_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn tdown1");
 
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG,
+	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
 			    UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_TDOWN);
 
-	val = xudma_tchanrt_read(tx_chn->udma_tchanx, UDMA_TCHAN_RT_CTL_REG);
+	val = xudma_tchanrt_read(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG);
 
 	while (sync && (val & UDMA_CHAN_RT_CTL_EN)) {
 		val = xudma_tchanrt_read(tx_chn->udma_tchanx,
-					 UDMA_TCHAN_RT_CTL_REG);
+					 UDMA_CHAN_RT_CTL_REG);
 		udelay(1);
 		if (i > K3_UDMAX_TDOWN_TIMEOUT_US) {
 			dev_err(tx_chn->common.dev, "TX tdown timeout\n");
@@ -441,7 +440,7 @@ void k3_udma_glue_tdown_tx_chn(struct k3_udma_glue_tx_channel *tx_chn,
 	}
 
 	val = xudma_tchanrt_read(tx_chn->udma_tchanx,
-				 UDMA_TCHAN_RT_PEER_RT_EN_REG);
+				 UDMA_CHAN_RT_PEER_RT_EN_REG);
 	if (sync && (val & UDMA_PEER_RT_EN_ENABLE))
 		dev_err(tx_chn->common.dev, "TX tdown peer not stopped\n");
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn tdown2");
@@ -716,17 +715,17 @@ static void k3_udma_glue_dump_rx_rt_chn(struct k3_udma_glue_rx_channel *chn,
 
 	dev_dbg(dev, "=== dump ===> %s\n", mark);
 
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_CTL_REG,
-		xudma_rchanrt_read(chn->udma_rchanx, UDMA_RCHAN_RT_CTL_REG));
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_PEER_RT_EN_REG,
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_CTL_REG,
+		xudma_rchanrt_read(chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_PEER_RT_EN_REG,
 		xudma_rchanrt_read(chn->udma_rchanx,
-				   UDMA_RCHAN_RT_PEER_RT_EN_REG));
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_PCNT_REG,
-		xudma_rchanrt_read(chn->udma_rchanx, UDMA_RCHAN_RT_PCNT_REG));
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_BCNT_REG,
-		xudma_rchanrt_read(chn->udma_rchanx, UDMA_RCHAN_RT_BCNT_REG));
-	dev_dbg(dev, "0x%08X: %08X\n", UDMA_RCHAN_RT_SBCNT_REG,
-		xudma_rchanrt_read(chn->udma_rchanx, UDMA_RCHAN_RT_SBCNT_REG));
+				   UDMA_CHAN_RT_PEER_RT_EN_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_PCNT_REG,
+		xudma_rchanrt_read(chn->udma_rchanx, UDMA_CHAN_RT_PCNT_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_BCNT_REG,
+		xudma_rchanrt_read(chn->udma_rchanx, UDMA_CHAN_RT_BCNT_REG));
+	dev_dbg(dev, "0x%08X: %08X\n", UDMA_CHAN_RT_SBCNT_REG,
+		xudma_rchanrt_read(chn->udma_rchanx, UDMA_CHAN_RT_SBCNT_REG));
 }
 
 static int
@@ -1084,13 +1083,12 @@ int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 		return -EINVAL;
 
 	rxrt_ctl = xudma_rchanrt_read(rx_chn->udma_rchanx,
-				      UDMA_RCHAN_RT_CTL_REG);
+				      UDMA_CHAN_RT_CTL_REG);
 	rxrt_ctl |= UDMA_CHAN_RT_CTL_EN;
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_RCHAN_RT_CTL_REG,
+	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
 			    rxrt_ctl);
 
-	xudma_rchanrt_write(rx_chn->udma_rchanx,
-			    UDMA_RCHAN_RT_PEER_RT_EN_REG,
+	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
 			    UDMA_PEER_RT_EN_ENABLE);
 
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt en");
@@ -1103,9 +1101,8 @@ void k3_udma_glue_disable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt dis1");
 
 	xudma_rchanrt_write(rx_chn->udma_rchanx,
-			    UDMA_RCHAN_RT_PEER_RT_EN_REG,
-			    0);
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_RCHAN_RT_CTL_REG, 0);
+			    UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
+	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG, 0);
 
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt dis2");
 }
@@ -1122,14 +1119,14 @@ void k3_udma_glue_tdown_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt tdown1");
 
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_RCHAN_RT_PEER_RT_EN_REG,
+	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
 			    UDMA_PEER_RT_EN_ENABLE | UDMA_PEER_RT_EN_TEARDOWN);
 
-	val = xudma_rchanrt_read(rx_chn->udma_rchanx, UDMA_RCHAN_RT_CTL_REG);
+	val = xudma_rchanrt_read(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG);
 
 	while (sync && (val & UDMA_CHAN_RT_CTL_EN)) {
 		val = xudma_rchanrt_read(rx_chn->udma_rchanx,
-					 UDMA_RCHAN_RT_CTL_REG);
+					 UDMA_CHAN_RT_CTL_REG);
 		udelay(1);
 		if (i > K3_UDMAX_TDOWN_TIMEOUT_US) {
 			dev_err(rx_chn->common.dev, "RX tdown timeout\n");
@@ -1139,7 +1136,7 @@ void k3_udma_glue_tdown_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 	}
 
 	val = xudma_rchanrt_read(rx_chn->udma_rchanx,
-				 UDMA_RCHAN_RT_PEER_RT_EN_REG);
+				 UDMA_CHAN_RT_PEER_RT_EN_REG);
 	if (sync && (val & UDMA_PEER_RT_EN_ENABLE))
 		dev_err(rx_chn->common.dev, "TX tdown peer not stopped\n");
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt tdown2");
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c2b3792bed54..7eae3a3d0703 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -366,7 +366,7 @@ static void udma_dump_chan_stdata(struct udma_chan *uc)
 	if (uc->config.dir == DMA_MEM_TO_DEV || uc->config.dir == DMA_MEM_TO_MEM) {
 		dev_dbg(dev, "TCHAN State data:\n");
 		for (i = 0; i < 32; i++) {
-			offset = UDMA_TCHAN_RT_STDATA_REG + i * 4;
+			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
 			dev_dbg(dev, "TRT_STDATA[%02d]: 0x%08x\n", i,
 				udma_tchanrt_read(uc->tchan, offset));
 		}
@@ -375,7 +375,7 @@ static void udma_dump_chan_stdata(struct udma_chan *uc)
 	if (uc->config.dir == DMA_DEV_TO_MEM || uc->config.dir == DMA_MEM_TO_MEM) {
 		dev_dbg(dev, "RCHAN State data:\n");
 		for (i = 0; i < 32; i++) {
-			offset = UDMA_RCHAN_RT_STDATA_REG + i * 4;
+			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
 			dev_dbg(dev, "RRT_STDATA[%02d]: 0x%08x\n", i,
 				udma_rchanrt_read(uc->rchan, offset));
 		}
@@ -500,9 +500,9 @@ static bool udma_is_chan_running(struct udma_chan *uc)
 	u32 rrt_ctl = 0;
 
 	if (uc->tchan)
-		trt_ctl = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_CTL_REG);
+		trt_ctl = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_CTL_REG);
 	if (uc->rchan)
-		rrt_ctl = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_CTL_REG);
+		rrt_ctl = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_CTL_REG);
 
 	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
 		return true;
@@ -516,17 +516,15 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
 
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
-		val = udma_rchanrt_read(uc->rchan,
-					UDMA_RCHAN_RT_PEER_RT_EN_REG);
+		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_PEER_RT_EN_REG);
 		pause_mask = UDMA_PEER_RT_EN_PAUSE;
 		break;
 	case DMA_MEM_TO_DEV:
-		val = udma_tchanrt_read(uc->tchan,
-					UDMA_TCHAN_RT_PEER_RT_EN_REG);
+		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_PEER_RT_EN_REG);
 		pause_mask = UDMA_PEER_RT_EN_PAUSE;
 		break;
 	case DMA_MEM_TO_MEM:
-		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_CTL_REG);
+		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_CTL_REG);
 		pause_mask = UDMA_CHAN_RT_CTL_PAUSE;
 		break;
 	default:
@@ -660,31 +658,31 @@ static void udma_reset_counters(struct udma_chan *uc)
 	u32 val;
 
 	if (uc->tchan) {
-		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_BCNT_REG);
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_BCNT_REG, val);
+		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_BCNT_REG);
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_BCNT_REG, val);
 
-		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_SBCNT_REG);
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_SBCNT_REG, val);
+		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_SBCNT_REG);
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_SBCNT_REG, val);
 
-		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PCNT_REG);
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_PCNT_REG, val);
+		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_PCNT_REG);
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PCNT_REG, val);
 
-		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG);
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG, val);
+		val = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_PEER_BCNT_REG);
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PEER_BCNT_REG, val);
 	}
 
 	if (uc->rchan) {
-		val = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_BCNT_REG);
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_BCNT_REG, val);
+		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_BCNT_REG);
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_BCNT_REG, val);
 
-		val = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_SBCNT_REG);
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_SBCNT_REG, val);
+		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_SBCNT_REG);
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_SBCNT_REG, val);
 
-		val = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_PCNT_REG);
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_PCNT_REG, val);
+		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_PCNT_REG);
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PCNT_REG, val);
 
-		val = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_PEER_BCNT_REG);
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_PEER_BCNT_REG, val);
+		val = udma_rchanrt_read(uc->rchan, UDMA_CHAN_RT_PEER_BCNT_REG);
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PEER_BCNT_REG, val);
 	}
 
 	uc->bcnt = 0;
@@ -694,16 +692,16 @@ static int udma_reset_chan(struct udma_chan *uc, bool hard)
 {
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_PEER_RT_EN_REG, 0);
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_CTL_REG, 0);
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG, 0);
 		break;
 	case DMA_MEM_TO_DEV:
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_CTL_REG, 0);
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_PEER_RT_EN_REG, 0);
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG, 0);
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_CTL_REG, 0);
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_CTL_REG, 0);
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG, 0);
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -731,7 +729,7 @@ static int udma_reset_chan(struct udma_chan *uc, bool hard)
 		 * the rchan.
 		 */
 		if (uc->config.dir == DMA_DEV_TO_MEM)
-			udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_CTL_REG,
+			udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG,
 					   UDMA_CHAN_RT_CTL_EN |
 					   UDMA_CHAN_RT_CTL_TDOWN |
 					   UDMA_CHAN_RT_CTL_FTDOWN);
@@ -809,10 +807,10 @@ static int udma_start(struct udma_chan *uc)
 				val |= PDMA_STATIC_TR_XY_BURST;
 
 			udma_rchanrt_write(uc->rchan,
-				UDMA_RCHAN_RT_PEER_STATIC_TR_XY_REG, val);
+				UDMA_CHAN_RT_PEER_STATIC_TR_XY_REG, val);
 
 			udma_rchanrt_write(uc->rchan,
-				UDMA_RCHAN_RT_PEER_STATIC_TR_Z_REG,
+				UDMA_CHAN_RT_PEER_STATIC_TR_Z_REG,
 				PDMA_STATIC_TR_Z(uc->desc->static_tr.bstcnt,
 						 match_data->statictr_z_mask));
 
@@ -821,11 +819,11 @@ static int udma_start(struct udma_chan *uc)
 			       sizeof(uc->static_tr));
 		}
 
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_CTL_REG,
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN);
 
 		/* Enable remote */
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_PEER_RT_EN_REG,
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE);
 
 		break;
@@ -841,7 +839,7 @@ static int udma_start(struct udma_chan *uc)
 				val |= PDMA_STATIC_TR_XY_BURST;
 
 			udma_tchanrt_write(uc->tchan,
-				UDMA_TCHAN_RT_PEER_STATIC_TR_XY_REG, val);
+				UDMA_CHAN_RT_PEER_STATIC_TR_XY_REG, val);
 
 			/* save the current staticTR configuration */
 			memcpy(&uc->static_tr, &uc->desc->static_tr,
@@ -849,17 +847,17 @@ static int udma_start(struct udma_chan *uc)
 		}
 
 		/* Enable remote */
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_PEER_RT_EN_REG,
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE);
 
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN);
 
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_CTL_REG,
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN);
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN);
 
 		break;
@@ -885,20 +883,20 @@ static int udma_stop(struct udma_chan *uc)
 		if (!uc->cyclic && !uc->desc)
 			udma_push_to_ring(uc, -1);
 
-		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_PEER_RT_EN_REG,
+		udma_rchanrt_write(uc->rchan, UDMA_CHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE |
 				   UDMA_PEER_RT_EN_TEARDOWN);
 		break;
 	case DMA_MEM_TO_DEV:
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_PEER_RT_EN_REG,
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_PEER_RT_EN_REG,
 				   UDMA_PEER_RT_EN_ENABLE |
 				   UDMA_PEER_RT_EN_FLUSH);
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN |
 				   UDMA_CHAN_RT_CTL_TDOWN);
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
+		udma_tchanrt_write(uc->tchan, UDMA_CHAN_RT_CTL_REG,
 				   UDMA_CHAN_RT_CTL_EN |
 				   UDMA_CHAN_RT_CTL_TDOWN);
 		break;
@@ -938,8 +936,8 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
 	    uc->config.dir != DMA_MEM_TO_DEV)
 		return true;
 
-	peer_bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG);
-	bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_BCNT_REG);
+	peer_bcnt = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_PEER_BCNT_REG);
+	bcnt = udma_tchanrt_read(uc->tchan, UDMA_CHAN_RT_BCNT_REG);
 
 	/* Transfer is incomplete, store current residue and time stamp */
 	if (peer_bcnt < bcnt) {
@@ -2739,29 +2737,29 @@ static enum dma_status udma_tx_status(struct dma_chan *chan,
 
 		if (uc->desc->dir == DMA_MEM_TO_DEV) {
 			bcnt = udma_tchanrt_read(uc->tchan,
-						 UDMA_TCHAN_RT_SBCNT_REG);
+						 UDMA_CHAN_RT_SBCNT_REG);
 
 			if (uc->config.ep_type != PSIL_EP_NATIVE) {
 				peer_bcnt = udma_tchanrt_read(uc->tchan,
-						UDMA_TCHAN_RT_PEER_BCNT_REG);
+						UDMA_CHAN_RT_PEER_BCNT_REG);
 
 				if (bcnt > peer_bcnt)
 					delay = bcnt - peer_bcnt;
 			}
 		} else if (uc->desc->dir == DMA_DEV_TO_MEM) {
 			bcnt = udma_rchanrt_read(uc->rchan,
-						 UDMA_RCHAN_RT_BCNT_REG);
+						 UDMA_CHAN_RT_BCNT_REG);
 
 			if (uc->config.ep_type != PSIL_EP_NATIVE) {
 				peer_bcnt = udma_rchanrt_read(uc->rchan,
-						UDMA_RCHAN_RT_PEER_BCNT_REG);
+						UDMA_CHAN_RT_PEER_BCNT_REG);
 
 				if (peer_bcnt > bcnt)
 					delay = peer_bcnt - bcnt;
 			}
 		} else {
 			bcnt = udma_tchanrt_read(uc->tchan,
-						 UDMA_TCHAN_RT_BCNT_REG);
+						 UDMA_CHAN_RT_BCNT_REG);
 		}
 
 		bcnt -= uc->bcnt;
@@ -2795,18 +2793,18 @@ static int udma_pause(struct dma_chan *chan)
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
 		udma_rchanrt_update_bits(uc->rchan,
-					 UDMA_RCHAN_RT_PEER_RT_EN_REG,
+					 UDMA_CHAN_RT_PEER_RT_EN_REG,
 					 UDMA_PEER_RT_EN_PAUSE,
 					 UDMA_PEER_RT_EN_PAUSE);
 		break;
 	case DMA_MEM_TO_DEV:
 		udma_tchanrt_update_bits(uc->tchan,
-					 UDMA_TCHAN_RT_PEER_RT_EN_REG,
+					 UDMA_CHAN_RT_PEER_RT_EN_REG,
 					 UDMA_PEER_RT_EN_PAUSE,
 					 UDMA_PEER_RT_EN_PAUSE);
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_tchanrt_update_bits(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
+		udma_tchanrt_update_bits(uc->tchan, UDMA_CHAN_RT_CTL_REG,
 					 UDMA_CHAN_RT_CTL_PAUSE,
 					 UDMA_CHAN_RT_CTL_PAUSE);
 		break;
@@ -2825,17 +2823,17 @@ static int udma_resume(struct dma_chan *chan)
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
 		udma_rchanrt_update_bits(uc->rchan,
-					 UDMA_RCHAN_RT_PEER_RT_EN_REG,
+					 UDMA_CHAN_RT_PEER_RT_EN_REG,
 					 UDMA_PEER_RT_EN_PAUSE, 0);
 
 		break;
 	case DMA_MEM_TO_DEV:
 		udma_tchanrt_update_bits(uc->tchan,
-					 UDMA_TCHAN_RT_PEER_RT_EN_REG,
+					 UDMA_CHAN_RT_PEER_RT_EN_REG,
 					 UDMA_PEER_RT_EN_PAUSE, 0);
 		break;
 	case DMA_MEM_TO_MEM:
-		udma_tchanrt_update_bits(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
+		udma_tchanrt_update_bits(uc->tchan, UDMA_CHAN_RT_CTL_REG,
 					 UDMA_CHAN_RT_CTL_PAUSE, 0);
 		break;
 	default:
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 128d8744a435..a8ea1138e1a5 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -18,52 +18,33 @@
 #define UDMA_RX_FLOW_ID_FW_OES_REG	0x80
 #define UDMA_RX_FLOW_ID_FW_STATUS_REG	0x88
 
-/* TX chan RT regs */
-#define UDMA_TCHAN_RT_CTL_REG		0x0
-#define UDMA_TCHAN_RT_SWTRIG_REG	0x8
-#define UDMA_TCHAN_RT_STDATA_REG	0x80
-
-#define UDMA_TCHAN_RT_PEER_REG(i)	(0x200 + ((i) * 0x4))
-#define UDMA_TCHAN_RT_PEER_STATIC_TR_XY_REG	\
-	UDMA_TCHAN_RT_PEER_REG(0)	/* PSI-L: 0x400 */
-#define UDMA_TCHAN_RT_PEER_STATIC_TR_Z_REG	\
-	UDMA_TCHAN_RT_PEER_REG(1)	/* PSI-L: 0x401 */
-#define UDMA_TCHAN_RT_PEER_BCNT_REG		\
-	UDMA_TCHAN_RT_PEER_REG(4)	/* PSI-L: 0x404 */
-#define UDMA_TCHAN_RT_PEER_RT_EN_REG		\
-	UDMA_TCHAN_RT_PEER_REG(8)	/* PSI-L: 0x408 */
-
-#define UDMA_TCHAN_RT_PCNT_REG		0x400
-#define UDMA_TCHAN_RT_BCNT_REG		0x408
-#define UDMA_TCHAN_RT_SBCNT_REG		0x410
-
-/* RX chan RT regs */
-#define UDMA_RCHAN_RT_CTL_REG		0x0
-#define UDMA_RCHAN_RT_SWTRIG_REG	0x8
-#define UDMA_RCHAN_RT_STDATA_REG	0x80
-
-#define UDMA_RCHAN_RT_PEER_REG(i)	(0x200 + ((i) * 0x4))
-#define UDMA_RCHAN_RT_PEER_STATIC_TR_XY_REG	\
-	UDMA_RCHAN_RT_PEER_REG(0)	/* PSI-L: 0x400 */
-#define UDMA_RCHAN_RT_PEER_STATIC_TR_Z_REG	\
-	UDMA_RCHAN_RT_PEER_REG(1)	/* PSI-L: 0x401 */
-#define UDMA_RCHAN_RT_PEER_BCNT_REG		\
-	UDMA_RCHAN_RT_PEER_REG(4)	/* PSI-L: 0x404 */
-#define UDMA_RCHAN_RT_PEER_RT_EN_REG		\
-	UDMA_RCHAN_RT_PEER_REG(8)	/* PSI-L: 0x408 */
-
-#define UDMA_RCHAN_RT_PCNT_REG		0x400
-#define UDMA_RCHAN_RT_BCNT_REG		0x408
-#define UDMA_RCHAN_RT_SBCNT_REG		0x410
-
-/* UDMA_TCHAN_RT_CTL_REG/UDMA_RCHAN_RT_CTL_REG */
+/* TCHANRT/RCHANRT registers */
+#define UDMA_CHAN_RT_CTL_REG		0x0
+#define UDMA_CHAN_RT_SWTRIG_REG		0x8
+#define UDMA_CHAN_RT_STDATA_REG		0x80
+
+#define UDMA_CHAN_RT_PEER_REG(i)	(0x200 + ((i) * 0x4))
+#define UDMA_CHAN_RT_PEER_STATIC_TR_XY_REG	\
+	UDMA_CHAN_RT_PEER_REG(0)	/* PSI-L: 0x400 */
+#define UDMA_CHAN_RT_PEER_STATIC_TR_Z_REG	\
+	UDMA_CHAN_RT_PEER_REG(1)	/* PSI-L: 0x401 */
+#define UDMA_CHAN_RT_PEER_BCNT_REG		\
+	UDMA_CHAN_RT_PEER_REG(4)	/* PSI-L: 0x404 */
+#define UDMA_CHAN_RT_PEER_RT_EN_REG		\
+	UDMA_CHAN_RT_PEER_REG(8)	/* PSI-L: 0x408 */
+
+#define UDMA_CHAN_RT_PCNT_REG		0x400
+#define UDMA_CHAN_RT_BCNT_REG		0x408
+#define UDMA_CHAN_RT_SBCNT_REG		0x410
+
+/* UDMA_CHAN_RT_CTL_REG */
 #define UDMA_CHAN_RT_CTL_EN		BIT(31)
 #define UDMA_CHAN_RT_CTL_TDOWN		BIT(30)
 #define UDMA_CHAN_RT_CTL_PAUSE		BIT(29)
 #define UDMA_CHAN_RT_CTL_FTDOWN		BIT(28)
 #define UDMA_CHAN_RT_CTL_ERROR		BIT(0)
 
-/* UDMA_TCHAN_RT_PEER_RT_EN_REG/UDMA_RCHAN_RT_PEER_RT_EN_REG (PSI-L: 0x408) */
+/* UDMA_CHAN_RT_PEER_RT_EN_REG */
 #define UDMA_PEER_RT_EN_ENABLE		BIT(31)
 #define UDMA_PEER_RT_EN_TEARDOWN	BIT(30)
 #define UDMA_PEER_RT_EN_PAUSE		BIT(29)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

