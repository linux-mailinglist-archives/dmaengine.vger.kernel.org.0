Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4161D255910
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgH1LDt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 07:03:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52338 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgH1LDd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Aug 2020 07:03:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07SB3SHf010025;
        Fri, 28 Aug 2020 06:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598612608;
        bh=Ht/kpmfFKKAmBLtxYmnb3a0fKfLy/bJ2ohoyyGN62fI=;
        h=From:To:CC:Subject:Date;
        b=lJklyuEmEg0ftZAPvTCVT7ipc+wvIBXH4IJghDVOomz5BdvT0w4ic7Swno4kTYFY5
         GsO32P4IFyA/VIE1o2vx7K0OuIFbEgEjcaBGFnpevNcmhliFQMbUrmKzz4F0wnOKMk
         4E1JHK/pe6pbsqWfeVcUDputRhLnV/vKTkv+KtXo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07SB3S3t055872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 06:03:28 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 28
 Aug 2020 06:03:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 28 Aug 2020 06:03:27 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07SB3Po4020682;
        Fri, 28 Aug 2020 06:03:26 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <andy.shevchenko@gmail.com>
Subject: [PATCH] dmaengine: Mark dma_request_slave_channel() deprecated
Date:   Fri, 28 Aug 2020 14:05:07 +0300
Message-ID: <20200828110507.22407-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
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
index a53e71d2bbd4..ac8ef6cf7626 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -871,24 +871,6 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
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
  * @mask:	capabilities that the channel must satisfy
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 011371b7f081..dd357a747780 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1472,7 +1472,6 @@ void dma_issue_pending_all(void);
 struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 				       dma_filter_fn fn, void *fn_param,
 				       struct device_node *np);
-struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
@@ -1502,11 +1501,6 @@ static inline struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
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
@@ -1575,6 +1569,15 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
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

