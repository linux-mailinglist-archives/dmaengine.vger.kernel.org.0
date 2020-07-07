Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC50216A16
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgGGKWz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 06:22:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54250 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgGGKWz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 06:22:55 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 067AMq8W114151;
        Tue, 7 Jul 2020 05:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594117372;
        bh=apBcm8KT8pPXFkAQ+4y0dISm+b7P0iqDl7j3ffEUMtE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ioZ5B3VlY6DL9yF9cZXyfX7x1ymk6lol7Q/hhi9uJtXKg+nVYYmnuXWLTWuo/7W2d
         UVuPrkTkisNTyEyJFcXhtzg6SpsXWRolYGKEmhju02uCphRP4mHDBuK2eAgwByxLJ7
         J4ib/JHV3hSh5JjOaqQ0uCrX62nn0OKrL2cmYKto=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 067AMqd1063200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 05:22:52 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 05:22:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 05:22:52 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067AMmac054798;
        Tue, 7 Jul 2020 05:22:50 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 1/5] dmaengine: ti: k3-udma: Remove dma_sync_single calls for descriptors
Date:   Tue, 7 Jul 2020 13:23:48 +0300
Message-ID: <20200707102352.28773-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707102352.28773-1-peter.ujfalusi@ti.com>
References: <20200707102352.28773-1-peter.ujfalusi@ti.com>
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

