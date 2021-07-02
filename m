Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A753B9ECB
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jul 2021 12:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhGBKIK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jul 2021 06:08:10 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:47392 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231302AbhGBKIJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jul 2021 06:08:09 -0400
X-IronPort-AV: E=Sophos;i="5.83,316,1616425200"; 
   d="scan'208";a="86345572"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jul 2021 19:05:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5BD944010738;
        Fri,  2 Jul 2021 19:05:32 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: dma: Document RZ/G2L bindings
Date:   Fri,  2 Jul 2021 11:05:24 +0100
Message-Id: <20210702100527.28251-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210702100527.28251-1-biju.das.jz@bp.renesas.com>
References: <20210702100527.28251-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document RZ/G2L DMAC bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note:-  This patch has dependency on #include <dt-bindings/clock/r9a07g044-cpg.h> file which will be in 
next 5.14-rc1 release.

v3->v4:
  * Described clocks and reset properties
v2->v3:
  * Added error interrupt first.
  * Updated clock and reset maxitems.
  * Added Geert's Rb tag.
v1->v2:
  * Made interrupt names in defined order
  * Removed src address and channel configuration from dma-cells.
  * Changed the compatibele string to "renesas,r9a07g044-dmac".
v1:-
  * https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210611113642.18457-2-biju.das.jz@bp.renesas.com/
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
new file mode 100644
index 000000000000..31118f4707d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/renesas,rz-dmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L DMA Controller
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
+      - const: renesas,rz-dmac
+
+  reg:
+    items:
+      - description: Control and channel register block
+      - description: DMA extended resource selector block
+
+  interrupts:
+    maxItems: 17
+
+  interrupt-names:
+    items:
+      - const: error
+      - const: ch0
+      - const: ch1
+      - const: ch2
+      - const: ch3
+      - const: ch4
+      - const: ch5
+      - const: ch6
+      - const: ch7
+      - const: ch8
+      - const: ch9
+      - const: ch10
+      - const: ch11
+      - const: ch12
+      - const: ch13
+      - const: ch14
+      - const: ch15
+
+  clocks:
+    items:
+      - description: DMA main clock
+      - description: DMA register access clock
+
+  '#dma-cells':
+    const: 1
+    description:
+      The cell specifies the MID/RID of the DMAC port connected to
+      the DMA client.
+
+  dma-channels:
+    const: 16
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Reset for DMA ARESETN reset terminal
+      - description: Reset for DMA RST_ASYNC reset terminal
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - '#dma-cells'
+  - dma-channels
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    dmac: dma-controller@11820000 {
+        compatible = "renesas,r9a07g044-dmac",
+                     "renesas,rz-dmac";
+        reg = <0x11820000 0x10000>,
+              <0x11830000 0x10000>;
+        interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 126 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 127 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 131 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 132 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 133 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 135 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 137 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 138 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 139 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "error",
+                          "ch0", "ch1", "ch2", "ch3",
+                          "ch4", "ch5", "ch6", "ch7",
+                          "ch8", "ch9", "ch10", "ch11",
+                          "ch12", "ch13", "ch14", "ch15";
+        clocks = <&cpg CPG_MOD R9A07G044_DMAC_ACLK>,
+                 <&cpg CPG_MOD R9A07G044_DMAC_PCLK>;
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_DMAC_ARESETN>,
+                 <&cpg R9A07G044_DMAC_RST_ASYNC>;
+        #dma-cells = <1>;
+        dma-channels = <16>;
+    };
-- 
2.17.1

