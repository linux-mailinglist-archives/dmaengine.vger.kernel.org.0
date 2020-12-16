Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F462DC363
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 16:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725274AbgLPPsR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Dec 2020 10:48:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48342 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgLPPsR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Dec 2020 10:48:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BGFlXhA063332;
        Wed, 16 Dec 2020 09:47:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608133653;
        bh=C6JSxO3a7ViYCM/ckqr/jQXBVjXS0ZvS2smJlEBUfl4=;
        h=From:To:CC:Subject:Date;
        b=t9NV3jQ7XDvy6SLwBxM4JlALktTr51L1hp4opRW09IWlpr+kxkIGBxXd8H0IvKNN4
         i9NHvhgoQ1xKo98hN2rTYobX13pZeybRG32UQkN9urQGxO1rwQy0/zhtqjDeLwDOKg
         mjcOWtJsPvSUH2NVb/VaKDw4SazybTDwvY2xTPi0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BGFlX5C086881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 09:47:33 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Dec 2020 09:47:33 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Dec 2020 09:47:32 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BGFlV58045030;
        Wed, 16 Dec 2020 09:47:31 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Fix pktdma rchan TPL level setup
Date:   Wed, 16 Dec 2020 17:48:33 +0200
Message-ID: <20201216154833.20821-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Instead of initializing the rchan_tpl the initial commit re-initialized
the tchan_tpl.

Fixes: d2abc982333c0 ("dmaengine: ti: k3-udma: Initial support for K3 PKTDMA")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index d4ab7f144c75..aa6186a1223d 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4774,9 +4774,9 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 		ud->tchan_tpl.levels = 1;
 	}
 
-	ud->tchan_tpl.levels = ud->tchan_tpl.levels;
-	ud->tchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[0];
-	ud->tchan_tpl.start_idx[1] = ud->tchan_tpl.start_idx[1];
+	ud->rchan_tpl.levels = ud->tchan_tpl.levels;
+	ud->rchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[0];
+	ud->rchan_tpl.start_idx[1] = ud->tchan_tpl.start_idx[1];
 
 	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

