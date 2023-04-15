Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1706E30EC
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDOKt2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDOKtI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9088691;
        Sat, 15 Apr 2023 03:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22CF4617D4;
        Sat, 15 Apr 2023 10:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919D8C4339C;
        Sat, 15 Apr 2023 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681555623;
        bh=Wq9HdywcRzw2m/st4OKSeu8XmLXjFD1NNFfAN6itaz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1V1Glt+7qP0DuKq0r9iCQFfwK+4c4koQxWYQQB3BhE1vLCWuNR6VCP0ez+35Lape
         Cc/tFcbYQYFEpoiQGedC/z/f2P+NScvijDQyvZe6VckFMvPcFTuj45zhHzzAWInmc2
         7ng45PY8VTZPKuJTsn9lKIethfa/fF4KwWGMmA+I8rA3YF70Xr60jKd2izA8GwlNlR
         JSnGvIhRC1uvn3+jinujgR6R+654mW6BKj43u4iBul8+71k3g8I9fC0WHXxtF/sM+9
         b7As7vusHOcTLE0vZ+lrDRVtMSbTjHiLXdSDJ1s0ViHDIgjwpLTGQ1LjiH3TRjV2vu
         jbylsVKmQhn6g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] dmaengine: dw-axi-dmac: delay irq getting until request_irq
Date:   Sat, 15 Apr 2023 18:35:55 +0800
Message-Id: <20230415103601.2979-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415103601.2979-1-jszhang@kernel.org>
References: <20230415103601.2979-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is to prepare for per-channel irq support in next patch. In
per-channel irq case, we need to parse dt firstly to know whether
the platform is per-channel irq or not.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 410222e7224c..6087fb7d567a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1395,10 +1395,6 @@ static int dw_probe(struct platform_device *pdev)
 	chip->dev = &pdev->dev;
 	chip->dw->hdata = hdata;
 
-	chip->irq = platform_get_irq(pdev, 0);
-	if (chip->irq < 0)
-		return chip->irq;
-
 	chip->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
@@ -1426,6 +1422,10 @@ static int dw_probe(struct platform_device *pdev)
 	if (!dw->chan)
 		return -ENOMEM;
 
+	chip->irq = platform_get_irq(pdev, 0);
+	if (chip->irq < 0)
+		return chip->irq;
+
 	ret = devm_request_irq(chip->dev, chip->irq, dw_axi_dma_interrupt,
 			       IRQF_SHARED, KBUILD_MODNAME, chip);
 	if (ret)
-- 
2.39.2

