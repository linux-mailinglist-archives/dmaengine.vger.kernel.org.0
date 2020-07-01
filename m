Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C829210954
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgGAKbX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 06:31:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60916 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbgGAKbW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 06:31:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061AVHHo014772;
        Wed, 1 Jul 2020 05:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593599477;
        bh=HsTXo54E4mgo+ijnq0QByyaF6voZeMrogfaxJMQ+FO8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=knRlbgnXEifLJ9El+Txu0NBhotkIsm8Fji5RkztWbGvKv7tqX2FPgoa2ZWzeS0dj2
         eFg5+p1HTJ5dS+qhyr0i0SaW73SCpdyos3AhALAGsDDI6nqs6EqMmkgwS5e8nJj701
         QD9/MvVkXEQPzWN29Nx4MdR4YAdi+/2rzFdV7/Ao=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061AVH1B057173;
        Wed, 1 Jul 2020 05:31:17 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 05:31:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 05:31:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061AVFqG039362;
        Wed, 1 Jul 2020 05:31:16 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next 6/6] dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair
Date:   Wed, 1 Jul 2020 13:30:30 +0300
Message-ID: <20200701103030.29684-7-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701103030.29684-1-grygorii.strashko@ti.com>
References: <20200701103030.29684-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

We only request ring pairs via K3 DMA driver, switch to use the new
k3_ringacc_request_rings_pair() to simplify the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c | 40 ++++++++++++-----------------------
 drivers/dma/ti/k3-udma.c      | 34 ++++++++++-------------------
 2 files changed, 24 insertions(+), 50 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 64c8955e0cf1..67408dc3b05b 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -271,20 +271,12 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 	atomic_set(&tx_chn->free_pkts, cfg->txcq_cfg.size);
 
 	/* request and cfg rings */
-	tx_chn->ringtx = k3_ringacc_request_ring(tx_chn->common.ringacc,
-						 tx_chn->udma_tchan_id, 0);
-	if (!tx_chn->ringtx) {
-		ret = -ENODEV;
-		dev_err(dev, "Failed to get TX ring %u\n",
-			tx_chn->udma_tchan_id);
-		goto err;
-	}
-
-	tx_chn->ringtxcq = k3_ringacc_request_ring(tx_chn->common.ringacc,
-						   -1, 0);
-	if (!tx_chn->ringtxcq) {
-		ret = -ENODEV;
-		dev_err(dev, "Failed to get TXCQ ring\n");
+	ret =  k3_ringacc_request_rings_pair(tx_chn->common.ringacc,
+					     tx_chn->udma_tchan_id, -1,
+					     &tx_chn->ringtx,
+					     &tx_chn->ringtxcq);
+	if (ret) {
+		dev_err(dev, "Failed to get TX/TXCQ rings %d\n", ret);
 		goto err;
 	}
 
@@ -587,22 +579,16 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	}
 
 	/* request and cfg rings */
-	flow->ringrx = k3_ringacc_request_ring(rx_chn->common.ringacc,
-					       flow_cfg->ring_rxq_id, 0);
-	if (!flow->ringrx) {
-		ret = -ENODEV;
-		dev_err(dev, "Failed to get RX ring\n");
+	ret =  k3_ringacc_request_rings_pair(rx_chn->common.ringacc,
+					     flow_cfg->ring_rxq_id,
+					     flow_cfg->ring_rxfdq0_id,
+					     &flow->ringrxfdq,
+					     &flow->ringrx);
+	if (ret) {
+		dev_err(dev, "Failed to get RX/RXFDQ rings %d\n", ret);
 		goto err_rflow_put;
 	}
 
-	flow->ringrxfdq = k3_ringacc_request_ring(rx_chn->common.ringacc,
-						  flow_cfg->ring_rxfdq0_id, 0);
-	if (!flow->ringrxfdq) {
-		ret = -ENODEV;
-		dev_err(dev, "Failed to get RXFDQ ring\n");
-		goto err_ringrx_free;
-	}
-
 	ret = k3_ringacc_ring_cfg(flow->ringrx, &flow_cfg->rx_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringrx %d\n", ret);
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c91e2dc1bb72..a389aa6d260f 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1418,17 +1418,12 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 	if (ret)
 		return ret;
 
-	uc->tchan->t_ring = k3_ringacc_request_ring(ud->ringacc,
-						    uc->tchan->id, 0);
-	if (!uc->tchan->t_ring) {
-		ret = -EBUSY;
-		goto err_tx_ring;
-	}
-
-	uc->tchan->tc_ring = k3_ringacc_request_ring(ud->ringacc, -1, 0);
-	if (!uc->tchan->tc_ring) {
+	ret = k3_ringacc_request_rings_pair(ud->ringacc, uc->tchan->id, -1,
+					    &uc->tchan->t_ring,
+					    &uc->tchan->tc_ring);
+	if (ret) {
 		ret = -EBUSY;
-		goto err_txc_ring;
+		goto err_ring;
 	}
 
 	memset(&ring_cfg, 0, sizeof(ring_cfg));
@@ -1447,10 +1442,9 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 err_ringcfg:
 	k3_ringacc_ring_free(uc->tchan->tc_ring);
 	uc->tchan->tc_ring = NULL;
-err_txc_ring:
 	k3_ringacc_ring_free(uc->tchan->t_ring);
 	uc->tchan->t_ring = NULL;
-err_tx_ring:
+err_ring:
 	udma_put_tchan(uc);
 
 	return ret;
@@ -1499,16 +1493,11 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 
 	rflow = uc->rflow;
 	fd_ring_id = ud->tchan_cnt + ud->echan_cnt + uc->rchan->id;
-	rflow->fd_ring = k3_ringacc_request_ring(ud->ringacc, fd_ring_id, 0);
-	if (!rflow->fd_ring) {
-		ret = -EBUSY;
-		goto err_rx_ring;
-	}
-
-	rflow->r_ring = k3_ringacc_request_ring(ud->ringacc, -1, 0);
-	if (!rflow->r_ring) {
+	ret = k3_ringacc_request_rings_pair(ud->ringacc, fd_ring_id, -1,
+					    &rflow->fd_ring, &rflow->r_ring);
+	if (ret) {
 		ret = -EBUSY;
-		goto err_rxc_ring;
+		goto err_ring;
 	}
 
 	memset(&ring_cfg, 0, sizeof(ring_cfg));
@@ -1533,10 +1522,9 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
 err_ringcfg:
 	k3_ringacc_ring_free(rflow->r_ring);
 	rflow->r_ring = NULL;
-err_rxc_ring:
 	k3_ringacc_ring_free(rflow->fd_ring);
 	rflow->fd_ring = NULL;
-err_rx_ring:
+err_ring:
 	udma_put_rflow(uc);
 err_rflow:
 	udma_put_rchan(uc);
-- 
2.17.1

