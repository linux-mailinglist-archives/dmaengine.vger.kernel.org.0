Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E3A479267
	for <lists+dmaengine@lfdr.de>; Fri, 17 Dec 2021 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhLQRHB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Dec 2021 12:07:01 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45692 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbhLQRG7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Dec 2021 12:06:59 -0500
Received: by mail-ot1-f52.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso3626753otf.12;
        Fri, 17 Dec 2021 09:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jIcAGBsH93IVEmESrr2eOsNfTOo9xXRXTvyxq8+pwP0=;
        b=KuMP+BN/mGNBCiUBf6hWssNBFTMnWSJhXfny/meWHoaZ4s0Nlh3JWZxNLx6L53fAuR
         8d5HbMxarsgUGqVUocabtAwjG9hI0HNiiJbXsTzGGNHgN9mV+3tqmoYkS5AS853O5Rl7
         yB/B6uiA6JH1p5CotNTkeEt2XZDwqI8APTVrWjeQcLURAvlIfYgjr1JOC9r3HpN68vSn
         amt5Rzjn1L7NXkc75xCtU55XBhE1Cnhbb0mU3FqSml/r0s2bvCU7w+qHmw4IHJOeQS7B
         I8ksY93RQ0e/GXDGRfr00YXCGqG0b9U+JCOg/wahYUwfJkbxLM8KQPjHWH4qwMHXnnBf
         CMoA==
X-Gm-Message-State: AOAM530XP25ukSZyD72MvlkfyTqHSi216AL85W3UiGsv1OdvvP0cYfZe
        iIMnOU2lIpEG2jhRwMlsennjPCGEYw==
X-Google-Smtp-Source: ABdhPJwLTNm0xFKP2i+PsRsIwaSxyq6thKDtuz8Bja2H6C/udpSljFrok13aA/LofvZCJoSaO88xsQ==
X-Received: by 2002:a05:6830:34a0:: with SMTP id c32mr2923461otu.379.1639760818673;
        Fri, 17 Dec 2021 09:06:58 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id bp11sm1820079oib.38.2021.12.17.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:06:58 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: pl330: Convert to DT schema
Date:   Fri, 17 Dec 2021 11:06:43 -0600
Message-Id: <20211217170644.3145332-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the Arm PL330 DMA controller binding to DT schema.

The '#dma-channels' and '#dma-requests' properties are unused as they are
discoverable and are non-standard (the standard props don't have '#'). So
drop them from the binding.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/dma/arm,pl330.yaml    | 83 +++++++++++++++++++
 .../devicetree/bindings/dma/arm-pl330.txt     | 49 -----------
 2 files changed, 83 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/arm,pl330.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl330.txt

diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
new file mode 100644
index 000000000000..decab185cf4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/arm,pl330.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM PrimeCell PL330 DMA Controller
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description:
+  The ARM PrimeCell PL330 DMA controller can move blocks of memory contents
+  between memory and peripherals or memory to memory.
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,pl330
+  required:
+    - compatible
+
+allOf:
+  - $ref: dma-controller.yaml#
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - arm,pl330
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 32
+    description: A single combined interrupt or an interrupt per event
+
+  '#dma-cells':
+    const: 1
+    description: Contains the DMA request number for the consumer
+
+  arm,pl330-broken-no-flushp:
+    type: boolean
+    description: quirk for avoiding to execute DMAFLUSHP
+
+  arm,pl330-periph-burst:
+    type: boolean
+    description: quirk for performing burst transfer only
+
+  dma-coherent: true
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: dma
+      - const: dma-ocp
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    dma-controller@12680000 {
+        compatible = "arm,pl330", "arm,primecell";
+        reg = <0x12680000 0x1000>;
+        interrupts = <99>;
+        #dma-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
deleted file mode 100644
index 315e90122afa..000000000000
--- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-* ARM PrimeCell PL330 DMA Controller
-
-The ARM PrimeCell PL330 DMA controller can move blocks of memory contents
-between memory and peripherals or memory to memory.
-
-Required properties:
-  - compatible: should include both "arm,pl330" and "arm,primecell".
-  - reg: physical base address of the controller and length of memory mapped
-    region.
-  - interrupts: interrupt number to the cpu.
-
-Optional properties:
-  - dma-coherent      : Present if dma operations are coherent
-  - #dma-cells: must be <1>. used to represent the number of integer
-    cells in the dmas property of client device.
-  - dma-channels: contains the total number of DMA channels supported by the DMAC
-  - dma-requests: contains the total number of DMA requests supported by the DMAC
-  - arm,pl330-broken-no-flushp: quirk for avoiding to execute DMAFLUSHP
-  - arm,pl330-periph-burst: quirk for performing burst transfer only
-  - resets: contains an entry for each entry in reset-names.
-	    See ../reset/reset.txt for details.
-  - reset-names: must contain at least "dma", and optional is "dma-ocp".
-
-Example:
-
-	pdma0: pdma@12680000 {
-		compatible = "arm,pl330", "arm,primecell";
-		reg = <0x12680000 0x1000>;
-		interrupts = <99>;
-		#dma-cells = <1>;
-		#dma-channels = <8>;
-		#dma-requests = <32>;
-	};
-
-Client drivers (device nodes requiring dma transfers from dev-to-mem or
-mem-to-dev) should specify the DMA channel numbers and dma channel names
-as shown below.
-
-  [property name]  = <[phandle of the dma controller] [dma request id]>;
-  [property name]  = <[dma channel name]>
-
-      where 'dma request id' is the dma request number which is connected
-      to the client controller. The 'property name' 'dmas' and 'dma-names'
-      as required by the generic dma device tree binding helpers. The dma
-      names correspond 1:1 with the dma request ids in the dmas property.
-
-  Example:  dmas = <&pdma0 12
-		    &pdma1 11>;
-	    dma-names = "tx", "rx";
-- 
2.32.0

