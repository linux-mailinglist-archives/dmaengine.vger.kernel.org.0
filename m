Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C77B5FC7
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 06:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbjJCEV1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 00:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbjJCEV0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 00:21:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D5EC6;
        Mon,  2 Oct 2023 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696306881; x=1727842881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uk/EcBn8FiTIAxuCyH3yLDadwdTVKJxp1FqVVQmqg/w=;
  b=jZc5TvkgAFpbhOm3gTSux4iNJh2LGiwHOI0Y9XDp3ulPqSmBbSayEr9D
   TK/C07XbTGeYNehk88iS8yf2ct3l3h/QeYX5Dd0fjE/wzBKQNJyTGcEkL
   Ruuc4+GrayoH4SiLoWTrvNcT6h62Y6NI858XeW3p5V/CgR7WVHuL+kwzO
   GXQoMrvujiu5fqgE1n3pGMzEorTF3pyP3DTf0GP5n8YwDO1CnOBT1NnRX
   j1A9U4mYCp3S1OB6Y7gPX5wS/5HNNZUMJdwHP/tTxMk2liSxPOn44Kmnr
   IHhJ0wkVmEzUngeXZEFgRM5RFmdWybK/kYmK0FkYGmYfkQhVq3wCZ/JD1
   g==;
X-CSE-ConnectionGUID: ryNJk9XvTIqOWjKHHkWxlA==
X-CSE-MsgGUID: Ekm9/htGRBKlxh3uJwPLog==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="238350654"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 21:21:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 2 Oct 2023 21:21:14 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 2 Oct 2023 21:21:09 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/4] dt-bindings: dma: sf-pdma: add new compatible name
Date:   Tue, 3 Oct 2023 09:52:13 +0530
Message-ID: <20231003042215.142678-3-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003042215.142678-1-shravan.chippa@microchip.com>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Add new compatible name microchip,mpfs-pdma to support
out of order dma transfers

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 .../bindings/dma/sifive,fu540-c000-pdma.yaml         | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index a1af0b906365..974467c4bacb 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -27,10 +27,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,fu540-c000-pdma
-      - const: sifive,pdma0
+    oneOf:
+      - items:
+          - const: microchip,mpfs-pdma # Microchip out of order DMA transfer
+          - const: sifive,fu540-c000-pdma # Sifive in-order DMA transfer
+      - items:
+          - enum:
+              - sifive,fu540-c000-pdma
+          - const: sifive,pdma0
     description:
       Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
       Supported compatible strings are -
-- 
2.34.1

