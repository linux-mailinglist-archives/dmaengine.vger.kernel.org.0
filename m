Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF82D26EA
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgLHJF0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:05:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51862 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgLHJFZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:05:25 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B894UcF130445;
        Tue, 8 Dec 2020 03:04:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418270;
        bh=GiNkoTZiOnAH2fr3ySzMWO6hbOMelTjuxGa0BF6Vy54=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yGdOemyPt9SJmSAHay95XfO8lVilFRcBM33cDVtHSK/0NdI2fBVQb/GUL66FwvnZv
         1uiir8e800esenhgblrHTJjWwu0NiPxaqOXV4DTz6vl3ycCmG1yaV5nEE2RoXYTv52
         0/RRfYBC7uvIBIzDwnGneahzGBoywErHX5TUZKF8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B894TQE117605
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:04:29 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:04:29 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:04:29 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dcH120112;
        Tue, 8 Dec 2020 03:04:26 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 12/20] dt-bindings: dma: ti: Add document for K3 PKTDMA
Date:   Tue, 8 Dec 2020 11:04:32 +0200
Message-ID: <20201208090440.31792-13-peter.ujfalusi@ti.com>
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
Texas Instruments K3 Packet DMA (PKTDMA).

PKTDMA is introduced as part of AM64.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
new file mode 100644
index 000000000000..b13ab60cd740
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -0,0 +1,172 @@
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
+  compatible:
+    const: ti,am64-dmss-pktdma
+
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
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: gcfg
+      - const: rchanrt
+      - const: tchanrt
+      - const: ringrt
+
+  msi-parent: true
+
+  ti,sci-rm-range-tchan:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of PKTDMA split tx channel resource subtypes for resource allocation
+      for this host
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+    items:
+      maximum: 0x3f
+
+  ti,sci-rm-range-tflow:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of PKTDMA split tx flow resource subtypes for resource allocation
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
+      Array of PKTDMA split rx channel resource subtypes for resource allocation
+      for this host
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+    items:
+      maximum: 0x3f
+
+  ti,sci-rm-range-rflow:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of PKTDMA split rx flow resource subtypes for resource allocation
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
+  - ti,sci-rm-range-tchan
+  - ti,sci-rm-range-tflow
+  - ti,sci-rm-range-rchan
+  - ti,sci-rm-range-rflow
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
+            main_pktdma: dma-controller@485c0000 {
+                compatible = "ti,am64-dmss-pktdma";
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

