Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33DC25BBCF
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 09:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgICHiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 03:38:20 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:34171 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgICHiS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Sep 2020 03:38:18 -0400
X-IronPort-AV: E=Sophos;i="5.76,385,1592838000"; 
   d="scan'208";a="56050743"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 16:38:16 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 751D641F27AD;
        Thu,  3 Sep 2020 16:38:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [RESEND PATCH v2] dt-bindings: renesas,rcar-dmac: Document r8a7742 support
Date:   Thu,  3 Sep 2020 08:38:13 +0100
Message-Id: <20200903073813.4490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Renesas RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
Document RZ/G1H (also known as R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
Hi Vinod,

As requested I am resending just the DT documentation patch.

v2 - https://patchwork.kernel.org/patch/11524771/

Cheers,
Prabhakar
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
index 13f1a46be40d..b548e4723936 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,dmac-r8a7742  # RZ/G1H
           - renesas,dmac-r8a7743  # RZ/G1M
           - renesas,dmac-r8a7744  # RZ/G1N
           - renesas,dmac-r8a7745  # RZ/G1E
-- 
2.17.1

