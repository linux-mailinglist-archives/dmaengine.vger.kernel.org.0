Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892CA27E492
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgI3JOK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:14:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35008 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3JOJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9E35X034882;
        Wed, 30 Sep 2020 04:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457243;
        bh=5ridk5920UfMB0nCEIpCyF/07n7stscwVpGaO1rQQhA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hAI/eQIpcwJQUk0v9xFVj0B/6YmQCfL80Xrg/yduhWEsIRKVXZOIKXFFDi5MX11gu
         uP1TDOA+UeSEcvhtZ0zLj21Vy8JquVYtCfA16JaiksmhnfxFXsgIUZAGcHggrtQffr
         cr9QI/UlAe+cvcSFFMlZvY1qtlL9mbyyk6jh9tUg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U9E2CL111169
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:14:02 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:02 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJY116385;
        Wed, 30 Sep 2020 04:13:59 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 01/18] dmaengine: of-dma: Add support for optional router configuration callback
Date:   Wed, 30 Sep 2020 12:13:55 +0300
Message-ID: <20200930091412.8020-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930091412.8020-1-peter.ujfalusi@ti.com>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
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

