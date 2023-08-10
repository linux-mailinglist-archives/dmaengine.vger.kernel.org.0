Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B20D777F60
	for <lists+dmaengine@lfdr.de>; Thu, 10 Aug 2023 19:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHJRoO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjHJRoN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 13:44:13 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FEA2702;
        Thu, 10 Aug 2023 10:44:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AHi5hq108007;
        Thu, 10 Aug 2023 12:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691689446;
        bh=p0h9a3yfqGfj6OxwLWntvYTPbXggepS1dBoJ4kxyu5s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f+OwEkGGUIs5ARmwdvcLCe55T3LQtVOrGIxI//q54X5BciAz7tlvGCL/ebyUHjcW2
         0zIXrKwFWedBpeKSK1xpQxR2Ku1kCi5Ul7acvf5sLglOMAE/ehUdR+aYHNpcEquT7B
         vPR5qmKSsWmqB2dZ17SiQurIdORvc6FP60qtfCYQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AHi5V8026492
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 12:44:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 12:44:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 12:44:05 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AHhxug084260;
        Thu, 10 Aug 2023 12:44:02 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
Date:   Thu, 10 Aug 2023 23:13:53 +0530
Message-ID: <20230810174356.3322583-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810174356.3322583-1-vigneshr@ti.com>
References: <20230810174356.3322583-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Block copy DMA(BCDMA)module on K3 SoCs have ring cfg, TX and RX
channel cfg register regions which are usually configured by a Device
Management firmware. But certain entities such as bootloader (like
U-Boot) may have to access them directly. Describe this region in the
binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
five regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 4ca300a42a99..d166e284532b 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -37,11 +37,11 @@ properties:
 
   reg:
     minItems: 3
-    maxItems: 5
+    maxItems: 8
 
   reg-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 8
 
   "#dma-cells":
     const: 3
@@ -161,14 +161,19 @@ allOf:
       properties:
         reg:
           minItems: 5
+          maxItems: 8
 
         reg-names:
+          minItems: 5
           items:
             - const: gcfg
             - const: bchanrt
             - const: rchanrt
             - const: tchanrt
             - const: ringrt
+            - const: cfg
+            - const: tchan
+            - const: rchan
 
       required:
         - ti,sci-rm-range-bchan
@@ -216,12 +221,16 @@ examples:
             main_bcdma: dma-controller@485c0100 {
                 compatible = "ti,am64-dmss-bcdma";
 
-                reg = <0x0 0x485c0100 0x0 0x100>,
-                      <0x0 0x4c000000 0x0 0x20000>,
-                      <0x0 0x4a820000 0x0 0x20000>,
-                      <0x0 0x4aa40000 0x0 0x20000>,
-                      <0x0 0x4bc00000 0x0 0x100000>;
-                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
+                reg = <0x00 0x485c0100 0x00 0x100>,
+                      <0x00 0x4c000000 0x00 0x20000>,
+                      <0x00 0x4a820000 0x00 0x20000>,
+                      <0x00 0x4aa40000 0x00 0x20000>,
+                      <0x00 0x4bc00000 0x00 0x100000>,
+                      <0x00 0x48600000 0x00 0x8000>,
+                      <0x00 0x484a4000 0x00 0x2000>,
+                      <0x00 0x484c2000 0x00 0x2000>;
+                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
+                            "cfg", "tchan", "rchan";
                 msi-parent = <&inta_main_dmss>;
                 #dma-cells = <3>;
 
-- 
2.41.0

