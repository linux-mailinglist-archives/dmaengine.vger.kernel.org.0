Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9AC6F805A
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjEEJtT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 05:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEEJtS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 05:49:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF618DD2;
        Fri,  5 May 2023 02:49:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3458Q6ne076875;
        Fri, 5 May 2023 03:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683275166;
        bh=dcoc0TaLj2PqYHrHsjoa5H3Fd5Sh+EZ+E15K/tnODBY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FrM10/DPdGSDPFfWy0E/gKSCiEWHXRfg7Jh44prTOEpNNtXnG0Ih8NZQSZGbIHspC
         toRtHq+SSb/osFBGxkUeBpTeYCeMEOxNlvVM1fBySZ6h2/hiebFy6UIjhrMH4g7Pnw
         gVYCStek9Qxgg/sj6Hcek2z3FHTQNB7TuYvwFEkI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3458Q6sg035302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 03:26:06 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 03:26:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 03:26:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3458Q4Rb021882;
        Fri, 5 May 2023 03:26:05 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <peter.ujfalusi@gmail.com>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <j-choudhary@ti.com>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <vigneshr@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: dma: ti: Add J721S2 BCDMA
Date:   Fri, 5 May 2023 13:56:01 +0530
Message-ID: <20230505082602.31783-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505082602.31783-1-vaishnav.a@ti.com>
References: <20230505082602.31783-1-vaishnav.a@ti.com>
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

V1->V2:
     * Move J721S2 BCDMA entry to else condition to avoid failure
     with AM62A BCDMA.

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 54 +++++++++++++------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index beecfe7a1732..54d4b8e0c8ce 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -33,6 +33,7 @@ properties:
     enum:
       - ti,am62a-dmss-bcdma-csirx
       - ti,am64-dmss-bcdma
+      - ti,j721s2-dmss-bcdma-csi
 
   reg:
     minItems: 3
@@ -152,21 +153,44 @@ allOf:
         - power-domains
 
     else:
-      properties:
-        reg:
-          minItems: 5
-
-        reg-names:
-          items:
-            - const: gcfg
-            - const: bchanrt
-            - const: rchanrt
-            - const: tchanrt
-            - const: ringrt
-
-      required:
-        - ti,sci-rm-range-bchan
-        - ti,sci-rm-range-tchan
+      if:
+        properties:
+          compatible:
+            contains:
+              const: ti,j721s2-dmss-bcdma-csi
+      then:
+        properties:
+          ti,sci-rm-range-bchan: false
+
+          reg:
+            maxItems: 4
+
+          reg-names:
+            items:
+              - const: gcfg
+              - const: rchanrt
+              - const: tchanrt
+              - const: ringrt
+
+        required:
+          - ti,sci-rm-range-tchan
+
+      else:
+        properties:
+          reg:
+            minItems: 5
+
+          reg-names:
+            items:
+              - const: gcfg
+              - const: bchanrt
+              - const: rchanrt
+              - const: tchanrt
+              - const: ringrt
+
+        required:
+          - ti,sci-rm-range-bchan
+          - ti,sci-rm-range-tchan
 
 unevaluatedProperties: false
 
-- 
2.17.1

