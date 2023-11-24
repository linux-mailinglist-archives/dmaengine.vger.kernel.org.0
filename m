Return-Path: <dmaengine+bounces-199-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9374D7F6B7F
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 05:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F552816BC
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 04:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D143D6E;
	Fri, 24 Nov 2023 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UECTTwLZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2CD6E;
	Thu, 23 Nov 2023 20:58:04 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vvpS043202;
	Thu, 23 Nov 2023 22:57:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700801877;
	bh=HjBkXljfWp+92EwJDlN9yJARdABEr4KgfTuFDro3yCM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UECTTwLZQJBtqdkxcku7VjuIAnrjR/CnNySAFURiGUvs/9Z7Thl7pyZFtivXWUb98
	 H4lKhgYy8mv/sD8lMPuAHlqF3NINsbh/7zegDWgoV4su+iaTvkevcB48KIDZrnyll9
	 TYCQcIq7hoEnOJQCWay0SMGunw82EPfJglMlRHBQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AO4vv5f076370
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Nov 2023 22:57:57 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 22:57:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 22:57:57 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vo8g004756;
	Thu, 23 Nov 2023 22:57:54 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/4] dt-bindings: dma: ti: k3-*: Add descriptions for register regions
Date: Fri, 24 Nov 2023 10:27:19 +0530
Message-ID: <20231124045722.191817-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124045722.191817-1-vigneshr@ti.com>
References: <20231124045722.191817-1-vigneshr@ti.com>
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
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml   | 18 +++++++++++++++---
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml  |  6 +++++-
 .../devicetree/bindings/dma/ti/k3-udma.yaml    |  5 ++++-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 4ca300a42a99..11727af9df73 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -141,7 +141,10 @@ allOf:
         ti,sci-rm-range-tchan: false
 
         reg:
-          maxItems: 3
+          items:
+            - description: BCDMA Control /Status Registers region
+            - description: RX Channel Realtime Registers region
+            - description: Ring Realtime Registers region
 
         reg-names:
           items:
@@ -160,7 +163,12 @@ allOf:
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
@@ -184,7 +192,11 @@ allOf:
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
2.43.0


