Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA41C2F90
	for <lists+dmaengine@lfdr.de>; Sun,  3 May 2020 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgECVrQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 3 May 2020 17:47:16 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:4267 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729104AbgECVrP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 3 May 2020 17:47:15 -0400
X-IronPort-AV: E=Sophos;i="5.73,349,1583161200"; 
   d="scan'208";a="46232084"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 May 2020 06:47:13 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3F65B4006DF9;
        Mon,  4 May 2020 06:47:10 +0900 (JST)
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
Subject: [PATCH v2 01/10] dt-bindings: pinctrl: sh-pfc: Document r8a7742 PFC support
Date:   Sun,  3 May 2020 22:46:45 +0100
Message-Id: <1588542414-14826-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588542414-14826-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document PFC support for the RZ/G1H (R8A7742) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index 6eada23eaa31..b68613188c19 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -13,6 +13,7 @@ Required Properties:
     - "renesas,pfc-emev2": for EMEV2 (EMMA Mobile EV2) compatible pin-controller.
     - "renesas,pfc-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible pin-controller.
     - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
+    - "renesas,pfc-r8a7742": for R8A7742 (RZ/G1H) compatible pin-controller.
     - "renesas,pfc-r8a7743": for R8A7743 (RZ/G1M) compatible pin-controller.
     - "renesas,pfc-r8a7744": for R8A7744 (RZ/G1N) compatible pin-controller.
     - "renesas,pfc-r8a7745": for R8A7745 (RZ/G1E) compatible pin-controller.
-- 
2.17.1

