Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB1A7C568E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbjJKOR1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346957AbjJKOR0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 10:17:26 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011CA7;
        Wed, 11 Oct 2023 07:17:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1394760011;
        Wed, 11 Oct 2023 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697033843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svngh7gavoOsAoTd14KvI+aVm1JHod9n5Mvh72UXNZY=;
        b=K+0KsVZ3BA/vLUJOTXyrJHGjkf1S7uVlIMYETl+hN76MKKXIj56hJ4b86OYyMy0qpdpslE
        PDE85LtXseROAHen6+fxvcJv9zDcK4IgJE/jMt/63TqSVevtnu1+XHsZPNuEj+iep2eeHR
        fMcMQxZ3oRLkyEglQYXz2bHO3ei6uNowDnCrRovkko6gVFudnqXVAcOKenVbgJGa+zbLUr
        ChDJUwQGsReMCIHcz9g8o8AwU1vKPUAI1c86M2RW6yYCEvS02XoZLsniEEE9XnWwJviG0r
        tU/KiFu8ooSeCcgJohdRQIexK1ZwDHjeGCZts5o/cn1ERZ7vEQ3TXGpLw+R2rQ==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed, 11 Oct 2023 16:17:00 +0200
Subject: [PATCH v4 4/6] dmaengine: dw-edma: Add HDMA remote interrupt
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-b4-feature_hdma_mainline-v4-4-43d417b93138@bootlin.com>
References: <20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com>
In-Reply-To: <20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>
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

Only the local interruption was configured, remote interrupt was left
behind. This patch fix it by setting stop and abort remote interrupts when
the DW_EDMA_CHIP_LOCAL flag is not set.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 108f9127aaaa..04b0bcb6ded9 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -237,6 +237,8 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
 		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
 		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);

-- 
2.25.1

