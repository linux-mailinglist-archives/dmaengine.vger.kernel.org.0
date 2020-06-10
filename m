Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29F1F546B
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2020 14:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgFJMTk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jun 2020 08:19:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:46454 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbgFJMTk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Jun 2020 08:19:40 -0400
IronPort-SDR: d68Jey18RF7MoXeypSiWoMaiaPL8ihvTHWwmOPNDESMBK5XGApPgwFl1G3NsRXMcp8Do5ZVkZm
 +5mHkcssN9fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:19:37 -0700
IronPort-SDR: IQ2k9hAr3oIbOOso4ryQ5JF9Jsf46THfag1i4TVbIiXIhNf5ESR6EiQPFMIKPBDEM+bFFm9mbh
 ScN4fFOSUpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,495,1583222400"; 
   d="scan'208";a="380044316"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2020 05:19:35 -0700
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, malliamireddy009@gmail.com,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>
Subject: [PATCH 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Date:   Wed, 10 Jun 2020 20:17:55 +0800
Message-Id: <55a58a87e1265ac8aabb4191385dbb42d5c49c14.1591790337.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1591790337.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1591790337.git.mallikarjunax.reddy@linux.intel.com>
In-Reply-To: <cover.1591790337.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1591790337.git.mallikarjunax.reddy@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT bindings YAML schema for DMA controller driver
of Lightning Mountain(LGM) SoC.

Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
---
 .../devicetree/bindings/dma/intel,ldma.yaml        | 428 +++++++++++++++++++++
 1 file changed, 428 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
new file mode 100644
index 0000000000000..cd59b452206fc
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
+  items:
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
+            port,name:
+              $ref: /schemas/types.yaml#definitions/string-array
+              description:
+                 Port name of each DMA port.
+
+            port,chans:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 The channels included on this port. Format is channel start
+                 number and how many channels on this port.
+
+            port,burst:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Specify the DMA port burst size, the valid value will be
+                 2, 4, 8. Default is 2 for data path dma.
+
+            port,txwgt:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Specify the port transmit weight for QoS purpose. The valid
+                 value is 1~7. Default value is 1.
+
+            port,endian:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Specify the DMA port endiannes conversion due to SoC endianness difference.
+
+          required:
+            - reg
+            - port,name
+            - port,chans
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
+                - enum: [0, 1, 2, 3, 4, 5, 6, 7]
+              description:
+                 Which channel this node refers to.
+
+            chan,desc_num:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel maximum descriptor number. The max value is 255.
+
+            chan,pkt-sz:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Channel buffer packet size. It must be power of 2.
+                 The maximum size is 4096.
+
+            chan,desc-rx-nonpost:
+              type: boolean
+              description:
+                 Write non-posted type for DMA RX last data beat of every descriptor.
+
+            chan,data-endian:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel data endianness configuration according to SoC requirement.
+
+            chan,desc-endian:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel descriptor endianness configuration according to SoC requirement.
+
+            chan,data-endian-en:
+              type: boolean
+              description:
+                 Per channel data endianness enabled.
+
+            chan,desc-endian-en:
+              type: boolean
+              description:
+                 Per channel descriptor endianness enabled.
+
+            chan,byte-offset:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel byte offset(0~128).
+
+            chan,hdr-mode:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 The first parameter is header mode size, the second
+                 parameter is checksum enable or disable. If enabled,
+                 header mode size is ignored. If disabled, header mode
+                 size must be provided.
+
+            chan,non-arb-cnt:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel non arbitration counter while polling
+
+            chan,arb-cnt:
+              $ref: /schemas/types.yaml#/definitions/uint32
+              description:
+                 Per channel arbitration counter while polling.
+                 arb_cnt must be greater than non_arb_cnt
+
+            chan,pkt-drop:
+              type: boolean
+              description:
+                 Channel packet drop enabled or disabled.
+
+            chan,hw-desc:
+              $ref: /schemas/types.yaml#/definitions/uint32
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
+     dma,ports {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       dma-ports@0 {
+           reg = <0>;
+           port,name = "SPI0";
+           port,chans = <0 2>;
+           port,burst = <2>;
+           port,txwgt = <1>;
+       };
+       dma-ports@1 {
+           reg = <1>;
+           port,name = "SPI1";
+           port,chans = <2 2>;
+           port,burst = <2>;
+           port,txwgt = <1>;
+       };
+       dma-ports@2 {
+           reg = <2>;
+           port,name = "SPI2";
+           port,chans = <4 2>;
+           port,burst = <2>;
+           port,txwgt = <1>;
+       };
+       dma-ports@3 {
+           reg = <3>;
+           port,name = "SPI3";
+           port,chans = <6 2>;
+           port,burst = <2>;
+           port,endian = <0>;
+           port,txwgt = <1>;
+       };
+       dma-ports@4 {
+           reg = <4>;
+           port,name = "HSNAND";
+           port,chans = <8 2>;
+           port,burst = <8>;
+           port,txwgt = <1>;
+       };
+       dma-ports@5 {
+           reg = <5>;
+           port,name = "PCM";
+           port,chans = <10 6>;
+           port,burst = <8>;
+           port,txwgt = <1>;
+       };
+     };
+     dma,channels {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       dma-channels@0 {
+           reg = <0>;
+           chan,desc_num = <1>;
+       };
+       dma-channels@1 {
+           reg = <1>;
+           chan,desc_num = <1>;
+       };
+       dma-channels@2 {
+           reg = <2>;
+           chan,desc_num = <1>;
+       };
+       dma-channels@3 {
+           reg = <3>;
+           chan,desc_num = <1>;
+       };
+       dma-channels@4 {
+           reg = <4>;
+           chan,desc_num = <1>;
+       };
+       dma-channels@5 {
+           reg = <5>;
+           chan,desc_num = <1>;
+       };
+       dma-channels@6 {
+           reg = <6>;
+           chan,desc_num = <1>;
+       };
+       dma-channels@7 {
+           reg = <7>;
+           chan,desc_num = <1>;
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
+     dma,channels {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         dma-channels@12 {
+             reg = <12>;
+             chan,pkt-sz = <4096>;
+             chan,desc-rx-nonpost;
+             chan,data-endian = <0>;
+             chan,desc-endian = <0>;
+             chan,data-endian_en;
+             chan,desc-endian_en;
+             chan,byte-offset = <0>;
+             chan,hdr-mode = <128 0>;
+             chan,non-arb-cnt = <0>;
+             chan,arb-cnt = <0>;
+             chan,hw-desc = <0x20000000 8>;
+         };
+         dma-channels@13 {
+             reg = <13>;
+             chan,pkt-drop;
+             chan,pkt-sz = <4096>;
+             chan,data-endian = <0>;
+             chan,desc-endian = <0>;
+             chan,data-endian_en;
+             chan,desc-endian_en;
+             chan,byte-offset = <0>;
+             chan,hdr-mode = <128 0>;
+             chan,non-arb-cnt = <0>;
+             chan,arb-cnt = <0>;
+         };
+     };
+   };
-- 
2.11.0

