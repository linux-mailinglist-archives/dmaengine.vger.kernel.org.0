Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B071927F
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 07:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjFAFqB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 01:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjFAFqA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 01:46:00 -0400
X-Greylist: delayed 565 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 22:45:58 PDT
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FCA9D;
        Wed, 31 May 2023 22:45:58 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 58AD546CD1;
        Thu,  1 Jun 2023 08:45:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-i55hgXNO;
        Thu, 01 Jun 2023 08:45:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598356;
        bh=1bDXVRXKM/tgJHSAAZWdj5rtWyNT0wihqHFmyX6zdO0=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=BS63bU9vkWL2D0xknjnAFd6ZNX+bpTaFbZFjz/OcVLvtithjXmQBlhHgZQt0MgOpx
         sH0+S6rHM7a0GjcVyVr0uD2X5V5VYiizh9U14mLfLWG6NufYfpgTZyJuAy0/PSrw7O
         L5IIrIG78FgxnxCZv6RwY+s2Ytt+AkPDwiQ3reQA=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 21/43] dt-bindings: dma: Add Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:45:26 +0300
Message-Id: <20230601054549.10843-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add YAML bindings for ep93xx SoC DMA.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    Rob Herring:
    - replaced maintainers
    - defined each entry in reg, interrupts
    - dropped dma-channels
    
    Krzysztof Kozlowski:
    - fixed title
    - renamed files
    - use fallback compatible and list all possible compatibles
    - dropped label
    - fix ident

 .../bindings/dma/cirrus,ep9301-dma-m2m.yaml   |  72 ++++++++++
 .../bindings/dma/cirrus,ep9301-dma-m2p.yaml   | 124 ++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml

diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml
new file mode 100644
index 000000000000..413492268bd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/cirrus,ep9301-dma-m2m.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logick ep93xx SoC DMA controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-dma-m2m
+      - items:
+          - enum:
+              - cirrus,ep9302-dma-m2m
+              - cirrus,ep9307-dma-m2m
+              - cirrus,ep9312-dma-m2m
+              - cirrus,ep9315-dma-m2m
+          - const: cirrus,ep9301-dma-m2m
+
+  reg:
+    items:
+      - description: m2m0 channel registers
+      - description: m2m1 channel registers
+
+  clocks:
+    items:
+      - description: m2m0 channel gate clock
+      - description: m2m1 channel gate clock
+
+  clock-names:
+    items:
+      - const: m2m0
+      - const: m2m1
+
+  interrupts:
+    items:
+      - description: m2m0 channel interrupt
+      - description: m2m1 channel interrupt
+
+  '#dma-cells': true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
+    dma-controller@80000100 {
+      compatible = "cirrus,ep9301-dma-m2m";
+      reg = <0x80000100 0x0040>,
+            <0x80000140 0x0040>;
+      clocks = <&syscon EP93XX_CLK_M2M0>,
+              <&syscon EP93XX_CLK_M2M1>;
+      clock-names = "m2m0", "m2m1";
+      interrupt-parent = <&vic0>;
+      interrupts = <17>, <18>;
+      #dma-cells = <1>;
+    };
+
+...
+
diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml
new file mode 100644
index 000000000000..79f2d61de6a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/cirrus,ep9301-dma-m2p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logick ep93xx SoC M2P DMA controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-dma-m2p
+      - items:
+          - enum:
+              - cirrus,ep9302-dma-m2p
+              - cirrus,ep9307-dma-m2p
+              - cirrus,ep9312-dma-m2p
+              - cirrus,ep9315-dma-m2p
+          - const: cirrus,ep9301-dma-m2p
+
+  reg:
+    items:
+      - description: m2p0 channel registers
+      - description: m2p1 channel registers
+      - description: m2p2 channel registers
+      - description: m2p3 channel registers
+      - description: m2p4 channel registers
+      - description: m2p5 channel registers
+      - description: m2p6 channel registers
+      - description: m2p7 channel registers
+      - description: m2p8 channel registers
+      - description: m2p9 channel registers
+
+  clocks:
+    items:
+      - description: m2p0 channel gate clock
+      - description: m2p1 channel gate clock
+      - description: m2p2 channel gate clock
+      - description: m2p3 channel gate clock
+      - description: m2p4 channel gate clock
+      - description: m2p5 channel gate clock
+      - description: m2p6 channel gate clock
+      - description: m2p7 channel gate clock
+      - description: m2p8 channel gate clock
+      - description: m2p9 channel gate clock
+
+  clock-names:
+    items:
+      - const: m2p0
+      - const: m2p1
+      - const: m2p2
+      - const: m2p3
+      - const: m2p4
+      - const: m2p5
+      - const: m2p6
+      - const: m2p7
+      - const: m2p8
+      - const: m2p9
+
+  interrupts:
+    items:
+      - description: m2p0 channel interrupt
+      - description: m2p1 channel interrupt
+      - description: m2p2 channel interrupt
+      - description: m2p3 channel interrupt
+      - description: m2p4 channel interrupt
+      - description: m2p5 channel interrupt
+      - description: m2p6 channel interrupt
+      - description: m2p7 channel interrupt
+      - description: m2p8 channel interrupt
+      - description: m2p9 channel interrupt
+
+  '#dma-cells': true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
+    dma-controller@80000000 {
+      compatible = "cirrus,ep9301-dma-m2p";
+      reg =   <0x80000000 0x0040>,
+              <0x80000040 0x0040>,
+              <0x80000080 0x0040>,
+              <0x800000c0 0x0040>,
+              <0x80000240 0x0040>,
+              <0x80000200 0x0040>,
+              <0x800002c0 0x0040>,
+              <0x80000280 0x0040>,
+              <0x80000340 0x0040>,
+              <0x80000300 0x0040>;
+      clocks = <&syscon EP93XX_CLK_M2P0>,
+              <&syscon EP93XX_CLK_M2P1>,
+              <&syscon EP93XX_CLK_M2P2>,
+              <&syscon EP93XX_CLK_M2P3>,
+              <&syscon EP93XX_CLK_M2P4>,
+              <&syscon EP93XX_CLK_M2P5>,
+              <&syscon EP93XX_CLK_M2P6>,
+              <&syscon EP93XX_CLK_M2P7>,
+              <&syscon EP93XX_CLK_M2P8>,
+              <&syscon EP93XX_CLK_M2P9>;
+      clock-names = "m2p0", "m2p1",
+              "m2p2", "m2p3",
+              "m2p4", "m2p5",
+              "m2p6", "m2p7",
+              "m2p8", "m2p9";
+      interrupt-parent = <&vic0>;
+      interrupts = <7>, <8>, <9>, <10>, <11>, <12>, <13>, <14>, <15>, <16>;
+      #dma-cells = <1>;
+    };
+
+...
+
-- 
2.37.4

