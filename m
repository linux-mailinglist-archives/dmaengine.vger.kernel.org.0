Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E127CDF3C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Oct 2023 16:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbjJROSY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Oct 2023 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbjJROSQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Oct 2023 10:18:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3F49FC;
        Wed, 18 Oct 2023 07:16:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E900CC433CC;
        Wed, 18 Oct 2023 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638582;
        bh=WHnnd90rLnf8jpNRxFcfyRVBWvywCkM/Goa6sLpEoPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yx8s/waTsgP4Mt9MfguFIudKGqszHukXkpyOuLdy15MF0svyXi355L52Jo+vr6dSX
         hvmnxHe21FPZln+UzdhOIi8cbJlrNz3Jh+zkvyECXoEli1WVHIy6F/SEsKkF9rLsid
         w5kEMCqYza5fsnUfHc9rAjK9CAn+0ExOQJAqxdtH7q1vWaPUMa4iK4RrX6pwkJYkW5
         qeqQnsQ9bJpG63wCdI2rmJauJXM41Vc6DiJpZ2QSi4xDFzmAO/K7PGT8oJ5rY1vfKb
         mOTnlp+gnT+lS9CniY7T01cKG1Sn1kyXJ8lBDfqcF4lp8MFEp3StTNvFbdVLsHY4NY
         og5eCYuSFMqBQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/7] dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe
Date:   Wed, 18 Oct 2023 10:16:09 -0400
Message-Id: <20231018141613.1335848-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141613.1335848-1-sashal@kernel.org>
References: <20231018141613.1335848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.327
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 0618c077a8c20e8c81e367988f70f7e32bb5a717 ]

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context.
We fix it by calling pm_runtime_disable when error returns.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/tencent_DD2D371DB5925B4B602B1E1D0A5FA88F1208@qq.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ste_dma40.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 498d9886ed9bc..bb39b04d67d71 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3678,6 +3678,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
 	kfree(base->lcla_pool.alloc_map);
 	kfree(base->lookup_log_chans);
-- 
2.40.1

