Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4C4E9562
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 13:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiC1Lli (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbiC1Lgg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 07:36:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AFA6169
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 04:28:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXi-0003Rz-31; Mon, 28 Mar 2022 13:28:14 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXe-003ZlR-EZ; Mon, 28 Mar 2022 13:28:13 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXd-006byQ-E8; Mon, 28 Mar 2022 13:28:09 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 04/19] ASoC: fsl_micfil: do not define SHIFT/MASK for single bits
Date:   Mon, 28 Mar 2022 13:27:29 +0200
Message-Id: <20220328112744.1575631-5-s.hauer@pengutronix.de>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No need to have defines for the mask of single bits. Also shift is
unused. Drop all these unnecessary defines.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_micfil.c |  18 +++---
 sound/soc/fsl/fsl_micfil.h | 125 +++++++++----------------------------
 2 files changed, 40 insertions(+), 103 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 5353474d0ff2b..878d24fde3581 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -170,7 +170,7 @@ static int fsl_micfil_reset(struct device *dev)
 
 	ret = regmap_update_bits(micfil->regmap,
 				 REG_MICFIL_CTRL1,
-				 MICFIL_CTRL1_MDIS_MASK,
+				 MICFIL_CTRL1_MDIS,
 				 0);
 	if (ret) {
 		dev_err(dev, "failed to clear MDIS bit %d\n", ret);
@@ -179,7 +179,7 @@ static int fsl_micfil_reset(struct device *dev)
 
 	ret = regmap_update_bits(micfil->regmap,
 				 REG_MICFIL_CTRL1,
-				 MICFIL_CTRL1_SRES_MASK,
+				 MICFIL_CTRL1_SRES,
 				 MICFIL_CTRL1_SRES);
 	if (ret) {
 		dev_err(dev, "failed to reset MICFIL: %d\n", ret);
@@ -253,7 +253,7 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		/* Enable the module */
 		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
-					 MICFIL_CTRL1_PDMIEN_MASK,
+					 MICFIL_CTRL1_PDMIEN,
 					 MICFIL_CTRL1_PDMIEN);
 		if (ret) {
 			dev_err(dev, "failed to enable the module\n");
@@ -266,7 +266,7 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		/* Disable the module */
 		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
-					 MICFIL_CTRL1_PDMIEN_MASK,
+					 MICFIL_CTRL1_PDMIEN,
 					 0);
 		if (ret) {
 			dev_err(dev, "failed to enable the module\n");
@@ -332,7 +332,7 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 
 	/* 1. Disable the module */
 	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
-				 MICFIL_CTRL1_PDMIEN_MASK, 0);
+				 MICFIL_CTRL1_PDMIEN, 0);
 	if (ret) {
 		dev_err(dev, "failed to disable the module\n");
 		return ret;
@@ -593,16 +593,16 @@ static irqreturn_t micfil_err_isr(int irq, void *devid)
 
 	regmap_read(micfil->regmap, REG_MICFIL_STAT, &stat_reg);
 
-	if (stat_reg & MICFIL_STAT_BSY_FIL_MASK)
+	if (stat_reg & MICFIL_STAT_BSY_FIL)
 		dev_dbg(&pdev->dev, "isr: Decimation Filter is running\n");
 
-	if (stat_reg & MICFIL_STAT_FIR_RDY_MASK)
+	if (stat_reg & MICFIL_STAT_FIR_RDY)
 		dev_dbg(&pdev->dev, "isr: FIR Filter Data ready\n");
 
-	if (stat_reg & MICFIL_STAT_LOWFREQF_MASK) {
+	if (stat_reg & MICFIL_STAT_LOWFREQF) {
 		dev_dbg(&pdev->dev, "isr: ipg_clk_app is too low\n");
 		regmap_write_bits(micfil->regmap, REG_MICFIL_STAT,
-				  MICFIL_STAT_LOWFREQF_MASK, 1);
+				  MICFIL_STAT_LOWFREQF, 1);
 	}
 
 	return IRQ_HANDLED;
diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
index bac825c3135a0..11ccc08523b2e 100644
--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -33,33 +33,17 @@
 #define REG_MICFIL_VAD0_ZCD		0xA8
 
 /* MICFIL Control Register 1 -- REG_MICFILL_CTRL1 0x00 */
-#define MICFIL_CTRL1_MDIS_SHIFT		31
-#define MICFIL_CTRL1_MDIS_MASK		BIT(MICFIL_CTRL1_MDIS_SHIFT)
-#define MICFIL_CTRL1_MDIS		BIT(MICFIL_CTRL1_MDIS_SHIFT)
-#define MICFIL_CTRL1_DOZEN_SHIFT	30
-#define MICFIL_CTRL1_DOZEN_MASK		BIT(MICFIL_CTRL1_DOZEN_SHIFT)
-#define MICFIL_CTRL1_DOZEN		BIT(MICFIL_CTRL1_DOZEN_SHIFT)
-#define MICFIL_CTRL1_PDMIEN_SHIFT	29
-#define MICFIL_CTRL1_PDMIEN_MASK	BIT(MICFIL_CTRL1_PDMIEN_SHIFT)
-#define MICFIL_CTRL1_PDMIEN		BIT(MICFIL_CTRL1_PDMIEN_SHIFT)
-#define MICFIL_CTRL1_DBG_SHIFT		28
-#define MICFIL_CTRL1_DBG_MASK		BIT(MICFIL_CTRL1_DBG_SHIFT)
-#define MICFIL_CTRL1_DBG		BIT(MICFIL_CTRL1_DBG_SHIFT)
-#define MICFIL_CTRL1_SRES_SHIFT		27
-#define MICFIL_CTRL1_SRES_MASK		BIT(MICFIL_CTRL1_SRES_SHIFT)
-#define MICFIL_CTRL1_SRES		BIT(MICFIL_CTRL1_SRES_SHIFT)
-#define MICFIL_CTRL1_DBGE_SHIFT		26
-#define MICFIL_CTRL1_DBGE_MASK		BIT(MICFIL_CTRL1_DBGE_SHIFT)
-#define MICFIL_CTRL1_DBGE		BIT(MICFIL_CTRL1_DBGE_SHIFT)
+#define MICFIL_CTRL1_MDIS		BIT(31)
+#define MICFIL_CTRL1_DOZEN		BIT(30)
+#define MICFIL_CTRL1_PDMIEN		BIT(29)
+#define MICFIL_CTRL1_DBG		BIT(28)
+#define MICFIL_CTRL1_SRES		BIT(27)
+#define MICFIL_CTRL1_DBGE		BIT(26)
 #define MICFIL_CTRL1_DISEL_SHIFT	24
 #define MICFIL_CTRL1_DISEL_WIDTH	2
 #define MICFIL_CTRL1_DISEL_MASK		((BIT(MICFIL_CTRL1_DISEL_WIDTH) - 1) \
 					 << MICFIL_CTRL1_DISEL_SHIFT)
