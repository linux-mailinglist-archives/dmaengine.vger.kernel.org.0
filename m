Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6602B5D96
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 11:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgKQK4b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 05:56:31 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34070 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgKQK4a (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 05:56:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAuP2k117215;
        Tue, 17 Nov 2020 04:56:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605610585;
        bh=GPNClNRp61iGNgJX9hjyyFfrcPdoVMSd0kEOHS+xKLc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uVdP+flRTAxnCrsn0rXQ/oBgbbZFdX+SKtKMBOx88G9hWGtnZSAQNuWWJKdT72Qef
         ruE8j7JL3CwrjXEKYa2pHbcMCbWLkxpgoqmzkydS9SeQUl0nfHJVEhQqwz+bJg0yma
         PFOpk3mlR3bw2QJ0Dh5oYwViIOPPI+TA63yW2btM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAuPJj010058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:56:25 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:56:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:56:24 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAu6tp087311;
        Tue, 17 Nov 2020 04:56:22 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 05/19] dmaengine: ti: k3-udma-glue: Configure the dma_dev for rings
Date:   Tue, 17 Nov 2020 12:56:42 +0200
Message-ID: <20201117105656.5236-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117105656.5236-1-peter.ujfalusi@ti.com>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Rings in RING mode should be using the DMA device for DMA API as in this
mode the ringacc will not access the ring memory in any ways, but the DMA
is.

Fix up the ring configuration and set the dma_dev unconditionally and let
the ringacc driver to select the correct device to use for DMA API.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 29d1524d1916..ddf0730aa2bc 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -280,6 +280,10 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
 		goto err;
 	}
 
+	/* Set the dma_dev for the rings to be configured */
+	cfg->tx_cfg.dma_dev = k3_udma_glue_tx_get_dma_device(tx_chn);
+	cfg->txcq_cfg.dma_dev = cfg->tx_cfg.dma_dev;
+
 	ret = k3_ringacc_ring_cfg(tx_chn->ringtx, &cfg->tx_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringtx %d\n", ret);
@@ -595,6 +599,10 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 		goto err_rflow_put;
 	}
 
+	/* Set the dma_dev for the rings to be configured */
+	flow_cfg->rx_cfg.dma_dev = k3_udma_glue_rx_get_dma_device(rx_chn);
+	flow_cfg->rxfdq_cfg.dma_dev = flow_cfg->rx_cfg.dma_dev;
+
 	ret = k3_ringacc_ring_cfg(flow->ringrx, &flow_cfg->rx_cfg);
 	if (ret) {
 		dev_err(dev, "Failed to cfg ringrx %d\n", ret);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

