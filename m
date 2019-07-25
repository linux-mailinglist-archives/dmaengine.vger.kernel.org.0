Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DDE75A0B
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 00:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfGYWCy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 18:02:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47278 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfGYWCy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Jul 2019 18:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564092170; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3yvF1lB2/uhxhtLoVJ9x7plcRIpIEm3TZOdg1G57Pc=;
        b=VBCx1fIAVpFwyOwDurw8A1un5blM+CibG1zAEgHn99lsyFDEBWDV1MtAIlJih1GV3EwzHn
        fgnqh88LcgtbhUdcLOjdUoySzIPos7b6YKDLPHnoqwwxedsjU1RSmtBMp+91aJpsRVqu0e
        tuHESZ0heEHOQMEFY1arrw70KqyW0rY=
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
Subject: [PATCH 02/11] MIPS: qi_lb60: Migrate to devicetree
Date:   Thu, 25 Jul 2019 18:02:06 -0400
Message-Id: <20190725220215.460-3-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
References: <20190725220215.460-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move all the platform data to devicetree.

The only bit dropped is the PWM beeper, which requires the PWM driver
to be updated. I figured it's okay to remove it here since it's really
a non-critical device, and it'll be re-introduced soon enough.

The other change is the CS line of the SPI is now set as active low. The
SPI core would have forced "active low" anyway, unless the 'spi-cs-high'
property is set.

In the process of moving to devicetree, we also switched to new drivers:
- We use the simple-audio-card and simple-amplifier drivers instead of
  the custom ASoC code;
- We use the new Ingenic DRM driver coupled with the GiantPlus GPM940B0
  DRM panel driver instead of the old framebuffer driver;
- We use the new jz4780-dma driver instead of the old jz4740-dma one;
- We use the ingenic-nand and jz4740-ecc drivers instead of the old
  jz4740-nand driver;
- We use ingenic-battery instead of jz4740-battery;
- We use iio-hwmon instead of jz4740-hwmon;
- We use ingenic-iio instead of the old jz4740-adc MFD driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 295 ++++++++++++++-
 arch/mips/jz4740/Makefile              |   4 -
 arch/mips/jz4740/board-qi_lb60.c       | 491 -------------------------
 3 files changed, 294 insertions(+), 496 deletions(-)
 delete mode 100644 arch/mips/jz4740/board-qi_lb60.c

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index cc26650562c2..8f3750981714 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -4,6 +4,16 @@
 #include "jz4740.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/iio/adc/ingenic,adc.h>
+#include <dt-bindings/input/input.h>
+
+#define KEY_QI_QI	KEY_F13
+#define KEY_QI_UPRED	KEY_RIGHTALT
+#define KEY_QI_VOLUP	KEY_VOLUMEUP
+#define KEY_QI_VOLDOWN	KEY_VOLUMEDOWN
+#define KEY_QI_FN	KEY_LEFTCTRL
+
 / {
 	compatible = "qi,lb60", "ingenic,jz4740";
 
@@ -11,7 +21,16 @@
 		stdout-path = &uart0;
 	};
 
