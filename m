Return-Path: <dmaengine+bounces-202-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAA7F6B85
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 05:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C217B28163C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 04:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0546A8;
	Fri, 24 Nov 2023 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oEJWSGTf"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAC8D67;
	Thu, 23 Nov 2023 20:58:12 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4w6dK043238;
	Thu, 23 Nov 2023 22:58:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700801886;
	bh=Q1gyWSbxTBCR6bJ5T/9ZpdTilTyPX7BqQhvvGnSbOb4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oEJWSGTf2FUhC/x6FubTI7xI72Udx/1rWalhkg5rsLoPb0bo499WD12iRhhg5qCPm
	 Ye83/7gUMIs9Yq3FPJ0hJA8kDg6aKQpOx9ldoSRHQjP/Flt5NSEk0Axe3T4AObMhBI
	 jP7a5cX+dkj0wLlXSTve+1VYrz2eV8IBT/pV2wmQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AO4w60Q081147
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Nov 2023 22:58:06 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 22:58:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 22:58:06 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AO4vo8j004756;
	Thu, 23 Nov 2023 22:58:03 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/4] dt-bindings: dma: ti: k3-udma: Describe cfg register regions
Date: Fri, 24 Nov 2023 10:27:22 +0530
Message-ID: <20231124045722.191817-5-vigneshr@ti.com>
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

Unified DMA (UDMA) module on K3 SoCs have TX and RX channel cfg and RX
flow cfg register regions which are usually configured by a Device
Management firmware. But certain entities such as bootloader (like
U-Boot) may have to access them directly. Describe this region in the
binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
four regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-udma.yaml       | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
index ded588bd079a..b18cf2bfdb5b 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
@@ -69,16 +69,24 @@ properties:
       - ti,j721e-navss-mcu-udmap
 
   reg:
+    minItems: 3
     items:
       - description: UDMA-P Control /Status Registers region
       - description: RX Channel Realtime Registers region
       - description: TX Channel Realtime Registers region
+      - description: TX Configuration Registers region
+      - description: RX Configuration Registers region
+      - description: RX Flow Configuration Registers region
 
   reg-names:
+    minItems: 3
     items:
       - const: gcfg
       - const: rchanrt
       - const: tchanrt
+      - const: tchan
+      - const: rchan
+      - const: rflow
 
   msi-parent: true
 
@@ -161,8 +169,11 @@ examples:
                 compatible = "ti,am654-navss-main-udmap";
                 reg = <0x0 0x31150000 0x0 0x100>,
                       <0x0 0x34000000 0x0 0x100000>,
-                      <0x0 0x35000000 0x0 0x100000>;
-                reg-names = "gcfg", "rchanrt", "tchanrt";
+                      <0x0 0x35000000 0x0 0x100000>,
+                      <0x0 0x30b00000 0x0 0x20000>,
+                      <0x0 0x30c00000 0x0 0x8000>,
+                      <0x0 0x30d00000 0x0 0x4000>;
+                reg-names = "gcfg", "rchanrt", "tchanrt", "tchan", "rchan", "rflow";
                 #dma-cells = <1>;
 
                 ti,ringacc = <&ringacc>;
-- 
2.43.0


