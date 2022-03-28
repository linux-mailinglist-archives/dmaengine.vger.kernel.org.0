Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92B94E9547
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 13:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbiC1LlN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243500AbiC1Lgf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 07:36:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1261087
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 04:28:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXj-0003Tq-Bv; Mon, 28 Mar 2022 13:28:15 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXf-003Zm5-IL; Mon, 28 Mar 2022 13:28:14 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nYnXd-006byW-G0; Mon, 28 Mar 2022 13:28:09 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 06/19] ASoC: fsl_micfil: use clear/set bits
Date:   Mon, 28 Mar 2022 13:27:31 +0200
Message-Id: <20220328112744.1575631-7-s.hauer@pengutronix.de>
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

Instead regmap_update_bits() use the simpler variants
regmap_[set|clear]_bits() where appropriate.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_micfil.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index cfa8af668d921..70185f75d8a04 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -168,19 +168,15 @@ static int fsl_micfil_reset(struct device *dev)
 	struct fsl_micfil *micfil = dev_get_drvdata(dev);
 	int ret;
 
-	ret = regmap_update_bits(micfil->regmap,
-				 REG_MICFIL_CTRL1,
-				 MICFIL_CTRL1_MDIS,
-				 0);
+	ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
+				MICFIL_CTRL1_MDIS);
 	if (ret) {
 		dev_err(dev, "failed to clear MDIS bit %d\n", ret);
 		return ret;
 	}
 
-	ret = regmap_update_bits(micfil->regmap,
-				 REG_MICFIL_CTRL1,
-				 MICFIL_CTRL1_SRES,
-				 MICFIL_CTRL1_SRES);
+	ret = regmap_set_bits(micfil->regmap, REG_MICFIL_CTRL1,
+			      MICFIL_CTRL1_SRES);
 	if (ret) {
 		dev_err(dev, "failed to reset MICFIL: %d\n", ret);
 		return ret;
@@ -252,9 +248,8 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 		}
 
 		/* Enable the module */
-		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
-					 MICFIL_CTRL1_PDMIEN,
-					 MICFIL_CTRL1_PDMIEN);
+		ret = regmap_set_bits(micfil->regmap, REG_MICFIL_CTRL1,
+				      MICFIL_CTRL1_PDMIEN);
 		if (ret) {
 			dev_err(dev, "failed to enable the module\n");
 			return ret;
@@ -265,9 +260,8 @@ static int fsl_micfil_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		/* Disable the module */
-		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
-					 MICFIL_CTRL1_PDMIEN,
-					 0);
+		ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
+					MICFIL_CTRL1_PDMIEN);
 		if (ret) {
 			dev_err(dev, "failed to enable the module\n");
 			return ret;
@@ -332,8 +326,8 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	/* 1. Disable the module */
-	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL1,
-				 MICFIL_CTRL1_PDMIEN, 0);
+	ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
+				 MICFIL_CTRL1_PDMIEN);
 	if (ret) {
 		dev_err(dev, "failed to disable the module\n");
 		return ret;
-- 
2.30.2

