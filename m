Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0439F7072DF
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 22:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjEQUT6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEQUT6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 16:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B681FE5;
        Wed, 17 May 2023 13:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8E02636B3;
        Wed, 17 May 2023 20:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9214EC433EF;
        Wed, 17 May 2023 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684354796;
        bh=h3i1Kbtu2+A1CAmny+IHIGNGTx6Ino27EpoDhBCMCUg=;
        h=From:To:Cc:Subject:Date:From;
        b=dKTVy9RVKLUOGSJm4GI2wiXXavIxvJWRQOXFML1qF5dX6IQv/j/BQ6OaaGy1EZqrF
         QjDxyEbxGDQMGJU6/anHP0DmQ1SbRsrsqNQd+pDZ/H+Na1pefAzI2HHDI5F+wEXZgx
         1HOHkb86GpqWY1YuS/jZ/Q1TACdvCNg/xWDInApnYvb875r1BuhPrO41mIt5fh1nEI
         akTM8FKO4g1jA4i1ku59nOLBOhiEh3Jcdy9CH0ndt1QvULB22Ks2YcRN6t0KAFbhbm
         9LbEfcVyimFeGNWIdT9yHa1J4HlFev9CcniTZC+iStMbCy37giqWRUAR8saClYm0zk
         DptvrOxjgrWLg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: ste_dma40: use proper format string for resource_size_t
Date:   Wed, 17 May 2023 22:19:47 +0200
Message-Id: <20230517201951.619693-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

When LPAE is set, both the dma_addr_t and resource_size_t become 64 bit
wide, causing a warning about the format string:

drivers/dma/ste_dma40.c: In function 'd40_probe':
drivers/dma/ste_dma40.c:3539:23: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
 3539 |         dev_info(dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",

Change both to the special %pap and %pap helpers for these types.

Fixes: 5a1a3b9c19dd ("dmaengine: ste_dma40: Get LCPA SRAM from SRAM node")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ste_dma40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 9ff6dd9e2fa2..dbc988cfc4bf 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3536,8 +3536,8 @@ static int __init d40_probe(struct platform_device *pdev)
 	}
 	base->lcpa_size = resource_size(&res_lcpa);
 	base->phy_lcpa = res_lcpa.start;
-	dev_info(dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
-		 (u32)base->phy_lcpa, base->lcpa_size);
+	dev_info(dev, "found LCPA SRAM at %pad, size %pa\n",
+		 &base->phy_lcpa, &base->lcpa_size);
 
 	/* We make use of ESRAM memory for this. */
 	val = readl(base->virtbase + D40_DREG_LCPA);
-- 
2.39.2

