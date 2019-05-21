Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED7B24993
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEUH7m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 03:59:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51398 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfEUH7m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 May 2019 03:59:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4L7xaA7120057;
        Tue, 21 May 2019 02:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558425576;
        bh=5FvJ6nHLjhjVMrC3TxE53QTyFIFMi2zQ7rGA3i0mTRA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TjLtTLB08aPVw+6l7OG6wm3UtFsXU61Y8HXE3XT+qwXj9iIdXXPsedsCnAVBCItw9
         0St/vWQsV7eo7/1wdW9MEJCINhZrkIvJJrF3WucD6KFQQKmez8dZbXF/rZ4VJNlVdf
         Qh4QpFQXfU+Y/e/vhhJuQvQkSIwGhelENH/U0Xtw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4L7xa7l073407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 May 2019 02:59:36 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 21
 May 2019 02:59:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 21 May 2019 02:59:35 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4L7xUk1078442;
        Tue, 21 May 2019 02:59:34 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 2/2] dmaengine: ti: edma: Enable support for polled (memcpy) completion
Date:   Tue, 21 May 2019 10:59:45 +0300
Message-ID: <20190521075945.14085-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521075945.14085-1-peter.ujfalusi@ti.com>
References: <20190521075945.14085-1-peter.ujfalusi@ti.com>
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
return with DMA_COMPLETE to let the client know that the transfer is
completed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index a5822925a327..0f4873c2aa12 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1226,8 +1226,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 
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
@@ -1254,7 +1255,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 		}
 
 		edesc->pset[1].param.opt |= ITCCHEN;
-		edesc->pset[1].param.opt |= TCINTEN;
+		/* Enable transfer complete interrupt if requested */
+		if (tx_flags & DMA_PREP_INTERRUPT)
+			edesc->pset[1].param.opt |= TCINTEN;
 	}
 
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
@@ -1816,6 +1819,20 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 	unsigned long flags;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
+
+	if (ret != DMA_COMPLETE && echan->edesc && !echan->edesc->cyclic) {
+		struct edma_cc *ecc = echan->ecc;
+		int channel = EDMA_CHAN_SLOT(echan->ch_num);
+		int idx = EDMA_REG_ARRAY_INDEX(channel);
+		int ch_bit = EDMA_CHANNEL_BIT(channel);
+		unsigned int sh_er = edma_shadow0_read_array(ecc, SH_ER, idx);
+		unsigned int sh_eer = edma_shadow0_read_array(ecc, SH_EER, idx);
+
+		/* The channel is no longer active */
+		if (!(sh_er & ch_bit) && !(sh_eer & ch_bit))
+			ret = DMA_COMPLETE;
+	}
+
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

