Return-Path: <dmaengine+bounces-3096-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CA797116B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3312834ED
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C411B1D5F;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv/GC30K"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA991B150D;
	Mon,  9 Sep 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869536; cv=none; b=LH3TGjlKcWV0ryLDBGrxH3wwYYe/N4FaNqLHBoIO4mTH0Lo/T3SCh98QIiEiaDZyZgJqmkfO5iXNgc4OVmVLGz416i+FIttC9TGxNSLO90NO6cRlzcTfIuJQJf7j3eiwhd9532apHb11UqywruoOQPvkC4Os0dW1dsTR4BXg2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869536; c=relaxed/simple;
	bh=OwXslceZMSHlNCp9gnYCsH+AlosVcBVrdxvtTOSfLHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSqmJmRTPP47/yxLZscIniubsqziwx41wbE7BFyAehsZDw7Wh4DTY35SXGIW328dFJzghXy6lz8t/4B/Wn7xlLuXZEe5h7lUiXx6RgnRaTdhVm/bUpaY838oT0HDXenVb5URKf5RPi4quw/yHU4VEA8zpL5X4kAEjyO+dFEk8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv/GC30K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B76B8C4CEDB;
	Mon,  9 Sep 2024 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725869535;
	bh=OwXslceZMSHlNCp9gnYCsH+AlosVcBVrdxvtTOSfLHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mv/GC30KsMPjYlNvrIwovUPues6eetqWuHXKHjmfFvLzdywuUFnQZv/FD1uLr1HAG
	 enYA3+6AqOyDKeDigTMUCFXrBSzwXCfUyGmITqhkBn4Ycby4PdCzD2YPqB/1CDe72S
	 aDDT35q3VhunlGWoCOiqsfoFU81pglYXDJ/t6PD8PMbQSqfDjXErnWV6nKvYe/ChQz
	 jVEwTmum2LAUHJjt4DgYjHi30YKSD2K1DM04blWRy18ETFHKdeNOJaroyWgQhlzde5
	 WladIiGbCXq8SEthJu/jq6nmnawQYcX71689DTj9sGkcNGfs6a3H97q3EEoNeYZg0H
	 l7DKheC5eZJkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFD1CD4F4C;
	Mon,  9 Sep 2024 08:12:15 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 09 Sep 2024 11:10:33 +0300
Subject: [PATCH v12 08/38] dt-bindings: dma: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-ep93xx-v12-8-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
In-Reply-To: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725869532; l=7696;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=Y0DItFCDipfwR6StRBre7127VedaUlKJubOzvlu96UM=;
 b=GAnN0CDd+SmDOF7VfOSvQsINkSFNHn0Yz4hs0kPe43GE60ULUx3YEsgZGTu3cGZza2xZMm9mxEqm
 HvtbKhu0B+JZfz0G2Q6zOQ6UF+HiZRYD38h0bprWfpw4V1o38m0R
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC DMA.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/dma/cirrus,ep9301-dma-m2m.yaml        |  84 ++++++++++++
 .../bindings/dma/cirrus,ep9301-dma-m2p.yaml        | 144 +++++++++++++++++++++
 2 files changed, 228 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml
