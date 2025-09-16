Return-Path: <dmaengine+bounces-6547-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693AEB5A1EC
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E649321DAC
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1672E1EE4;
	Tue, 16 Sep 2025 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="GAvx5qwG";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UzO03XcR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FCF2DF15A;
	Tue, 16 Sep 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053386; cv=none; b=sESXzhB4wBz9iTg1eeLoko6r/an7UVIYE61LErQ4apZ/hYXcqbLJgUnLQqO9kPvInl60lkTu+YaNwPRFjynAes35U2wKIfYuc891YSdawlHon3RkJ4T702bi61b48m2oVZZ9qp1v921qVJdIRFr99/khrGNgttf1OWV5tal6q/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053386; c=relaxed/simple;
	bh=F0hJeg4vF8n1IM7OJY4KSBkC9cZRnfQ7Ctr7Iv83zwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZU5s9z2JxuRtJZBbIfd+4HwlY1BqjEwjrppxf1OSNC+wi3F04sPAWxe9PC1cVpyqDO+7KZBSrvQcD3OqeVe0uV4o38MiZ8jPRB384obZMup5PuYoPzPMB2LZLvjy37E06YwapKT5c9gDajwNHEXqaUZdbTLzQ2fMcKQUOX7F+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=GAvx5qwG; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=UzO03XcR; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053336; bh=WlrpMszuag375++3au3AQMu
	mLE/Z1ZoZmJDjJqd8ieY=; b=GAvx5qwGFbxhNRkxwhc5JSYB1VRIMjT5ITBEWXUjVNyQ0BNZ7n
	sPJRK49nsYSihF6htA0vNokgdRIR+nQd0zL96pFlmWIrCntfk8gd5ENYJKXzz0hxoB2VikAnAhM
	pZFG08Xt/Aw1XeI2Ygsr5tq4QthZmwtGBBU3En3e3ezDluZx5QW73yYfSUWU3hpBrQDL9fBKirG
	ReGGVxNrWIv22KM00QZaDIvPKsnL+PUP3+VPkjeLArQes/PIm5LGDaEN334/+3Q162yDD8Z9OVz
	Sv+iSk9BiyPut/O3rwwaTq54MfwPbnUKeTZ1bw0Vta8J/i5rFf6L154KEr+qR+hTahQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053336; bh=WlrpMszuag375++3au3AQMu
	mLE/Z1ZoZmJDjJqd8ieY=; b=UzO03XcRaN3wGrSqDtBkO/u7EMhC+mKUBkEupBvSBqMoLn/K9o
	n56YX+PHZY+jiYPCh5W/1ggBp9Tr5ku7pFAw==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Wed, 17 Sep 2025 03:07:26 +0700
Subject: [PATCH 09/25] dt-bindings: clock: Add RDA Micro RDA8810PL
 clock/reset controller
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-9-74866def1fe3@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2

Add documentation describing the RDA8810PL Clock and Reset
controller.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 .../bindings/clock/rda,8810pl-apsyscon.yaml        | 44 ++++++++++++
 include/dt-bindings/clock/rda,8810pl-apclk.h       | 79 ++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml b/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..988b609403a96abc4964ab366daa6fec0514595c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rda,8810pl-apsyscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro RDA8810PL AP Clock Controller
+
+maintainers:
+  - Dang Huynh <dang.huynh@mainlining.org>
+
+properties:
+  compatible:
+    items:
+      - const: rda,8810pl-apsyscon
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rda,8810pl-apclk.h>
+
+    ap_syscon: syscon@0 {
+      compatible = "rda,8810pl-apsyscon", "syscon";
+      reg = <0x0 0x1000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/rda,8810pl-apclk.h b/include/dt-bindings/clock/rda,8810pl-apclk.h
new file mode 100644
index 0000000000000000000000000000000000000000..372358e72436a28c0775519f49626c9c5f4c6046
--- /dev/null
+++ b/include/dt-bindings/clock/rda,8810pl-apclk.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_RDA8810_H_
+#define _DT_BINDINGS_CLK_RDA8810_H_
+
+/* soc clocks */
+#define CLK_CPU 0
+#define CLK_BUS 1
+#define CLK_MEM 2
+
+#define CLK_USB 3
+#define CLK_AXI 4
+#define CLK_GCG 5
+#define CLK_AHB1 6
+#define CLK_APB1 7
+#define CLK_APB2 8
+
+#define CLK_GPU 9
+#define CLK_VPU 10
+#define CLK_VOC 11
+#define CLK_SFLSH 12
+
+#define CLK_UART1 13
+#define CLK_UART2 14
+#define CLK_UART3 15
+
+#define CLK_VOC2 16
+#define CLK_EMMC 17
+
+#define CLK_COUNT (CLK_EMMC + 1)
+
+/* resets */
+#define RST_CPU 0
+
+#define RST_AXI_VOC 1
+#define RST_AXI_DMA 2
+#define RST_AXI_CONNECT 3
+#define RST_AXI_VPU 4
+
+#define RST_GCG_GOUDA 5
+#define RST_GCG_CAMERA 6
+#define RST_GCG_LCDC 7
+
+#define RST_AHB1_USBC 8
+#define RST_AHB1_SPIFLASH 9
+
+#define RST_APB1_TIMER 10
+#define RST_APB1_KEYPAD 11
+#define RST_APB1_GPIO 12
+#define RST_APB1_PWM 13
+#define RST_APB1_AIF 14
+#define RST_APB1_AUIFC 15
+#define RST_APB1_I2C1 16
+#define RST_APB1_I2C2 17
+#define RST_APB1_I2C3 18
+#define RST_APB1_COMREGS 19
+#define RST_APB1_DMC 20
+#define RST_APB1_DDRPHY_P 21
+
+#define RST_APB2_IFC 22
+#define RST_APB2_UART1 23
+#define RST_APB2_UART2 24
+#define RST_APB2_UART3 25
+#define RST_APB2_SPI1 26
+#define RST_APB2_SPI2 27
+#define RST_APB2_SPI3 28
+#define RST_APB2_SDMMC1 29
+#define RST_APB2_SDMMC2 30
+#define RST_APB2_SDMMC3 31
+#define RST_APB2_NAND 32
+
+#define RST_MEM_GPU 33
+#define RST_MEM_VPU 34
+#define RST_MEM_DMC 35
+#define RST_MEM_DDRPHY_P 36
+
+#define RST_COUNT (RST_MEM_DDRPHY_P + 1)
+
+#endif /* _DT_BINDINGS_CLK_RDA8810_H_ */

-- 
2.51.0


