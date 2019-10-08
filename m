Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43011CF747
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 12:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfJHKjX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 06:39:23 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:42391 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730511AbfJHKjW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 06:39:22 -0400
X-IronPort-AV: E=Sophos;i="5.67,270,1566831600"; 
   d="scan'208";a="28578207"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Oct 2019 19:39:21 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2A0AD4009677;
        Tue,  8 Oct 2019 19:39:16 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH 04/10] dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1 support
Date:   Tue,  8 Oct 2019 11:38:46 +0100
Message-Id: <1570531132-21856-5-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570531132-21856-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document RZ/G2N (R8A774B1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
index 9d98266..0fe433b 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
@@ -9,6 +9,8 @@ need this driver.
 Required properties:
 - compatible: "renesas,r8a774a1-usb3-phy" if the device is a part of an R8A774A1
 	      SoC.
+	      "renesas,r8a774b1-usb3-phy" if the device is a part of an R8A774B1
+	      SoC.
 	      "renesas,r8a7795-usb3-phy" if the device is a part of an R8A7795
 	      SoC.
 	      "renesas,r8a7796-usb3-phy" if the device is a part of an R8A7796
-- 
2.7.4

