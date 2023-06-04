Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34627721698
	for <lists+dmaengine@lfdr.de>; Sun,  4 Jun 2023 14:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFDMN0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jun 2023 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjFDMNZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Jun 2023 08:13:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C35DB;
        Sun,  4 Jun 2023 05:13:21 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYN7M-1pbPdB1oB8-00VQsj; Sun, 04 Jun 2023 14:12:43 +0200
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 03/10] dt-bindings: dma: convert bcm2835-dma bindings to YAML
Date:   Sun,  4 Jun 2023 14:12:16 +0200
Message-Id: <20230604121223.9625-4-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604121223.9625-1-stefan.wahren@i2se.com>
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/DYqJCPanm08IVBLMJyh/pdGyuuxwXbEVgfjLIDmscRCU1NhtUj
 79EOpxxt2arSufaI7U1uLOZhYntT8/XQIlpmwCfsmEL0MIaIKEm092hU9HApjE2az/mZFhW
 k0ZA/VoFtqmYWBUxH2TLGMNLhRIsNXjUbEp7b1MpZz/JbEe0RO3NTRwzBomkUeCInkX8Cai
 eHU4H81IHh4Z2JaPc/2EA==
UI-OutboundReport: notjunk:1;M01:P0:duIpyYLtPW0=;KVa6IYHyFloX7F52MS9l4x3nYB8
 611sPSdVsdgt2yXnD6RkfDUAA0cH+jsGzzMjrRprE73Dxeoe1ipJa5Dn5+QkldgnYCAoY1QhC
 VquTfCmkKVLeyWpqiF0w4KrN7SZCdcKXOUzUUeKAerNah05Y/3NjGMKfdoa5oxMEYc/X80l7l
 zd1HhZQshNgowr67XcxCYWEZVDPP6H4iJKRFV3vxbvEV+e2WyStfGfESp1zt96zg5tVOGCk8C
 xI+utlu+mLeyeOpfLC9YdDZXAvsRx48M7vlImhAmu1ZB7TAh9JOSHklpoLEl14iHqzFAMyBFv
 zIhJdGakWhZreDZ5EH1ADPTI8n5+kD8zwPwWFOUPVAfA+U2UnKyNz5ps8pxbe4xvGkHvu+09o
 JwIOTWQ1sFfAEClzkqRpWFBSewfHGbHfxAnPQ/ySsO8T1P8P2kxfCRCkKLskuLLqFsCnH8LPW
 QkSgP07ukpf4giaJCGWWZbPKIxkwECuxtVU0M3oHo/ia81UAt+XIodkN1yKRADksqfsbVG3oz
 iWjtXsLNL9OV0UpKFjMdlNk7QrfBgymUmAeQrQzv192zr49YwC69CwYcP5Dl9uAN7Liy8sgq5
 iNKR8icQsA1ieQDWF8Hh0t7Xuw5ABRlzBLlQlqP7vk7WYbD9h7pF3b/UVe4skTmdXFIkbo7LG
 8qXwgiOPkyjOUVVARm04bvlJ0kFfZGXg6djOydXRIA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the DT binding document for bcm2835-dma from .txt to YAML.
Since brcm,dma-channel-mask is considered deprecated use the
generic property.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/dma/brcm,bcm2835-dma.txt         | 83 ----------------
 .../bindings/dma/brcm,bcm2835-dma.yaml        | 98 +++++++++++++++++++
 2 files changed, 98 insertions(+), 83 deletions(-)
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
index 000000000000..a09000a8131f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
@@ -0,0 +1,98 @@
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
+  - $ref: "dma-controller.yaml#"
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
+  dma-channel-mask:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - dma-channel-mask
+
+unevaluatedProperties: false
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
+        dma-channel-mask = <0x7f35>;
+    };
+
+...
-- 
2.34.1

