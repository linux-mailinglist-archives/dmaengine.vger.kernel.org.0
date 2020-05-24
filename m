Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF6C1E034A
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2020 23:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbgEXVjh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 May 2020 17:39:37 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:17581 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387879AbgEXVjh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 May 2020 17:39:37 -0400
X-IronPort-AV: E=Sophos;i="5.73,431,1583161200"; 
   d="scan'208";a="47678148"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 May 2020 06:39:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 815BE40E3D58;
        Mon, 25 May 2020 06:39:16 +0900 (JST)
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
Subject: [PATCH 2/8] dt-bindings: PCI: pci-rcar-gen2: Add device tree support for r8a7742
Date:   Sun, 24 May 2020 22:37:51 +0100
Message-Id: <1590356277-19993-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add internal PCI bridge support for r8a7742 SoC. The Renesas RZ/G1H
(R8A7742) internal PCI bridge is identical to the R-Car Gen2 family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index b94078f..aeba38f 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -6,7 +6,8 @@ AHB. There is one bridge instance per USB port connected to the internal
 OHCI and EHCI controllers.
 
 Required properties:
-- compatible: "renesas,pci-r8a7743" for the R8A7743 SoC;
+- compatible: "renesas,pci-r8a7742" for the R8A7742 SoC;
+	      "renesas,pci-r8a7743" for the R8A7743 SoC;
 	      "renesas,pci-r8a7744" for the R8A7744 SoC;
 	      "renesas,pci-r8a7745" for the R8A7745 SoC;
 	      "renesas,pci-r8a7790" for the R8A7790 SoC;
-- 
2.7.4

