Return-Path: <dmaengine+bounces-4551-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 389D3A3DDAE
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 16:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2B57A3332
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3151DE3A7;
	Thu, 20 Feb 2025 15:01:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCF71D5CF2;
	Thu, 20 Feb 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063694; cv=none; b=Jg/oDjlTx8etH/iSvX6Tf3/gvPSExywgllRVs0MpKwTFUW20kOyOsb2K7GC/alAx6oIt1oR+JfP9TqjNs+ClsJ52uzbYqWSjzMZ4oS5HpEeXLFGXxxe1BQ3+lygbOWxiBjAFraAMkQkjwrYmQGzJAf7zh7nfVlTSRfVuo//K7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063694; c=relaxed/simple;
	bh=c4edLnlYaJztPjFMrGE2znXm3JwnJ3t7K78QCLZA6Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YNNTrOb4sBlLPYkdfOMBymS6VrbpWL5OisXTMfeDsj9LSlpymC9VoHSpiWNfYROx0tPmu9LF1mjIZXGkMDXwlFPVXVm8E4AKUbytZYF4QqtLqRVSVIJGf4k0HeNCsCkEOsGl2+a2B68f2B5J+/Bi8z8GNivIo7uJ5yM4HzYnTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: rSBCXq1nRr+m/mxjfNDSBw==
X-CSE-MsgGUID: eaUx7H5LS+aW6XpCVlNs2Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Feb 2025 00:01:30 +0900
Received: from mulinux.example.org (unknown [10.226.92.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B8C6542C8306;
	Fri, 21 Feb 2025 00:01:26 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
Date: Thu, 20 Feb 2025 15:01:06 +0000
Message-Id: <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
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
* Instead of using MID/IRD it uses REQ NO/ACK NO
* It is connected to the Interrupt Control Unit (ICU)

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v3->v4:
* No change.
v2->v3:
* No change.
v1->v2:
* Removed RZ/V2H DMAC example.
* Improved the readability of the `if` statement.
---
 .../bindings/dma/renesas,rz-dmac.yaml         | 107 +++++++++++++++---
 1 file changed, 89 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 82de3b927479..4b89d199c022 100644
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
@@ -61,14 +66,22 @@ properties:
   '#dma-cells':
     const: 1
     description:
-      The cell specifies the encoded MID/RID values of the DMAC port
-      connected to the DMA client and the slave channel configuration
-      parameters.
+      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs, the cell
+      specifies the encoded MID/RID values of the DMAC port connected to the
+      DMA client and the slave channel configuration parameters.
       bits[0:9] - Specifies MID/RID value
       bit[10] - Specifies DMA request high enable (HIEN)
       bit[11] - Specifies DMA request detection type (LVL)
       bits[12:14] - Specifies DMAACK output mode (AM)
       bit[15] - Specifies Transfer Mode (TM)
+      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO, and the
+      slave channel configuration parameters.
+      bits[0:9] - Specifies the REQ NO
+      bits[10:16] - Specifies the ACK NO
+      bit[17] - Specifies DMA request high enable (HIEN)
+      bit[18] - Specifies DMA request detection type (LVL)
+      bits[19:21] - Specifies DMAACK output mode (AM)
+      bit[22] - Specifies Transfer Mode (TM)
 
   dma-channels:
     const: 16
@@ -80,12 +93,29 @@ properties:
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
+      On the RZ/V2H(P) SoC configures the ICU to which the DMAC is connected to.
+      It must contain the phandle to the ICU, and the index of the DMAC as seen
+      from the ICU (e.g. parameter k from register ICU_DMkSELy).
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the ICU node.
+          - description: The DMAC index.
+              4 for DMAC0
+              0 for DMAC1
+              1 for DMAC2
+              2 for DMAC3
+              3 for DMAC4
+
 required:
   - compatible
   - reg
@@ -98,13 +128,25 @@ allOf:
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
@@ -112,13 +154,42 @@ allOf:
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


