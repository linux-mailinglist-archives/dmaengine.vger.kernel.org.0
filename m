Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4089450191C
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiDNQyM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiDNQyC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 12:54:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8113CCE4
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 09:22:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2FC-0007Ou-2J; Thu, 14 Apr 2022 18:22:54 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2FC-00312R-HR; Thu, 14 Apr 2022 18:22:53 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1nf2F9-00GuBM-GY; Thu, 14 Apr 2022 18:22:51 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     alsa-devel@alsa-project.org
Cc:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 12/21] ASoC: fsl_micfil: add multi fifo support
Date:   Thu, 14 Apr 2022 18:22:40 +0200
Message-Id: <20220414162249.3934543-13-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220414162249.3934543-1-s.hauer@pengutronix.de>
References: <20220414162249.3934543-1-s.hauer@pengutronix.de>
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

The micfil hardware provides the microphone data on multiple successive
FIFO registers, one register per stereo pair. Also to work properly the
SDMA_DONE0_CONFIG_DONE_SEL bit in the SDMA engines SDMA_DONE0_CONFIG
register must be set. This patch provides the necessary information to
the SDMA engine driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
---

Notes:
    Changes since v3:
    - Fix include name
    
    Changes since v2:
    - Add forgotten commit message

 sound/soc/fsl/fsl_micfil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 4656a18a03e45..56df916ad55f2 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -16,6 +16,7 @@
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/dma/imx-dma.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -35,6 +36,7 @@ struct fsl_micfil {
 	struct clk *busclk;
 	struct clk *mclk;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	struct sdma_peripheral_config sdmacfg;
 	unsigned int dataline;
 	char name[32];
 	int irq[MICFIL_IRQ_LINES];
@@ -324,6 +326,10 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	micfil->dma_params_rx.peripheral_config = &micfil->sdmacfg;
+	micfil->dma_params_rx.peripheral_size = sizeof(micfil->sdmacfg);
+	micfil->sdmacfg.n_fifos_src = channels;
+	micfil->sdmacfg.sw_done = true;
 	micfil->dma_params_rx.maxburst = channels * MICFIL_DMA_MAXBURST_RX;
 
 	return 0;
-- 
2.30.2

