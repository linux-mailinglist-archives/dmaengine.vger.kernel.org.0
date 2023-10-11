Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDCE7C4CB9
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 10:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjJKIMn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjJKIMm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 04:12:42 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489DA9E;
        Wed, 11 Oct 2023 01:12:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB7801BF207;
        Wed, 11 Oct 2023 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697011954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svngh7gavoOsAoTd14KvI+aVm1JHod9n5Mvh72UXNZY=;
        b=Mh4FFs5qGnnta/KdhOFirxSlbpfwyU8rWS7+pkpEzJHs0IcWQ4Pc1Bd3A0ZhunxMo2zIfH
        HyjTs249F1qpcLVApKrrb7H1MZ8O3X5ojm3NQi0nde5Z74VcOUnspyXIPHjWzYF4uCgiwG
        6tXRh3TiwjaHQidUuiJ5+5NpiwXCSn77BQ8WAWKu5r4pxzgZTgtrS5EKqFmx31GWNGGanO
        QEP4fXaB6CTcvzGAlAVx4Uy6BQjlndJodNLLxGZ6dEnSUrPRmMOX94lnTnwMEDDr2vPuF6
        BY5mAeAfjpzbZLizS7IKzL3KdMsbaB+zZeO0+C4JQc+6XkqQOZW+FclSunsyGg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Wed, 11 Oct 2023 10:11:43 +0200
Subject: [PATCH v3 4/6] dmaengine: dw-edma: Add HDMA remote interrupt
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-b4-feature_hdma_mainline-v3-4-24ee0c979c6f@bootlin.com>
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

