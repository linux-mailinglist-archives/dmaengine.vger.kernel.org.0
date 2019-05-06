Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9D149BC
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 14:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfEFMfr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 08:35:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51614 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfEFMfo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 08:35:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x46CZJbg017849;
        Mon, 6 May 2019 07:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557146119;
        bh=k+xYXJk24KElUVNAc9y4GHfBm7/BQojVwXvOY0hlb2M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xK9JGg19rRbmty8mZwA+uvBocr+9M+PlIhum5w3yXmvxojinXIQBx/+8cnvmvhlSm
         qqMAr+tx7+AZ2BknK1b0Vop0ZvS4Oo5JDwLRnccPAvnsXow7qnetJWjMktk/Nwn4Sg
         WEBEilerQe5UQtEjTNRXyLFMjlQ19z9tRFQGwUiM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x46CZJf7035849
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 May 2019 07:35:19 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 6 May
 2019 07:35:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 6 May 2019 07:35:16 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x46CYpUD110286;
        Mon, 6 May 2019 07:35:13 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
Subject: [PATCH 07/16] dmaengine: Add function to request slave channel from a dma_device
Date:   Mon, 6 May 2019 15:34:47 +0300
Message-ID: <20190506123456.6777-8-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506123456.6777-1-peter.ujfalusi@ti.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dma_get_any_slave_channel() would skip using the filter function, which
in some cases needed to be executed before the alloc_chan_resources
callback to make sure that all parameters are provided for the slave
channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c   | 7 ++++---
 include/linux/dmaengine.h | 5 ++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 8eed5ff0fc01..7ec93be12088 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -617,7 +617,8 @@ struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_channel);
 
-struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
+struct dma_chan *dmadev_get_slave_channel(struct dma_device *device,
+					  dma_filter_fn fn, void *fn_param)
 {
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
@@ -628,13 +629,13 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
 	/* lock against __dma_request_channel */
 	mutex_lock(&dma_list_mutex);
 
-	chan = find_candidate(device, &mask, NULL, NULL);
+	chan = find_candidate(device, &mask, fn, fn_param);
 
 	mutex_unlock(&dma_list_mutex);
 
 	return IS_ERR(chan) ? NULL : chan;
 }
-EXPORT_SYMBOL_GPL(dma_get_any_slave_channel);
+EXPORT_SYMBOL_GPL(dmadev_get_slave_channel);
 
 /**
  * __dma_request_channel - try to allocate an exclusive channel
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c1486564a314..4774b66f2064 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1541,7 +1541,10 @@ int dmaenginem_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
-struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
+struct dma_chan *dmadev_get_slave_channel(struct dma_device *device,
+					  dma_filter_fn fn, void *fn_param);
+#define dma_get_any_slave_channel(device) \
+	dmadev_get_slave_channel(device, NULL, NULL)
 #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
 #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
 	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

