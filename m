Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0858E7692D9
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGaKOw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 06:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjGaKOv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 06:14:51 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AD8E3
        for <dmaengine@vger.kernel.org>; Mon, 31 Jul 2023 03:14:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACE4B1BF209;
        Mon, 31 Jul 2023 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690798489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dHh+33T/p3O910tAiQDRaPdGhqm/kMGZdU0Eay9+h4=;
        b=SN4TFl8B2PELsl2XPp24QRdL1/mJKIRG5/BxqpTjyYG41ok9789F5eM3Wr9CGq5iCzewIM
        eXIRB1YSJ/uCnh+Uo+KwP7sb/9KzBJHYkMCwequVM+rcfceW498eRQXxwo83+37PYeEj02
        hxKGgJiNgwM3sC3LqMSn2n0JOP/uIWTP3/jXz48OLbFo9ILoiSvudoj4Fom2f38vNxlZdJ
        o3vaXubMGRMhWIGP0y4BXKGK6VLhic1OX29BjkDtPx5GklzC2pK9Bv17rTBuT+XrLmNh9I
        t++36TXuBJSQGXeGPHMKRDoRRKQREG8IObFtgatndAEkWGuxTlzwrA3cqKuvng==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/4] dmaengine: xilinx: xdma: Fix typo
Date:   Mon, 31 Jul 2023 12:14:40 +0200
Message-Id: <20230731101442.792514-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731101442.792514-1-miquel.raynal@bootlin.com>
References: <20230731101442.792514-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Probably a copy/paste error with the previous block, here we are
actually managing C2H IRQs.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 359123526dd0..5cdb19bd80a7 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -717,7 +717,7 @@ static int xdma_irq_init(struct xdma_device *xdev)
 		ret = request_irq(irq, xdma_channel_isr, 0,
 				  "xdma-c2h-channel", &xdev->c2h_chans[j]);
 		if (ret) {
-			xdma_err(xdev, "H2C channel%d request irq%d failed: %d",
+			xdma_err(xdev, "C2H channel%d request irq%d failed: %d",
 				 j, irq, ret);
 			goto failed_init_c2h;
 		}
-- 
2.34.1

