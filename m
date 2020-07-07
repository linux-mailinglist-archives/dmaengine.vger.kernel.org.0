Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514112168D1
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 11:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGJJp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 05:09:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60476 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGJJo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 05:09:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06799fZL049829;
        Tue, 7 Jul 2020 04:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594112981;
        bh=pmiAoMPT2Jn0ftgcwU5NoB6hnpkce0XQLrDZsXfC6sA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GD6NqUS/bZT0FwEEcj8ODA/hgg9simrnajY3Jmpxvrxf+vCakxxbkrZ8AtxKcYFlz
         PYxO8Rz4jIOyLEi0E1Pa2MI/S7B7wg7ncA3igeHGzJjT8opfQHUPG04oJS9M27XJHE
         8v8Gg2H8IqKrDgIdKwV73uT5RFu4qA8lu4QnjIwU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06799arT076026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 04:09:41 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 04:09:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 04:09:37 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06799RGn052457;
        Tue, 7 Jul 2020 04:09:36 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH 2/5] dmaengine: ti: k3-udma: Do not use ring_get_occ in udma_pop_from_ring
Date:   Tue, 7 Jul 2020 12:10:28 +0300
Message-ID: <20200707091031.10411-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707091031.10411-1-peter.ujfalusi@ti.com>
References: <20200707091031.10411-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The ring_get_occ is redundant as the k3_ringacc_ring_pop() is also
checking the occ of the ring.

With removing the ring_get_occ, the function can be simplified as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 919669634d87..c2b3792bed54 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -588,7 +588,7 @@ static bool udma_desc_is_rx_flush(struct udma_chan *uc, dma_addr_t addr)
 static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
 {
 	struct k3_ring *ring = NULL;
-	int ret = -ENOENT;
+	int ret;
 
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
@@ -599,26 +599,24 @@ static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
 		ring = uc->tchan->tc_ring;
 		break;
 	default:
-		break;
+		return -ENOENT;
 	}
 
-	if (ring && k3_ringacc_ring_get_occ(ring)) {
-		ret = k3_ringacc_ring_pop(ring, addr);
-		if (ret)
-			return ret;
+	ret = k3_ringacc_ring_pop(ring, addr);
+	if (ret)
+		return ret;
 
-		rmb(); /* Ensure that reads are not moved before this point */
+	rmb(); /* Ensure that reads are not moved before this point */
 
-		/* Teardown completion */
-		if (cppi5_desc_is_tdcm(*addr))
-			return ret;
+	/* Teardown completion */
+	if (cppi5_desc_is_tdcm(*addr))
+		return 0;
 
-		/* Check for flush descriptor */
-		if (udma_desc_is_rx_flush(uc, *addr))
-			return -ENOENT;
-	}
+	/* Check for flush descriptor */
+	if (udma_desc_is_rx_flush(uc, *addr))
+		return -ENOENT;
 
-	return ret;
+	return 0;
 }
 
 static void udma_reset_rings(struct udma_chan *uc)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

