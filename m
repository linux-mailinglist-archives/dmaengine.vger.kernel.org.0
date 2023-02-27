Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915886A4250
	for <lists+dmaengine@lfdr.de>; Mon, 27 Feb 2023 14:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjB0NLD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Feb 2023 08:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjB0NLC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Feb 2023 08:11:02 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD912878;
        Mon, 27 Feb 2023 05:11:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C629424E272;
        Mon, 27 Feb 2023 21:10:54 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 21:10:54 +0800
Received: from localhost.localdomain (113.72.145.171) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 21:10:54 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: constrain minItems/maxItems of resets for JH7110 DMA
Date:   Mon, 27 Feb 2023 21:10:40 +0800
Message-ID: <20230227131042.16125-2-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227131042.16125-1-walker.chen@starfivetech.com>
References: <20230227131042.16125-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controller needs two reset items to work properly on JH7110 SoC,
so there is need to change the maxItems' value to 2 and add minItems
whose value is equal to 1. Other platforms do not have this constraint.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index ad107a4d3b33..4ed0a6b7ca69 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -12,14 +12,12 @@ maintainers:
 description:
   Synopsys DesignWare AXI DMA Controller DT Binding
 
-allOf:
-  - $ref: "dma-controller.yaml#"
-
 properties:
   compatible:
     enum:
       - snps,axi-dma-1.01a
       - intel,kmb-axi-dma
+      - starfive,jh7110-axi-dma
 
   reg:
     minItems: 1
@@ -58,7 +56,8 @@ properties:
     maximum: 8
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   snps,dma-masters:
     description: |
@@ -109,6 +108,24 @@ required:
   - snps,priority
   - snps,block-size
 
+allOf:
+  - $ref: "dma-controller.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - starfive,jh7110-axi-dma
+    then:
+      properties:
+        resets:
+          minItems: 1
+          maxItems: 2
+    else:
+      properties:
+        resets:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.17.1

