Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E234A706062
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 08:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjEQGpA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjEQGot (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 02:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997A426B1
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 23:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC8A6360C
        for <dmaengine@vger.kernel.org>; Wed, 17 May 2023 06:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA59C433EF;
        Wed, 17 May 2023 06:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684305887;
        bh=KCTC5QHFyubfdtA0DbLUsXoNLZpdpf2o3rF8b4RQnsE=;
        h=From:To:Cc:Subject:Date:From;
        b=CKJR27JxWqz2KCsXRCrqY6ws4/FdVLu9FeqVqIR6GyTDmfahGGNQQrJEgnoosroyX
         oSsAPSXl+OMBALnQ/WxakvWzOr0bzw8JkAundReOxkPaOCqFSWi/hUJ3Az5KfV1+7H
         X97VrYP0M7+vqXNHNWxF1z8k76yw0jUleQses/rkVw0gs0v7Ttk2QFjGGgJBSc+oHS
         H/L5VagyLOk5vSvVu7/8sedSpa5EWjS5EQsLWZtgk2MZ3sdVJafT3Vg0Lgrm7cs6kK
         BHDjzSmSaSsYO5KCnuJI813aFY34o/YtUKu9u0Rz0TlehWDyr/z/Cj8/DEMxq+ZnDh
         W+M3Akh2NaRtg==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] dmaengine: ste_dma40: use correct print specfier for resource_size_t
Date:   Wed, 17 May 2023 12:14:33 +0530
Message-Id: <20230517064434.141091-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
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

We should use %pR for printing resource_size_t, so update that fixing
the warning:

drivers/dma/ste_dma40.c:3556:25: warning: format specifies type 'unsigned int'
but the argument has type 'resource_size_t' (aka 'unsigned long long') [-Wformat]

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5a1a3b9c19dd ("dmaengine: ste_dma40: Get LCPA SRAM from SRAM node")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/ste_dma40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c30d00a78eed..56c839241a53 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3542,8 +3542,8 @@ static int __init d40_probe(struct platform_device *pdev)
 	}
 	base->lcpa_size = resource_size(&res_lcpa);
 	base->phy_lcpa = res_lcpa.start;
-	dev_info(dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
-		 (u32)base->phy_lcpa, base->lcpa_size);
+	dev_info(dev, "found LCPA SRAM at 0x%08x, size %pR\n",
+		 (u32)base->phy_lcpa, &base->lcpa_size);
 
 	/* We make use of ESRAM memory for this. */
 	val = readl(base->virtbase + D40_DREG_LCPA);
-- 
2.40.1

