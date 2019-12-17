Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF94121F6C
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfLQATs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:19:48 -0500
Received: from muru.com ([72.249.23.125]:48654 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfLQATs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:19:48 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id BF2A68272;
        Tue, 17 Dec 2019 00:20:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 03/14] ARM: dts: Configure interconnect target module for omap3 sdma
Date:   Mon, 16 Dec 2019 16:19:14 -0800
Message-Id: <20191217001925.44558-4-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We can now probe devices with device tree only configuration using
ti-sysc interconnect target module driver. Let's configure the
module, but keep the legacy "ti,hwmods" peroperty to avoid new boot
time warnings. The legacy property will be removed in later patches
together with the legacy platform data.

Note that we want to use separate compatible for omap34xx and
omap36xx so let's do that here too while at it.

Cc: devicetree@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-n900.dts |  5 ++++
 arch/arm/boot/dts/omap3.dtsi     | 45 +++++++++++++++++++++++++-------
 arch/arm/boot/dts/omap36xx.dtsi  |  4 +++
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -482,6 +482,11 @@ &vintdig {
 	regulator-always-on;
 };
 
+/* First two dma channels are reserved on secure omap3 */
+&sdma {
+	dma-channel-mask = <0xfffffffc>;
+};
+
 &twl {
 	twl_audio: audio {
 		compatible = "ti,twl4030-audio";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -206,17 +206,42 @@ intc: interrupt-controller@48200000 {
 			reg = <0x48200000 0x1000>;
 		};
 
-		sdma: dma-controller@48056000 {
-			compatible = "ti,omap3630-sdma", "ti,omap3430-sdma";
-			reg = <0x48056000 0x1000>;
-			interrupts = <12>,
-				     <13>,
-				     <14>,
-				     <15>;
-			#dma-cells = <1>;
-			dma-channels = <32>;
-			dma-requests = <96>;
+		target-module@48056000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "dma";
+			reg = <0x48056000 0x4>,
+			      <0x4805602c 0x4>,
+			      <0x48056028 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_EMUFREE |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			/* Domains (V, P, C): core, core_pwrdm, core_l3_clkdm */
+			clocks = <&core_l3_ick>;
+			clock-names = "ick";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48056000 0x1000>;
+
+			sdma: dma-controller@0 {
+				compatible = "ti,omap3430-sdma", "ti,omap-sdma";
+				reg = <0x0 0x1000>;
+				interrupts = <12>,
+					     <13>,
+					     <14>,
+					     <15>;
+				#dma-cells = <1>;
+				dma-channels = <32>;
+				dma-requests = <96>;
+			};
 		};
 
 		gpio1: gpio@48310000 {
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -223,6 +223,10 @@ thermal_zones: thermal-zones {
 	};
 };
 
+&sdma {
+	compatible = "ti,omap3630-sdma", "ti,omap-sdma";
+};
+
 /* OMAP3630 needs dss_96m_fck for VENC */
 &venc {
 	clocks = <&dss_tv_fck>, <&dss_96m_fck>;
-- 
2.24.1
