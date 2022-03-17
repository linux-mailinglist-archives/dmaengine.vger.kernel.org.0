Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7719B4DC119
	for <lists+dmaengine@lfdr.de>; Thu, 17 Mar 2022 09:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiCQI34 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Mar 2022 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiCQI3z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Mar 2022 04:29:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA16E019
        for <dmaengine@vger.kernel.org>; Thu, 17 Mar 2022 01:28:39 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nUlUo-00068t-7h; Thu, 17 Mar 2022 09:28:34 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nUlUm-0027Ti-PP; Thu, 17 Mar 2022 09:28:32 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 03/19] ASoC: fsl_micfil: drop fsl_micfil_set_mclk_rate()
Date:   Thu, 17 Mar 2022 09:28:02 +0100
Message-Id: <20220317082818.503143-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220317082818.503143-1-s.hauer@pengutronix.de>
References: <20220317082818.503143-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
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

All that the .set_sysclk hook in the micfil driver does is to pass
the sysclk frequency to fsl_micfil_set_mclk_rate(). This function
expects the sample rate as argument though, not any kind of sysclk
frequency. The resulting rate setting of the clock is overwritten
in hw_params anyway, so drop this altogether.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_micfil.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index cf10c212d770d..5353474d0ff2b 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -358,30 +358,10 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int fsl_micfil_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
-				     unsigned int freq, int dir)
-{
-	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
-	struct device *dev = &micfil->pdev->dev;
-
-	int ret;
-
-	if (!freq)
-		return 0;
-
-	ret = fsl_micfil_set_mclk_rate(micfil, freq);
-	if (ret < 0)
-		dev_err(dev, "failed to set mclk[%lu] to rate %u\n",
-			clk_get_rate(micfil->mclk), freq);
-
-	return ret;
-}
-
 static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
 	.startup = fsl_micfil_startup,
 	.trigger = fsl_micfil_trigger,
 	.hw_params = fsl_micfil_hw_params,
-	.set_sysclk = fsl_micfil_set_dai_sysclk,
 };
 
 static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
-- 
2.30.2

