Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A2B59BC97
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiHVJRZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiHVJPx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 05:15:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60252A40A;
        Mon, 22 Aug 2022 02:15:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27M9FZbu019388;
        Mon, 22 Aug 2022 04:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661159735;
        bh=CCFuC6F3PDmk2qInbJWBLRf6Yk6t6h+PLhjhJhuGEiU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wVHPOOoOSXMNWegBZxJgN9tTlzrUxjqKFEC2pfWyu1jkiRQVmWYH48cilDIOW81A4
         GXbLcOKJryRxCgnVAVsaVziLaLnwBdnwv+Q76xPG0blv49+9fwhorbI1fneWITb5uh
         VN91c/YXBIolZRYwsNATRwAawDB84QRYNLmzhpmM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27M9FYu9111259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 04:15:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 04:15:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 04:15:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27M9FXYS037071;
        Mon, 22 Aug 2022 04:15:34 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <broonie@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <vigneshr@ti.com>, <kishon@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 1/2] dmaengine: ti: k3-udma: Respond TX done if DMA_PREP_INTERRUPT is not requested
Date:   Mon, 22 Aug 2022 14:45:30 +0530
Message-ID: <20220822091531.27827-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822091531.27827-1-vaishnav.a@ti.com>
References: <20220822091531.27827-1-vaishnav.a@ti.com>
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

When the DMA consumer driver does not expect the callback for TX done,
There is no need to perform the channel RT byte counter calculations 
and estimate the completion but return complete on first attempt itself.
This assumes that the consumer who did not request DMA_PREP_INTERRUPT 
has its own mechanism for understanding TX completion, example: MCSPI
EOW interrupt can be used as TX completion signal for a SPI transaction.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 drivers/dma/ti/k3-udma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 39b330ada200..03d579068453 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -263,6 +263,7 @@ struct udma_chan_config {
 	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
 
 	u32 tr_trigger_type;
+	unsigned long tx_flags;
 
 	/* PKDMA mapped channel */
 	int mapped_channel_id;
@@ -1057,7 +1058,7 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
 
 	/* Only TX towards PDMA is affected */
 	if (uc->config.ep_type == PSIL_EP_NATIVE ||
-	    uc->config.dir != DMA_MEM_TO_DEV)
+	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
 		return true;
 
 	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
@@ -3418,6 +3419,8 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (!burst)
 		burst = 1;
 
+	uc->config.tx_flags = tx_flags;
+
 	if (uc->config.pkt_mode)
 		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
 					   context);
-- 
2.17.1

