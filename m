Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B11A4F7A57
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbiDGIwE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiDGIvz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 04:51:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE446D861
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 01:49:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ncNpq-0003cx-1d; Thu, 07 Apr 2022 10:49:46 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1ncNpq-001Zqt-Hk; Thu, 07 Apr 2022 10:49:45 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1ncNpm-000w4j-SC; Thu, 07 Apr 2022 10:49:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 16/21] ASoC: fsl_micfil: rework quality setting
Date:   Thu,  7 Apr 2022 10:49:31 +0200
Message-Id: <20220407084936.223075-17-s.hauer@pengutronix.de>
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

For the quality setting the quality setting register values are directly
exposed to the kcontrol and thus to userspace. This is unfortunate
because the register settings contains invalid bit combinations marked
as "N/A". For userspace it doesn't make much sense to be able to set
these just to see that the driver responds with "Please make sure you
select a valid quality." in the kernel log.

Work around this by adding get/set functions for the quality setting.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Notes:
    Changes since v3:
    - Leave default quality setting at 'medium'

 sound/soc/fsl/fsl_micfil.c | 109 ++++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 31 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 4d8dfb2c22290..e71f799fc4c67 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -31,6 +31,15 @@
 
 #define MICFIL_OSR_DEFAULT	16
 
+enum quality {
+	QUALITY_HIGH,
+	QUALITY_MEDIUM,
+	QUALITY_LOW,
+	QUALITY_VLOW0,
+	QUALITY_VLOW1,
+	QUALITY_VLOW2,
+};
+
 struct fsl_micfil {
 	struct platform_device *pdev;
 	struct regmap *regmap;
@@ -42,7 +51,7 @@ struct fsl_micfil {
 	unsigned int dataline;
 	char name[32];
 	int irq[MICFIL_IRQ_LINES];
-	int quality;	/*QUALITY 2-0 bits */
+	enum quality quality;
 };
 
 struct fsl_micfil_soc_data {
@@ -65,29 +74,73 @@ static const struct of_device_id fsl_micfil_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_micfil_dt_ids);
 
-/* Table 5. Quality Modes
- * Medium	0 0 0
- * High		0 0 1
- * Very Low 2	1 0 0
- * Very Low 1	1 0 1
- * Very Low 0	1 1 0
- * Low		1 1 1
- */
 static const char * const micfil_quality_select_texts[] = {
-	"Medium", "High",
-	"N/A", "N/A",
-	"VLow2", "VLow1",
-	"VLow0", "Low",
+	[QUALITY_HIGH] = "High",
+	[QUALITY_MEDIUM] = "Medium",
+	[QUALITY_LOW] = "Low",
+	[QUALITY_VLOW0] = "VLow0",
+	[QUALITY_VLOW1] = "Vlow1",
+	[QUALITY_VLOW2] = "Vlow2",
 };
 
 static const struct soc_enum fsl_micfil_quality_enum =
-	SOC_ENUM_SINGLE(REG_MICFIL_CTRL2,
-			MICFIL_CTRL2_QSEL_SHIFT,
-			ARRAY_SIZE(micfil_quality_select_texts),
-			micfil_quality_select_texts);
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(micfil_quality_select_texts),
+			    micfil_quality_select_texts);
 
 static DECLARE_TLV_DB_SCALE(gain_tlv, 0, 100, 0);
 
+static int micfil_set_quality(struct fsl_micfil *micfil)
+{
+	u32 qsel;
+
+	switch (micfil->quality) {
+	case QUALITY_HIGH:
+		qsel = MICFIL_QSEL_HIGH_QUALITY;
+		break;
+	case QUALITY_MEDIUM:
+		qsel = MICFIL_QSEL_MEDIUM_QUALITY;
+		break;
+	case QUALITY_LOW:
+		qsel = MICFIL_QSEL_LOW_QUALITY;
+		break;
+	case QUALITY_VLOW0:
+		qsel = MICFIL_QSEL_VLOW0_QUALITY;
+		break;
+	case QUALITY_VLOW1:
+		qsel = MICFIL_QSEL_VLOW1_QUALITY;
+		break;
+	case QUALITY_VLOW2:
+		qsel = MICFIL_QSEL_VLOW2_QUALITY;
+		break;
+	}
+
+	return regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
+				  MICFIL_CTRL2_QSEL,
+				  FIELD_PREP(MICFIL_CTRL2_QSEL, qsel));
+}
+
+static int micfil_quality_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(cmpnt);
+
+	ucontrol->value.integer.value[0] = micfil->quality;
+
+	return 0;
+}
+
+static int micfil_quality_set(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(cmpnt);
+
+	micfil->quality = ucontrol->value.integer.value[0];
+
+	return micfil_set_quality(micfil);
+}
+
 static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
 	SOC_SINGLE_SX_TLV("CH0 Volume", REG_MICFIL_OUT_CTRL,
 			  MICFIL_OUTGAIN_CHX_SHIFT(0), 0xF, 0x7, gain_tlv),
@@ -107,7 +160,7 @@ static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
 			  MICFIL_OUTGAIN_CHX_SHIFT(7), 0xF, 0x7, gain_tlv),
 	SOC_ENUM_EXT("MICFIL Quality Select",
 		     fsl_micfil_quality_enum,
-		     snd_soc_get_enum_double, snd_soc_put_enum_double),
+		     micfil_quality_get, micfil_quality_set),
 };
 
 /* The SRES is a self-negated bit which provides the CPU with the
@@ -207,22 +260,21 @@ static int fsl_set_clock_params(struct device *dev, unsigned int rate)
 {
 	struct fsl_micfil *micfil = dev_get_drvdata(dev);
 	int clk_div = 8;
+	int osr = MICFIL_OSR_DEFAULT;
 	int ret;
 
-	ret = clk_set_rate(micfil->mclk, rate * clk_div * MICFIL_OSR_DEFAULT * 8);
+	ret = clk_set_rate(micfil->mclk, rate * clk_div * osr * 8);
 	if (ret)
 		return ret;
 
-	/* set CICOSR */
-	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
-				 MICFIL_CTRL2_CICOSR,
-				 FIELD_PREP(MICFIL_CTRL2_CICOSR, 16 - MICFIL_OSR_DEFAULT));
+	ret = micfil_set_quality(micfil);
 	if (ret)
 		return ret;
 
 	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
-				 MICFIL_CTRL2_CLKDIV,
-				 FIELD_PREP(MICFIL_CTRL2_CLKDIV, clk_div));
+				 MICFIL_CTRL2_CLKDIV | MICFIL_CTRL2_CICOSR,
+				 FIELD_PREP(MICFIL_CTRL2_CLKDIV, clk_div) |
+				 FIELD_PREP(MICFIL_CTRL2_CICOSR, 16 - osr));
 
 	return ret;
 }
@@ -275,12 +327,7 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 	struct fsl_micfil *micfil = dev_get_drvdata(cpu_dai->dev);
 	int ret;
 
-	/* set qsel to medium */
-	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
-			MICFIL_CTRL2_QSEL,
-			FIELD_PREP(MICFIL_CTRL2_QSEL, MICFIL_QSEL_MEDIUM_QUALITY));
-	if (ret)
-		return ret;
+	micfil->quality = QUALITY_MEDIUM;
 
 	/* set default gain to max_gain */
 	regmap_write(micfil->regmap, REG_MICFIL_OUT_CTRL, 0x77777777);
-- 
2.30.2

