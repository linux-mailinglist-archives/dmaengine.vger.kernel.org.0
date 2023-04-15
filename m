Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5416E30E8
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDOKtK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDOKsc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD59ED5;
        Sat, 15 Apr 2023 03:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B2E60A47;
        Sat, 15 Apr 2023 10:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B6AC433EF;
        Sat, 15 Apr 2023 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681555619;
        bh=18h7yJ4dungwOKffwnbsdGXL7tiydULOEDbCcZ66iBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyAvtD+Suf4/SUkan//MnSBSdyqeFc0SonNaw8cHANd/q6xFnbtfbXkNq3L/DSIdC
         02a/m4s1pGiCiRiyGt8mr9mShw4DmlXKrkyZ1Maw5wGstS3AGB/POejilB/aYwzV7F
         Z5eDVmdxlHL0+wVaBtZGiFvl+pAdOrfJWqlzicZw98O9j+nRyvZ3bA9ELMvn8xxydx
         0Kyu5wCQcJTRqfU4KTt0s/69NzQ3oaXJaXH6REqYFdYp5XeXU4+Fgb/6/RHUlxDhjK
         mMwPLTwOA3ClxowjcZntLdLbkPPgiDdj/kDJZv7WgVGljcUrw+1DnacvxBxZNwuspD
         wtufttvDj0ozw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] dmaengine: dw-axi-dmac: remove unnecessary devm_free_irq() calling
Date:   Sat, 15 Apr 2023 18:35:52 +0800
Message-Id: <20230415103601.2979-3-jszhang@kernel.org>
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

In dw_remove(), We have disabled the irq from the dw-axi-dma side, so
we are safe against the case "The irq is still ON when devices remove
is executed and irq should be quiesced before remove is completed."

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 23a10dbdecb7..56f12dfa410d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1542,8 +1542,6 @@ static int dw_remove(struct platform_device *pdev)
 	pm_runtime_disable(chip->dev);
 	axi_dma_suspend(chip);
 
-	devm_free_irq(chip->dev, chip->irq, chip);
-
 	of_dma_controller_free(chip->dev->of_node);
 
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
-- 
2.39.2

