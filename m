Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947EE650962
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 10:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiLSJhY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 04:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiLSJhX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 04:37:23 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017066249;
        Mon, 19 Dec 2022 01:37:21 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CD96384480;
        Mon, 19 Dec 2022 10:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671442639;
        bh=TxtTjPiKxLORzwmcpAANzpgmAGJleDoXm2KN/wUzCHc=;
        h=From:To:Cc:Subject:Date:From;
        b=Got4flQo+qTUCW4iFs09+Tj5NsZ7BbAbUl+H2he/XxsaoymrxB9IHQjZQoq6pZH57
         CsICPKPfdfZhrvdyid4p0H+IvjOThZVRr9y83OzR4ycG6qqEPPwSQhDzLYAWM/I2uJ
         uuBvlqpPfc/hoxRw8f9PulOOTaRmRCyrq2nMlhv4QadvC0jOIoZB7KtMpQMsrE5b7t
         PG12SFTTxsWBE9qIuL/e6XoIeuL1nLxzA/BVwScalkpfqlLKWdBNfmcl9b24mh3GXI
         WQL9QIa98caB4JKHqk6/1G0oIlnjGxc5RY5JGQsjud0i4B5uA6cCxun8qbtbCzKsvW
         J46LFzoKBgKHg==
From:   Marek Vasut <marex@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT schema
Date:   Mon, 19 Dec 2022 10:37:13 +0100
Message-Id: <20221219093713.328776-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the MXS DMA binding to DT schema format using json-schema.

Drop "interrupt-names" property, since it is broken. The drivers/dma/mxs-dma.c
in Linux kernel does not use it, the property contains duplicate array entries
in existing DTs, and even malformed entries (gmpi, should have been gpmi). Get
rid of that optional property altogether.

Update example node names to be standard dma-controller@ ,
add global interrupt-parent property into example.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
To: devicetree@vger.kernel.org
---
V2: - Drop -items:-enum: and use plain -enum:
    - Fill in blank line between maxItems:8 and if:
    - Move not: past if:
    - Drop the entire allOf section except ref dma-controller.yaml
---
 .../devicetree/bindings/dma/fsl,mxs-dma.yaml  | 80 +++++++++++++++++++
 .../devicetree/bindings/dma/fsl-mxs-dma.txt   | 60 --------------
 2 files changed, 80 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
new file mode 100644
index 0000000000000..add9c77e8b52a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl,mxs-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Direct Memory Access (DMA) Controller from i.MX23/i.MX28
+
+maintainers:
+  - Marek Vasut <marex@denx.de>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx6q-dma-apbh
+              - fsl,imx6sx-dma-apbh
+              - fsl,imx7d-dma-apbh
+          - const: fsl,imx28-dma-apbh
+      - enum:
+          - fsl,imx23-dma-apbh
+          - fsl,imx23-dma-apbx
+          - fsl,imx28-dma-apbh
+          - fsl,imx28-dma-apbx
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+    maxItems: 16
+
+  "#dma-cells":
+    const: 1
+
+  dma-channels:
+    enum: [4, 8, 16]
+
+required:
+  - compatible
+  - reg
+  - "#dma-cells"
+  - dma-channels
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-parent = <&irqc>;
+
+    dma-controller@80004000 {
+      compatible = "fsl,imx28-dma-apbh";
+      reg = <0x80004000 0x2000>;
+      interrupts = <82 83 84 85
+                    88 88 88 88
+                    88 88 88 88
+                    87 86 0 0>;
+      #dma-cells = <1>;
+      dma-channels = <16>;
+    };
+
+    dma-controller@80024000 {
+      compatible = "fsl,imx28-dma-apbx";
+      reg = <0x80024000 0x2000>;
+      interrupts = <78 79 66 0
+                    80 81 68 69
+                    70 71 72 73
+                    74 75 76 77>;
+      #dma-cells = <1>;
+      dma-channels = <16>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
deleted file mode 100644
index e30e184f50c72..0000000000000
--- a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-* Freescale MXS DMA
-
-Required properties:
-- compatible : Should be "fsl,<chip>-dma-apbh" or "fsl,<chip>-dma-apbx"
-- reg : Should contain registers location and length
-- interrupts : Should contain the interrupt numbers of DMA channels.
-  If a channel is empty/reserved, 0 should be filled in place.
-- #dma-cells : Must be <1>.  The number cell specifies the channel ID.
-- dma-channels : Number of channels supported by the DMA controller
-
-Optional properties:
-- interrupt-names : Name of DMA channel interrupts
-
-Supported chips:
-imx23, imx28.
-
-Examples:
-
-dma_apbh: dma-apbh@80004000 {
-	compatible = "fsl,imx28-dma-apbh";
-	reg = <0x80004000 0x2000>;
-	interrupts = <82 83 84 85
-		      88 88 88 88
-		      88 88 88 88
-		      87 86 0 0>;
-	interrupt-names = "ssp0", "ssp1", "ssp2", "ssp3",
-			  "gpmi0", "gmpi1", "gpmi2", "gmpi3",
-			  "gpmi4", "gmpi5", "gpmi6", "gmpi7",
-			  "hsadc", "lcdif", "empty", "empty";
-	#dma-cells = <1>;
-	dma-channels = <16>;
-};
-
-dma_apbx: dma-apbx@80024000 {
-	compatible = "fsl,imx28-dma-apbx";
-	reg = <0x80024000 0x2000>;
-	interrupts = <78 79 66 0
-		      80 81 68 69
-		      70 71 72 73
-		      74 75 76 77>;
-	interrupt-names = "auart4-rx", "auart4-tx", "spdif-tx", "empty",
-			  "saif0", "saif1", "i2c0", "i2c1",
-			  "auart0-rx", "auart0-tx", "auart1-rx", "auart1-tx",
-			  "auart2-rx", "auart2-tx", "auart3-rx", "auart3-tx";
-	#dma-cells = <1>;
-	dma-channels = <16>;
-};
-
-DMA clients connected to the MXS DMA controller must use the format
-described in the dma.txt file.
-
-Examples:
-
-auart0: serial@8006a000 {
-	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
-	reg = <0x8006a000 0x2000>;
-	interrupts = <112>;
-	dmas = <&dma_apbx 8>, <&dma_apbx 9>;
-	dma-names = "rx", "tx";
-};
-- 
2.35.1

