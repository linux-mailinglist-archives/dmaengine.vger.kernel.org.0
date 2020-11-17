Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9622B5D99
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 11:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKQK4e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 05:56:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59658 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgKQK4d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 05:56:33 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAuSLj019551;
        Tue, 17 Nov 2020 04:56:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605610588;
        bh=5ridk5920UfMB0nCEIpCyF/07n7stscwVpGaO1rQQhA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=W1u7Mx1PwsOuT8GyG/xpAz0KvDnKeigyw/WI0qJ88iN2FyC/B9XEDPNHAhJ1+3RIA
         lNMyvDdGdDLwMqQdM4wZJy0aIIugdjbvWIjnA7AWEq+UnYE1CT8RpANkX7sdzz0PeG
         8g0XDO4RWicCvykSk2aSrhrPy4fOsvbLUqrlFoj8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAuSfI010123
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:56:28 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:56:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:56:27 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAu6tq087311;
        Tue, 17 Nov 2020 04:56:25 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 06/19] dmaengine: of-dma: Add support for optional router configuration callback
Date:   Tue, 17 Nov 2020 12:56:43 +0200
Message-ID: <20201117105656.5236-7-peter.ujfalusi@ti.com>
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

Additional configuration for the DMA event router might be needed for a
channel which can not be done during device_alloc_chan_resources callback
since the router information is not yet present for the drivers.

If there is a need for additional configuration for the channel if DMA
router is in use, then the driver can implement the device_router_config
callback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/of-dma.c      | 10 ++++++++++
 include/linux/dmaengine.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 8a4f608904b9..ec00b20ae8e4 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -75,8 +75,18 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
 		ofdma->dma_router->route_free(ofdma->dma_router->dev,
 					      route_data);
 	} else {
+		int ret = 0;
+
 		chan->router = ofdma->dma_router;
 		chan->route_data = route_data;
+
+		if (chan->device->device_router_config)
+			ret = chan->device->device_router_config(chan);
+
+		if (ret) {
+			dma_release_channel(chan);
+			chan = ERR_PTR(ret);
+		}
 	}
 
 	/*
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index dd357a747780..d6197fe875af 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -800,6 +800,7 @@ struct dma_filter {
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
  *	number of allocated descriptors
+ * @device_router_config: optional callback for DMA router configuration
  * @device_free_chan_resources: release DMA channel's resources
  * @device_prep_dma_memcpy: prepares a memcpy operation
  * @device_prep_dma_xor: prepares a xor operation
@@ -874,6 +875,7 @@ struct dma_device {
 	enum dma_residue_granularity residue_granularity;
 
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
+	int (*device_router_config)(struct dma_chan *chan);
 	void (*device_free_chan_resources)(struct dma_chan *chan);
 
 	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

