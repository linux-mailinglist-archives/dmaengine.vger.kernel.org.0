Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D0D4AB1EB
	for <lists+dmaengine@lfdr.de>; Sun,  6 Feb 2022 21:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiBFUIT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 6 Feb 2022 15:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBFUIT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 6 Feb 2022 15:08:19 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 12:08:16 PST
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8516C06173B
        for <dmaengine@vger.kernel.org>; Sun,  6 Feb 2022 12:08:16 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,348,1635174000"; 
   d="scan'208";a="110330710"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Feb 2022 05:03:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.17])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3382740F07D4;
        Mon,  7 Feb 2022 05:03:11 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/G2UL SoC
Date:   Sun,  6 Feb 2022 20:03:08 +0000
Message-Id: <20220206200308.14315-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document RZ/G2UL DMAC bindings. RZ/G2UL DMAC is identical to one found
on the RZ/G2L SoC. No driver changes are required as generic compatible
string "renesas,rz-dmac" will be used as a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch depend upon [1]
[1] https://patchwork.kernel.org/project/linux-dmaengine/patch/20220110134659.30424-9-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index e353377084aa..1e25c5b0fb4d 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/dma/renesas,rz-dmac.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/{G2L,V2L} DMA Controller
+title: Renesas RZ/{G2L,G2UL,V2L} DMA Controller
 
 maintainers:
   - Biju Das <biju.das.jz@bp.renesas.com>
@@ -16,6 +16,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-dmac # RZ/G2UL
           - renesas,r9a07g044-dmac # RZ/G2{L,LC}
           - renesas,r9a07g054-dmac # RZ/V2L
       - const: renesas,rz-dmac
-- 
2.17.1

