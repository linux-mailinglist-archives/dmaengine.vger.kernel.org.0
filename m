Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77561729294
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jun 2023 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbjFIIRk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jun 2023 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbjFIIRg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jun 2023 04:17:36 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6C91FEC;
        Fri,  9 Jun 2023 01:17:02 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686298620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaIwrR05LfNW5SSLQAneAaJEWILGvAsISfahHxT0j/M=;
        b=Ex3mdL6eGB+jsiAganw8NeFfEveOKMnoTHHsGmGraYohL+oKAE+F/B9Hqq07myNS2d86D0
        m58xWjJxig8A3VFHxrQ6gkPNMk1q/PzKvcoUXN7tGHfoMYq/pth5TtFJdINUI+7+kufST0
        /exwSmDFjkMouCOk7+jlHMiTZ7UrgVwkjDSDmI7SpOu/Gaf37NubjLYP604h5G0foA9Ljn
        bHh/ASjJMWOwBaxbD+ABTbyqHE4IDoe4Lx5quchR/xFb2SFou/ZI8V2SFRf641EqHgIyyQ
        8uQccGgDyXVtM4KiAfqWnEwi6PzcUW/Vo47DmKm04LaQ45bZusVyp/I6ESAUgw==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED319C0006;
        Fri,  9 Jun 2023 08:16:59 +0000 (UTC)
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
Subject: [PATCH 4/9] dmaengine: dw-edma: HDMA: Add memory barrier before starting the DMA transfer in remote setup
Date:   Fri,  9 Jun 2023 10:16:49 +0200
Message-Id: <20230609081654.330857-5-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609081654.330857-1-kory.maincent@bootlin.com>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

This patch is fixing a commit which is only in dmaengine tree and not
merged mainline.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 7bd1a0f742be..0b77ddbe91b5 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -247,6 +247,15 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
+
+	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		/* Make sure Linked List has been written.
+		 * Linux memory barriers don't cater for what's required here.
+		 * What's required is what's here - a read of the linked
+		 * list region.
+		 */
+		readl(chunk->ll_region.vaddr.io);
+
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
-- 
2.25.1

