Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2E2ABE54
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgKIOOg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 09:14:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:51663 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbgKIOOg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 09:14:36 -0500
IronPort-SDR: F9NhAy30VITp2OG4xHmJuTWljUKBMvBffKeC7nuZGYC+BpIVf6Hkdp9orBnxquX9FHp/+T5Lu1
 gzG96c5Csffg==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="187758536"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="187758536"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 06:14:35 -0800
IronPort-SDR: oVPDxXTl7XKMRwAgHLPDMFqDcDF7oSficSto+ZaxiE83zM4CeJn8Wx+mpbNp56OmvI8kXYS8EE
 otq2NAYse63A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="307996353"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga007.fm.intel.com with ESMTP; 09 Nov 2020 06:14:32 -0800
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, mallikarjunax.reddy@linux.intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
Subject: [PATCH v8 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Date:   Mon,  9 Nov 2020 22:14:24 +0800
Message-Id: <b06793aa409d05ac7e0729bcd2002c43ff25d48b.1604930089.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1604930089.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1604930089.git.mallikarjunax.reddy@linux.intel.com>
In-Reply-To: <cover.1604930089.git.mallikarjunax.reddy@linux.intel.com>
References: <cover.1604930089.git.mallikarjunax.reddy@linux.intel.com>
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

v6:
- Add additionalProperties: false
- completely removed 'dma-ports' and 'dma-channels' child nodes.
- Moved channel dt properties to client side dmas.
- Use standard dma-channels and dma-channel-mask properties.
- Documented reset-names
- Add description for dma-cells

v7:
- modified compatible to oneof
- Reduced number of dma-cells to 3
- Fine tune the description of some properties.

v7-resend:
- rebase to 5.10-rc1

v8:
- rebased to 5.10-rc3
- Fixing the bot issues (wrong indentation)
---
 .../devicetree/bindings/dma/intel,ldma.yaml        | 134 +++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/intel,ldma.yaml

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
new file mode 100644
index 000000000000..7cf0eab1a703
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -0,0 +1,134 @@
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
+  $nodename:
+    pattern: "^dma-controller(@.*)?$"
+
+  compatible:
+    oneOf:
+      - const: intel,lgm-cdma
+      - const: intel,lgm-dma2tx
+      - const: intel,lgm-dma1rx
+      - const: intel,lgm-dma1tx
+      - const: intel,lgm-dma0tx
+      - const: intel,lgm-dma3
+      - const: intel,lgm-toe-dma30
+      - const: intel,lgm-toe-dma31
+
+  reg:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 3
+    description:
+      The first cell is the peripheral's DMA request line.
+      The second cell is the peripheral's (port) number corresponding to the channel.
+      The third cell is the burst length of the channel.
+
+  dma-channels:
+    minimum: 1
+    maximum: 16
+
+  dma-channel-mask:
+    items:
+      minItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: ctrl
+
+  interrupts:
+    maxItems: 1
+
+  intel,dma-poll-cnt:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+      DMA descriptor polling counter is used to control the poling mechanism
+      for the descriptor fetching for all channels.
+
+  intel,dma-byte-en:
+    type: boolean
+    description:
+      DMA byte enable is only valid for DMA write(RX).
+      Byte enable(1) means DMA write will be based on the number of dwords
+      instead of the whole burst.
+
+  intel,dma-drb:
+    type: boolean
+    description:
+      DMA descriptor read back to make sure data and desc synchronization.
+
+  intel,dma-desc-in-sram:
+    type: boolean
+    description:
+      DMA descritpors in SRAM or not. Some old controllers descriptors
+      can be in DRAM or SRAM. The new ones are all in SRAM.
+
+  intel,dma-orrc:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description:
+      DMA outstanding read counter value determine the number of
+      ORR-Outstanding Read Request. The maximum value is 16.
+  intel,dma-dburst-wr:
+    type: boolean
+    description:
+      Enable RX dynamic burst write. When it is enabled, the DMA does RX dynamic burst;
+      if it is disabled, the DMA RX will still support programmable fixed burst size of 2,4,8,16.
+      It only applies to RX DMA and memcopy DMA.
+
+required:
+  - compatible
+  - reg
+  - '#dma-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    dma0: dma-controller@e0e00000 {
+      compatible = "intel,lgm-cdma";
+      reg = <0xe0e00000 0x1000>;
+      #dma-cells = <3>;
+      dma-channels = <16>;
+      dma-channel-mask = <0xFFFF>;
+      interrupt-parent = <&ioapic1>;
+      interrupts = <82 1>;
+      resets = <&rcu0 0x30 0>;
+      reset-names = "ctrl";
+      clocks = <&cgu0 80>;
+      intel,dma-poll-cnt = <4>;
+      intel,dma-byte-en;
+      intel,dma-drb;
+    };
+  - |
+    dma3: dma-controller@ec800000 {
+      compatible = "intel,lgm-dma3";
+      reg = <0xec800000 0x1000>;
+      clocks = <&cgu0 71>;
+      resets = <&rcu0 0x10 9>;
+      #dma-cells = <3>;
+      intel,dma-poll-cnt = <16>;
+      intel,dma-desc-in-sram;
+      intel,dma-orrc = <16>;
+      intel,dma-byte-en;
+      intel,dma-dburst-wr;
+    };
-- 
2.11.0

