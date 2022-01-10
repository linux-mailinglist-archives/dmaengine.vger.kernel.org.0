Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207A3489A8D
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 14:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiAJNru (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 08:47:50 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:17543 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234254AbiAJNrc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jan 2022 08:47:32 -0500
X-IronPort-AV: E=Sophos;i="5.88,277,1635174000"; 
   d="scan'208";a="106558145"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 22:47:31 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 69EE642E354B;
        Mon, 10 Jan 2022 22:47:29 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 08/12] dt-bindings: dma: rz-dmac: Document RZ/V2L SoC
Date:   Mon, 10 Jan 2022 13:46:55 +0000
Message-Id: <20220110134659.30424-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Document RZ/V2L DMAC bindings. RZ/V2L DMAC is identical to one found on
the RZ/G2L SoC. No driver changes are required as generic compatible
string "renesas,rz-dmac" will be used as a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v1->v2
* Included ACK from ROB
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 7a4f415d74dc..e353377084aa 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/dma/renesas,rz-dmac.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/G2L DMA Controller
+title: Renesas RZ/{G2L,V2L} DMA Controller
 
 maintainers:
   - Biju Das <biju.das.jz@bp.renesas.com>
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - renesas,r9a07g044-dmac # RZ/G2{L,LC}
+          - renesas,r9a07g054-dmac # RZ/V2L
       - const: renesas,rz-dmac
 
   reg:
-- 
2.17.1

