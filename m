Return-Path: <dmaengine+bounces-8011-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50135CF353B
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A01EF30069BF
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B97332EA2;
	Mon,  5 Jan 2026 11:46:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D6C2F261F;
	Mon,  5 Jan 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613565; cv=none; b=HiEL0wlDS6CxgCeBQbKh4piKM7J26rqIgd/rZS3LCw2V53pyBEonQ0+NzbNfrTftfEKE45DOWWzlgGfry/ZK32tUkMMylBVF5GPRjGd2DtZ8G/mY3SMKJvoNsXLwPjharVi6nlC2sxxa2ORK3Rbx21N8YYMW1yWUHMiNXT74Bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613565; c=relaxed/simple;
	bh=hQUGl/JOIhEClbwG5aqnz0TsDD7fMyK36fqyGEbhh3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZJ5OTQhwC4YIeyNZCfOLqAH9QD1ecSuDu1rHyJMBCRVcrI81tvVeE7ZDq/Z3IP8SooIjFo/qdvXeAgiNfq/FGzUw7Xgu6HAojSqN3myzfOg6i6bqLb381RIN72Q5tmFUmP1fIra2mDyczAouF5FVRDeU+8/GG9IRx0cYRJ/3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: EKTVPgWHQl6uhGQ0WpmPrA==
X-CSE-MsgGUID: qD2P7+7USpOQVnMVTtgGNg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2026 20:46:00 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.160])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7D08141AF7F0;
	Mon,  5 Jan 2026 20:45:55 +0900 (JST)
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
Subject: [PATCH v4 3/4] dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
Date: Mon,  5 Jan 2026 13:44:44 +0200
Message-ID: <20260105114445.878262-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

V4:
 * pick up Geert's Reviewed-by

V3:
 * pick up Rob's Reviewed-by tag

V2:
 * remove notes

 .../bindings/dma/renesas,rz-dmac.yaml         | 100 ++++++++++++++----
 1 file changed, 82 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index d137b9cbaee9..3398868bdaf3 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -29,6 +29,13 @@ properties:
 
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
@@ -36,27 +43,12 @@ properties:
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
@@ -122,6 +114,35 @@ required:
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
@@ -189,6 +210,49 @@ allOf:
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

