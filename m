Return-Path: <dmaengine+bounces-2306-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5566B90031D
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B72B22D19
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4168190686;
	Fri,  7 Jun 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEDcDPHc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA919066C;
	Fri,  7 Jun 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762388; cv=none; b=sscp2sMhGh9mNJKUt6C480Nc+o1RbF3EIBUCQ93D+n1pCvUF58LFrKgF7EOHQibhJdAN7HI3ZpX8BqypaEuv5+ADZ2f/xURj8wRFRpA7kST/TuW9O372pbS8zN2MTug3HYBk5bFhyp6IpTTT+Zq02vW+yMMGqrIs9ESDw+ujvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762388; c=relaxed/simple;
	bh=wVAKBmbrYCvt2d2EYAP000JHBn2/GjHrNPCB6alfcUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpqd6ADb6/kA30Bfd+64I4VckIqXylMN2vh4kDQbq1OuFK6dxXdqvvY5sPv2w36G5n8GoSps/PP+Lchgmr5wtwD0iyCM3aprbU6TrZiUqzVTCtk9T5gcFwiVLwG3l9UY/P8oMUi/GtwqmEbl3AB2f0iTwre1fDp8wt3yLQirg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEDcDPHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F9F5C32786;
	Fri,  7 Jun 2024 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717762388;
	bh=wVAKBmbrYCvt2d2EYAP000JHBn2/GjHrNPCB6alfcUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hEDcDPHcSMnmmcdb4gvbCqnoSumjL77+uY1acSew1LMXtzQXxRL8r/Cl+CX6Gebbm
	 UCl8j4NgjKGpLnDrD9G/KrJ2EVFuily54OBcyY6wHX2hbuQwE2TaOfH4uoP7VmPITg
	 /fXtBWtoW7xcYmZx6Z+wkGC8Qq+GRyPtwiWUHUKyQ5qyjyNIYw9muhTSl3VMCxpb3Z
	 QuaoZdgAme0i10d93oLaGxRi6+fBQxGjOcpZWh8z7JytVqqBjl5fjFFWq9UuvD50NO
	 FEUNouuRygu1vPb3MES5YuBW9c6YCOIk/CKV5oTyfMPeEj/5v1REBH0Jwo/3IPm9jN
	 RKPX8sFtYIz9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B408C27C53;
	Fri,  7 Jun 2024 12:13:08 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 07 Jun 2024 20:12:23 +0800
Subject: [PATCH v8 1/2] dt-bindings: dma: Add Loongson-1 APB DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-loongson1-dma-v8-1-f9992d257250@gmail.com>
References: <20240607-loongson1-dma-v8-0-f9992d257250@gmail.com>
In-Reply-To: <20240607-loongson1-dma-v8-0-f9992d257250@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717762386; l=2804;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=GCRKEsFB+WWe319UoKSD9gj5YrbqFa+5zSpsMcm+1K8=;
 b=f2WDNM4CxH67u6sFtH50acPTPWJtvofNulPd6gB3bzk+Dt+XQiizlVYW7S0x8Nspvu1Np90au
 a5SO+JRbnvNBwspolN9y7MhxNvQ1PUc/ssmM5VrpRA77olMpiroD6Tc
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



