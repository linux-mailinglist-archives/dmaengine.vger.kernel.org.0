Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBD7C4CB4
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 10:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjJKIMe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 04:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjJKIMd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 04:12:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7CC98;
        Wed, 11 Oct 2023 01:12:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE3341BF206;
        Wed, 11 Oct 2023 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697011950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zfuTvre0UzAi4GpamYmN3E9uemUolgHrcnYVxe0/6o=;
        b=cwZtJjF55N4K1zCBuf7PfW7hNYydtD8p1nr7TpEtIiG+2S1jcgcesg0cUMQGTTeupwaQRD
        iM1rNe9SIQWe+rz4XDOEQJ3wtqaV3zbVWVw7TT/uuVNsUowGpFGegTvMjZpChSZdkDzaRG
        BvKPHYzmL7nETO6EnWPXmrF0jDyyBCqt+27QME7b836VzPKKq2+Vkf3XFfW3xIsCuPgG1o
        FFhIFcK0aqVR0SBuzistjylQtMtlgX4K6IoMIvFiB48CbK+SuOH4sjwd7JXszy+tbhCqx6
        5W992I8Q3I2FkBGGltAyIK2KBFitdV2tyH63hIJEEvP4VMDVxRCB9K344ZNAsQ==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed, 11 Oct 2023 10:11:41 +0200
Subject: [PATCH v3 2/6] dmaengine: dw-edma: Fix wrong interrupt bit set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-b4-feature_hdma_mainline-v3-2-24ee0c979c6f@bootlin.com>
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

Fix "HDMA_V0_LOCAL_STOP_INT_EN" to "HDMA_V0_LOCAL_ABORT_INT_EN" as the STOP
bit is already set in the same line.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---

Changes in v3:
- Split the patch in two to differ bug fix and simple harmless typo.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1f4cb7db5475..108f9127aaaa 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -236,7 +236,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Interrupt enable&unmask - done, abort */
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
 		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
-		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
+		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);

-- 
2.25.1

