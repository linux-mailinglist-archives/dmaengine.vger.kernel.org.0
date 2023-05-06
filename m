Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCD6F930F
	for <lists+dmaengine@lfdr.de>; Sat,  6 May 2023 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEFQWN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 May 2023 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEFQWL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 6 May 2023 12:22:11 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9634680
        for <dmaengine@vger.kernel.org>; Sat,  6 May 2023 09:22:10 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vKfgpvoXUU7B5vKfgpeMVi; Sat, 06 May 2023 18:22:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683390128;
        bh=tQOt5gblo50yrL9JEVMTC1Kl+IqfyNk1DzG+I68m8IY=;
        h=From:To:Cc:Subject:Date;
        b=p94vS1C8N7HOUEeVIz25beGwN21Adr6ZEyGrZH1UiycC2XTuLJfojX0oAmsxnfUTG
         K6Bn6vSB4JOcVBKwZvms6vjwwMB5tkSZO0oQBB30wqDI/KIZWuNYkq3lHSJVlfKWOW
         QLgcKeEQ2HhdDzGIuuOQ3GB4He4KFEFb0PjUZq5rY6od5MLPQXJm2Xxr8IYh2EiDh+
         wg02zCSDzpiJ8xnx0Nqo5XvFu7iXUGxMiqY8p0KP0GIX5LNljM4h6SWX2V88tH0YsG
         CZdvRYpRcnyiWCRZmwo7Fky/mq9mv4fQWPxCpV7XpqompwmJQ1vbskmotOrahPl815
         KaRIfIk+Rg2Eg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 18:22:08 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: mcf-edma: Use struct_size()
Date:   Sat,  6 May 2023 18:22:06 +0200
Message-Id: <97c2bb1c9b69d0739da3762a7752ae6582c4ad02.1683390112.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use struct_size() instead of hand writing it.
This is less verbose and more informative.

'mcf_chan' is now unused and can be removed. In fact, it is shadowed by
another variable in the 'for' loop below. Keep this one.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It will also help scripts when __counted_by macro will be added.
See [1].

[1]: https://lore.kernel.org/all/6453f739.170a0220.62695.7785@mx.google.com/
---
 drivers/dma/mcf-edma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
index ebd8733f72ad..28304dd8763a 100644
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -180,9 +180,8 @@ static int mcf_edma_probe(struct platform_device *pdev)
 {
 	struct mcf_edma_platform_data *pdata;
 	struct fsl_edma_engine *mcf_edma;
-	struct fsl_edma_chan *mcf_chan;
 	struct edma_regs *regs;
-	int ret, i, len, chans;
+	int ret, i, chans;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
@@ -191,8 +190,8 @@ static int mcf_edma_probe(struct platform_device *pdev)
 	}
 
 	chans = pdata->dma_channels;
-	len = sizeof(*mcf_edma) + sizeof(*mcf_chan) * chans;
-	mcf_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	mcf_edma = devm_kzalloc(&pdev->dev, struct_size(mcf_edma, chans, chans),
+				GFP_KERNEL);
 	if (!mcf_edma)
 		return -ENOMEM;
 
-- 
2.34.1

