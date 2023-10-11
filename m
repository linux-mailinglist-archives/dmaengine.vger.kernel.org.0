Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D648B7C4CBB
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 10:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjJKIMt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 04:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjJKIMn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 04:12:43 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A131DA;
        Wed, 11 Oct 2023 01:12:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 475771BF20C;
        Wed, 11 Oct 2023 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697011957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raWpLxdnCsHiI6FQxGeq5/CW+Sjk7JXPZqqzsnU681g=;
        b=PdEzs+iwrBvoWBhPl97FjcpSGd90nBOEQ8xvaPJqFZ7EOnP3oVIei7hBWoOahPXkZiKoSx
        /eo7W0Bmiqth0V+eQESnoaYF7oZto0U9u57kkZUbon7wRGWnWbTk0pHou76+4tyfhmNHrj
        slmPP7CUxxKEsbcOPACjFRkqSdF4UPyK8sTNxvzqA9bz3z4olqOPb8rjmHMOj6vy5OE2WJ
        yRBPuUOe/3ahekYliDRdH3flj9EfuntbpXPyz+p2Prp4Mw/G3rf+BxjmZ8Zz+9GWcRjV+a
        RZBtCgCrdw7F14jdH3Eb9UmafuX+pLFOCM2lqm9xfacqRB7iwI0k/27CYO/ClA==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed, 11 Oct 2023 10:11:45 +0200
Subject: [PATCH v3 6/6] dmaengine: dw-edma: eDMA: Add sync read before
 starting the DMA transfer in remote setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-b4-feature_hdma_mainline-v3-6-24ee0c979c6f@bootlin.com>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Linked list element and pointer are not stored in the same memory as
the eDMA controller register. If the doorbell register is toggled before
the full write of the linked list a race condition error can appears.
In remote setup we can only use a readl to the memory to assured the full
write has occurred.

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- New patch
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b38786f0ad79..6245b720fbfe 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -346,6 +346,20 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	/*
+	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internals
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
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -412,6 +426,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
 	}
+
+	dw_edma_v0_sync_ll_data(chunk);
+
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));

-- 
2.25.1

