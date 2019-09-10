Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24117AE973
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfIJLuN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 07:50:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33200 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfIJLuN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 07:50:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8ABoBuR040806;
        Tue, 10 Sep 2019 06:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568116211;
        bh=EqKT5FCpYXzCmOXY0n2mABkUfFslwNpZ85dM04a5nHc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BlbforvP0LGbgN1TGnofPmcmASn2nZxobkNRBxTrWaJT7EyblYsVD0U8awgUtRLsK
         kAz0/gSPjmZU9msAqrctAIxBxn2BTdVggkaGjp5D9Rd8InRohByZrJeU7JiD3m9zDi
         wk+nDPhJSm+0oZeiVDNxR4lu0dD/YmJAj+lOpCvw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8ABoBvr010377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Sep 2019 06:50:11 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 06:50:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 06:50:09 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ABo5cG028909;
        Tue, 10 Sep 2019 06:50:08 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: dma: Add documentation for DMA domains
Date:   Tue, 10 Sep 2019 14:50:35 +0300
Message-ID: <20190910115037.23539-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190910115037.23539-1-peter.ujfalusi@ti.com>
References: <20190910115037.23539-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On systems where multiple DMA controllers available, non Slave (for example
memcpy operation) users can not be described in DT as there is no device
involved from the DMA controller's point of view, DMA binding is not usable.
However in these systems still a peripheral might need to be serviced by or
it is better to serviced by specific DMA controller.
When a memcpy is used to/from a memory mapped region for example a DMA in the
same domain can perform better.
For generic software modules doing mem 2 mem operations it also matter that
they will get a channel from a controller which is faster in DDR to DDR mode
rather then from the first controller happen to be loaded.

This property is inherited, so it may be specified in a device node or in any
of its parent nodes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/dma/dma-domain.yaml   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml

diff --git a/Documentation/devicetree/bindings/dma/dma-domain.yaml b/Documentation/devicetree/bindings/dma/dma-domain.yaml
new file mode 100644
index 000000000000..da59bb129c58
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/dma-domain.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/dma-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DMA Domain Controller Definition
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+description:
+  On systems where multiple DMA controllers available, none Slave (for example
+  memcpy operation) users can not be described in DT as there is no device
+  involved from the DMA controller's point of view, DMA binding is not usable.
+  However in these systems still a peripheral might need to be serviced by or
+  it is better to serviced by specific DMA controller.
+  When a memcpy is used to/from a memory mapped region for example a DMA in the
+  same domain can perform better.
+  For generic software modules doing mem 2 mem operations it also matter that
+  they will get a channel from a controller which is faster in DDR to DDR mode
+  rather then from the first controller happen to be loaded.
+
+  This property is inherited, so it may be specified in a device node or in any
+  of its parent nodes.
+
+properties:
+  $dma-domain-controller:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description:
+      phande to the DMA controller node which should be used for the device or
+      domain.
+
+examples:
+  - |
+    / {
+        model = "Texas Instruments K3 AM654 SoC";
+        compatible = "ti,am654";
+        interrupt-parent = <&gic500>;
+        /* For modules without device, DDR to DDR is faster on main UDMAP */
+        dma-domain-controller = <&main_udmap>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ...
+    };
+
+    &cbass_main {
+        /* For modules within MAIN domain, use main UDMAP */
+        dma-domain-controller = <&main_udmap>;
+
+        cbass_main_navss: interconnect0 {
+            ...
+            main_udmap: dma-controller@31150000 {
+                compatible = "ti,am654-navss-main-udmap";
+                ...
+            };
+        };
+    };
+
+    &cbass_mcu {
+        /* For modules within MCU domain, use mcu UDMAP */
+        dma-domain-controller = <&mcu_udmap>;
+
+        cbass_mcu_navss: interconnect1 {
+            ...
+            mcu_udmap: dma-controller@285c0000 {
+                compatible = "ti,am654-navss-mcu-udmap";
+                ...
+            };
+        };
+
+        fss: fss@47000000 {
+            compatible = "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+
+            ospi0: spi@47040000 {
+                compatible = "ti,am654-ospi", "cdns,qspi-nor";
+                ...
+                /* memcpy channel will be request from mcu_udmap */
+            };
+        };
+    };
+...
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

