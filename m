Return-Path: <dmaengine+bounces-200-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2637F7F6B81
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 05:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D652A2814E6
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 04:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51933441A;
	Fri, 24 Nov 2023 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gmaFe0vk"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CED6F;
	Thu, 23 Nov 2023 20:58:06 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4w08f043213;
	Thu, 23 Nov 2023 22:58:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700801880;
	bh=Nr4yvQ63vzpR8jqHfgCSy9Z4F3QZkyPd0SgK2o1Puek=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gmaFe0vkxa1e98/bnamHh/Mf3otRudVdOxqh89ystSFq0MIb080N6ji9Dw1AoSVNJ
	 jwl8Ol32lS3W3YjJZUFTGAHMNIyMsaUBgGFg1HLkPrA8Ql5OsodY3FCuDUCux2INhI
	 HTl/6Jup/xBjjZs6d+i74HsBr+G3449DctnXZ//Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AO4w0Ps080884
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Nov 2023 22:58:00 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 22:58:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 22:58:00 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vo8h004756;
	Thu, 23 Nov 2023 22:57:57 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/4] dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
Date: Fri, 24 Nov 2023 10:27:20 +0530
Message-ID: <20231124045722.191817-3-vigneshr@ti.com>
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

Block copy DMA(BCDMA)module on K3 SoCs have ring, BCHAN, TX and RX
channel cfg register regions which are usually configured by a Device
Management firmware. But certain entities such as bootloader (like
U-Boot) may have to access them directly. Describe this region in the
binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
five regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index 11727af9df73..27b8e1636560 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -37,11 +37,11 @@ properties:
 
   reg:
     minItems: 3
-    maxItems: 5
+    maxItems: 9
 
   reg-names:
     minItems: 3
-    maxItems: 5
+    maxItems: 9
 
   "#dma-cells":
     const: 3
@@ -163,20 +163,30 @@ allOf:
     then:
       properties:
         reg:
+          minItems: 5
           items:
             - description: BCDMA Control /Status Registers region
             - description: Block Copy Channel Realtime Registers region
             - description: RX Channel Realtime Registers region
             - description: TX Channel Realtime Registers region
             - description: Ring Realtime Registers region
+            - description: Ring Configuration Registers region
+            - description: TX Channel Configuration Registers region
+            - description: RX Channel Configuration Registers region
+            - description: Block Copy Channel Configuration Registers region
 
         reg-names:
+          minItems: 5
           items:
             - const: gcfg
             - const: bchanrt
             - const: rchanrt
             - const: tchanrt
             - const: ringrt
+            - const: ring
+            - const: tchan
+            - const: rchan
+            - const: bchan
 
       required:
         - ti,sci-rm-range-bchan
@@ -232,8 +242,13 @@ examples:
                       <0x0 0x4c000000 0x0 0x20000>,
                       <0x0 0x4a820000 0x0 0x20000>,
                       <0x0 0x4aa40000 0x0 0x20000>,
-                      <0x0 0x4bc00000 0x0 0x100000>;
-                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
+                      <0x0 0x4bc00000 0x0 0x100000>,
+                      <0x0 0x48600000 0x0 0x8000>,
+                      <0x0 0x484a4000 0x0 0x2000>,
+                      <0x0 0x484c2000 0x0 0x2000>,
+                      <0x0 0x48420000 0x0 0x2000>;
+                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
+                            "ring", "tchan", "rchan", "bchan";
                 msi-parent = <&inta_main_dmss>;
                 #dma-cells = <3>;
 
-- 
2.43.0


