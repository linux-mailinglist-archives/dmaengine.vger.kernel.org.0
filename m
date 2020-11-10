Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDEB2ACE14
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 05:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbgKJEG3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 23:06:29 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:48526 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733307AbgKJEGZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 23:06:25 -0500
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6465102|-1;BR=01201311R861b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.0102791-0.00112627-0.988595;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.IulFdj5_1604981159;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IulFdj5_1604981159)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 10 Nov 2020 12:06:17 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, ulf.hansson@linaro.org, kishon@ti.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        dan.j.williams@intel.com, linus.walleij@linaro.org,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, colin.king@canonical.com, rdunlap@infradead.org,
        krzk@kernel.org, gregkh@linuxfoundation.org, megous@megous.com,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
        tiny.windzz@gmail.com
Cc:     Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 04/19] dt-bindings: dma: allwinner,sun50i-a64-dma: Add A100 compatible
Date:   Tue, 10 Nov 2020 12:05:38 +0800
Message-Id: <20201110040553.1381-5-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110040553.1381-1-frank@allwinnertech.com>
References: <20201110040553.1381-1-frank@allwinnertech.com>
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

