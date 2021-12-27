Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0947FC6F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhL0MGc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:32 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52495 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbhL0MG3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:29 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGz5f-1nFHHi2rQZ-00E4bT; Mon, 27 Dec 2021 13:06:13 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 02/11] dt-bindings: dma: Convert brcm,bcm2835-dma to json-schema
Date:   Mon, 27 Dec 2021 13:05:36 +0100
Message-Id: <1640606743-10993-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:5EBx1vqHQjUwIibXOA/ejfDPHeveGUnOdiS0WCl/uWvy16rhMmD
 3igTFnIZuP1gVfVP8rIgTDPrIn7PY7q8udtRc5qE1va9C7Wne6qmHnryakgbi5ZxgzrR77d
 PIOwPtW+LDq7j0Zyo5jaJccoIWRXLDwWUhUjMSRspJhOoD5gTJG7BKExlSHanoimXDh0F4l
 yLHfln/CqZgmxefhsH4UQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XLJknB9NW4s=:NehJJ6QaDj365aBk3SsIQV
 Q9NOFQla64wFtlsiQdAUwJAmbCuOSMS5XtCmwxboBFue28AZWcFVKW2lzTjulakx6sJXKA6iC
 W1kzm9EBi3W1tB/m1FtXVH4eL9pdLKsDNa20FOueJOK340cL//KmqyFtdhrsHbh+5Hc1IQ2s6
 BWnjpi4cUS+M5HKxqMJolHYBytNLrp18mJNLDuM6tC3IkopsLbHcjyjiIY2s/yBwgNaM53OhV
 fO4Kk7fgwNvB8BeEL/QjN3J0Q2g2Q8fiFeb3vbL6N8VQE+rnP9I6y+oPUUv80IIc34+QGTADD
 CnYKPcpfarWAmmS368opF7kRsOh5Ww+RIN8uL4Qe/QDq099v+yT3K0ixcq0aGSGJbCj3eBJkz
 Mwj8/XaGgwNiVYgTpgc6K2LNgAHjwoyh5EmiUKCy1FOXIST7nzxQUwiPRnvk0khlgmnUe7aV4
 nOtixfZ7dSm/rEji8B+fqUjnIM85ue6amFjfy5jRMulMeBTSoeuSAOTMD3E5jc5+LoJbpxTJ+
 XBy3+sgLuczJjttvgAqaIIubykrtNmm+bZW+AKR8PNbPHpqC1r59RW86cod8hOr0z+Yzh86AR
 /q/Tzr0hopCfLicUYWrx8HHvEw70ewq0I5UF752fmVSbqszcWC0gCwsdeMlQWbWTZEd8JJooJ
 k79sKaW+vHssDsx6fMaslV+lyvKuX352/lyaY/F/M60DtTMPCRipzk8qASeFl1zKAhGTE11qs
 1n88j/QjNUDulgL2
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This convert the BCM2835 DMA bindings to YAML format.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   |  83 ----------------
 .../devicetree/bindings/dma/brcm,bcm2835-dma.yaml  | 107 +++++++++++++++++++++
 2 files changed, 107 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
deleted file mode 100644
index b6a8cc0..0000000
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
index 0000000..44cb83f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.yaml
@@ -0,0 +1,107 @@
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
+description: |
+  The BCM2835 DMA controller has 16 channels in total.
+  Only the lower 13 channels have an associated IRQ.
+  Some arbitrary channels are used by the firmware
+  (1,3,6,7 in the current firmware version).
+  The channels 0,2 and 3 have special functionality
+  and should not be used by the driver.
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
+  "#dma-cells":
+    const: 1
+    description: >
+      DMA clients must use the format described in dma.txt, giving a phandle
+      to the DMA controller while the second cell in the dmas property of the
+      client device represents the DREQ number.
+
+  brcm,dma-channel-mask:
+    description:
+      Bit mask representing the channels not used by the firmware in
+      ascending order, i.e. first channel corresponds to LSB.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - brcm,dma-channel-mask
+
+additionalProperties: false
+
+examples:
+  - |
+    dma: dma-controller@7e007000 {
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
2.7.4

