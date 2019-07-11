Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92F7653E2
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2019 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfGKJeb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jul 2019 05:34:31 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54103 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKJeb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Jul 2019 05:34:31 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4BE8E1C002D;
        Thu, 11 Jul 2019 09:34:21 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: dma: Add YAML schemas for the generic DMA bindings
Date:   Thu, 11 Jul 2019 11:21:56 +0200
Message-Id: <20190711092158.14678-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controllers and consumers have a bunch of generic properties that
are needed in a device tree. Add a YAML schemas for those.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../devicetree/bindings/dma/dma-consumer.yaml |  60 +++++++++
 .../bindings/dma/dma-controller.yaml          |  79 ++++++++++++
 Documentation/devicetree/bindings/dma/dma.txt | 114 +-----------------
 3 files changed, 140 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/dma-controller.yaml

diff --git a/Documentation/devicetree/bindings/dma/dma-consumer.yaml b/Documentation/devicetree/bindings/dma/dma-consumer.yaml
new file mode 100644
index 000000000000..2f6315863ad1
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/dma-consumer.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/dma-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DMA Consumer Generic Binding
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+select: true
+
+properties:
+  dmas:
+    description:
+      List of one or more DMA specifiers, each consisting of
+          - A phandle pointing to DMA controller node
+          - A number of integer cells, as determined by the
+            \#dma-cells property in the node referenced by phandle
+            containing DMA controller specific information. This
+            typically contains a DMA request line number or a
+            channel number, but can contain any data that is
+            required for configuring a channel.
+
+  dma-names:
+    description:
+      Contains one identifier string for each DMA specifier in the
+      dmas property. The specific strings that can be used are defined
+      in the binding of the DMA client device.  Multiple DMA
+      specifiers can be used to represent alternatives and in this
+      case the dma-names for those DMA specifiers must be identical
+      (see examples).
+
+dependencies:
+  dma-names: [ dmas ]
+
+examples:
+  - |
+    /* A device with one DMA read channel, one DMA write channel */
+    i2c1: i2c@1 {
+         /* ... */
+         dmas = <&dma 2>, 	/* read channel */
+                <&dma 3>;	/* write channel */
+        dma-names = "rx", "tx";
+        /* ... */
+    };
+
+  - |
+    /* A single read-write channel with three alternative DMA controllers */
+    dmas = <&dma1 5>, <&dma2 7>, <&dma3 2>;
+    dma-names = "rx-tx", "rx-tx", "rx-tx";
+
+  - |
+    /* A device with three channels, one of which has two alternatives */
+    dmas = <&dma1 2>,		/* read channel */
+           <&dma1 3>,		/* write channel */
+           <&dma2 0>,		/* error read */
+           <&dma3 0>;		/* alternative error read */
+    dma-names = "rx", "tx", "error", "error";
diff --git a/Documentation/devicetree/bindings/dma/dma-controller.yaml b/Documentation/devicetree/bindings/dma/dma-controller.yaml
new file mode 100644
index 000000000000..17c650131b78
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/dma-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DMA Controller Generic Binding
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description:
+  Generic binding to provide a way for a driver using DMA Engine to
+  retrieve the DMA request or channel information that goes from a
+  hardware device to a DMA controller.
+
+properties:
+  $nodename:
+    pattern: "^dma-controller(@.*)?$"
+
+  "#dma-cells":
+    # minimum: 1
+    description:
+      Used to provide DMA controller specific information.
+
+  dma-channel-masks:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+      Bitmask of available DMA channels in ascending order that are
+      not reserved by firmware and are available to the
+      kernel. i.e. first channel corresponds to LSB.
+
+  dma-channels:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+      Number of DMA channels supported by the controller.
+
+  dma-masters:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+    description:
+      DMA routers are transparent IP blocks used to route DMA request
+      lines from devices to the DMA controller. Some SoCs (like TI
+      DRA7x) have more peripherals integrated with DMA requests than
+      what the DMA controller can handle directly.
+
+      In such a case, dma-masters is an array of phandle to the DMA
+      controllers the router can direct the signal to.
+
+  dma-requests:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+      Number of DMA request signals supported by the controller.
+
+examples:
+  - |
+    dma: dma@48000000 {
+        compatible = "ti,omap-sdma";
+        reg = <0x48000000 0x1000>;
+        interrupts = <0 12 0x4
+                      0 13 0x4
+                      0 14 0x4
+                      0 15 0x4>;
+        #dma-cells = <1>;
+        dma-channels = <32>;
+        dma-requests = <127>;
+        dma-channel-mask = <0xfffe>;
+    };
+
+  - |
+    sdma_xbar: dma-router@4a002b78 {
+        compatible = "ti,dra7-dma-crossbar";
+        reg = <0x4a002b78 0xfc>;
+        #dma-cells = <1>;
+        dma-requests = <205>;
+        ti,dma-safe-map = <0>;
+        dma-masters = <&sdma>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
index eeb4e4d1771e..90a67a016a48 100644
--- a/Documentation/devicetree/bindings/dma/dma.txt
+++ b/Documentation/devicetree/bindings/dma/dma.txt
@@ -1,113 +1 @@
-* Generic DMA Controller and DMA request bindings
-
-Generic binding to provide a way for a driver using DMA Engine to retrieve the
-DMA request or channel information that goes from a hardware device to a DMA
-controller.
-
-
-* DMA controller
-
-Required property:
-- #dma-cells: 		Must be at least 1. Used to provide DMA controller
-			specific information. See DMA client binding below for
-			more details.
-
-Optional properties:
-- dma-channels: 	Number of DMA channels supported by the controller.
-- dma-requests: 	Number of DMA request signals supported by the
-			controller.
-- dma-channel-mask:	Bitmask of available DMA channels in ascending order
-			that are not reserved by firmware and are available to
-			the kernel. i.e. first channel corresponds to LSB.
-
-Example:
-
-	dma: dma@48000000 {
-		compatible = "ti,omap-sdma";
-		reg = <0x48000000 0x1000>;
-		interrupts = <0 12 0x4
-			      0 13 0x4
-			      0 14 0x4
-			      0 15 0x4>;
-		#dma-cells = <1>;
-		dma-channels = <32>;
-		dma-requests = <127>;
-		dma-channel-mask = <0xfffe>
-	};
-
-* DMA router
-
-DMA routers are transparent IP blocks used to route DMA request lines from
-devices to the DMA controller. Some SoCs (like TI DRA7x) have more peripherals
-integrated with DMA requests than what the DMA controller can handle directly.
-
-Required property:
-- dma-masters:		phandle of the DMA controller or list of phandles for
-			the DMA controllers the router can direct the signal to.
-- #dma-cells: 		Must be at least 1. Used to provide DMA router specific
-			information. See DMA client binding below for more
-			details.
-
-Optional properties:
-- dma-requests: 	Number of incoming request lines the router can handle.
-- In the node pointed by the dma-masters:
-	- dma-requests:	The router driver might need to look for this in order
-			to configure the routing.
-
-Example:
-	sdma_xbar: dma-router@4a002b78 {
-		compatible = "ti,dra7-dma-crossbar";
-		reg = <0x4a002b78 0xfc>;
-		#dma-cells = <1>;
-		dma-requests = <205>;
-		ti,dma-safe-map = <0>;
-		dma-masters = <&sdma>;
-	};
-
-* DMA client
-
-Client drivers should specify the DMA property using a phandle to the controller
-followed by DMA controller specific data.
-
-Required property:
-- dmas:			List of one or more DMA specifiers, each consisting of
-			- A phandle pointing to DMA controller node
-			- A number of integer cells, as determined by the
-			  #dma-cells property in the node referenced by phandle
-			  containing DMA controller specific information. This
-			  typically contains a DMA request line number or a
-			  channel number, but can contain any data that is
-			  required for configuring a channel.
-- dma-names: 		Contains one identifier string for each DMA specifier in
-			the dmas property. The specific strings that can be used
-			are defined in the binding of the DMA client device.
-			Multiple DMA specifiers can be used to represent
-			alternatives and in this case the dma-names for those
-			DMA specifiers must be identical (see examples).
-
-Examples:
-
-1. A device with one DMA read channel, one DMA write channel:
-
-	i2c1: i2c@1 {
-		...
-		dmas = <&dma 2		/* read channel */
-			&dma 3>;	/* write channel */
-		dma-names = "rx", "tx";
-		...
-	};
-
-2. A single read-write channel with three alternative DMA controllers:
-
-	dmas = <&dma1 5
-		&dma2 7
-		&dma3 2>;
-	dma-names = "rx-tx", "rx-tx", "rx-tx";
-
-3. A device with three channels, one of which has two alternatives:
-
-	dmas = <&dma1 2			/* read channel */
-		&dma1 3			/* write channel */
-		&dma2 0			/* error read */
-		&dma3 0>;		/* alternative error read */
-	dma-names = "rx", "tx", "error", "error";
+This file has been moved to dma-controller.yaml.
-- 
2.21.0

