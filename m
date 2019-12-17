Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64263121F92
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfLQAUN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:20:13 -0500
Received: from muru.com ([72.249.23.125]:48806 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfLQAUM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:20:12 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 094B181DE;
        Tue, 17 Dec 2019 00:20:47 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 14/14] ARM: OMAP2+: Drop legacy platform data for sdma
Date:   Mon, 16 Dec 2019 16:19:25 -0800
Message-Id: <20191217001925.44558-15-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We can now probe devices with ti-sysc interconnect driver and dts
data. Let's drop the related platform data and custom ti,hwmods
dts property.

As we're just dropping data, and the early platform data init
is based on the custom ti,hwmods property, we want to drop both
the platform data and ti,hwmods property in a single patch.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi                |  1 -
 arch/arm/boot/dts/omap2.dtsi                  |  1 -
 arch/arm/boot/dts/omap3.dtsi                  |  1 -
 arch/arm/boot/dts/omap4-l4.dtsi               |  1 -
 arch/arm/boot/dts/omap5-l4.dtsi               |  1 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    | 26 --------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    | 26 --------
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 18 ------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    | 53 ----------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    | 61 -------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    | 53 ----------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c     | 53 ----------------
 arch/arm/mach-omap2/omap_hwmod_common_data.h  |  1 -
 13 files changed, 296 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -186,7 +186,6 @@ cm_core_clockdomains: clockdomains {
 
 		target-module@56000 {			/* 0x4a056000, ap 9 02.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "dma_system";
 			reg = <0x56000 0x4>,
 			      <0x5602c 0x4>,
 			      <0x56028 0x4>;
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -82,7 +82,6 @@ intc: interrupt-controller@1 {
 
 		target-module@48056000 {
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "dma";
 			reg = <0x48056000 0x4>,
 			      <0x4805602c 0x4>,
 			      <0x48056028 0x4>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -208,7 +208,6 @@ intc: interrupt-controller@48200000 {
 
 		target-module@48056000 {
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "dma";
 			reg = <0x48056000 0x4>,
 			      <0x4805602c 0x4>,
 			      <0x48056028 0x4>;
diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -136,7 +136,6 @@ cm2_clockdomains: clockdomains {
 
 		target-module@56000 {			/* 0x4a056000, ap 7 0a.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "dma_system";
 			reg = <0x56000 0x4>,
 			      <0x5602c 0x4>,
 			      <0x56028 0x4>;
diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -213,7 +213,6 @@ dwc3: dwc3@10000 {
 
 		target-module@56000 {			/* 0x4a056000, ap 7 02.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "dma_system";
 			reg = <0x56000 0x4>,
 			      <0x5602c 0x4>,
 			      <0x56028 0x4>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/platform_data/i2c-omap.h>
-#include <linux/omap-dma.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
@@ -126,13 +125,6 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.flags		= HWMOD_16BIT_REG,
 };
 
-static struct omap_hwmod omap2420_dma_system_hwmod = {
-	.name		= "dma",
-	.class		= &omap2xxx_dma_hwmod_class,
-	.main_clk	= "core_l3_ck",
-	.flags		= HWMOD_NO_IDLEST,
-};
-
 /* mailbox */
 static struct omap_hwmod omap2420_mailbox_hwmod = {
 	.name		= "mailbox",
@@ -320,22 +312,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* dma_system -> L3 */
-static struct omap_hwmod_ocp_if omap2420_dma_system__l3 = {
-	.master		= &omap2420_dma_system_hwmod,
-	.slave		= &omap2xxx_l3_main_hwmod,
-	.clk		= "core_l3_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> dma_system */
-static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2420_dma_system_hwmod,
-	.clk		= "sdma_ick",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
 	.master		= &omap2xxx_l4_core_hwmod,
@@ -427,8 +403,6 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_wkup__gpio2,
 	&omap2420_l4_wkup__gpio3,
 	&omap2420_l4_wkup__gpio4,
-	&omap2420_dma_system__l3,
-	&omap2420_l4_core__dma_system,
 	&omap2420_l4_core__mailbox,
 	&omap2420_l4_core__mcbsp1,
 	&omap2420_l4_core__mcbsp2,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -12,7 +12,6 @@
 
 #include <linux/platform_data/i2c-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
-#include <linux/omap-dma.h>
 
 #include "omap_hwmod.h"
 #include "l3_2xxx.h"
@@ -121,13 +120,6 @@ static struct omap_hwmod omap2430_gpio5_hwmod = {
 	.class		= &omap2xxx_gpio_hwmod_class,
 };
 
-static struct omap_hwmod omap2430_dma_system_hwmod = {
-	.name		= "dma",
-	.class		= &omap2xxx_dma_hwmod_class,
-	.main_clk	= "core_l3_ck",
-	.flags		= HWMOD_NO_IDLEST,
-};
-
 /* mailbox */
 static struct omap_hwmod omap2430_mailbox_hwmod = {
 	.name		= "mailbox",
@@ -500,22 +492,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__gpio5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* dma_system -> L3 */
-static struct omap_hwmod_ocp_if omap2430_dma_system__l3 = {
-	.master		= &omap2430_dma_system_hwmod,
-	.slave		= &omap2xxx_l3_main_hwmod,
-	.clk		= "core_l3_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_core -> dma_system */
-static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
-	.master		= &omap2xxx_l4_core_hwmod,
-	.slave		= &omap2430_dma_system_hwmod,
-	.clk		= "sdma_ick",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox = {
 	.master		= &omap2xxx_l4_core_hwmod,
@@ -627,8 +603,6 @@ static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
 	&omap2430_l4_wkup__gpio3,
 	&omap2430_l4_wkup__gpio4,
 	&omap2430_l4_core__gpio5,
-	&omap2430_dma_system__l3,
-	&omap2430_l4_core__dma_system,
 	&omap2430_l4_core__mailbox,
 	&omap2430_l4_core__mcbsp1,
 	&omap2430_l4_core__mcbsp2,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/omap-dma.h>
 
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
@@ -95,23 +94,6 @@ struct omap_hwmod_class omap2xxx_gpio_hwmod_class = {
 	.sysc = &omap2xxx_gpio_sysc,
 };
 
-/* system dma */
-static struct omap_hwmod_class_sysconfig omap2xxx_dma_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x002c,
-	.syss_offs	= 0x0028,
-	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_MIDLEMODE |
-			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_EMUFREE |
-			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-struct omap_hwmod_class omap2xxx_dma_hwmod_class = {
-	.name	= "dma",
-	.sysc	= &omap2xxx_dma_sysc,
-};
-
 /*
  * 'mailbox' class
  * mailbox module allowing communication between the on-chip processors
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -16,7 +16,6 @@
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/hsmmc-omap.h>
 
-#include <linux/omap-dma.h>
 #include "l3_3xxx.h"
 #include "l4_3xxx.h"
 
@@ -833,39 +832,6 @@ static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.class		= &omap3xxx_gpio_hwmod_class,
 };
 
-static struct omap_hwmod_class_sysconfig omap3xxx_dma_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x002c,
-	.syss_offs	= 0x0028,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE |
-			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap3xxx_dma_hwmod_class = {
-	.name = "dma",
-	.sysc = &omap3xxx_dma_sysc,
-};
-
-/* dma_system */
-static struct omap_hwmod omap3xxx_dma_system_hwmod = {
-	.name		= "dma",
-	.class		= &omap3xxx_dma_hwmod_class,
-	.main_clk	= "core_l3_ick",
-	.prcm = {
-		.omap2 = {
-			.module_offs		= CORE_MOD,
-			.idlest_reg_id		= 1,
-			.idlest_idle_bit	= OMAP3430_ST_SDMA_SHIFT,
-		},
-	},
-	.flags		= HWMOD_NO_IDLEST,
-};
-
 /*
  * 'mcbsp' class
  * multi channel buffered serial port controller
@@ -2225,23 +2191,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio6 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* dma_system -> L3 */
-static struct omap_hwmod_ocp_if omap3xxx_dma_system__l3 = {
-	.master		= &omap3xxx_dma_system_hwmod,
-	.slave		= &omap3xxx_l3_main_hwmod,
-	.clk		= "core_l3_ick",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_cfg -> dma_system */
-static struct omap_hwmod_ocp_if omap3xxx_l4_core__dma_system = {
-	.master		= &omap3xxx_l4_core_hwmod,
-	.slave		= &omap3xxx_dma_system_hwmod,
-	.clk		= "core_l4_ick",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-
 /* l4_core -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mcbsp1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
@@ -2620,8 +2569,6 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_per__gpio4,
 	&omap3xxx_l4_per__gpio5,
 	&omap3xxx_l4_per__gpio6,
-	&omap3xxx_dma_system__l3,
-	&omap3xxx_l4_core__dma_system,
 	&omap3xxx_l4_core__mcbsp1,
 	&omap3xxx_l4_per__mcbsp2,
 	&omap3xxx_l4_per__mcbsp3,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -20,8 +20,6 @@
 #include <linux/io.h>
 #include <linux/power/smartreflex.h>
 
-#include <linux/omap-dma.h>
-
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
 #include "cm1_44xx.h"
@@ -32,9 +30,6 @@
 /* Base offset for all OMAP4 interrupts external to MPUSS */
 #define OMAP44XX_IRQ_GIC_START	32
 
-/* Base offset for all OMAP4 dma requests */
-#define OMAP44XX_DMA_REQ_START	1
-
 /*
  * IP blocks
  */
@@ -398,44 +393,6 @@ static struct omap_hwmod omap44xx_debugss_hwmod = {
 	},
 };
 
-/*
- * 'dma' class
- * dma controller for data exchange between memory to memory (i.e. internal or
- * external memory) and gp peripherals to memory or memory to gp peripherals
- */
-
-static struct omap_hwmod_class_sysconfig omap44xx_dma_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x002c,
-	.syss_offs	= 0x0028,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_EMUFREE | SYSC_HAS_MIDLEMODE |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap44xx_dma_hwmod_class = {
-	.name	= "dma",
-	.sysc	= &omap44xx_dma_sysc,
-};
-
-/* dma_system */
-static struct omap_hwmod omap44xx_dma_system_hwmod = {
-	.name		= "dma_system",
-	.class		= &omap44xx_dma_hwmod_class,
-	.clkdm_name	= "l3_dma_clkdm",
-	.main_clk	= "l3_div_ck",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_SDMA_SDMA_CONTEXT_OFFSET,
-		},
-	},
-};
-
 /*
  * 'dmic' class
  * digital microphone controller
@@ -2205,14 +2162,6 @@ static struct omap_hwmod_ocp_if omap44xx_debugss__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* dma_system -> l3_main_2 */
-static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 = {
-	.master		= &omap44xx_dma_system_hwmod,
-	.slave		= &omap44xx_l3_main_2_hwmod,
-	.clk		= "l3_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* fdif -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_fdif__l3_main_2 = {
 	.master		= &omap44xx_fdif_hwmod,
@@ -2445,14 +2394,6 @@ static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> dma_system */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_dma_system_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_abe -> dmic */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
 	.master		= &omap44xx_l4_abe_hwmod,
@@ -2945,7 +2886,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_cfg__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_debugss__l3_main_2,
-	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_fdif__l3_main_2,
 	&omap44xx_hsi__l3_main_2,
 	&omap44xx_ipu__l3_main_2,
@@ -2975,7 +2915,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_wkup__ctrl_module_wkup,
 	&omap44xx_l4_wkup__ctrl_module_pad_wkup,
 	&omap44xx_l3_instr__debugss,
-	&omap44xx_l4_cfg__dma_system,
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_dsp__iva,
 	/* &omap44xx_dsp__sl2if, */
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -17,8 +17,6 @@
 #include <linux/io.h>
 #include <linux/power/smartreflex.h>
 
-#include <linux/omap-dma.h>
-
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
 #include "cm1_54xx.h"
@@ -28,10 +26,6 @@
 /* Base offset for all OMAP5 interrupts external to MPUSS */
 #define OMAP54XX_IRQ_GIC_START	32
 
-/* Base offset for all OMAP5 dma requests */
-#define OMAP54XX_DMA_REQ_START	1
-
-
 /*
  * IP blocks
  */
@@ -232,44 +226,6 @@ static struct omap_hwmod omap54xx_counter_32k_hwmod = {
 	},
 };
 
-/*
- * 'dma' class
- * dma controller for data exchange between memory to memory (i.e. internal or
- * external memory) and gp peripherals to memory or memory to gp peripherals
- */
-
-static struct omap_hwmod_class_sysconfig omap54xx_dma_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x002c,
-	.syss_offs	= 0x0028,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_EMUFREE | SYSC_HAS_MIDLEMODE |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap54xx_dma_hwmod_class = {
-	.name	= "dma",
-	.sysc	= &omap54xx_dma_sysc,
-};
-
-/* dma_system */
-static struct omap_hwmod omap54xx_dma_system_hwmod = {
-	.name		= "dma_system",
-	.class		= &omap54xx_dma_hwmod_class,
-	.clkdm_name	= "dma_clkdm",
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DMA_DMA_SYSTEM_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_DMA_DMA_SYSTEM_CONTEXT_OFFSET,
-		},
-	},
-};
-
 /*
  * 'dmic' class
  * digital microphone controller
@@ -1415,14 +1371,6 @@ static struct omap_hwmod_ocp_if omap54xx_l4_wkup__counter_32k = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> dma_system */
-static struct omap_hwmod_ocp_if omap54xx_l4_cfg__dma_system = {
-	.master		= &omap54xx_l4_cfg_hwmod,
-	.slave		= &omap54xx_dma_system_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_abe -> dmic */
 static struct omap_hwmod_ocp_if omap54xx_l4_abe__dmic = {
 	.master		= &omap54xx_l4_abe_hwmod,
@@ -1665,7 +1613,6 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l3_main_1__l4_wkup,
 	&omap54xx_mpu__mpu_private,
 	&omap54xx_l4_wkup__counter_32k,
-	&omap54xx_l4_cfg__dma_system,
 	&omap54xx_l4_abe__dmic,
 	&omap54xx_l4_cfg__mmu_dsp,
 	&omap54xx_l3_main_2__dss,
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -17,8 +17,6 @@
 #include <linux/io.h>
 #include <linux/power/smartreflex.h>
 
-#include <linux/omap-dma.h>
-
 #include "omap_hwmod.h"
 #include "omap_hwmod_common_data.h"
 #include "cm1_7xx.h"
@@ -29,10 +27,6 @@
 /* Base offset for all DRA7XX interrupts external to MPUSS */
 #define DRA7XX_IRQ_GIC_START	32
 
-/* Base offset for all DRA7XX dma requests */
-#define DRA7XX_DMA_REQ_START	1
-
-
 /*
  * IP blocks
  */
@@ -387,44 +381,6 @@ static struct omap_hwmod dra7xx_epwmss2_hwmod = {
 	},
 };
 
-/*
- * 'dma' class
- *
- */
-
-static struct omap_hwmod_class_sysconfig dra7xx_dma_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x002c,
-	.syss_offs	= 0x0028,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_EMUFREE | SYSC_HAS_MIDLEMODE |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
-			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class dra7xx_dma_hwmod_class = {
-	.name	= "dma",
-	.sysc	= &dra7xx_dma_sysc,
-};
-
-/* dma_system */
-static struct omap_hwmod dra7xx_dma_system_hwmod = {
-	.name		= "dma_system",
-	.class		= &dra7xx_dma_hwmod_class,
-	.clkdm_name	= "dma_clkdm",
-	.main_clk	= "l3_iclk_div",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_DMA_DMA_SYSTEM_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_DMA_DMA_SYSTEM_CONTEXT_OFFSET,
-		},
-	},
-};
-
 /*
  * 'tpcc' class
  *
@@ -1698,14 +1654,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per2__dcan2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> dma_system */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__dma_system = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_dma_system_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main_1 -> tpcc */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__tpcc = {
 	.master		= &dra7xx_l3_main_1_hwmod,
@@ -2140,7 +2088,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__ctrl_module_wkup,
 	&dra7xx_l4_wkup__dcan1,
 	&dra7xx_l4_per2__dcan2,
-	&dra7xx_l4_cfg__dma_system,
 	&dra7xx_l3_main_1__tpcc,
 	&dra7xx_l3_main_1__tptc0,
 	&dra7xx_l3_main_1__tptc1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -98,7 +98,6 @@ extern struct omap_hwmod_class omap2_hdq1w_class;
 extern struct omap_hwmod_class omap2xxx_timer_hwmod_class;
 extern struct omap_hwmod_class omap2xxx_wd_timer_hwmod_class;
 extern struct omap_hwmod_class omap2xxx_gpio_hwmod_class;
-extern struct omap_hwmod_class omap2xxx_dma_hwmod_class;
 extern struct omap_hwmod_class omap2xxx_mailbox_hwmod_class;
 extern struct omap_hwmod_class omap2xxx_mcspi_class;
 
-- 
2.24.1
