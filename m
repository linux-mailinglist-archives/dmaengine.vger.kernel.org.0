Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13D61A44E7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2020 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJKCW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Apr 2020 06:02:22 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:42126 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbgDJKCW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Apr 2020 06:02:22 -0400
X-IronPort-AV: E=Sophos;i="5.72,366,1580742000"; 
   d="scan'208";a="44156016"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Apr 2020 19:02:20 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3FE47400C0B9;
        Fri, 10 Apr 2020 19:02:20 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] dt-bindings: dma: renesas,usb-dmac: convert bindings to json-schema
Date:   Fri, 10 Apr 2020 19:02:03 +0900
Message-Id: <1586512923-21739-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert Renesas R-Car USB-DMA Controller bindings documentation
to json-schema.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   | 55 ------------
 .../devicetree/bindings/dma/renesas,usb-dmac.yaml  | 99 ++++++++++++++++++++++
 2 files changed, 99 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml

diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
deleted file mode 100644
index e8f6c42..00000000
--- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Renesas USB DMA Controller Device Tree bindings
-
-Required Properties:
--compatible: "renesas,<soctype>-usb-dmac", "renesas,usb-dmac" as fallback.
-	Examples with soctypes are:
-	  - "renesas,r8a7743-usb-dmac" (RZ/G1M)
-	  - "renesas,r8a7744-usb-dmac" (RZ/G1N)
-	  - "renesas,r8a7745-usb-dmac" (RZ/G1E)
-	  - "renesas,r8a77470-usb-dmac" (RZ/G1C)
-	  - "renesas,r8a774a1-usb-dmac" (RZ/G2M)
-	  - "renesas,r8a774b1-usb-dmac" (RZ/G2N)
-	  - "renesas,r8a774c0-usb-dmac" (RZ/G2E)
-	  - "renesas,r8a7790-usb-dmac" (R-Car H2)
-	  - "renesas,r8a7791-usb-dmac" (R-Car M2-W)
-	  - "renesas,r8a7793-usb-dmac" (R-Car M2-N)
-	  - "renesas,r8a7794-usb-dmac" (R-Car E2)
-	  - "renesas,r8a7795-usb-dmac" (R-Car H3)
-	  - "renesas,r8a7796-usb-dmac" (R-Car M3-W)
-	  - "renesas,r8a77961-usb-dmac" (R-Car M3-W+)
-	  - "renesas,r8a77965-usb-dmac" (R-Car M3-N)
-	  - "renesas,r8a77990-usb-dmac" (R-Car E3)
-	  - "renesas,r8a77995-usb-dmac" (R-Car D3)
-- reg: base address and length of the registers block for the DMAC
-- interrupts: interrupt specifiers for the DMAC, one for each entry in
-  interrupt-names.
-- interrupt-names: one entry per channel, named "ch%u", where %u is the
-  channel number ranging from zero to the number of channels minus one.
-- clocks: a list of phandle + clock-specifier pairs.
-- #dma-cells: must be <1>, the cell specifies the channel number of the DMAC
-  port connected to the DMA client.
-- dma-channels: number of DMA channels
-
-Example: R8A7790 (R-Car H2) USB-DMACs
-
-	usb_dmac0: dma-controller@e65a0000 {
-		compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
-		reg = <0 0xe65a0000 0 0x100>;
-		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
-			      0 109 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "ch0", "ch1";
-		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC0>;
-		#dma-cells = <1>;
-		dma-channels = <2>;
-	};
-
-	usb_dmac1: dma-controller@e65b0000 {
-		compatible = "renesas,usb-dmac";
-		reg = <0 0xe65b0000 0 0x100>;
-		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
-			      0 110 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "ch0", "ch1";
-		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC1>;
-		#dma-cells = <1>;
-		dma-channels = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
new file mode 100644
index 00000000..9c81081
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/renesas,usb-dmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas USB DMA Controller
+
+maintainers:
+  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r8a7743-usb-dmac  # RZ/G1M
+          - renesas,r8a7744-usb-dmac  # RZ/G1N
+          - renesas,r8a7745-usb-dmac  # RZ/G1E
+          - renesas,r8a77470-usb-dmac # RZ/G1C
+          - renesas,r8a774a1-usb-dmac # RZ/G2M
+          - renesas,r8a774b1-usb-dmac # RZ/G2N
+          - renesas,r8a774c0-usb-dmac # RZ/G2E
+          - renesas,r8a7790-usb-dmac  # R-Car H2
+          - renesas,r8a7791-usb-dmac  # R-Car M2-W
+          - renesas,r8a7793-usb-dmac  # R-Car M2-N
+          - renesas,r8a7794-usb-dmac  # R-Car E2
+          - renesas,r8a7795-usb-dmac  # R-Car H3
+          - renesas,r8a7796-usb-dmac  # R-Car M3-W
+          - renesas,r8a77961-usb-dmac # R-Car M3-W+
+          - renesas,r8a77965-usb-dmac # R-Car M3-N
+          - renesas,r8a77990-usb-dmac # R-Car E3
+          - renesas,r8a77995-usb-dmac # R-Car D3
+      - const: renesas,usb-dmac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    maxItems: 2
+    items:
+      - pattern: "^ch[0-1]$"
+      - pattern: "^ch[0-1]$"
+
+  clocks:
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+    description:
+      The cell specifies the channel number of the DMAC port connected to
+      the DMA client.
+
+  dma-channels:
+    maximum: 2
+
+  iommus:
+    maxItems: 2
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - '#dma-cells'
+  - dma-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7790-sysc.h>
+
+    usb_dmac0: dma-controller@e65a0000 {
+        compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
+        reg = <0xe65a0000 0x100>;
+        interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "ch0", "ch1";
+        clocks = <&cpg CPG_MOD 330>;
+        power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+        resets = <&cpg 330>;
+        #dma-cells = <1>;
+        dma-channels = <2>;
+    };
-- 
2.7.4

