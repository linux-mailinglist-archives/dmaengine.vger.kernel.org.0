Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1CF244480
	for <lists+dmaengine@lfdr.de>; Fri, 14 Aug 2020 07:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgHNF0Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Aug 2020 01:26:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:37286 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgHNF0Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Aug 2020 01:26:24 -0400
IronPort-SDR: pfTZTC2cemgowcTR6C9BMvyt9n9DeEh9q9UcY5P43I6+b01cadOj7FTLCm2FFF8waP7Ycv0MhR
 z9iwfvV37VEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="141985055"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="141985055"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 22:26:23 -0700
IronPort-SDR: 1vj2gHrnz3+0RfWVbjf3ufpj42/BO/TRyGVGRw3zRDpGaSqGJ/7gAXiD9U7N9OGxR7/enYVQni
 be6bbPYJHwng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="495624183"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2020 22:26:20 -0700
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, mallikarjunax.reddy@linux.intel.com,
        malliamireddy009@gmail.com
Subject: [PATCH v5 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Date:   Fri, 14 Aug 2020 13:26:09 +0800
Message-Id: <68c77fd2ffb477aa4a52a58f8a26bfb191d3c5d1.1597381889.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
In-Reply-To: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT bindings YAML schema for DMA controller driver
of Lightning Mountain(LGM) SoC.

Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
---
v1:
- Initial version.

v2:
- Fix bot errors.

v3:
- No change.

v4:
- Address Thomas langer comments
  - use node name pattern as dma-controller as in common binding.
  - Remove "_" (underscore) in instance name.
  - Remove "port-" and "chan-" in attribute name for both 'dma-ports' & 'dma-channels' child nodes.

v5:
- Moved some of the attributes in 'dma-ports' & 'dma-channels' child nodes to dma client/consumer side as cells in 'dmas' properties.
---
 .../devicetree/bindings/dma/intel,ldma.yaml        | 319 +++++++++++++++++++++
 1 file changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
new file mode 100644
index 000000000000..9beaf191a6de
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -0,0 +1,319 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lightning Mountain centralized low speed DMA and high speed DMA controllers.
+
+maintainers:
+  - chuanhua.lei@intel.com
+  - mallikarjunax.reddy@intel.com
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+ $nodename:
+   pattern: "^dma-controller(@.*)?$"
+
+ "#dma-cells":
+   const: 1
+
+ compatible:
+  anyOf:
+   - const: intel,lgm-cdma
+   - const: intel,lgm-dma2tx
+   - const: intel,lgm-dma1rx
+   - const: intel,lgm-dma1tx
+   - const: intel,lgm-dma0tx
+   - const: intel,lgm-dma3
+   - const: intel,lgm-toe-dma30
+   - const: intel,lgm-toe-dma31
+
+ reg:
+  maxItems: 1
+
+ clocks:
+  maxItems: 1
+
+ resets:
+  maxItems: 1
+
+ interrupts:
+  maxItems: 1
+
+ intel,dma-poll-cnt:
+   $ref: /schemas/types.yaml#definitions/uint32
+   description:
+     DMA descriptor polling counter. It may need fine tune according
+     to the system application scenario.
+
+ intel,dma-byte-en:
+   type: boolean
+   description:
+     DMA byte enable is only valid for DMA write(RX).
+     Byte enable(1) means DMA write will be based on the number of dwords
+     instead of the whole burst.
+
+ intel,dma-drb:
+    type: boolean
+    description:
+      DMA descriptor read back to make sure data and desc synchronization.
+
+ intel,dma-burst:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+       Specifiy the DMA burst size(in dwords), the valid value will be 8, 16, 32.
+       Default is 16 for data path dma, 32 is for memcopy DMA.
+
+ intel,dma-polling-cnt:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+       DMA descriptor polling counter. It may need fine tune according to
+       the system application scenario.
+
+ intel,dma-desc-in-sram:
+    type: boolean
+    description:
+       DMA descritpors in SRAM or not. Some old controllers descriptors
+       can be in DRAM or SRAM. The new ones are all in SRAM.
+
+ intel,dma-orrc:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+       DMA outstanding read counter. The maximum value is 16, and it may
+       need fine tune according to the system application scenarios.
+
+ intel,dma-dburst-wr:
+    type: boolean
+    description:
+       Enable RX dynamic burst write. It only applies to RX DMA and memcopy DMA.
+
+
+ dma-ports:
+    type: object
+    description:
+       This sub-node must contain a sub-node for each DMA port.
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^dma-ports@[0-9]+$":
+          type: object
+
+          properties:
+            reg:
+              items:
+                - enum: [0, 1, 2, 3, 4, 5]
+              description:
+                 Which port this node refers to.
+
+            intel,name:
+              $ref: /schemas/types.yaml#definitions/string-array
+              description:
+                 Port name of each DMA port.
+
+            intel,chans:
+              $ref: /schemas/types.yaml#/definitions/uint32-array
+              description:
+                 The channels included on this port. Format is channel start
+                 number and how many channels on this port.
+
+          required:
+            - reg
+            - intel,name
+            - intel,chans
+
+
+ ldma-channels:
+    type: object
+    description:
+       This sub-node must contain a sub-node for each DMA channel.
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^ldma-channels@[0-15]+$":
+          type: object
+
+          properties:
+            reg:
+              items:
+                - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
+              description:
+                 Which channel this node refers to.
+
+            intel,desc_num:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel maximum descriptor number. The max value is 255.
+
+            intel,hdr-mode:
+              $ref: /schemas/types.yaml#/definitions/uint32-array
+              description:
+                 The first parameter is header mode size, the second
+                 parameter is checksum enable or disable. If enabled,
+                 header mode size is ignored. If disabled, header mode
+                 size must be provided.
+
+            intel,hw-desc:
+              $ref: /schemas/types.yaml#/definitions/uint32-array
+              description:
+                 Per channel dma hardware descriptor configuration.
+                 The first parameter is descriptor physical address and the
+                 second parameter hardware descriptor number.
+
+          required:
+            - reg
+
+required:
+ - compatible
+ - reg
+ - '#dma-cells'
+
+examples:
+ - |
+   dma0: dma-controller@e0e00000 {
+     compatible = "intel,lgm-cdma";
+     reg = <0xe0e00000 0x1000>;
+     #dma-cells = <3>;
+     interrupt-parent = <&ioapic1>;
+     interrupts = <82 1>;
+     resets = <&rcu0 0x30 0>;
+     reset-names = "ctrl";
+     clocks = <&cgu0 80>;
+     intel,dma-poll-cnt = <4>;
+     intel,dma-byte-en;
+     intel,dma-drb;
+     dma-ports {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       dma-ports@0 {
+           reg = <0>;
+           intel,name = "SPI0";
+           intel,chans = <0 2>;
+       };
+       dma-ports@1 {
+           reg = <1>;
+           intel,name = "SPI1";
+           intel,chans = <2 2>;
+       };
+       dma-ports@2 {
+           reg = <2>;
+           intel,name = "SPI2";
+           intel,chans = <4 2>;
+       };
+       dma-ports@3 {
+           reg = <3>;
+           intel,name = "SPI3";
+           intel,chans = <6 2>;
+       };
+       dma-ports@4 {
+           reg = <4>;
+           intel,name = "HSNAND";
+           intel,chans = <8 2>;
+       };
+       dma-ports@5 {
+           reg = <5>;
+           intel,name = "PCM";
+           intel,chans = <10 6>;
+       };
+     };
+     ldma-channels {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       ldma-channels@0 {
+           reg = <0>;
+           intel,desc_num = <1>;
+       };
+       ldma-channels@1 {
+           reg = <1>;
+           intel,desc_num = <1>;
+       };
+       ldma-channels@2 {
+           reg = <2>;
+           intel,desc_num = <1>;
+       };
+       ldma-channels@3 {
+           reg = <3>;
+           intel,desc_num = <1>;
+       };
+       ldma-channels@4 {
+           reg = <4>;
+           intel,desc_num = <1>;
+       };
+       ldma-channels@5 {
+           reg = <5>;
+           intel,desc_num = <1>;
+       };
+       ldma-channels@6 {
+           reg = <6>;
+           intel,desc_num = <1>;
+       };
+       ldma-channels@7 {
+           reg = <7>;
+           intel,desc_num = <1>;
+       };
+       ldma-channels@8 {
+           reg = <8>;
+       };
+       ldma-channels@9 {
+           reg = <9>;
+       };
+       ldma-channels@10 {
+           reg = <10>;
+       };
+       ldma-channels@11 {
+           reg = <11>;
+       };
+       ldma-channels@12 {
+           reg = <12>;
+       };
+       ldma-channels@13 {
+           reg = <13>;
+       };
+       ldma-channels@14 {
+           reg = <14>;
+       };
+       ldma-channels@15 {
+           reg = <15>;
+       };
+     };
+   };
+ - |
+   dma3: dma-controller@ec800000 {
+     compatible = "intel,lgm-dma3";
+     reg = <0xec800000 0x1000>;
+     clocks = <&cgu0 71>;
+     resets = <&rcu0 0x10 9>;
+     #dma-cells = <7>;
+     intel,dma-burst = <32>;
+     intel,dma-polling-cnt = <16>;
+     intel,dma-desc-in-sram;
+     intel,dma-orrc = <16>;
+     intel,dma-byte-en;
+     intel,dma-dburst-wr;
+     ldma-channels {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         ldma-channels@12 {
+             reg = <12>;
+             intel,hdr-mode = <128 0>;
+             intel,hw-desc = <0x20000000 8>;
+         };
+         ldma-channels@13 {
+             reg = <13>;
+             intel,hdr-mode = <128 0>;
+         };
+     };
+   };
-- 
2.11.0

