Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63646CF739
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfJHKjr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 06:39:47 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:52530 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730627AbfJHKjp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 06:39:45 -0400
X-IronPort-AV: E=Sophos;i="5.67,270,1566831600"; 
   d="scan'208";a="28359402"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Oct 2019 19:39:43 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6883D400941B;
        Tue,  8 Oct 2019 19:39:39 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH 09/10] arm64: dts: renesas: r8a774b1: Add USB3.0 device nodes
Date:   Tue,  8 Oct 2019 11:38:51 +0100
Message-Id: <1570531132-21856-10-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add usb3.0 phy, host and function device nodes on RZ/G2N SoC dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index abbcec6..f24bd34 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -720,9 +720,16 @@
 		};
 
 		usb3_phy0: usb-phy@e65ee000 {
+			compatible = "renesas,r8a774b1-usb3-phy",
+				     "renesas,rcar-gen3-usb3-phy";
 			reg = <0 0xe65ee000 0 0x90>;
+			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
+				 <&usb_extal_clk>;
+			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
 			#phy-cells = <0>;
-			/* placeholder */
+			status = "disabled";
 		};
 
 		dmac0: dma-controller@e6700000 {
@@ -1239,13 +1246,25 @@
 		};
 
 		xhci0: usb@ee000000 {
+			compatible = "renesas,xhci-r8a774b1",
+				     "renesas,rcar-gen3-xhci";
 			reg = <0 0xee000000 0 0xc00>;
-			/* placeholder */
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
 		};
 
 		usb3_peri0: usb@ee020000 {
+			compatible = "renesas,r8a774b1-usb3-peri",
+				     "renesas,rcar-gen3-usb3-peri";
 			reg = <0 0xee020000 0 0x400>;
-			/* placeholder */
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
 		};
 
 		ohci0: usb@ee080000 {
-- 
2.7.4

