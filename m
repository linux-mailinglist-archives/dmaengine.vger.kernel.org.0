Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4210F189
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2019 21:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLBUbn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Dec 2019 15:31:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56508 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLBUbn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Dec 2019 15:31:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB2KVU2q064017;
        Mon, 2 Dec 2019 14:31:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575318690;
        bh=WJ7/iDoH+LgZm+FTh1H3GU4VY8iNBVP3eVx3nZf37Js=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ibwwyX4C1bE891UNaonAVXRMx4ZwTY4Gfe3ExB59ZVRB+mLyo1AiwGq6KFphTiRhN
         /3OjZmoSlmWh35JsB26bZKAmsWRt8+I2j25SZdzbPV3bGOMeTTpazJGhcIydY9WL42
         45wOkoCc7Sg+If53ly5IkB5/r9mqlBKq7RX7ypKo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB2KVU89001490
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Dec 2019 14:31:30 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Dec
 2019 14:31:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Dec 2019 14:31:30 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB2KVOPm106889;
        Mon, 2 Dec 2019 14:31:27 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <vigneshr@ti.com>
Subject: [PATCH 1/3] dmaengine: ti: k3-udma: Correct completed descriptor's residue value
Date:   Mon, 2 Dec 2019 22:31:26 +0200
Message-ID: <20191202203128.14348-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202203128.14348-1-peter.ujfalusi@ti.com>
References: <0191128105945.13071-1-peter.ujfalusi@ti.com>
 <20191202203128.14348-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The residue should show the number of _not_ completed bytes, so it has to
be 0 when the full transfer is completed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c1450b0a8224..1b929f7a84d4 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2784,13 +2784,14 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 
 		if (cppi5_desc_get_type(desc_vaddr) ==
 		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
-			result->residue = cppi5_hdesc_get_pktlen(desc_vaddr);
-			if (result->residue == d->residue)
-				result->result = DMA_TRANS_NOERROR;
-			else
+			result->residue = d->residue -
+					  cppi5_hdesc_get_pktlen(desc_vaddr);
+			if (result->residue)
 				result->result = DMA_TRANS_ABORTED;
+			else
+				result->result = DMA_TRANS_NOERROR;
 		} else {
-			result->residue = d->residue;
+			result->residue = 0;
 			result->result = DMA_TRANS_NOERROR;
 		}
 	}
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

