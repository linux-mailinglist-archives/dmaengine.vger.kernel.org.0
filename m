Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2226E41AF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDQH4A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 03:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDQHz6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 03:55:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054B03AA2
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ec816c9b62so1187412e87.2
        for <dmaengine@vger.kernel.org>; Mon, 17 Apr 2023 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718154; x=1684310154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2kEZXqS3DdorsV7KBvalbCQQT9rGiidMVD8f+P+zW8=;
        b=cszasHJqTYYYiVgMtunipV+yzyUhFzSLNhUSkwJDjzdL7jFJrC3sW5CWMmi297UZuk
         icxBUMV5s1ZlZ3lqmVzkwG02nMxJ6IXkEO26lhcMrSMSIQTM71BrUKYMkURHWrY6ZnKI
         bAVlqFHdMatGCfWMnFwelhVbkjVURlAIXTqiWVJhGu8myBWN+i9tHfHpmFR0NSKQGGud
         rkycl4wBZ3xdjEtnSM+p7sCoqwxTUDCrsMvfS03lNPgWMM9FCJlAe6K70IrzW+VLH3DA
         Xj6hQQfit2+FZiMRguB3LIuZ9asqaQCfhECdLQI7rljKFlEP08FJMzEBr2y1RJOH1FNS
         HyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718154; x=1684310154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2kEZXqS3DdorsV7KBvalbCQQT9rGiidMVD8f+P+zW8=;
        b=OYBLmWLz/HR7+HxC2DR8jjMQSi+0iLEPjoGjPadfsEoR70gOTMHydGdtzca0CTSXTX
         TPVGuQ097Z9FuJhDzS5gsSkbZCTTz6cZ5M9vyD7jKDhLMMTLbsUAcTvwQdjWglBho7HD
         TT7sa7capcnBepNR3KXut5iWKe2+Vv+vDC02yO75PfTiyBIh3psXzeh6SzK5P7eoFghB
         XTNwU1U5uFZcf2NcI6XKOKG0XvJEUvKP2N3gcA5BQr+EqgT3tm/SXPQ6UM8As1jReXEa
         FaJq9cEriJYDMGFeOLjvZZwl2ZuqdryvIqOZ9+d695O8R++fRV989k5BeZt7gL6QJMMG
         LXHw==
X-Gm-Message-State: AAQBX9foRmW5W6OGlz0p+MajOKVB1sWnNDs8rpOC8wT6bi2ZcIgbcwPQ
        b1oLLIi1HvsMw5i0W8c06z7RaA==
X-Google-Smtp-Source: AKy350bPHIoevthvL1Vu2On/x5qhfIXMiZgEySgZRAofY0B4hePo2ONJGYQf+Vn7/2yaEFBJjWs1Yw==
X-Received: by 2002:a19:c502:0:b0:4ec:8087:88bb with SMTP id w2-20020a19c502000000b004ec808788bbmr1805886lfe.3.1681718154207;
        Mon, 17 Apr 2023 00:55:54 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004eb274b3a43sm1952547lfc.134.2023.04.17.00.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:55:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 09:55:46 +0200
Subject: [PATCH 1/7] dt-bindings: dma: dma40: Prefer to pass sram through
 phandle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v1-1-b26324956e47@linaro.org>
References: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend the DMA40 bindings so that we can pass two SRAM
segments as phandles instead of directly referring to the
memory address in the second reg cell. This enables more
granular control over the SRAM, and adds the optiona LCLA
SRAM segment as well.

Deprecate the old way of passing LCPA as a second reg cell,
make sram compulsory.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/dma/stericsson,dma40.yaml  | 35 +++++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
index 64845347f44d..4fe0df937171 100644
--- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
+++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
@@ -112,14 +112,23 @@ properties:
       - const: stericsson,dma40
 
   reg:
-    items:
-      - description: DMA40 memory base
-      - description: LCPA memory base
+    oneOf:
+      - items:
+          - description: DMA40 memory base
+      - items:
+          - description: DMA40 memory base
+          - description: LCPA memory base, deprecated, use eSRAM pool instead
+        deprecated: true
+
 
   reg-names:
-    items:
-      - const: base
-      - const: lcpa
+    oneOf:
+      - items:
+          - const: base
+      - items:
+          - const: base
+          - const: lcpa
+        deprecated: true
 
   interrupts:
     maxItems: 1
@@ -127,6 +136,14 @@ properties:
   clocks:
     maxItems: 1
 
+  sram:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    items:
+      maxItems: 2
+    description:
+      List of phandles for the SRAM used by the DMA40 block, the first
+      phandle is the LCPA memory, the second is the LCLA memory.
+
   memcpy-channels:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: Array of u32 elements indicating which channels on the DMA
@@ -138,6 +155,7 @@ required:
   - reg
   - interrupts
   - clocks
+  - sram
   - memcpy-channels
 
 additionalProperties: false
@@ -149,8 +167,9 @@ examples:
     #include <dt-bindings/mfd/dbx500-prcmu.h>
     dma-controller@801c0000 {
         compatible = "stericsson,db8500-dma40", "stericsson,dma40";
-        reg = <0x801c0000 0x1000>, <0x40010000 0x800>;
-        reg-names = "base", "lcpa";
+        reg = <0x801c0000 0x1000>;
+        reg-names = "base";
+        sram = <&lcpa>, <&lcla>;
         interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
         #dma-cells = <3>;
         memcpy-channels = <56 57 58 59 60>;

-- 
2.39.2

