Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6962664BA09
	for <lists+dmaengine@lfdr.de>; Tue, 13 Dec 2022 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbiLMQng (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Dec 2022 11:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiLMQnc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Dec 2022 11:43:32 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5615FFC;
        Tue, 13 Dec 2022 08:43:27 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BDGhCAL042949;
        Tue, 13 Dec 2022 10:43:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670949792;
        bh=1sdVIeBxoZTAw0wZ5K5+Bhj/ogaEqZRyuZbryv9UwlI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hEW/fUPwFxgKXn7fr86wLCXDNZ70m/iqH5o4ynC2TPpH/lq/7oF6gY5/BZIr8Z5Xd
         LmwV5M4c/EMrIEeguZVb+MOXvKgQ8JGkFZEFe1dPcYkFsVEqfDe3qt0ySzrnQb/Lv9
         BzN72XT5J4uN6OgJzDSmco12s8r0gvj7CedKJQAw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BDGhCoP112121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Dec 2022 10:43:12 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 13
 Dec 2022 10:43:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 13 Dec 2022 10:43:12 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BDGh6gJ034997;
        Tue, 13 Dec 2022 10:43:09 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/5] dt-bindings: dma: ti: k3-bcdma: Add bindings for BCDMA CSI RX
Date:   Tue, 13 Dec 2022 22:13:00 +0530
Message-ID: <20221213164304.1126945-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213164304.1126945-1-vigneshr@ti.com>
References: <20221213164304.1126945-1-vigneshr@ti.com>
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
v3:
Add min/max constraints for reg-names and reg on per compatible basis

v2:
reorder compatibles alphabetically
Fix reg defintion to min 3 and max 5
Keep top level constraints as is  and further restrict
variants within "if-else" blocks

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 77 ++++++++++++++-----
 1 file changed, 59 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 08627d91e607..2bc48dfd3396 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -28,13 +28,19 @@ description: |
   PDMAs can be configured via BCDMA split channel's peer registers to match with
   the configuration of the legacy peripheral.
 
-allOf:
-  - $ref: /schemas/dma/dma-controller.yaml#
-  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
-
 properties:
   compatible:
-    const: ti,am64-dmss-bcdma
+    enum:
+      - ti,am62a-dmss-bcdma-csirx
+      - ti,am64-dmss-bcdma
+
+  reg:
+    minItems: 3
+    maxItems: 5
+
+  reg-names:
+    minItems: 3
+    maxItems: 5
 
   "#dma-cells":
     const: 3
@@ -65,19 +71,13 @@ properties:
 
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
@@ -123,10 +123,51 @@ required:
   - msi-parent
   - ti,sci
   - ti,sci-dev-id
-  - ti,sci-rm-range-bchan
-  - ti,sci-rm-range-tchan
   - ti,sci-rm-range-rchan
 
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+  - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+
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
+        - power-domains
+
+    else:
+      properties:
+        reg:
+          minItems: 5
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
+        - ti,sci-rm-range-bchan
+        - ti,sci-rm-range-tchan
+
 unevaluatedProperties: false
 
 examples:
-- 
2.38.1