new file mode 100644
index 000000000000..871b76ddf90f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/cirrus,ep9301-dma-m2m.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic ep93xx SoC DMA controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-dma-m2m
+      - items:
+          - enum:
+              - cirrus,ep9302-dma-m2m
+              - cirrus,ep9307-dma-m2m
+              - cirrus,ep9312-dma-m2m
+              - cirrus,ep9315-dma-m2m
+          - const: cirrus,ep9301-dma-m2m
+
+  reg:
+    items:
+      - description: m2m0 channel registers
+      - description: m2m1 channel registers
+
+  clocks:
+    items:
+      - description: m2m0 channel gate clock
+      - description: m2m1 channel gate clock
+
+  clock-names:
+    items:
+      - const: m2m0
+      - const: m2m1
+
+  interrupts:
+    items:
+      - description: m2m0 channel interrupt
+      - description: m2m1 channel interrupt
+
+  '#dma-cells':
+    const: 2
+    description: |
+      The first cell is the unique device channel number as indicated by this
+      table for ep93xx:
+
+      10: SPI controller
+      11: IDE controller
+
+      The second cell is the DMA direction line number:
+
+      1: Memory to device
+      2: Device to memory
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
+    dma-controller@80000100 {
+        compatible = "cirrus,ep9301-dma-m2m";
+        reg = <0x80000100 0x0040>,
+              <0x80000140 0x0040>;
+        clocks = <&syscon EP93XX_CLK_M2M0>,
+                 <&syscon EP93XX_CLK_M2M1>;
+        clock-names = "m2m0", "m2m1";
+        interrupt-parent = <&vic0>;
+        interrupts = <17>, <18>;
+        #dma-cells = <2>;
+    };
diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml
new file mode 100644
index 000000000000..d14c31553543
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2p.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/cirrus,ep9301-dma-m2p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic ep93xx SoC M2P DMA controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-dma-m2p
+      - items:
+          - enum:
+              - cirrus,ep9302-dma-m2p
+              - cirrus,ep9307-dma-m2p
+              - cirrus,ep9312-dma-m2p
+              - cirrus,ep9315-dma-m2p
+          - const: cirrus,ep9301-dma-m2p
+
+  reg:
+    items:
+      - description: m2p0 channel registers
+      - description: m2p1 channel registers
+      - description: m2p2 channel registers
+      - description: m2p3 channel registers
+      - description: m2p4 channel registers
+      - description: m2p5 channel registers
+      - description: m2p6 channel registers
+      - description: m2p7 channel registers
+      - description: m2p8 channel registers
+      - description: m2p9 channel registers
+
+  clocks:
+    items:
+      - description: m2p0 channel gate clock
+      - description: m2p1 channel gate clock
+      - description: m2p2 channel gate clock
+      - description: m2p3 channel gate clock
+      - description: m2p4 channel gate clock
+      - description: m2p5 channel gate clock
+      - description: m2p6 channel gate clock
+      - description: m2p7 channel gate clock
+      - description: m2p8 channel gate clock
+      - description: m2p9 channel gate clock
+
+  clock-names:
+    items:
+      - const: m2p0
+      - const: m2p1
+      - const: m2p2
+      - const: m2p3
+      - const: m2p4
+      - const: m2p5
+      - const: m2p6
+      - const: m2p7
+      - const: m2p8
+      - const: m2p9
+
+  interrupts:
+    items:
+      - description: m2p0 channel interrupt
+      - description: m2p1 channel interrupt
+      - description: m2p2 channel interrupt
+      - description: m2p3 channel interrupt
+      - description: m2p4 channel interrupt
+      - description: m2p5 channel interrupt
+      - description: m2p6 channel interrupt
+      - description: m2p7 channel interrupt
+      - description: m2p8 channel interrupt
+      - description: m2p9 channel interrupt
+
+  '#dma-cells':
+    const: 2
+    description: |
+      The first cell is the unique device channel number as indicated by this
+      table for ep93xx:
+
+      0: I2S channel 1
+      1: I2S channel 2 (unused)
+      2: AC97 channel 1 (unused)
+      3: AC97 channel 2 (unused)
+      4: AC97 channel 3 (unused)
+      5: I2S channel 3 (unused)
+      6: UART1 (unused)
+      7: UART2 (unused)
+      8: UART3 (unused)
+      9: IRDA (unused)
+
+      The second cell is the DMA direction line number:
+
+      1: Memory to device
+      2: Device to memory
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
+    dma-controller@80000000 {
+        compatible = "cirrus,ep9301-dma-m2p";
+        reg = <0x80000000 0x0040>,
+              <0x80000040 0x0040>,
+              <0x80000080 0x0040>,
+              <0x800000c0 0x0040>,
+              <0x80000240 0x0040>,
+              <0x80000200 0x0040>,
+              <0x800002c0 0x0040>,
+              <0x80000280 0x0040>,
+              <0x80000340 0x0040>,
+              <0x80000300 0x0040>;
+        clocks = <&syscon EP93XX_CLK_M2P0>,
+                 <&syscon EP93XX_CLK_M2P1>,
+                 <&syscon EP93XX_CLK_M2P2>,
+                 <&syscon EP93XX_CLK_M2P3>,
+                 <&syscon EP93XX_CLK_M2P4>,
+                 <&syscon EP93XX_CLK_M2P5>,
+                 <&syscon EP93XX_CLK_M2P6>,
+                 <&syscon EP93XX_CLK_M2P7>,
+                 <&syscon EP93XX_CLK_M2P8>,
+                 <&syscon EP93XX_CLK_M2P9>;
+        clock-names = "m2p0", "m2p1",
+                      "m2p2", "m2p3",
+                      "m2p4", "m2p5",
+                      "m2p6", "m2p7",
+                      "m2p8", "m2p9";
+        interrupt-parent = <&vic0>;
+        interrupts = <7>, <8>, <9>, <10>, <11>, <12>, <13>, <14>, <15>, <16>;
+        #dma-cells = <2>;
+    };

-- 
2.43.2



