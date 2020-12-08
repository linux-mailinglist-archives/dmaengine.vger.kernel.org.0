Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1858D2D26E5
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgLHJFG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:05:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34420 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgLHJFF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:05:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8949ko002798;
        Tue, 8 Dec 2020 03:04:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418249;
        bh=HSm4+oz7ndB15ND59RBAyXDIbwXFdQb/ZAZiFLJMjns=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cJFVI0DCd7pz0AE6g3eWxmqI0OF4OUSm21jmTFuT15eADWvhxglpgzJ819ym/gHjG
         2YaxynXnqtSwevC5vMHYqTOskeLf2Jbym1UVdJRaZjyG+0VkOa/cJPZBB+J3UODqDa
         58SBbYoSwBYjjSBG4lSBigDDAsMWOv+wrHB7NISQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8949jB044070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:04:09 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:04:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:04:09 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dcC120112;
        Tue, 8 Dec 2020 03:04:05 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 07/20] dmaengine: of-dma: Add support for optional router configuration callback
Date:   Tue, 8 Dec 2020 11:04:27 +0200
Message-ID: <20201208090440.31792-8-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208090440.31792-1-peter.ujfalusi@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
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
index 493a047ed0a2..aed44888cad3 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -805,6 +805,7 @@ struct dma_filter {
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
  *	number of allocated descriptors
+ * @device_router_config: optional callback for DMA router configuration
  * @device_free_chan_resources: release DMA channel's resources
  * @device_prep_dma_memcpy: prepares a memcpy operation
  * @device_prep_dma_xor: prepares a xor operation
@@ -879,6 +880,7 @@ struct dma_device {
 	enum dma_residue_granularity residue_granularity;
 
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
+	int (*device_router_config)(struct dma_chan *chan);
 	void (*device_free_chan_resources)(struct dma_chan *chan);
 
 	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

