Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25E0210948
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 12:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgGAKa5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 06:30:57 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37120 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbgGAKa4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 06:30:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061AUrRu089330;
        Wed, 1 Jul 2020 05:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593599453;
        bh=QPAYCJ+yvghUv/lKfSQ6i5rtjCPNd21V448/9mNeHZk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NMwhSyYOg/7kMBdHd8UVfaAQ05yo7Esv7c55tBqWzsi08XLPyEq99xyM8Z6I5ikXC
         Ln6iStfG6VqX6DzQLxcVod1fQ4HD6Ukn8QINqwETiEscSNDYvtNFU73plBQJ6t5Bxc
         tGn9kBEsvtzV/Y3G/qkb9TSzpGEz5J4bYNENgUpw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061AUmGq072692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 05:30:53 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 05:30:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 05:30:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061AUopr081926;
        Wed, 1 Jul 2020 05:30:50 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next 1/6] dt-bindings: soc: ti: k3-ringacc: convert bindings to json-schema
Date:   Wed, 1 Jul 2020 13:30:25 +0300
Message-ID: <20200701103030.29684-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701103030.29684-1-grygorii.strashko@ti.com>
References: <20200701103030.29684-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the K3 NavigatorSS Ring Accelerator bindings documentation to
json-schema.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../devicetree/bindings/soc/ti/k3-ringacc.txt |  59 ----------
 .../bindings/soc/ti/k3-ringacc.yaml           | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml

diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
deleted file mode 100644
index 59758ccce809..000000000000
--- a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-* Texas Instruments K3 NavigatorSS Ring Accelerator
-
-The Ring Accelerator (RA) is a machine which converts read/write accesses
-from/to a constant address into corresponding read/write accesses from/to a
-circular data structure in memory. The RA eliminates the need for each DMA
-controller which needs to access ring elements from having to know the current
-state of the ring (base address, current offset). The DMA controller
-performs a read or write access to a specific address range (which maps to the
-source interface on the RA) and the RA replaces the address for the transaction
-with a new address which corresponds to the head or tail element of the ring
-(head for reads, tail for writes).
-
-The Ring Accelerator is a hardware module that is responsible for accelerating
-management of the packet queues. The K3 SoCs can have more than one RA instances
-
-Required properties:
-- compatible	: Must be "ti,am654-navss-ringacc";
-- reg		: Should contain register location and length of the following
-		  named register regions.
-- reg-names	: should be
-		  "rt" - The RA Ring Real-time Control/Status Registers
-		  "fifos" - The RA Queues Registers
-		  "proxy_gcfg" - The RA Proxy Global Config Registers
-		  "proxy_target" - The RA Proxy Datapath Registers
-- ti,num-rings	: Number of rings supported by RA
-- ti,sci-rm-range-gp-rings : TI-SCI RM subtype for GP ring range
-- ti,sci	: phandle on TI-SCI compatible System controller node
-- ti,sci-dev-id	: TI-SCI device id of the ring accelerator
-- msi-parent	: phandle for "ti,sci-inta" interrupt controller
-
-Optional properties:
- -- ti,dma-ring-reset-quirk : enable ringacc / udma ring state interoperability
-		  issue software w/a
-
-Example:
-
-ringacc: ringacc@3c000000 {
-	compatible = "ti,am654-navss-ringacc";
-	reg =	<0x0 0x3c000000 0x0 0x400000>,
-		<0x0 0x38000000 0x0 0x400000>,
-		<0x0 0x31120000 0x0 0x100>,
-		<0x0 0x33000000 0x0 0x40000>;
-	reg-names = "rt", "fifos",
-		    "proxy_gcfg", "proxy_target";
-	ti,num-rings = <818>;
-	ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
-	ti,dma-ring-reset-quirk;
-	ti,sci = <&dmsc>;
-	ti,sci-dev-id = <187>;
-	msi-parent = <&inta_main_udmass>;
-};
-
-client:
-
-dma_ipx: dma_ipx@<addr> {
-	...
-	ti,ringacc = <&ringacc>;
-	...
-}
diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
new file mode 100644
index 000000000000..ae33fc957141
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/ti/k3-ringacc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Texas Instruments K3 NavigatorSS Ring Accelerator
+
+maintainers:
+  - Santosh Shilimkar <ssantosh@kernel.org>
+  - Grygorii Strashko <grygorii.strashko@ti.com>
+
+description: |
+  The Ring Accelerator (RA) is a machine which converts read/write accesses
+  from/to a constant address into corresponding read/write accesses from/to a
+  circular data structure in memory. The RA eliminates the need for each DMA
+  controller which needs to access ring elements from having to know the current
+  state of the ring (base address, current offset). The DMA controller
+  performs a read or write access to a specific address range (which maps to the
+  source interface on the RA) and the RA replaces the address for the transaction
+  with a new address which corresponds to the head or tail element of the ring
+  (head for reads, tail for writes).
+
+  The Ring Accelerator is a hardware module that is responsible for accelerating
+  management of the packet queues. The K3 SoCs can have more than one RA instances
+
+properties:
+  compatible:
+    items:
+      - const: ti,am654-navss-ringacc
+
+  reg:
+    items:
+      - description: real time registers regions
+      - description: fifos registers regions
+      - description: proxy gcfg registers regions
+      - description: proxy target registers regions
+
+  reg-names:
+    items:
+      - const: rt
+      - const: fifos
+      - const: proxy_gcfg
+      - const: proxy_target
+
+  msi-parent: true
+
+  ti,num-rings:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of rings supported by RA
+
+  ti,sci-rm-range-gp-rings:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TI-SCI RM subtype for GP ring range
+
+  ti,sci:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+    description: phandle on TI-SCI compatible System controller node
+
+  ti,sci-dev-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: TI-SCI device id of the ring accelerator
+
+  ti,dma-ring-reset-quirk:
+    $ref: /schemas/types.yaml#definitions/flag
+    description: |
+      enable ringacc/udma ring state interoperability issue software w/a
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - msi-parent
+  - ti,num-rings
+  - ti,sci-rm-range-gp-rings
+  - ti,sci
+  - ti,sci-dev-id
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ringacc: ringacc@3c000000 {
+            compatible = "ti,am654-navss-ringacc";
+            reg = <0x0 0x3c000000 0x0 0x400000>,
+                  <0x0 0x38000000 0x0 0x400000>,
+                  <0x0 0x31120000 0x0 0x100>,
+                  <0x0 0x33000000 0x0 0x40000>;
+            reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+            ti,num-rings = <818>;
+            ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
+            ti,dma-ring-reset-quirk;
+            ti,sci = <&dmsc>;
+            ti,sci-dev-id = <187>;
+            msi-parent = <&inta_main_udmass>;
+        };
+    };
-- 
2.17.1

