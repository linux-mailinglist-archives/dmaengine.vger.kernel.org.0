Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4397027E4B0
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgI3JOl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:14:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35172 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3JOg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9ETpn035054;
        Wed, 30 Sep 2020 04:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457269;
        bh=QqJ+KtVkkwtEEs8vHrO8kwub4apioUn3mdcrgdWfutw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GVtpfI+++dLVVn7jIdZWObw3choRGVHwwTtRrAn0xGWk0M/A+ojksxFDjvaOA0Wr2
         dIZGqrICZAUjxv4VeLIEN9MeD7SaT16TlJgwYZqJa8heGNuVTBJdAGD/JXo2wNZThY
         N2fU55/fdH7k3XO1gqQI8N4oVmdxs4WIxUh3XdR4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U9ET82111953
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:14:29 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:28 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJh116385;
        Wed, 30 Sep 2020 04:14:26 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 10/18] dt-bindings: dma: ti: Add document for K3 PKTDMA
Date:   Wed, 30 Sep 2020 12:14:04 +0300
Message-ID: <20200930091412.8020-11-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930091412.8020-1-peter.ujfalusi@ti.com>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

New binding document for
Texas Instruments K3 Packet DMA (PKTDMA).

PKTDMA is introduced as part of AM64.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 189 ++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
new file mode 100644
index 000000000000..75b35bd85830
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/k3-pktdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DMSS PKTDMA Device Tree Bindings
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+
+description: |
+  The Packet DMA (PKTDMA) is intended to perform similar functions as the packet
+  mode channels of K3 UDMA-P.
+  PKTDMA only includes Split channels to service PSI-L based peripherals.
+
+  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
+  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
+  legacy peripheral.
+
+  PDMAs can be configured via PKTDMA split channel's peer registers to match
+  with the configuration of the legacy peripheral.
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  "#dma-cells":
+    const: 2
+    description: |
+      The first cell is the PSI-L  thread ID of the remote (to PKTDMA) end.
+      Valid ranges for thread ID depends on the data movement direction:
+      for source thread IDs (rx): 0 - 0x7fff
+      for destination thread IDs (tx): 0x8000 - 0xffff
+
+      Please refer to the device documentation for the PSI-L thread map and also
+      the PSI-L peripheral chapter for the correct thread ID.
+
+      The second cell is the ASEL value for the channel
+
+  compatible:
+    enum:
+      - ti,am64-dmss-pktdma
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+   items:
+     - const: gcfg
+     - const: rchanrt
+     - const: tchanrt
+     - const: ringrt
+
+  msi-parent: true
+
+  ti,sci:
+    description: phandle to TI-SCI compatible System controller node
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,sci-dev-id:
+    description: TI-SCI device id of PKTDMA
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  ti,sci-rm-range-tchan:
+    description: |
+      Array of PKTDMA split tx channel resource subtypes for resource allocation
+      for this host
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+
+  ti,sci-rm-range-tflow:
+    description: |
+      Array of PKTDMA split tx flow resource subtypes for resource allocation
+      for this host
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+
+  ti,sci-rm-range-rchan:
+    description: |
+      Array of PKTDMA split rx channel resource subtypes for resource allocation
+      for this host
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+
+  ti,sci-rm-range-rflow:
+    description: |
+      Array of PKTDMA split rx flow resource subtypes for resource allocation
+      for this host
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - "#dma-cells"
+  - reg
+  - reg-names
+  - msi-parent
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,sci-rm-range-tchan
+  - ti,sci-rm-range-tflow
+  - ti,sci-rm-range-rchan
+  - ti,sci-rm-range-rflow
+
+additionalProperties: false
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
+            main_pktdma: dma-controller@485c0000 {
+                compatible = "ti,am64-dmss-pktdma";
+                #address-cells = <2>;
+                #size-cells = <2>;
+
+                reg = <0x0 0x485c0000 0x0 0x100>,
+                      <0x0 0x4a800000 0x0 0x20000>,
+                      <0x0 0x4aa00000 0x0 0x40000>,
+                      <0x0 0x4b800000 0x0 0x400000>;
+                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+                msi-parent = <&inta_main_dmss>;
+                #dma-cells = <2>;
+
+                ti,sci = <&dmsc>;
+                ti,sci-dev-id = <30>;
+
+                ti,sci-rm-range-tchan = <0x23>, /* UNMAPPED_TX_CHAN */
+                                        <0x24>, /* CPSW_TX_CHAN */
+                                        <0x25>, /* SAUL_TX_0_CHAN */
+                                        <0x26>, /* SAUL_TX_1_CHAN */
+                                        <0x27>, /* ICSSG_0_TX_CHAN */
+                                        <0x28>; /* ICSSG_1_TX_CHAN */
+                ti,sci-rm-range-tflow = <0x10>, /* RING_UNMAPPED_TX_CHAN */
+                                        <0x11>, /* RING_CPSW_TX_CHAN */
+                                        <0x12>, /* RING_SAUL_TX_0_CHAN */
+                                        <0x13>, /* RING_SAUL_TX_1_CHAN */
+                                        <0x14>, /* RING_ICSSG_0_TX_CHAN */
+                                        <0x15>; /* RING_ICSSG_1_TX_CHAN */
+                ti,sci-rm-range-rchan = <0x29>, /* UNMAPPED_RX_CHAN */
+                                        <0x2b>, /* CPSW_RX_CHAN */
+                                        <0x2d>, /* SAUL_RX_0_CHAN */
+                                        <0x2f>, /* SAUL_RX_1_CHAN */
+                                        <0x31>, /* SAUL_RX_2_CHAN */
+                                        <0x33>, /* SAUL_RX_3_CHAN */
+                                        <0x35>, /* ICSSG_0_RX_CHAN */
+                                        <0x37>; /* ICSSG_1_RX_CHAN */
+                ti,sci-rm-range-rflow = <0x2a>, /* FLOW_UNMAPPED_RX_CHAN */
+                                        <0x2c>, /* FLOW_CPSW_RX_CHAN */
+                                        <0x2e>, /* FLOW_SAUL_RX_0/1_CHAN */
+                                        <0x32>, /* FLOW_SAUL_RX_2/3_CHAN */
+                                        <0x36>, /* FLOW_ICSSG_0_RX_CHAN */
+                                        <0x38>; /* FLOW_ICSSG_1_RX_CHAN */
+            };
+        };
+    };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

