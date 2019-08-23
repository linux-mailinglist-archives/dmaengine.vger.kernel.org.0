Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6709B01B
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2019 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394982AbfHWM4M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Aug 2019 08:56:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58866 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfHWM4L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Aug 2019 08:56:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7NCu6uB103832;
        Fri, 23 Aug 2019 07:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566564966;
        bh=z7aNVn0YYauCti4+ZL7WkTdhJclZFoX05/eUquPIZnU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=byBQEq30ILKRQAB4n4ESMgjjmPpVKcmVZoaZtDu7Sv1yotDwZAmksKVMSJcEbfaba
         /PgiYi0KmJ6aQCNtQ9iDq9hA0JgT9fpdLX94yMT/ItaNQbWhZ2AaXe1zgnPrG7R6oD
         qwvMwBOCSOEYpUQcw+ox0zqUOUfCi1X5+rs27kdA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7NCu6Em080831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Aug 2019 07:56:06 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 23
 Aug 2019 07:56:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 23 Aug 2019 07:56:06 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7NCtwkg092319;
        Fri, 23 Aug 2019 07:56:03 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH 2/5] dmaengine: ti: edma: Only reset region0 access registers
Date:   Fri, 23 Aug 2019 15:56:15 +0300
Message-ID: <20190823125618.8133-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823125618.8133-1-peter.ujfalusi@ti.com>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Region0 is used by Linux, do not reset other registers controlling access
for other shadow regions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 1aae95cc0d4b..87450431f336 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2434,11 +2434,10 @@ static int edma_probe(struct platform_device *pdev)
 		edma_assign_priority_to_queue(ecc, queue_priority_mapping[i][0],
 					      queue_priority_mapping[i][1]);
 
-	for (i = 0; i < ecc->num_region; i++) {
-		edma_write_array2(ecc, EDMA_DRAE, i, 0, 0x0);
-		edma_write_array2(ecc, EDMA_DRAE, i, 1, 0x0);
-		edma_write_array(ecc, EDMA_QRAE, i, 0x0);
-	}
+	edma_write_array2(ecc, EDMA_DRAE, 0, 0, 0x0);
+	edma_write_array2(ecc, EDMA_DRAE, 0, 1, 0x0);
+	edma_write_array(ecc, EDMA_QRAE, 0, 0x0);
+
 	ecc->info = info;
 
 	/* Init the dma device and channels */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

