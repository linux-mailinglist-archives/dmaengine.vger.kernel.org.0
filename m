Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7D12D271A
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgLHJGA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:06:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34474 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgLHJF4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:05:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B894F1n002838;
        Tue, 8 Dec 2020 03:04:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418255;
        bh=IQO2yaz/9bInpDSpHQeF6HLe6FFsup5nZ3kyY3A1F0I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Z1UMw+8LkhV2e19/tzFzQdQXd8csZpGX/rwqA/nA0sppRJnGaYHZ9VsedAoQRC4Gf
         LGwVtVRUoa22J9Fr0dgtEwTRRkQV26MRmcXqrr1YNQ+2P9zByhpvZrGq2567f3eu4O
         vsVhSIDYz77r0q1dG4zWX4gS/NghlwCAIMscCG5k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B894FR5044156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:04:15 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:04:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:04:14 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dcD120112;
        Tue, 8 Dec 2020 03:04:09 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 08/20] dmaengine: Add support for per channel coherency handling
Date:   Tue, 8 Dec 2020 11:04:28 +0200
Message-ID: <20201208090440.31792-9-peter.ujfalusi@ti.com>
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
index aed44888cad3..68130f5f599e 100644
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
@@ -1618,4 +1621,13 @@ dmaengine_get_direction_text(enum dma_transfer_direction dir)
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

