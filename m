Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1E727556
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jun 2023 04:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjFHCzv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Jun 2023 22:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjFHCzu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Jun 2023 22:55:50 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D634B1FF7;
        Wed,  7 Jun 2023 19:55:46 -0700 (PDT)
Received: from loongson.cn (unknown [223.106.25.146])
        by gateway (Coremail) with SMTP id _____8DxyOkxQ4FkrFoAAA--.1277S3;
        Thu, 08 Jun 2023 10:55:45 +0800 (CST)
Received: from localhost.localdomain (unknown [223.106.25.146])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTMouQ4FkIFQGAA--.12049S3;
        Thu, 08 Jun 2023 10:55:44 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND v2 1/2] dt-bindings: dmaengine: Add Loongson LS2X APB DMA controller
Date:   Thu,  8 Jun 2023 10:55:30 +0800
Message-Id: <bb2d5985a3d9fd8e7ccbe2794842d93a8978d8a6.1686192243.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1686192243.git.zhoubinbin@loongson.cn>
References: <cover.1686192243.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTMouQ4FkIFQGAA--.12049S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4DtrWfJFW5uw4fGry8JFc_yoW8ZF13pF
        nxCasrKrW0qF13A395JFy8Aw1avr93AanrXa9rJw17K3yDWan0vw4akw10vay3Cr42qFyU
        ZFZag3yjga4xJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUj8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_GFv_Wryle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgxwIDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add Loongson LS2X APB DMA controller binding with DT schema
format using json-schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/dma/loongson,ls2x-apbdma.yaml    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
new file mode 100644
index 000000000000..8e5643186310
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/loongson,ls2x-apbdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson LS2X APB DMA controller
+
+description:
+  The Loongson LS2X APB DMA controller is used for transferring data
+  between system memory and the peripherals on the APB bus.
+
+maintainers:
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: loongson,ls2k1000-apbdma
+      - items:
+          - const: loongson,ls2k0500-apbdma
+          - const: loongson,ls2k1000-apbdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+  dma-channels:
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - dma-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    dma-controller@1fe00c00 {
+        compatible = "loongson,ls2k1000-apbdma";
+        reg = <0x1fe00c00 0x8>;
+        interrupt-parent = <&liointc1>;
+        interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+        dma-channels = <1>;
+    };
+
+...
-- 
2.39.3

