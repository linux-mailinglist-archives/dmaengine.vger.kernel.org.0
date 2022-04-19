Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7810F506E38
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352496AbiDSNk5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352470AbiDSNky (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 09:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7009037ABD;
        Tue, 19 Apr 2022 06:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABF2A616A8;
        Tue, 19 Apr 2022 13:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626C6C385B4;
        Tue, 19 Apr 2022 13:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375481;
        bh=Cy+wwzOaVgtjDqQCWI06PLYznih6Y2ND7QxFqe4Xpd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTxet9qASIyT4pT7/bXgoG7K+343ypyZ3dk2jesY6LllhVU667bteRuuDsMlY1+38
         MpXUOXEEZJ1GFmvK1Wx6WWHwUEkzBncehUftqSKvdHbmu1mZlvF9uk/QSI3ydWScQY
         9164an8c0Bq2tcooKmOSSORP4/BqxFTRLl0RwGOSPJ/f8XnzC+knL6+AWXbOqxXrO9
         jT2WrNqUQlrcLED9/1qX0uSI65WM5jAAklzubs7u45qvte+7LIosfAKSCdPdO+U+yK
         aa3n07UtWnFgQdNlFXT8HmdCFVXag+AgGjv8BrQWmXVQUtFozHDJ7jeNiH6wjN8YAr
         +oetnkGXMv64A==
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
Subject: [PATCH 03/41] ARM: omap1: move lcd_dma code into omapfb driver
Date:   Tue, 19 Apr 2022 15:36:45 +0200
Message-Id: <20220419133723.1394715-4-arnd@kernel.org>
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

The omapfb driver is split into platform specific code for omap1, and
driver code that is also specific to omap1.

Moving both parts into the driver directory simplifies the structure
and avoids the dependency on certain omap machine header files.

As mach/lcd_dma.h can not be included from include/linux/omap-dma.h
any more now, move the omap_lcd_dma_running() declaration into the
omap-dma header, which matches where it is defined.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/Makefile                  |  4 --
 arch/arm/mach-omap1/include/mach/lcdc.h       | 44 -------------------
 drivers/video/fbdev/Makefile                  |  2 +-
 drivers/video/fbdev/omap/Makefile             |  5 +++
 .../video/fbdev/omap}/lcd_dma.c               |  4 +-
 .../video/fbdev/omap}/lcd_dma.h               |  2 -
 drivers/video/fbdev/omap/lcdc.c               |  2 +-
 drivers/video/fbdev/omap/lcdc.h               | 35 +++++++++++++++
 drivers/video/fbdev/omap/sossi.c              |  1 +
 include/linux/omap-dma.h                      |  4 +-
 10 files changed, 48 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/lcdc.h
 rename {arch/arm/mach-omap1 => drivers/video/fbdev/omap}/lcd_dma.c (99%)
 rename {arch/arm/mach-omap1/include/mach => drivers/video/fbdev/omap}/lcd_dma.h (98%)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index c757a52d0801..450bbf552b57 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -57,7 +57,3 @@ obj-$(CONFIG_ARCH_OMAP730)		+= gpio7xx.o
 obj-$(CONFIG_ARCH_OMAP850)		+= gpio7xx.o
 obj-$(CONFIG_ARCH_OMAP15XX)		+= gpio15xx.o
 obj-$(CONFIG_ARCH_OMAP16XX)		+= gpio16xx.o
-
-ifneq ($(CONFIG_FB_OMAP),)
-obj-y += lcd_dma.o
-endif
diff --git a/arch/arm/mach-omap1/include/mach/lcdc.h b/arch/arm/mach-omap1/include/mach/lcdc.h
deleted file mode 100644
index 7152db1f5361..000000000000
--- a/arch/arm/mach-omap1/include/mach/lcdc.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * arch/arm/mach-omap1/include/mach/lcdc.h
- *
- * Extracted from drivers/video/omap/lcdc.c
- * Copyright (C) 2004 Nokia Corporation
- * Author: Imre Deak <imre.deak@nokia.com>
- */
-#ifndef __MACH_LCDC_H__
-#define __MACH_LCDC_H__
-
-#define OMAP_LCDC_BASE			0xfffec000
-#define OMAP_LCDC_SIZE			256
-#define OMAP_LCDC_IRQ			INT_LCD_CTRL
-
-#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
-#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
-#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
-#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
-#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
-#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
-#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
-#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
-
-#define OMAP_LCDC_STAT_DONE		(1 << 0)
-#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
-#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
-#define OMAP_LCDC_STAT_ABC		(1 << 3)
-#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
-#define OMAP_LCDC_STAT_FUF		(1 << 5)
-#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
-
-#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
-#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
-#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
-
-#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
-#define OMAP_LCDC_IRQ_DONE		(1 << 3)
-#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
-#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
-#define OMAP_LCDC_IRQ_LINE		(1 << 6)
-#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
-
-#endif /* __MACH_LCDC_H__ */
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 477b9624b703..7795c4126706 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -110,7 +110,7 @@ obj-$(CONFIG_FB_UDL)		  += udlfb.o
 obj-$(CONFIG_FB_SMSCUFX)	  += smscufx.o
 obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
-obj-$(CONFIG_FB_OMAP)             += omap/
+obj-y				  += omap/
 obj-y                             += omap2/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
