Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1C4E9567
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbiC1Lln (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbiC1Lgf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 07:36:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2B7F33
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 04:28:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXi-0003Sr-I3; Mon, 28 Mar 2022 13:28:14 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXe-003Zlg-Sw; Mon, 28 Mar 2022 13:28:13 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXd-006bz9-O2; Mon, 28 Mar 2022 13:28:09 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 19/19] ASoC: fsl_micfil: fold fsl_set_clock_params() into its only user
Date:   Mon, 28 Mar 2022 13:27:44 +0200
Message-Id: <20220328112744.1575631-20-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220328112744.1575631-1-s.hauer@pengutronix.de>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
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

fsl_set_clock_params() is used only once and easily be folded into its
caller, do so.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_micfil.c | 41 ++++++++++++--------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 99c256f46f38e..26b3395020973 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -253,29 +253,6 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int fsl_set_clock_params(struct device *dev, unsigned int rate)
-{
-	struct fsl_micfil *micfil = dev_get_drvdata(dev);
-	int clk_div = 8;
-	int osr = MICFIL_OSR_DEFAULT;
-	int ret;
-
-	ret = clk_set_rate(micfil->mclk, rate * clk_div * osr * 8);
-	if (ret)
-		return ret;
-
-	ret = micfil_set_quality(micfil);
-	if (ret)
-		return ret;
-
-	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
-				 MICFIL_CTRL2_CLKDIV | MICFIL_CTRL2_CICOSR,
-				 FIELD_PREP(MICFIL_CTRL2_CLKDIV, clk_div) |
-				 FIELD_PREP(MICFIL_CTRL2_CICOSR, 16 - osr));
-
-	return ret;
-}
-
 static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -283,7 +260,8 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
-	struct device *dev = &micfil->pdev->dev;
+	int clk_div = 8;
+	int osr = MICFIL_OSR_DEFAULT;
 	int ret;
 
 	/* 1. Disable the module */
@@ -298,11 +276,18 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	ret = fsl_set_clock_params(dev, rate);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set clock parameters [%d]\n", ret);
+	ret = clk_set_rate(micfil->mclk, rate * clk_div * osr * 8);
+	if (ret)
 		return ret;
-	}
+
+	ret = micfil_set_quality(micfil);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
+				 MICFIL_CTRL2_CLKDIV | MICFIL_CTRL2_CICOSR,
+				 FIELD_PREP(MICFIL_CTRL2_CLKDIV, clk_div) |
+				 FIELD_PREP(MICFIL_CTRL2_CICOSR, 16 - osr));
 
 	micfil->dma_params_rx.peripheral_config = &micfil->sdmacfg;
 	micfil->dma_params_rx.peripheral_size = sizeof(micfil->sdmacfg);
-- 
2.30.2

