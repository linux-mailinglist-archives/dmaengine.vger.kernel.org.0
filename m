Return-Path: <dmaengine+bounces-7513-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2ECA82AF
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3F23221F86
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A93345CDC;
	Fri,  5 Dec 2025 15:14:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A033FE08;
	Fri,  5 Dec 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947651; cv=none; b=SIGJxA/KTbto6kbRWDKOtY8mjc2dgz+pmpYKotMY0y1sHQFzTGAjL2X5EvzpifTRVxLMcUcI4MbLWJj8HohpEHh1mT0xuxwAOYJQODGkCfkhskVoTZw24SVhSXtJPa94gs3aCaGU/AVmDBTfYRizDTWNBOn+atMrJlwBKjynFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947651; c=relaxed/simple;
	bh=ukb1UAwmqxDBbf6H+og+mlmMTI5A9pD1u9Se2kBCWOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqLYZe1ikyGgQw9OrAQnEeiCn8Kq1HXEDPvKuvvaapZDrMUf9uSoOUVfyBmNC/drgUS6WWkDafd89N9qJNdEPMyjMeDf2Pju3YDwdOITt1RLpLjIbUPLYWPsXhmDicqwFwv4iNMS8v5ZdTr0MYGn6c+4uRjvysTTgknnJKX/8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: hUMuIR75SDKFo2Fnt02k6Q==
X-CSE-MsgGUID: ptbN+7ocRsyHC8p0hJzpCQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2025 00:14:04 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.202])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5ADD44005E29;
	Sat,  6 Dec 2025 00:14:00 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 3/6] dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
Date: Fri,  5 Dec 2025 17:12:51 +0200
Message-ID: <20251205151254.2970669-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251205151254.2970669-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251205151254.2970669-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three
DMAC instances. Compared to the previously supported RZ/V2H, these SoCs
are missing the error interrupt line and the reset lines, and they use
a different ICU IP.

Document them, and use RZ/T2H as a fallback for RZ/N2H as the DMACs are
entirely compatible.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

V3:
 * pick up Rob's Reviewed-by tag

V2:
 * remove notes

 .../bindings/dma/renesas,rz-dmac.yaml         | 100 ++++++++++++++----
 1 file changed, 82 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index f891cfcc48c7..f7bcdb4a29ca 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -28,6 +28,13 @@ properties:
 
       - const: renesas,r9a09g057-dmac # RZ/V2H(P)
 
+      - const: renesas,r9a09g077-dmac # RZ/T2H
+
+      - items:
+          - enum:
+              - renesas,r9a09g087-dmac # RZ/N2H
+          - const: renesas,r9a09g077-dmac
+
   reg:
     items:
       - description: Control and channel register block
@@ -35,27 +42,12 @@ properties:
     minItems: 1
 
   interrupts:
+    minItems: 16
     maxItems: 17
 
   interrupt-names:
-    items:
-      - const: error
-      - const: ch0
-      - const: ch1
-      - const: ch2
-      - const: ch3
-      - const: ch4
-      - const: ch5
-      - const: ch6
-      - const: ch7
-      - const: ch8
-      - const: ch9
-      - const: ch10
-      - const: ch11
-      - const: ch12
-      - const: ch13
-      - const: ch14
-      - const: ch15
+    minItems: 16
+    maxItems: 17
 
   clocks:
     items:
@@ -121,6 +113,35 @@ required:
 allOf:
   - $ref: dma-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rz-dmac
+              - renesas,r9a09g057-dmac
+    then:
+      properties:
+        interrupt-names:
+          items:
+            - const: error
+            - const: ch0
+            - const: ch1
+            - const: ch2
+            - const: ch3
+            - const: ch4
+            - const: ch5
+            - const: ch6
+            - const: ch7
+            - const: ch8
+            - const: ch9
+            - const: ch10
+            - const: ch11
+            - const: ch12
+            - const: ch13
+            - const: ch14
+            - const: ch15
+
   - if:
       properties:
         compatible:
@@ -188,6 +209,49 @@ allOf:
         - renesas,icu
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-dmac
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        clocks:
+          maxItems: 1
+
+        clock-names: false
+        resets: false
+        reset-names: false
+
+        interrupts:
+          maxItems: 16
+
+        interrupt-names:
+          items:
+            - const: ch0
+            - const: ch1
+            - const: ch2
+            - const: ch3
+            - const: ch4
+            - const: ch5
+            - const: ch6
+            - const: ch7
+            - const: ch8
+            - const: ch9
+            - const: ch10
+            - const: ch11
+            - const: ch12
+            - const: ch13
+            - const: ch14
+            - const: ch15
+
+      required:
+        - clocks
+        - power-domains
+        - renesas,icu
+
 additionalProperties: false
 
 examples:
-- 
2.52.0

