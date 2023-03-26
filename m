Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD796C92E6
	for <lists+dmaengine@lfdr.de>; Sun, 26 Mar 2023 09:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCZHGu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Mar 2023 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCZHGt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Mar 2023 03:06:49 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD834A5D2
        for <dmaengine@vger.kernel.org>; Sun, 26 Mar 2023 00:06:47 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gKSipZ5u2E500gKSipnFEo; Sun, 26 Mar 2023 09:06:44 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Mar 2023 09:06:44 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: mv_xor_v2: Fix an error code.
Date:   Sun, 26 Mar 2023 09:06:37 +0200
Message-Id: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the probe is deferred, -EPROBE_DEFER should be returned, not
+EPROBE_DEFER.

Fixes: 3cd2c313f1d6 ("dmaengine: mv_xor_v2: Fix clock resource by adding a register clock")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/mv_xor_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 89790beba305..0991b8265829 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -752,7 +752,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 
 	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
-		ret = EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
 		goto disable_reg_clk;
 	}
 	if (!IS_ERR(xor_dev->clk)) {
-- 
2.34.1

