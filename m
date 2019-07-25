Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E6075A1F
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 00:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfGYWDL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 18:03:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47396 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfGYWDK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Jul 2019 18:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564092187; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTh5425yXCqJXuaiG2LiwB549PtGkNt17YNuvHqHC/0=;
        b=vRUeERQTbUEcJBBZ1i5UD7gFOly4svQz+BjzJb8F8Wi28xvIs5nnGUrtXcjNs/PseSGxPw
        DsNg5L7bVGjc2MI3TKCzHdMwGAkrmdtxj6F4jyn0rjRAQbhnRvEVEO93Gc4srMEC4Ak46F
        xzT0eYXO20oEtKy20FZqPnidIT3YwVg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 04/11] ASoC: jz4740: Drop lb60 board code
Date:   Thu, 25 Jul 2019 18:02:08 -0400
Message-Id: <20190725220215.460-5-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
References: <20190725220215.460-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The board now uses the simple-audio-card driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 sound/soc/jz4740/Kconfig   |  25 +--------
 sound/soc/jz4740/Makefile  |   5 --
 sound/soc/jz4740/qi_lb60.c | 106 -------------------------------------
 3 files changed, 2 insertions(+), 134 deletions(-)
 delete mode 100644 sound/soc/jz4740/qi_lb60.c

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 6b757168693e..e72f826062e9 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -1,30 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config SND_JZ4740_SOC
-	tristate "SoC Audio for Ingenic JZ4740 SoC"
-	depends on MIPS || COMPILE_TEST
-	select SND_SOC_GENERIC_DMAENGINE_PCM
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the JZ4740 I2S interface. You will also need to select the audio
-	  interfaces to support below.
-
-if SND_JZ4740_SOC
-
 config SND_JZ4740_SOC_I2S
 	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
+	depends on MIPS || COMPILE_TEST
 	depends on HAS_IOMEM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
 	  based boards.
-
-config SND_JZ4740_SOC_QI_LB60
-	tristate "SoC Audio support for Qi LB60"
-	depends on HAS_IOMEM
-	depends on JZ4740_QI_LB60 || COMPILE_TEST
-	select SND_JZ4740_SOC_I2S
-    select SND_SOC_JZ4740_CODEC
-	help
-	  Say Y if you want to add support for ASoC audio on the Qi LB60 board
-	  a.k.a Qi Ben NanoNote.
-
-endif
diff --git a/sound/soc/jz4740/Makefile b/sound/soc/jz4740/Makefile
index fb10e9ad9ff7..f8701c9b09fe 100644
--- a/sound/soc/jz4740/Makefile
+++ b/sound/soc/jz4740/Makefile
@@ -5,8 +5,3 @@
 snd-soc-jz4740-i2s-objs := jz4740-i2s.o
 
 obj-$(CONFIG_SND_JZ4740_SOC_I2S) += snd-soc-jz4740-i2s.o
-
-# Jz4740 Machine Support
-snd-soc-qi-lb60-objs := qi_lb60.o
-
-obj-$(CONFIG_SND_JZ4740_SOC_QI_LB60) += snd-soc-qi-lb60.o
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
deleted file mode 100644
index 8ef6f41dcfbe..000000000000
--- a/sound/soc/jz4740/qi_lb60.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2009, Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <linux/gpio/consumer.h>
-
-struct qi_lb60 {
-	struct gpio_desc *snd_gpio;
-	struct gpio_desc *amp_gpio;
-};
-
-static int qi_lb60_spk_event(struct snd_soc_dapm_widget *widget,
-			     struct snd_kcontrol *ctrl, int event)
-{
-	struct qi_lb60 *qi_lb60 = snd_soc_card_get_drvdata(widget->dapm->card);
-	int on = !SND_SOC_DAPM_EVENT_OFF(event);
-
-	gpiod_set_value_cansleep(qi_lb60->snd_gpio, on);
-	gpiod_set_value_cansleep(qi_lb60->amp_gpio, on);
-
-	return 0;
-}
-
-static const struct snd_soc_dapm_widget qi_lb60_widgets[] = {
-	SND_SOC_DAPM_SPK("Speaker", qi_lb60_spk_event),
-	SND_SOC_DAPM_MIC("Mic", NULL),
-};
-
-static const struct snd_soc_dapm_route qi_lb60_routes[] = {
-	{"Mic", NULL, "MIC"},
-	{"Speaker", NULL, "LOUT"},
-	{"Speaker", NULL, "ROUT"},
-};
-
-SND_SOC_DAILINK_DEFS(hifi,
-	DAILINK_COMP_ARRAY(COMP_CPU("jz4740-i2s")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("jz4740-codec", "jz4740-hifi")),
-	DAILINK_COMP_ARRAY(COMP_PLATFORM("jz4740-i2s")));
-
-static struct snd_soc_dai_link qi_lb60_dai = {
-	.name = "jz4740",
-	.stream_name = "jz4740",
-	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBM_CFM,
-	SND_SOC_DAILINK_REG(hifi),
-};
-
-static struct snd_soc_card qi_lb60_card = {
-	.name = "QI LB60",
-	.owner = THIS_MODULE,
-	.dai_link = &qi_lb60_dai,
-	.num_links = 1,
-
-	.dapm_widgets = qi_lb60_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(qi_lb60_widgets),
-	.dapm_routes = qi_lb60_routes,
-	.num_dapm_routes = ARRAY_SIZE(qi_lb60_routes),
-	.fully_routed = true,
-};
-
-static int qi_lb60_probe(struct platform_device *pdev)
-{
-	struct qi_lb60 *qi_lb60;
-	struct snd_soc_card *card = &qi_lb60_card;
-
-	qi_lb60 = devm_kzalloc(&pdev->dev, sizeof(*qi_lb60), GFP_KERNEL);
-	if (!qi_lb60)
-		return -ENOMEM;
-
-	qi_lb60->snd_gpio = devm_gpiod_get(&pdev->dev, "snd", GPIOD_OUT_LOW);
-	if (IS_ERR(qi_lb60->snd_gpio))
-		return PTR_ERR(qi_lb60->snd_gpio);
-
-	qi_lb60->amp_gpio = devm_gpiod_get(&pdev->dev, "amp", GPIOD_OUT_LOW);
-	if (IS_ERR(qi_lb60->amp_gpio))
-		return PTR_ERR(qi_lb60->amp_gpio);
-
-	card->dev = &pdev->dev;
-
-	snd_soc_card_set_drvdata(card, qi_lb60);
-
-	return devm_snd_soc_register_card(&pdev->dev, card);
-}
-
-static struct platform_driver qi_lb60_driver = {
-	.driver		= {
-		.name	= "qi-lb60-audio",
-	},
-	.probe		= qi_lb60_probe,
-};
-
-module_platform_driver(qi_lb60_driver);
-
-MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("ALSA SoC QI LB60 Audio support");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:qi-lb60-audio");
-- 
2.21.0.593.g511ec345e18

