Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22A7B53E0
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 15:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbjJBNSB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbjJBNSA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 09:18:00 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE531B0;
        Mon,  2 Oct 2023 06:17:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B9C41BF212;
        Mon,  2 Oct 2023 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696252675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6qb0UV8Z2ZKESqm4bQ1W8nZg6JqpnXsb2K3oQSjwYc=;
        b=RybW5RZYQzCY7NtLtfl1deihG3t1AsWq3uXVglpL4oTEmVrv66uF62mj8ofOQ4ei+Tl4jf
        UqJ8yHfWTm1l44Ipz03M62Ol+nxaaH8S14t1HOemxwgXgaeytay0BiwEYAniM7ZMzeoZdy
        rAHt6s57HVUOGxzImVDgq+CRsxuOIizesbTjE5eBoPmLnGip0FKVlqvQ2u79wfCyjIZxVO
        7JC0Z8tt83lgfAN0nMpBMmW5hWjc9fzEUKZ3jRG8tpVtI+UkThTaxAF62C6HXJJnsbGWbV
        2iA1t0I90grWFkUxNngK1ruE14nQvzP1tN8GVCaUiOPCAsnVUnm+q35dGWerbQ==
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
Subject: [PATCH v2 3/5] dmaengine: dw-edma: Add HDMA remote interrupt configuration
Date:   Mon,  2 Oct 2023 15:17:47 +0200
Message-Id: <20231002131749.2977952-4-kory.maincent@bootlin.com>
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

Only the local interruption was configured, remote interrupt was left
behind. This patch fix it by setting stop and abort remote interrupts when
the DW_EDMA_CHIP_LOCAL flag is not set.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 0afafc683a9e..0cce1880cfdc 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -236,6 +236,8 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
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

