Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798727A1844
	for <lists+dmaengine@lfdr.de>; Fri, 15 Sep 2023 10:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjIOINC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Sep 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjIOIMn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Sep 2023 04:12:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA42270B;
        Fri, 15 Sep 2023 01:12:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B723C116B2;
        Fri, 15 Sep 2023 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694765529;
        bh=oGB5mmj066e796PNEy2kGnJIR5NsQ47GaGZNF2b49IY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=m1cxzMWAkI0iefdnqIUUun5kdfydZwGEYzXyvH8FaC3dFEY3XNWGsXJ6P5pYgZDim
         yeQzgpqT+h8/CqVKFmw5UAqQ96F3OXUDs6lOl5IcmZrx3AF+ZsErv4Ao9oIj9wXhKD
         GcMQ1JebE/YZM+WKjdEiVJV70Gm0Ly0GP2OHnQO4xKnSwLzqrUQV8X1zgTgaGnAAxH
         PFD2ebBHTO3iYIus2vFeDZGiT/JHsc3XjzB5JvZZqlhVMR7NDKe23eTGAMGp10nP/g
         3/+p1R4b5AZ1hoPrpT+KrDwMsRwMVWgo4AMz775SYmNQWiZfkUO18YiMkmih86G13j
         RoV/kbKKyvNSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7FFEE643F;
        Fri, 15 Sep 2023 08:12:09 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Fri, 15 Sep 2023 11:11:05 +0300
Subject: [PATCH v4 23/42] dt-bindings: dma: Add Cirrus EP93xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-ep93xx-v4-23-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694765525; l=8728;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=ikbItjDUGCitdThpEQWLEuTYpqlVGNdH+yORw6iXxkY=; =?utf-8?q?b=3DSIeQvkPrpSxQ?=
 =?utf-8?q?PcQ2Xrasiz5txOWckdAPHTId6ld3TXLhFG4LG2NBq2iQEtpCm1oDpnDyXq9eRY58?=
 Clx/HzMiDj/PXWWnSWEO7mb884msUGpssT0cK1EMdqND7VXZW9E2
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC DMA.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |  69 ++++++++++++
 .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        | 121 +++++++++++++++++++++
 include/dt-bindings/dma/cirrus,ep93xx-dma.h        |  26 +++++
 include/linux/platform_data/dma-ep93xx.h           |  21 +---
 4 files changed, 217 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml
new file mode 100644
index 000000000000..80a4352bf8aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml
@@ -0,0 +1,69 @@
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
+    #include <dt-bindings/clock/cirrus,ep9301-clk.h>
+    dma-controller@80000100 {
+        compatible = "cirrus,ep9301-dma-m2m";
+        reg = <0x80000100 0x0040>,
+              <0x80000140 0x0040>;
+        clocks = <&eclk EP93XX_CLK_M2M0>,
+                 <&eclk EP93XX_CLK_M2M1>;
+        clock-names = "m2m0", "m2m1";
+        interrupt-parent = <&vic0>;
+        interrupts = <17>, <18>;
+        #dma-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml
new file mode 100644
index 000000000000..0236cc37233e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml
@@ -0,0 +1,121 @@
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
+    #include <dt-bindings/clock/cirrus,ep9301-clk.h>
+    dma-controller@80000000 {
+        compatible = "cirrus,ep9301-dma-m2p";
+        reg = <0x80000000 0x0040>,
+              <0x80000040 0x0040>,
+              <0x80000080 0x0040>,
+              <0x800000c0 0x0040>,
+              <0x80000240 0x0040>,
+              <0x80000200 0x0040>,
+              <0x800002c0 0x0040>,
+              <0x80000280 0x0040>,
+              <0x80000340 0x0040>,
+              <0x80000300 0x0040>;
+        clocks = <&eclk EP93XX_CLK_M2P0>,
+                 <&eclk EP93XX_CLK_M2P1>,
+                 <&eclk EP93XX_CLK_M2P2>,
+                 <&eclk EP93XX_CLK_M2P3>,
+                 <&eclk EP93XX_CLK_M2P4>,
+                 <&eclk EP93XX_CLK_M2P5>,
+                 <&eclk EP93XX_CLK_M2P6>,
+                 <&eclk EP93XX_CLK_M2P7>,
+                 <&eclk EP93XX_CLK_M2P8>,
+                 <&eclk EP93XX_CLK_M2P9>;
+        clock-names = "m2p0", "m2p1",
+                      "m2p2", "m2p3",
+                      "m2p4", "m2p5",
+                      "m2p6", "m2p7",
+                      "m2p8", "m2p9";
+        interrupt-parent = <&vic0>;
+        interrupts = <7>, <8>, <9>, <10>, <11>, <12>, <13>, <14>, <15>, <16>;
+        #dma-cells = <1>;
+    };
diff --git a/include/dt-bindings/dma/cirrus,ep93xx-dma.h b/include/dt-bindings/dma/cirrus,ep93xx-dma.h
new file mode 100644
index 000000000000..21c7324eb27e
--- /dev/null
+++ b/include/dt-bindings/dma/cirrus,ep93xx-dma.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+#ifndef DT_BINDINGS_CIRRUS_EP93XX_DMA_H
+#define DT_BINDINGS_CIRRUS_EP93XX_DMA_H
+
+/*
+ * M2P channels.
+ *
+ * Note that these values are also directly used for setting the PPALLOC
+ * register.
+ */
+#define EP93XX_DMA_I2S1         0
+#define EP93XX_DMA_I2S2         1
+#define EP93XX_DMA_AAC1         2
+#define EP93XX_DMA_AAC2         3
+#define EP93XX_DMA_AAC3         4
+#define EP93XX_DMA_I2S3         5
+#define EP93XX_DMA_UART1        6
+#define EP93XX_DMA_UART2        7
+#define EP93XX_DMA_UART3        8
+#define EP93XX_DMA_IRDA         9
+/* M2M channels */
+#define EP93XX_DMA_SSP          10
+#define EP93XX_DMA_IDE          11
+
+#endif /* DT_BINDINGS_CIRRUS_EP93XX_DMA_H */
+
diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
index eb9805bb3fe8..54b41d1468ef 100644
--- a/include/linux/platform_data/dma-ep93xx.h
+++ b/include/linux/platform_data/dma-ep93xx.h
@@ -5,26 +5,7 @@
 #include <linux/types.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-
-/*
- * M2P channels.
- *
- * Note that these values are also directly used for setting the PPALLOC
- * register.
- */
-#define EP93XX_DMA_I2S1		0
-#define EP93XX_DMA_I2S2		1
-#define EP93XX_DMA_AAC1		2
-#define EP93XX_DMA_AAC2		3
-#define EP93XX_DMA_AAC3		4
-#define EP93XX_DMA_I2S3		5
-#define EP93XX_DMA_UART1	6
-#define EP93XX_DMA_UART2	7
-#define EP93XX_DMA_UART3	8
-#define EP93XX_DMA_IRDA		9
-/* M2M channels */
-#define EP93XX_DMA_SSP		10
-#define EP93XX_DMA_IDE		11
+#include <dt-bindings/dma/cirrus,ep93xx-dma.h>
 
 /**
  * struct ep93xx_dma_data - configuration data for the EP93xx dmaengine

-- 
2.39.2

