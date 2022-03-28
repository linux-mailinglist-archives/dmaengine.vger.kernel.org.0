Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FA4E9552
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbiC1LlW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 07:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbiC1Lgg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 07:36:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6012AF2
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 04:28:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXj-0003TZ-Dy; Mon, 28 Mar 2022 13:28:15 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXf-003Zls-BO; Mon, 28 Mar 2022 13:28:14 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXd-006byu-L9; Mon, 28 Mar 2022 13:28:09 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 14/19] ASoC: fsl_micfil: simplify clock setting
Date:   Mon, 28 Mar 2022 13:27:39 +0200
Message-Id: <20220328112744.1575631-15-s.hauer@pengutronix.de>
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

The reference manual has this for calculating the micfil internal clock
divider:

         MICFIL Clock rate
clkdiv = -----------------
         8 * OSR * outrate

(with OSR == Oversampling Rate, outrate == output sample rate)

The driver first sets the MICFIL Clock rate to (outrate * 1024) and then
calculates back the clkdiv value from the above calculation.

Simplify this by using a fixed clkdiv value of 8 and set the MICFIL
Clock rate to (outrate * clkdiv * OSR * 8).

While at it drop disabling the clock before setting its rate. The MICFIL
module is disabled when the rate is changed and it is also resetted
before it is started again, so I doubt it's necessary to disable the
clock.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_micfil.c | 45 ++++----------------------------------
 1 file changed, 4 insertions(+), 41 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 8335646a84d17..fd3b168a38661 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -111,19 +111,6 @@ static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
 		     snd_soc_get_enum_double, snd_soc_put_enum_double),
 };
 
-static inline int get_clk_div(struct fsl_micfil *micfil,
-			      unsigned int rate)
-{
-	long mclk_rate;
-	int clk_div;
-
-	mclk_rate = clk_get_rate(micfil->mclk);
-
-	clk_div = mclk_rate / (rate * micfil->osr * 8);
-
-	return clk_div;
-}
-
 /* The SRES is a self-negated bit which provides the CPU with the
  * capability to initialize the PDM Interface module through the
  * slave-bus interface. This bit always reads as zero, and this
@@ -147,24 +134,6 @@ static int fsl_micfil_reset(struct device *dev)
 	return 0;
 }
 
-static int fsl_micfil_set_mclk_rate(struct fsl_micfil *micfil,
-				    unsigned int freq)
-{
-	struct device *dev = &micfil->pdev->dev;
-	int ret;
-
-	clk_disable_unprepare(micfil->mclk);
-
-	ret = clk_set_rate(micfil->mclk, freq * 1024);
-	if (ret)
-		dev_warn(dev, "failed to set rate (%u): %d\n",
-			 freq * 1024, ret);
-
-	clk_prepare_enable(micfil->mclk);
-
-	return ret;
-}
-
 static int fsl_micfil_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -238,13 +207,12 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 static int fsl_set_clock_params(struct device *dev, unsigned int rate)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(dev);
-	int clk_div;
+	int clk_div = 8;
 	int ret;
 
-	ret = fsl_micfil_set_mclk_rate(micfil, rate);
-	if (ret < 0)
-		dev_err(dev, "failed to set mclk[%lu] to rate %u\n",
-			clk_get_rate(micfil->mclk), rate);
+	ret = clk_set_rate(micfil->mclk, rate * clk_div * micfil->osr * 8);
+	if (ret)
+		return ret;
 
 	/* set CICOSR */
 	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
@@ -253,11 +221,6 @@ static int fsl_set_clock_params(struct device *dev, unsigned int rate)
 	if (ret)
 		return ret;
 
-	/* set CLK_DIV */
-	clk_div = get_clk_div(micfil, rate);
-	if (clk_div < 0)
-		ret = -EINVAL;
-
 	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
 				 MICFIL_CTRL2_CLKDIV,
 				 FIELD_PREP(MICFIL_CTRL2_CLKDIV, clk_div));
-- 
2.30.2

