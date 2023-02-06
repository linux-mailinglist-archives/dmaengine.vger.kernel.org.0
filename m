Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4B68BBCC
	for <lists+dmaengine@lfdr.de>; Mon,  6 Feb 2023 12:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBFLid (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Feb 2023 06:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBFLib (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Feb 2023 06:38:31 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50610D;
        Mon,  6 Feb 2023 03:38:30 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D8FFF24E1F4;
        Mon,  6 Feb 2023 19:38:23 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Feb
 2023 19:38:23 +0800
Received: from localhost.localdomain (183.27.96.33) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Feb
 2023 19:38:22 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] dt-bindings: dma: snps,dw-axi-dmac: Update resets and add snps,num-hs-if
Date:   Mon, 6 Feb 2023 19:38:09 +0800
Message-ID: <20230206113811.23133-2-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230206113811.23133-1-walker.chen@starfivetech.com>
References: <20230206113811.23133-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.33]
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

Add two reset items and properties 'snps,num-hs-if'.
The DMA controller needs to be reset before being used in JH7110 SoC.
Another difference from the original version is that the hardware
handshake number of DMA can be up to 56 while the number in original
version is less than 16, and different registers are selected according
to this.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 .../bindings/dma/snps,dw-axi-dmac.yaml          | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 67aa7bb6d36a..1a8d8c20e254 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -9,6 +9,7 @@ title: Synopsys DesignWare AXI DMA Controller
 maintainers:
   - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
   - Jee Heng Sia <jee.heng.sia@intel.com>
+  - Walker Chen <walker.chen@starfivetech.com>
 
 description:
   Synopsys DesignWare AXI DMA Controller DT Binding
@@ -21,6 +22,7 @@ properties:
     enum:
       - snps,axi-dma-1.01a
       - intel,kmb-axi-dma
+      - starfive,axi-dma
 
   reg:
     minItems: 1
@@ -59,7 +61,12 @@ properties:
     maximum: 8
 
   resets:
-    maxItems: 1
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: axi-rst
+      - const: ahb-rst
 
   snps,dma-masters:
     description: |
@@ -74,6 +81,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3, 4, 5, 6]
 
+  snps,num-hs-if:
+    description: |
+      The number of hardware handshake. If it is more than 16,
+      CHx_CFG2 is used to configure the DMA transfer instead of CHx_CFG.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 256
+
   snps,priority:
     description: |
       Channel priority specifier associated with the DMA channels.
-- 
2.17.1

