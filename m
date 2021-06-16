Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871843A98EC
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFPLQj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 07:16:39 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:36685 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229546AbhFPLQj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Jun 2021 07:16:39 -0400
X-IronPort-AV: E=Sophos;i="5.83,277,1616425200"; 
   d="scan'208";a="84538440"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jun 2021 20:14:31 +0900
Received: from localhost.localdomain (unknown [10.226.93.117])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1356A421789D;
        Wed, 16 Jun 2021 20:14:28 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: dma: Document RZ/G2L bindings
Date:   Wed, 16 Jun 2021 11:55:57 +0100
Message-Id: <20210616105557.9321-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document RZ/G2L DMAC bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note:-  This patch has dependency on #include <dt-bindings/clock/r9a07g044-cpg.h> file which will be in 
next 5.14-rc1 release.

v1->v2:
  * Made interrupt names in defined order
  * Removed src address and channel configuration from dma-cells.
  * Changed the compatibele string to "renesas,r9a07g044-dmac".
  * 
v1:-
  * https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210611113642.18457-2-biju.das.jz@bp.renesas.com/
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
new file mode 100644
index 000000000000..0389050aadf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -0,0 +1,118 @@
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
+      - const: error
+
+  clocks:
+    maxItems: 1
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
+        interrupts = <GIC_SPI 125 IRQ_TYPE_EDGE_RISING>,
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
+                     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "ch0", "ch1", "ch2", "ch3",
+                          "ch4", "ch5", "ch6", "ch7",
+                          "ch8", "ch9", "ch10", "ch11",
+                          "ch12", "ch13", "ch14", "ch15",
+                          "error";
+        clocks = <&cpg CPG_MOD R9A07G044_CLK_DMAC>;
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_CLK_DMAC>;
+        #dma-cells = <1>;
+        dma-channels = <16>;
+    };
-- 
2.17.1

