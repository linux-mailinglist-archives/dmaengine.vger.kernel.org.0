Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13567B53DF
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbjJBNSF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbjJBNSD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 09:18:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03FD9;
        Mon,  2 Oct 2023 06:17:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD3681BF216;
        Mon,  2 Oct 2023 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696252677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFnqrIivznbc7iY4pOaLEZYZBXChdROSQsmwT2VMB+U=;
        b=BKaiwBuMn/fwnRgXKNjIC2RC1raMjrtxyygUVqr8E4DjTT5BJUYlw/QkKwl1i+8a39Pwm/
        5Lq3WOnihBFL2GG+YOCcHZde8jefLLukH24pDbGyOSM2mvfS4ZGbamse1lWt+k3gG+a4aI
        sU3q1Sn1YiIiKrbaSlTqWD3U+/R/n02Bfz+NB/n6VaFw62F+Nst+eKhaR74cnltoMBxfJb
        wBkUM5sxVmWC4Vl8P9Wu+HlrjMttDLKlgWy7zlvGVm00epzRo5IAkgAWg4/Kmza/EDRZX3
        TSiHUyt2nEmra7XQKXcwCNjEnVBgaisd+8ifZ/9Ae9SUPiKN3aV9BsRf8V55LQ==
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
Subject: [PATCH v2 5/5] dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
Date:   Mon,  2 Oct 2023 15:17:49 +0200
Message-Id: <20231002131749.2977952-6-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231002131749.2977952-1-kory.maincent@bootlin.com>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

The Linked list element and pointer are not stored in the same memory as
the eDMA controller register. If the doorbell register is toggled before
the full write of the linked list a race condition error can appears.
In remote setup we can only use a readl to the memory to assured the full
write has occurred.

Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b38786f0ad79..75c0b1fa9c40 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -346,6 +346,25 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
 }
 
+/**
+ * dw_edma_v0_sync_ll_data() - sync the ll data write
+ * @chunk: dma chunk
+ *
+ * In case of remote eDMA engine setup, the DW PCIe RP/EP internals
+ * configuration registers and Application memory are normally accesse
+ * over different buses. We need to insure ll data has been written before
+ * toggling the doorbell register.
+ */
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+{
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		/* Linux memory barriers don't cater for what's required here.
+		 * What's required is what's here - a read of the linked
+		 * list region.
+		 */
+		readl(chunk->ll_region.vaddr.io);
+}
+
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
@@ -412,6 +431,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
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

