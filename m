Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D56F7B53E3
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 15:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjJBNSE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 09:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbjJBNSB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 09:18:01 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF3C6;
        Mon,  2 Oct 2023 06:17:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81AED1BF205;
        Mon,  2 Oct 2023 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696252676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+CSUvAMd1jybDq39rbPIkUIvZut6yZ4pfXMFOmMcHw=;
        b=Bu7573VhSa5erKsSfwK0iaEuh1VE0npy5odZq3iNi+YU0L+E6Tg69KeevCCXPqC0VXyT0a
        RZp//Qp3exSV75CU9MjD1plVw64IoBSBKPfq8+lVCOj7LfG3TPAAPh/aQiZ+tHCIbmce3x
        IFdbf3LBwq1ba/VIlrmUAIDMgJ8WJOPLvf9+v6ZZX/oOr9BKlYLaTpNUHktd7Dyq+lgWTj
        xzwh835qXlf65Ccnr+nmscYy5V4gVZb0cBcj90RF+c0KbU/r9K1dWAxSbA20feyzGcDzIs
        rj9+RKK49RBbwx2WPqWSgYgzkCgEV8EFgOoH1Gu7HABc0jo6qrkHAD+ofj8U2Q==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v2 4/5] dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
Date:   Mon,  2 Oct 2023 15:17:48 +0200
Message-Id: <20231002131749.2977952-5-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231002131749.2977952-1-kory.maincent@bootlin.com>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

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
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 0cce1880cfdc..26b5020dcc2a 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -221,6 +221,25 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
+/**
+ * dw_hdma_v0_sync_ll_data() - sync the ll data write
+ * @chunk: dma chunk
+ *
+ * In case of remote HDMA engine setup, the DW PCIe RP/EP internals
+ * configuration registers and Application memory are normally accesse
+ * over different buses. We need to insure ll data has been written before
+ * toggling the doorbell register.
+ */
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		/* Linux memory barriers don't cater for what's required here.
+		 * What's required is what's here - a read of the linked
+		 * list region.
+		 */
+		readl(chunk->ll_region.vaddr.io);
+}
+
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -251,6 +270,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
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

