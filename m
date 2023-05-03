Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6416F5060
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjECGxS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 02:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECGxR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 02:53:17 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778161BEC;
        Tue,  2 May 2023 23:53:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3436r5Xt015957;
        Wed, 3 May 2023 01:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683096785;
        bh=VurFgGySbQkfcSExMQrzeXBMZ00w2zK+5oK6ceDKM9U=;
        h=From:To:CC:Subject:Date;
        b=bsHwi9PZdKcJG0N89hAdecEHuagUlb7Ygf/lN1SE0R3CxKDuhBaurpWTEWBnXVnnP
         gMtOJz3JUr/TXpnqIR4RVikXKdEO9BIU+1j+Rs4D0RMhUzhMPTdKITXVLjBVEDUhu5
         s26aXFznWdCm0FqZgr7W2NLnzS6zXRO+5ZNA8SvY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3436r5q9126803
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 01:53:05 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 01:53:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 01:53:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3436r4iG083057;
        Wed, 3 May 2023 01:53:04 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 1/2] dt-bindings: dma: ti: Add J721S2 BCDMA
Date:   Wed, 3 May 2023 12:23:02 +0530
Message-ID: <20230503065303.16674-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add bindings for J721S2 BCDMA instance dedicated for Camera
Serial Interface. Unlike AM62A CSI BCDMA, this instance has RX
and TX channels but lacks block copy channels.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index beecfe7a1732..5ca9581a66f4 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -33,6 +33,7 @@ properties:
     enum:
       - ti,am62a-dmss-bcdma-csirx
       - ti,am64-dmss-bcdma
+      - ti,j721s2-dmss-bcdma-csi
 
   reg:
     minItems: 3
@@ -150,7 +151,27 @@ allOf:
 
       required:
         - power-domains
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,j721s2-dmss-bcdma-csi
+    then:
+      properties:
+        ti,sci-rm-range-bchan: false
+
+        reg:
+          maxItems: 4
 
+        reg-names:
+          items:
+            - const: gcfg
+            - const: rchanrt
+            - const: tchanrt
+            - const: ringrt
+
+      required:
+        - ti,sci-rm-range-tchan
     else:
       properties:
         reg:
-- 
2.17.1

