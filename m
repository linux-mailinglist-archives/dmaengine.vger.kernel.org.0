Return-Path: <dmaengine+bounces-177-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806517F4B46
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 16:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C714281387
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67669584FC;
	Wed, 22 Nov 2023 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qdGp1tEf"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1229B170E;
	Wed, 22 Nov 2023 07:43:01 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFgtjC031052;
	Wed, 22 Nov 2023 09:42:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700667775;
	bh=/hLXqNq2lxfuDYMurFDuU/pVsd2mCXJXYqLfaS+P+zU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qdGp1tEfNQRWLytU3ht3tqcSh+oDaOdB7wJev8podPQ9/jadNoQjNOI9ajCfcdMlO
	 Z8kjfj2dD2gw2DNCWGkMXFHVCFIqm0UbQEt2pcyMf7AL6zzCvRDM1i3wM1Kv9A0DRQ
	 hK/C7tlxCxoIE3ac3CKAw4ja0+n5+BsZFaQrPzsM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFgtgM086025
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Nov 2023 09:42:55 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:42:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:42:55 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFggJo046973;
	Wed, 22 Nov 2023 09:42:52 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/4] dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
Date: Wed, 22 Nov 2023 21:12:37 +0530
Message-ID: <20231122154238.815781-4-vigneshr@ti.com>
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

Packet DMA (PKTDMA) module on K3 SoCs have ring cfg, TX and RX channel
cfg and RX flow cfg register regions which are usually configured by a
Device Management firmware. But certain entities such as bootloader
(like U-Boot) may have to access them directly. Describe this region in
the binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
four regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
index 3580b08f65c6..11e064c02994 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -45,18 +45,28 @@ properties:
       The second cell is the ASEL value for the channel
 
   reg:
+    minItems: 4
     items:
       - description: Packet DMA Control /Status Registers region
       - description: RX Channel Realtime Registers region
       - description: TX Channel Realtime Registers region
       - description: Ring Realtime Registers region
+      - description: Ring Configuration Registers region
+      - description: TX Configuration Registers region
+      - description: RX Configuration Registers region
+      - description: RX Flow Configuration Registers region
 
   reg-names:
+    minItems: 4
     items:
       - const: gcfg
       - const: rchanrt
       - const: tchanrt
       - const: ringrt
+      - const: ring
+      - const: tchan
+      - const: rchan
+      - const: rflow
 
   msi-parent: true
 
@@ -140,8 +150,14 @@ examples:
                 reg = <0x0 0x485c0000 0x0 0x100>,
                       <0x0 0x4a800000 0x0 0x20000>,
                       <0x0 0x4aa00000 0x0 0x40000>,
-                      <0x0 0x4b800000 0x0 0x400000>;
-                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+                      <0x0 0x4b800000 0x0 0x400000>,
+                      <0x0 0x485e0000 0x0 0x20000>,
+                      <0x0 0x484a0000 0x0 0x4000>,
+                      <0x0 0x484c0000 0x0 0x2000>,
+                      <0x0 0x48430000 0x0 0x4000>;
+                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+                            "ring", "tchan", "rchan", "rflow";
+
                 msi-parent = <&inta_main_dmss>;
                 #dma-cells = <2>;
 
-- 
2.42.0


