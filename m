Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A111C0385
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 12:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfI0Kh3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Sep 2019 06:37:29 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:56641 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbfI0Kh3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Sep 2019 06:37:29 -0400
X-IronPort-AV: E=Sophos;i="5.64,555,1559487600"; 
   d="scan'208";a="27461305"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Sep 2019 19:37:26 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 786AA41AF5F1;
        Fri, 27 Sep 2019 19:37:24 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Biju Das <biju.das@bp.renesas.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: dmaengine: rcar-dmac: Document R8A774B1 bindings
Date:   Fri, 27 Sep 2019 11:37:09 +0100
Message-Id: <1569580629-55677-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Renesas RZ/G2N (R8A774B1) SoC also has the R-Car gen2/3 compatible
DMA controllers, therefore document RZ/G2N specific bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V1-->V2
  * Incorporated Geert's review comment
  * Added Geert's reviewed by tag
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 5a512c5..5551e92 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -21,6 +21,7 @@ Required Properties:
 		- "renesas,dmac-r8a7745" (RZ/G1E)
 		- "renesas,dmac-r8a77470" (RZ/G1C)
 		- "renesas,dmac-r8a774a1" (RZ/G2M)
+		- "renesas,dmac-r8a774b1" (RZ/G2N)
 		- "renesas,dmac-r8a774c0" (RZ/G2E)
 		- "renesas,dmac-r8a7790" (R-Car H2)
 		- "renesas,dmac-r8a7791" (R-Car M2-W)
-- 
2.7.4

