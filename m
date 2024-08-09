Return-Path: <dmaengine+bounces-2827-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B79994CEA2
	for <lists+dmaengine@lfdr.de>; Fri,  9 Aug 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC6282CD5
	for <lists+dmaengine@lfdr.de>; Fri,  9 Aug 2024 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791F1922D9;
	Fri,  9 Aug 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0JoxsnN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E0166F14;
	Fri,  9 Aug 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199498; cv=none; b=F0GyyqvFpHeFbjBVZAAwzC6IWht+ikdpaccKowcjzpZoMnxMvqq7r4XzlnKAJ2ARxWNEM0vvnusesuPKfTq11/wgvI0ulQNvP2+sV6hL68m+iOCUfj9PfAQW9q3gGEhsQeOLhka/FqfuvJ9eJG7OyPfqLXsUT1UMx2EYD+cFDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199498; c=relaxed/simple;
	bh=S7V6DK8sSaH8Ftf5eoWhGnb7BbPhd3ifx1Z0XEEsNDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9g0nvnYOjwgx0pGVf8GzCj9rwokr8JRtrUFsrQwBxQ7ldjSn5Imo4LvEbi1FrMaHWeI3272dhTM294ppq1DCwgQaDKNgH6vpVIreLTimHI4vaZaSC+qs5LdKrV+zbLHdvjzJoUXFbx5lEilbiHCqUdYJDnGZy6zaVqStXSUrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0JoxsnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE82DC4AF0D;
	Fri,  9 Aug 2024 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723199497;
	bh=S7V6DK8sSaH8Ftf5eoWhGnb7BbPhd3ifx1Z0XEEsNDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P0JoxsnN/12XyORyr7qigvUYh3EBpNjgJvxNQfzlZueUXpxL00MTEknrkM5pqtGt1
	 0NX0WByS/JkM6TK/L+jKk3vaIob3TD8OO+oTMG71F9AgShiMxoalLyvTeGStRTt1P5
	 bZ895CUpKC1yNFTaddM+2qRa2ihbA1fR6FYqRnhoYrvJxDVMXqgZ07CMIZQ95Fqc64
	 OovoNIpjUjG/3ETv0eWGAKuyTP4lujpfaENB6QUJwWqu+uF+tbaKBOee4RrcIBFO5y
	 I9V0mSzcU/KOy+oKB4/mzzYhr3lhkaCiEctPyL13cOpYP/mqWZB0IXdsjp4qb/iWOV
	 PRayuRAVRhhyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B10C52D7C;
	Fri,  9 Aug 2024 10:31:37 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 09 Aug 2024 18:30:58 +0800
Subject: [PATCH v12 1/2] dt-bindings: dma: Add Loongson-1 APB DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-loongson1-dma-v12-1-d9469a4a6b85@gmail.com>
References: <20240809-loongson1-dma-v12-0-d9469a4a6b85@gmail.com>
In-Reply-To: <20240809-loongson1-dma-v12-0-d9469a4a6b85@gmail.com>
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723199495; l=2956;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=Qluc1iegek8oFl5BI6efzejkT7cwfkm/k1sNIM1vwVk=;
 b=j0LpAHtEhGJvjoDOlIzz0H2cWoMIncGIDOFguiLYp13a2aIaAFisy2/j/+I9KjPcSIQEF08eW
 P+dfNKRODgGCPrZfHTAUQrsnIJGBXojT24l9Kxd8EMhfzH2KQ7GOaVZ
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
Changes in v12:
- Delete superfluous blank lines in the examples section.

Changes in v11:
- None

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
 .../bindings/dma/loongson,ls1b-apbdma.yaml         | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.yaml
new file mode 100644
index 000000000000..4c7d2fb7b292
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.yaml
@@ -0,0 +1,65 @@
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
+        interrupt-parent = <&intc0>;
+        interrupts = <13 IRQ_TYPE_EDGE_RISING>,
+                     <14 IRQ_TYPE_EDGE_RISING>,
+                     <15 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "ch0", "ch1", "ch2";
+        #dma-cells = <1>;
+    };

-- 
2.43.0



