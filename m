Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2B7509E4
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjGLNpt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 09:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjGLNpr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 09:45:47 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 06:45:45 PDT
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A30E4D;
        Wed, 12 Jul 2023 06:45:44 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1689169090; bh=MDjcxHwKAkbnDFoF09JZJJNakVmauHwYvdirrNru67w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p9nRWNe6U3z4u4E7mhqhHdUKp1QoeKp/H+AS8GMT+veGNsNnW2hKALhOshGs/IDlt
         LojJLgNYLMmfV0cr8zn2DA896TJxwh8MbNixIz6+4gc/BL2gQl5yEh3WinY6wCuS+W
         T1pL3F3VbalquQDQWYhiZXRaLXjUQPEhVaGP/L+E=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     asahi@lists.linux.dev, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: dma: apple,sio: Add schema
Date:   Wed, 12 Jul 2023 15:38:05 +0200
Message-Id: <20230712133806.4450-2-povik+lin@cutebit.org>
In-Reply-To: <20230712133806.4450-1-povik+lin@cutebit.org>
References: <20230712133806.4450-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_FAIL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Describe the SIO coprocessor which serves as pretend DMA controller on
recent Apple platforms.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 .../devicetree/bindings/dma/apple,sio.yaml    | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,sio.yaml

diff --git a/Documentation/devicetree/bindings/dma/apple,sio.yaml b/Documentation/devicetree/bindings/dma/apple,sio.yaml
new file mode 100644
index 000000000000..0e3780ad9dd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/apple,sio.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/apple,sio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SIO Coprocessor
+
+description:
+  SIO is a coprocessor on Apple M1 and later chips (and maybe also on earlier
+  chips). Its role is to offload SPI, UART and DisplayPort audio transfers,
+  being a pretend DMA controller.
+
+maintainers:
+  - Martin Povišer <povik+lin@cutebit.org>
+
+allOf:
+  - $ref: dma-controller.yaml#
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
+    minItems: 2
+    maxItems: 8
+    description:
+      A number of references to reserved memory regions among which are the DATA/TEXT
+      sections of coprocessor executable firmware and also auxiliary firmware data
+      describing the available DMA-enabled peripherals
+
+  apple,sio-firmware-params:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Parameters in the form of opaque key/value pairs that are to be sent to the SIO
+      coprocesssor once it boots. These parameters can point into the reserved memory
+      regions (in device address space).
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
+    sio: dma-controller@36400000 {
+      compatible = "apple,t8103-sio", "apple,sio";
+      reg = <0x36400000 0x8000>;
+      dma-channels = <128>;
+      #dma-cells = <1>;
+      mboxes = <&sio_mbox>;
+      iommus = <&sio_dart 0>;
+      power-domains = <&ps_sio_cpu>;
+      memory-region = <&sio_text>, <&sio_data>,
+                      <&sio_auxdata1>, <&sio_auxdata2>; /* Filled by loader */
+      apple,sio-firmware-params = <0xb 0x10>, <0xc 0x1b80>, <0xf 0x14>,
+                                  <0x10 0x1e000>, <0x30d 0x34>, <0x30e 0x4000>,
+                                  <0x1a 0x38>, <0x1b 0x50>; /* Filled by loader */
+    };
-- 
2.38.3