-#define MICFIL_CTRL1_DISEL(v)		(((v) << MICFIL_CTRL1_DISEL_SHIFT) \
-					 & MICFIL_CTRL1_DISEL_MASK)
-#define MICFIL_CTRL1_ERREN_SHIFT	23
-#define MICFIL_CTRL1_ERREN_MASK		BIT(MICFIL_CTRL1_ERREN_SHIFT)
-#define MICFIL_CTRL1_ERREN		BIT(MICFIL_CTRL1_ERREN_SHIFT)
+#define MICFIL_CTRL1_ERREN		BIT(23)
 #define MICFIL_CTRL1_CHEN_SHIFT		0
 #define MICFIL_CTRL1_CHEN_WIDTH		8
 #define MICFIL_CTRL1_CHEN_MASK(x)	(BIT(x) << MICFIL_CTRL1_CHEN_SHIFT)
@@ -91,15 +75,9 @@
 					 & MICFIL_CTRL2_CLKDIV_MASK)
 
 /* MICFIL Status Register -- REG_MICFIL_STAT 0x08 */
-#define MICFIL_STAT_BSY_FIL_SHIFT	31
-#define MICFIL_STAT_BSY_FIL_MASK	BIT(MICFIL_STAT_BSY_FIL_SHIFT)
-#define MICFIL_STAT_BSY_FIL		BIT(MICFIL_STAT_BSY_FIL_SHIFT)
-#define MICFIL_STAT_FIR_RDY_SHIFT	30
-#define MICFIL_STAT_FIR_RDY_MASK	BIT(MICFIL_STAT_FIR_RDY_SHIFT)
-#define MICFIL_STAT_FIR_RDY		BIT(MICFIL_STAT_FIR_RDY_SHIFT)
-#define MICFIL_STAT_LOWFREQF_SHIFT	29
-#define MICFIL_STAT_LOWFREQF_MASK	BIT(MICFIL_STAT_LOWFREQF_SHIFT)
-#define MICFIL_STAT_LOWFREQF		BIT(MICFIL_STAT_LOWFREQF_SHIFT)
+#define MICFIL_STAT_BSY_FIL		BIT(31)
+#define MICFIL_STAT_FIR_RDY		BIT(30)
+#define MICFIL_STAT_LOWFREQF		BIT(29)
 #define MICFIL_STAT_CHXF_SHIFT(v)	(v)
 #define MICFIL_STAT_CHXF_MASK(v)	BIT(MICFIL_STAT_CHXF_SHIFT(v))
 #define MICFIL_STAT_CHXF(v)		BIT(MICFIL_STAT_CHXF_SHIFT(v))
