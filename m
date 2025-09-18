Return-Path: <dmaengine+bounces-6648-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48674B86896
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B211C83307
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7E2D9796;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+G1lq5e"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2F2D7DE5;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221398; cv=none; b=csdl7mu3Z3z11j+7mfHfuE1AAImtNfVjhAbudOzk44Ki5W1ml2CiM6ZBv/MalbRd+yzwcmr+05DqOo223RpGJatVrrsQava0B0UZIQ25vQbM2sL5IJTF0fuIYYhDnjJU+wQv+xDDf36UHiSJR+hBLddssLOjMVdW/h5IWNQ7mIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221398; c=relaxed/simple;
	bh=KkndGZ2cFeTM19fVBhPaNoLbiQh6UVaVfyXkJUdBXsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RD5f5Ea8xKqw+giVxfDZ2mZqFNkhwMikdNNW0jc41PZjhVrZqY0Zelj4WHLKasY4b2Z0frO+YfB+OZLaNkwHPc0vtie9S3FLWJENz2VYlAAGCpD/bYdMlRyU6PPxUNMmIgvJ9wrfRdw84STwIwYcCwKhGnb9rIbKdgMs5e57fhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+G1lq5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17B7DC4AF13;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221398;
	bh=KkndGZ2cFeTM19fVBhPaNoLbiQh6UVaVfyXkJUdBXsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q+G1lq5eX76T2uqv5/HptLwuHYisvdH2xVJ/ZCMJJY6xr2aJTQXo9pEOxrZnnjCIS
	 4Jcyw/H5/f1UeJ0rIJ+Isukjgkqa6HA7uhIjZIn3KtTAJk8CS/F4A32JKiKo2NEBSj
	 NjEjRSWTo/j1UwN6t5HQhkjaXOwZtYrFJrO186EFXZ8UeYsCKYC52J9VGlbkrnLrM9
	 R1myopw6va0UYQlS1Aiiun+qE8l3JmQ3vz41yX+kjaWgjBbtd+/4ZCXsMNCfBYdtCh
	 nG5Y1pYE8wXAmoaASW2Xp+nMDEYtmrAMLaXpt9fjKXmapvLMRRqfWQhXKAMTWv9FHN
	 T7PiVg/UCQfWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F57CCAC59A;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Fri, 19 Sep 2025 01:48:44 +0700
Subject: [PATCH 04/10] dt-bindings: mmc: Add RDA SDMMC controller
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-rda8810pl-mmc-v1-4-d4f08a05ba4d@mainlining.org>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758221395; l=2667;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=AsSx2jfyiIl9tD1PzUkU8B/80/dNLISAbs6T475/JWo=;
 b=m1jZ5iiJdDLR2oNGhbZc1KvGaZ/RhK/lM0bAsauM7cx684WiuGLwZlK4HFh7moDg6YJ4FQU+R
 ttMceldPwaYBD+EGfHCFOX0uBSgU42qv2H8yNPUABQPx0Skg+RH4jnz
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Add documentation describing the SD/MMC controller in RDA Micro
RDA8810PL SoC.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 Documentation/devicetree/bindings/mmc/rda,mmc.yaml | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rda,mmc.yaml b/Documentation/devicetree/bindings/mmc/rda,mmc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f3cda38abd66023ca9bc94d1c29df5ae9e211e7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/rda,mmc.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/rda,mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro SD/MMC Controller
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+maintainers:
+  - Dang Huynh <dang.huynh@mainlining.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - rda,8810pl-mmc
+      - const: rda,mmc
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
+    const: mclk
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  rda,mclk-adj:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Some board need MCLK output to be delayed for the card to work.
+      If not present, MCLK output is not delayed.
+    minimum: 0
+    maximum: 255
+
+  rda,mclk-inv:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Some board need MCLK to be inverted for the card to work.
+      If not present, MCLK is not inverted.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - dmas
+  - dma-names
+  - vmmc-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/rda,8810pl-apclk.h>
+    #include <dt-bindings/dma/rda-ifc.h>
+    mmc@20950000 {
+      compatible = "rda,8810pl-mmc", "rda,mmc";
+      reg = <0x20950000 0x1000>;
+      interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&ap_syscon CLK_APB2>;
+      clock-names = "mclk";
+      resets = <&ap_syscon RST_APB2_SDMMC1>;
+      dmas = <&ifc IFC_SDMMC1_TX>, <&ifc IFC_SDMMC1_RX>;
+      dma-names = "tx", "rx";
+      vmmc-supply = <&vdd_sdmmc>;
+      rda,mclk-adj = /bits/ 8 <1>;
+      rda,mclk-inv;
+    };
+
+...

-- 
2.51.0



