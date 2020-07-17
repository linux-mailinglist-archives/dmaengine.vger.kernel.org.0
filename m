Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D30223C45
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 15:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgGQNVD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 09:21:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56530 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNVD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 09:21:03 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKtsM052680;
        Fri, 17 Jul 2020 08:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594992055;
        bh=eGWgXhUwUeAtpANP9pM9jKJOBsp9KaRGdWRkWGuXPjI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f+tGfC0vOdpwXSN/aSL2JaPNHF0GloI+o/IuHETZ+lnF4Zv2eYctDSCmJ/P+VZcEP
         XLVbsLF5Q6oA2j6a001m5cQc8DuBB6JBzXa2nfca28BBNljOGfyqfI1+/3c8B79ifH
         QWSGGVIriY2LL/heIizd/JGLD8THqwhOMpR6B30U=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HDKtPs018243
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 08:20:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:20:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:20:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKrvc107830;
        Fri, 17 Jul 2020 08:20:54 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 6/6] dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair
Date:   Fri, 17 Jul 2020 16:20:19 +0300
Message-ID: <20200717132019.20427-7-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717132019.20427-1-grygorii.strashko@ti.com>
References: <20200717132019.20427-1-grygorii.strashko@ti.com>
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
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/ti/k3-udma-glue.c | 42 +++++++++++------------------------
 drivers/dma/ti/k3-udma.c      | 34 +++++++++-------------------
 2 files changed, 24 insertions(+), 52 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 64c8955e0cf1..c888ae4fec96 100644
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
@@ -673,8 +659,6 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 
 err_ringrxfdq_free:
 	k3_ringacc_ring_free(flow->ringrxfdq);
-
-err_ringrx_free:
 	k3_ringacc_ring_free(flow->ringrx);
 
 err_rflow_put:
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 6c879a734360..49d0d3af6311 100644
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

