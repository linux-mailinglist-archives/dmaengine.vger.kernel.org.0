Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ABB1BEB15
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 23:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgD2V7I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 17:59:08 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:8434 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726935AbgD2V7H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 17:59:07 -0400
X-IronPort-AV: E=Sophos;i="5.73,333,1583161200"; 
   d="scan'208";a="46009266"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Apr 2020 06:59:06 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 63E2C40ECBAC;
        Thu, 30 Apr 2020 06:59:02 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 18/18] ARM: dts: r8a7742: Add GPIO support
Date:   Wed, 29 Apr 2020 22:56:55 +0100
Message-Id: <1588197415-13747-19-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Describe GPIO blocks in the R8A7742 device tree.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 5305214..3901c63 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -249,66 +249,90 @@
 			compatible = "renesas,gpio-r8a7742",
 				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 0 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 912>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
 		gpio1: gpio@e6051000 {
 			compatible = "renesas,gpio-r8a7742",
 				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 32 30>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 911>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
 		gpio2: gpio@e6052000 {
 			compatible = "renesas,gpio-r8a7742",
 				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 64 30>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 910>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
 		gpio3: gpio@e6053000 {
 			compatible = "renesas,gpio-r8a7742",
 				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 96 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 909>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
 		gpio4: gpio@e6054000 {
 			compatible = "renesas,gpio-r8a7742",
 				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 128 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 908>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
 		gpio5: gpio@e6055000 {
 			compatible = "renesas,gpio-r8a7742",
 				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 160 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 907>;
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
 		pfc: pin-controller@e6060000 {
-- 
2.7.4

