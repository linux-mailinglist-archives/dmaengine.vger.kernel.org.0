Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E257A1CF61B
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgELNpl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 09:45:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35900 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgELNpl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 09:45:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CDjciR039248;
        Tue, 12 May 2020 08:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589291139;
        bh=+jnSnTwuT2CPfudwZC4+pQ+ZTdRbsNrMvMkC0HrHB00=;
        h=From:To:CC:Subject:Date;
        b=FL5MBUE7jMH19v+pHZEvBJ16g188h9eGexLpZK3DonFHLhBAiYqUnPEvjOAj6tHEQ
         YqK5+SUfGHs82432HIg1P/H0tHMczTrN2uCNnj5ti1qCuwW8NunwHbUi4BLfOjKilj
         vtG9HiPD7O4529L8hiBC+rjnAEtTB9QYgH9W0PH8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04CDjckN059612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 08:45:38 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 08:45:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 08:45:38 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CDjabY087567;
        Tue, 12 May 2020 08:45:37 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Remove udma_chan.in_ring_cnt
Date:   Tue, 12 May 2020 16:46:11 +0300
Message-ID: <20200512134611.6015-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The in_ring_cnt is not used for anything, it can be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 5afd0fde4706..e3983b764c10 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -231,7 +231,6 @@ struct udma_chan {
 	struct udma_tx_drain tx_drain;
 
 	u32 bcnt; /* number of bytes completed since the start of the channel */
-	u32 in_ring_cnt; /* number of descriptors in flight */
 
 	/* Channel configuration parameters */
 	struct udma_chan_config config;
@@ -574,7 +573,6 @@ static int udma_push_to_ring(struct udma_chan *uc, int idx)
 	struct udma_desc *d = uc->desc;
 	struct k3_ring *ring = NULL;
 	dma_addr_t paddr;
-	int ret;
 
 	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
@@ -598,11 +596,7 @@ static int udma_push_to_ring(struct udma_chan *uc, int idx)
 		udma_sync_for_device(uc, idx);
 	}
 
-	ret = k3_ringacc_ring_push(ring, &paddr);
-	if (!ret)
-		uc->in_ring_cnt++;
-
-	return ret;
+	return k3_ringacc_ring_push(ring, &paddr);
 }
 
 static bool udma_desc_is_rx_flush(struct udma_chan *uc, dma_addr_t addr)
@@ -655,9 +649,6 @@ static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
 						d->hwdesc[0].cppi5_desc_size,
 						DMA_FROM_DEVICE);
 		rmb(); /* Ensure that reads are not moved before this point */
-
-		if (!ret)
-			uc->in_ring_cnt--;
 	}
 
 	return ret;
@@ -697,8 +688,6 @@ static void udma_reset_rings(struct udma_chan *uc)
 		udma_desc_free(&uc->terminated_desc->vd);
 		uc->terminated_desc = NULL;
 	}
-
-	uc->in_ring_cnt = 0;
 }
 
 static void udma_reset_counters(struct udma_chan *uc)
@@ -1073,9 +1062,6 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 
 	/* Teardown completion message */
 	if (cppi5_desc_is_tdcm(paddr)) {
-		/* Compensate our internal pop/push counter */
-		uc->in_ring_cnt++;
-
 		complete_all(&uc->teardown_completed);
 
 		if (uc->terminated_desc) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