@@ -137,32 +115,16 @@
 					 << MICFIL_VAD0_CTRL1_INITT_SHIFT)
 #define MICFIL_VAD0_CTRL1_INITT(v)	(((v) << MICFIL_VAD0_CTRL1_INITT_SHIFT) \
 					 & MICFIL_VAD0_CTRL1_INITT_MASK)
-#define MICFIL_VAD0_CTRL1_ST10_SHIFT	4
-#define MICFIL_VAD0_CTRL1_ST10_MASK	BIT(MICFIL_VAD0_CTRL1_ST10_SHIFT)
-#define MICFIL_VAD0_CTRL1_ST10		BIT(MICFIL_VAD0_CTRL1_ST10_SHIFT)
-#define MICFIL_VAD0_CTRL1_ERIE_SHIFT	3
-#define MICFIL_VAD0_CTRL1_ERIE_MASK	BIT(MICFIL_VAD0_CTRL1_ERIE_SHIFT)
-#define MICFIL_VAD0_CTRL1_ERIE		BIT(MICFIL_VAD0_CTRL1_ERIE_SHIFT)
-#define MICFIL_VAD0_CTRL1_IE_SHIFT	2
-#define MICFIL_VAD0_CTRL1_IE_MASK	BIT(MICFIL_VAD0_CTRL1_IE_SHIFT)
-#define MICFIL_VAD0_CTRL1_IE		BIT(MICFIL_VAD0_CTRL1_IE_SHIFT)
-#define MICFIL_VAD0_CTRL1_RST_SHIFT	1
-#define MICFIL_VAD0_CTRL1_RST_MASK	BIT(MICFIL_VAD0_CTRL1_RST_SHIFT)
-#define MICFIL_VAD0_CTRL1_RST		BIT(MICFIL_VAD0_CTRL1_RST_SHIFT)
-#define MICFIL_VAD0_CTRL1_EN_SHIFT	0
-#define MICFIL_VAD0_CTRL1_EN_MASK	BIT(MICFIL_VAD0_CTRL1_EN_SHIFT)
-#define MICFIL_VAD0_CTRL1_EN		BIT(MICFIL_VAD0_CTRL1_EN_SHIFT)
+#define MICFIL_VAD0_CTRL1_ST10		BIT(4)
+#define MICFIL_VAD0_CTRL1_ERIE		BIT(3)
+#define MICFIL_VAD0_CTRL1_IE		BIT(2)
+#define MICFIL_VAD0_CTRL1_RST		BIT(1)
+#define MICFIL_VAD0_CTRL1_EN		BIT(0)
 
 /* MICFIL HWVAD0 Control 2 Register -- REG_MICFIL_VAD0_CTRL2*/
