Return-Path: <dmaengine+bounces-4321-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48407A2B4AD
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 23:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E873A66B7
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 22:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0925022FF38;
	Thu,  6 Feb 2025 22:03:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E923908E;
	Thu,  6 Feb 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879413; cv=none; b=soiARMp6IJy5zplikQRSHxG2wTA5XRzygfKdHLJwkq3wldKFTMtIhgKThzZjK2UrlxbN8tqC5Ka7ZLIQEspIjsaY7sWVEFbIIS+YAxoStGVZKCsGQxDEmMk5x0kw737kRDjlWyC5LrKLuMW9Y7xnfX7RFrpf9Yzg7iO9nxMPKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879413; c=relaxed/simple;
	bh=VzwUIlUNsYR3IUvd79NMgBs63LVlWJuqP965TSTFG9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mli+UKI/UoMual6lkj6BE8zjh+rOPLRf/DaMBrjMURtbJJbj08qNpNrBIo/+pADVf9jLk+i5i8QRLbfpu2n7ElmfzXR06dihzTbsmjml9rGSF6AgkSLHOHt8xgpFd2waPAN/Tb/aHA8rpll9barlrvwizh6jqEmZbHxvAyEmuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 9JmMVHxNRwOKL49DmlJoQw==
X-CSE-MsgGUID: lx80E4IAQdyI9b/yQ0P9mw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Feb 2025 07:03:31 +0900
Received: from mulinux.example.org (unknown [10.226.93.55])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5B2C540AF2B1;
	Fri,  7 Feb 2025 07:03:27 +0900 (JST)
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
Subject: [PATCH 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
Date: Thu,  6 Feb 2025 22:03:04 +0000
Message-Id: <20250206220308.76669-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
References: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
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
 .../bindings/dma/renesas,rz-dmac.yaml         | 152 +++++++++++++++---
 1 file changed, 127 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 82de3b927479..d4dd22432e49 100644
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
@@ -98,27 +128,62 @@ allOf:
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
+            const: renesas,r9a09g057-dmac
     then:
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
       required:
         - clocks
-        - clock-names
         - power-domains
+        - renesas,icu
         - resets
-        - reset-names
 
     else:
-      properties:
-        clocks: false
-        clock-names: false
-        power-domains: false
-        resets: false
-        reset-names: false
+      if:
+        not:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - renesas,r7s72100-dmac
+      then:
+        properties:
+          reg:
+            minItems: 2
+          clocks:
+            minItems: 2
+          resets:
+            minItems: 2
+
+          renesas,icu: false
+
+        required:
+          - clocks
+          - clock-names
+          - power-domains
+          - resets
+          - reset-names
+
+      else:
+        properties:
+          clocks: false
+          clock-names: false
+          power-domains: false
+          resets: false
+          reset-names: false
+          renesas,icu: false
 
 additionalProperties: false
 
@@ -164,3 +229,40 @@ examples:
         #dma-cells = <1>;
         dma-channels = <16>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+    dmac0: dma-controller@11400000 {
+        compatible = "renesas,r9a09g057-dmac";
+        reg = <0x11400000 0x10000>;
+        interrupts = <GIC_SPI 499 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 89  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 90  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 91  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 92  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 93  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 94  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 95  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 96  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 97  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 98  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 99  IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 100 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 101 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 103 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 104 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "error",
+                          "ch0", "ch1", "ch2", "ch3",
+                          "ch4", "ch5", "ch6", "ch7",
+                          "ch8", "ch9", "ch10", "ch11",
+                          "ch12", "ch13", "ch14", "ch15";
+        clocks = <&cpg CPG_MOD 0x0>;
+        power-domains = <&cpg>;
+        resets = <&cpg 0x31>;
+        #dma-cells = <1>;
+        dma-channels = <16>;
+        renesas,icu = <&icu 4>;
+    };
-- 
2.34.1