-	mmc_power: fixedregulator {
+	vcc: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	mmc_power: regulator@1 {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc_vcc";
 		gpio = <&gpd 2 0>;
@@ -19,6 +38,203 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	amp_supply: regulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "amp_supply";
+		gpio = <&gpd 4 0>;
+		enable-active-high;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	amp: analog-amplifier {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&gpb 29 GPIO_ACTIVE_HIGH>;
+		VCC-supply = <&amp_supply>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,name = "QI LB60";
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,widgets =
+			"Speaker", "Speaker",
+			"Microphone", "Mic";
+		simple-audio-card,routing =
+			"MIC", "Mic",
+			"Speaker", "OUTL",
+			"Speaker", "OUTR",
+			"INL", "LOUT",
+			"INL", "ROUT";
+
+		simple-audio-card,aux-devs = <&amp>;
+
+		simple-audio-card,bitclock-master = <&dai_codec>;
+		simple-audio-card,frame-master = <&dai_codec>;
+
+		dai_cpu: simple-audio-card,cpu {
+			sound-dai = <&aic>;
+		};
+
+		dai_codec: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		key {
+			label = "Power";
+			wakeup-source;
+			linux,code = <KEY_POWER>;
+			gpios = <&gpd 29 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	keyboard {
+		compatible = "gpio-matrix-keypad";
+
+		col-scan-delay-us = <10>;
+		debounce-delay-ms = <10>;
+		wakeup-source;
+
+		row-gpios = <&gpd 18 0 &gpd 19 0 &gpd 20 0 &gpd 21 0
+			     &gpd 22 0 &gpd 23 0 &gpd 24 0 &gpd 26 0>;
+		col-gpios = <&gpc 10 0 &gpc 11 0 &gpc 12 0 &gpc 13 0
+			     &gpc 14 0 &gpc 15 0 &gpc 16 0 &gpc 17 0>;
+		gpio-activelow;
+
+		linux,keymap = <
+			MATRIX_KEY(0, 0, KEY_F1)	/* S2 */
+			MATRIX_KEY(0, 1, KEY_F2)	/* S3 */
+			MATRIX_KEY(0, 2, KEY_F3)	/* S4 */
+			MATRIX_KEY(0, 3, KEY_F4)	/* S5 */
+			MATRIX_KEY(0, 4, KEY_F5)	/* S6 */
+			MATRIX_KEY(0, 5, KEY_F6)	/* S7 */
+			MATRIX_KEY(0, 6, KEY_F7)	/* S8 */
+
+			MATRIX_KEY(1, 0, KEY_Q)	/* S10 */
+			MATRIX_KEY(1, 1, KEY_W)	/* S11 */
+			MATRIX_KEY(1, 2, KEY_E)	/* S12 */
+			MATRIX_KEY(1, 3, KEY_R)	/* S13 */
+			MATRIX_KEY(1, 4, KEY_T)	/* S14 */
+			MATRIX_KEY(1, 5, KEY_Y)	/* S15 */
+			MATRIX_KEY(1, 6, KEY_U)	/* S16 */
+			MATRIX_KEY(1, 7, KEY_I)	/* S17 */
+			MATRIX_KEY(2, 0, KEY_A)	/* S18 */
+			MATRIX_KEY(2, 1, KEY_S)	/* S19 */
+			MATRIX_KEY(2, 2, KEY_D)	/* S20 */
+			MATRIX_KEY(2, 3, KEY_F)	/* S21 */
+			MATRIX_KEY(2, 4, KEY_G)	/* S22 */
+			MATRIX_KEY(2, 5, KEY_H)	/* S23 */
+			MATRIX_KEY(2, 6, KEY_J)	/* S24 */
+			MATRIX_KEY(2, 7, KEY_K)	/* S25 */
+			MATRIX_KEY(3, 0, KEY_ESC)	/* S26 */
+			MATRIX_KEY(3, 1, KEY_Z)	/* S27 */
+			MATRIX_KEY(3, 2, KEY_X)	/* S28 */
+			MATRIX_KEY(3, 3, KEY_C)	/* S29 */
+			MATRIX_KEY(3, 4, KEY_V)	/* S30 */
+			MATRIX_KEY(3, 5, KEY_B)	/* S31 */
+			MATRIX_KEY(3, 6, KEY_N)	/* S32 */
+			MATRIX_KEY(3, 7, KEY_M)	/* S33 */
+			MATRIX_KEY(4, 0, KEY_TAB)	/* S34 */
+			MATRIX_KEY(4, 1, KEY_CAPSLOCK)	/* S35 */
+			MATRIX_KEY(4, 2, KEY_BACKSLASH)	/* S36 */
+			MATRIX_KEY(4, 3, KEY_APOSTROPHE)	/* S37 */
+			MATRIX_KEY(4, 4, KEY_COMMA)	/* S38 */
+			MATRIX_KEY(4, 5, KEY_DOT)	/* S39 */
+			MATRIX_KEY(4, 6, KEY_SLASH)	/* S40 */
+			MATRIX_KEY(4, 7, KEY_UP)	/* S41 */
+			MATRIX_KEY(5, 0, KEY_O)	/* S42 */
+			MATRIX_KEY(5, 1, KEY_L)	/* S43 */
+			MATRIX_KEY(5, 2, KEY_EQUAL)	/* S44 */
+			MATRIX_KEY(5, 3, KEY_QI_UPRED)	/* S45 */
+			MATRIX_KEY(5, 4, KEY_SPACE)	/* S46 */
+			MATRIX_KEY(5, 5, KEY_QI_QI)	/* S47 */
+			MATRIX_KEY(5, 6, KEY_RIGHTCTRL)	/* S48 */
+			MATRIX_KEY(5, 7, KEY_LEFT)	/* S49 */
+			MATRIX_KEY(6, 0, KEY_F8)	/* S50 */
+			MATRIX_KEY(6, 1, KEY_P)	/* S51 */
+			MATRIX_KEY(6, 2, KEY_BACKSPACE)/* S52 */
+			MATRIX_KEY(6, 3, KEY_ENTER)	/* S53 */
+			MATRIX_KEY(6, 4, KEY_QI_VOLUP)	/* S54 */
+			MATRIX_KEY(6, 5, KEY_QI_VOLDOWN)	/* S55 */
+			MATRIX_KEY(6, 6, KEY_DOWN)	/* S56 */
+			MATRIX_KEY(6, 7, KEY_RIGHT)	/* S57 */
+
+			MATRIX_KEY(7, 0, KEY_LEFTSHIFT)	/* S58 */
+			MATRIX_KEY(7, 1, KEY_LEFTALT) /* S59 */
+			MATRIX_KEY(7, 2, KEY_QI_FN)	/* S60 */
+			>;
+	};
+
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpc 23 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpc 22 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpc 21 GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+
+		spi@0 {
+			compatible = "ili8960";
+			reg = <0>;
+			spi-max-frequency = <30000>;
+			spi-3wire;
+		};
+	};
+
+	usb_charger: charger {
+		compatible = "gpio-charger";
+		charger-type = "usb-sdp";
+		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
+		status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
+	};
+
+	simple_battery: battery {
+		compatible = "simple-battery";
+		voltage-min-design-microvolt = <3600000>;
+		voltage-max-design-microvolt = <4200000>;
+	};
+
+	pmu {
+		compatible = "ingenic,jz4740-battery";
+		io-channels = <&adc INGENIC_ADC_BATTERY>;
+		io-channel-names = "battery";
+		power-supplies = <&usb_charger>;
+		monitored-battery = <&simple_battery>;
+	};
+
+	hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc INGENIC_ADC_AUX>;
+	};
+
+	panel: panel {
+		compatible = "giantplus,gpm940b0";
+
+		power-supply = <&vcc>;
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&panel_output>;
+			};
+		};
+	};
+
+	usb_phy: usb-phy {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+
+		vcc-supply = <&vcc>;
+	};
 };
 
 &ext {
@@ -34,7 +250,84 @@
 	pinctrl-0 = <&pins_uart0>;
 };
 
