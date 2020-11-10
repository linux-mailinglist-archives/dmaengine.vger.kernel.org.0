Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25B72ACF9F
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgKJG1U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 01:27:20 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:41113 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgKJG1T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Nov 2020 01:27:19 -0500
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.61374|-1;BR=01201311R441b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.0102791-0.00112627-0.988595;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Iuo2KNX_1604989628;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.Iuo2KNX_1604989628)
          by smtp.aliyun-inc.com(10.147.42.198);
          Tue, 10 Nov 2020 14:27:12 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank@allwinnertech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [RESEND PATCH 04/19] dt-bindings: dma: allwinner,sun50i-a64-dma: Add A100 compatible
Date:   Tue, 10 Nov 2020 14:26:38 +0800
Message-Id: <f15a18e9b8868e8853db1b5a3d1e411b0ac1c63a.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add a binding for A100's dma controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
index 372679dbd216..b6e1ebfaf366 100644
--- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     oneOf:
       - const: allwinner,sun50i-a64-dma
+      - const: allwinner,sun50i-a100-dma
       - const: allwinner,sun50i-h6-dma
       - items:
           - const: allwinner,sun8i-r40-dma
@@ -56,7 +57,9 @@ required:
 if:
   properties:
     compatible:
-      const: allwinner,sun50i-h6-dma
+      enum:
+        - allwinner,sun50i-a100-dma
+        - allwinner,sun50i-h6-dma
 
 then:
   properties:
-- 
2.28.0