-#define MICFIL_VAD0_CTRL2_FRENDIS_SHIFT	31
-#define MICFIL_VAD0_CTRL2_FRENDIS_MASK	BIT(MICFIL_VAD0_CTRL2_FRENDIS_SHIFT)
-#define MICFIL_VAD0_CTRL2_FRENDIS	BIT(MICFIL_VAD0_CTRL2_FRENDIS_SHIFT)
-#define MICFIL_VAD0_CTRL2_PREFEN_SHIFT	30
-#define MICFIL_VAD0_CTRL2_PREFEN_MASK	BIT(MICFIL_VAD0_CTRL2_PREFEN_SHIFT)
-#define MICFIL_VAD0_CTRL2_PREFEN	BIT(MICFIL_VAD0_CTRL2_PREFEN_SHIFT)
-#define MICFIL_VAD0_CTRL2_FOUTDIS_SHIFT	28
-#define MICFIL_VAD0_CTRL2_FOUTDIS_MASK	BIT(MICFIL_VAD0_CTRL2_FOUTDIS_SHIFT)
-#define MICFIL_VAD0_CTRL2_FOUTDIS	BIT(MICFIL_VAD0_CTRL2_FOUTDIS_SHIFT)
+#define MICFIL_VAD0_CTRL2_FRENDIS	BIT(31)
+#define MICFIL_VAD0_CTRL2_PREFEN	BIT(30)
+#define MICFIL_VAD0_CTRL2_FOUTDIS	BIT(28)
 #define MICFIL_VAD0_CTRL2_FRAMET_SHIFT	16
 #define MICFIL_VAD0_CTRL2_FRAMET_WIDTH	6
 #define MICFIL_VAD0_CTRL2_FRAMET_MASK	((BIT(MICFIL_VAD0_CTRL2_FRAMET_WIDTH) - 1) \
@@ -183,12 +145,8 @@
 					 & MICFIL_VAD0_CTRL2_HPF_MASK)
 
 /* MICFIL HWVAD0 Signal CONFIG Register -- REG_MICFIL_VAD0_SCONFIG */
-#define MICFIL_VAD0_SCONFIG_SFILEN_SHIFT	31
-#define MICFIL_VAD0_SCONFIG_SFILEN_MASK		BIT(MICFIL_VAD0_SCONFIG_SFILEN_SHIFT)
-#define MICFIL_VAD0_SCONFIG_SFILEN		BIT(MICFIL_VAD0_SCONFIG_SFILEN_SHIFT)
-#define MICFIL_VAD0_SCONFIG_SMAXEN_SHIFT	30
-#define MICFIL_VAD0_SCONFIG_SMAXEN_MASK		BIT(MICFIL_VAD0_SCONFIG_SMAXEN_SHIFT)
-#define MICFIL_VAD0_SCONFIG_SMAXEN		BIT(MICFIL_VAD0_SCONFIG_SMAXEN_SHIFT)
+#define MICFIL_VAD0_SCONFIG_SFILEN		BIT(31)
+#define MICFIL_VAD0_SCONFIG_SMAXEN		BIT(30)
 #define MICFIL_VAD0_SCONFIG_SGAIN_SHIFT		0
 #define MICFIL_VAD0_SCONFIG_SGAIN_WIDTH		4
 #define MICFIL_VAD0_SCONFIG_SGAIN_MASK		((BIT(MICFIL_VAD0_SCONFIG_SGAIN_WIDTH) - 1) \
@@ -197,17 +155,10 @@
 						 & MICFIL_VAD0_SCONFIG_SGAIN_MASK)
 
 /* MICFIL HWVAD0 Noise CONFIG Register -- REG_MICFIL_VAD0_NCONFIG */
-#define MICFIL_VAD0_NCONFIG_NFILAUT_SHIFT	31
-#define MICFIL_VAD0_NCONFIG_NFILAUT_MASK	BIT(MICFIL_VAD0_NCONFIG_NFILAUT_SHIFT)
-#define MICFIL_VAD0_NCONFIG_NFILAUT		BIT(MICFIL_VAD0_NCONFIG_NFILAUT_SHIFT)
-#define MICFIL_VAD0_NCONFIG_NMINEN_SHIFT	30
-#define MICFIL_VAD0_NCONFIG_NMINEN_MASK		BIT(MICFIL_VAD0_NCONFIG_NMINEN_SHIFT)
-#define MICFIL_VAD0_NCONFIG_NMINEN		BIT(MICFIL_VAD0_NCONFIG_NMINEN_SHIFT)
-#define MICFIL_VAD0_NCONFIG_NDECEN_SHIFT	29
-#define MICFIL_VAD0_NCONFIG_NDECEN_MASK		BIT(MICFIL_VAD0_NCONFIG_NDECEN_SHIFT)
-#define MICFIL_VAD0_NCONFIG_NDECEN		BIT(MICFIL_VAD0_NCONFIG_NDECEN_SHIFT)
-#define MICFIL_VAD0_NCONFIG_NOREN_SHIFT		28
-#define MICFIL_VAD0_NCONFIG_NOREN		BIT(MICFIL_VAD0_NCONFIG_NOREN_SHIFT)
+#define MICFIL_VAD0_NCONFIG_NFILAUT		BIT(31)
+#define MICFIL_VAD0_NCONFIG_NMINEN		BIT(30)
+#define MICFIL_VAD0_NCONFIG_NDECEN		BIT(29)
+#define MICFIL_VAD0_NCONFIG_NOREN		BIT(28)
 #define MICFIL_VAD0_NCONFIG_NFILADJ_SHIFT	8
 #define MICFIL_VAD0_NCONFIG_NFILADJ_WIDTH	5
 #define MICFIL_VAD0_NCONFIG_NFILADJ_MASK	((BIT(MICFIL_VAD0_NCONFIG_NFILADJ_WIDTH) - 1) \
