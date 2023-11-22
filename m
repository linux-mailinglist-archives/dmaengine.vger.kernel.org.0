Return-Path: <dmaengine+bounces-176-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D87F4B43
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69C228131D
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC814F69;
	Wed, 22 Nov 2023 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EibEm12u"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E1D72;
	Wed, 22 Nov 2023 07:43:00 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFgqKW031041;
	Wed, 22 Nov 2023 09:42:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700667772;
	bh=pFduLlydOwKar9BVb8D513PZ/AG8sYpzIvIkHf6BHxQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EibEm12uKf5xmX8rhPG2NwQu6LHW4DKNRvU6xUJu45zvqu+ncNCGWPDTyNo0aJZGh
	 i2YSWHSYzbRD8i1ZgPKDAxojH7sDaLhqp7dqAn8YqNcYf9lfK5Kh0NYO97vRYhxmxu
	 wVYAOPKQdkbuR31WoCSK9BeGh+4E/AD6PJyG53M0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFgq8R012010
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Nov 2023 09:42:52 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:42:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:42:52 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFggJn046973;
	Wed, 22 Nov 2023 09:42:49 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/4] dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
Date: Wed, 22 Nov 2023 21:12:36 +0530
Message-ID: <20231122154238.815781-3-vigneshr@ti.com>
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

Block copy DMA(BCDMA)module on K3 SoCs have ring, BCHAN, TX and RX
channel cfg register regions which are usually configured by a Device
Management firmware. But certain entities such as bootloader (like
U-Boot) may have to access them directly. Describe this region in the
binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
five regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
index b5444800b036..b9a0ce347368 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
@@ -155,20 +155,30 @@ allOf:
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
@@ -224,8 +234,13 @@ examples:
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
2.42.0


