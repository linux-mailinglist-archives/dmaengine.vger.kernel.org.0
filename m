Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09AA777F63
	for <lists+dmaengine@lfdr.de>; Thu, 10 Aug 2023 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjHJRoS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHJRoO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 13:44:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3704D2702;
        Thu, 10 Aug 2023 10:44:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AHi9GM117090;
        Thu, 10 Aug 2023 12:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691689449;
        bh=gfbLHysTG0e8/gnydYR5Ri1V5MI+cGJ91H+QawmnPdk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aToNUE3zGPNJtjVgjd3APKOMLtDlTd/pSlFMm7iJPDiyg2nEQjjodYFvXIX6o3bNh
         E8Xj9OAFeTCcpiW/CWL+XMSiAwI5FYGZMFG0Em6DnCYY6mn52rED1kFtikfx8BatcF
         iJt+g5rsj/Bd2rMKCUe0W3+7S3QwE2MNpZicaCWI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AHi8Dn026510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 12:44:08 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 12:44:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 12:44:08 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AHhxuh084260;
        Thu, 10 Aug 2023 12:44:05 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
Date:   Thu, 10 Aug 2023 23:13:54 +0530
Message-ID: <20230810174356.3322583-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810174356.3322583-1-vigneshr@ti.com>
References: <20230810174356.3322583-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Packet DMA (PKTDMA) module on K3 SoCs have ring cfg, TX and RX channel
cfg and RX flow cfg register regions which are usually configured by a
Device Management firmware. But certain entities such as bootloader
(like U-Boot) may have to access them directly. Describe this region in
the binding documentation for completeness of module description.

Keep the binding compatible with existing DTS files by requiring first
four regions to be present at least.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
index a69f62f854d8..5f9ba4bb05f6 100644
--- a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
+++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
@@ -45,14 +45,20 @@ properties:
       The second cell is the ASEL value for the channel
 
   reg:
-    maxItems: 4
+    minItems: 4
+    maxItems: 8
 
   reg-names:
+    minItems: 4
     items:
       - const: gcfg
       - const: rchanrt
       - const: tchanrt
       - const: ringrt
+      - const: cfg
+      - const: tchan
+      - const: rchan
+      - const: rflow
 
   msi-parent: true
 
@@ -136,8 +142,14 @@ examples:
                 reg = <0x0 0x485c0000 0x0 0x100>,
                       <0x0 0x4a800000 0x0 0x20000>,
                       <0x0 0x4aa00000 0x0 0x40000>,
-                      <0x0 0x4b800000 0x0 0x400000>;
-                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+                      <0x0 0x4b800000 0x0 0x400000>,
+                      <0x00 0x485e0000 0x00 0x20000>,
+                      <0x00 0x484a0000 0x00 0x4000>,
+                      <0x00 0x484c0000 0x00 0x2000>,
+                      <0x00 0x48430000 0x00 0x4000>;
+                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+                            "cfg", "tchan", "rchan", "rflow";
+
                 msi-parent = <&inta_main_dmss>;
                 #dma-cells = <2>;
 
-- 
2.41.0

