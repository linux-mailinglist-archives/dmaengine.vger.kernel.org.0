Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286AC5B86DE
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 13:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiINLBA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiINLA7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 07:00:59 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C83868D;
        Wed, 14 Sep 2022 04:00:58 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28EB0pFl020848;
        Wed, 14 Sep 2022 06:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663153251;
        bh=N3V5rQp5fY9ZZxVnAZrfo3lpoBY/T8FN05g1IIxelYU=;
        h=From:To:CC:Subject:Date;
        b=nCoGwY/A+gFTrgD/14uhQ9x42e0ouRDgezkp2SG7Jrh/aFxJrNK8E9Jr5b0lmGHw6
         r5qgz6UUMwvbHzktz+kwGm1doC7EizAjrB9ycCIqUUXAUmvrfz3i1xqn6TUpjW4EB6
         rxueViV1+BdL8AOPp/0Fwe0QA3oQfu55+qC8xpH8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28EB0pYo016195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Sep 2022 06:00:51 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 14
 Sep 2022 06:00:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 14 Sep 2022 06:00:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28EB0nE9103334;
        Wed, 14 Sep 2022 06:00:50 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <dmaengine@vger.kernel.org>
CC:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <peter.ujfalusi@gmail.com>, <vigneshr@ti.com>, <vkoul@kernel.org>,
        <vaishnav.a@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma: Respond TX done if DMA_PREP_INTERRUPT is not requested
Date:   Wed, 14 Sep 2022 16:30:49 +0530
Message-ID: <20220914110049.5842-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the DMA consumer driver does not expect the callback for TX done, then
we need not perform the channel RT byte counter calculations and estimate
the completion but return complete on first attempt itself.This assumes
that the consumer who did not request DMA_PREP_INTERRUPT has its own
mechanism for understanding TX completion, example: MCSPI EOW interrupt
can be used as TX completion signal for a SPI transaction.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---

V1->V2:
	* Add comment to explain the expectations from the consumer
	when DMA_PREP_INTERRUPT is not requested.
	* v1 was sent as series:
	https://lore.kernel.org/lkml/20220822091531.27827-2-vaishnav.a@ti.com/

 drivers/dma/ti/k3-udma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 39b330ada200..fbb80a6e59b2 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -263,6 +263,7 @@ struct udma_chan_config {
 	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
 
 	u32 tr_trigger_type;
+	unsigned long tx_flags;
 
 	/* PKDMA mapped channel */
 	int mapped_channel_id;
@@ -1055,9 +1056,14 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
 {
 	u32 peer_bcnt, bcnt;
 
-	/* Only TX towards PDMA is affected */
+	/*
+	 * Only TX towards PDMA is affected.
+	 * If DMA_PREP_INTERRUPT is not set by consumer then skip the transfer
+	 * completion calculation, consumer must ensure that there is no stale
+	 * data in DMA fabric in this case.
+	 */
 	if (uc->config.ep_type == PSIL_EP_NATIVE ||
-	    uc->config.dir != DMA_MEM_TO_DEV)
+	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
 		return true;
 
 	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
@@ -3418,6 +3424,8 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (!burst)
 		burst = 1;
 
+	uc->config.tx_flags = tx_flags;
+
 	if (uc->config.pkt_mode)
 		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
 					   context);
-- 
2.17.1

