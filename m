Return-Path: <dmaengine+bounces-2675-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6674992E536
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2786B22703
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644CF158DD4;
	Thu, 11 Jul 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga4n2OZD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29194156F5D;
	Thu, 11 Jul 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695355; cv=none; b=tvsUEnDf4gXpzdI86u1eG170JcR1UkAWg31Wa9ekcnfLLIsAKMZHyoI7cxnt3sxzLslyw5NtPv0FytlhZXGJaF8q0BaGSXH88ovRKEtQ1ZiCMx+VQDBKTYq4/oLqsyfX6qt4/4zuZ07hPAKjUTwWpqICpM5qzxA07jVZigqOu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695355; c=relaxed/simple;
	bh=DE+FVo77unx9XVdvimGFNJZwqU+7Z3SMhyWIyT6Piz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvgER+pmmL03ee/HHJlrPJ2odJKPdI3iK6ukT+KuKfZMet4uhB4C1GiVNSHsgDbJZu/x8jjKlyIx83MoLPFllfThqKcI6r+IibAlhaiEfeJMDX0bZJRcmilkkhZV9eL+A5irCn+PemMdu2KZbzKIRPZzOjduIKxPE222m3DCqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga4n2OZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B554BC4AF07;
	Thu, 11 Jul 2024 10:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720695354;
	bh=DE+FVo77unx9XVdvimGFNJZwqU+7Z3SMhyWIyT6Piz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ga4n2OZDJKaEvJj08Hcgy3eue0lU2iHxO7R789FzIix9BbdSxi0ipdImINKfNgsXq
	 afb+p9kOd5fERwhT1zyN8Q4Q1zbZDU44c04q4Nx9Lb8RBx/gNnssNjkGkQ7aWxDbaH
	 31P9srxn0NPMI1AcI8gRgUxaZTXYKGvYMnzUwFlh+KJF2py+I86OIEppne70uK8Ri1
	 /pdya1hDIyhsyAwj+DmN/Jg+zx/p900k5Ijpv9ow2rzmaU9c3zpzpGGCKcjnHDU4WH
	 7v0t2D558Od1NHnyOVPLS3VJc+gjaTZle6WR9EWSKJ6VVAaGynCfV6yJF9fqOY9PfF
	 fqSoKpAtHzabg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9628BC3DA4A;
	Thu, 11 Jul 2024 10:55:54 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Thu, 11 Jul 2024 18:55:37 +0800
Subject: [PATCH RESEND v9 1/2] dt-bindings: dma: Add Loongson-1 APB DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-loongson1-dma-v9-1-5ce8b5e85a56@gmail.com>
References: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
In-Reply-To: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720695351; l=2830;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=VMRWdh/PCclHrwoAYaQVWsjCcphB3QpZQvLeWMebljU=;
 b=4EDEp8WcZcafME11O8Ch4XkaZIGy1/jNWpkY6EVjozNuxrmzqrJe/+2GdHKLyl7NJdJCBReh7
 m0ImZrvgB+lBre1BsmRVH7QxUJor3XQquFiMarX+0DqB/GYlj5dpbc9
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

Add devicetree binding document for Loongson-1 APB DMA.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v9:
- None

Changes in v8:
- Change 'interrupts' property to an items list

Changes in v7:
- Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai Chen)
- Update the title and description part accordingly
- Rename the file to loongson,ls1b-apbdma.yaml
- Add a compatible string for LS1A
- Delete minItems of 'interrupts'
- Change patterns of 'interrupt-names' to const

Changes in v6:
- Change the compatible to the fallback
- Some minor fixes

Changes in v5:
- A newly added patch
---
 .../bindings/dma/loongson,ls1b-apbdma.yaml         | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.yaml
new file mode 100644
index 000000000000..192c85c1199d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/loongson,ls1b-apbdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 APB DMA Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description:
+  Loongson-1 APB DMA controller provides 3 independent channels for
+  peripherals such as NAND, audio playback and capture.
+
+properties:
+  compatible:
+    oneOf:
+      - const: loongson,ls1b-apbdma
+      - items:
+          - enum:
+              - loongson,ls1a-apbdma
+              - loongson,ls1c-apbdma
+          - const: loongson,ls1b-apbdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: NAND interrupt
+      - description: Audio playback interrupt
+      - description: Audio capture interrupt
+
+  interrupt-names:
+    items:
+      - const: ch0
+      - const: ch1
+      - const: ch2
+
+  '#dma-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - '#dma-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    dma-controller@1fd01160 {
+        compatible = "loongson,ls1b-apbdma";
+        reg = <0x1fd01160 0x4>;
+
+        interrupt-parent = <&intc0>;
+        interrupts = <13 IRQ_TYPE_EDGE_RISING>,
+                     <14 IRQ_TYPE_EDGE_RISING>,
+                     <15 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "ch0", "ch1", "ch2";
+
+        #dma-cells = <1>;
+    };

-- 
2.43.0



