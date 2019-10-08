Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF79CF744
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfJHKjc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 06:39:32 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:52530 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730582AbfJHKj1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 06:39:27 -0400
X-IronPort-AV: E=Sophos;i="5.67,270,1566831600"; 
   d="scan'208";a="28359370"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Oct 2019 19:39:25 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.36.196])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9A3E2400941B;
        Tue,  8 Oct 2019 19:39:21 +0900 (JST)
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
Subject: [PATCH 05/10] dt-bindings: usb-xhci: Add r8a774b1 support
Date:   Tue,  8 Oct 2019 11:38:47 +0100
Message-Id: <1570531132-21856-6-git-send-email-fabrizio.castro@bp.renesas.com>
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
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 97400e8..2fe9f3c 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -10,6 +10,7 @@ Required properties:
     - "renesas,xhci-r8a7743" for r8a7743 SoC
     - "renesas,xhci-r8a7744" for r8a7744 SoC
     - "renesas,xhci-r8a774a1" for r8a774a1 SoC
+    - "renesas,xhci-r8a774b1" for r8a774b1 SoC
     - "renesas,xhci-r8a774c0" for r8a774c0 SoC
     - "renesas,xhci-r8a7790" for r8a7790 SoC
     - "renesas,xhci-r8a7791" for r8a7791 SoC
-- 
2.7.4

