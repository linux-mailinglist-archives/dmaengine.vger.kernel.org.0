Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB10777F64
	for <lists+dmaengine@lfdr.de>; Thu, 10 Aug 2023 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjHJRoS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjHJRoR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 13:44:17 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219082710;
        Thu, 10 Aug 2023 10:44:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AHiCjc117096;
        Thu, 10 Aug 2023 12:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691689452;
        bh=ZO3JdNsGbz/sKkPIRR3tr/lL4jsNsXrDVuUjakQcWD8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WcvEeFtNvAcMg+G8Q81v6b8CR8ZKGUBM6B4AcJwfl4SbNA+906NYgQJgpZA8ofKkx
         UQv8d9FclRmiJxc6eqXTcpiBIvniQ9YMSj4qCQCNn1r6GpaB0VhigHXF0LMmbP33Ua
         lznp5ku9u14WL+s6tZG6bOAUIz45WQPciEcm+BEk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AHiC35075264
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 12:44:12 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 12:44:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 12:44:11 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AHhxui084260;
        Thu, 10 Aug 2023 12:44:08 -0500
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
Subject: [PATCH 3/3] dt-bindings: dma: ti: k3-udma: Describe cfg register regions
Date:   Thu, 10 Aug 2023 23:13:55 +0530
Message-ID: <20230810174356.3322583-4-vigneshr@ti.com>
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

Unified DMA (UDMA) module on K3 SoCs have TX and RX channel cfg and RX
flow cfg register regions which are usually configured by a Device
Management firmware. But certain entities such as bootloader (like
U-Boot) may have to access them directly. Describe this region in the
binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
four regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-udma.yaml        | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index 22f6c5e2f7f4..f0d7c3a4d205 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -69,13 +69,18 @@ properties:
       - ti,j721e-navss-mcu-udmap
 
   reg:
-    maxItems: 3
+    minItems: 3
+    maxItems: 6
 
   reg-names:
+    minItems: 3
     items:
       - const: gcfg
       - const: rchanrt
       - const: tchanrt
+      - const: tchan
+      - const: rchan
+      - const: rflow
 
   msi-parent: true
 
@@ -158,8 +163,11 @@ examples:
                 compatible = "ti,am654-navss-main-udmap";
                 reg = <0x0 0x31150000 0x0 0x100>,
                       <0x0 0x34000000 0x0 0x100000>,
-                      <0x0 0x35000000 0x0 0x100000>;
-                reg-names = "gcfg", "rchanrt", "tchanrt";
+                      <0x0 0x35000000 0x0 0x100000>,
+                      <0x0 0x30b00000 0x0 0x20000>,
+                      <0x0 0x30c00000 0x0 0x8000>,
+                      <0x0 0x30d00000 0x0 0x4000>;
+                reg-names = "gcfg", "rchanrt", "tchanrt", "tchan", "rchan", "rflow";
                 #dma-cells = <1>;
 
                 ti,ringacc = <&ringacc>;
-- 
2.41.0

