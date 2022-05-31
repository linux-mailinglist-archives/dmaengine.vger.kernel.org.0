Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD743539911
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 23:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbiEaVwf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 17:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiEaVwc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 17:52:32 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E122B0D;
        Tue, 31 May 2022 14:52:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654033458; bh=CPWVSVHa28KDvdSstDaWFZDL9Ast1WCVvqOwg7GnnT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Os1rOH6XwiMKLoqEenByIV0k5qVxbh3QQbaCHEdIkDO1ywtyZ7NwBUcAWKM9CpF8f
         4YL/NGmv8I3ttkzhhLYJdM5YK1Ek4hAWjOBjLhMKLrTW+ldCqtR/CwI6DzPrvo+aSA
         9r/ZJ7klFn88cqx3X9Ns5CQqP9tEkRPK2gk3yyvY=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: dma: Add Apple ADMAC
Date:   Tue, 31 May 2022 23:36:13 +0200
Message-Id: <20220531213615.7822-2-povik+lin@cutebit.org>
In-Reply-To: <20220531213615.7822-1-povik+lin@cutebit.org>
References: <20220531213615.7822-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
samples on SoCs from the "Apple Silicon" family.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 .../devicetree/bindings/dma/apple,admac.yaml  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml

diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
new file mode 100644
index 000000000000..ab8a4ec7779f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/apple,admac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Audio DMA Controller (ADMAC)
+
+description: |
+  Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio samples
+  on SoCs from the "Apple Silicon" family.
+
+  The controller has been seen with up to 24 channels. Even-numbered channels
+  are TX-only, odd-numbered are RX-only. Individual channels are coupled to
+  fixed device endpoints.
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
+    description:
+      Clients specify a single cell with channel number.
+
+  dma-channels:
+    maximum: 24
+
+  interrupts:
+    minItems: 4
+    maxItems: 4
+    description:
+      Interrupts that correspond to the 4 IRQ outputs of the controller. Usually
+      only one of the controller outputs will be connected as an usable interrupt
+      source. The remaining interrupts will be left without a valid value, e.g.
+      in an interrupts-extended list the disconnected positions will contain
+      an empty phandle reference <0>.
+
+required:
+  - compatible
+  - reg
+  - '#dma-cells'
+  - dma-channels
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    admac: dma-controller@238200000 {
+      compatible = "apple,t8103-admac", "apple,admac";
+      reg = <0x38200000 0x34000>;
+      dma-channels = <24>;
+      interrupts-extended = <0>,
+                            <&aic AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>,
+                            <0>,
+                            <0>;
+      #dma-cells = <1>;
+    };
-- 
2.33.0

