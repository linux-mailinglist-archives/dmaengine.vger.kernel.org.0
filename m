Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3654DC120
	for <lists+dmaengine@lfdr.de>; Thu, 17 Mar 2022 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiCQIaD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Mar 2022 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiCQIaA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Mar 2022 04:30:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B8DA6F4
        for <dmaengine@vger.kernel.org>; Thu, 17 Mar 2022 01:28:43 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nUlUt-000693-4g; Thu, 17 Mar 2022 09:28:39 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nUlUm-0027UC-Vw; Thu, 17 Mar 2022 09:28:32 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 13/19] ASoC: fsl_micfil: Drop get_pdm_clk()
Date:   Thu, 17 Mar 2022 09:28:12 +0100
Message-Id: <20220317082818.503143-14-s.hauer@pengutronix.de>
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

get_pdm_clk() calculates the PDM clock based on the quality setting,
but really the PDM clock is independent of the quality, it's always
rate * 4 * micfil->osr. Just drop the function and do the calculation
in the caller.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_micfil.c | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 48054b9bd4bb2..8dadb824a94ff 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -110,42 +110,6 @@ static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
 		     snd_soc_get_enum_double, snd_soc_put_enum_double),
 };
 
-static inline int get_pdm_clk(struct fsl_micfil *micfil,
-			      unsigned int rate)
-{
-	u32 ctrl2_reg;
-	int qsel;
-	int bclk;
-	int osr = MICFIL_OSR_DEFAULT;
-
-	regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
-	qsel = FIELD_GET(MICFIL_CTRL2_QSEL, ctrl2_reg);
-
-	switch (qsel) {
-	case MICFIL_QSEL_HIGH_QUALITY:
-		bclk = rate * 8 * osr / 2; /* kfactor = 0.5 */
-		break;
-	case MICFIL_QSEL_MEDIUM_QUALITY:
-	case MICFIL_QSEL_VLOW0_QUALITY:
-		bclk = rate * 4 * osr * 1; /* kfactor = 1 */
-		break;
-	case MICFIL_QSEL_LOW_QUALITY:
-	case MICFIL_QSEL_VLOW1_QUALITY:
-		bclk = rate * 2 * osr * 2; /* kfactor = 2 */
-		break;
-	case MICFIL_QSEL_VLOW2_QUALITY:
-		bclk = rate * osr * 4; /* kfactor = 4 */
-		break;
-	default:
-		dev_err(&micfil->pdev->dev,
-			"Please make sure you select a valid quality.\n");
-		bclk = -1;
-		break;
-	}
-
-	return bclk;
-}
-
 static inline int get_clk_div(struct fsl_micfil *micfil,
 			      unsigned int rate)
 {
@@ -154,7 +118,7 @@ static inline int get_clk_div(struct fsl_micfil *micfil,
 
 	mclk_rate = clk_get_rate(micfil->mclk);
 
-	clk_div = mclk_rate / (get_pdm_clk(micfil, rate) * 2);
+	clk_div = mclk_rate / (rate * micfil->osr * 8);
 
 	return clk_div;
 }
-- 
2.30.2

