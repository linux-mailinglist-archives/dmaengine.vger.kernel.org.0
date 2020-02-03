Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122AF150411
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 11:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgBCKSZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 05:18:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57930 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgBCKSS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 05:18:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 013AIDDl127288;
        Mon, 3 Feb 2020 04:18:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580725093;
        bh=WIVihqnSycLXDyolXt07z45P16RfSqFN74PakBFswQc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HYNKCXyrdjSTspK0uJHd8pdl0ZPPlWQaJyxbgYAbFuJP8VfMRPXN4pX89awzUvIsZ
         xLKDsO3ywfRmi8GS/FfSuBCu2BMlL/1kWieokk9H7edicZrwRJxISciOclRbmMjMUA
         XnxmQTqLgVgyWKEIKpCbGUnKpc4KoryZsJj9VS9E=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 013AIDr2039797
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Feb 2020 04:18:13 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 04:18:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 04:18:12 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013AI7mU040513;
        Mon, 3 Feb 2020 04:18:11 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>
Subject: [PATCH 2/3] dmaengine: Mark dma_request_slave_channel() deprecated
Date:   Mon, 3 Feb 2020 12:18:05 +0200
Message-ID: <20200203101806.2441-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203101806.2441-1-peter.ujfalusi@ti.com>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

New drivers should use dma_request_chan() instead
dma_request_slave_channel()

dma_request_slave_channel() is a simple wrapper for dma_request_chan()
eating up the error code for channel request failure and makes deferred
probing impossible.

Move the dma_request_slave_channel() into the header as inline function,
mark it as deprecated.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c   | 18 ------------------
 include/linux/dmaengine.h | 15 +++++++++------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 121231300d35..8ec2257a8d88 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -781,24 +781,6 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_GPL(dma_request_chan);
 
-/**
- * dma_request_slave_channel - try to allocate an exclusive slave channel
- * @dev:	pointer to client device structure
- * @name:	slave channel name
- *
- * Returns pointer to appropriate DMA channel on success or NULL.
- */
-struct dma_chan *dma_request_slave_channel(struct device *dev,
-					   const char *name)
-{
-	struct dma_chan *ch = dma_request_chan(dev, name);
-	if (IS_ERR(ch))
-		return NULL;
-
-	return ch;
-}
-EXPORT_SYMBOL_GPL(dma_request_slave_channel);
-
 /**
  * dma_request_chan_by_mask - allocate a channel satisfying certain capabilities
  * @mask: capabilities that the channel must satisfy
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 6702df107d79..4c522bf6ac25 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1440,7 +1440,6 @@ void dma_issue_pending_all(void);
 struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 				       dma_filter_fn fn, void *fn_param,
 				       struct device_node *np);
-struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
@@ -1470,11 +1469,6 @@ static inline struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 {
 	return NULL;
 }
-static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
-							 const char *name)
-{
-	return NULL;
-}
 static inline struct dma_chan *dma_request_chan(struct device *dev,
 						const char *name)
 {
@@ -1544,6 +1538,15 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 #define dma_request_channel(mask, x, y) \
 	__dma_request_channel(&(mask), x, y, NULL)
 
+/* Deprecated, please use dma_request_chan() directly */
+static inline struct dma_chan * __deprecated
+dma_request_slave_channel(struct device *dev, const char *name)
+{
+	struct dma_chan *ch = dma_request_chan(dev, name);
+
+	return IS_ERR(ch) ? NULL : ch;
+}
+
 static inline struct dma_chan
 *dma_request_slave_channel_compat(const dma_cap_mask_t mask,
 				  dma_filter_fn fn, void *fn_param,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

