Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C188C1C468
	for <lists+dmaengine@lfdr.de>; Tue, 14 May 2019 10:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfENIJS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 May 2019 04:09:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45694 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfENIJR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 May 2019 04:09:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4E8906O075511;
        Tue, 14 May 2019 03:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557821340;
        bh=67I6cooNfh1F8AQXL7gdX4bUdrl5JfNMEDrEWLCHlZI=;
        h=From:To:CC:Subject:Date;
        b=ZoGoxTHeUhfongEglbY3PxQOCE2N8xA0H44sMqw1Qm0bAre2rdjnq63COttwZ/YLf
         lH5JnvnlCzGhBHsM4GCRcqrme+6dfshichnyKKtBLfc5raX2IZUMg7ZwCAqKGcfvMw
         Vhd2OwlJ+VpcQ7c9klAxQbf21mnZmuKiDQgo1ghE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4E88xuB023104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 May 2019 03:08:59 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 14
 May 2019 03:08:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 14 May 2019 03:08:59 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4E88v2H031599;
        Tue, 14 May 2019 03:08:57 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH] dmaengine: ti: edma: Enable support for polled (memcpy) completion
Date:   Tue, 14 May 2019 11:09:09 +0300
Message-ID: <20190514080909.10306-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When a DMA client driver decides that it is not providing callback for
completion of a transfer (and/or does not set the DMA_PREP_INTERRUPT) but
it will poll the status of the transfer (in case of short memcpy for
example) we will not get interrupt for the completion of the transfer and
will not mark the transaction as done.

Check the event registers (ER and EER) and if the channel is inactive then
return wioth DMA_COMPLETE to let the client know that the transfer is
completed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index ceabdea40ae0..7501445af069 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1211,8 +1211,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 
 	edesc->pset[0].param.opt |= ITCCHEN;
 	if (nslots == 1) {
-		/* Enable transfer complete interrupt */
-		edesc->pset[0].param.opt |= TCINTEN;
+		/* Enable transfer complete interrupt if requested */
+		if (tx_flags & DMA_PREP_INTERRUPT)
+			edesc->pset[0].param.opt |= TCINTEN;
 	} else {
 		/* Enable transfer complete chaining for the first slot */
 		edesc->pset[0].param.opt |= TCCHEN;
@@ -1239,7 +1240,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 		}
 
 		edesc->pset[1].param.opt |= ITCCHEN;
-		edesc->pset[1].param.opt |= TCINTEN;
+		/* Enable transfer complete interrupt if requested */
+		if (tx_flags & DMA_PREP_INTERRUPT)
+			edesc->pset[1].param.opt |= TCINTEN;
 	}
 
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
@@ -1801,6 +1804,20 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 	unsigned long flags;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
+
+	if (ret != DMA_COMPLETE && echan->edesc && !echan->edesc->cyclic) {
+		struct edma_cc *ecc = echan->ecc;
+		int channel = EDMA_CHAN_SLOT(echan->ch_num);
+		int j = (channel >> 5);
+		unsigned int mask = BIT(channel & 0x1f);
+		unsigned int sh_er = edma_shadow0_read_array(ecc, SH_ER, j);
+		unsigned int sh_eer = edma_shadow0_read_array(ecc, SH_EER, j);
+
+		/* The channel is no longer active */
+		if (!(sh_er & mask) && !(sh_eer & mask))
+			ret = DMA_COMPLETE;
+	}
+
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

