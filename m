Return-Path: <dmaengine+bounces-1394-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AFD87D9F5
	for <lists+dmaengine@lfdr.de>; Sat, 16 Mar 2024 12:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6CDB2137F
	for <lists+dmaengine@lfdr.de>; Sat, 16 Mar 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C08217993;
	Sat, 16 Mar 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9s8jeD1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7F1429B;
	Sat, 16 Mar 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710588852; cv=none; b=UjXcMar63eXKDwryhe9htwVFZCLQLjCCL7Vt3WVXIUKKtor9msqNDXCpGLwVa+Z3TK5zzvS0REGdBMOrRt9/ABvS1JlX6kaNE8zsps8frsS1OMV2QblYRgVAViv089DNU1PJrTE+X5KiDN+V2aQGEF8QuT7tFO+ygXWN7CEM59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710588852; c=relaxed/simple;
	bh=K9Bfz33mqZSL+LnFPLofVRuX+BnBX7o3BY7bNa6bqYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omBgPMiVO9i8WWroDIcDu+7+01MLPu4gbZtR7LU3dRmUbS65JQlV0qdrme1Iy1oMKjd5XFNvBY9eRwYnWXCtc2ZIqZx+uJR1k5RYUa5tfN4tFbUoaK83AazqLoGYbB/KZVNrzIy5V+1K9UCQ9MisuxIuqN2IE7dIJQBI6ltto24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9s8jeD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBF46C43394;
	Sat, 16 Mar 2024 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710588851;
	bh=K9Bfz33mqZSL+LnFPLofVRuX+BnBX7o3BY7bNa6bqYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n9s8jeD1U2Koja0dUd8IcDaKTKV0Ax/i49PX6NlDTyWTks6vOuI1FVnxplqm2ODG5
	 z4lnDsJwRrOB0kRXkV5xdgwH3/fgS0qdostdOPaHVj0vdadOQBkDDYY/hPKUpSGTUc
	 4BypBhKpO+VRwYQR8+oNW2mL+JY7iqjwZbCqH7WtikjUY8CFVc6G2cQdl182Oz37ed
	 /+ZF4qJyUr4YzE5mSGx6/3tMHCP1IS7jDJM3X6Fwww8rxRJd0ySmDwl8RrI1qatZKO
	 sTsDpDYqWmf9FbbbtyE/nzRZmflTc0iltuZHd+i8RU+bxVjchWXBsyI/SOb3W64Mxy
	 bINq6miwBWW9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE7C54E60;
	Sat, 16 Mar 2024 11:34:11 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Sat, 16 Mar 2024 19:33:53 +0800
Subject: [PATCH v6 1/2] dt-bindings: dma: Add Loongson-1 DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-loongson1-dma-v6-1-90de2c3cc928@gmail.com>
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
In-Reply-To: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710588849; l=2188;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=zE5CW4nW1JlxiVUlqwg3Ou+NzTgOjpf36TPsPJRMfcc=;
 b=6IHnL5oJofud1sZyiuybqQC/60Ow/y2P3LA6puHgIMw1fu2XcfQm9jX28FIMNmWzIjpRuQ6Xa
 Y4b9qZglbJkAQoK/4sQca6gkTSLSVZ7XIHHyHCvZeOoll6xTbEPODgL
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received:
 by B4 Relay for keguang.zhang@gmail.com/20231129 with auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: <keguang.zhang@gmail.com>

From: Keguang Zhang <keguang.zhang@gmail.com>

Add devicetree binding document for Loongson-1 DMA.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V5 -> V6:
   Change the compatible to the fallback
   Some minor fixes
V4 -> V5:
   A newly added patch
---
 .../devicetree/bindings/dma/loongson,ls1x-dma.yaml | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
new file mode 100644
index 000000000000..06358df725c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 DMA Controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+description:
+  Loongson-1 DMA controller provides 3 independent channels for
+  peripherals such as NAND and AC97.
+
+properties:
+  compatible:
+    oneOf:
+      - const: loongson,ls1b-dma
+      - items:
+          - enum:
+              - loongson,ls1c-dma
+          - const: loongson,ls1b-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Each channel has a dedicated interrupt line.
+    minItems: 1
+    maxItems: 3
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - pattern: ch0
+      - pattern: ch1
+      - pattern: ch2
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
+        compatible = "loongson,ls1b-dma";
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


