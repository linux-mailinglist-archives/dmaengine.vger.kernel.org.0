Return-Path: <dmaengine+bounces-1653-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1478917B0
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 12:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB921C229DF
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA9D6A323;
	Fri, 29 Mar 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRe/qpwS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49F1096F;
	Fri, 29 Mar 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711678; cv=none; b=OjuB8V3ijsrhniuTwflHhwQi5AanxI4j481abPK83gtkc+jNxBFBN6IsZ99T08+64C5009Yb2IFJq1nschRqqsVU63gp8LcLTgg6bs+6l4s45aGxzIDP2ValHePSp3r+HLpW1WVleZkeaobnciEDvb0k0S6daE1G9lbx9iiFUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711678; c=relaxed/simple;
	bh=Uu195y/59BqgYGBbl1zGaa7SJ9EwJiXNNKk+wj/zbKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7yCOIzVvBP1oWsoncNQy8xsffYluhKsKmedrLsxctAMIaKq1n6Fj/TsxLyQPkTEbULqDIUaM7e7kqLSzt0i29I+AtuyzDQKqK485n+fJRkcx0Qpr9W26n20Z0W4cvvlGwgZu7aF2WaJQYnaeYtjlfIjVqWIXAweD23w6eMhgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRe/qpwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC556C433F1;
	Fri, 29 Mar 2024 11:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711711678;
	bh=Uu195y/59BqgYGBbl1zGaa7SJ9EwJiXNNKk+wj/zbKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gRe/qpwSDB76WzYRqwV9qqzHXhOH7X7TR+ghD6OrwxLJhhzwmXfWhZmlimy0UMCge
	 N7yB2JnGsjI0Gf9TbmtNiqJLkEGtwqbpYDJPQta7Q6wsme2LTMVNoMa+ISu/eWtPkt
	 rSczs1p3bxRUyQk1AP6USVAlT9So7R0Sfb84FD+sGxP9t5bQqHIyiEoMDQ6PBZ7i+n
	 qTGYWrR8cjasYWwLyozWDha3mgoVr3NVrGPnUvEYOBeMCx+u6zqsReqCEmcU73IHvS
	 4BAJL4PXM9enkxHlcVuO3aUbJQoYfEVz/BoziR8VOwzawH93O3/KOI86yZijUXnyKg
	 pvlgbZ3BpjIpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8935CD11DD;
	Fri, 29 Mar 2024 11:27:57 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Fri, 29 Mar 2024 19:26:57 +0800
Subject: [PATCH v7 1/2] dt-bindings: dma: Add Loongson-1 APB DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-loongson1-dma-v7-1-37db58608de5@gmail.com>
References: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
In-Reply-To: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711711676; l=2565;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=ds4wTZorT6jaeeqOkLe7QSlyOemDGAMPint8d9K/rWA=;
 b=q+CsL+tMdnTSWeaHeNWmgWjCfvAW5THz6sQKOfdzuxpuhjiYucwPLUqSrDi159SZwrcUn4ADD
 7MGf/pWDMpSCGKVMJ2MRcDgy1hP67+ZTIzfg9Bh3a0k/PslY5V5RmTu
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

Add devicetree binding document for Loongson-1 APB DMA.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
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
index 000000000000..449da9fc2de1
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
+    description: Each channel has a dedicated interrupt line.
+    maxItems: 3
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
2.40.1



