Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B44B9C80
	for <lists+dmaengine@lfdr.de>; Thu, 17 Feb 2022 10:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiBQJxG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Feb 2022 04:53:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiBQJxF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Feb 2022 04:53:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E567B56E;
        Thu, 17 Feb 2022 01:52:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 362A61F40E62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645091570;
        bh=8+3/okjkZLSEe2YaUM/Pojm7bjbRNZ9YE8jw4vsEZBs=;
        h=From:To:Cc:Subject:Date:From;
        b=BQKqe6xe80UowaRFWaHdwUaOj09S4iONkRwTfSgSX28NEhpl9l/Evh7i/IGBq98/2
         hJ7WJAvriFTkjlE75SHagd7zFRd7HuTdFMB5/Oeq12J0KTLflWdhqQxKS3ZZaEhzNV
         eJFFO3monUiy45kmqSu2gAidLilnkJg3djlTZo5KRCAuAdZo8rezoNqFE8r5o6YCWn
         FigAKymenOZHQaNvfiIOyjlNGHniO4iMl4+wT8ajjUCaubX86o6Qt6GC1z0rebEIxN
         1mGfxgdxtiz0wc9CwE5ES/ZyCE8uMmanye7pXcwzS9IN+/VvTlNvtClRgNUmYbOIzD
         xs+Mu7p+HXTtA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     vkoul@kernel.org
Cc:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        long.cheng@mediatek.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3] dt-bindings: dma: Convert mtk-uart-apdma to DT schema
Date:   Thu, 17 Feb 2022 10:52:42 +0100
Message-Id: <20220217095242.13761-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the MediaTek UART APDMA Controller binding to DT schema.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v3: Removed anyOf condition
v2: Fixed interrupt maxItems to 16, added interrupts/reg maxItems constraint
    to 8 when the dma-requests property is not present

 .../bindings/dma/mediatek,uart-dma.yaml       | 122 ++++++++++++++++++
 .../bindings/dma/mtk-uart-apdma.txt           |  56 --------
 2 files changed, 122 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt

diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
new file mode 100644
index 000000000000..54d68fc688b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/mediatek,uart-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek UART APDMA controller
+
+maintainers:
+  - Long Cheng <long.cheng@mediatek.com>
+
+description: |
+  The MediaTek UART APDMA controller provides DMA capabilities
+  for the UART peripheral bus.
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2712-uart-dma
+              - mediatek,mt8516-uart-dma
+          - const: mediatek,mt6577-uart-dma
+      - enum:
+          - mediatek,mt6577-uart-dma
+
+  reg:
+    minItems: 1
+    maxItems: 16
+
+  interrupts:
+    description: |
+      TX, RX interrupt lines for each UART APDMA channel
+    minItems: 1
+    maxItems: 16
+
+  clocks:
+    description: Must contain one entry for the APDMA main clock
+    maxItems: 1
+
+  clock-names:
+    const: apdma
+
+  "#dma-cells":
+    const: 1
+    description: |
+      The first cell specifies the UART APDMA channel number
+
+  dma-requests:
+    description: |
+      Number of virtual channels of the UART APDMA controller
+    maximum: 16
+
+  mediatek,dma-33bits:
+    type: boolean
+    description: Enable 33-bits UART APDMA support
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+if:
+  not:
+    required:
+      - dma-requests
+then:
+  properties:
+    interrupts:
+      maxItems: 8
+    reg:
+      maxItems: 8
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt2712-clk.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        apdma: dma-controller@11000400 {
+            compatible = "mediatek,mt2712-uart-dma",
+                         "mediatek,mt6577-uart-dma";
+            reg = <0 0x11000400 0 0x80>,
+                  <0 0x11000480 0 0x80>,
+                  <0 0x11000500 0 0x80>,
+                  <0 0x11000580 0 0x80>,
+                  <0 0x11000600 0 0x80>,
+                  <0 0x11000680 0 0x80>,
+                  <0 0x11000700 0 0x80>,
+                  <0 0x11000780 0 0x80>,
+                  <0 0x11000800 0 0x80>,
+                  <0 0x11000880 0 0x80>,
+                  <0 0x11000900 0 0x80>,
+                  <0 0x11000980 0 0x80>;
+            interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
+                         <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
+            dma-requests = <12>;
+            clocks = <&pericfg CLK_PERI_AP_DMA>;
+            clock-names = "apdma";
+            mediatek,dma-33bits;
+            #dma-cells = <1>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
deleted file mode 100644
index fef9c1eeb264..000000000000
--- a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Mediatek UART APDMA Controller
-
-Required properties:
-- compatible should contain:
-  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
-  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
-  * "mediatek,mt8516-uart-dma", "mediatek,mt6577" for MT8516 SoC
-
-- reg: The base address of the APDMA register bank.
-
-- interrupts: A single interrupt specifier.
- One interrupt per dma-requests, or 8 if no dma-requests property is present
-
-- dma-requests: The number of DMA channels
-
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: The APDMA clock for register accesses
-
-- mediatek,dma-33bits: Present if the DMA requires support
-
-Examples:
-
-	apdma: dma-controller@11000400 {
-		compatible = "mediatek,mt2712-uart-dma",
-			     "mediatek,mt6577-uart-dma";
-		reg = <0 0x11000400 0 0x80>,
-		      <0 0x11000480 0 0x80>,
-		      <0 0x11000500 0 0x80>,
-		      <0 0x11000580 0 0x80>,
-		      <0 0x11000600 0 0x80>,
-		      <0 0x11000680 0 0x80>,
-		      <0 0x11000700 0 0x80>,
-		      <0 0x11000780 0 0x80>,
-		      <0 0x11000800 0 0x80>,
-		      <0 0x11000880 0 0x80>,
-		      <0 0x11000900 0 0x80>,
-		      <0 0x11000980 0 0x80>;
-		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
-		dma-requests = <12>;
-		clocks = <&pericfg CLK_PERI_AP_DMA>;
-		clock-names = "apdma";
-		mediatek,dma-33bits;
-		#dma-cells = <1>;
-	};
-- 
2.33.1

