Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA81C2FB3
	for <lists+dmaengine@lfdr.de>; Sun,  3 May 2020 23:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgECVrn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 3 May 2020 17:47:43 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:12329 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729287AbgECVrn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 3 May 2020 17:47:43 -0400
X-IronPort-AV: E=Sophos;i="5.73,349,1583161200"; 
   d="scan'208";a="46232113"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 May 2020 06:47:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0A6E84006DF9;
        Mon,  4 May 2020 06:47:37 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 08/10] dt-bindings: arm: Document iW-RainboW-G21D-Qseven-RZG1H board
Date:   Sun,  3 May 2020 22:46:52 +0100
Message-Id: <1588542414-14826-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the iW-RainboW-G21D-Qseven-RZG1H device tree bindings,
listing it as a supported board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 8e85e1c72fc4..b7d2e921150a 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -59,6 +59,13 @@ properties:
               - iwave,g21m
           - const: renesas,r8a7742
 
+      - items:
+          - enum:
+              # iWave Systems RZ/G1H Qseven Development Platform (iW-RainboW-G21D-Qseven)
+              - iwave,g21d
+          - const: iwave,g21m
+          - const: renesas,r8a7742
+
       - description: RZ/G1M (R8A77430)
         items:
           - enum:
-- 
2.17.1

