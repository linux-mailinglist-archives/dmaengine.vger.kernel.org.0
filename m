Return-Path: <dmaengine+bounces-175-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9732E7F4B45
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 16:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C07B20FFA
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA465A119;
	Wed, 22 Nov 2023 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ur1Qzyg4"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5AE2122;
	Wed, 22 Nov 2023 07:42:56 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFgnfh033558;
	Wed, 22 Nov 2023 09:42:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700667769;
	bh=OxRmiBN3Pgu3iPmL7lCCvrMnZB2uL46cCr5d6yuQLOw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ur1Qzyg4cQ4PMOXxnyMSs9fU5rKBzjuck7RuqLYYpWg0odjXvbOPFAWpprSeReLZc
	 r4QoeOwGmW5A0HtSL1uyDVaPHlpxTIXAlKtM3XHbGX18BeqSsE7VwKQVXzpOPdAPl+
	 PrujKbv3KeJAGfdktCdVAi66pD3Bjy1/B/T67gHE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFgnq8085986
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Nov 2023 09:42:49 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:42:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:42:49 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFggJm046973;
	Wed, 22 Nov 2023 09:42:46 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/4] dt-bindings: dma: ti: k3-*: Add descriptions for register regions
Date: Wed, 22 Nov 2023 21:12:35 +0530
Message-ID: <20231122154238.815781-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231122154238.815781-1-vigneshr@ti.com>
References: <20231122154238.815781-1-vigneshr@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

In preparation for introducing more register regions, add description
for existing register regions so that its easier to map reg-names to
that of SoC Documentations/TRMs.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 26 +++++++++++--------
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml |  6 ++++-
 .../devicetree/bindings/dma/ti/k3-udma.yaml   |  5 +++-
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 4ca300a42a99..b5444800b036 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -35,14 +35,6 @@ properties:
       - ti,am64-dmss-bcdma
       - ti,j721s2-dmss-bcdma-csi
 
-  reg:
-    minItems: 3
-    maxItems: 5
-
-  reg-names:
-    minItems: 3
-    maxItems: 5
-
   "#dma-cells":
     const: 3
     description: |
@@ -141,7 +133,10 @@ allOf:
         ti,sci-rm-range-tchan: false
 
         reg:
-          maxItems: 3
+          items:
+            - description: BCDMA Control /Status Registers region
+            - description: RX Channel Realtime Registers region
+            - description: Ring Realtime Registers region
 
         reg-names:
           items:
@@ -160,7 +155,12 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 5
+          items:
+            - description: BCDMA Control /Status Registers region
+            - description: Block Copy Channel Realtime Registers region
+            - description: RX Channel Realtime Registers region
+            - description: TX Channel Realtime Registers region
+            - description: Ring Realtime Registers region
 
         reg-names:
           items:
@@ -184,7 +184,11 @@ allOf:
         ti,sci-rm-range-bchan: false
 
         reg:
-          maxItems: 4
+          items:
+            - description: BCDMA Control /Status Registers region
+            - description: RX Channel Realtime Registers region
+            - description: TX Channel Realtime Registers region
+            - description: Ring Realtime Registers region
 
         reg-names:
           items:
diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
index a69f62f854d8..3580b08f65c6 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -45,7 +45,11 @@ properties:
       The second cell is the ASEL value for the channel
 
   reg:
-    maxItems: 4
+    items:
+      - description: Packet DMA Control /Status Registers region
+      - description: RX Channel Realtime Registers region
+      - description: TX Channel Realtime Registers region
+      - description: Ring Realtime Registers region
 
   reg-names:
     items:
diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index 22f6c5e2f7f4..ded588bd079a 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -69,7 +69,10 @@ properties:
       - ti,j721e-navss-mcu-udmap
 
   reg:
-    maxItems: 3
+    items:
+      - description: UDMA-P Control /Status Registers region
+      - description: RX Channel Realtime Registers region
+      - description: TX Channel Realtime Registers region
 
   reg-names:
     items:
-- 
2.42.0


