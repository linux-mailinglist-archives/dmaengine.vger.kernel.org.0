Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84D1653EA
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2019 11:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfGKJgY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jul 2019 05:36:24 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41907 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKJgY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Jul 2019 05:36:24 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B715EC0042;
        Thu, 11 Jul 2019 09:36:08 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: dma: Convert Allwinner A10 DMA to a schema
Date:   Thu, 11 Jul 2019 11:21:57 +0200
Message-Id: <20190711092158.14678-2-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190711092158.14678-1-maxime.ripard@bootlin.com>
References: <20190711092158.14678-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The older Allwinner SoCs have a DMA controller supported in Linux, with a
matching Device Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../bindings/dma/allwinner,sun4i-a10-dma.yaml | 55 +++++++++++++++++++
 .../devicetree/bindings/dma/sun4i-dma.txt     | 45 ---------------
 2 files changed, 55 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
new file mode 100644
index 000000000000..15abc0f9429f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/allwinner,sun4i-a10-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 DMA Controller Device Tree Bindings
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
+    const: 2
+    description:
+      The first cell is either 0 or 1, the former to use the normal
+      DMA, 1 for dedicated DMA. The second cell is the request line
+      number.
+
+  compatible:
+    const: allwinner,sun4i-a10-dma
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
+required:
+  - "#dma-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    dma: dma-controller@1c02000 {
+        compatible = "allwinner,sun4i-a10-dma";
+        reg = <0x01c02000 0x1000>;
+        interrupts = <27>;
+        clocks = <&ahb_gates 6>;
+        #dma-cells = <2>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/sun4i-dma.txt b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
deleted file mode 100644
index 8ad556aca70b..000000000000
--- a/Documentation/devicetree/bindings/dma/sun4i-dma.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Allwinner A10 DMA Controller
-
-This driver follows the generic DMA bindings defined in dma.txt.
-
-Required properties:
-
-- compatible:	Must be "allwinner,sun4i-a10-dma"
-- reg:		Should contain the registers base address and length
-- interrupts:	Should contain a reference to the interrupt used by this device
-- clocks:	Should contain a reference to the parent AHB clock
-- #dma-cells :	Should be 2, first cell denoting normal or dedicated dma,
-		second cell holding the request line number.
-
-Example:
-	dma: dma-controller@1c02000 {
-		compatible = "allwinner,sun4i-a10-dma";
-		reg = <0x01c02000 0x1000>;
-		interrupts = <27>;
-		clocks = <&ahb_gates 6>;
-		#dma-cells = <2>;
-	};
-
-Clients:
-
-DMA clients connected to the Allwinner A10 DMA controller must use the
-format described in the dma.txt file, using a three-cell specifier for
-each channel: a phandle plus two integer cells.
-The three cells in order are:
-
-1. A phandle pointing to the DMA controller.
-2. Whether it is using normal (0) or dedicated (1) channels
-3. The port ID as specified in the datasheet
-
-Example:
-	spi2: spi@1c17000 {
-		compatible = "allwinner,sun4i-a10-spi";
-		reg = <0x01c17000 0x1000>;
-		interrupts = <0 12 4>;
-		clocks = <&ahb_gates 22>, <&spi2_clk>;
-		clock-names = "ahb", "mod";
-		dmas = <&dma 1 29>, <&dma 1 28>;
-		dma-names = "rx", "tx";
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-- 
2.21.0

