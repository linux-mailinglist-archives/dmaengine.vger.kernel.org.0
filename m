Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FFA168E61
	for <lists+dmaengine@lfdr.de>; Sat, 22 Feb 2020 12:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgBVLVQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Feb 2020 06:21:16 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:29551 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgBVLVQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Feb 2020 06:21:16 -0500
X-Greylist: delayed 118522 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Feb 2020 06:21:14 EST
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 01MBKjen004488;
        Sat, 22 Feb 2020 20:20:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 01MBKjen004488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582370446;
        bh=Fm1qChr6ZbZLhdE3dP5bKvN2cnwWcGsLh5GHdABxVyE=;
        h=From:To:Cc:Subject:Date:From;
        b=tND51qjySwpbpvelT1nqARk2V3PBmw+G/91f5VL+7kQ8U6lzFvobKmL4ivpI3tTZR
         Y/OjJTFSMLPAggU5pvKARW8Xw3YdLeCQAwX/h3Vfob1Y6IAUMLe1pez7DeBazDmt1X
         m8Csj6062CPiy6sgOUKnB0K4EsShKp+mU9ISVC9ANX6ZxbImQovZcdEqqAGdqL2nUQ
         xIh1PYOOFIgKcttm1GxTOyRZNJibjW8xfol4nS+jy13eIBvzT9X5ke7ynxf8io/q6K
         baxH+4UFcdsw+llaa38eluyvX5mP5LGjwgzr+SPRdfhQ1+XavGSOnPLBwKMmyft4fZ
         ZP/EEdXZCwkBA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: dma: Convert UniPhier MIO DMA controller to json-schema
Date:   Sat, 22 Feb 2020 20:20:42 +0900
Message-Id: <20200222112042.32345-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the UniPhier MIO (Media I/O) DMA controller binding to DT
schema format.

While I was here, I added the resets property.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - add 'resets'

 .../dma/socionext,uniphier-mio-dmac.yaml      | 63 +++++++++++++++++++
 .../bindings/dma/uniphier-mio-dmac.txt        | 25 --------
 2 files changed, 63 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt

diff --git a/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
new file mode 100644
index 000000000000..e7bf6dd7da29
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/socionext,uniphier-mio-dmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UniPhier Media IO DMA controller
+
+description: |
+  This works as an external DMA engine for SD/eMMC controllers etc.
+  found in UniPhier LD4, Pro4, sLD8 SoCs.
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    const: socionext,uniphier-mio-dmac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      A list of interrupt specifiers associated with the DMA channels.
+      The number of interrupt lines is SoC-dependent.
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#dma-cells':
+    description: The single cell represents the channel index.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#dma-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    // In the example below, "interrupts = <0 68 4>, <0 68 4>, ..." is not a
+    // typo. The first two channels share a single interrupt line.
+
+    dmac: dma-controller@5a000000 {
+        compatible = "socionext,uniphier-mio-dmac";
+        reg = <0x5a000000 0x1000>;
+        interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+                     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
+        clocks = <&mio_clk 7>;
+        resets = <&mio_rst 7>;
+        #dma-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
deleted file mode 100644
index b12388dc7eac..000000000000
--- a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-UniPhier Media IO DMA controller
-
-This works as an external DMA engine for SD/eMMC controllers etc.
-found in UniPhier LD4, Pro4, sLD8 SoCs.
-
-Required properties:
-- compatible: should be "socionext,uniphier-mio-dmac".
-- reg: offset and length of the register set for the device.
-- interrupts: a list of interrupt specifiers associated with the DMA channels.
-- clocks: a single clock specifier.
-- #dma-cells: should be <1>. The single cell represents the channel index.
-
-Example:
-	dmac: dma-controller@5a000000 {
-		compatible = "socionext,uniphier-mio-dmac";
-		reg = <0x5a000000 0x1000>;
-		interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
-			     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
-		clocks = <&mio_clk 7>;
-		#dma-cells = <1>;
-	};
-
-Note:
-In the example above, "interrupts = <0 68 4>, <0 68 4>, ..." is not a typo.
-The first two channels share a single interrupt line.
-- 
2.17.1

