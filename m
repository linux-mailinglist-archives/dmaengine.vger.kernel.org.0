Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8894B506E03
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbiDSNop (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352590AbiDSNlu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:41:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB18381B4;
        Tue, 19 Apr 2022 06:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DECEFB81984;
        Tue, 19 Apr 2022 13:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AC2C385AE;
        Tue, 19 Apr 2022 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375541;
        bh=Tabda3W6PeTGMPAu0M9QQqvhYHycL4TemoWy40qzXKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LW0UoBnX9Hzd86LCuPcO6M26sjgPOlXq6jYIKYaqHJXq5bcL1DEHz6T4LiTtbxQ5V
         rNq+KpgWJcQ+v3qqv0Osu2Bn1grzaUydyONyZK25cqWeeQyp6iiruSwB9jDhNJQi1H
         rgGCt2NBVy+QTsRCYLzUIrmIhsPCty3jBIuS1+h2vprkrocgwhSJnxqWFEGI1m9XWb
         Ra28W18ndsOK4QP3CQrCAQqyI2jbSWeW0BeZ7olszsizmclogqzyomgTeXxeiBgofD
         EAYelDZWulsqVtmdDnpD9qbRdAr1E4/1sb4ACF1iwKSPghV+dWtF/UoVae683yoGUy
         p4lP1qqtWoMfA==
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
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/41] fbdev: omap: avoid using mach/*.h files
Date:   Tue, 19 Apr 2022 15:36:53 +0200
Message-Id: <20220419133723.1394715-12-arnd@kernel.org>
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

All the headers we actually need are now in include/linux/soc,
so use those versions instead and allow compile-testing on
other architectures.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/backlight/Kconfig          | 4 ++--
 drivers/video/backlight/omap1_bl.c       | 4 ++--
 drivers/video/fbdev/omap/Kconfig         | 4 ++--
 drivers/video/fbdev/omap/lcd_ams_delta.c | 2 +-
 drivers/video/fbdev/omap/lcd_dma.c       | 3 ++-
 drivers/video/fbdev/omap/lcd_inn1510.c   | 2 +-
 drivers/video/fbdev/omap/lcd_osk.c       | 4 ++--
 drivers/video/fbdev/omap/lcdc.c          | 2 ++
 drivers/video/fbdev/omap/omapfb_main.c   | 3 +--
 drivers/video/fbdev/omap/sossi.c         | 1 +
 10 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index e32694c13da5..a003e02e13ce 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -211,8 +211,8 @@ config BACKLIGHT_LOCOMO
 
 config BACKLIGHT_OMAP1
 	tristate "OMAP1 PWL-based LCD Backlight"
-	depends on ARCH_OMAP1
-	default y
+	depends on ARCH_OMAP1 || COMPILE_TEST
+	default ARCH_OMAP1
 	help
 	  This driver controls the LCD backlight level and power for
 	  the PWL module of OMAP1 processors.  Say Y if your board
diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
index 74263021b1b3..69a49384b3de 100644
--- a/drivers/video/backlight/omap1_bl.c
+++ b/drivers/video/backlight/omap1_bl.c
@@ -14,8 +14,8 @@
 #include <linux/slab.h>
 #include <linux/platform_data/omap1_bl.h>
 
-#include <mach/hardware.h>
-#include <mach/mux.h>
+#include <linux/soc/ti/omap1-io.h>
+#include <linux/soc/ti/omap1-mux.h>
 
 #define OMAPBL_MAX_INTENSITY		0xff
 
diff --git a/drivers/video/fbdev/omap/Kconfig b/drivers/video/fbdev/omap/Kconfig
index df2a5d0d4aa2..b1786cf1b486 100644
--- a/drivers/video/fbdev/omap/Kconfig
+++ b/drivers/video/fbdev/omap/Kconfig
@@ -2,7 +2,7 @@
 config FB_OMAP
 	tristate "OMAP frame buffer support"
 	depends on FB
-	depends on ARCH_OMAP1
+	depends on ARCH_OMAP1 || (ARM && COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -42,7 +42,7 @@ config FB_OMAP_LCD_MIPID
 
 config FB_OMAP_LCD_H3
 	bool "TPS65010 LCD controller on OMAP-H3"
-	depends on MACH_OMAP_H3
+	depends on MACH_OMAP_H3 || COMPILE_TEST
 	depends on TPS65010=y
 	default y
 	help
diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index 01944ce46aa1..414d0f074306 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -14,7 +14,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/lcd.h>
 
-#include <mach/hardware.h>
+#include <linux/soc/ti/omap1-io.h>
 
 #include "omapfb.h"
 
diff --git a/drivers/video/fbdev/omap/lcd_dma.c b/drivers/video/fbdev/omap/lcd_dma.c
index 867a63c06f42..f85817635a8c 100644
--- a/drivers/video/fbdev/omap/lcd_dma.c
+++ b/drivers/video/fbdev/omap/lcd_dma.c
@@ -25,7 +25,8 @@
 
 #include <linux/omap-dma.h>
 
-#include <mach/hardware.h>
+#include <linux/soc/ti/omap1-soc.h>
+#include <linux/soc/ti/omap1-io.h>
 
 #include "lcdc.h"
 #include "lcd_dma.h"
diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
index 37ed0c14aa5a..bb915637e9b6 100644
--- a/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c
@@ -10,7 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
+#include <linux/soc/ti/omap1-soc.h>
 
 #include "omapfb.h"
 
diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
index 5d5762128c8d..8168ba0d47fd 100644
--- a/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c
@@ -11,8 +11,8 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
-#include <mach/mux.h>
+#include <linux/soc/ti/omap1-io.h>
+#include <linux/soc/ti/omap1-mux.h>
 
 #include "omapfb.h"
 
diff --git a/drivers/video/fbdev/omap/lcdc.c b/drivers/video/fbdev/omap/lcdc.c
index d9731d12bd72..4c9091bd936d 100644
--- a/drivers/video/fbdev/omap/lcdc.c
+++ b/drivers/video/fbdev/omap/lcdc.c
@@ -17,6 +17,8 @@
 #include <linux/clk.h>
 #include <linux/gfp.h>
 
+#include <linux/soc/ti/omap1-io.h>
+#include <linux/soc/ti/omap1-soc.h>
 #include <linux/omap-dma.h>
 
 #include <asm/mach-types.h>
diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index b8fd509f11e4..292fcb0a24fc 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -20,8 +20,7 @@
 
 #include <linux/omap-dma.h>
 
-#include <mach/hardware.h>
-
+#include <linux/soc/ti/omap1-soc.h>
 #include "omapfb.h"
 #include "lcdc.h"
 
diff --git a/drivers/video/fbdev/omap/sossi.c b/drivers/video/fbdev/omap/sossi.c
index ade9d452254c..6b99d89fbe6e 100644
--- a/drivers/video/fbdev/omap/sossi.c
+++ b/drivers/video/fbdev/omap/sossi.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 
 #include <linux/omap-dma.h>
+#include <linux/soc/ti/omap1-io.h>
 
 #include "omapfb.h"
 #include "lcd_dma.h"
-- 
2.29.2

