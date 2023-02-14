Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCC6966AD
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjBNOZd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 09:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjBNOZc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 09:25:32 -0500
X-Greylist: delayed 516 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Feb 2023 06:25:09 PST
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14B2D5D;
        Tue, 14 Feb 2023 06:25:09 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1676383887; bh=5pAp3t0l3VlIhW4fUc+cLwXz2Tja64FRhpQyrgaKAyc=;
        h=From:To:Cc:Subject:Date;
        b=Z45+z/7boRVyipsWi/aaqFYx7TCrRxwZ9LEzVxh6q/io2rpOmW9UStpQMARQ8U88t
         Y6xiI20/yw3O9IwrzCha413PDbHMKyFesmOSwpaE3zPVEM3REOzmYMn2xQBPglgK0l
         jdFcxo3z8m8LGLFXd4DHMDLAf/92uCc5E6sWNCYk=
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [RFC PATCH] dt-bindings: dma: apple,sio: Add schema
Date:   Tue, 14 Feb 2023 15:10:53 +0100
Message-Id: <20230214141053.92731-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Describe the SIO coprocessor which serves as pretend DMA controller on
recent Apple platforms.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---

Since the schema mentions a loader preparing the binding appropriately,
here's a PR with the relevant (WIP) loader code, if anyone wants to look:
https://github.com/AsahiLinux/m1n1/pull/286

 .../devicetree/bindings/dma/apple,sio.yaml    | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,sio.yaml

diff --git a/Documentation/devicetree/bindings/dma/apple,sio.yaml b/Documentation/devicetree/bindings/dma/apple,sio.yaml
new file mode 100644
index 000000000000..a76cc8265e76
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/apple,sio.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/apple,sio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SIO Coprocessor
+
+description: |
+  SIO is a coprocessor on Apple M1 and later chips (and maybe also on earlier
+  chips). Its role is to offload SPI, UART and DisplayPort audio transfers,
+  being a pretend DMA controller.
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
+          - apple,t6000-sio
+          - apple,t8103-sio
+      - const: apple,sio
+
+  reg:
+    maxItems: 1
+
+  '#dma-cells':
+    const: 1
+    description:
+      DMA clients specify a single cell that corresponds to the RTKit endpoint
+      number used for arranging the transfers in question
+
+  dma-channels:
+    maximum: 128
+
+  mboxes:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  memory-region:
+    description:
+      A number of references to reserved memory regions among which are the DATA/TEXT
+      sections of coprocessor executable firmware and also auxiliary firmware data
+      describing the available DMA-enabled peripherals
+
+  apple,sio-firmware-params:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Parameters in the form of opaque key/value pairs that are to be sent to the SIO
+      coprocesssor once it boots. These parameters can refer to the reserved memory
+      regions described in 'memory-region'.
+
+      Note that unlike Apple's firmware, we treat the parameters, and the data they
+      refer to, as opaque. Apple embed short data blobs into their SIO devicetree node
+      that describe the DMA-enabled peripherals (presumably with defined semantics).
+      Their driver processes those blobs and sets up data structure in mapped device
+      memory, then references this memory in the parameters sent to the SIO. At the
+      level of description we are opting for in this binding, we assume the job of
+      constructing those data structures has been done in advance, leaving behind an
+      opaque list of key/value parameter pairs to be sent by a prospective driver.
+
+      This approach is chosen for two reasons:
+
+       - It means we don't need to try to understand the semantics of Apple's blobs
+         as long as we know the transformation we need to do from Apple's devicetree
+         data to SIO data (which can be shoved away into a loader). It also means the
+         semantics of Apple's blobs (or of something to replace them) need not be part
+         of the binding and be kept up with Apple's firmware changes in the future.
+
+       - It leaves less work for the driver attaching on this binding. Instead the work
+         is done upfront in the loader which can be better suited for keeping up with
+         Apple's firmware changes.
+
+required:
+  - compatible
+  - reg
+  - '#dma-cells'
+  - dma-channels
+  - mboxes
+  - iommus
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    aic: interrupt-controller {
+      interrupt-controller;
+      #interrupt-cells = <3>;
+    };
+
+    sio_mbox: mbox@36408000 {
+      compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox-v4";
+      reg = <0x36408000 0x4000>;
+      interrupt-parent = <&aic>;
+      interrupts = <AIC_IRQ 640 IRQ_TYPE_LEVEL_HIGH>,
+                   <AIC_IRQ 641 IRQ_TYPE_LEVEL_HIGH>,
+                   <AIC_IRQ 642 IRQ_TYPE_LEVEL_HIGH>,
+                   <AIC_IRQ 643 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "send-empty", "send-not-empty",
+                        "recv-empty", "recv-not-empty";
+      #mbox-cells = <0>;
+      power-domains = <&ps_sio>;
+    };
+
+    sio: dma-controller@36400000 {
+      status = "disabled"; /* To be filled by loader */
+      compatible = "apple,t8103-sio", "apple,sio";
+      reg = <0x36400000 0x8000>;
+      dma-channels = <128>;
+      #dma-cells = <1>;
+      mboxes = <&sio_mbox>;
+      iommus = <&sio_dart 0>;
+      power-domains = <&ps_sio_cpu>;
+      memory-region = <0x0>; /* To be filled by loader */
+      apple,sio-firmware-params = <0x0>; /* To be filled by loader */
+    };
-- 
2.33.0
