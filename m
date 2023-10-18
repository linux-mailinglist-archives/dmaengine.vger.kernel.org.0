Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89CE7CDF70
	for <lists+dmaengine@lfdr.de>; Wed, 18 Oct 2023 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjJROYW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Oct 2023 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345225AbjJROXz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Oct 2023 10:23:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687444209;
        Wed, 18 Oct 2023 07:15:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6509FC433BB;
        Wed, 18 Oct 2023 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638507;
        bh=zekRr9a00Jr3ArCQxgxsODP0YzWw4bHCuFhfHXDv9hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJMciktXwPiQPPfZQNUpy/xraA+rwInMq20Kj/5k2qJUXHhy8uDCtVYwFPwhLkrE1
         TOWUxsySo4pDVIZ5EfxF8cWmuDhzTVNGLVhxgDlADITZ/Nj0szn3/z8gAl6ga9tvoC
         WeLBvY7kQvhrSqY1/bsVRee1kq/alZV4Y/rkj1iG6GxPEUQik6x8+yb8AOvIrIJ4kh
         slfJU/ouat/YLXIh/G7sY7ZrRqT/j7kBHt5ZBkJaVfNVsLkr9KXiXqLki9fqoCQDpH
         1I/86MapGNvwib/Iuacg8g63vmgxbyheP/BX475LNKeAotXoJNx5ZvsRF1Wwo/BsH5
         OXIlncguMEDUg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 07/11] dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe
Date:   Wed, 18 Oct 2023 10:14:49 -0400
Message-Id: <20231018141455.1335353-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141455.1335353-1-sashal@kernel.org>
References: <20231018141455.1335353-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.198
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
index d99fec8215083..4c306dd13e865 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3698,6 +3698,7 @@ static int __init d40_probe(struct platform_device *pdev)
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
+	pm_runtime_disable(base->dev);
 
 	kfree(base->lcla_pool.alloc_map);
 	kfree(base->lookup_log_chans);
-- 
2.40.1

