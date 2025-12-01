Return-Path: <dmaengine+bounces-7426-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE9C976CB
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 13:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5593A5631
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B630F547;
	Mon,  1 Dec 2025 12:50:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1C630F944;
	Mon,  1 Dec 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593429; cv=none; b=X9koJ25LgkysynmjvG8jbgAa7m/i8vijDWzCQdCRJUOssoVAfi+9j+3Umbbk18BSIqajOYx1kiCyY+XC/8J6lJ8sjBLut7QvnH3fT6ZgmR4fojf1AS2y2kVT8DdR2RawQ4W5JxyjvTszLxJClA/K7Bfhd73jecT+eHw2kc39f5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593429; c=relaxed/simple;
	bh=zFA7eNiL8YbxScfmf3fTKRUWq/qcgQoMV6XqiUB5gwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1+bWzOYfmLzGKO/EmQA6im6GzcYvqssPHqTDjv4gObZ+SZKrBZqmOsay5kDjORo1n3gfwpz6OD39WRLDuEySW+f0Z4rU/1MyPhN3M1gitTu1YG7GmsghoRPJ7lf747Kj6CKfsrt1033n7R56dskJdr/ouAbFm4SCHD+fSI4Hew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: /0Ce4U4uSQCd09pve3Ifow==
X-CSE-MsgGUID: FqSOLICqT8ixMki8KGSDvA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 21:50:25 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E3D3142100DB;
	Mon,  1 Dec 2025 21:50:20 +0900 (JST)
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
Subject: [PATCH v2 3/6] dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
Date: Mon,  1 Dec 2025 14:49:08 +0200
Message-ID: <20251201124911.572395-4-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
---

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

