Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8BE7C4CBA
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 10:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjJKIMv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 04:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjJKIMn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 04:12:43 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610BCC4;
        Wed, 11 Oct 2023 01:12:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 477A91BF20B;
        Wed, 11 Oct 2023 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697011956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czWpdkchpjIcmkN5wE2Ao4sOST4MTB7arrN4NTSp2AY=;
        b=ZAMMWcZIv3fUK0YhnOY6IGV91gV13RwXR1jadOMLxKqrh96UtzvCyUR1Qr9RUKkdm84Ekj
        ogmgBZpcsht4rXjfbkjOVzWBmGYsBed15hgAOlzoXo9OvLDS+9hEOYWTVpdeDmK7UFn6Uz
        4jMShL7Whh9qY04DzrIjj2wPqZS+DYjCGJ+PkIXcaotTpiWoNdQ38wSoFwlTlGnRv93aQ0
        C12YRSDgaqsUo9u24oi/1Rv37dhG2BDsvIV/GaU9jbz0aGqlOMnwRqcqJnP+61d8NyTglv
        jeYDppQ7/rnxsnc4MWkteZwtRYVWOpJ3PraMrbgbbiG9U1BTGwDvJ8SzSWuJEQ==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed, 11 Oct 2023 10:11:44 +0200
Subject: [PATCH v3 5/6] dmaengine: dw-edma: HDMA: Add sync read before
 starting the DMA transfer in remote setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-b4-feature_hdma_mainline-v3-5-24ee0c979c6f@bootlin.com>
References: <20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com>
In-Reply-To: <20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Linked list element and pointer are not stored in the same memory as
the HDMA controller register. If the doorbell register is toggled before
the full write of the linked list a race condition error can appears.
In remote setup we can only use a readl to the memory to assured the full
write has occurred.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Move the sync read in a function.
- Add commments
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 04b0bcb6ded9..13b6aec6a6de 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -222,6 +222,20 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	/*
+	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internals
+	 * configuration registers and Application memory are normally accessed
+	 * over different buses. Ensure LL-data reaches the memory before the
+	 * doorbell register is toggled by issuing the dummy-read from the remote
+	 * LL memory in a hope that the posted MRd TLP will return only after the
+	 * last MWr TLP is completed
+	 */
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chunk->ll_region.vaddr.io);
+}
+
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -252,6 +266,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+
+	dw_hdma_v0_sync_ll_data(chunk);
+
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }

-- 
2.25.1

