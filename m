Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE52168CF
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 11:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgGGJJl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 05:09:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46864 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGJJl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 05:09:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06799bXc094489;
        Tue, 7 Jul 2020 04:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594112977;
        bh=apBcm8KT8pPXFkAQ+4y0dISm+b7P0iqDl7j3ffEUMtE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=my3/NmjFfvbhbwFo3DTdhwce4z8xLdtW/ZAVUJD7ZstGaLojGe0jyAn1a0Xr6r5RM
         sI6aaEAqf8kN3JHNKvbDZw6BVN91DHtc5bjjSnIdhiTCBKAFPQ/tq3rCDpVjr1AOju
         E5W0qmo4URmUBFsoCXldcgbmsPBA9E4BwXbDg1jI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06799Wgl086512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 04:09:37 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 04:09:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 04:09:35 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06799RGm052457;
        Tue, 7 Jul 2020 04:09:34 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH 1/5] dmaengine: ti: k3-udma: Remove dma_sync_single calls for descriptors
Date:   Tue, 7 Jul 2020 12:10:27 +0300
Message-ID: <20200707091031.10411-2-peter.ujfalusi@ti.com>
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

The descriptors are allocated via wither dma_pool or dma_alloc_coherent.

There is no need for the dma_sync_singel_* calls.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 6c879a734360..919669634d87 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -539,30 +539,6 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
 	return false;
 }
 
-static void udma_sync_for_device(struct udma_chan *uc, int idx)
-{
-	struct udma_desc *d = uc->desc;
-
-	if (uc->cyclic && uc->config.pkt_mode) {
-		dma_sync_single_for_device(uc->ud->dev,
-					   d->hwdesc[idx].cppi5_desc_paddr,
-					   d->hwdesc[idx].cppi5_desc_size,
-					   DMA_TO_DEVICE);
-	} else {
-		int i;
-
-		for (i = 0; i < d->hwdesc_count; i++) {
-			if (!d->hwdesc[i].cppi5_desc_vaddr)
-				continue;
-
-			dma_sync_single_for_device(uc->ud->dev,
-						d->hwdesc[i].cppi5_desc_paddr,
-						d->hwdesc[i].cppi5_desc_size,
-						DMA_TO_DEVICE);
-		}
-	}
-}
-
 static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
 {
 	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
@@ -593,7 +569,6 @@ static int udma_push_to_ring(struct udma_chan *uc, int idx)
 		paddr = udma_curr_cppi5_desc_paddr(d, idx);
 
 		wmb(); /* Ensure that writes are not moved over this point */
-		udma_sync_for_device(uc, idx);
 	}
 
 	return k3_ringacc_ring_push(ring, &paddr);
@@ -628,12 +603,12 @@ static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
 	}
 
 	if (ring && k3_ringacc_ring_get_occ(ring)) {
-		struct udma_desc *d = NULL;
-
 		ret = k3_ringacc_ring_pop(ring, addr);
 		if (ret)
 			return ret;
 
+		rmb(); /* Ensure that reads are not moved before this point */
+
 		/* Teardown completion */
 		if (cppi5_desc_is_tdcm(*addr))
 			return ret;
@@ -641,14 +616,6 @@ static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
 		/* Check for flush descriptor */
 		if (udma_desc_is_rx_flush(uc, *addr))
 			return -ENOENT;
-
-		d = udma_udma_desc_from_paddr(uc, *addr);
-
-		if (d)
-			dma_sync_single_for_cpu(uc->ud->dev, *addr,
-						d->hwdesc[0].cppi5_desc_size,
-						DMA_FROM_DEVICE);
-		rmb(); /* Ensure that reads are not moved before this point */
 	}
 
 	return ret;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

