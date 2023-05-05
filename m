Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CF6F84F4
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjEEOjl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEEOjk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 10:39:40 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7537F1634E;
        Fri,  5 May 2023 07:39:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345EdXbG001399;
        Fri, 5 May 2023 09:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683297573;
        bh=1kQ1KWTdL2m4TLS0zoE+1YZP6/kYoYIQqI8C4X6l3nQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RdnTrBbZ5ovXP9Qlq8uZZhCXtx0nHIOdqFGbY8UpprK9s1gEexSDb3jFf1nmkfPc6
         fDnAPZaQOTV1g/XXKS4CdBit7ZPjFW8YvBCcbzAisaB1S+cofErJBY3IdLbErQzwPo
         Rb89tJ4N3mb/uQuwBWsW1qhwOcOclNuCKav4E4Gs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345EdXjr123278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 09:39:33 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 09:39:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 09:39:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345EdVNE045167;
        Fri, 5 May 2023 09:39:32 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vigneshr@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: dma: ti: Add J721S2 BCDMA
Date:   Fri, 5 May 2023 20:09:28 +0530
Message-ID: <20230505143929.28131-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505143929.28131-1-vaishnav.a@ti.com>
References: <20230505143929.28131-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

V2->V3:
  * Avoid using if:else:if, instead move ti,am64-dmss-bcdma
  to new if:, also keep entries in alphabetical order.

V1->V2:
     * Move J721S2 BCDMA entry to else condition to avoid failure
     with AM62A BCDMA.

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 54 +++++++++++++------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index beecfe7a1732..4ca300a42a99 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -33,6 +33,7 @@ properties:
     enum:
       - ti,am62a-dmss-bcdma-csirx
       - ti,am64-dmss-bcdma
+      - ti,j721s2-dmss-bcdma-csi
 
   reg:
     minItems: 3
@@ -151,7 +152,12 @@ allOf:
       required:
         - power-domains
 
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am64-dmss-bcdma
+    then:
       properties:
         reg:
           minItems: 5
@@ -168,6 +174,28 @@ allOf:
         - ti,sci-rm-range-bchan
         - ti,sci-rm-range-tchan
 
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
+
+        reg-names:
+          items:
+            - const: gcfg
+            - const: rchanrt
+            - const: tchanrt
+            - const: ringrt
+
+      required:
+        - ti,sci-rm-range-tchan
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1

