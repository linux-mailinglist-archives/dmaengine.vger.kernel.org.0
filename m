Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07684ABA8E
	for <lists+dmaengine@lfdr.de>; Fri,  6 Sep 2019 16:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391823AbfIFOQ7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Sep 2019 10:16:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53072 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfIFOQ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Sep 2019 10:16:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x86EGrqM081318;
        Fri, 6 Sep 2019 09:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567779413;
        bh=lL+zXXpiAMPM0yEzqtzknYNhG5vy2NXPPxTYA7JesO0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bMPSYu3h2iINSzphkoyAysVXm0iwyvy1a2EUt0dQQ2CW6AglsVw2xIayp6CImvkpF
         HRT8Z/IvKAgoQdyC+D5FNdoVy/vScxAeC1a0CmnzFsh0kZ33Hh5Rvl76Sr/nRbPYlC
         3QSOVssDCgoEaihU3HP5w3hah29dn2/QNSPPUoKs=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x86EGrAd092427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Sep 2019 09:16:53 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 6 Sep
 2019 09:16:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 6 Sep 2019 09:16:53 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x86EGmad042400;
        Fri, 6 Sep 2019 09:16:51 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vinod.koul@intel.com>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
Date:   Fri, 6 Sep 2019 17:17:15 +0300
Message-ID: <20190906141717.23859-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906141717.23859-1-peter.ujfalusi@ti.com>
References: <20190906141717.23859-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On systems where multiple DMA controllers available, none Slave (for example
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
 .../devicetree/bindings/dma/dma-domain.yaml   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml

diff --git a/Documentation/devicetree/bindings/dma/dma-domain.yaml b/Documentation/devicetree/bindings/dma/dma-domain.yaml
new file mode 100644
index 000000000000..c2f182f30081
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/dma-domain.yaml
@@ -0,0 +1,59 @@
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
+    };
+
+    &cbass_mcu {
+        /* For modules within MCU domain, use mcu UDMAP */
+        dma-domain-controller = <&mcu_udmap>;
+    };
+...
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

