Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589CB734152
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jun 2023 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjFQNhL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jun 2023 09:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjFQNhJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jun 2023 09:37:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CE7E76;
        Sat, 17 Jun 2023 06:37:07 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MDyoW-1qIB4O3sYe-009xZN; Sat, 17 Jun 2023 15:36:41 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 2/7] dt-bindings: dma: convert bcm2835-dma bindings to YAML
Date:   Sat, 17 Jun 2023 15:36:15 +0200
Message-Id: <20230617133620.53129-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617133620.53129-1-stefan.wahren@i2se.com>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SMCweP7CjBUg9TJaFmx+JT9DWEI9Cf+A5pEvrkXawHTf0lH2NoL
 FN5znBD2IZjkeXfhCMa9FqAvBtUQKBJoy2OHIIaNEGluQqVUyuNQE26P1+5jt1Dt1gCpsp6
 fH+DE3zFHPZ5cSLCsCR3rsIupTId3E0McqcfRfPI8+N1Mw8cfncOdEfD8Uo1ezk7xAanyBh
 1m36rVaLFqzBsXDRth//Q==
UI-OutboundReport: notjunk:1;M01:P0:24tRoCPrR4M=;SSDp+KJP5S/XIQSmZ3YQgK4YNhv
 zwyuH4sekOJqZ/V1wStyGKJ03QV+vVXLNxPn9bee5aakudOHRvKgG3PhT/mWyA3tPUJHvHDCg
 5u8FJRyrqqGGd0AYwY5iaiiNDZu3B9lbE4UNsKAhyURjEjEQiU88VDkNnVwiuD3RSYnuKlx8o
 /eexGj7VH99/ox73oSaI6sFmrWD/xjkoiuAE+Gu0i2mW4xVRlJL+7bCg385HjkcBqhFkqpoFG
 VsmTB4zccV8b8h6XWl1SoosOnn9wXddavVp9XyRnwNLR7TIsAYTSHExpI/U27pOavKMfzVQi9
 pNlUnqPAuM6mxEm9uk2ZW7hk3okOtDwYY0dIt2xoRJ14/Ffm/WygFXQQV+ogO8rs0yDQq1EYK
 aRSkH/EmoFgZND3WxYu7IcGu01TZ3Z3vB5F+lfLfgJyAPeo7NM/oZS8Z39Nv153RSmVZxN11g
 sTcnTnYyo0tYeUbDFJI1u2TuYlF8nsOV+QW/Mtu4I/4Z2ChgCf6tmOejDhLUESRHkAeg5I07D
 68Lc87k0TYvqZqoWN659OhG5nbD0AMjdlP5NZ5KHyEL5zhwHu9qjMbvCAQE7tPgYsbH2vr1cj
 I0fDdlkUacH5IaOi8gizE1wOiSP+1pLFLlyBZiCraS92s5XiPrPe9IHXuIEvUWB+WVAS1H2Zm
 +O3nPXHByHABzIDbL2YIGAwD+Pryoif+iXHv7ZZ4EQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for bcm2835-dma from .txt to YAML.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/dma/brcm,bcm2835-dma.txt         |  83 --------------
 .../bindings/dma/brcm,bcm2835-dma.yaml        | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
