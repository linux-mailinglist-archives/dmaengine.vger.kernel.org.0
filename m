Return-Path: <dmaengine+bounces-7644-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B013CCC191E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 09:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF8D1303883D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 08:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB5348445;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szghvzKL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782AE347FED;
	Tue, 16 Dec 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872201; cv=none; b=NxCycUKTBGGPy90TUkHVys2cIqBLn0q2Fm+bBCQe5LyNSXVKmVqsroGmDs8jLJs2QL8/Vd9TBxXmU/iGpUH10r1Tm97ab199LLfneBUoAWeXmOugiIuiCoLk7fd4ZuQFA80AQLRS3icxvo7lgVoEMm+DD8KCwNNEwqP+o8XeM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872201; c=relaxed/simple;
	bh=SWV/NfL3tLtgdR0M1+5VAcbUWkx942kwzpVWDE2itE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TubFHaT6fGsB/pK9F8D4B/Hs/TKbiYjhtuppbw0B6pBvBRc0kCUDtn6WLCfOofs70HCYH24BjmB/6JCFh16Ert29q/oeRjLgcCUTbdfAUmIohqW162Xvrcy5Rd23uL167LR0znhsAQuBCqo6OnW61De9SvumFeY7SUpBVDYJjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szghvzKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED877C19424;
	Tue, 16 Dec 2025 08:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872201;
	bh=SWV/NfL3tLtgdR0M1+5VAcbUWkx942kwzpVWDE2itE0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=szghvzKLsJXowPIL3zohB0bKAioASP/yfFzcC89jI6asBK9WKb9ccFqt8vP017QQ1
	 sbMVNshut3lEw6TZqLnJMyWeHRO3rxZyikVpdo/Qy3e6ukaWO4ce5Ms3CZdTdXd3KV
	 KDbhjZP4wj5lrnChsVq8PXBODHl/d8ntgemBxacHWUq2IJDeFe07KZBMQz/keeAD8Y
	 CZxFKXweZi3Jsmsj8iPQdlC60vdtdm/FkQ8k3oGzYWHlaSnI2q4DVIV/8jK0SGOy0Z
	 xoObIDlyGe9Ct2yIKPrNBaxRWDqhJW6uZXlU+a3x8fO0a9qBJzf5xVxrBZMlLIsaTP
	 hO0w5WFvfLw6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4960D5C0D0;
	Tue, 16 Dec 2025 08:03:20 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 16 Dec 2025 08:03:17 +0000
Subject: [PATCH 1/3] dt-bindings: dma: Add Amlogic general DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251216-amlogic-dma-v1-1-e289e57e96a7@amlogic.com>
References: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
In-Reply-To: <20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765872198; l=2309;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=YtNRhQ7yOxGHI4OflJLoTQNj1t3FJEpqV/TcNs/qfSA=;
 b=XpNQNJ5Pk6DQgEgq8PAeCMnzEndlKbIEJtJ9zf+fGqwPN8DH/boK5LsAvSrASIYm4jjkWFm+d
 sQSF4mpzF76Af5+idnocEoqsSblm27jw0/CW4/tWBOsIciDiUmgfmBQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add documentation describing the Amlogic general DMA.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/dma/amlogic,general-dma.yaml          | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/amlogic,general-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,general-dma.yaml
new file mode 100644
index 000000000000..8b9cec9b8da0
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/amlogic,general-dma.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/amlogic,general-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic general DMA controller
+
+description: |
+  This is a general-purpose peripheral DMA controller. It currently supports
+  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
+  for the same peripheral use two separate channels, controlled by different
+  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
+  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
+  there is no significant difference.
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,general-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: sys
+
+  '#dma-cells':
+    const: 2
+
+  dma-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 64
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#dma-cells'
+  - dma-channels
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        dma-controller@fe400000{
+            compatible = "amlogic,general-dma";
+            reg = <0x0 0xfe400000 0x0 0x4000>;
+            interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&clkc 45>;
+            #dma-cells = <2>;
+            dma-channels = <28>;
+        };
+    };

-- 
2.52.0