@@ -234,29 +185,15 @@
 					 << MICFIL_VAD0_ZCD_ZCDADJ_SHIFT)
 #define MICFIL_VAD0_ZCD_ZCDADJ(v)	(((v) << MICFIL_VAD0_ZCD_ZCDADJ_SHIFT)\
 					 & MICFIL_VAD0_ZCD_ZCDADJ_MASK)
-#define MICFIL_VAD0_ZCD_ZCDAND_SHIFT	4
-#define MICFIL_VAD0_ZCD_ZCDAND_MASK	BIT(MICFIL_VAD0_ZCD_ZCDAND_SHIFT)
-#define MICFIL_VAD0_ZCD_ZCDAND		BIT(MICFIL_VAD0_ZCD_ZCDAND_SHIFT)
-#define MICFIL_VAD0_ZCD_ZCDAUT_SHIFT	2
-#define MICFIL_VAD0_ZCD_ZCDAUT_MASK	BIT(MICFIL_VAD0_ZCD_ZCDAUT_SHIFT)
-#define MICFIL_VAD0_ZCD_ZCDAUT		BIT(MICFIL_VAD0_ZCD_ZCDAUT_SHIFT)
-#define MICFIL_VAD0_ZCD_ZCDEN_SHIFT	0
-#define MICFIL_VAD0_ZCD_ZCDEN_MASK	BIT(MICFIL_VAD0_ZCD_ZCDEN_SHIFT)
-#define MICFIL_VAD0_ZCD_ZCDEN		BIT(MICFIL_VAD0_ZCD_ZCDEN_SHIFT)
+#define MICFIL_VAD0_ZCD_ZCDAND		BIT(4)
+#define MICFIL_VAD0_ZCD_ZCDAUT		BIT(2)
+#define MICFIL_VAD0_ZCD_ZCDEN		BIT(0)
 
 /* MICFIL HWVAD0 Status Register - REG_MICFIL_VAD0_STAT */
-#define MICFIL_VAD0_STAT_INITF_SHIFT	31
-#define MICFIL_VAD0_STAT_INITF_MASK	BIT(MICFIL_VAD0_STAT_INITF_SHIFT)
-#define MICFIL_VAD0_STAT_INITF		BIT(MICFIL_VAD0_STAT_INITF_SHIFT)
-#define MICFIL_VAD0_STAT_INSATF_SHIFT	16
-#define MICFIL_VAD0_STAT_INSATF_MASK	BIT(MICFIL_VAD0_STAT_INSATF_SHIFT)
-#define MICFIL_VAD0_STAT_INSATF		BIT(MICFIL_VAD0_STAT_INSATF_SHIFT)
-#define MICFIL_VAD0_STAT_EF_SHIFT	15
-#define MICFIL_VAD0_STAT_EF_MASK	BIT(MICFIL_VAD0_STAT_EF_SHIFT)
-#define MICFIL_VAD0_STAT_EF		BIT(MICFIL_VAD0_STAT_EF_SHIFT)
-#define MICFIL_VAD0_STAT_IF_SHIFT	0
-#define MICFIL_VAD0_STAT_IF_MASK	BIT(MICFIL_VAD0_STAT_IF_SHIFT)
-#define MICFIL_VAD0_STAT_IF		BIT(MICFIL_VAD0_STAT_IF_SHIFT)
+#define MICFIL_VAD0_STAT_INITF		BIT(31)
+#define MICFIL_VAD0_STAT_INSATF		BIT(16)
+#define MICFIL_VAD0_STAT_EF		BIT(15)
+#define MICFIL_VAD0_STAT_IF		BIT(0)
 
 /* MICFIL Output Control Register */
 #define MICFIL_OUTGAIN_CHX_SHIFT(v)	(4 * (v))
-- 
2.30.2

