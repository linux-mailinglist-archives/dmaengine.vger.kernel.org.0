Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6827E494
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgI3JOL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:14:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35022 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgI3JOK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9E5Gn034888;
        Wed, 30 Sep 2020 04:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457245;
        bh=24q5eD4y4xZgELs8UTDdNZFf1mU01Jty7BUIc3+XGk4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Eu0tzELmEDYfv6KlmUeoSiKtMyo3jDlvSWanA9cxOXpb530t1NVJZJ2KRh3PrzdPB
         Uoosxfb4Lh5eqygJHmKdCE4B9zP14hquHRZJlTQiZOkFNwOo5vsfxSD0I1b0mb/g1h
         XNEoGZw15iUPd3soBB4aqVyBjpbuISGiBfQ1PRMo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9E5fg121766;
        Wed, 30 Sep 2020 04:14:05 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:05 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJZ116385;
        Wed, 30 Sep 2020 04:14:02 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 02/18] dmaengine: Add support for per channel coherency handling
Date:   Wed, 30 Sep 2020 12:13:56 +0300
Message-ID: <20200930091412.8020-3-peter.ujfalusi@ti.com>
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

