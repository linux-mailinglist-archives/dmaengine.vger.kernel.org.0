Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5852B5D87
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 11:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgKQK4g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 05:56:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59664 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgKQK4g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 05:56:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAuVI2019558;
        Tue, 17 Nov 2020 04:56:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605610591;
        bh=24q5eD4y4xZgELs8UTDdNZFf1mU01Jty7BUIc3+XGk4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tYW3hLul0fVpDYy1m/RvZ/5ySeiEBG5wvZC6pVfPZhNc61Qh5LO7lwpWll3i5xobv
         8b82CYGbqXsOXfg4zhsK2zWBbXhigw9pDfrXkM7oWBjmT5BJphU/KHsvNwW27HwlyB
         n758PNCY3xzROQtVa/Kv2er32eoYKOi0jTOC28uM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAuVEA005357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:56:31 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:56:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:56:30 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAu6tr087311;
        Tue, 17 Nov 2020 04:56:28 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 07/19] dmaengine: Add support for per channel coherency handling
Date:   Tue, 17 Nov 2020 12:56:44 +0200
Message-ID: <20201117105656.5236-8-peter.ujfalusi@ti.com>
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

If the DMA device supports per channel coherency configuration (a channel
can be configured to have coherent or not coherent view) then a single
device (the DMA controller's device) can not be used for dma_api for all
channels as channels can have different coherency.

Introduce custom_dma_mapping flag for the dma_chan and a new helper to get
the device pointer to be used for dma_api for the given channel.

Client drivers should be updated to be able to support per channel
coherency by:

- dma_map_single(chan->device->dev, ptr, size, DMA_TO_DEVICE);
+ struct device *dma_dev = dmaengine_get_dma_device(chan);
+
+ dma_map_single(dma_dev, ptr, size, DMA_TO_DEVICE);

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dmaengine.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index d6197fe875af..182a1a2e7793 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -357,11 +357,14 @@ struct dma_chan {
  * @chan: driver channel device
  * @device: sysfs device
  * @dev_id: parent dma_device dev_id
+ * @chan_dma_dev: The channel is using custom/different dma-mapping
+ * compared to the parent dma_device
  */
 struct dma_chan_dev {
 	struct dma_chan *chan;
 	struct device device;
 	int dev_id;
+	bool chan_dma_dev;
 };
 
 /**
@@ -1613,4 +1616,13 @@ dmaengine_get_direction_text(enum dma_transfer_direction dir)
 		return "invalid";
 	}
 }
+
+static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
+{
+	if (chan->dev->chan_dma_dev)
+		return &chan->dev->device;
+
+	return chan->device->dev;
+}
+
 #endif /* DMAENGINE_H */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

