Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7F75A51
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 00:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfGYWEU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 18:04:20 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47876 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfGYWEU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Jul 2019 18:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564092257; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4oRILrMqt0pKYBhUUbdSFvuh/4sYT7CLAXQEyFIORY=;
        b=FzaJ66oDIb5UXuMpiEZ23ElSSgQoTUXOS/xI74gkg2Dlq4cB5LU+Mp8VonDvi8UG9bkJzd
        kFbNisvb8A0QbrgPmCnE1tbuX0N1j7UM7FSAnbO1AoR3SOmv2/pLx+YJmJx59bjNAnJL2F
        1FcUQbNOTp6h8xHsUURg9FbM/1+XzJA=
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
Subject: [PATCH 11/11] MIPS: jz4740: Drop dead code
Date:   Thu, 25 Jul 2019 18:02:15 -0400
Message-Id: <20190725220215.460-12-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
References: <20190725220215.460-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove all the source files that are not used anywhere anymore.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/mips/include/asm/mach-jz4740/gpio.h      |  15 --
 arch/mips/include/asm/mach-jz4740/jz4740_fb.h |  58 ----
 .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  12 -
 arch/mips/include/asm/mach-jz4740/platform.h  |  26 --
 arch/mips/jz4740/Makefile                     |   3 +-
 arch/mips/jz4740/platform.c                   | 250 ------------------
 arch/mips/jz4740/prom.c                       |   5 -
 arch/mips/jz4740/setup.c                      |   3 +-
 8 files changed, 2 insertions(+), 370 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-jz4740/gpio.h
 delete mode 100644 arch/mips/include/asm/mach-jz4740/jz4740_fb.h
 delete mode 100644 arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
 delete mode 100644 arch/mips/include/asm/mach-jz4740/platform.h
 delete mode 100644 arch/mips/jz4740/platform.c

diff --git a/arch/mips/include/asm/mach-jz4740/gpio.h b/arch/mips/include/asm/mach-jz4740/gpio.h
deleted file mode 100644
index 2092a3597734..000000000000
--- a/arch/mips/include/asm/mach-jz4740/gpio.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2009, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 GPIO pin definitions
- */
-
-#ifndef _JZ_GPIO_H
-#define _JZ_GPIO_H
-
-#define JZ_GPIO_PORTA(x) ((x) + 32 * 0)
-#define JZ_GPIO_PORTB(x) ((x) + 32 * 1)
-#define JZ_GPIO_PORTC(x) ((x) + 32 * 2)
-#define JZ_GPIO_PORTD(x) ((x) + 32 * 3)
-
-#endif
diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
deleted file mode 100644
index e84a48f73285..000000000000
--- a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2009, Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#ifndef __ASM_MACH_JZ4740_JZ4740_FB_H__
-#define __ASM_MACH_JZ4740_JZ4740_FB_H__
-
-#include <linux/fb.h>
-
-enum jz4740_fb_lcd_type {
-	JZ_LCD_TYPE_GENERIC_16_BIT = 0,
-	JZ_LCD_TYPE_GENERIC_18_BIT = 0 | (1 << 4),
-	JZ_LCD_TYPE_SPECIAL_TFT_1 = 1,
-	JZ_LCD_TYPE_SPECIAL_TFT_2 = 2,
-	JZ_LCD_TYPE_SPECIAL_TFT_3 = 3,
-	JZ_LCD_TYPE_NON_INTERLACED_CCIR656 = 5,
-	JZ_LCD_TYPE_INTERLACED_CCIR656 = 7,
-	JZ_LCD_TYPE_SINGLE_COLOR_STN = 8,
-	JZ_LCD_TYPE_SINGLE_MONOCHROME_STN = 9,
-	JZ_LCD_TYPE_DUAL_COLOR_STN = 10,
-	JZ_LCD_TYPE_DUAL_MONOCHROME_STN = 11,
-	JZ_LCD_TYPE_8BIT_SERIAL = 12,
-};
-
-#define JZ4740_FB_SPECIAL_TFT_CONFIG(start, stop) (((start) << 16) | (stop))
-
-/*
-* width: width of the lcd display in mm
-* height: height of the lcd display in mm
-* num_modes: size of modes
-* modes: list of valid video modes
-* bpp: bits per pixel for the lcd
-* lcd_type: lcd type
-*/
-
-struct jz4740_fb_platform_data {
-	unsigned int width;
-	unsigned int height;
-
-	size_t num_modes;
-	struct fb_videomode *modes;
-
-	unsigned int bpp;
-	enum jz4740_fb_lcd_type lcd_type;
-
-	struct {
-		uint32_t spl;
-		uint32_t cls;
-		uint32_t ps;
-		uint32_t rev;
-	} special_tft_config;
-
-	unsigned pixclk_falling_edge:1;
-	unsigned date_enable_active_low:1;
-};
-
-#endif
diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
deleted file mode 100644
index 9a7de47c7c79..000000000000
--- a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_MMC_JZ4740_MMC
-#define __LINUX_MMC_JZ4740_MMC
-
-struct jz4740_mmc_platform_data {
-	unsigned card_detect_active_low:1;
-	unsigned read_only_active_low:1;
-
-	unsigned data_1bit:1;
-};
-
-#endif
diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
deleted file mode 100644
index 241270d3ea14..000000000000
--- a/arch/mips/include/asm/mach-jz4740/platform.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform device definitions
- */
-
-
-#ifndef __JZ4740_PLATFORM_H
-#define __JZ4740_PLATFORM_H
-
-#include <linux/platform_device.h>
-
-extern struct platform_device jz4740_udc_device;
-extern struct platform_device jz4740_udc_xceiv_device;
-extern struct platform_device jz4740_mmc_device;
-extern struct platform_device jz4740_i2c_device;
-extern struct platform_device jz4740_nand_device;
-extern struct platform_device jz4740_framebuffer_device;
-extern struct platform_device jz4740_i2s_device;
-extern struct platform_device jz4740_pcm_device;
-extern struct platform_device jz4740_codec_device;
-extern struct platform_device jz4740_adc_device;
-extern struct platform_device jz4740_pwm_device;
-extern struct platform_device jz4740_dma_device;
-
-#endif
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 390c82adc00c..6de14c0deb4e 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,8 +5,7 @@
 
 # Object file lists.
 
