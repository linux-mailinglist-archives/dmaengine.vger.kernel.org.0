Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B286C567995
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 23:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiGEVwe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 17:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiGEVwd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 17:52:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED05318B02
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 14:52:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c131-20020a1c3589000000b003a19b2bce36so4934073wma.4
        for <dmaengine@vger.kernel.org>; Tue, 05 Jul 2022 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GzPXU6fxlhRLcLCzHAtBw9aqp9IODNCeRsuQO5lcpY=;
        b=XT7ASFf1nIxEfdXiclNYpFSfVq9s4C412d1OLgO/lRLR31n5QoYTHi2w0+p6vqybbX
         L8rsroWGHmISyxXwTMLY5Pxl0TOG8uaNtgvh3ABkRgQei276FZRvd10cHmCHvrO97nSs
         X1TOJ070+O3zWigaRb5S9HsAQ7feSkeZGigRifEXpzQYhOCweEjRkKfebf8ovWlSg9Sm
         MATg8gxg3oOtY6sR8l+nawtwKUugNgrjxosw3dX9AbAQmizt8wGPJ0C0+p2XxxuR4VYQ
         cB+b97WOaIvDgK7CYap6O6H46outSUnrjdgeLqMg7CbGejFauZTBHZWOALqxV0SFuBD2
         cSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GzPXU6fxlhRLcLCzHAtBw9aqp9IODNCeRsuQO5lcpY=;
        b=vOmk3sHM2B3AxGXYXD1ExRKPs7YaIwvXv25gdk3o6FsVgmoDbO/FjYl7InNFwJDICq
         97bkwvpahmbE2pQfPuE9LNMNRKSQIhUzewz0FQvshB5GWAd9YeCxP88r1BP4NW7dDupk
         XJOH1JYbt6XIlHKF5t9SOZHVNrUTq3p8jqLxQhwrR54W2r6lLGVmqcs0vXcZsUFb13hR
         5jbF2PPxEUwswa9sxwJ0v7vKA48Dodf8qanGZNKsDdxKG4Gu5l1vkNVHU5q//Qo4rqxw
         VKyeT9UirSxvdqbMTwfcx0arTIgYlyGwgiR4F5i+m9L9hOJN7aK9W4RpVefe9ES7XPvx
         ewSQ==
X-Gm-Message-State: AJIora/hRkzXbIX3DWelY9OkgeGoTLpFdeoFmYavNz4ubTTK7/qDZz3w
        Ci9aQ7gL8qlXo43fH/c9CsXXPL9mTjT+yfKzjZk=
X-Google-Smtp-Source: AGRyM1uhOixFRoKPZ9r+xlFuyTA+0x5iwS5mflmn1FfFUubL8NnF+MTFXr4CI29OWbYvLWfq3Ui0Iw==
X-Received: by 2002:a7b:ce0e:0:b0:3a0:4623:86b7 with SMTP id m14-20020a7bce0e000000b003a0462386b7mr39641466wmc.62.1657057949473;
        Tue, 05 Jul 2022 14:52:29 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g34-20020a05600c4ca200b0039c7dbafa7asm18353920wmp.19.2022.07.05.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:52:29 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 04/13] dt-bindings: memory-controllers: add canaan k210 sram controller
Date:   Tue,  5 Jul 2022 22:52:05 +0100
Message-Id: <20220705215213.1802496-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
References: <20220705215213.1802496-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The k210 U-Boot port has been using the clocks defined in the
devicetree to bring up the board's SRAM, but this violates the
dt-schema. As such, move the clocks to a dedicated node with
the same compatible string & document it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../memory-controllers/canaan,k210-sram.yaml  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml b/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
new file mode 100644
index 000000000000..f81fb866e319
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/canaan,k210-sram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Canaan K210 SRAM memory controller
+
+description:
+  The Canaan K210 SRAM memory controller is responsible for the system's 8 MiB
+  of SRAM. The controller is initialised by the bootloader, which configures
+  its clocks, before OS bringup.
+
+maintainers:
+  - Conor Dooley <conor@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - canaan,k210-sram
+
+  clocks:
+    minItems: 1
+    items:
+      - description: sram0 clock
+      - description: sram1 clock
+      - description: aisram clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: sram0
+      - const: sram1
+      - const: aisram
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/k210-clk.h>
+    memory-controller {
+        compatible = "canaan,k210-sram";
+        clocks = <&sysclk K210_CLK_SRAM0>,
+                 <&sysclk K210_CLK_SRAM1>,
+                 <&sysclk K210_CLK_AI>;
+        clock-names = "sram0", "sram1", "aisram";
+    };
-- 
2.37.0

