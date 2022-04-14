Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574E50191E
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 18:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbiDNQyO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiDNQyG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 12:54:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD0913CCEE
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 09:22:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2FC-0007PT-Na; Thu, 14 Apr 2022 18:22:54 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2FD-00312h-6p; Thu, 14 Apr 2022 18:22:53 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2F9-00GuEK-Qs; Thu, 14 Apr 2022 18:22:51 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 19/21] ASoC: fsl_micfil: drop support for undocumented property
Date:   Thu, 14 Apr 2022 18:22:47 +0200
Message-Id: <20220414162249.3934543-20-s.hauer@pengutronix.de>
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

The "fsl,shared-interrupt" property is undocumented and unnecessary.
Just pass IRQF_SHARED unconditionally.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
---
 sound/soc/fsl/fsl_micfil.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 89af6cfe24e69..a603033daed69 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -554,7 +554,6 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *regs;
 	int ret, i;
-	unsigned long irqflag = 0;
 
 	micfil = devm_kzalloc(&pdev->dev, sizeof(*micfil), GFP_KERNEL);
 	if (!micfil)
@@ -618,12 +617,9 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 			return micfil->irq[i];
 	}
 
-	if (of_property_read_bool(np, "fsl,shared-interrupt"))
-		irqflag = IRQF_SHARED;
-
 	/* Digital Microphone interface interrupt */
 	ret = devm_request_irq(&pdev->dev, micfil->irq[0],
-			       micfil_isr, irqflag,
+			       micfil_isr, IRQF_SHARED,
 			       micfil->name, micfil);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to claim mic interface irq %u\n",
@@ -633,7 +629,7 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 
 	/* Digital Microphone interface error interrupt */
 	ret = devm_request_irq(&pdev->dev, micfil->irq[1],
-			       micfil_err_isr, irqflag,
+			       micfil_err_isr, IRQF_SHARED,
 			       micfil->name, micfil);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to claim mic interface error irq %u\n",
-- 
2.30.2

