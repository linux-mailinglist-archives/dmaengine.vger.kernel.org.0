Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BDA1AD841
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 10:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgDQIHP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 04:07:15 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:39199 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729495AbgDQIHP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Apr 2020 04:07:15 -0400
X-IronPort-AV: E=Sophos;i="5.72,394,1580742000"; 
   d="scan'208";a="44777868"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2020 17:07:14 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 41EA641F2119;
        Fri, 17 Apr 2020 17:07:14 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 1/2] dt-bindings: dma: renesas,rcar-dmac: convert bindings to json-schema
Date:   Fri, 17 Apr 2020 17:07:08 +0900
Message-Id: <1587110829-26609-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587110829-26609-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1587110829-26609-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert Renesas R-Car and RZ/G DMA Controller bindings
documentation to json-schema.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  | 117 ----------------
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml | 150 +++++++++++++++++++++
 2 files changed, 150 insertions(+), 117 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
deleted file mode 100644
index b7f81c6..00000000
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ /dev/null
@@ -1,117 +0,0 @@
-* Renesas R-Car (RZ/G) DMA Controller Device Tree bindings
-
-Renesas R-Car (Gen 2/3) and RZ/G SoCs have multiple multi-channel DMA
-controller instances named DMAC capable of serving multiple clients. Channels
-can be dedicated to specific clients or shared between a large number of
-clients.
-
-Each DMA client is connected to one dedicated port of the DMAC, identified by
-an 8-bit port number called the MID/RID. A DMA controller can thus serve up to
-256 clients in total. When the number of hardware channels is lower than the
-number of clients to be served, channels must be shared between multiple DMA
-clients. The association of DMA clients to DMAC channels is fully dynamic and
-not described in these device tree bindings.
-
-Required Properties:
-
-- compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.
-	      Examples with soctypes are:
-		- "renesas,dmac-r8a7743" (RZ/G1M)
-		- "renesas,dmac-r8a7744" (RZ/G1N)
-		- "renesas,dmac-r8a7745" (RZ/G1E)
-		- "renesas,dmac-r8a77470" (RZ/G1C)
-		- "renesas,dmac-r8a774a1" (RZ/G2M)
-		- "renesas,dmac-r8a774b1" (RZ/G2N)
-		- "renesas,dmac-r8a774c0" (RZ/G2E)
-		- "renesas,dmac-r8a7790" (R-Car H2)
-		- "renesas,dmac-r8a7791" (R-Car M2-W)
-		- "renesas,dmac-r8a7792" (R-Car V2H)
-		- "renesas,dmac-r8a7793" (R-Car M2-N)
-		- "renesas,dmac-r8a7794" (R-Car E2)
-		- "renesas,dmac-r8a7795" (R-Car H3)
-		- "renesas,dmac-r8a7796" (R-Car M3-W)
-		- "renesas,dmac-r8a77961" (R-Car M3-W+)
-		- "renesas,dmac-r8a77965" (R-Car M3-N)
-		- "renesas,dmac-r8a77970" (R-Car V3M)
-		- "renesas,dmac-r8a77980" (R-Car V3H)
-		- "renesas,dmac-r8a77990" (R-Car E3)
-		- "renesas,dmac-r8a77995" (R-Car D3)
-
-- reg: base address and length of the registers block for the DMAC
-
-- interrupts: interrupt specifiers for the DMAC, one for each entry in
-  interrupt-names.
-- interrupt-names: one entry for the error interrupt, named "error", plus one
-  entry per channel, named "ch%u", where %u is the channel number ranging from
-  zero to the number of channels minus one.
-
-- clock-names: "fck" for the functional clock
-- clocks: a list of phandle + clock-specifier pairs, one for each entry
-  in clock-names.
-- clock-names: must contain "fck" for the functional clock.
-
-- #dma-cells: must be <1>, the cell specifies the MID/RID of the DMAC port
-  connected to the DMA client
-- dma-channels: number of DMA channels
-
-Example: R8A7790 (R-Car H2) SYS-DMACs
-
-	dmac0: dma-controller@e6700000 {
-		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
-		reg = <0 0xe6700000 0 0x20000>;
-		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
-			      0 200 IRQ_TYPE_LEVEL_HIGH
-			      0 201 IRQ_TYPE_LEVEL_HIGH
-			      0 202 IRQ_TYPE_LEVEL_HIGH
-			      0 203 IRQ_TYPE_LEVEL_HIGH
-			      0 204 IRQ_TYPE_LEVEL_HIGH
-			      0 205 IRQ_TYPE_LEVEL_HIGH
-			      0 206 IRQ_TYPE_LEVEL_HIGH
-			      0 207 IRQ_TYPE_LEVEL_HIGH
-			      0 208 IRQ_TYPE_LEVEL_HIGH
-			      0 209 IRQ_TYPE_LEVEL_HIGH
-			      0 210 IRQ_TYPE_LEVEL_HIGH
-			      0 211 IRQ_TYPE_LEVEL_HIGH
-			      0 212 IRQ_TYPE_LEVEL_HIGH
-			      0 213 IRQ_TYPE_LEVEL_HIGH
-			      0 214 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5", "ch6", "ch7",
-				"ch8", "ch9", "ch10", "ch11",
-				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
-		clock-names = "fck";
-		#dma-cells = <1>;
-		dma-channels = <15>;
-	};
-
-	dmac1: dma-controller@e6720000 {
-		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
-		reg = <0 0xe6720000 0 0x20000>;
-		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
-			      0 216 IRQ_TYPE_LEVEL_HIGH
-			      0 217 IRQ_TYPE_LEVEL_HIGH
-			      0 218 IRQ_TYPE_LEVEL_HIGH
-			      0 219 IRQ_TYPE_LEVEL_HIGH
-			      0 308 IRQ_TYPE_LEVEL_HIGH
-			      0 309 IRQ_TYPE_LEVEL_HIGH
-			      0 310 IRQ_TYPE_LEVEL_HIGH
-			      0 311 IRQ_TYPE_LEVEL_HIGH
-			      0 312 IRQ_TYPE_LEVEL_HIGH
-			      0 313 IRQ_TYPE_LEVEL_HIGH
-			      0 314 IRQ_TYPE_LEVEL_HIGH
-			      0 315 IRQ_TYPE_LEVEL_HIGH
-			      0 316 IRQ_TYPE_LEVEL_HIGH
-			      0 317 IRQ_TYPE_LEVEL_HIGH
-			      0 318 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5", "ch6", "ch7",
-				"ch8", "ch9", "ch10", "ch11",
-				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
-		clock-names = "fck";
-		#dma-cells = <1>;
-		dma-channels = <15>;
-	};
diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
new file mode 100644
index 00000000..b842dfd9
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/renesas,rcar-dmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car and RZ/G DMA Controller
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
+          - renesas,dmac-r8a7743  # RZ/G1M
+          - renesas,dmac-r8a7744  # RZ/G1N
+          - renesas,dmac-r8a7745  # RZ/G1E
+          - renesas,dmac-r8a77470 # RZ/G1C
+          - renesas,dmac-r8a774a1 # RZ/G2M
+          - renesas,dmac-r8a774b1 # RZ/G2N
+          - renesas,dmac-r8a774c0 # RZ/G2E
+          - renesas,dmac-r8a7790  # R-Car H2
+          - renesas,dmac-r8a7791  # R-Car M2-W
+          - renesas,dmac-r8a7792  # R-Car V2H
+          - renesas,dmac-r8a7793  # R-Car M2-N
+          - renesas,dmac-r8a7794  # R-Car E2
+          - renesas,dmac-r8a7795  # R-Car H3
+          - renesas,dmac-r8a7796  # R-Car M3-W
+          - renesas,dmac-r8a77961 # R-Car M3-W+
+          - renesas,dmac-r8a77965 # R-Car M3-N
+          - renesas,dmac-r8a77970 # R-Car V3M
+          - renesas,dmac-r8a77980 # R-Car V3H
+          - renesas,dmac-r8a77990 # R-Car E3
+          - renesas,dmac-r8a77995 # R-Car D3
+      - const: renesas,rcar-dmac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 9
+    maxItems: 17
+
+  interrupt-names:
+    minItems: 9
+    maxItems: 17
+    items:
+      - const: error
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+      - pattern: "^ch([0-9]|1[0-5])$"
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+    items:
+      - const: fck
+
+  '#dma-cells':
+    const: 1
+    description:
+      The cell specifies the MID/RID of the DMAC port connected to
+      the DMA client.
+
+  dma-channels:
+    minimum: 8
+    maximum: 16
+
+  dma-channel-mask: true
+
+  iommus:
+    minItems: 8
+    maxItems: 16
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
+  - clock-names
+  - '#dma-cells'
+  - dma-channels
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7790-sysc.h>
+
+    dmac0: dma-controller@e6700000 {
+        compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
+        reg = <0xe6700000 0x20000>;
+        interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "error",
+                          "ch0", "ch1", "ch2", "ch3",
+                          "ch4", "ch5", "ch6", "ch7",
+                          "ch8", "ch9", "ch10", "ch11",
+                          "ch12", "ch13", "ch14";
+        clocks = <&cpg CPG_MOD 219>;
+        clock-names = "fck";
+        power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+        resets = <&cpg 219>;
+        #dma-cells = <1>;
+        dma-channels = <15>;
+    };
-- 
2.7.4

