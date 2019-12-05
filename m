Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEC114193
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2019 14:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfLENhl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Dec 2019 08:37:41 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:48198 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfLENhl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Dec 2019 08:37:41 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id aDde2100M5USYZQ01DdeZU; Thu, 05 Dec 2019 14:37:39 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icrK6-00026q-Fr; Thu, 05 Dec 2019 14:37:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1icrK6-0001YT-Cp; Thu, 05 Dec 2019 14:37:38 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: dmaengine: rcar-dmac: Document r8a77961 support
Date:   Thu,  5 Dec 2019 14:37:36 +0100
Message-Id: <20191205133736.5934-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document support for the system DMA controller in the Renesas R-Car
M3-W+ (R8A77961) SoC.

No driver update is needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 5551e929fd99f630..b7f81c63be8bdc33 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -30,6 +30,7 @@ Required Properties:
 		- "renesas,dmac-r8a7794" (R-Car E2)
 		- "renesas,dmac-r8a7795" (R-Car H3)
 		- "renesas,dmac-r8a7796" (R-Car M3-W)
+		- "renesas,dmac-r8a77961" (R-Car M3-W+)
 		- "renesas,dmac-r8a77965" (R-Car M3-N)
 		- "renesas,dmac-r8a77970" (R-Car V3M)
 		- "renesas,dmac-r8a77980" (R-Car V3H)
-- 
2.17.1

