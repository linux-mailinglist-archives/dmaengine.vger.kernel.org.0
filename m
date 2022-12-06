Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DACA643C5F
	for <lists+dmaengine@lfdr.de>; Tue,  6 Dec 2022 05:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiLFEg0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 23:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiLFEgQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 23:36:16 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4AF1B9F8;
        Mon,  5 Dec 2022 20:36:13 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B64a4cD084411;
        Mon, 5 Dec 2022 22:36:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670301364;
        bh=DHn66Lw1d4cx434I/RfQKwlFZn1prlnYd32a7jBzc2s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nbZrq4wUf3xlthZ0fVr1GUYJ0MIYQgxkS/rwXY6jhMgxDrqnPz9mxivVgq5wO9wus
         FQZbF0wHVBfjOoBIlVU41Vh7l7zHiikKj4Cfpt+yA7VJF4T2y0rYm4aEXm8b7vn8rj
         1rwmlJvFV5iw++cArwieDfcearmqq2RabS7HaTB4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B64a4F8034696
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Dec 2022 22:36:04 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 5
 Dec 2022 22:36:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 5 Dec 2022 22:36:04 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B64Zx2Z097382;
        Mon, 5 Dec 2022 22:36:02 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/5] dt-bindings: dma: ti: k3-bcdma: Add bindings for BCDMA CSI RX
Date:   Tue, 6 Dec 2022 10:05:50 +0530
Message-ID: <20221206043554.1521522-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206043554.1521522-1-vigneshr@ti.com>
References: <20221206043554.1521522-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

AM62A SoC has a dedicated BCDMA that serves Camera Serial Interface
(CSI) IP. Add new compatible for the same. Unlike system
BCDMA, this instance only has RX DMA channels and lack TX or block copy
channel. Thus make those properties optional. Additionally CSI RX has
independent power domain, add the binding for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 87 ++++++++++++++-----
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 08627d91e607..d7b5adbb9b2e 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -32,9 +32,66 @@ allOf:
   - $ref: /schemas/dma/dma-controller.yaml#
   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am62a-dmss-bcdma-csirx
+    then:
+      properties:
+        ti,sci-rm-range-bchan: false
+        ti,sci-rm-range-tchan: false
+
+        reg:
+          maxItems: 3
+
+        reg-names:
+          items:
+            - const: gcfg
+            - const: rchanrt
+            - const: ringrt
+
+      required:
+        - compatible
+        - "#dma-cells"
+        - reg
+        - reg-names
+        - msi-parent
+        - ti,sci
+        - ti,sci-dev-id
+        - ti,sci-rm-range-rchan
+        - power-domains
+
+    else:
+      properties:
+        reg:
+          maxItems: 5
+
+        reg-names:
+          items:
+            - const: gcfg
+            - const: bchanrt
+            - const: rchanrt
+            - const: tchanrt
+            - const: ringrt
+
+      required:
+        - compatible
+        - "#dma-cells"
+        - reg
+        - reg-names
+        - msi-parent
+        - ti,sci
+        - ti,sci-dev-id
+        - ti,sci-rm-range-bchan
+        - ti,sci-rm-range-tchan
+        - ti,sci-rm-range-rchan
+
 properties:
   compatible:
-    const: ti,am64-dmss-bcdma
+    enum:
+      - ti,am64-dmss-bcdma
+      - ti,am62a-dmss-bcdma-csirx
 
   "#dma-cells":
     const: 3
@@ -65,19 +122,13 @@ properties:
 
       cell 3: ASEL value for the channel
 
-  reg:
-    maxItems: 5
-
-  reg-names:
-    items:
-      - const: gcfg
-      - const: bchanrt
-      - const: rchanrt
-      - const: tchanrt
-      - const: ringrt
-
   msi-parent: true
 
+  power-domains:
+    description:
+      Power domain if available
+    maxItems: 1
+
   ti,asel:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: ASEL value for non slave channels
@@ -115,18 +166,6 @@ properties:
     items:
       maximum: 0x3f
 
-required:
-  - compatible
-  - "#dma-cells"
-  - reg
-  - reg-names
-  - msi-parent
-  - ti,sci
-  - ti,sci-dev-id
-  - ti,sci-rm-range-bchan
-  - ti,sci-rm-range-tchan
-  - ti,sci-rm-range-rchan
-
 unevaluatedProperties: false
 
 examples:
-- 
2.38.1

