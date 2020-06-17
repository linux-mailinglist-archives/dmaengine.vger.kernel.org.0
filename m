Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA1A1FC89D
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 10:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFQI3Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 04:29:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:18653 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQI3W (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 04:29:22 -0400
IronPort-SDR: DB+5Aa5g8/sJ2Nb2ccI4pPP/B/OVPRyx/Z/FbfKmREcDn7nLvxMvbmdZgX4B+yVovqsO5Ped9b
 a05b2Yma0uIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 01:26:20 -0700
IronPort-SDR: Mp2xsIaIQSkZzEdNBNm5vaGOyt46g6bHR4ozOchaTpyJcDDiV6JGcN2ZTb8NOdsj2jqXsuGVnq
 B9cpbOlupN9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="450158045"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2020 01:26:17 -0700
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, malliamireddy009@gmail.com,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>
Subject: [PATCH v2 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Date:   Wed, 17 Jun 2020 16:24:29 +0800
Message-Id: <16bcb25a3e8b9c768cd4157f1b5eaa423a7f844d.1592381244.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
In-Reply-To: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1592381244.git.mallikarjunax.reddy@linux.intel.com>
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
---
 .../devicetree/bindings/dma/intel,ldma.yaml        | 428 +++++++++++++++++++++
 1 file changed, 428 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
new file mode 100644
index 000000000000..d474c3e47126
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -0,0 +1,428 @@
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
+properties:
+ $nodename:
+   pattern: "^dma(@.*)?$"
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
+   - const: intel,lgm-toe_dma30
+   - const: intel,lgm-toe_dma31
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
+ intel,dma-txendi:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+       DMA TX endianness conversion due to SoC endianness difference.
+
+ intel,dma-rxendi:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+       DMA RX endianness conversion due to SoC endianness difference.
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
+            intel,port-name:
+              $ref: /schemas/types.yaml#definitions/string-array
+              description:
+                 Port name of each DMA port.
+
+            intel,port-chans:
+              $ref: /schemas/types.yaml#/definitions/uint32-array
+              description:
+                 The channels included on this port. Format is channel start
+                 number and how many channels on this port.
+
+            intel,port-burst:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Specify the DMA port burst size, the valid value will be
+                 2, 4, 8. Default is 2 for data path dma.
+
+            intel,port-txwgt:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Specify the port transmit weight for QoS purpose. The valid
+                 value is 1~7. Default value is 1.
+
+            intel,port-endian:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Specify the DMA port endiannes conversion due to SoC endianness difference.
+
+          required:
+            - reg
+            - intel,port-name
+            - intel,port-chans
+
+
+ dma-channels:
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
+      "^dma-channels@[0-9]+$":
+          type: object
+
+          properties:
+            reg:
+              items:
+                - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
+              description:
+                 Which channel this node refers to.
+
+            intel,chan-desc_num:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel maximum descriptor number. The max value is 255.
+
+            intel,chan-pkt_sz:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Channel buffer packet size. It must be power of 2.
+                 The maximum size is 4096.
+
+            intel,chan-desc-rx-nonpost:
+              type: boolean
+              description:
+                 Write non-posted type for DMA RX last data beat of every descriptor.
+
+            intel,chan-data-endian:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel data endianness configuration according to SoC requirement.
+
+            intel,chan-desc-endian:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel descriptor endianness configuration according to SoC requirement.
+
+            intel,chan-data-endian-en:
+              type: boolean
+              description:
+                 Per channel data endianness enabled.
+
+            intel,chan-desc-endian-en:
+              type: boolean
+              description:
+                 Per channel descriptor endianness enabled.
+
+            intel,chan-byte-offset:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel byte offset(0~128).
+
+            intel,chan-hdr-mode:
+              $ref: /schemas/types.yaml#/definitions/uint32-array
+              description:
+                 The first parameter is header mode size, the second
+                 parameter is checksum enable or disable. If enabled,
+                 header mode size is ignored. If disabled, header mode
+                 size must be provided.
+
+            intel,chan-non-arb-cnt:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel non arbitration counter while polling
+
+            intel,chan-arb-cnt:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel arbitration counter while polling.
+                 arb_cnt must be greater than non_arb_cnt
+
+            intel,chan-pkt-drop:
+              type: boolean
+              description:
+                 Channel packet drop enabled or disabled.
+
+            intel,chan-hw-desc:
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
+   dma0: dma@e0e00000 {
+     compatible = "intel,lgm-cdma";
+     reg = <0xe0e00000 0x1000>;
+     #dma-cells = <1>;
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
+           intel,port-name = "SPI0";
+           intel,port-chans = <0 2>;
+           intel,port-burst = <2>;
+           intel,port-txwgt = <1>;
+       };
+       dma-ports@1 {
+           reg = <1>;
+           intel,port-name = "SPI1";
+           intel,port-chans = <2 2>;
+           intel,port-burst = <2>;
+           intel,port-txwgt = <1>;
+       };
+       dma-ports@2 {
+           reg = <2>;
+           intel,port-name = "SPI2";
+           intel,port-chans = <4 2>;
+           intel,port-burst = <2>;
+           intel,port-txwgt = <1>;
+       };
+       dma-ports@3 {
+           reg = <3>;
+           intel,port-name = "SPI3";
+           intel,port-chans = <6 2>;
+           intel,port-burst = <2>;
+           intel,port-endian = <0>;
+           intel,port-txwgt = <1>;
+       };
+       dma-ports@4 {
+           reg = <4>;
+           intel,port-name = "HSNAND";
+           intel,port-chans = <8 2>;
+           intel,port-burst = <8>;
+           intel,port-txwgt = <1>;
+       };
+       dma-ports@5 {
+           reg = <5>;
+           intel,port-name = "PCM";
+           intel,port-chans = <10 6>;
+           intel,port-burst = <8>;
+           intel,port-txwgt = <1>;
+       };
+     };
+     dma-channels {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       dma-channels@0 {
+           reg = <0>;
+           intel,chan-desc_num = <1>;
+       };
+       dma-channels@1 {
+           reg = <1>;
+           intel,chan-desc_num = <1>;
+       };
+       dma-channels@2 {
+           reg = <2>;
+           intel,chan-desc_num = <1>;
+       };
+       dma-channels@3 {
+           reg = <3>;
+           intel,chan-desc_num = <1>;
+       };
+       dma-channels@4 {
+           reg = <4>;
+           intel,chan-desc_num = <1>;
+       };
+       dma-channels@5 {
+           reg = <5>;
+           intel,chan-desc_num = <1>;
+       };
+       dma-channels@6 {
+           reg = <6>;
+           intel,chan-desc_num = <1>;
+       };
+       dma-channels@7 {
+           reg = <7>;
+           intel,chan-desc_num = <1>;
+       };
+       dma-channels@8 {
+           reg = <8>;
+       };
+       dma-channels@9 {
+           reg = <9>;
+       };
+       dma-channels@10 {
+           reg = <10>;
+       };
+       dma-channels@11 {
+           reg = <11>;
+       };
+       dma-channels@12 {
+           reg = <12>;
+       };
+       dma-channels@13 {
+           reg = <13>;
+       };
+       dma-channels@14 {
+           reg = <14>;
+       };
+       dma-channels@15 {
+           reg = <15>;
+       };
+     };
+   };
+ - |
+   dma3: dma@ec800000 {
+     compatible = "intel,lgm-dma3";
+     reg = <0xec800000 0x1000>;
+     clocks = <&cgu0 71>;
+     resets = <&rcu0 0x10 9>;
+     #dma-cells = <1>;
+     intel,dma-burst = <32>;
+     intel,dma-polling-cnt = <16>;
+     intel,dma-desc-in-sram;
+     intel,dma-orrc = <16>;
+     intel,dma-byte-en;
+     intel,dma-txendi = <0>;
+     intel,dma-rxendi = <0>;
+     intel,dma-dburst-wr;
+     dma-channels {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         dma-channels@12 {
+             reg = <12>;
+             intel,chan-pkt_sz = <4096>;
+             intel,chan-desc-rx-nonpost;
+             intel,chan-data-endian = <0>;
+             intel,chan-desc-endian = <0>;
+             intel,chan-data-endian-en;
+             intel,chan-desc-endian-en;
+             intel,chan-byte-offset = <0>;
+             intel,chan-hdr-mode = <128 0>;
+             intel,chan-non-arb-cnt = <0>;
+             intel,chan-arb-cnt = <0>;
+             intel,chan-hw-desc = <0x20000000 8>;
+         };
+         dma-channels@13 {
+             reg = <13>;
+             intel,chan-pkt-drop;
+             intel,chan-pkt_sz = <4096>;
+             intel,chan-data-endian = <0>;
+             intel,chan-desc-endian = <0>;
+             intel,chan-data-endian-en;
+             intel,chan-desc-endian-en;
+             intel,chan-byte-offset = <0>;
+             intel,chan-hdr-mode = <128 0>;
+             intel,chan-non-arb-cnt = <0>;
+             intel,chan-arb-cnt = <0>;
+         };
+     };
+   };
-- 
2.11.0

