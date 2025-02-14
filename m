Return-Path: <dmaengine+bounces-4483-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348AEA3656F
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF1173370
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2A269CFC;
	Fri, 14 Feb 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0k83SsB+"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35E269AE8;
	Fri, 14 Feb 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556531; cv=none; b=KOXQZUjQPSPpUaVlKjl4Xl9QgaFaDprRgasGe/QZNOBGeo+AsSzQMv12sVAVbH3Twva8HffuxD755CgP6o6l8ZVryfCdSVGSgTIMG4mKArlYN8tUMP29AOpTTMzHBIjvHl/A1LauiY7soLiX+fRG4akFnFvzlciKpeB94xGKmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556531; c=relaxed/simple;
	bh=1jirbwm0amL5vmDsxIqDjfqVX7+BXeBDlukbPMT/bKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBA0jnZ6UiFRKX78sDo06+lpw4M/dgIGqQWjB2gqX70buk5Y3GQrZR1L8ZAw91wgf8i5RsKR3+IuKzK5JdSazMxARn8JikcaKQe2ZFqnu81VjbGhuYXrQdQg6Tbcad67/Il+jHVr3MCDjvIZVRdMUUjtgYvZ240NT/lbTi9dIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0k83SsB+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739556530; x=1771092530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1jirbwm0amL5vmDsxIqDjfqVX7+BXeBDlukbPMT/bKI=;
  b=0k83SsB+8rhHn55ILx5rq7UjYkJQV0u2Kb5ZbF/k3GlZNtwDmR7TS6XU
   HHat/YKq4IxCd7HGa8ZjIe2tJaYA4S8n73oQxEes5bvZdwsMj62UvyoBM
   Q6tX2LpUGqRLi/SL1kE+tsfQrtlQYPxaMmRzErXin5GtIlQiw+/hqqaI3
   1bEEFbkmsmW3JhoB/2hKDxIw+3PPfWcnz4hBAPIAd43dAsZ4Znyjah+cO
   VTk2/rxxPPkFYQH6LdRZe4xX5B3qHinOjxwR3VIU/EY0VcSemdKiko2f2
   pyWExBFJt+GCKNQv0gonOh2pJMrJhhZNhUIZdVUuJrMA/yD8SsgtKiSX5
   g==;
X-CSE-ConnectionGUID: afEECSQvQkGMMmDvtHvTFg==
X-CSE-MsgGUID: dnELiuSgQq+xQPam+KENXg==
X-IronPort-AV: E=Sophos;i="6.13,286,1732604400"; 
   d="scan'208";a="37700932"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2025 11:08:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Feb 2025 11:08:26 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 14 Feb 2025 11:08:26 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <vkoul@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 7/8] ARM: dts: microchip: sama7d65: Add DMAs to sama7d65 SoC
Date: Fri, 14 Feb 2025 11:08:20 -0700
Message-ID: <78da4125a991c6f4081fce78825f1f983091e0f5.1739555984.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739555984.git.Ryan.Wanner@microchip.com>
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add DMAs to the SAMA7D65 SoC device tree.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index d06a51972d363..b472a7d929ee4 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/dma/at91.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -95,6 +96,17 @@ chipid@e0020000 {
 			reg = <0xe0020000 0x8>;
 		};
 
+		dma2: dma-controller@e1200000 {
+			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
+			reg = <0xe1200000 0x1000>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
+			clock-names = "dma_clk";
+			dma-requests = <0>;
+			status = "disabled";
+		};
+
 		sdmmc1: mmc@e1208000 {
 			compatible = "microchip,sama7d65-sdhci", "microchip,sam9x60-sdhci";
 			reg = <0xe1208000 0x400>;
@@ -107,6 +119,26 @@ sdmmc1: mmc@e1208000 {
 			status = "disabled";
 		};
 
+		dma0: dma-controller@e1610000 {
+			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
+			reg = < 0xe1610000 0x1000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 21>;
+			clock-names = "dma_clk";
+			status = "disabled";
+		};
+
+		dma1: dma-controller@e1614000 {
+			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
+			reg = <0xe1614000 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 22>;
+			clock-names = "dma_clk";
+			status = "disabled";
+		};
+
 		pit64b0: timer@e1800000 {
 			compatible = "microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b";
 			reg = <0xe1800000 0x100>;
-- 
2.43.0


