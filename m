Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21DAE978
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfIJLuR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 07:50:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33214 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbfIJLuQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 07:50:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8ABoEDe040830;
        Tue, 10 Sep 2019 06:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568116214;
        bh=FIswI+Spzr3FuHme+8/MFEJTlDFumZEJPiU62/4thvM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LA/FMTDxr9pw0iuLQXwJ1fFYHeR9eJPh5VbzS625h/0cakdjpulc+aNUUdC+HEwQ9
         t06+BDOfAYFdPyJ88JCZaKUJI3uf12qTZjVEDGztFgguUyll7nHXu2/G8LyYszC4jV
         MAh95JoQn3GcMZ1XvgVyeD+jqrgAV1ncFEXxsAUc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ABoEW0089127;
        Tue, 10 Sep 2019 06:50:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 06:50:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 06:50:14 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ABo5cI028909;
        Tue, 10 Sep 2019 06:50:12 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 3/3] dmaengine: Support for requesting channels preferring DMA domain controller
Date:   Tue, 10 Sep 2019 14:50:37 +0300
Message-ID: <20190910115037.23539-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910115037.23539-1-peter.ujfalusi@ti.com>
References: <20190910115037.23539-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In case the channel is not requested via the slave API, use the
of_find_dma_domain() to see if a system default DMA controller is
specified.

Add new function which can be used by clients to request channels by mask
from their DMA domain controller if specified.

Client drivers can take advantage of the domain support by moving from
dma_request_chan_by_mask() to dma_request_chan_by_domain()

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c   | 21 ++++++++++++++++-----
 include/linux/dmaengine.h |  9 ++++++---
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 03ac4b96117c..1bae3ff24da0 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -640,6 +640,10 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 	struct dma_device *device, *_d;
 	struct dma_chan *chan = NULL;
 
+	/* If np is not specified, get the default DMA domain controller */
+	if (!np)
+		np = of_find_dma_domain(NULL);
+
 	/* Find a channel */
 	mutex_lock(&dma_list_mutex);
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
@@ -751,19 +755,26 @@ struct dma_chan *dma_request_slave_channel(struct device *dev,
 EXPORT_SYMBOL_GPL(dma_request_slave_channel);
 
 /**
- * dma_request_chan_by_mask - allocate a channel satisfying certain capabilities
- * @mask: capabilities that the channel must satisfy
+ * dma_request_chan_by_domain - allocate a channel by mask from DMA domain
+ * @dev:	pointer to client device structure
+ * @mask:	capabilities that the channel must satisfy
  *
  * Returns pointer to appropriate DMA channel on success or an error pointer.
  */
-struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
+struct dma_chan *dma_request_chan_by_domain(struct device *dev,
+					    const dma_cap_mask_t *mask)
 {
 	struct dma_chan *chan;
 
 	if (!mask)
 		return ERR_PTR(-ENODEV);
 
-	chan = __dma_request_channel(mask, NULL, NULL, NULL);
+	if (dev)
+		chan = __dma_request_channel(mask, NULL, NULL,
+					     of_find_dma_domain(dev->of_node));
+	else
+		chan = __dma_request_channel(mask, NULL, NULL, NULL);
+
 	if (!chan) {
 		mutex_lock(&dma_list_mutex);
 		if (list_empty(&dma_device_list))
@@ -775,7 +786,7 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
 
 	return chan;
 }
-EXPORT_SYMBOL_GPL(dma_request_chan_by_mask);
+EXPORT_SYMBOL_GPL(dma_request_chan_by_domain);
 
 void dma_release_channel(struct dma_chan *chan)
 {
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8fcdee1c0cf9..de5c52810443 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1307,7 +1307,8 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
-struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *dma_request_chan_by_domain(struct device *dev,
+					    const dma_cap_mask_t *mask);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1344,8 +1345,8 @@ static inline struct dma_chan *dma_request_chan(struct device *dev,
 {
 	return ERR_PTR(-ENODEV);
 }
-static inline struct dma_chan *dma_request_chan_by_mask(
-						const dma_cap_mask_t *mask)
+static inline struct dma_chan *dma_request_chan_by_domain(struct device *dev,
+			const dma_cap_mask_t *mask)
 {
 	return ERR_PTR(-ENODEV);
 }
@@ -1406,6 +1407,8 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 	__dma_request_channel(&(mask), x, y, NULL)
 #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
 	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
+#define dma_request_chan_by_mask(mask) \
+	dma_request_chan_by_domain(NULL, mask)
 
 static inline struct dma_chan
 *__dma_request_slave_channel_compat(const dma_cap_mask_t *mask,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

