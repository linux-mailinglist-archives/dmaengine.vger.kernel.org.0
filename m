Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C570ADD2
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjEULsO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEUK1w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEF910E6;
        Sun, 21 May 2023 03:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A85A760E74;
        Sun, 21 May 2023 10:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB34C4339B;
        Sun, 21 May 2023 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664612;
        bh=+Tf439DcPyOhnrJYLUHMQ/cInIgZ19g0uwID2SQPxBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onljlQhnGLnsMg8c1ByUgOfPf+pW4AQdNXQQfNkiVzxEmVJIqo1lCyYXS617e7stn
         SLs3YAiTnhWULSS0eEE1vuuZLP9FuwgB/MMv488p0Bql484cf/ntGD45TRB4KlDzQ6
         pXt4ZUYZMo3SKUsI9BOE5PGrVSw1r55lVhpXyIMirQEzAb/fC9SvEVQwN0inkwp0Nt
         xWe6V7FF9wzKr12vR0+o2jNptP86lAmi+U8XUuLnEdgH8BJlyfr4TrZmWkPipBrq5L
         Px0JE2bkVCUzf9+H6BKb3NQocHi0nnR2/TtPOTrq+JxT61sntQD/Ou112+Sz2qS9HL
         b9fhqCoe1CunQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] dmaengine: dw-axi-dmac: delay irq getting until request_irq
Date:   Sun, 21 May 2023 18:12:10 +0800
Message-Id: <20230521101216.4084-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521101216.4084-1-jszhang@kernel.org>
References: <20230521101216.4084-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index e596910e9f84..64b4ee2d618b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1403,10 +1403,6 @@ static int dw_probe(struct platform_device *pdev)
 	chip->dev = &pdev->dev;
 	chip->dw->hdata = hdata;
 
-	chip->irq = platform_get_irq(pdev, 0);
-	if (chip->irq < 0)
-		return chip->irq;
-
 	chip->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
@@ -1447,6 +1443,10 @@ static int dw_probe(struct platform_device *pdev)
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
2.40.0

