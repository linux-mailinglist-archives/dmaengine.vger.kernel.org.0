Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CDF4F269F
	for <lists+dmaengine@lfdr.de>; Tue,  5 Apr 2022 10:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiDEIGD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 04:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiDEICK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 04:02:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0CC4BB81
        for <dmaengine@vger.kernel.org>; Tue,  5 Apr 2022 01:00:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nbe6g-0003cq-PJ; Tue, 05 Apr 2022 10:00:06 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nbe6g-001BHF-9X; Tue, 05 Apr 2022 10:00:04 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nbe6b-00BXaT-86; Tue, 05 Apr 2022 10:00:01 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 18/20] ASoC: fsl_micfil: drop only once used defines
Date:   Tue,  5 Apr 2022 09:59:57 +0200
Message-Id: <20220405075959.2744803-19-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405075959.2744803-1-s.hauer@pengutronix.de>
References: <20220405075959.2744803-1-s.hauer@pengutronix.de>
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

FSL_MICFIL_RATES and FSL_MICFIL_FORMATS is only used once. Drop
the unnecesary indirection and use SNDRV_PCM_RATE_8000_48000 and
SNDRV_PCM_FMTBIT_S16_LE directly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_micfil.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index f7742a6e6c204..f536ea2db89db 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -25,9 +25,6 @@
 
 #include "fsl_micfil.h"
 
-#define FSL_MICFIL_RATES		SNDRV_PCM_RATE_8000_48000
-#define FSL_MICFIL_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE)
-
 #define MICFIL_OSR_DEFAULT	16
 
 enum quality {
@@ -349,8 +346,8 @@ static struct snd_soc_dai_driver fsl_micfil_dai = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
 		.channels_max = 8,
-		.rates = FSL_MICFIL_RATES,
-		.formats = FSL_MICFIL_FORMATS,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.ops = &fsl_micfil_dai_ops,
 };
-- 
2.30.2

