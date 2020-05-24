Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD5A1E0341
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2020 23:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbgEXVis (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 May 2020 17:38:48 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:11437 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387879AbgEXVis (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 May 2020 17:38:48 -0400
X-IronPort-AV: E=Sophos;i="5.73,430,1583161200"; 
   d="scan'208";a="47890422"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 May 2020 06:38:46 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 425E340E3D52;
        Mon, 25 May 2020 06:38:43 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/8] dt-bindings: phy: rcar-gen2: Add r8a7742 support
Date:   Sun, 24 May 2020 22:37:50 +0100
Message-Id: <1590356277-19993-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add USB PHY support for r8a7742 SoC. Renesas RZ/G1H (R8A7742)
USB PHY is identical to the R-Car Gen2 family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
index ac96d64..a3bd1c4 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -4,7 +4,8 @@ This file provides information on what the device node for the R-Car generation
 2 USB PHY contains.
 
 Required properties:
-- compatible: "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
+- compatible: "renesas,usb-phy-r8a7742" if the device is a part of R8A7742 SoC.
+	      "renesas,usb-phy-r8a7743" if the device is a part of R8A7743 SoC.
 	      "renesas,usb-phy-r8a7744" if the device is a part of R8A7744 SoC.
 	      "renesas,usb-phy-r8a7745" if the device is a part of R8A7745 SoC.
 	      "renesas,usb-phy-r8a77470" if the device is a part of R8A77470 SoC.
-- 
2.7.4

