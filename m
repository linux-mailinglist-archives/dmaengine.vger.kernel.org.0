Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84C96EE9F
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jul 2019 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfGTJ0P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Jul 2019 05:26:15 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54501 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfGTJ0P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Jul 2019 05:26:15 -0400
X-Originating-IP: 91.163.65.175
Received: from localhost (91-163-65-175.subs.proxad.net [91.163.65.175])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5BE86C0008;
        Sat, 20 Jul 2019 09:26:12 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/3] dt-bindings: dma: Convert Allwinner A31 and A64 DMA to a schema
Date:   Sat, 20 Jul 2019 11:26:07 +0200
Message-Id: <20190720092607.31095-3-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720092607.31095-1-maxime.ripard@bootlin.com>
References: <20190720092607.31095-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The newer Allwinner SoCs have a DMA controller supported in Linux, with a
matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../dma/allwinner,sun50i-a64-dma.yaml         | 88 +++++++++++++++++++
 .../bindings/dma/allwinner,sun6i-a31-dma.yaml | 62 +++++++++++++
 .../devicetree/bindings/dma/sun6i-dma.txt     | 81 -----------------
 3 files changed, 150 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/sun6i-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
new file mode 100644
index 000000000000..4cb9d6b93138
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/allwinner,sun50i-a64-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A64 DMA Controller Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+    description: The cell is the request line number.
+
+  compatible:
+    enum:
+      - allwinner,sun50i-a64-dma
+      - allwinner,sun50i-h6-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mbus
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#dma-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - dma-channels
+
+if:
+  properties:
+    compatible:
+      const: allwinner,sun50i-h6-dma
+
+then:
+  properties:
+    clocks:
+      maxItems: 2
+
+  required:
+    - clock-names
+
+else:
+  properties:
+    clocks:
+      maxItems: 1
+
+# FIXME: We should set it, but it would report all the generic
+# properties as additional properties.
+# additionalProperties: false
+
+examples:
+  - |
+    dma: dma-controller@1c02000 {
+        compatible = "allwinner,sun50i-a64-dma";
+        reg = <0x01c02000 0x1000>;
+        interrupts = <0 50 4>;
+        clocks = <&ccu 30>;
+        dma-channels = <8>;
+        dma-requests = <27>;
+        resets = <&ccu 7>;
+        #dma-cells = <1>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml
new file mode 100644
index 000000000000..740b7f9b535b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/allwinner,sun6i-a31-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 DMA Controller Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+    description: The cell is the request line number.
+
+  compatible:
+    oneOf:
+      - const: allwinner,sun6i-a31-dma
+      - const: allwinner,sun8i-a23-dma
+      - const: allwinner,sun8i-a83t-dma
+      - const: allwinner,sun8i-h3-dma
+      - const: allwinner,sun8i-v3s-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#dma-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    dma: dma-controller@1c02000 {
+        compatible = "allwinner,sun6i-a31-dma";
+        reg = <0x01c02000 0x1000>;
+        interrupts = <0 50 4>;
+        clocks = <&ahb1_gates 6>;
+        resets = <&ahb1_rst 6>;
+        #dma-cells = <1>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
deleted file mode 100644
index cae31f4e77ba..000000000000
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-Allwinner A31 DMA Controller
-
-This driver follows the generic DMA bindings defined in dma.txt.
-
-Required properties:
-
-- compatible:	Must be one of
-		  "allwinner,sun6i-a31-dma"
-		  "allwinner,sun8i-a23-dma"
-		  "allwinner,sun8i-a83t-dma"
-		  "allwinner,sun8i-h3-dma"
-		  "allwinner,sun8i-v3s-dma"
-- reg:		Should contain the registers base address and length
-- interrupts:	Should contain a reference to the interrupt used by this device
-- clocks:	Should contain a reference to the parent AHB clock
-- resets:	Should contain a reference to the reset controller asserting
-		this device in reset
-- #dma-cells :	Should be 1, a single cell holding a line request number
-
-Example:
-	dma: dma-controller@1c02000 {
-		compatible = "allwinner,sun6i-a31-dma";
-		reg = <0x01c02000 0x1000>;
-		interrupts = <0 50 4>;
-		clocks = <&ahb1_gates 6>;
-		resets = <&ahb1_rst 6>;
-		#dma-cells = <1>;
-	};
-
-------------------------------------------------------------------------------
-For A64 and H6 DMA controller:
-
-Required properties:
-- compatible:	Must be one of
-		  "allwinner,sun50i-a64-dma"
-		  "allwinner,sun50i-h6-dma"
-- dma-channels: Number of DMA channels supported by the controller.
-		Refer to Documentation/devicetree/bindings/dma/dma.txt
-- clocks:	In addition to parent AHB clock, it should also contain mbus
-		clock (H6 only)
-- clock-names:	Should contain "bus" and "mbus" (H6 only)
-- all properties above, i.e. reg, interrupts, clocks, resets and #dma-cells
-
-Optional properties:
-- dma-requests: Number of DMA request signals supported by the controller.
-		Refer to Documentation/devicetree/bindings/dma/dma.txt
-
-Example:
-	dma: dma-controller@1c02000 {
-		compatible = "allwinner,sun50i-a64-dma";
-		reg = <0x01c02000 0x1000>;
-		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&ccu CLK_BUS_DMA>;
-		dma-channels = <8>;
-		dma-requests = <27>;
-		resets = <&ccu RST_BUS_DMA>;
-		#dma-cells = <1>;
-	};
-------------------------------------------------------------------------------
-
-Clients:
-
-DMA clients connected to the A31 DMA controller must use the format
-described in the dma.txt file, using a two-cell specifier for each
-channel: a phandle plus one integer cells.
-The two cells in order are:
-
-1. A phandle pointing to the DMA controller.
-2. The port ID as specified in the datasheet
-
-Example:
-spi2: spi@1c6a000 {
-	compatible = "allwinner,sun6i-a31-spi";
-	reg = <0x01c6a000 0x1000>;
-	interrupts = <0 67 4>;
-	clocks = <&ahb1_gates 22>, <&spi2_clk>;
-	clock-names = "ahb", "mod";
-	dmas = <&dma 25>, <&dma 25>;
-	dma-names = "rx", "tx";
-	resets = <&ahb1_rst 22>;
-};
-- 
2.21.0

