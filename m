Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B143501927
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiDNQyZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242512AbiDNQyI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 12:54:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F65D13CEC9
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 09:23:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2FF-0007Vc-4s; Thu, 14 Apr 2022 18:22:57 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2FF-00313Z-50; Thu, 14 Apr 2022 18:22:55 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2F9-00GuF2-Sv; Thu, 14 Apr 2022 18:22:51 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 21/21] ASoC: fsl_micfil: Remove debug message
Date:   Thu, 14 Apr 2022 18:22:49 +0200
Message-Id: <20220414162249.3934543-22-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220414162249.3934543-1-s.hauer@pengutronix.de>
References: <20220414162249.3934543-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The micfil driver prints out the IRQ numbers for each interrupt at error
level. This information is useful for debugging at best, remove it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
---

Notes:
    Changes since v3:
    - new patch

 sound/soc/fsl/fsl_micfil.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 8c7b15dbd1d45..cd85c8714f970 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -597,7 +597,6 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	/* get IRQs */
 	for (i = 0; i < MICFIL_IRQ_LINES; i++) {
 		micfil->irq[i] = platform_get_irq(pdev, i);
-		dev_err(&pdev->dev, "GET IRQ: %d\n", micfil->irq[i]);
 		if (micfil->irq[i] < 0)
 			return micfil->irq[i];
 	}
-- 
2.30.2