-obj-y += prom.o time.o reset.o setup.o \
-	platform.o timer.o
+obj-y += prom.o time.o reset.o setup.o timer.o
 
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
deleted file mode 100644
index c74c99f5951d..000000000000
--- a/arch/mips/jz4740/platform.c
+++ /dev/null
@@ -1,250 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform devices
- */
-
-#include <linux/clk.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/resource.h>
-
-#include <linux/dma-mapping.h>
-
-#include <linux/usb/musb.h>
-
-#include <asm/mach-jz4740/platform.h>
-#include <asm/mach-jz4740/base.h>
-#include <asm/mach-jz4740/irq.h>
-
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
-
-/* USB Device Controller */
-struct platform_device jz4740_udc_xceiv_device = {
-	.name = "usb_phy_generic",
-	.id   = 0,
-};
-
-static struct resource jz4740_udc_resources[] = {
-	[0] = {
-		.start = JZ4740_UDC_BASE_ADDR,
-		.end   = JZ4740_UDC_BASE_ADDR + 0x10000 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = JZ4740_IRQ_UDC,
-		.end   = JZ4740_IRQ_UDC,
-		.flags = IORESOURCE_IRQ,
-		.name  = "mc",
-	},
-};
-
-struct platform_device jz4740_udc_device = {
-	.name = "musb-jz4740",
-	.id   = -1,
-	.dev  = {
-		.dma_mask          = &jz4740_udc_device.dev.coherent_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.num_resources = ARRAY_SIZE(jz4740_udc_resources),
-	.resource      = jz4740_udc_resources,
-};
-
-/* MMC/SD controller */
-static struct resource jz4740_mmc_resources[] = {
-	{
-		.start	= JZ4740_MSC_BASE_ADDR,
-		.end	= JZ4740_MSC_BASE_ADDR + 0x1000 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= JZ4740_IRQ_MSC,
-		.end	= JZ4740_IRQ_MSC,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device jz4740_mmc_device = {
-	.name		= "jz4740-mmc",
-	.id		= 0,
-	.dev = {
-		.dma_mask = &jz4740_mmc_device.dev.coherent_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(jz4740_mmc_resources),
-	.resource	= jz4740_mmc_resources,
-};
-
-/* I2C controller */
-static struct resource jz4740_i2c_resources[] = {
-	{
-		.start	= JZ4740_I2C_BASE_ADDR,
-		.end	= JZ4740_I2C_BASE_ADDR + 0x1000 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= JZ4740_IRQ_I2C,
-		.end	= JZ4740_IRQ_I2C,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device jz4740_i2c_device = {
-	.name		= "jz4740-i2c",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(jz4740_i2c_resources),
-	.resource	= jz4740_i2c_resources,
-};
-
-/* NAND controller */
-static struct resource jz4740_nand_resources[] = {
-	{
-		.name	= "mmio",
-		.start	= JZ4740_EMC_BASE_ADDR,
-		.end	= JZ4740_EMC_BASE_ADDR + 0x1000 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "bank1",
-		.start	= 0x18000000,
-		.end	= 0x180C0000 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name	= "bank2",
-		.start	= 0x14000000,
-		.end	= 0x140C0000 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name	= "bank3",
-		.start	= 0x0C000000,
-		.end	= 0x0C0C0000 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name	= "bank4",
-		.start	= 0x08000000,
-		.end	= 0x080C0000 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device jz4740_nand_device = {
-	.name = "jz4740-nand",
-	.num_resources = ARRAY_SIZE(jz4740_nand_resources),
-	.resource = jz4740_nand_resources,
-};
-
-/* LCD controller */
-static struct resource jz4740_framebuffer_resources[] = {
-	{
-		.start	= JZ4740_LCD_BASE_ADDR,
-		.end	= JZ4740_LCD_BASE_ADDR + 0x1000 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device jz4740_framebuffer_device = {
-	.name		= "jz4740-fb",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(jz4740_framebuffer_resources),
-	.resource	= jz4740_framebuffer_resources,
-	.dev = {
-		.dma_mask = &jz4740_framebuffer_device.dev.coherent_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
-
-/* I2S controller */
-static struct resource jz4740_i2s_resources[] = {
-	{
-		.start	= JZ4740_AIC_BASE_ADDR,
-		.end	= JZ4740_AIC_BASE_ADDR + 0x38 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device jz4740_i2s_device = {
-	.name		= "jz4740-i2s",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(jz4740_i2s_resources),
-	.resource	= jz4740_i2s_resources,
-};
-
-/* PCM */
-struct platform_device jz4740_pcm_device = {
-	.name		= "jz4740-pcm-audio",
-	.id		= -1,
-};
-
-/* Codec */
-static struct resource jz4740_codec_resources[] = {
-	{
-		.start	= JZ4740_AIC_BASE_ADDR + 0x80,
-		.end	= JZ4740_AIC_BASE_ADDR + 0x88 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device jz4740_codec_device = {
-	.name		= "jz4740-codec",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(jz4740_codec_resources),
-	.resource	= jz4740_codec_resources,
-};
-
-/* ADC controller */
-static struct resource jz4740_adc_resources[] = {
-	{
-		.start	= JZ4740_SADC_BASE_ADDR,
-		.end	= JZ4740_SADC_BASE_ADDR + 0x30,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= JZ4740_IRQ_SADC,
-		.end	= JZ4740_IRQ_SADC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= JZ4740_IRQ_ADC_BASE,
-		.end	= JZ4740_IRQ_ADC_BASE,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device jz4740_adc_device = {
-	.name		= "jz4740-adc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(jz4740_adc_resources),
-	.resource	= jz4740_adc_resources,
-};
-
-/* PWM */
-struct platform_device jz4740_pwm_device = {
-	.name = "jz4740-pwm",
-	.id   = -1,
-};
-
-/* DMA */
-static struct resource jz4740_dma_resources[] = {
-	{
-		.start	= JZ4740_DMAC_BASE_ADDR,
-		.end	= JZ4740_DMAC_BASE_ADDR + 0x400 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= JZ4740_IRQ_DMAC,
-		.end	= JZ4740_IRQ_DMAC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device jz4740_dma_device = {
-	.name		= "jz4740-dma",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(jz4740_dma_resources),
-	.resource	= jz4740_dma_resources,
-};
diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
index 88f33af4403b..ff4555c3fb15 100644
--- a/arch/mips/jz4740/prom.c
+++ b/arch/mips/jz4740/prom.c
@@ -4,15 +4,10 @@
  *  JZ4740 SoC prom code
  */
 
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/string.h>
-
-#include <linux/serial_reg.h>
 
 #include <asm/bootinfo.h>
 #include <asm/fw/fw.h>
-#include <asm/mach-jz4740/base.h>
 
 void __init prom_init(void)
 {
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index 4264eaf030c3..73ed2724d4c7 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -15,10 +15,9 @@
 #include <asm/bootinfo.h>
 #include <asm/prom.h>
 
-#include <asm/mach-jz4740/base.h>
-
 #include "reset.h"
 
+#define JZ4740_EMC_BASE_ADDR 0x13010000
 
 #define JZ4740_EMC_SDRAM_CTRL 0x80
 
-- 
2.21.0.593.g511ec345e18

