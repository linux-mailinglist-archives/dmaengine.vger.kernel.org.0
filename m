Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3A4A1F9
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfFRNVa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 09:21:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33790 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRNVa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 09:21:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5IDLIXI095404;
        Tue, 18 Jun 2019 08:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560864078;
        bh=C7JoaS/KSR5kOredj6u+NHN8evey0o8bmyMIlXmzdPQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UA6N49ZabXq3vPChrBddi7saqDxZsP8Kt4eIYObGk+8vxxBbzZeh0PPkOLXz7r3qS
         xkSJQmR1XmivKP6+eLjORHtuSNz95HQi0Wl7BrukBn9CSaJvgdm9KvyiDKReDjlax3
         zRVlq20TJqpqVc/v/OPqFYHI4KuLSie32QobtzGs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5IDLIco021527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Jun 2019 08:21:18 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 18
 Jun 2019 08:21:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 18 Jun 2019 08:21:17 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5IDLBKl026006;
        Tue, 18 Jun 2019 08:21:15 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v4 2/3] dmaengine: ti: edma: Correct the residue calculation (fix for memcpy)
Date:   Tue, 18 Jun 2019 16:21:47 +0300
Message-ID: <20190618132148.26468-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618132148.26468-1-peter.ujfalusi@ti.com>
References: <20190618132148.26468-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For memcpy we never stored the start address of the transfer for the pset
which rendered the memcpy residue calculation completely broken.

In the edma_residue() function we also need to to some correction for the
calculations:
Instead waiting for all EDMA channels to be idle (in a busy system it can
take few iteration to hit a point when all queues are idle) wait for the
event pending on the given channel (SH_ER for hw synchronized channels,
SH_ESR for manually triggered channels).

If the position returned by EMDA is 0 it imiplies that the last paRAM set
has been consumed and we are at the closing dummy set, thus we can conclude
that the transfer is completed and we can return 0 as residue.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 3fd7831d1279..48b155cab822 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1039,6 +1039,7 @@ static int edma_config_pset(struct dma_chan *chan, struct edma_pset *epset,
 		src_cidx = cidx;
 		dst_bidx = acnt;
 		dst_cidx = cidx;
+		epset->addr = src_addr;
 	} else {
 		dev_err(dev, "%s: direction not implemented yet\n", __func__);
 		return -EINVAL;
@@ -1749,7 +1750,11 @@ static u32 edma_residue(struct edma_desc *edesc)
 	int loop_count = EDMA_MAX_TR_WAIT_LOOPS;
 	struct edma_chan *echan = edesc->echan;
 	struct edma_pset *pset = edesc->pset;
-	dma_addr_t done, pos;
+	dma_addr_t done, pos, pos_old;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	int idx = EDMA_REG_ARRAY_INDEX(channel);
+	int ch_bit = EDMA_CHANNEL_BIT(channel);
+	int event_reg;
 	int i;
 
 	/*
@@ -1762,16 +1767,20 @@ static u32 edma_residue(struct edma_desc *edesc)
 	 * "pos" may represent a transfer request that is still being
 	 * processed by the EDMACC or EDMATC. We will busy wait until
 	 * any one of the situations occurs:
-	 *   1. the DMA hardware is idle
-	 *   2. a new transfer request is setup
+	 *   1. while and event is pending for the channel
+	 *   2. a position updated
 	 *   3. we hit the loop limit
 	 */
-	while (edma_read(echan->ecc, EDMA_CCSTAT) & EDMA_CCSTAT_ACTV) {
-		/* check if a new transfer request is setup */
-		if (edma_get_position(echan->ecc,
-				      echan->slot[0], dst) != pos) {
+	if (is_slave_direction(edesc->direction))
+		event_reg = SH_ER;
+	else
+		event_reg = SH_ESR;
+
+	pos_old = pos;
+	while (edma_shadow0_read_array(echan->ecc, event_reg, idx) & ch_bit) {
+		pos = edma_get_position(echan->ecc, echan->slot[0], dst);
+		if (pos != pos_old)
 			break;
-		}
 
 		if (!--loop_count) {
 			dev_dbg_ratelimited(echan->vchan.chan.device->dev,
@@ -1796,6 +1805,12 @@ static u32 edma_residue(struct edma_desc *edesc)
 		return edesc->residue_stat;
 	}
 
+	/*
+	 * If the position is 0, then EDMA loaded the closing dummy slot, the
+	 * transfer is completed
+	 */
+	if (!pos)
+		return 0;
 	/*
 	 * For SG operation we catch up with the last processed
 	 * status.
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

