Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B0624BC8
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 11:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEUJgm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 05:36:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43398 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUJgm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 May 2019 05:36:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4L9aaMn098360;
        Tue, 21 May 2019 04:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558431396;
        bh=GxL6bewKmok2K7kcNTTkF6/TucQW9A3nmg8gzoigNdg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H+looPK3EAy+tE5QRwlleHXYrg7fRyZM+3opkRhG8QPEmFeTI4c9FQag+ujuE2o70
         5aZ2Omv1Du9f8sTedOByowdOdiasKfWRYaTkyV6B8JimGqqqe+6fB9JhCQJPYYgN7h
         rpreUoZDC7uVgiuA2tY0n83Zj3kSpbAF5FW3coUM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4L9aaPK030354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 May 2019 04:36:36 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 21
 May 2019 04:36:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 21 May 2019 04:36:36 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4L9aUgb018934;
        Tue, 21 May 2019 04:36:35 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v3 2/2] dmaengine: ti: edma: Enable support for polled (memcpy) completion
Date:   Tue, 21 May 2019 12:36:46 +0300
Message-ID: <20190521093646.21836-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521093646.21836-1-peter.ujfalusi@ti.com>
References: <20190521093646.21836-1-peter.ujfalusi@ti.com>
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
index a39f817b3888..1ad539c38468 100644
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

