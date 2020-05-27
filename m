Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284551E39D5
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2020 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgE0HFi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 May 2020 03:05:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54890 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgE0HFi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 May 2020 03:05:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04R75Z9d119022;
        Wed, 27 May 2020 02:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590563135;
        bh=sezBODDlFoQDRRA5rGxNZgNFx87UJqeBJPxyRXFruWg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MxmMlxtHrV2/06pXxZTcOq/nAdILKc50tZTpTcatWgLUMl9Vb9yuo6f3vtziQa3oD
         BbLK1/0hBvTsF8zYxpJlu4BEa+zORzXq7UyNMRNnQmO+F3YAgjuNyZJwBL0Y2X/+7Y
         EwrvG//0nqNfzYbZ0A2IRZm4Tf8d8IagbMyl6U+I=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04R75Zte115863
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 02:05:35 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 May 2020 02:05:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 May 2020 02:05:34 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04R75UF6065430;
        Wed, 27 May 2020 02:05:33 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH 2/2] dmaengine: ti: k3-udma: Fix the running channel handling in alloc_chan_resources
Date:   Wed, 27 May 2020 10:06:12 +0300
Message-ID: <20200527070612.636-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527070612.636-1-peter.ujfalusi@ti.com>
References: <20200527070612.636-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the unlikely case when the channel is running (RT enabled) during
alloc_chan_resources then we should use udma_reset_chan() and not
udma_stop() as the later is trying to initiate a teardown on the channel,
which is not valid at this point.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 502d7f2edd8a..0d5fb154b8e2 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1848,7 +1848,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_stop(uc);
+		udma_reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

