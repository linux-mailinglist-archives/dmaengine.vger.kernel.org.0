Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08794704E45
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjEPM4P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjEPM4M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 08:56:12 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD46A79
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:55:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ad819ab8a9so119697451fa.0
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241740; x=1686833740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYIvv3rYmRWOYRNLYvtYel4ibJsZWh4O4oNdMBTy29c=;
        b=RjsBicnmpolKlYVetZhU3EWldBJY1nHZbNCR0FaY8EKZIlLI8rtgidTMKwlqGM1T4g
         BWggZAC8K6ZiQaPHvU/M1WYWcf/sxV62Cn6VE+nOaQQAAIbfxLS6ATaODh+7Dg0toJn+
         R1SItm3vjtQs3j8LuaByFdui9DkyitLOh+CrXel33+JANKQM82h+KooNCDSh2xU6z0Np
         kzVzHTEIjxu0d8a6wH7CiX4ToIzEJzZNE1tlj0qjBGWx9SGmuFg9jB+gAdJ9j0trawU7
         v3Hm8Ur4xb5/kMORzHniqMCoery5vVKM7f1na/sPQDj5KnX2K3UALZWXVqR3ToPgRsdX
         FE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241740; x=1686833740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYIvv3rYmRWOYRNLYvtYel4ibJsZWh4O4oNdMBTy29c=;
        b=eZJ27VdcDB/rokxDDn5lu5LD4i3rqdri5ijyW4BqpiYMcQRyZhkd7Gkqnr7E2d1jEj
         w2QF/+R/XrAWiDvahxIgwpaM3pEcpzIBhupJuUhWqun2EhNKqW7Dlb20CLzaOSCa+k9D
         ywjBF/m+akBMKTu1V+8H+rv+A7x79Gcif7fx5P/j2qi9/LdoNUD7Qp2xgVYe4zJHfLX0
         /Cfq1hhhgMQZNter07fTWmt1/9cvF/T6s6TdD0aqTTZiw/OehcC1CS5iLERlFm4JZBf+
         0LgQYSsVVdp/4IhcP8pBKo7zBbQtDwq4vRsPQA1xiyYk58pLzxdY4jF2TyVLiAZz4bRL
         wmAA==
X-Gm-Message-State: AC+VfDzP3p4UacojJTgu1Emfgq3V7WdFg43jbbQ49jmtoiFmcNX7TvxM
        yvlhy+NEhHtDnTSb937sFkzl7KwfwVkGX+kGxds=
X-Google-Smtp-Source: ACHHUZ4iIiIQJHnnQUggOOGmToYU8u9Bnn384mjwwjAiIYp0QrppKoJh32ZZGhOs+er8PD4McOys+Q==
X-Received: by 2002:a2e:6812:0:b0:298:aad9:e377 with SMTP id c18-20020a2e6812000000b00298aad9e377mr8354304lja.14.1684241740282;
        Tue, 16 May 2023 05:55:40 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id o23-20020a2e7317000000b002add1f4a92asm1647789ljc.113.2023.05.16.05.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:55:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 14:55:31 +0200
Subject: [PATCH v3 1/7] dt-bindings: dma: dma40: Prefer to pass sram
 through phandle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v3-1-60bfa6785968@linaro.org>
References: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Enumerate phandles using inner and outer maxItems as specified
  by Rob.
- Drop quotes around reference.
---
 .../devicetree/bindings/dma/stericsson,dma40.yaml  | 36 +++++++++++++++++-----
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
index 64845347f44d..1e5752b19a49 100644
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
@@ -127,6 +136,15 @@ properties:
   clocks:
     maxItems: 1
 
+  sram:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: A phandle array with inner size 1 (no arg cells).
+      First phandle is the LCPA (Logical Channel Parameter Address) memory.
+      Second phandle is the  LCLA (Logical Channel Link base Address) memory.
+    maxItems: 2
+    items:
+      maxItems: 1
+
   memcpy-channels:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: Array of u32 elements indicating which channels on the DMA
@@ -138,6 +156,7 @@ required:
   - reg
   - interrupts
   - clocks
+  - sram
   - memcpy-channels
 
 additionalProperties: false
@@ -149,8 +168,9 @@ examples:
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
2.40.1