+&uart1 {
+	status = "disabled";
+};
+
+&nemc {
+	nandc: nand-controller@1 {
+		compatible = "ingenic,jz4740-nand";
+		reg = <1 0 0x4000000>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ingenic,bch-controller = <&ecc>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_nemc>;
+
+		rb-gpios = <&gpc 30 GPIO_ACTIVE_LOW>;
+
+		nand@1 {
+			reg = <1>;
+
+			nand-ecc-step-size = <512>;
+			nand-ecc-strength = <4>;
+			nand-ecc-mode = "hw";
+			nand-is-boot-medium;
+			nand-on-flash-bbt;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "boot";
+					reg = <0x0 0x400000>;
+				};
+
+				partition@400000 {
+					label = "kernel";
+					reg = <0x400000 0x400000>;
+				};
+
+				partition@800000 {
+					label = "rootfs";
+					reg = <0x800000 0x0>;
+				};
+			};
+		};
+	};
+};
+
+&lcd {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_lcd>;
+
+	port {
+		panel_output: endpoint {
+			remote-endpoint = <&panel_input>;
+		};
+	};
+};
+
+&udc {
+	phys = <&usb_phy>;
+};
+
 &pinctrl {
+	pins_lcd: lcd {
+		function = "lcd";
+		groups = "lcd-8bit";
+	};
+
+	pins_nemc: nemc {
+		function = "nand";
+		groups = "nand-cs1";
+	};
+
 	pins_uart0: uart0 {
 		function = "uart0";
 		groups = "uart0-data";
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 88d6aa7d000b..390c82adc00c 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -10,10 +10,6 @@ obj-y += prom.o time.o reset.o setup.o \
 
 CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
 
-# board specific support
-
-obj-$(CONFIG_JZ4740_QI_LB60)	+= board-qi_lb60.o
-
 # PM support
 
 obj-$(CONFIG_PM) += pm.o
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
deleted file mode 100644
index f9dab810aab2..000000000000
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ /dev/null
@@ -1,491 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * linux/arch/mips/jz4740/board-qi_lb60.c
- *
- * QI_LB60 board support
- *
- * Copyright (c) 2009 Qi Hardware inc.,
- * Author: Xiangfu Liu <xiangfu@qi-hardware.com>
- * Copyright 2010, Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/gpio/machine.h>
-
-#include <linux/input.h>
-#include <linux/gpio_keys.h>
-#include <linux/input/matrix_keypad.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/spi_gpio.h>
-#include <linux/pinctrl/machine.h>
-#include <linux/pinctrl/pinconf-generic.h>
-#include <linux/power_supply.h>
-#include <linux/power/jz4740-battery.h>
-#include <linux/power/gpio-charger.h>
-#include <linux/pwm.h>
-
-#include <linux/platform_data/jz4740/jz4740_nand.h>
-
-#include <asm/mach-jz4740/gpio.h>
-#include <asm/mach-jz4740/jz4740_fb.h>
-
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-
-#include <asm/mach-jz4740/platform.h>
-
-/* GPIOs */
-#define QI_LB60_GPIO_KEYOUT(x)		(JZ_GPIO_PORTC(10) + (x))
-#define QI_LB60_GPIO_KEYIN(x)		(JZ_GPIO_PORTD(18) + (x))
-#define QI_LB60_GPIO_KEYIN8		JZ_GPIO_PORTD(26)
-
-/* NAND */
-
-/* Early prototypes of the QI LB60 had only 1GB of NAND.
- * In order to support these devices as well the partition and ecc layout is
- * initialized depending on the NAND size */
-static struct mtd_partition qi_lb60_partitions_1gb[] = {
-	{
-		.name = "NAND BOOT partition",
-		.offset = 0 * 0x100000,
-		.size = 4 * 0x100000,
-	},
-	{
-		.name = "NAND KERNEL partition",
-		.offset = 4 * 0x100000,
-		.size = 4 * 0x100000,
-	},
-	{
-		.name = "NAND ROOTFS partition",
-		.offset = 8 * 0x100000,
-		.size = (504 + 512) * 0x100000,
-	},
-};
-
-static struct mtd_partition qi_lb60_partitions_2gb[] = {
-	{
-		.name = "NAND BOOT partition",
-		.offset = 0 * 0x100000,
-		.size = 4 * 0x100000,
-	},
-	{
-		.name = "NAND KERNEL partition",
-		.offset = 4 * 0x100000,
-		.size = 4 * 0x100000,
-	},
-	{
-		.name = "NAND ROOTFS partition",
-		.offset = 8 * 0x100000,
-		.size = (504 + 512 + 1024) * 0x100000,
-	},
-};
-
-static int qi_lb60_ooblayout_ecc(struct mtd_info *mtd, int section,
-				 struct mtd_oob_region *oobregion)
-{
-	if (section)
-		return -ERANGE;
-
-	oobregion->length = 36;
-	oobregion->offset = 6;
-
-	if (mtd->oobsize == 128) {
-		oobregion->length *= 2;
-		oobregion->offset *= 2;
-	}
-
-	return 0;
-}
-
-static int qi_lb60_ooblayout_free(struct mtd_info *mtd, int section,
-				  struct mtd_oob_region *oobregion)
-{
-	int eccbytes = 36, eccoff = 6;
-
-	if (section > 1)
-		return -ERANGE;
-
-	if (mtd->oobsize == 128) {
-		eccbytes *= 2;
-		eccoff *= 2;
-	}
-
-	if (!section) {
-		oobregion->offset = 2;
-		oobregion->length = eccoff - 2;
-	} else {
-		oobregion->offset = eccoff + eccbytes;
-		oobregion->length = mtd->oobsize - oobregion->offset;
-	}
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
-	.ecc = qi_lb60_ooblayout_ecc,
-	.free = qi_lb60_ooblayout_free,
-};
-
-static void qi_lb60_nand_ident(struct platform_device *pdev,
-		struct mtd_info *mtd, struct mtd_partition **partitions,
-		int *num_partitions)
-{
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
-	if (chip->page_shift == 12) {
-		*partitions = qi_lb60_partitions_2gb;
-		*num_partitions = ARRAY_SIZE(qi_lb60_partitions_2gb);
-	} else {
-		*partitions = qi_lb60_partitions_1gb;
-		*num_partitions = ARRAY_SIZE(qi_lb60_partitions_1gb);
-	}
-
-	mtd_set_ooblayout(mtd, &qi_lb60_ooblayout_ops);
-}
-
-static struct jz_nand_platform_data qi_lb60_nand_pdata = {
-	.ident_callback = qi_lb60_nand_ident,
-	.banks = { 1 },
-};
-
-static struct gpiod_lookup_table qi_lb60_nand_gpio_table = {
-	.dev_id = "jz4740-nand.0",
-	.table = {
-		GPIO_LOOKUP("GPIOC", 30, "busy", 0),
-		{ },
-	},
-};
-
-
-/* Keyboard*/
-
-#define KEY_QI_QI	KEY_F13
-#define KEY_QI_UPRED	KEY_RIGHTALT
-#define KEY_QI_VOLUP	KEY_VOLUMEUP
-#define KEY_QI_VOLDOWN	KEY_VOLUMEDOWN
-#define KEY_QI_FN	KEY_LEFTCTRL
-
-static const uint32_t qi_lb60_keymap[] = {
-	KEY(0, 0, KEY_F1),	/* S2 */
-	KEY(0, 1, KEY_F2),	/* S3 */
-	KEY(0, 2, KEY_F3),	/* S4 */
-	KEY(0, 3, KEY_F4),	/* S5 */
-	KEY(0, 4, KEY_F5),	/* S6 */
-	KEY(0, 5, KEY_F6),	/* S7 */
-	KEY(0, 6, KEY_F7),	/* S8 */
-
-	KEY(1, 0, KEY_Q),	/* S10 */
-	KEY(1, 1, KEY_W),	/* S11 */
-	KEY(1, 2, KEY_E),	/* S12 */
-	KEY(1, 3, KEY_R),	/* S13 */
-	KEY(1, 4, KEY_T),	/* S14 */
-	KEY(1, 5, KEY_Y),	/* S15 */
-	KEY(1, 6, KEY_U),	/* S16 */
-	KEY(1, 7, KEY_I),	/* S17 */
-	KEY(2, 0, KEY_A),	/* S18 */
-	KEY(2, 1, KEY_S),	/* S19 */
-	KEY(2, 2, KEY_D),	/* S20 */
-	KEY(2, 3, KEY_F),	/* S21 */
-	KEY(2, 4, KEY_G),	/* S22 */
-	KEY(2, 5, KEY_H),	/* S23 */
-	KEY(2, 6, KEY_J),	/* S24 */
-	KEY(2, 7, KEY_K),	/* S25 */
-	KEY(3, 0, KEY_ESC),	/* S26 */
-	KEY(3, 1, KEY_Z),	/* S27 */
-	KEY(3, 2, KEY_X),	/* S28 */
-	KEY(3, 3, KEY_C),	/* S29 */
-	KEY(3, 4, KEY_V),	/* S30 */
-	KEY(3, 5, KEY_B),	/* S31 */
-	KEY(3, 6, KEY_N),	/* S32 */
-	KEY(3, 7, KEY_M),	/* S33 */
-	KEY(4, 0, KEY_TAB),	/* S34 */
-	KEY(4, 1, KEY_CAPSLOCK),	/* S35 */
-	KEY(4, 2, KEY_BACKSLASH),	/* S36 */
-	KEY(4, 3, KEY_APOSTROPHE),	/* S37 */
-	KEY(4, 4, KEY_COMMA),	/* S38 */
-	KEY(4, 5, KEY_DOT),	/* S39 */
-	KEY(4, 6, KEY_SLASH),	/* S40 */
-	KEY(4, 7, KEY_UP),	/* S41 */
-	KEY(5, 0, KEY_O),	/* S42 */
-	KEY(5, 1, KEY_L),	/* S43 */
-	KEY(5, 2, KEY_EQUAL),	/* S44 */
-	KEY(5, 3, KEY_QI_UPRED),	/* S45 */
-	KEY(5, 4, KEY_SPACE),	/* S46 */
-	KEY(5, 5, KEY_QI_QI),	/* S47 */
-	KEY(5, 6, KEY_RIGHTCTRL),	/* S48 */
-	KEY(5, 7, KEY_LEFT),	/* S49 */
-	KEY(6, 0, KEY_F8),	/* S50 */
-	KEY(6, 1, KEY_P),	/* S51 */
-	KEY(6, 2, KEY_BACKSPACE),/* S52 */
-	KEY(6, 3, KEY_ENTER),	/* S53 */
-	KEY(6, 4, KEY_QI_VOLUP),	/* S54 */
-	KEY(6, 5, KEY_QI_VOLDOWN),	/* S55 */
-	KEY(6, 6, KEY_DOWN),	/* S56 */
-	KEY(6, 7, KEY_RIGHT),	/* S57 */
-
-	KEY(7, 0, KEY_LEFTSHIFT),	/* S58 */
-	KEY(7, 1, KEY_LEFTALT), /* S59 */
-	KEY(7, 2, KEY_QI_FN),	/* S60 */
-};
-
-static const struct matrix_keymap_data qi_lb60_keymap_data = {
-	.keymap		= qi_lb60_keymap,
-	.keymap_size	= ARRAY_SIZE(qi_lb60_keymap),
-};
-
-static const unsigned int qi_lb60_keypad_cols[] = {
-	QI_LB60_GPIO_KEYOUT(0),
-	QI_LB60_GPIO_KEYOUT(1),
-	QI_LB60_GPIO_KEYOUT(2),
-	QI_LB60_GPIO_KEYOUT(3),
-	QI_LB60_GPIO_KEYOUT(4),
-	QI_LB60_GPIO_KEYOUT(5),
-	QI_LB60_GPIO_KEYOUT(6),
-	QI_LB60_GPIO_KEYOUT(7),
-};
-
-static const unsigned int qi_lb60_keypad_rows[] = {
-	QI_LB60_GPIO_KEYIN(0),
-	QI_LB60_GPIO_KEYIN(1),
-	QI_LB60_GPIO_KEYIN(2),
-	QI_LB60_GPIO_KEYIN(3),
-	QI_LB60_GPIO_KEYIN(4),
-	QI_LB60_GPIO_KEYIN(5),
-	QI_LB60_GPIO_KEYIN(6),
-	QI_LB60_GPIO_KEYIN8,
-};
-
-static struct matrix_keypad_platform_data qi_lb60_pdata = {
-	.keymap_data = &qi_lb60_keymap_data,
-	.col_gpios	= qi_lb60_keypad_cols,
-	.row_gpios	= qi_lb60_keypad_rows,
-	.num_col_gpios	= ARRAY_SIZE(qi_lb60_keypad_cols),
-	.num_row_gpios	= ARRAY_SIZE(qi_lb60_keypad_rows),
-	.col_scan_delay_us	= 10,
-	.debounce_ms		= 10,
-	.wakeup			= 1,
-	.active_low		= 1,
-};
-
-static struct platform_device qi_lb60_keypad = {
-	.name		= "matrix-keypad",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &qi_lb60_pdata,
-	},
-};
-
-/* Display */
-static struct fb_videomode qi_lb60_video_modes[] = {
-	{
-		.name = "320x240",
-		.xres = 320,
-		.yres = 240,
-		.refresh = 30,
-		.left_margin = 140,
-		.right_margin = 273,
-		.upper_margin = 20,
-		.lower_margin = 2,
-		.hsync_len = 1,
-		.vsync_len = 1,
-		.sync = 0,
-		.vmode = FB_VMODE_NONINTERLACED,
-	},
-};
-
-static struct jz4740_fb_platform_data qi_lb60_fb_pdata = {
-	.width		= 60,
-	.height		= 45,
-	.num_modes	= ARRAY_SIZE(qi_lb60_video_modes),
-	.modes		= qi_lb60_video_modes,
-	.bpp		= 24,
-	.lcd_type	= JZ_LCD_TYPE_8BIT_SERIAL,
-	.pixclk_falling_edge = 1,
-};
-
-struct spi_gpio_platform_data qi_lb60_spigpio_platform_data = {
-	.num_chipselect = 1,
-};
-
-static struct platform_device qi_lb60_spigpio_device = {
-	.name = "spi_gpio",
-	.id   = 1,
-	.dev = {
-		.platform_data = &qi_lb60_spigpio_platform_data,
-	},
-};
-
-static struct gpiod_lookup_table qi_lb60_spigpio_gpio_table = {
-	.dev_id         = "spi_gpio",
-	.table          = {
-		GPIO_LOOKUP("GPIOC", 23,
-			    "sck", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("GPIOC", 22,
-			    "mosi", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("GPIOC", 21,
-			    "cs", GPIO_ACTIVE_HIGH),
-		{ },
-	},
-};
-
-static struct spi_board_info qi_lb60_spi_board_info[] = {
-	{
-		.modalias = "ili8960",
-		.chip_select = 0,
-		.bus_num = 1,
-		.max_speed_hz = 30 * 1000,
-		.mode = SPI_3WIRE,
-	},
-};
-
-/* Battery */
-static struct jz_battery_platform_data qi_lb60_battery_pdata = {
-	.gpio_charge =	JZ_GPIO_PORTC(27),
-	.gpio_charge_active_low = 1,
-	.info = {
-		.name = "battery",
-		.technology = POWER_SUPPLY_TECHNOLOGY_LIPO,
-		.voltage_max_design = 4200000,
-		.voltage_min_design = 3600000,
-	},
-};
-
-/* GPIO Key: power */
-static struct gpio_keys_button qi_lb60_gpio_keys_buttons[] = {
-	[0] = {
-		.code		= KEY_POWER,
-		.gpio		= JZ_GPIO_PORTD(29),
-		.active_low	= 1,
-		.desc		= "Power",
-		.wakeup		= 1,
-	},
-};
-
-static struct gpio_keys_platform_data qi_lb60_gpio_keys_data = {
-	.nbuttons = ARRAY_SIZE(qi_lb60_gpio_keys_buttons),
-	.buttons = qi_lb60_gpio_keys_buttons,
-};
-
-static struct platform_device qi_lb60_gpio_keys = {
-	.name = "gpio-keys",
-	.id =	-1,
-	.dev = {
-		.platform_data = &qi_lb60_gpio_keys_data,
-	}
-};
-
-/* beeper */
-static struct pwm_lookup qi_lb60_pwm_lookup[] = {
-	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
-		   PWM_POLARITY_NORMAL),
-};
-
-static struct platform_device qi_lb60_pwm_beeper = {
-	.name = "pwm-beeper",
-	.id = -1,
-};
-
-/* charger */
-static char *qi_lb60_batteries[] = {
-	"battery",
-};
-
-static struct gpio_charger_platform_data qi_lb60_charger_pdata = {
-	.name = "usb",
-	.type = POWER_SUPPLY_TYPE_USB,
-	.gpio = JZ_GPIO_PORTD(28),
-	.gpio_active_low = 1,
-	.supplied_to = qi_lb60_batteries,
-	.num_supplicants = ARRAY_SIZE(qi_lb60_batteries),
-};
-
-static struct platform_device qi_lb60_charger_device = {
-	.name = "gpio-charger",
-	.dev = {
-		.platform_data = &qi_lb60_charger_pdata,
-	},
-};
-
-/* audio */
-static struct platform_device qi_lb60_audio_device = {
-	.name = "qi-lb60-audio",
-	.id = -1,
-};
-
-static struct gpiod_lookup_table qi_lb60_audio_gpio_table = {
-	.dev_id = "qi-lb60-audio",
-	.table = {
-		GPIO_LOOKUP("GPIOB", 29, "snd", 0),
-		GPIO_LOOKUP("GPIOD", 4, "amp", 0),
-		{ },
-	},
-};
-
-static struct platform_device *jz_platform_devices[] __initdata = {
-	&jz4740_udc_device,
-	&jz4740_udc_xceiv_device,
-	&jz4740_nand_device,
-	&qi_lb60_keypad,
-	&qi_lb60_spigpio_device,
-	&jz4740_framebuffer_device,
-	&jz4740_pcm_device,
-	&jz4740_i2s_device,
-	&jz4740_codec_device,
-	&jz4740_adc_device,
-	&jz4740_pwm_device,
-	&qi_lb60_gpio_keys,
-	&qi_lb60_pwm_beeper,
-	&qi_lb60_charger_device,
-	&qi_lb60_audio_device,
-};
-
-static struct pinctrl_map pin_map[] __initdata = {
-	/* NAND pin configuration */
-	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-nand",
-			"10010000.pin-controller", "nand-cs1", "nand"),
-
-	/* fbdev pin configuration */
-	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_DEFAULT,
-			"10010000.pin-controller", "lcd-8bit", "lcd"),
-	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_SLEEP,
-			"10010000.pin-controller", "lcd-no-pins", "lcd"),
-
-	/* PWM pin configuration */
-	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-pwm",
-			"10010000.pin-controller", "pwm4", "pwm4"),
-};
-
-
-static int __init qi_lb60_init_platform_devices(void)
-{
-	jz4740_framebuffer_device.dev.platform_data = &qi_lb60_fb_pdata;
-	jz4740_nand_device.dev.platform_data = &qi_lb60_nand_pdata;
-	jz4740_adc_device.dev.platform_data = &qi_lb60_battery_pdata;
-
-	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
-	gpiod_add_lookup_table(&qi_lb60_nand_gpio_table);
-	gpiod_add_lookup_table(&qi_lb60_spigpio_gpio_table);
-
-	spi_register_board_info(qi_lb60_spi_board_info,
-				ARRAY_SIZE(qi_lb60_spi_board_info));
-
-	pwm_add_table(qi_lb60_pwm_lookup, ARRAY_SIZE(qi_lb60_pwm_lookup));
-	pinctrl_register_mappings(pin_map, ARRAY_SIZE(pin_map));
-
-	return platform_add_devices(jz_platform_devices,
-					ARRAY_SIZE(jz_platform_devices));
-
-}
-
-static int __init qi_lb60_board_setup(void)
-{
-	printk(KERN_INFO "Qi Hardware JZ4740 QI LB60 setup\n");
-
-	if (qi_lb60_init_platform_devices())
-		panic("Failed to initialize platform devices");
-
-	return 0;
-}
-arch_initcall(qi_lb60_board_setup);
-- 
2.21.0.593.g511ec345e18

