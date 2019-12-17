Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F330121F66
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfLQATp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:19:45 -0500
Received: from muru.com ([72.249.23.125]:48622 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfLQATp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:19:45 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9CC1B8126;
        Tue, 17 Dec 2019 00:20:23 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/14] ARM: dts: Add generic compatible for omap sdma instances
Date:   Mon, 16 Dec 2019 16:19:12 -0800
Message-Id: <20191217001925.44558-2-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We need this to pass auxdata to all the sdma instances.

Cc: devicetree@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi  | 2 +-
 arch/arm/boot/dts/omap4-l4.dtsi | 2 +-
 arch/arm/boot/dts/omap5-l4.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -212,7 +212,7 @@ SYSC_OMAP2_SOFTRESET |
 			ranges = <0x0 0x56000 0x1000>;
 
 			sdma: dma-controller@0 {
-				compatible = "ti,omap4430-sdma";
+				compatible = "ti,omap4430-sdma", "ti,omap-sdma";
 				reg = <0x0 0x1000>;
 				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -160,7 +160,7 @@ SYSC_OMAP2_SOFTRESET |
 			ranges = <0x0 0x56000 0x1000>;
 
 			sdma: dma-controller@0 {
-				compatible = "ti,omap4430-sdma";
+				compatible = "ti,omap4430-sdma", "ti,omap-sdma";
 				reg = <0x0 0x1000>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -237,7 +237,7 @@ SYSC_OMAP2_SOFTRESET |
 			ranges = <0x0 0x56000 0x1000>;
 
 			sdma: dma-controller@0 {
-				compatible = "ti,omap4430-sdma";
+				compatible = "ti,omap4430-sdma", "ti,omap-sdma";
 				reg = <0x0 0x1000>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.24.1
