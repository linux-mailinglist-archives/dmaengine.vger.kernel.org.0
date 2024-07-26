Return-Path: <dmaengine+bounces-2746-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1040693D3B5
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 15:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC51C21E54
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2024 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D6617BB0B;
	Fri, 26 Jul 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTllicQs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001D17B511;
	Fri, 26 Jul 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999252; cv=none; b=cpg8U/05rNbX6Fqp9H7UxwpmgPI05F27g4P2Wf6OQLIrxEhuZ7YgIOG0k8VMCHJ+cNZaQtPxBmWjHj0nYtIUrtnaphsgvFuXVN8P+ATlgBIExx8s5OL9iIGASqFpFqH/zd8J8LoQXhUkD+RkRjsMmGcKIaxw/WAanGwmMsG0HmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999252; c=relaxed/simple;
	bh=u1m7gZkZ1yjoWoSMDdRGk7cBsTW8fNNZ2DIvAqgBKSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3TO9hkIruNCn9jK9psO9uPtiD9mgCcShaGYL2d22EzBV0ZAuq64v8zm+e2fHuam+qDu7fBvHWIwD/d97MvY0kg2hG9gi0rfUIfhr70uSvO1kGTNyAR5b4nFFlsiXE9B6LeA202LHcpQYU7sUbm4m2kj+2AVSRtyCzb0smFB9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTllicQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D0A9C4AF07;
	Fri, 26 Jul 2024 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721999252;
	bh=u1m7gZkZ1yjoWoSMDdRGk7cBsTW8fNNZ2DIvAqgBKSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XTllicQsaIYCkCR2gZeIKflDU5ln7xRJ9mhpefR0DAzfqPkIRs6HDpjbPFI7Vq+RW
	 87Nt9zFExeZEo7HgA9qsVKe0dKYxsxwDNtEGmVpPJy7qF7sSPtn1IoEZRldU7TuOkj
	 CphOkwZboiq9/KBOnp8SMnCLnOgeDE5ncLBOkR3BqbVVdP1ketroBYyzbS1R3udnez
	 tb2V3V0Ww9WtKceQCxSswqVeJ+vBRYOH4wVM4LnU74VObWjLdsjBs0gYWZZsy1WPPs
	 uYSh35+p/bUZYAqpZDUlgN7JJtoAcgBcP/ve64gR7RRn5rnCUVOFK8ZKTJ60ogtZA3
	 2HpWHVmXG8ipg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED541C3DA7F;
	Fri, 26 Jul 2024 13:07:31 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 26 Jul 2024 21:06:49 +0800
Subject: [PATCH v10 1/2] dt-bindings: dma: Add Loongson-1 APB DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-loongson1-dma-v10-1-31bf095a6fa6@gmail.com>
References: <20240726-loongson1-dma-v10-0-31bf095a6fa6@gmail.com>
In-Reply-To: <20240726-loongson1-dma-v10-0-31bf095a6fa6@gmail.com>
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721999250; l=2857;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=R8rn22f2AyWKsMzsGCrIEUV/dVtejeQpZG1kFfGOao0=;
 b=YrISyxilxDZEO0l5vFCheESMU0/GrcCgaOwim4azDaeVTa/9D6nacBcw3r0qdZKR06LSBvn/u
 k6PD2GwnypOCJw3plZrBAOr00uqVBlKxZEyfFdB9MHrMzG+PEeDZCj5
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
Changes in v10:
- None

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



