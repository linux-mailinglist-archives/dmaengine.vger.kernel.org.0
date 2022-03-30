Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA3B4ECA15
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349079AbiC3Q4N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349083AbiC3Q4M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 12:56:12 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8647D36B59;
        Wed, 30 Mar 2022 09:54:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648658714; bh=vezI7Vb6EsH9NmBmKIpXJGQJTm9trs6SWXfvudn0Ej0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Be23g2jMXdEQrhnl5wsePDhbST24/waN01xf645qOcPOiEjqTY4uxfmnS0SIytQfA
         VbezQpWU9DmPlrrKyzT3tTEqLH/TyXYgZ6rIDyuzhdsxlzhRgbVOOIDSqyw6vRUwxk
         Arm6Y5IxWf5vA/FHHkdCxSgkvEC/lkY/dvlCt+7o=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 1/2] dt-bindings: dma: Add Apple ADMAC
Date:   Wed, 30 Mar 2022 18:44:57 +0200
Message-Id: <20220330164458.93055-2-povik+lin@cutebit.org>
In-Reply-To: <20220330164458.93055-1-povik+lin@cutebit.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
samples on Apple SoCs from the "Apple Silicon" family.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 .../devicetree/bindings/dma/apple,admac.yaml  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml

diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
new file mode 100644
index 000000000000..34f76a9a2983
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/apple,admac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Audio DMA Controller (ADMAC)
+
+description: |
+  Apple's Audio DMA Controller (ADMAC) is used to fetch and store
+  audio samples on Apple SoCs from the "Apple Silicon" family.
+
+maintainers:
+  - Martin Povišer <povik+lin@cutebit.org>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t6000-admac
+          - apple,t8103-admac
+      - const: apple,admac
+
+  reg:
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+
+  apple,internal-irq-destination:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Index influencing internal routing of the IRQs
+      within the peripheral.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#dma-cells'
+  - dma-channels
+  - apple,internal-irq-destination
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    dart_sio: iommu@235004000 {
+      compatible = "apple,t8103-dart", "apple,dart";
+      reg = <0x2 0x35004000 0x0 0x4000>;
+      interrupt-parent = <&aic>;
+      interrupts = <AIC_IRQ 635 IRQ_TYPE_LEVEL_HIGH>;
+      #iommu-cells = <1>;
+    };
+
+    admac: dma-controller@238200000 {
+      compatible = "apple,t8103-admac", "apple,admac";
+      reg = <0x2 0x38200000 0x0 0x34000>;
+      dma-channels = <12>;
+      interrupt-parent = <&aic>;
+      interrupts = <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
+      #dma-cells = <1>;
+      iommus = <&dart_sio 2>;
+      apple,internal-irq-destination = <1>;
+    };
-- 
2.33.0

