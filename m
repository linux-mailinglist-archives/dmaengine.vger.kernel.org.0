Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9036B7F29
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCMRRO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCMRRA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F29A5A928;
        Mon, 13 Mar 2023 10:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D1261381;
        Mon, 13 Mar 2023 17:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318E9C4339B;
        Mon, 13 Mar 2023 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727740;
        bh=Wq9HdywcRzw2m/st4OKSeu8XmLXjFD1NNFfAN6itaz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKgd+ztaC39soHjcw/Zova9uilv09zfak4DBc6q5EpKhTdjMsEKuqZEbB1FWzkTTu
         j2apkY5HKm8HXIvXu6IEDUIQYId4xdoE27ejvIrCItoeam7kSIiwqjA+mNUAeLt/Qi
         xuQbCXysqla3PlCHbm9OqCwrBY0tLXDEX/cb8uWdmJulSjMPr21NPwHStU6+E/K9uD
         wrajF/s6kdeFzBilf9JukGJSLltythKuNtvhNJvhNVSR5ZWiOb7SyBcX26cX9kTxro
         TJISaXkvnCIZQXwuRgLgJRl4whOx0Xfm8qRXv5r/RNnmtV9l9MEN0iu0VbA+k/R3dQ
         Re6Ny4Jucq0JQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] dmaengine: dw-axi-dmac: delay irq getting until request_irq
Date:   Tue, 14 Mar 2023 01:04:44 +0800
Message-Id: <20230313170450.897-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313170450.897-1-jszhang@kernel.org>
References: <20230313170450.897-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

