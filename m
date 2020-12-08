Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1F92D270B
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgLHJGK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:06:10 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34542 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgLHJGJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:06:09 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B894QLA002920;
        Tue, 8 Dec 2020 03:04:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418266;
        bh=/HVwglcPZXx1QtJNin2Ol+OcupdDjfpEvJyJTw5mWLY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fQYNruU0X9J93tQyLnhTDehLfMskwQ0wfaovBGY0dNoEl8nIP9Ev3RvpOnK6ZfYjU
         Fh3JH5B5ZOeU+o66VIwswnz/H/47O6xoX0egOiFl9S3fSK0PYfA9qO/CUm9ViAtHP5
         15UEIb5uTQ02cgSWboyvwJvwOJozJEsAxgbyJa+c=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B894Qs4095689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:04:26 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:04:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:04:25 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dcG120112;
        Tue, 8 Dec 2020 03:04:23 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 11/20] dt-bindings: dma: ti: Add document for K3 BCDMA
Date:   Tue, 8 Dec 2020 11:04:31 +0200
Message-ID: <20201208090440.31792-12-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208090440.31792-1-peter.ujfalusi@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

New binding document for
Texas Instruments K3 Block Copy DMA (BCDMA).

BCDMA is introduced as part of AM64.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
new file mode 100644
index 000000000000..b15f68c499cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/k3-bcdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DMSS BCDMA Device Tree Bindings
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+
+description: |
+  The Block Copy DMA (BCDMA) is intended to perform similar functions as the TR
+  mode channels of K3 UDMA-P.
+  BCDMA includes block copy channels and Split channels.
+
+  Block copy channels mainly used for memory to memory transfers, but with
+  optional triggers a block copy channel can service peripherals by accessing
+  directly to memory mapped registers or area.
+
+  Split channels can be used to service PSI-L based peripherals.
+  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
+  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
+  legacy peripheral.
+
+  PDMAs can be configured via BCDMA split channel's peer registers to match with
+  the configuration of the legacy peripheral.
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    const: ti,am64-dmss-bcdma
+
+  "#dma-cells":
+    const: 3
+    description: |
+      cell 1: type of the BCDMA channel to be used to service the peripheral:
+        0 - split channel
+        1 - block copy channel using global trigger 1
+        2 - block copy channel using global trigger 2
+        3 - block copy channel using local trigger
+
+      cell 2: parameter for the channel:
+        if cell 1 is 0 (split channel):
+          PSI-L thread ID of the remote (to BCDMA) end.
+          Valid ranges for thread ID depends on the data movement direction:
+          for source thread IDs (rx): 0 - 0x7fff
+          for destination thread IDs (tx): 0x8000 - 0xffff
+
+          Please refer to the device documentation for the PSI-L thread map and
+          also the PSI-L peripheral chapter for the correct thread ID.
+        if cell 1 is 1 or 2 (block copy channel using global trigger):
+          Unused, ignored
+
+          The trigger must be configured for the channel externally to BCDMA,
+          channels using global triggers should not be requested directly, but
+          via DMA event router.
+        if cell 1 is 3 (block copy channel using local trigger):
+          bchan number of the locally triggered channel
+
+      cell 3: ASEL value for the channel
+
+  reg:
+    maxItems: 5
+
+  reg-names:
+    items:
+      - const: gcfg
+      - const: bchanrt
+      - const: rchanrt
+      - const: tchanrt
+      - const: ringrt
+
+  msi-parent: true
+
+  ti,asel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: ASEL value for non slave channels
+
+  ti,sci-rm-range-bchan:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of BCDMA block-copy channel resource subtypes for resource
+      allocation for this host
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+    items:
+      maximum: 0x3f
+
+  ti,sci-rm-range-tchan:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of BCDMA split tx channel resource subtypes for resource allocation
+      for this host
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+    items:
+      maximum: 0x3f
+
+  ti,sci-rm-range-rchan:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of BCDMA split rx channel resource subtypes for resource allocation
+      for this host
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+    items:
+      maximum: 0x3f
+
+required:
+  - compatible
+  - "#dma-cells"
+  - reg
+  - reg-names
+  - msi-parent
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,sci-rm-range-bchan
+  - ti,sci-rm-range-tchan
+  - ti,sci-rm-range-rchan
+
+unevaluatedProperties: false
+
+examples:
+  - |+
+    cbass_main {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        main_dmss {
+            compatible = "simple-mfd";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            dma-ranges;
+            ranges;
+
+            ti,sci-dev-id = <25>;
+
+            main_bcdma: dma-controller@485c0100 {
+                compatible = "ti,am64-dmss-bcdma";
+
+                reg = <0x0 0x485c0100 0x0 0x100>,
+                      <0x0 0x4c000000 0x0 0x20000>,
+                      <0x0 0x4a820000 0x0 0x20000>,
+                      <0x0 0x4aa40000 0x0 0x20000>,
+                      <0x0 0x4bc00000 0x0 0x100000>;
+                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
+                msi-parent = <&inta_main_dmss>;
+                #dma-cells = <3>;
+
+                ti,sci = <&dmsc>;
+                ti,sci-dev-id = <26>;
+
+                ti,sci-rm-range-bchan = <0x20>; /* BLOCK_COPY_CHAN */
+                ti,sci-rm-range-rchan = <0x21>; /* SPLIT_TR_RX_CHAN */
+                ti,sci-rm-range-tchan = <0x22>; /* SPLIT_TR_TX_CHAN */
+            };
+        };
+    };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

