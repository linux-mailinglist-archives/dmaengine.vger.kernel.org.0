Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354E675DD54
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jul 2023 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjGVP64 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jul 2023 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVP6z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jul 2023 11:58:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74991FDF
        for <dmaengine@vger.kernel.org>; Sat, 22 Jul 2023 08:58:50 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NF0FqBMdqoFSdNF0FqaSjc; Sat, 22 Jul 2023 17:58:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690041524;
        bh=7h7BXIi417HcJ7IVXgwp14lvQ+AKlv7jQenrpvVP09g=;
        h=From:To:Cc:Subject:Date;
        b=Inif3SLu+aoCjx+IQwQ8bAKNRAckAT1iVU7BanPLRxUxwWZsLpC7aoyXtMKoH/Vwy
         cq/2OA/xgdpvLghZeidgSATaYfAj0zWhzd8R+HwoQx62WW2l08Z8W0Z4AHXwDnAA8z
         7JhBU77Eb3GkIHabjaIdYnFDcfleWLcD9NMuDVz+0V/xaBwi/rAcTAGxHowPwLOU9C
         K7f4J5QcvB7eDpO4q8OmrY0bIChH9mCrM4VNQyUlY+8Irm/U2QJGFqNr2GhcXU7juR
         YMLJ2/XVkDMFuaC2omqfBoYEgJQKY9jr037SqSgDijIDi9Ak7ac+2wBfAri8ZHw36e
         ogdxX4dc4I6PA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 17:58:44 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: ep93xx: Use struct_size()
Date:   Sat, 22 Jul 2023 17:58:40 +0200
Message-Id: <36fa11d95b448b5f3f1677da41fe35b9e2751427.1690041500.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use struct_size() instead of hand-writing it, when allocating a structure
with a flex array.

This is less verbose, more robust and more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It will also be helpful if the __counted_by() annotation is added with a
Coccinelle script such as:
   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/counted_by&id=adc5b3cb48a049563dc673f348eab7b6beba8a9b
---
 drivers/dma/ep93xx_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 5338a94f1a69..5c4a448a1254 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1320,11 +1320,9 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
 	struct ep93xx_dma_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct ep93xx_dma_engine *edma;
 	struct dma_device *dma_dev;
-	size_t edma_size;
 	int ret, i;
 
-	edma_size = pdata->num_channels * sizeof(struct ep93xx_dma_chan);
-	edma = kzalloc(sizeof(*edma) + edma_size, GFP_KERNEL);
+	edma = kzalloc(struct_size(edma, channels, pdata->num_channels), GFP_KERNEL);
 	if (!edma)
 		return -ENOMEM;
 
-- 
2.34.1

