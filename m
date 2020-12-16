Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8642DB8F0
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 03:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgLPC1X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 21:27:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:43605 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgLPC1W (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Dec 2020 21:27:22 -0500
IronPort-SDR: YwEYUr9urhmDnX6WNVi5XENU2V1Bmzv4tcEsbrTLquXQAfnSciAOHsPT7yh/FLovP+EBgtyfGm
 +fd9nmdGkGYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="154220879"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="154220879"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 18:26:42 -0800
IronPort-SDR: pjHjZ1uyR+pOrY24RJ0yOnKJvImPrvV0TjSxU3RVFH8xzZh5PNFYawTTqUETthlI1wjGw/Pju+
 i0+GqEL4ACwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="557080676"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2020 18:26:40 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 01/16] dt-bindings: dma: Add YAML schemas for dw-axi-dmac
Date:   Wed, 16 Dec 2020 10:09:48 +0800
Message-Id: <20201216021003.26911-2-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216021003.26911-1-jee.heng.sia@intel.com>
References: <20201216021003.26911-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

YAML schemas Device Tree (DT) binding is the new format for DT to replace
the old format. Introduce YAML schemas DT binding for dw-axi-dmac and
remove the old version.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../bindings/dma/snps,dw-axi-dmac.txt         |  39 ------
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 121 ++++++++++++++++++
 2 files changed, 121 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
deleted file mode 100644
index dbe160400adc..000000000000
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Synopsys DesignWare AXI DMA Controller
-
-Required properties:
-- compatible: "snps,axi-dma-1.01a"
-- reg: Address range of the DMAC registers. This should include
-  all of the per-channel registers.
-- interrupt: Should contain the DMAC interrupt number.
-- dma-channels: Number of channels supported by hardware.
-- snps,dma-masters: Number of AXI masters supported by the hardware.
-- snps,data-width: Maximum AXI data width supported by hardware.
-  (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
-- snps,priority: Priority of channel. Array size is equal to the number of
-  dma-channels. Priority value must be programmed within [0:dma-channels-1]
-  range. (0 - minimum priority)
-- snps,block-size: Maximum block size supported by the controller channel.
-  Array size is equal to the number of dma-channels.
-
-Optional properties:
-- snps,axi-max-burst-len: Restrict master AXI burst length by value specified
-  in this property. If this property is missing the maximum AXI burst length
-  supported by DMAC is used. [1:256]
-
-Example:
-
-dmac: dma-controller@80000 {
-	compatible = "snps,axi-dma-1.01a";
-	reg = <0x80000 0x400>;
-	clocks = <&core_clk>, <&cfgr_clk>;
-	clock-names = "core-clk", "cfgr-clk";
-	interrupt-parent = <&intc>;
-	interrupts = <27>;
-
-	dma-channels = <4>;
-	snps,dma-masters = <2>;
-	snps,data-width = <3>;
-	snps,block-size = <4096 4096 4096 4096>;
-	snps,priority = <0 1 2 3>;
-	snps,axi-max-burst-len = <16>;
-};
diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
new file mode 100644
index 000000000000..3d2515463d56
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/snps,dw-axi-dmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare AXI DMA Controller
+
+maintainers:
+  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+
+description:
+  Synopsys DesignWare AXI DMA Controller DT Binding
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - snps,axi-dma-1.01a
+
+  reg:
+    items:
+      - description: Address range of the DMAC registers
+
+  reg-names:
+    items:
+      - const: axidma_ctrl_regs
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: core-clk
+      - const: cfgr-clk
+
+  '#dma-cells':
+    const: 1
+
+  dma-channels:
+    minimum: 1
+    maximum: 8
+
+  snps,dma-masters:
+    description: |
+      Number of AXI masters supported by the hardware.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+
+  snps,data-width:
+    description: |
+      AXI data width supported by hardware.
+      (0 - 8bits, 1 - 16bits, 2 - 32bits, ..., 6 - 512bits)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6]
+
+  snps,priority:
+    description: |
+      Channel priority specifier associated with the DMA channels.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+
+  snps,block-size:
+    description: |
+      Channel block size specifier associated with the DMA channels.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+
+  snps,axi-max-burst-len:
+    description: |
+      Restrict master AXI burst length by value specified in this property.
+      If this property is missing the maximum AXI burst length supported by
+      DMAC is used.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 256
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - '#dma-cells'
+  - dma-channels
+  - snps,dma-masters
+  - snps,data-width
+  - snps,priority
+  - snps,block-size
+
+additionalProperties: false
+
+examples:
+  - |
+     #include <dt-bindings/interrupt-controller/arm-gic.h>
+     #include <dt-bindings/interrupt-controller/irq.h>
+     /* example with snps,dw-axi-dmac */
+     dmac: dma-controller@80000 {
+         compatible = "snps,axi-dma-1.01a";
+         reg = <0x80000 0x400>;
+         clocks = <&core_clk>, <&cfgr_clk>;
+         clock-names = "core-clk", "cfgr-clk";
+         interrupt-parent = <&intc>;
+         interrupts = <27>;
+         #dma-cells = <1>;
+         dma-channels = <4>;
+         snps,dma-masters = <2>;
+         snps,data-width = <3>;
+         snps,block-size = <4096 4096 4096 4096>;
+         snps,priority = <0 1 2 3>;
+         snps,axi-max-burst-len = <16>;
+     };
-- 
2.18.0

