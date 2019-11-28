Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAE10C76B
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2019 12:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK1LAX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Nov 2019 06:00:23 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34432 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfK1LAW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Nov 2019 06:00:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASB0E40022826;
        Thu, 28 Nov 2019 05:00:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938814;
        bh=5OjMWNd5ALQ5WMDmKVwfPB8zpIcPz6tmK9RS2Eo8FeA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kQgrMivkpXWFnssCC9weOgrXSVsBRs7G6ElDvn6Utspg0UfmTxb1HhRKWN9w89ljw
         /Re3LBU+ZXB2nRPV9jCy8UP4i34JPubn6JsIZKLLZPJrRCNSgIvuf/V051jL/B8KVk
         +oqKNdMAaF3jh1zRoux4RQdrD3YpRDPzUndGd+nc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xASB0Eb9031772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 05:00:14 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 05:00:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 05:00:13 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAxgJM073287;
        Thu, 28 Nov 2019 05:00:10 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v6 08/17] dt-bindings: dma: ti: Add document for K3 UDMA
Date:   Thu, 28 Nov 2019 12:59:36 +0200
Message-ID: <20191128105945.13071-9-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128105945.13071-1-peter.ujfalusi@ti.com>
References: <20191128105945.13071-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

New binding document for
Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P).

UDMA-P is introduced as part of the K3 architecture and can be found in
AM654 and j721e.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/dma/ti/k3-udma.yaml   | 185 ++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
new file mode 100644
index 000000000000..77aef4a4abce
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -0,0 +1,185 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ti/k3-udma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 NAVSS Unified DMA Device Tree Bindings
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+
+description: |
+  The UDMA-P is intended to perform similar (but significantly upgraded)
+  functions as the packet-oriented DMA used on previous SoC devices. The UDMA-P
+  module supports the transmission and reception of various packet types.
+  The UDMA-P is architected to facilitate the segmentation and reassembly of
+  SoC DMA data structure compliant packets to/from smaller data blocks that are
+  natively compatible with the specific requirements of each connected
+  peripheral.
+  Multiple Tx and Rx channels are provided within the DMA which allow multiple
+  segmentation or reassembly operations to be ongoing. The DMA controller
+  maintains state information for each of the channels which allows packet
+  segmentation and reassembly operations to be time division multiplexed between
+  channels in order to share the underlying DMA hardware. An external DMA
+  scheduler is used to control the ordering and rate at which this multiplexing
+  occurs for Transmit operations. The ordering and rate of Receive operations
+  is indirectly controlled by the order in which blocks are pushed into the DMA
+  on the Rx PSI-L interface.
+
+  The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
+  channels. Channels in the UDMA-P can be configured to be either Packet-Based
+  or Third-Party channels on a channel by channel basis.
+
+  All transfers within NAVSS is done between PSI-L source and destination
+  threads.
+  The peripherals serviced by UDMA can be PSI-L native (sa2ul, cpsw, etc) or
+  legacy, non PSI-L native peripherals. In the later case a special, small PDMA
+  is tasked to act as a bridge between the PSI-L fabric and the legacy
+  peripheral.
+
+  PDMAs can be configured via UDMAP peer registers to match with the
+  configuration of the legacy peripheral.
+
+allOf:
+  - $ref: "../dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+    description: |
+      The cell is the PSI-L  thread ID of the remote (to UDMAP) end.
+      Valid ranges for thread ID depends on the data movement direction:
+      for source thread IDs (rx): 0 - 0x7fff
+      for destination thread IDs (tx): 0x8000 - 0xffff
+
+      PLease refer to the device documentation for the PSI-L thread map and also
+      the PSI-L peripheral chapter for the correct thread ID.
+
+  compatible:
+    enum:
+      - ti,am654-navss-main-udmap
+      - ti,am654-navss-mcu-udmap
+      - ti,j721e-navss-main-udmap
+      - ti,j721e-navss-mcu-udmap
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+   items:
+     - const: gcfg
+     - const: rchanrt
+     - const: tchanrt
+
+  msi-parent: true
+
+  ti,sci:
+    description: phandle to TI-SCI compatible System controller node
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,sci-dev-id:
+    description: TI-SCI device id of UDMAP
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  ti,ringacc:
+    description: phandle to the ring accelerator node
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  ti,sci-rm-range-tchan:
+    description: |
+      Array of UDMA tchan resource subtypes for resource allocation for this
+      host
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+
+  ti,sci-rm-range-rchan:
+    description: |
+      Array of UDMA rchan resource subtypes for resource allocation for this
+      host
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+
+  ti,sci-rm-range-rflow:
+    description: |
+      Array of UDMA rflow resource subtypes for resource allocation for this
+      host
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    # Should be enough
+    maxItems: 255
+
+required:
+  - compatible
+  - "#dma-cells"
+  - reg
+  - reg-names
+  - msi-parent
+  - ti,sci
+  - ti,sci-dev-id
+  - ti,ringacc
+  - ti,sci-rm-range-tchan
+  - ti,sci-rm-range-rchan
+  - ti,sci-rm-range-rflow
+
+examples:
+  - |+
+    cbass_main {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        cbass_main_navss: navss@30800000 {
+            compatible = "simple-mfd";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            dma-coherent;
+            dma-ranges;
+            ranges;
+
+            ti,sci-dev-id = <118>;
+
+            main_udmap: dma-controller@31150000 {
+                compatible = "ti,am654-navss-main-udmap";
+                reg = <0x0 0x31150000 0x0 0x100>,
+                      <0x0 0x34000000 0x0 0x100000>,
+                      <0x0 0x35000000 0x0 0x100000>;
+                reg-names = "gcfg", "rchanrt", "tchanrt";
+                #dma-cells = <1>;
+
+                ti,ringacc = <&ringacc>;
+
+                msi-parent = <&inta_main_udmass>;
+
+                ti,sci = <&dmsc>;
+                ti,sci-dev-id = <188>;
+
+                ti,sci-rm-range-tchan = <0x1>, /* TX_HCHAN */
+                                        <0x2>; /* TX_CHAN */
+                ti,sci-rm-range-rchan = <0x4>, /* RX_HCHAN */
+                                        <0x5>; /* RX_CHAN */
+                ti,sci-rm-range-rflow = <0x6>; /* GP RFLOW */
+            };
+        };
+
+        mcasp0: mcasp@02B00000 {
+            dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
+            dma-names = "tx", "rx";
+        };
+
+        crypto: crypto@4E00000 {
+            compatible = "ti,sa2ul-crypto";
+
+            dmas = <&main_udmap 0xc000>, <&main_udmap 0x4000>, <&main_udmap 0x4001>;
+            dma-names = "tx", "rx1", "rx2";
+        };
+    };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

