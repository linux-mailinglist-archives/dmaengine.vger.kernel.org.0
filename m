Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2616EC92A
	for <lists+dmaengine@lfdr.de>; Mon, 24 Apr 2023 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjDXJmQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Apr 2023 05:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDXJmP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Apr 2023 05:42:15 -0400
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 02:42:13 PDT
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FA8132;
        Mon, 24 Apr 2023 02:42:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id E3AC95EDB6;
        Mon, 24 Apr 2023 12:35:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-BwYy9Cx4;
        Mon, 24 Apr 2023 12:35:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328952;
        bh=Rjcz5dgGLteFjKtx+6Kc5AGWRQU0XvJKClPFRS4r3RE=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=UcrFabIZjE56akCZK7xPv3UCVVdigntUsjwDCrlxeJDwAo2ISruAb92Pt6BVPyES+
         itFRIlRzk6jAl/dlNuQlSv1FL8AILySvHhxenp/gvBgNdkacYxSQ2DyjrU3tYEYoxm
         Bqu2tFThRSEYzMjb9ny3p9yukrQdF0abomF/q6kQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/43] dt-bindings: dma: Add DT bindings ep93xx dma
Date:   Mon, 24 Apr 2023 15:34:36 +0300
Message-Id: <20230424123522.18302-21-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add YAML bindings for ep93xx SoC.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/dma/cirrus,ep93xx-dma-m2m.yaml   |  66 ++++++++++++
 .../bindings/dma/cirrus,ep93xx-dma-m2p.yaml   | 102 ++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2m.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2p.yaml

diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2m.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2m.yaml
new file mode 100644
index 000000000000..9a53ee9052a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2m.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/cirrus,ep93xx-dma-m2m.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logick ep93xx SoC DMA controller Device Tree Bindings
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - const: cirrus,ep9301-dma-m2m
+
+  reg:
+    minItems: 2
+    maxItems: 2
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
+    minItems: 2
+    maxItems: 2
+
+  dma-channels:
+    minimum: 2
+    maximum: 2
+
+  '#dma-cells': false
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
+    dma1: dma-controller@80000100 {
+        compatible = "cirrus,ep9301-dma-m2m";
+        reg = <0x80000100 0x0040>,
+                <0x80000140 0x0040>;
+        clocks = <&syscon EP93XX_CLK_M2M0>,
+                <&syscon EP93XX_CLK_M2M1>;
+        clock-names = "m2m0", "m2m1";
+        dma-channels = <2>;
+        interrupt-parent = <&vic0>;
+        interrupts = <17>, <18>;
+    };
+
+...
+
diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2p.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2p.yaml
new file mode 100644
index 000000000000..51fd72b4e843
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2p.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/cirrus,ep93xx-dma-m2p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logick ep93xx SoC M2P DMA controller Device Tree Bindings
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - const: cirrus,ep9301-dma-m2p
+
+  reg:
+    minItems: 10
+    maxItems: 10
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
+    minItems: 10
+    maxItems: 10
+
+  dma-channels:
+    minimum: 10
+    maximum: 10
+
+  '#dma-cells': false
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
+    dma0: dma-controller@80000000 {
+        compatible = "cirrus,ep9301-dma-m2p";
+        reg =   <0x80000000 0x0040>,
+                <0x80000040 0x0040>,
+                <0x80000080 0x0040>,
+                <0x800000c0 0x0040>,
+                <0x80000240 0x0040>,
+                <0x80000200 0x0040>,
+                <0x800002c0 0x0040>,
+                <0x80000280 0x0040>,
+                <0x80000340 0x0040>,
+                <0x80000300 0x0040>;
+        clocks = <&syscon EP93XX_CLK_M2P0>,
+                <&syscon EP93XX_CLK_M2P1>,
+                <&syscon EP93XX_CLK_M2P2>,
+                <&syscon EP93XX_CLK_M2P3>,
+                <&syscon EP93XX_CLK_M2P4>,
+                <&syscon EP93XX_CLK_M2P5>,
+                <&syscon EP93XX_CLK_M2P6>,
+                <&syscon EP93XX_CLK_M2P7>,
+                <&syscon EP93XX_CLK_M2P8>,
+                <&syscon EP93XX_CLK_M2P9>;
+        clock-names = "m2p0", "m2p1",
+                "m2p2", "m2p3",
+                "m2p4", "m2p5",
+                "m2p6", "m2p7",
+                "m2p8", "m2p9";
+        dma-channels = <10>;
+        interrupt-parent = <&vic0>;
+        interrupts = <7>, <8>, <9>, <10>, <11>, <12>, <13>, <14>, <15>, <16>;
+    };
+
+...
+
-- 
2.39.2

