Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48DC5304FC
	for <lists+dmaengine@lfdr.de>; Sun, 22 May 2022 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350038AbiEVRlY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 May 2022 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349974AbiEVRlQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 22 May 2022 13:41:16 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6322D167DC
        for <dmaengine@vger.kernel.org>; Sun, 22 May 2022 10:41:13 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id spZjnWR0UgNxBspZjnfQ7n; Sun, 22 May 2022 19:41:11 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 22 May 2022 19:41:11 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: lgm: Fix an error handling path in intel_ldma_probe()
Date:   Sun, 22 May 2022 19:41:05 +0200
Message-Id: <18504549bc4d2b62a72a02cb22a2e4d8e6a58720.1653241224.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ldma_clk_disable() calls both:
	clk_disable_unprepare(d->core_clk);
	reset_control_assert(d->rst);

So, should devm_reset_control_get_optional() fail, core_clk should not
be prepare_enable'd before it, otherwise it will never be
disable_unprepare'd.

Reorder the code to handle the error handling path as expected.

Fixes: 32d31c79a1a4 ("dmaengine: Add Intel LGM SoC DMA support.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/lgm/lgm-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index efe8bd3a0e2a..9b9184f964be 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -1593,11 +1593,12 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	d->core_clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(d->core_clk))
 		return PTR_ERR(d->core_clk);
-	clk_prepare_enable(d->core_clk);
 
 	d->rst = devm_reset_control_get_optional(dev, NULL);
 	if (IS_ERR(d->rst))
 		return PTR_ERR(d->rst);
+
+	clk_prepare_enable(d->core_clk);
 	reset_control_deassert(d->rst);
 
 	ret = devm_add_action_or_reset(dev, ldma_clk_disable, d);
-- 
2.34.1

