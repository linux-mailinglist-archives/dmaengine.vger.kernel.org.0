Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C16BA882
	for <lists+dmaengine@lfdr.de>; Wed, 15 Mar 2023 07:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCOG6h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Mar 2023 02:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCOG6g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Mar 2023 02:58:36 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3465120055;
        Tue, 14 Mar 2023 23:58:34 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,262,1673881200"; 
   d="scan'208";a="152641780"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Mar 2023 15:47:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.128])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7184041846CE;
        Wed, 15 Mar 2023 15:47:29 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: dma: rz-dmac: Document clock-names and reset-names
Date:   Wed, 15 Mar 2023 06:47:25 +0000
Message-Id: <20230315064726.22739-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document clock-names and reset-names properties as we have multiple
clocks and resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index f638d3934e71..c284abc6784a 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -54,6 +54,11 @@ properties:
       - description: DMA main clock
       - description: DMA register access clock
 
+  clock-names:
+    items:
+      - const: main
+      - const: register
+
   '#dma-cells':
     const: 1
     description:
@@ -77,16 +82,23 @@ properties:
       - description: Reset for DMA ARESETN reset terminal
       - description: Reset for DMA RST_ASYNC reset terminal
 
+  reset-names:
+    items:
+      - const: arst
+      - const: rst_async
+
 required:
   - compatible
   - reg
   - interrupts
   - interrupt-names
   - clocks
+  - clock-names
   - '#dma-cells'
   - dma-channels
   - power-domains
   - resets
+  - reset-names
 
 additionalProperties: false
 
@@ -124,9 +136,11 @@ examples:
                           "ch12", "ch13", "ch14", "ch15";
         clocks = <&cpg CPG_MOD R9A07G044_DMAC_ACLK>,
                  <&cpg CPG_MOD R9A07G044_DMAC_PCLK>;
+        clock-names = "main", "register";
         power-domains = <&cpg>;
         resets = <&cpg R9A07G044_DMAC_ARESETN>,
                  <&cpg R9A07G044_DMAC_RST_ASYNC>;
+        reset-names = "arst", "rst_async";
         #dma-cells = <1>;
         dma-channels = <16>;
     };
-- 
2.25.1

