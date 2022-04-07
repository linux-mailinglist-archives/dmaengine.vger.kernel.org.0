Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A534F7A4A
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiDGIvx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiDGIvv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 04:51:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C315E70868
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 01:49:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ncNpq-0003eS-SK; Thu, 07 Apr 2022 10:49:46 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1ncNpr-001ZrE-97; Thu, 07 Apr 2022 10:49:45 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1ncNpm-000w4I-MJ; Thu, 07 Apr 2022 10:49:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 07/21] ASoC: fsl_micfil: drop error messages from failed register accesses
Date:   Thu,  7 Apr 2022 10:49:22 +0200
Message-Id: <20220407084936.223075-8-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407084936.223075-1-s.hauer@pengutronix.de>
References: <20220407084936.223075-1-s.hauer@pengutronix.de>
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

Failed register accesses are really not expected in memory mapped
registers. When it fails then the register access itself is likely not
the reason, so no need to have extra error messages for each regmap
access. Just drop the error messages. This also fixes some places where
a return value is concatenated using 'ret |=' and then returned as
error value.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
---
 sound/soc/fsl/fsl_micfil.c | 53 ++++++++++----------------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index da4c245c35e62..619e013cf272d 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -170,17 +170,13 @@ static int fsl_micfil_reset(struct device *dev)
 
 	ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
 				MICFIL_CTRL1_MDIS);
-	if (ret) {
-		dev_err(dev, "failed to clear MDIS bit %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = regmap_set_bits(micfil->regmap, REG_MICFIL_CTRL1,
 			      MICFIL_CTRL1_SRES);
-	if (ret) {
-		dev_err(dev, "failed to reset MICFIL: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
@@ -242,18 +238,14 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
 				MICFIL_CTRL1_DISEL,
 				FIELD_PREP(MICFIL_CTRL1_DISEL, MICFIL_CTRL1_DISEL_DMA));
-		if (ret) {
-			dev_err(dev, "failed to update DISEL bits\n");
+		if (ret)
 			return ret;
-		}
 
 		/* Enable the module */
 		ret = regmap_set_bits(micfil->regmap, REG_MICFIL_CTRL1,
 				      MICFIL_CTRL1_PDMIEN);
-		if (ret) {
-			dev_err(dev, "failed to enable the module\n");
+		if (ret)
 			return ret;
-		}
 
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -262,18 +254,14 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 		/* Disable the module */
 		ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
 					MICFIL_CTRL1_PDMIEN);
-		if (ret) {
-			dev_err(dev, "failed to enable the module\n");
+		if (ret)
 			return ret;
-		}
 
 		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
 				MICFIL_CTRL1_DISEL,
 				FIELD_PREP(MICFIL_CTRL1_DISEL, MICFIL_CTRL1_DISEL_DISABLE));
-		if (ret) {
-			dev_err(dev, "failed to update DISEL bits\n");
+		if (ret)
 			return ret;
-		}
 		break;
 	default:
 		return -EINVAL;
@@ -293,24 +281,20 @@ static int fsl_set_clock_params(struct device *dev, unsigned int rate)
 			clk_get_rate(micfil->mclk), rate);
 
 	/* set CICOSR */
-	ret |= regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
+	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
 				 MICFIL_CTRL2_CICOSR,
 				 FIELD_PREP(MICFIL_CTRL2_CICOSR, MICFIL_CTRL2_CICOSR_DEFAULT));
 	if (ret)
-		dev_err(dev, "failed to set CICOSR in reg 0x%X\n",
-			REG_MICFIL_CTRL2);
+		return ret;
 
 	/* set CLK_DIV */
 	clk_div = get_clk_div(micfil, rate);
 	if (clk_div < 0)
 		ret = -EINVAL;
 
-	ret |= regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
+	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
 				 MICFIL_CTRL2_CLKDIV,
 				 FIELD_PREP(MICFIL_CTRL2_CLKDIV, clk_div));
-	if (ret)
-		dev_err(dev, "failed to set CLKDIV in reg 0x%X\n",
-			REG_MICFIL_CTRL2);
 
 	return ret;
 }
@@ -328,19 +312,14 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	/* 1. Disable the module */
 	ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
 				MICFIL_CTRL1_PDMIEN);
-	if (ret) {
-		dev_err(dev, "failed to disable the module\n");
+	if (ret)
 		return ret;
-	}
 
 	/* enable channels */
 	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
 				 0xFF, ((1 << channels) - 1));
-	if (ret) {
-		dev_err(dev, "failed to enable channels %d, reg 0x%X\n", ret,
-			REG_MICFIL_CTRL1);
+	if (ret)
 		return ret;
-	}
 
 	ret = fsl_set_clock_params(dev, rate);
 	if (ret < 0) {
@@ -362,7 +341,6 @@ static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
 static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(cpu_dai->dev);
-	struct device *dev = cpu_dai->dev;
 	int ret;
 	int i;
 
@@ -370,11 +348,8 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
 			MICFIL_CTRL2_QSEL,
 			FIELD_PREP(MICFIL_CTRL2_QSEL, MICFIL_QSEL_MEDIUM_QUALITY));
-	if (ret) {
-		dev_err(dev, "failed to set quality mode bits, reg 0x%X\n",
-			REG_MICFIL_CTRL2);
+	if (ret)
 		return ret;
-	}
 
 	/* set default gain to max_gain */
 	regmap_write(micfil->regmap, REG_MICFIL_OUT_CTRL, 0x77777777);
@@ -388,10 +363,8 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_FIFO_CTRL,
 			MICFIL_FIFO_CTRL_FIFOWMK,
 			FIELD_PREP(MICFIL_FIFO_CTRL_FIFOWMK, micfil->soc->fifo_depth - 1));
-	if (ret) {
-		dev_err(dev, "failed to set FIFOWMK\n");
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
-- 
2.30.2

