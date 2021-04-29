Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE636F094
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 22:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhD2T1L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD2T0y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Apr 2021 15:26:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890EDC061240
        for <dmaengine@vger.kernel.org>; Thu, 29 Apr 2021 12:25:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso703496wmh.0
        for <dmaengine@vger.kernel.org>; Thu, 29 Apr 2021 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FwO92DrnPsKVPwus54vmUdiWfGkOW+bLS6zDiNcyBmI=;
        b=cHk5rJqmgjp+4d8Ii0xqQ7CuIjZzZ/wk9qu/IYMdPbkLUQKk9O6X6JLgQkNJu4XPXE
         Afo4/kxdw8rbpQ5ukSdkDLSuJgq5RYiogN69oNXpWSIy7C/hR4uS8+un2irhJy4xYOri
         eVvEjHOg1/OfkTLmbpgltWt54/p02QTFTupbzczAW4Vv7B60pp1Q2moKooMk5IOAEAWn
         iCIcUzzuHP8pVxEKrlxP9NGNi5y6tpLfkJEGdRzH2UC/TlvyF8UE/t7Wlfm69FfL0/AI
         6RHoC49xg0OzjYna4vFStVKAA+gjHU53SgxwGGD3Qycukh13M2Ner9FNENVVZZoEiofM
         fo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FwO92DrnPsKVPwus54vmUdiWfGkOW+bLS6zDiNcyBmI=;
        b=CjmHwXS5D1+7ZKqB8fQDQaUJsGVdz6A6FvP3a0Gb9zrgxBUYVndnV9Bas3lA5IROib
         2yqCgANd+ic3D2vsECwJUzGoC3dAFzu6sdu+SSGZ/JCkiqk4m5zYGL2ifqm+g4//WkTb
         Vw0xSeIxH3srGYI05aLipznqC9qxCySti0Nk2v5SeSyfQBdr8gpAd6oJbQ8BTw1palwZ
         e3UBhpbP5flSVfdhX/gxCzaPazP63ao87zOIoakpgLzKqdM9KS3d9S347IWfVbtKj56G
         j6L3FkE3EgXXPpe+2LCN/f0lRVCgT0eF5Z7graJ2hVbsM65AG0Q9p1sl5L+f6179PoXI
         P3jA==
X-Gm-Message-State: AOAM530f2GutH2LIp3W3DskMBWbQtA/hYLEP9V2bgEmMdnxqwRp1eQIp
        Snbdpk0IGP8Z0r4YtNpfcZpYag==
X-Google-Smtp-Source: ABdhPJz3JuvnbQfWlxw2RaXg9/x7pHzO0+4Yn1MNLuILGMsetLcTIFnrS5C5LlYuyJXCCFb+YOUzZg==
X-Received: by 2002:a05:600c:3643:: with SMTP id y3mr12043754wmq.159.1619724310264;
        Thu, 29 Apr 2021 12:25:10 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l14sm6133316wrv.94.2021.04.29.12.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 12:25:09 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] dt-bindings: dma: convert arm-pl08x to yaml
Date:   Thu, 29 Apr 2021 19:25:04 +0000
Message-Id: <20210429192504.1148842-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Converts dma/arm-pl08x.txt to yaml.
In the process, I add an example for the faraday variant.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- fixes yamllint warning about indent
- added select
- fixed example (needed includes)

 .../devicetree/bindings/dma/arm-pl08x.txt     |  59 --------
 .../devicetree/bindings/dma/arm-pl08x.yaml    | 141 ++++++++++++++++++
 2 files changed, 141 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.yaml

diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.txt b/Documentation/devicetree/bindings/dma/arm-pl08x.txt
deleted file mode 100644
index 0ba81f79266f..000000000000
--- a/Documentation/devicetree/bindings/dma/arm-pl08x.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-* ARM PrimeCells PL080 and PL081 and derivatives DMA controller
-
-Required properties:
-- compatible: "arm,pl080", "arm,primecell";
-	      "arm,pl081", "arm,primecell";
-	      "faraday,ftdmac020", "arm,primecell"
-- arm,primecell-periphid: on the FTDMAC020 the primecell ID is not hard-coded
-  in the hardware and must be specified here as <0x0003b080>. This number
-  follows the PrimeCell standard numbering using the JEP106 vendor code 0x38
-  for Faraday Technology.
-- reg: Address range of the PL08x registers
-- interrupt: The PL08x interrupt number
-- clocks: The clock running the IP core clock
-- clock-names: Must contain "apb_pclk"
-- lli-bus-interface-ahb1: if AHB master 1 is eligible for fetching LLIs
-- lli-bus-interface-ahb2: if AHB master 2 is eligible for fetching LLIs
-- mem-bus-interface-ahb1: if AHB master 1 is eligible for fetching memory contents
-- mem-bus-interface-ahb2: if AHB master 2 is eligible for fetching memory contents
-- #dma-cells: must be <2>. First cell should contain the DMA request,
-              second cell should contain either 1 or 2 depending on
-              which AHB master that is used.
-
-Optional properties:
-- dma-channels: contains the total number of DMA channels supported by the DMAC
-- dma-requests: contains the total number of DMA requests supported by the DMAC
-- memcpy-burst-size: the size of the bursts for memcpy: 1, 4, 8, 16, 32
-  64, 128 or 256 bytes are legal values
-- memcpy-bus-width: the bus width used for memcpy in bits: 8, 16 or 32 are legal
-  values, the Faraday FTDMAC020 can also accept 64 bits
-
-Clients
-Required properties:
-- dmas: List of DMA controller phandle, request channel and AHB master id
-- dma-names: Names of the aforementioned requested channels
-
-Example:
-
-dmac0: dma-controller@10130000 {
-	compatible = "arm,pl080", "arm,primecell";
-	reg = <0x10130000 0x1000>;
-	interrupt-parent = <&vica>;
-	interrupts = <15>;
-	clocks = <&hclkdma0>;
-	clock-names = "apb_pclk";
-	lli-bus-interface-ahb1;
-	lli-bus-interface-ahb2;
-	mem-bus-interface-ahb2;
-	memcpy-burst-size = <256>;
-	memcpy-bus-width = <32>;
-	#dma-cells = <2>;
-};
-
-device@40008000 {
-	...
-	dmas = <&dmac0 0 2
-		&dmac0 1 2>;
-	dma-names = "tx", "rx";
-	...
-};
diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
new file mode 100644
index 000000000000..06dec6f3e9a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/arm-pl08x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM PrimeCells PL080 and PL081 and derivatives DMA controller
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - arm,pl080
+          - arm,pl081
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: "arm,pl080"
+          - const: "arm,primecell"
+      - items:
+          - const: "arm,pl081"
+          - const: "arm,primecell"
+      - items:
+          - const: faraday,ftdma020
+          - const: arm,pl080
+          - const: arm,primecell
+  arm,primecell-periphid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: on the FTDMAC020 the primecell ID is not hard-coded
+                 in the hardware and must be specified here as <0x0003b080>. This number
+                 follows the PrimeCell standard numbering using the JEP106 vendor code 0x38
+                 for Faraday Technology.
+  reg:
+    minItems: 1
+    description: Address range of the PL08x registers
+  interrupts:
+    minItems: 1
+    description: The PL08x interrupt number
+  clocks:
+    minItems: 1
+    description: The clock running the IP core clock
+  clock-names:
+    const: "apb_pclk"
+  lli-bus-interface-ahb1:
+    type: boolean
+    description: if AHB master 1 is eligible for fetching LLIs
+  lli-bus-interface-ahb2:
+    type: boolean
+    description: if AHB master 2 is eligible for fetching LLIs
+  mem-bus-interface-ahb1:
+    type: boolean
+    description: if AHB master 1 is eligible for fetching memory contents
+  mem-bus-interface-ahb2:
+    type: boolean
+    description: if AHB master 2 is eligible for fetching memory contents
+  "#dma-cells":
+    const: 2
+    description: must be <2>. First cell should contain the DMA request,
+                 second cell should contain either 1 or 2 depending on
+                 which AHB master that is used.
+
+  memcpy-burst-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 1
+      - 4
+      - 8
+      - 16
+      - 32
+      - 64
+      - 128
+      - 256
+    description: the size of the bursts for memcpy
+  memcpy-bus-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 8
+      - 16
+      - 32
+      - 64
+    description: |
+                 the bus width used for memcpy in bits: 8, 16 or 32 are legal
+                 values, the Faraday FTDMAC020 can also accept 64 bits
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    dmac0: dma-controller@10130000 {
+      compatible = "arm,pl080", "arm,primecell";
+      reg = <0x10130000 0x1000>;
+      interrupt-parent = <&vica>;
+      interrupts = <15>;
+      clocks = <&hclkdma0>;
+      clock-names = "apb_pclk";
+      lli-bus-interface-ahb1;
+      lli-bus-interface-ahb2;
+      mem-bus-interface-ahb2;
+      memcpy-burst-size = <256>;
+      memcpy-bus-width = <32>;
+      #dma-cells = <2>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/reset/cortina,gemini-reset.h>
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+    dma-controller@67000000 {
+      compatible = "faraday,ftdma020", "arm,pl080", "arm,primecell";
+      /* Faraday Technology FTDMAC020 variant */
+      arm,primecell-periphid = <0x0003b080>;
+      reg = <0x67000000 0x1000>;
+      interrupts = <9 IRQ_TYPE_EDGE_RISING>;
+      resets = <&syscon GEMINI_RESET_DMAC>;
+      clocks = <&syscon GEMINI_CLK_AHB>;
+      clock-names = "apb_pclk";
+      /* Bus interface AHB1 (AHB0) is totally tilted */
+      lli-bus-interface-ahb2;
+      mem-bus-interface-ahb2;
+      memcpy-burst-size = <256>;
+      memcpy-bus-width = <32>;
+      #dma-cells = <2>;
+    };
-- 
2.26.3

