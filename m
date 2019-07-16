Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701C36A3C8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfGPI0M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 04:26:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43300 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfGPI0L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Jul 2019 04:26:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6G8Q47R114442;
        Tue, 16 Jul 2019 03:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563265564;
        bh=INN8eT9Tuq8HUrMekaBYruIJDFB4niwn3CDGYmdZlz4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=F6L+LqbgAYmwu/oCbR/YjbnSLrvApeMDtbO8aTDr8Ga4FYB/ZJrSQ1RDszlr7Bs+z
         XlkEDznObLeEil7wqdT1HQXQqfn/TW+YTxwgdm6awLHo8rRDFX6rkgWgB7KNFQDeOQ
         6LQcaGfRZ/56YHrEoIAd/vVgf7guJiEsKDbLpHX0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6G8Q4V7102469
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jul 2019 03:26:04 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Jul 2019 03:26:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Jul 2019 03:26:03 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6G8PuBq103858;
        Tue, 16 Jul 2019 03:26:01 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v5 3/3] dmaengine: ti: edma: Support for polled (memcpy) completion
Date:   Tue, 16 Jul 2019 11:26:55 +0300
Message-ID: <20190716082655.1620-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716082655.1620-1-peter.ujfalusi@ti.com>
References: <20190716082655.1620-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
does not want to use interrupts for DMA completion or because it can not
rely on DMA interrupts due to executing the memcpy when interrupts are
disabled it will poll the status of the transfer.

Since we can not tell from any EDMA register that the transfer is
completed, we can only know that the paRAM set has been sent to TPTC for
processing we need to check the residue of the transfer, if it is 0 then
the transfer is completed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 5b8cbd6d7610..bcd431283d8a 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -180,6 +180,7 @@ struct edma_desc {
 	struct list_head		node;
 	enum dma_transfer_direction	direction;
 	int				cyclic;
+	bool				polled;
 	int				absync;
 	int				pset_nr;
 	struct edma_chan		*echan;
@@ -1227,8 +1228,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 
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
@@ -1255,9 +1257,14 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 		}
 
 		edesc->pset[1].param.opt |= ITCCHEN;
-		edesc->pset[1].param.opt |= TCINTEN;
+		/* Enable transfer complete interrupt if requested */
+		if (tx_flags & DMA_PREP_INTERRUPT)
+			edesc->pset[1].param.opt |= TCINTEN;
 	}
 
+	if (!(tx_flags & DMA_PREP_INTERRUPT))
+		edesc->polled = true;
+
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
 
@@ -1827,18 +1834,40 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 	struct virt_dma_desc *vdesc;
+	struct dma_tx_state txstate_tmp;
 	enum dma_status ret;
 	unsigned long flags;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE || !txstate)
+
+	if (ret == DMA_COMPLETE)
 		return ret;
 
+	/* Provide a dummy dma_tx_state for completion checking */
+	if (!txstate)
+		txstate = &txstate_tmp;
+
+	txstate->residue = 0;
 	spin_lock_irqsave(&echan->vchan.lock, flags);
 	if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie)
 		txstate->residue = edma_residue(echan->edesc);
 	else if ((vdesc = vchan_find_desc(&echan->vchan, cookie)))
 		txstate->residue = to_edma_desc(&vdesc->tx)->residue;
+
+	/*
+	 * Mark the cookie completed if the residue is 0 for non cyclic
+	 * transfers
+	 */
+	if (ret != DMA_COMPLETE && !txstate->residue &&
+	    echan->edesc && echan->edesc->polled &&
+	    echan->edesc->vdesc.tx.cookie == cookie) {
+		edma_stop(echan);
+		vchan_cookie_complete(&echan->edesc->vdesc);
+		echan->edesc = NULL;
+		edma_execute(echan);
+		ret = DMA_COMPLETE;
+	}
+
 	spin_unlock_irqrestore(&echan->vchan.lock, flags);
 
 	return ret;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

