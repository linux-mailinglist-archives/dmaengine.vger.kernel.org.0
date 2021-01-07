Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC292ED68E
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jan 2021 19:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbhAGSQf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Jan 2021 13:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbhAGSQ3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Jan 2021 13:16:29 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C8C0612FD
        for <dmaengine@vger.kernel.org>; Thu,  7 Jan 2021 10:15:29 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id DuFT2400P4C55Sk01uFTp2; Thu, 07 Jan 2021 19:15:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxZok-001v2n-W4; Thu, 07 Jan 2021 19:15:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxZok-008AYv-DM; Thu, 07 Jan 2021 19:15:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] dt-bindings: renesas,rcar-dmac: Add r8a779a0 support
Date:   Thu,  7 Jan 2021 19:15:21 +0100
Message-Id: <20210107181524.1947173-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107181524.1947173-1-geert+renesas@glider.be>
References: <20210107181524.1947173-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the compatible value for the Direct Memory Access Controller
blocks in the Renesas R-Car V3U (R8A779A0) SoC.

The most visible difference with DMAC blocks on other R-Car SoCs is the
move of the per-channel registers to a separate register block.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/dma/renesas,rcar-dmac.yaml       | 76 ++++++++++++-------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
index c07eb6f2fc8d2f12..7f2a54bc732d3a19 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
@@ -14,34 +14,37 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,dmac-r8a7742  # RZ/G1H
-          - renesas,dmac-r8a7743  # RZ/G1M
-          - renesas,dmac-r8a7744  # RZ/G1N
-          - renesas,dmac-r8a7745  # RZ/G1E
-          - renesas,dmac-r8a77470 # RZ/G1C
-          - renesas,dmac-r8a774a1 # RZ/G2M
-          - renesas,dmac-r8a774b1 # RZ/G2N
-          - renesas,dmac-r8a774c0 # RZ/G2E
-          - renesas,dmac-r8a774e1 # RZ/G2H
-          - renesas,dmac-r8a7790  # R-Car H2
-          - renesas,dmac-r8a7791  # R-Car M2-W
-          - renesas,dmac-r8a7792  # R-Car V2H
-          - renesas,dmac-r8a7793  # R-Car M2-N
-          - renesas,dmac-r8a7794  # R-Car E2
-          - renesas,dmac-r8a7795  # R-Car H3
-          - renesas,dmac-r8a7796  # R-Car M3-W
-          - renesas,dmac-r8a77961 # R-Car M3-W+
-          - renesas,dmac-r8a77965 # R-Car M3-N
-          - renesas,dmac-r8a77970 # R-Car V3M
-          - renesas,dmac-r8a77980 # R-Car V3H
-          - renesas,dmac-r8a77990 # R-Car E3
-          - renesas,dmac-r8a77995 # R-Car D3
-      - const: renesas,rcar-dmac
-
-  reg:
-    maxItems: 1
+    oneOf:
+      - items:
+          - enum:
+              - renesas,dmac-r8a7742  # RZ/G1H
+              - renesas,dmac-r8a7743  # RZ/G1M
+              - renesas,dmac-r8a7744  # RZ/G1N
+              - renesas,dmac-r8a7745  # RZ/G1E
+              - renesas,dmac-r8a77470 # RZ/G1C
+              - renesas,dmac-r8a774a1 # RZ/G2M
+              - renesas,dmac-r8a774b1 # RZ/G2N
+              - renesas,dmac-r8a774c0 # RZ/G2E
+              - renesas,dmac-r8a774e1 # RZ/G2H
+              - renesas,dmac-r8a7790  # R-Car H2
+              - renesas,dmac-r8a7791  # R-Car M2-W
+              - renesas,dmac-r8a7792  # R-Car V2H
+              - renesas,dmac-r8a7793  # R-Car M2-N
+              - renesas,dmac-r8a7794  # R-Car E2
+              - renesas,dmac-r8a7795  # R-Car H3
+              - renesas,dmac-r8a7796  # R-Car M3-W
+              - renesas,dmac-r8a77961 # R-Car M3-W+
+              - renesas,dmac-r8a77965 # R-Car M3-N
+              - renesas,dmac-r8a77970 # R-Car V3M
+              - renesas,dmac-r8a77980 # R-Car V3H
+              - renesas,dmac-r8a77990 # R-Car E3
+              - renesas,dmac-r8a77995 # R-Car D3
+          - const: renesas,rcar-dmac
+
+      - items:
+          - const: renesas,dmac-r8a779a0 # R-Car V3U
+
+  reg: true
 
   interrupts:
     minItems: 9
@@ -110,6 +113,23 @@ required:
   - power-domains
   - resets
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,dmac-r8a779a0
+then:
+  properties:
+    reg:
+      items:
+        - description: Base register block
+        - description: Channel register block
+else:
+  properties:
+    reg:
+      maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

