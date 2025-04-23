Return-Path: <dmaengine+bounces-5009-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79EBA98D38
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 16:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F6E7A9B98
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0EE280A50;
	Wed, 23 Apr 2025 14:34:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EE27D773;
	Wed, 23 Apr 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418885; cv=none; b=Zbj2IEQ2KW0hgM9yc85QyVBfM0EMoWVixx3EXZ6sKit53m3ZD7W2efgM5UyahqMygXFuHYFu/YiT9uAKT16q+KA26bOecl1FEbT38k8478H/iYF+p9ydm1Y5ZfGHAYdsAKImZhtf40u8Sk4a0QNHMv53ztbcrgszXEpySjBKSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418885; c=relaxed/simple;
	bh=ytyL/idyefayAOq23DjssQpwuPX1IeVcZWAZtJQo580=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TcEGh2zm2jQaHV/aQOv8ayi4VieN0EIwMWlU2gEdO6966TQGFFkMlvXWkIxSkcp88w2gXGdq7PpvfzzXn0ATNjQ9vzqTanVWtTLeMPVD402pAZXpkAqsNAzWV2l9pznzaajShyxTELr69/QmTW2CWW6N6DsO1N9dVIA6ez/cqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: wcRJKylATvKffxLYGrJ6yw==
X-CSE-MsgGUID: 73FtSGL8Qi+69ZIm34odhg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Apr 2025 23:34:42 +0900
Received: from mulinux.home (unknown [10.226.92.16])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1703F42722E5;
	Wed, 23 Apr 2025 23:34:37 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
Date: Wed, 23 Apr 2025 15:34:18 +0100
Message-Id: <20250423143422.3747702-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423143422.3747702-1-fabrizio.castro.jz@renesas.com>
References: <20250423143422.3747702-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
Renesas RZ/G2L family of SoCs, but there are some differences:
* It only uses one register area
* It only uses one clock
* It only uses one reset
* Instead of using MID/IRD it uses REQ No
* It is connected to the Interrupt Control Unit (ICU)

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v6->v7:
* Improved the descriptions related to property `renesas,icu`.
* Collected tags.
v5->v6:
* Reworked the description of `#dma-cells`.
* Reworked `renesas,icu` related descriptions.
* Added `reg:`->`minItems: 2` for `renesas,r7s72100-dmac`.
* Since the structure of the document remains the same, I have kept
  the tags I have received. Please let me know if that's not okay.
v4->v5:
* Removed ACK No from the specification of the dma cell.
* I have kept the tags received as this is a minor change and the
  structure remains the same as v4. Please let me know if this is
  not okay.
v3->v4:
* No change.
v2->v3:
* No change.
v1->v2:
* Removed RZ/V2H DMAC example.
* Improved the readability of the `if` statement.
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 101 ++++++++++++++----
 1 file changed, 82 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 82de3b927479..92b12762c472 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -11,19 +11,23 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r7s72100-dmac # RZ/A1H
-          - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
-          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
-          - renesas,r9a07g054-dmac # RZ/V2L
-          - renesas,r9a08g045-dmac # RZ/G3S
-      - const: renesas,rz-dmac
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r7s72100-dmac # RZ/A1H
+              - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
+              - renesas,r9a07g044-dmac # RZ/G2{L,LC}
+              - renesas,r9a07g054-dmac # RZ/V2L
+              - renesas,r9a08g045-dmac # RZ/G3S
+          - const: renesas,rz-dmac
+
+      - const: renesas,r9a09g057-dmac # RZ/V2H(P)
 
   reg:
     items:
       - description: Control and channel register block
       - description: DMA extended resource selector block
+    minItems: 1
 
   interrupts:
     maxItems: 17
@@ -52,6 +56,7 @@ properties:
     items:
       - description: DMA main clock
       - description: DMA register access clock
+    minItems: 1
 
   clock-names:
     items:
@@ -61,10 +66,10 @@ properties:
   '#dma-cells':
     const: 1
     description:
-      The cell specifies the encoded MID/RID values of the DMAC port
-      connected to the DMA client and the slave channel configuration
-      parameters.
-      bits[0:9] - Specifies MID/RID value
+      The cell specifies the encoded MID/RID or the REQ No values of
+      the DMAC port connected to the DMA client and the slave channel
+      configuration parameters.
+      bits[0:9] - Specifies the MID/RID or the REQ No value
       bit[10] - Specifies DMA request high enable (HIEN)
       bit[11] - Specifies DMA request detection type (LVL)
       bits[12:14] - Specifies DMAACK output mode (AM)
@@ -80,12 +85,26 @@ properties:
     items:
       - description: Reset for DMA ARESETN reset terminal
       - description: Reset for DMA RST_ASYNC reset terminal
+    minItems: 1
 
   reset-names:
     items:
       - const: arst
       - const: rst_async
 
+  renesas,icu:
+    description:
+      It must contain the phandle to the ICU and the index of the DMAC as seen
+      from the ICU.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the ICU node.
+          - description:
+              The number of the DMAC as seen from the ICU, i.e. parameter k from
+              register ICU_DMkSELy. This may differ from the actual DMAC instance
+              number.
+
 required:
   - compatible
   - reg
@@ -98,13 +117,25 @@ allOf:
   - $ref: dma-controller.yaml#
 
   - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - renesas,r7s72100-dmac
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g043-dmac
+              - renesas,r9a07g044-dmac
+              - renesas,r9a07g054-dmac
+              - renesas,r9a08g045-dmac
     then:
+      properties:
+        reg:
+          minItems: 2
+        clocks:
+          minItems: 2
+        resets:
+          minItems: 2
+
+        renesas,icu: false
+
       required:
         - clocks
         - clock-names
@@ -112,13 +143,45 @@ allOf:
         - resets
         - reset-names
 
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r7s72100-dmac
+    then:
       properties:
+        reg:
+          minItems: 2
+
         clocks: false
         clock-names: false
         power-domains: false
         resets: false
         reset-names: false
+        renesas,icu: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-dmac
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        clocks:
+          maxItems: 1
+        resets:
+          maxItems: 1
+
+        clock-names: false
+        reset-names: false
+
+      required:
+        - clocks
+        - power-domains
+        - renesas,icu
+        - resets
 
 additionalProperties: false
 
-- 
2.34.1


