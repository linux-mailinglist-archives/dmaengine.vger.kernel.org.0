Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90D63A4151
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhFKLit (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 07:38:49 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:25640 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230514AbhFKLis (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 07:38:48 -0400
X-IronPort-AV: E=Sophos;i="5.83,265,1616425200"; 
   d="scan'208";a="84098790"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Jun 2021 20:36:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.121])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 35378401C57C;
        Fri, 11 Jun 2021 20:36:48 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: dma: Document RZ/G2L bindings
Date:   Fri, 11 Jun 2021 12:36:38 +0100
Message-Id: <20210611113642.18457-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document RZ/G2L DMAC bindings.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
new file mode 100644
index 000000000000..df54bd6ddfd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -0,0 +1,132 @@
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
+          - renesas,dmac-r9a07g044  # RZ/G2{L,LC}
+      - const: renesas,rz-dmac
+
+  reg:
+    items:
+      - description: Control and channel register block
+      - description: DMA extension resource selector block
+
+  interrupts:
+    maxItems: 17
+
+  interrupt-names:
+    maxItems: 17
+    items:
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
+  renesas,rz-dmac-slavecfg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      DMA configuration for a slave channel. Each channel must have an array of
+      3 items as below.
+      first item in the array is MID+RID
+      second item in the array is slave src or dst address
+      third item in the array is channel configuration value.
+    items:
+      minItems: 3
+      maxItems: 48
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
+        compatible = "renesas,dmac-r9a07g044",
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
+        renesas,rz-dmac-slavecfg = <0x255 0x10049C18 0x0011228>;
+    };
-- 
2.17.1