deleted file mode 100644
index b6a8cc0978cd..000000000000
--- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-* BCM2835 DMA controller
-
-The BCM2835 DMA controller has 16 channels in total.
-Only the lower 13 channels have an associated IRQ.
-Some arbitrary channels are used by the firmware
-(1,3,6,7 in the current firmware version).
-The channels 0,2 and 3 have special functionality
-and should not be used by the driver.
-
-Required properties:
-- compatible: Should be "brcm,bcm2835-dma".
-- reg: Should contain DMA registers location and length.
-- interrupts: Should contain the DMA interrupts associated
-		to the DMA channels in ascending order.
-- interrupt-names: Should contain the names of the interrupt
-		   in the form "dmaXX".
-		   Use "dma-shared-all" for the common interrupt line
-		   that is shared by all dma channels.
-- #dma-cells: Must be <1>, the cell in the dmas property of the
-		client device represents the DREQ number.
-- brcm,dma-channel-mask: Bit mask representing the channels
-			 not used by the firmware in ascending order,
-			 i.e. first channel corresponds to LSB.
-
-Example:
-
-dma: dma@7e007000 {
-	compatible = "brcm,bcm2835-dma";
-	reg = <0x7e007000 0xf00>;
-	interrupts = <1 16>,
-		     <1 17>,
-		     <1 18>,
-		     <1 19>,
-		     <1 20>,
-		     <1 21>,
-		     <1 22>,
-		     <1 23>,
-		     <1 24>,
-		     <1 25>,
-		     <1 26>,
-		     /* dma channel 11-14 share one irq */
-		     <1 27>,
-		     <1 27>,
-		     <1 27>,
-		     <1 27>,
-		     /* unused shared irq for all channels */
-		     <1 28>;
-	interrupt-names = "dma0",
-			  "dma1",
-			  "dma2",
-			  "dma3",
-			  "dma4",
-			  "dma5",
-			  "dma6",
-			  "dma7",
-			  "dma8",
-			  "dma9",
-			  "dma10",
-			  "dma11",
-			  "dma12",
-			  "dma13",
-			  "dma14",
-			  "dma-shared-all";
-
-	#dma-cells = <1>;
-	brcm,dma-channel-mask = <0x7f35>;
-};
-
-
-DMA clients connected to the BCM2835 DMA controller must use the format
-described in the dma.txt file, using a two-cell specifier for each channel.
-
-Example:
-
-bcm2835_i2s: i2s@7e203000 {
-	compatible = "brcm,bcm2835-i2s";
-	reg = <	0x7e203000 0x24>;
-	clocks = <&clocks BCM2835_CLOCK_PCM>;
-
-	dmas = <&dma 2>,
-	       <&dma 3>;
-	dma-names = "tx", "rx";
-};
diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
new file mode 100644
index 000000000000..5de8421e933a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/brcm,bcm2835-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM2835 DMA controller
+
+maintainers:
+  - Nicolas Saenz Julienne <nsaenz@kernel.org>
+
+description:
+  The BCM2835 DMA controller has 16 channels in total. Only the lower
+  13 channels have an associated IRQ. Some arbitrary channels are used by the
+  VideoCore firmware (1,3,6,7 in the current firmware version). The channels
+  0, 2 and 3 have special functionality and should not be used by the driver.
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm2835-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Should contain the DMA interrupts associated to the DMA channels in
+      ascending order.
+    minItems: 1
+    maxItems: 16
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 16
+
+  '#dma-cells':
+    description: The single cell represents the DREQ number.
+    const: 1
+
+  brcm,dma-channel-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Bitmask of available DMA channels in ascending order that are
+      not reserved by firmware and are available to the
+      kernel. i.e. first channel corresponds to LSB.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - brcm,dma-channel-mask
+
+examples:
+  - |
+    dma-controller@7e007000 {
+      compatible = "brcm,bcm2835-dma";
+      reg = <0x7e007000 0xf00>;
+      interrupts = <1 16>,
+                   <1 17>,
+                   <1 18>,
+                   <1 19>,
+                   <1 20>,
+                   <1 21>,
+                   <1 22>,
+                   <1 23>,
+                   <1 24>,
+                   <1 25>,
+                   <1 26>,
+                   /* dma channel 11-14 share one irq */
+                   <1 27>,
+                   <1 27>,
+                   <1 27>,
+                   <1 27>,
+                   /* unused shared irq for all channels */
+                   <1 28>;
+      interrupt-names = "dma0",
+                        "dma1",
+                        "dma2",
+                        "dma3",
+                        "dma4",
+                        "dma5",
+                        "dma6",
+                        "dma7",
+                        "dma8",
+                        "dma9",
+                        "dma10",
+                        "dma11",
+                        "dma12",
+                        "dma13",
+                        "dma14",
+                        "dma-shared-all";
+        #dma-cells = <1>;
+        brcm,dma-channel-mask = <0x7f35>;
+    };
+
+...
-- 
2.34.1

