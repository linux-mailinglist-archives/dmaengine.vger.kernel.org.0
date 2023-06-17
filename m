Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110FD734142
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjFQNhI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jun 2023 09:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjFQNhH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jun 2023 09:37:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9067B5;
        Sat, 17 Jun 2023 06:37:05 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N49Yn-1q1L6f0zC5-0108qe; Sat, 17 Jun 2023 15:36:40 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 1/7] ARM: dts: bcm283x: Fix pinctrl groups
Date:   Sat, 17 Jun 2023 15:36:14 +0200
Message-Id: <20230617133620.53129-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IY3M0xwlJcn1MHHWzufLssN2h75OOWkxST7zRVe3Aze71fo0TWI
 AizeCsOGFtCvGGHrVqALKQoNzZh067DQ1DvzT1zXzcOkvCHzqSXS2n3CZov4nF+NF2J+YRB
 Lf9MvTXQnWdMhfolPqD34KHbxjxPBsyXT27TiMBlPm1XXMc/5R0VQwoA2YocbR6BZ1m9CbU
 p9IlT0LhX6SryE7po8d6g==
UI-OutboundReport: notjunk:1;M01:P0:X6pAvDBu4OQ=;zyoofsDWMG++GvPo1YfB/u8FFOH
 HlE1XYcUeGzAusqDKVYGThsSfTkS9xjxIQcRw50iNYNdDN/kwNgK2pmuUhNIQCs1AsMtM7BXz
 +7uddUuEklqA6gG5ok3rvcgyHV2Nl+XDIjdSvXc8P3pPZyodcYgsIrLD/7ZvzG91wYRcWIM9q
 p3QIDfbwcgwNJeNnActWD8MNfDfA8bqTmAm7kNlwvw39dzUagkymZ9ciqwbmUKZxssGLO5Doj
 r++nwI2Wti96Mcaphs9bU9ry9SaEkGCD9kgvgOPvSkmkwHjSJ0wtLQNhqhL6UTT5/ghM5ehK+
 KwoEw+FmgJ+vsbRiMX+KbA8D8aeSXMMIWhyX1Kbwiy4c9Khswwd99NmKutPeCUcXoCvNX8If6
 YcUOadgz665HIVmLER4kbYCIb7m6p/Td2vLGydxLC4z7GGQl/EVVnbFeKTq+QHy/2Wa2ZFQve
 Er4vqaRHGKiB/SflZvVw/8zyF+C3PKA7dcmb4fcNIyQd3VFYBm4hqRWOV2UrO2YAqj9ksBUSn
 JMsREY2bMHUBW1LqNIC36cVy9yesGlJISGFcCG2ljK7/VFDaWTEoGDY82pmGnOSzE3aWZWGni
 BXq62Uj36JM2AMtYwEizaK/fkowddq20TUfJEwBguWREi8PClZjJuvUYU0SjC+a/MIqznRsys
 +Na6/QOos0m7OL5wWRAUvkpYsTtyh6E61nUks5YQ1A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently the dtbs_check for bcm2837 generates warnings like this:

gpio@7e200000: 'pinctrl-0' is a dependency of 'pinctrl-names'

This is caused by the definition of pinctrl-names without matching
pinctrl group and vice versa. So defining both at the same place
make the dts files easier to review.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts   | 1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts        | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts   | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts   | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts        | 1 +
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts  | 1 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts   | 2 ++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts     | 1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi         | 2 --
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts  | 1 +
 arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts | 2 ++
 12 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 02ce817868ba..069b48272aa5 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -81,6 +81,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index 3fdf60eb11dc..2726c00431e8 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -83,6 +83,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 9956fd06a4b6..c57b999a4520 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -83,6 +83,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 4e1770afb145..ae6d3a9586ab 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -83,6 +83,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt2>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index eec1d0892d33..72764be75a79 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -83,6 +83,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0>;
 };
 
diff --git a/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts b/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
index 87958a96c3e0..3f9d198ac3ab 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
@@ -73,6 +73,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0>;
 };
 
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index dbf825985ec0..1f0b163e400c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -97,6 +97,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0>;
 };
 
@@ -111,6 +112,7 @@ &led_act {
 };
 
 &sdhci {
+	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio34 &gpclk2_gpio43>;
 };
 
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index f80e65a825fd..539c19c10946 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -85,6 +85,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ee9ee9d1fe65..f0acc9390f31 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -26,8 +26,6 @@ vchiq: mailbox@7e00b840 {
 };
 
 &gpio {
-	pinctrl-names = "default";
-
 	gpioout: gpioout {
 		brcm,pins = <6>;
 		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index 6068ec390081..79918033750e 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -82,6 +82,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
 
 	/* I2S interface */
diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
index cf84e69fced8..72d26d130efa 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
@@ -72,6 +72,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0>;
 };
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts b/arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts
index b9cc4594398b..85cf594724ef 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-zero-2-w.dts
@@ -95,6 +95,7 @@ &gpio {
 			  "SD_DATA2_R",
 			  "SD_DATA3_R";
 
+	pinctrl-names = "default";
 	pinctrl-0 = <&gpioout &alt0>;
 };
 
@@ -109,6 +110,7 @@ &led_act {
 };
 
 &sdhci {
+	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_gpio34 &gpclk2_gpio43>;
 };
 
-- 
2.34.1

