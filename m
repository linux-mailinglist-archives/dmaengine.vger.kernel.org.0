Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA87C27E49C
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgI3JOT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:14:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35058 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgI3JOS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9EBRG034949;
        Wed, 30 Sep 2020 04:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457251;
        bh=GcxwvtwaXqOgpXBurlcj+/JKCfjnKyirXPuoynaLPoY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cR283PKKVRkA1UvJzKq0rKhfRVKMRoKAQIu4Sha+mqxdvAd6P+7LoB1Bd+iVpsbRt
         lXfgV70ZTFRgjycB8GDj3v3CnW/MNLr4j2jXd8annHLf1prn08JXiwo/8N1Ph/r7Ya
         qOtdrdY1U1fcUqKgwWK8jUMJ2pRkbqKRYuUIzTls=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9EBJV121952;
        Wed, 30 Sep 2020 04:14:11 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:11 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJb116385;
        Wed, 30 Sep 2020 04:14:08 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 04/18] dmaengine: dmatest: Use dmaengine_get_dma_device
Date:   Wed, 30 Sep 2020 12:13:58 +0300
Message-ID: <20200930091412.8020-5-peter.ujfalusi@ti.com>
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

By using the dmaengine_get_dma_device() to get the device for
dma_api use, the dmatest can support per channel coherency if it is
supported by the DMA controller.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmatest.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a3a172173e34..f696246f57fd 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -573,6 +573,7 @@ static int dmatest_func(void *data)
 	struct dmatest_params	*params;
 	struct dma_chan		*chan;
 	struct dma_device	*dev;
+	struct device		*dma_dev;
 	unsigned int		error_count;
 	unsigned int		failed_tests = 0;
 	unsigned int		total_tests = 0;
@@ -606,6 +607,8 @@ static int dmatest_func(void *data)
 	params = &info->params;
 	chan = thread->chan;
 	dev = chan->device;
+	dma_dev = dmaengine_get_dma_device(chan);
+
 	src = &thread->src;
 	dst = &thread->dst;
 	if (thread->type == DMA_MEMCPY) {
@@ -730,7 +733,7 @@ static int dmatest_func(void *data)
 			filltime = ktime_add(filltime, diff);
 		}
 
-		um = dmaengine_get_unmap_data(dev->dev, src->cnt + dst->cnt,
+		um = dmaengine_get_unmap_data(dma_dev, src->cnt + dst->cnt,
 					      GFP_KERNEL);
 		if (!um) {
 			failed_tests++;
@@ -745,10 +748,10 @@ static int dmatest_func(void *data)
 			struct page *pg = virt_to_page(buf);
 			unsigned long pg_off = offset_in_page(buf);
 
-			um->addr[i] = dma_map_page(dev->dev, pg, pg_off,
+			um->addr[i] = dma_map_page(dma_dev, pg, pg_off,
 						   um->len, DMA_TO_DEVICE);
 			srcs[i] = um->addr[i] + src->off;
-			ret = dma_mapping_error(dev->dev, um->addr[i]);
+			ret = dma_mapping_error(dma_dev, um->addr[i]);
 			if (ret) {
 				result("src mapping error", total_tests,
 				       src->off, dst->off, len, ret);
@@ -763,9 +766,9 @@ static int dmatest_func(void *data)
 			struct page *pg = virt_to_page(buf);
 			unsigned long pg_off = offset_in_page(buf);
 
-			dsts[i] = dma_map_page(dev->dev, pg, pg_off, um->len,
+			dsts[i] = dma_map_page(dma_dev, pg, pg_off, um->len,
 					       DMA_BIDIRECTIONAL);
-			ret = dma_mapping_error(dev->dev, dsts[i]);
+			ret = dma_mapping_error(dma_dev, dsts[i]);
 			if (ret) {
 				result("dst mapping error", total_tests,
 				       src->off, dst->off, len, ret);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

