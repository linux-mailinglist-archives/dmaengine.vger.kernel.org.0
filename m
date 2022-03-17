Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA24DC11F
	for <lists+dmaengine@lfdr.de>; Thu, 17 Mar 2022 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiCQIaC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Mar 2022 04:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiCQIaA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Mar 2022 04:30:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE394E019
        for <dmaengine@vger.kernel.org>; Thu, 17 Mar 2022 01:28:43 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nUlUt-000692-5f; Thu, 17 Mar 2022 09:28:39 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nUlUm-0027U9-VT; Thu, 17 Mar 2022 09:28:32 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 12/19] ASoC: fsl_micfil: use define for OSR default value
Date:   Thu, 17 Mar 2022 09:28:11 +0100
Message-Id: <20220317082818.503143-13-s.hauer@pengutronix.de>
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

The OSR (OverSampling Rate) setting is set once to the default value
and never changed throughout the driver. Nevertheless the value is
read back from the register for further calculations. Just use the
default value because we know what we have written.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_micfil.c | 10 ++++++----
 sound/soc/fsl/fsl_micfil.h |  1 -
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 7795fc59d7d1a..48054b9bd4bb2 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -28,6 +28,8 @@
 #define FSL_MICFIL_RATES		SNDRV_PCM_RATE_8000_48000
 #define FSL_MICFIL_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE)
 
+#define MICFIL_OSR_DEFAULT	16
+
 struct fsl_micfil {
 	struct platform_device *pdev;
 	struct regmap *regmap;
@@ -40,6 +42,7 @@ struct fsl_micfil {
 	char name[32];
 	int irq[MICFIL_IRQ_LINES];
 	int quality;	/*QUALITY 2-0 bits */
+	unsigned int osr;
 };
 
 struct fsl_micfil_soc_data {
@@ -111,11 +114,11 @@ static inline int get_pdm_clk(struct fsl_micfil *micfil,
 			      unsigned int rate)
 {
 	u32 ctrl2_reg;
-	int qsel, osr;
+	int qsel;
 	int bclk;
+	int osr = MICFIL_OSR_DEFAULT;
 
 	regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
-	osr = 16 - FIELD_GET(MICFIL_CTRL2_CICOSR, ctrl2_reg);
 	qsel = FIELD_GET(MICFIL_CTRL2_QSEL, ctrl2_reg);
 
 	switch (qsel) {
@@ -281,7 +284,7 @@ static int fsl_set_clock_params(struct device *dev, unsigned int rate)
 	/* set CICOSR */
 	ret = regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,
 				 MICFIL_CTRL2_CICOSR,
-				 FIELD_PREP(MICFIL_CTRL2_CICOSR, MICFIL_CTRL2_CICOSR_DEFAULT));
+				 FIELD_PREP(MICFIL_CTRL2_CICOSR, 16 - MICFIL_OSR_DEFAULT));
 	if (ret)
 		return ret;
 
@@ -672,7 +675,6 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	micfil->dma_params_rx.addr = res->start + REG_MICFIL_DATACH0;
 	micfil->dma_params_rx.maxburst = MICFIL_DMA_MAXBURST_RX;
 
-
 	platform_set_drvdata(pdev, micfil);
 
 	pm_runtime_enable(&pdev->dev);
diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
index 5cecae2519795..08901827047db 100644
--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -58,7 +58,6 @@
 #define MICFIL_QSEL_VLOW2_QUALITY	4
 
 #define MICFIL_CTRL2_CICOSR		GENMASK(19, 16)
-#define MICFIL_CTRL2_CICOSR_DEFAULT	0
 #define MICFIL_CTRL2_CLKDIV		GENMASK(7, 0)
 
 /* MICFIL Status Register -- REG_MICFIL_STAT 0x08 */
-- 
2.30.2

