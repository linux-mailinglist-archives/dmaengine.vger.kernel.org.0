Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39913506DE4
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352578AbiDSNlu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352474AbiDSNlV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:41:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695738BDF;
        Tue, 19 Apr 2022 06:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09AC6B81984;
        Tue, 19 Apr 2022 13:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FABC385A7;
        Tue, 19 Apr 2022 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375503;
        bh=L4gg5quKavJfZpB1KmVyym3/k9syW52kKGL3fWcWNjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kw5XRrHAn4pHn0I0JSh0pW57bNvPPurtShwMxO/ul/PIS9ZWV7guEzF9xGWK75yRC
         bzffgZZd8BPpYtn0JabaPloCpm1tz/ceomP3Qs/F5g/4nJxDb9p53CYK8dY+lp094q
         5wSTJkSY6xX7kul1bEQDyh2BoaPj9LNbGhLQVEKS74JWheELzUKJZJGWNDB6nIy4sR
         xnLBt7RWn0x8glJbzXe3XEizJ0lyMha7r/xgEfcpwSpe8ncBfbEVc8L7vt/yccyzep
         Gv9WCtCyMSH2+NDbePmeginBmFfZtvvfUXLljK5KzX4lbjo/agNMuMUcCA3OAl3QVI
         ZFJk0s9vx/QYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, tony@atomide.com, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 06/41] ARM: omap1: ams-delta: remove camera leftovers
Date:   Tue, 19 Apr 2022 15:36:48 +0200
Message-Id: <20220419133723.1394715-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419133723.1394715-1-arnd@kernel.org>
References: <20220419133723.1394715-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The obsolete camera support was removed, but a few lines remain in this
file and cause a warning:

arch/arm/mach-omap1/board-ams-delta.c:462:12: warning: 'ams_delta_camera_power' defined but not used [-Wunused-function]
  462 | static int ams_delta_camera_power(struct device *dev, int power)

Remove this and all related lines as well.

Fixes: ce548396a433 ("media: mach-omap1: board-ams-delta.c: remove soc_camera dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 1026a816dcc0..12d61ad98395 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -407,9 +407,6 @@ static struct gpio_led gpio_leds[] __initdata = {
 	[LATCH1_PIN_LED_CAMERA] = {
 		.name		 = "camera",
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
-#ifdef CONFIG_LEDS_TRIGGERS
-		.default_trigger = "ams_delta_camera",
-#endif
 	},
 	[LATCH1_PIN_LED_ADVERT] = {
 		.name		 = "advert",
@@ -456,10 +453,6 @@ static struct gpiod_lookup_table leds_gpio_table = {
 	},
 };
 
-#ifdef CONFIG_LEDS_TRIGGERS
-DEFINE_LED_TRIGGER(ams_delta_camera_led_trigger);
-#endif
-
 static struct platform_device ams_delta_audio_device = {
 	.name   = "ams-delta-audio",
 	.id     = -1,
@@ -705,10 +698,6 @@ static void __init ams_delta_init(void)
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 	omap1_usb_init(&ams_delta_usb_config);
-#ifdef CONFIG_LEDS_TRIGGERS
-	led_trigger_register_simple("ams_delta_camera",
-			&ams_delta_camera_led_trigger);
-#endif
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 	/*
-- 
2.29.2

