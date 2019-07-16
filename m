Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED086A3BA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfGPIYO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 04:24:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51812 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfGPIYO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Jul 2019 04:24:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6G8O5VV119076;
        Tue, 16 Jul 2019 03:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563265445;
        bh=FQHBBqqUreCc29zYpsi4qJzXPSnKlBjRH1T19Nb9E1M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=juid4IpLl2bYjyFaWX1Gjky77VMHy+aQ2DAXR8JR6P55W7Stj7COJYIOkjPHlfBz1
         9xxYbjzvG3GdYbmOV2PnhiuwBfST/OXJoXEoWr8aNkC4o5ppn/cJRdWBDOSu/WbWUD
         IG4OudAhW1k9MkmClEmC2Ztf/RvYtqGZ1NSciWp0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6G8O53g099841
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jul 2019 03:24:05 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Jul 2019 03:24:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Jul 2019 03:24:04 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6G8O0lg033709;
        Tue, 16 Jul 2019 03:24:02 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 1/2] dmaengine: ti: omap-dma: Readability cleanup in omap_dma_tx_status()
Date:   Tue, 16 Jul 2019 11:24:58 +0300
Message-ID: <20190716082459.1222-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716082459.1222-1-peter.ujfalusi@ti.com>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The tx_status is most likely going to be asked for the current transfer, so
check that first then try to fall back to lookup of non started transfers.

In this way the code is a bit more readable and in most cases we will avoid
to run vchan_find_desc() all the time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/omap-dma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index ba2489d4ea24..029c0bd550d5 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -832,10 +832,8 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 		return ret;
 
 	spin_lock_irqsave(&c->vc.lock, flags);
-	vd = vchan_find_desc(&c->vc, cookie);
-	if (vd) {
-		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
-	} else if (c->desc && c->desc->vd.tx.cookie == cookie) {
+
+	if (c->desc && c->desc->vd.tx.cookie == cookie) {
 		struct omap_desc *d = c->desc;
 		dma_addr_t pos;
 
@@ -847,11 +845,15 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 			pos = 0;
 
 		txstate->residue = omap_dma_desc_size_pos(d, pos);
+	} else if ((vd = vchan_find_desc(&c->vc, cookie))) {
+		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
 	} else {
 		txstate->residue = 0;
 	}
+
 	if (ret == DMA_IN_PROGRESS && c->paused)
 		ret = DMA_PAUSED;
+
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
 	return ret;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

