Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6116F0553
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 14:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbjD0MKE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 08:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbjD0MKD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 08:10:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC8469E
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec9c7c6986so8910562e87.0
        for <dmaengine@vger.kernel.org>; Thu, 27 Apr 2023 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682597400; x=1685189400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBQqau5zd2jC+LHz8Ur60RWpH4I9DwzbI/d1n0X/hZQ=;
        b=Zd61UDivIru9nOswRX6lsNoYqxwEl+I+DUHIDb8GWzVmNWoEUI2Ct2DrHWg9DgZafp
         Lw7RrqH9wN+oMynZKtNQNGOlU/bMLOOmcjnVHXgr73KRBeWWYVIf1IIDmUcKPg8TNE7n
         3w2vfTJcH+0DToR2mAPz7h3aZDnYawiOH/IcVo8trEHOOCz9/Tj9I3Do5o1m3RAWNoIG
         vcdCTK71+1piDsR+35+mcyY5o25eSBvXqq4bOabRYHGLY+WEQmgyx930xXnVHJmwRR/V
         du5vY0AMFm1fZdIudbqXPhJiSWLipjYKuS4EM/NEyNGFVyMFXGhY8BoOJKs4L5ywp/05
         Z/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597400; x=1685189400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBQqau5zd2jC+LHz8Ur60RWpH4I9DwzbI/d1n0X/hZQ=;
        b=JSnlYr0fugaw3YcozLrZJHU9CQJA+qdIdfg2UPpPn5ScTiQVDf2TK3mNV6oR1tM9z1
         A2Lyksd8AmH5nn6g1t9Jl3jp+807cIaB6AxAFzRTgmornyK6gwOXST0F9ld5xE/E2jJe
         Uwx2Qa+qKt/6yqi9so3YAjdO32mQurmFnoWeFLaC6nxqREV9iqPBPxfi0roBfeOJU/9v
         5tzB7S/9nQAPL0emzWx+dyu2iadjPqbphiKo/4pjr+28RhsSS2C2Hy8lPpy+sJ1Ls5Md
         F4ztjR//tE6pq2h9G+SXmfsc9VX0uEstkg2f+hqKqvQKuTJ/1DzHm/alkDXPM1Ns69Nr
         ciSA==
X-Gm-Message-State: AC+VfDy6vmJIsuRvxlSwNZZYtuv/KkpnodtrK+egyVbCN/Dxf0hI4z5X
        Eam58Zbz6+TgxKV9Kmh1+PG9Hg==
X-Google-Smtp-Source: ACHHUZ51RnqVnzXZaFmG/P4pMw3HLHFfsYhhRc1Ti4h0XtxeUBVoIzsQyB7wcEKR8Oii4Y5j4rxviA==
X-Received: by 2002:ac2:5691:0:b0:4e8:46a1:21a9 with SMTP id 17-20020ac25691000000b004e846a121a9mr553592lfr.49.1682597399823;
        Thu, 27 Apr 2023 05:09:59 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004d4d7fb0e07sm2892044lfn.216.2023.04.27.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:09:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Apr 2023 14:09:56 +0200
Subject: [PATCH v2 1/8] dt-bindings: dma: dma40: Prefer to pass sram
 through phandle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v2-1-cdaa68a4b863@linaro.org>
References: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
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
2.40.0