diff --git a/drivers/video/fbdev/omap/Makefile b/drivers/video/fbdev/omap/Makefile
index daaa73a94e7f..b88e02f5cb1f 100644
--- a/drivers/video/fbdev/omap/Makefile
+++ b/drivers/video/fbdev/omap/Makefile
@@ -5,6 +5,11 @@
 
 obj-$(CONFIG_FB_OMAP) += omapfb.o
 
+ifdef CONFIG_FB_OMAP
+# must be built-in
+obj-y += lcd_dma.o
+endif
+
 objs-yy := omapfb_main.o lcdc.o
 
 objs-y$(CONFIG_FB_OMAP_LCDC_EXTERNAL) += sossi.o
diff --git a/arch/arm/mach-omap1/lcd_dma.c b/drivers/video/fbdev/omap/lcd_dma.c
similarity index 99%
rename from arch/arm/mach-omap1/lcd_dma.c
rename to drivers/video/fbdev/omap/lcd_dma.c
index a72ac0c02b4f..867a63c06f42 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/drivers/video/fbdev/omap/lcd_dma.c
@@ -26,7 +26,9 @@
 #include <linux/omap-dma.h>
 
 #include <mach/hardware.h>
-#include <mach/lcdc.h>
+
+#include "lcdc.h"
+#include "lcd_dma.h"
 
 int omap_lcd_dma_running(void)
 {
diff --git a/arch/arm/mach-omap1/include/mach/lcd_dma.h b/drivers/video/fbdev/omap/lcd_dma.h
similarity index 98%
rename from arch/arm/mach-omap1/include/mach/lcd_dma.h
rename to drivers/video/fbdev/omap/lcd_dma.h
index 1a3c0cf17899..1b4780197381 100644
--- a/arch/arm/mach-omap1/include/mach/lcd_dma.h
+++ b/drivers/video/fbdev/omap/lcd_dma.h
@@ -60,6 +60,4 @@ extern void omap_set_lcd_dma_b1_vxres(unsigned long vxres);
 extern void omap_set_lcd_dma_b1_mirror(int mirror);
 extern void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscale);
 
-extern int omap_lcd_dma_running(void);
-
 #endif /* __MACH_OMAP1_LCD_DMA_H__ */
diff --git a/drivers/video/fbdev/omap/lcdc.c b/drivers/video/fbdev/omap/lcdc.c
index 7317c9aad677..d9a23f6cf7fc 100644
--- a/drivers/video/fbdev/omap/lcdc.c
+++ b/drivers/video/fbdev/omap/lcdc.c
@@ -17,7 +17,6 @@
 #include <linux/clk.h>
 #include <linux/gfp.h>
 
-#include <mach/lcdc.h>
 #include <linux/omap-dma.h>
 
 #include <asm/mach-types.h>
@@ -25,6 +24,7 @@
 #include "omapfb.h"
 
 #include "lcdc.h"
+#include "lcd_dma.h"
 
 #define MODULE_NAME			"lcdc"
 
diff --git a/drivers/video/fbdev/omap/lcdc.h b/drivers/video/fbdev/omap/lcdc.h
index 8a7607d861c1..cbbfd9b9e949 100644
--- a/drivers/video/fbdev/omap/lcdc.h
+++ b/drivers/video/fbdev/omap/lcdc.h
@@ -1,6 +1,41 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LCDC_H
 #define LCDC_H
+/*
+ * Copyright (C) 2004 Nokia Corporation
+ * Author: Imre Deak <imre.deak@nokia.com>
+ */
+#define OMAP_LCDC_BASE			0xfffec000
+#define OMAP_LCDC_SIZE			256
+#define OMAP_LCDC_IRQ			INT_LCD_CTRL
+
+#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
+#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
+#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
+#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
+#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
+#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
+#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
+#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
+
+#define OMAP_LCDC_STAT_DONE		(1 << 0)
+#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
+#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
+#define OMAP_LCDC_STAT_ABC		(1 << 3)
+#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
+#define OMAP_LCDC_STAT_FUF		(1 << 5)
+#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
+
+#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
+#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
+#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
+
+#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
+#define OMAP_LCDC_IRQ_DONE		(1 << 3)
+#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
+#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
+#define OMAP_LCDC_IRQ_LINE		(1 << 6)
+#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
 
 int omap_lcdc_set_dma_callback(void (*callback)(void *data), void *data);
 void omap_lcdc_free_dma_callback(void);
diff --git a/drivers/video/fbdev/omap/sossi.c b/drivers/video/fbdev/omap/sossi.c
index 80ac67f27f0d..d3c755b293ea 100644
--- a/drivers/video/fbdev/omap/sossi.c
+++ b/drivers/video/fbdev/omap/sossi.c
@@ -15,6 +15,7 @@
 #include <linux/omap-dma.h>
 
 #include "omapfb.h"
+#include "lcd_dma.h"
 #include "lcdc.h"
 
 #define MODULE_NAME		"omapfb-sossi"
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 5c5c93ad6b50..441f5f0919c6 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -328,8 +328,8 @@ extern dma_addr_t omap_get_dma_dst_pos(int lch);
 extern int omap_get_dma_active_status(int lch);
 extern int omap_dma_running(void);
 
-#if defined(CONFIG_ARCH_OMAP1) && IS_ENABLED(CONFIG_FB_OMAP)
-#include <mach/lcd_dma.h>
+#if IS_ENABLED(CONFIG_FB_OMAP)
+extern int omap_lcd_dma_running(void);
 #else
 static inline int omap_lcd_dma_running(void)
 {
-- 
2.29.2

