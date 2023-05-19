Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96B709363
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjESJgo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 May 2023 05:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjESJg1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 May 2023 05:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB031BC1;
        Fri, 19 May 2023 02:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C0A655B6;
        Fri, 19 May 2023 09:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB93C433EF;
        Fri, 19 May 2023 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684488892;
        bh=LAoKjMeFQXh9WKY0mviRB9jJBiyu4k4R57L17sXUcpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=F/3GLRHwi6iVYpdhFPhRF1YVpQnKl0RmfNAgxXmXJRGW6yigVmLWXuaaGAYage971
         OFvBGWZmieCFmAmpr5XqpL8O/67Vte/QeVkxtkjiGBiUPnTv9JrinKxOr9wZ2NJSU+
         3xPQBfz4ehvL2qGwMoEQAcYsHLUs/8F5wOxmiC2UY0ZP1dz9aEwvV6RhPjyDmFia2r
         TGgiOJNZRZjrx/9kaDmWvUOjUIKQNi66r8Cw6qKKSGBP5zsF2R3JBPoOKWaiSmkCjU
         HpDUCAUalun0TpDRA7oBhLR/nfmDHVIfEy3hi5EvaVQVRH3pJScXgTy5+wlERDGjhh
         fTucJeEuDxCFQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] dmaengine: ste_dma40: use proper format string for resource_size_t
Date:   Fri, 19 May 2023 11:34:38 +0200
Message-Id: <20230519093447.4097040-1-arnd@kernel.org>
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

A fixup for a printk format string warning causes an out-of-bounds
variable access as the %pR string expects a struct resource instead of
a plain resource_size_t.

Change both to the special %pap and %pap helpers for these types.

Fixes: 5a1a3b9c19dd ("dmaengine: ste_dma40: Get LCPA SRAM from SRAM node")
Fixes: ef1e1c41a11d ("dmaengine: ste_dma40: use correct print specfier for resource_size_t")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix up incorrect fix misusing %pR
---
 drivers/dma/ste_dma40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 8e9c02f83fc7..803c65cd6712 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3536,8 +3536,8 @@ static int __init d40_probe(struct platform_device *pdev)
 	}
 	base->lcpa_size = resource_size(&res_lcpa);
 	base->phy_lcpa = res_lcpa.start;
-	dev_info(dev, "found LCPA SRAM at 0x%08x, size %pR\n",
-		 (u32)base->phy_lcpa, &base->lcpa_size);
+	dev_info(dev, "found LCPA SRAM at %pad, size %pa\n",
+		 &base->phy_lcpa, &base->lcpa_size);
 
 	/* We make use of ESRAM memory for this. */
 	val = readl(base->virtbase + D40_DREG_LCPA);
-- 
2.39.2

