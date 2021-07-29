Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0543D9F79
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 10:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhG2IZc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 04:25:32 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:8856 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234795AbhG2IZb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Jul 2021 04:25:31 -0400
X-IronPort-AV: E=Sophos;i="5.84,278,1620658800"; 
   d="scan'208";a="89137507"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Jul 2021 17:25:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8239E4208669;
        Thu, 29 Jul 2021 17:25:25 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: dma: Document RZ/G2L bindings
Date:   Thu, 29 Jul 2021 09:25:18 +0100
Message-Id: <20210729082520.26186-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210729082520.26186-1-biju.das.jz@bp.renesas.com>
References: <20210729082520.26186-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document RZ/G2L DMAC bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note:-
 This base series for this patch is Linux 5.14-rc2(or +) otherwise bots would 
 complain about check failures

v4->v5:
  * Passing legacy slave channel configuration parameters using dmaengine_slave_config is prohibited.
    So started passing this parameters in DT instead, by encoding MID/RID values with channel parameters
    in the #dma-cells.
  * Updated the description for #dma-cells
  * Removed Rb tag's of Geert and Rob since there is a modification in binding patch
v3->v4:
  * Added Rob's Rb tag
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
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
new file mode 100644
index 000000000000..7a4f415d74dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -0,0 +1,130 @@
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
+      The cell specifies the encoded MID/RID values of the DMAC port
+      connected to the DMA client and the slave channel configuration
+      parameters.
+      bits[0:9] - Specifies MID/RID value
+      bit[10] - Specifies DMA request high enable (HIEN)
+      bit[11] - Specifies DMA request detection type (LVL)
+      bits[12:14] - Specifies DMAACK output mode (AM)
+      bit[15] - Specifies Transfer Mode (TM)
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

