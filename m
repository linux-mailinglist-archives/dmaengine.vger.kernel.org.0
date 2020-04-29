Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18681BEAE2
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgD2V6a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 17:58:30 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:53190 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727792AbgD2V63 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 17:58:29 -0400
X-IronPort-AV: E=Sophos;i="5.73,333,1583161200"; 
   d="scan'208";a="45795855"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Apr 2020 06:58:28 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9ADD740ECBAC;
        Thu, 30 Apr 2020 06:58:24 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 10/18] dt-bindings: rcar-dmac: Document r8a7742 support
Date:   Wed, 29 Apr 2020 22:56:47 +0100
Message-Id: <1588197415-13747-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Renesas RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
Document RZ/G1H (also known as R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index b7f81c6..1168cd5 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -16,6 +16,7 @@ Required Properties:
 
 - compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.
 	      Examples with soctypes are:
+		- "renesas,dmac-r8a7742" (RZ/G1H)
 		- "renesas,dmac-r8a7743" (RZ/G1M)
 		- "renesas,dmac-r8a7744" (RZ/G1N)
 		- "renesas,dmac-r8a7745" (RZ/G1E)
-- 
2.7.4

