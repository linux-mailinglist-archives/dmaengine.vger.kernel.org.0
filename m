Return-Path: <dmaengine+bounces-6566-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5AB5A26F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046F73278A9
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DE334391;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Birj6Lfi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E731B820;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=bAFzep2i4tX+7kUTakDwKQh7blccoqZ6ETIjWxXfzySyG/8IQH6EcWwN2fUwkIY8Gsa0O38AR54PY/C+svKslrH5xhKH2FbkRNuLfZEwgx2SItqdlubogOL5houV+9aO4TGej/LIAvSWwrb/1/5sBx18fBQPMy3wiAxhVMuy3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=s5jfml22S4HZXK96jIcDhIwNffw2qcJ0QY0RssdtAYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PoM3RIMhF5Ex/WwsL8HFUqt1KdtXn4M6pSnmI2b8zPenYo5bZImfnKwlUDsbyUqf6So4tH03DYptE1BYTggKfQ0pb5Hg6hIKq+CM0ob4bCq3nucXoiCM3PVMNOqZgwkU017fbJAfGdFt1xMolLDWl6wttFs+kbBPQAVkuiLGplg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Birj6Lfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78A3DC2BCC4;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=s5jfml22S4HZXK96jIcDhIwNffw2qcJ0QY0RssdtAYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Birj6LfivaNjxqb8uCvp/d+CR1xUfaMr/nE+QUIambTVTGHnn8cCDzqmT4pGj1Pfu
	 WKL6K68MdfVk1K/Wma+iBl8XbHykjT4D6/Rotfj0uLFRn2yLMFYaXlRzHA123sYELY
	 vpOMj6KWEEedSp3OSnrm2/zhHGscp2bEI84xoV4NykeqhcWb8l8OcI7UF8P7Ub60DQ
	 2PoZ9BLaxo9GDQ9B3WLuUPieOFYlYoyw2d7OIIb9KW269AEHOXKwlj+FLUYt6lWRGI
	 io6TfrMkaogxPet+GDXEyVlsqojpzOufXEWzMtJpQNuh6yYF8Rwj6dMoTTN8KYvBpx
	 gnfQNM9yHCtYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E18FCAC5A0;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:06 +0700
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
Message-Id: <20250917-rda8810pl-drivers-v1-9-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=3631;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=F0hJeg4vF8n1IM7OJY4KSBkC9cZRnfQ7Ctr7Iv83zwo=;
 b=W5aQqbp5wDQi2g8XC9wV9RV6i8ghSROwrftQm0G26e3EgJ7UwRgy8QFcZDW/kC8joRM4uC3Vz
 OnZu0YIn94TBd4gvxz2dnv/wUco20c3tMi/KuPVnqJ9wsl7lNQZzVrw
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

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



