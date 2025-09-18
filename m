Return-Path: <dmaengine+bounces-6652-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9EEB868F7
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB3C1C83F15
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 18:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110882FCBE1;
	Thu, 18 Sep 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcI/Kqlw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391F2D94B8;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221398; cv=none; b=d0xtclZEICiARjjLMy0V30GhWiT2X1/dlSgXIeTqOcva+5FcViTTM6lj7uOvxX/hWQ/4/ZfhJypgKPPFBLgjjaDe6O5Ncv2ATRFtO01Hp+9IUrqfhA4ZA6FON8oF5BbFOUc1oWpDqhcJhrQn4EpK5QAvKD620RGGrRxfnbQb7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221398; c=relaxed/simple;
	bh=ohlcFbPtKmd6hrVvoOnC65XlpriD3T31l/t/8TTOy4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oye3woRcplVlKd/6JkcHFK8asE+0ZhHtmFxH4QWvc7qfNv6LdaxYFlzLmS6mNUWaZCacSVAEOWdmEoaQxcxqzo6mKXZjoauxlJ8ffgs8zEZ3Q/B0kPWd8zGB5eQRcgEPdYxFU1dRy8dUTW3vxsMWJqy70qxhdJp/St1ZNAdMxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcI/Kqlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49FA3C2BCB0;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221398;
	bh=ohlcFbPtKmd6hrVvoOnC65XlpriD3T31l/t/8TTOy4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VcI/KqlwaUz3pzRY2vSkreJU/lnbr9uVzPm2ZpZmHqy3g4XpVzUbb0Y2gLulGPVH7
	 1xQYCISUFMx9MoeJdKXb50gV5szekq8VcTJJqsuBu/WEFdOFvOmzoCrTW3tXQ0R7v6
	 NPhvpAnz26EsK4oiMgxeUDKBwgvlw74oNpa/rzoAsO07LAGPL090KdVdWFGY8xgAVG
	 LuDK7QYKhkQktyI0U/na2G2KkStZ2cDjjSOcMt07JjZ8+lB5GlhTeSjYn6zSNiV/dc
	 5G82PRCr5+ca0aGlnuKhVdblbCpsOyLbXCFt7sdx/IhnTstmIhlHlCdRo59LEsLR0N
	 /i8l85YIl56Dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B71CAC59A;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Fri, 19 Sep 2025 01:48:47 +0700
Subject: [PATCH 07/10] clk: Add Clock and Reset Driver for RDA Micro
 RDA8810PL SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-rda8810pl-mmc-v1-7-d4f08a05ba4d@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758221395; l=26561;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=CvcBXgkQGoS86dp3bss1ffFLI1ZZup5pOtQeoJAC0UY=;
 b=EcTki2KHo91GML0NzHo8REuqpG2umkkwffUzzeHjvqHD58XhIKrIv0So1Go41BF5W17FTGt9h
 CzEk13FqLiCDmYPkDlNZdlLWHat2UW+GbSu0yVQ/iJKJ3Hcjy5x3UrO
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

Add a clock/reset driver for RDA8810PL SoC, which provides clocks for
various subsystems.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 MAINTAINERS                   |   6 +
 drivers/clk/Kconfig           |   1 +
 drivers/clk/Makefile          |   1 +
 drivers/clk/rda/Kconfig       |  14 +
 drivers/clk/rda/Makefile      |   2 +
 drivers/clk/rda/clk-rda8810.c | 769 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 793 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8886d66bd8242ae76ca52393af3958435bf6b9a5..56f9d19fbf421eefffe554987e14604c764daab2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21418,6 +21418,12 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	tools/testing/selftests/rcutorture
 
+RDA MICRO CLOCK AND RESET DRIVER
+M:	Dang Huynh <dang.huynh@mainlining.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/rda,8810pl-apsyscon.yaml
+F:	drivers/clk/rda/clk-rda8810.c
+
 RDACM20 Camera Sensor
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index b1425aed659387a676bd933fe50ac4894c7156fe..15f5bc9108b565acb1c3c6e978ad0e5a71f5550d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -520,6 +520,7 @@ source "drivers/clk/nuvoton/Kconfig"
 source "drivers/clk/pistachio/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/ralink/Kconfig"
+source "drivers/clk/rda/Kconfig"
 source "drivers/clk/renesas/Kconfig"
 source "drivers/clk/rockchip/Kconfig"
 source "drivers/clk/samsung/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 18ed29cfdc1133b6c254190c6092eb263366d5ac..8241bb7f88daaebde766ba92d718b2ca710d6b5f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_COMMON_CLK_PISTACHIO)	+= pistachio/
 obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-y					+= ralink/
+obj-y					+= rda/
 obj-y					+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
diff --git a/drivers/clk/rda/Kconfig b/drivers/clk/rda/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..b505e3e552cef1e7ea3da4aa46d61d0d0a3d5db0
--- /dev/null
+++ b/drivers/clk/rda/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config CLK_RDA8810
+	bool "RDA Micro RDA8810PL Clock and Reset Controller"
+	depends on ARCH_RDA || COMPILE_TEST
+	select MFD_SYSCON
+	select REGMAP_MMIO
+	select RESET_CONTROLLER
+	help
+	  This driver supports clock and reset for RDA Micro RDA8810 platform.
+	  If you have a board with the RDA8810PL SoC, say Y to use most of the
+	  board peripherals.
+
+	  If unsure, say N.
+
diff --git a/drivers/clk/rda/Makefile b/drivers/clk/rda/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..98848dccabe5d2199d5e9469d6bde154b2b3d86a
--- /dev/null
+++ b/drivers/clk/rda/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_CLK_RDA8810) += clk-rda8810.o
diff --git a/drivers/clk/rda/clk-rda8810.c b/drivers/clk/rda/clk-rda8810.c
new file mode 100644
index 0000000000000000000000000000000000000000..8d844f30a0deede267fe531dbf7b370a8328cff0
--- /dev/null
+++ b/drivers/clk/rda/clk-rda8810.c
@@ -0,0 +1,769 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDA8810PL Clock and Reset driver
+ *
+ * Copyright (C) 2013 RDA Microelectronics Inc.
+ * Copyright (c) 2025 Dang Huynh <dang.huynh@mainlining.org>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/reset-controller.h>
+#include <dt-bindings/clock/rda,8810pl-apclk.h>
+
+#define MHZ 1000000U
+
+/*
+ * Some registers are protected, we need to write AP_CTRL_PROTECT_UNLOCK to
+ * AP_REG_DBG then we can make changes to them.
+ */
+#define AP_CTRL_PROTECT_LOCK	0xA50000
+#define AP_CTRL_PROTECT_UNLOCK	0xA50001
+
+/* Register Base */
+#define AP_REG_DBG 0x0
+#define AP_REG_CPU_ENABLE 0x60
+#define AP_REG_AXI_ENABLE 0x6C
+#define AP_REG_AXIDIV2_ENABLE 0x78
+#define AP_REG_GCG_ENABLE 0x84
+#define AP_REG_AHB1_ENABLE 0x90
+#define AP_REG_APB1_ENABLE 0x9C
+#define AP_REG_APB2_ENABLE 0xA8
+#define AP_REG_MEM_ENABLE 0xB4
+#define AP_REG_APO_ENABLE 0xC0
+
+/* AP Clk Config Bits */
+#define AP_PERI_SRC_DIV BIT(12)
+
+/* UART Clock Bits */
+#define AP_UART_DIVIDER GENMASK(9, 0)
+#define AP_UART_SET_PLL BIT(12)
+
+/* AP Clk Enable */
+#define AP_ENABLE_CPU_CORE BIT(0)
+#define AP_ENABLE_CPU_DUMMY BIT(1)
+#define AP_ENABLE_AHB0_CONF BIT(0)
+#define AP_ENABLE_APB0_CONF BIT(1)
+#define AP_ENABLE_AXI_VOC  BIT(2)
+#define AP_ENABLE_AXI_DMA  BIT(3)
+#define AP_ENABLE_AXI_ALWAYS BIT(4)
+#define AP_ENABLE_AXI_CONNECT BIT(5)
+#define AP_ENABLE_APB0_IRQ BIT(6)
+#define AP_ENABLE_AXIDIV2_IMEM BIT(0)
+#define AP_ENABLE_AXIDIV2_ALWAYS BIT(1)
+#define AP_ENABLE_AXIDIV2_CONNECT BIT(2)
+#define AP_ENABLE_AXIDIV2_VPU BIT(3)
+#define AP_ENABLE_GCG_APB_CONF BIT(0)
+#define AP_ENABLE_GCG_GOUDA BIT(1)
+#define AP_ENABLE_GCG_CAMERA BIT(2)
+#define AP_ENABLE_GCG_ALWAYS BIT(3)
+#define AP_ENABLE_GCG_CONNECT BIT(4)
+#define AP_ENABLE_GCG_DPI BIT(7)
+#define AP_ENABLE_AHB1_USBC BIT(0)
+#define AP_ENABLE_AHB1_ALWAYS BIT(1)
+#define AP_ENABLE_AHB1_SPIFLASH BIT(2)
+#define AP_ENABLE_APB1_CONF BIT(0)
+#define AP_ENABLE_APB1_AIF BIT(1)
+#define AP_ENABLE_APB1_AUIFC BIT(2)
+#define AP_ENABLE_APB1_AUIFC_CH0 BIT(3)
+#define AP_ENABLE_APB1_AUIFC_CH1 BIT(4)
+#define AP_ENABLE_APB1_I2C1 BIT(5)
+#define AP_ENABLE_APB1_I2C2 BIT(6)
+#define AP_ENABLE_APB1_I2C3 BIT(7)
+#define AP_ENABLE_APB1D_OSC BIT(8)
+#define AP_ENABLE_APB1D_PWM BIT(9)
+#define AP_ENABLE_APB1_ALWAYS BIT(10)
+#define AP_ENABLE_APB1_DAPLITE BIT(11)
+#define AP_ENABLE_APB1_TIMER BIT(12)
+#define AP_ENABLE_APB1_GPIO BIT(13)
+#define AP_ENABLE_APB2_CONF BIT(0)
+#define AP_ENABLE_APB2_IFC BIT(1)
+#define AP_ENABLE_APB2_IFC_CH0 BIT(2)
+#define AP_ENABLE_APB2_IFC_CH1 BIT(3)
+#define AP_ENABLE_APB2_IFC_CH2 BIT(4)
+#define AP_ENABLE_APB2_IFC_CH3 BIT(5)
+#define AP_ENABLE_APB2_IFC_CH4 BIT(6)
+#define AP_ENABLE_APB2_IFC_CH5 BIT(7)
+#define AP_ENABLE_APB2_IFC_CH6 BIT(8)
+#define AP_ENABLE_APB2_IFC_CH7 BIT(9)
+#define AP_ENABLE_APB2_UART1 BIT(10)
+#define AP_ENABLE_APB2_UART2 BIT(11)
+#define AP_ENABLE_APB2_UART3 BIT(12)
+#define AP_ENABLE_APB2_SPI1 BIT(13)
+#define AP_ENABLE_APB2_SPI2 BIT(14)
+#define AP_ENABLE_APB2_SPI3 BIT(15)
+#define AP_ENABLE_APB2_SDMMC1 BIT(16)
+#define AP_ENABLE_APB2_SDMMC2 BIT(17)
+#define AP_ENABLE_APB2_SDMMC3 BIT(18)
+#define AP_ENABLE_APB2_ALWAYS BIT(19)
+#define AP_ENABLE_APB2_NANDFLASH BIT(20)
+#define AP_ENABLE_MEM_CONF BIT(0)
+#define AP_ENABLE_MEM_DMC  BIT(1)
+#define AP_ENABLE_MEM_GPU  BIT(2)
+#define AP_ENABLE_MEM_VPU  BIT(3)
+#define AP_ENABLE_MEM_DDRPHY_P BIT(4)
+#define AP_ENABLE_MEM_CONNECT BIT(5)
+#define AP_ENABLE_APOC_VPU BIT(0)
+#define AP_ENABLE_APOC_BCK BIT(1)
+#define AP_ENABLE_APOC_UART1 BIT(2)
+#define AP_ENABLE_APOC_UART2 BIT(3)
+#define AP_ENABLE_APOC_UART3 BIT(4)
+#define AP_ENABLE_APOC_VOC_CORE BIT(5)
+#define AP_ENABLE_APOC_VOC BIT(6)
+#define AP_ENABLE_APOC_VOC_ALWAYS BIT(7)
+#define AP_ENABLE_APOC_DDRPHY_N BIT(8)
+#define AP_ENABLE_APOC_DDRPHY2XP BIT(9)
+#define AP_ENABLE_APOC_DDRPHY2XN BIT(10)
+#define AP_ENABLE_APOC_GPU BIT(11)
+#define AP_ENABLE_APOC_USBPHY BIT(12)
+#define AP_ENABLE_APOC_CSI BIT(13)
+#define AP_ENABLE_APOC_DSI BIT(14)
+#define AP_ENABLE_APOC_GPIO BIT(15)
+#define AP_ENABLE_APOC_SPIFLASH BIT(16)
+#define AP_ENABLE_APOC_PIX BIT(17)
+#define AP_ENABLE_APOC_PDGB BIT(18)
+
+/* AP Reset */
+#define AP_RST_CPU_REG 0x1C
+#define AP_RST_AXI_REG 0x24
+#define AP_RST_AXIDIV2_REG 0x2C
+#define AP_RST_GCG_REG 0x34
+#define AP_RST_AHB1_REG 0x3C
+#define AP_RST_APB1_REG 0x44
+#define AP_RST_APB2_REG 0x4C
+#define AP_RST_MEM_REG 0x54
+
+/* Bits */
+#define AP_RST_CPU_CORE BIT(0)
+#define AP_RST_CPU_SYS BIT(1)
+#define AP_RST_AXI_VOC BIT(0)
+#define AP_RST_AXI_DMA BIT(1)
+#define AP_RST_AXI_SYS BIT(2)
+#define AP_RST_AXI_CONNECT BIT(3)
+#define AP_RST_AXI_VPU BIT(5)
+#define AP_RST_AXIDIV2_IMEM BIT(0)
+#define AP_RST_AXIDIV2_SYS BIT(1)
+#define AP_RST_AXIDIV2_VPU BIT(2)
+#define AP_RST_GCG_SYS BIT(0)
+#define AP_RST_GCG_GOUDA BIT(1)
+#define AP_RST_GCG_CAMERA BIT(2)
+#define AP_RST_GCG_LCDC BIT(4)
+#define AP_RST_AHB1_SYS BIT(0)
+#define AP_RST_AHB1_USBC BIT(1)
+#define AP_RST_AHB1_SPIFLASH BIT(2)
+#define AP_RST_APB1_SYS BIT(0)
+#define AP_RST_APB1_TIMER BIT(1)
+#define AP_RST_APB1_KEYPAD BIT(2)
+#define AP_RST_APB1_GPIO BIT(3)
+#define AP_RST_APB1_PWM BIT(4)
+#define AP_RST_APB1_AIF BIT(5)
+#define AP_RST_APB1_AUIFC BIT(6)
+#define AP_RST_APB1_I2C1 BIT(7)
+#define AP_RST_APB1_I2C2 BIT(8)
+#define AP_RST_APB1_I2C3 BIT(9)
+#define AP_RST_APB1_COMREGS BIT(10)
+#define AP_RST_APB1_DMC BIT(11)
+#define AP_RST_APB1_DDRPHY_P BIT(12)
+#define AP_RST_APB2_SYS BIT(0)
+#define AP_RST_APB2_IFC BIT(1)
+#define AP_RST_APB2_UART1 BIT(2)
+#define AP_RST_APB2_UART2 BIT(3)
+#define AP_RST_APB2_UART3 BIT(4)
+#define AP_RST_APB2_SPI1 BIT(5)
+#define AP_RST_APB2_SPI2 BIT(6)
+#define AP_RST_APB2_SPI3 BIT(7)
+#define AP_RST_APB2_SDMMC1 BIT(8)
+#define AP_RST_APB2_SDMMC2 BIT(9)
+#define AP_RST_APB2_SDMMC3 BIT(10)
+#define AP_RST_APB2_NANDFLASH BIT(11)
+#define AP_RST_MEM_SYS BIT(0)
+#define AP_RST_MEM_GPU BIT(1)
+#define AP_RST_MEM_VPU BIT(2)
+#define AP_RST_MEM_DMC BIT(3)
+#define AP_RST_MEM_DDRPHY_P BIT(4)
+
+/* Default PLL frequency */
+#define AP_PLL_CPU_FREQ (988 * MHZ)
+#define AP_PLL_BUS_FREQ (800 * MHZ)
+#define AP_PLL_MEM_FREQ (260 * MHZ)
+#define AP_PLL_USB_FREQ (480 * MHZ)
+
+struct rda8810_reset_list {
+	int reg;
+	int bit;
+};
+
+struct rda_clk_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct clk_hw_onecell_data *onecell;
+	struct reset_controller_dev rstctl;
+	const struct rda8810_reset_list *rstlist;
+};
+
+struct rda_clk_hw {
+	int id;
+	int reg;
+	struct clk_hw hw;
+
+	int ena_reg;
+	int ena_bit;
+
+	struct rda_clk_priv *priv;
+};
+
+struct rda_clk_matchdata {
+	const struct rda_clk_hw *clk_list;
+	int max_clocks;
+};
+
+static const struct clk_ops rda8810_clk_ops;
+
+#define RDA_CLK_INIT(_id, _name, _parent, _flags, _reg, _ena_reg, _ena_bit) { \
+	.id = _id, \
+	.reg = _reg, \
+	.ena_reg = _ena_reg, \
+	.ena_bit = _ena_bit, \
+	.hw.init = CLK_HW_INIT_PARENTS_DATA(_name, \
+			_parent, \
+			&rda8810_clk_ops, \
+			_flags) \
+}
+
+#define RDA_CLK_INIT_NO_PARENT(_id, _name, _flags, _reg, _ena_reg, _ena_bit) { \
+	.id = _id, \
+	.reg = _reg, \
+	.ena_reg = _ena_reg, \
+	.ena_bit = _ena_bit, \
+	.hw.init = CLK_HW_INIT_NO_PARENT(_name, &rda8810_clk_ops, _flags) \
+}
+
+#define to_rda_rst(p) container_of(p, struct rda_clk_priv, rstctl)
+
+static inline struct rda_clk_hw *to_rda_hw(struct clk_hw *hw)
+{
+	return container_of(hw, struct rda_clk_hw, hw);
+}
+
+/* clock division value map */
+static const u8 clk_div_map[] = {
+	4*60,	/* 0 */
+	4*60,	/* 1 */
+	4*60,	/* 2 */
+	4*60,	/* 3 */
+	4*60,	/* 4 */
+	4*60,	/* 5 */
+	4*60,	/* 6 */
+	4*60,	/* 7 */
+	4*40,	/* 8 */
+	4*30,	/* 9 */
+	4*24,	/* 10 */
+	4*20,	/* 11 */
+	4*17,	/* 12 */
+	4*15,	/* 13 */
+	4*13,	/* 14 */
+	4*12,	/* 15 */
+	4*11,	/* 16 */
+	4*10,	/* 17 */
+	4*9,	/* 18 */
+	4*8,	/* 19 */
+	4*7,	/* 20 */
+	4*13/2,	/* 21 */
+	4*6,	/* 22 */
+	4*11/2,	/* 23 */
+	4*5,	/* 24 */
+	4*9/2,	/* 25 */
+	4*4,	/* 26 */
+	4*7/2,	/* 27 */
+	4*3,	/* 28 */
+	4*5/2,	/* 29 */
+	4*2,	/* 30 */
+	4*1,	/* 31 */
+};
+
+static u32 apsys_get_divreg(u32 basefreq, u32 reqfreq, u32 *pdiv2)
+{
+	int i;
+	int index;
+	u32 adiv;
+	u32 ndiv;
+
+	adiv = basefreq / (reqfreq >> 2);
+	if (pdiv2) {
+		/* try div2 mode first */
+		ndiv = adiv >> 1;
+	} else {
+		ndiv = adiv;
+	}
+
+	for (i = ARRAY_SIZE(clk_div_map) - 1; i >= 1; i--)
+		if (ndiv < ((clk_div_map[i] + clk_div_map[i-1]) >> 1))
+			break;
+	index = i;
+
+	if (pdiv2) {
+		if (adiv == (clk_div_map[index] << 1)) {
+			/* div2 mode is OK */
+			*pdiv2 = 1;
+		} else {
+			/* try div1 mode */
+			for (i = ARRAY_SIZE(clk_div_map) - 1; i >= 1; i--)
+				if (adiv < ((clk_div_map[i] + clk_div_map[i-1]) >> 1))
+					break;
+			/* compare the results between div1 and div2 */
+			if (abs(adiv - (clk_div_map[index] << 1)) <=
+					abs(adiv - clk_div_map[i])) {
+				*pdiv2 = 1;
+			} else {
+				*pdiv2 = 0;
+				index = i;
+			}
+		}
+	}
+
+	return index;
+}
+
+static u32 apsys_cal_freq_by_divreg(u32 basefreq, u32 reg, u32 div2)
+{
+	u32 newfreq;
+
+	if (reg >= ARRAY_SIZE(clk_div_map))
+		reg = ARRAY_SIZE(clk_div_map) - 1;
+
+	/* Assuming basefreq is smaller than 2^31 (2.147G Hz) */
+	newfreq = (basefreq << (div2 ? 0 : 1)) / (clk_div_map[reg] >> 1);
+	return newfreq;
+}
+
+static void apsys_get_reg_div(struct rda_clk_hw *rda_hw, u32 *reg, u32 *div2)
+{
+	struct rda_clk_priv *priv = rda_hw->priv;
+	int tmp_reg, tmp_div2;
+	int ret;
+
+	ret = regmap_read(priv->regmap, rda_hw->reg, &tmp_reg);
+	if (ret)
+		return;
+
+	tmp_div2 = tmp_reg & AP_PERI_SRC_DIV;
+
+	*reg = tmp_reg;
+	*div2 = tmp_div2;
+}
+
+static int apsys_get_uart_clock(unsigned long parent_rate, u32 *reg)
+{
+	int clksrc = 26000000;
+	u32 div;
+	int rate = 0;
+
+	if (*reg & AP_UART_SET_PLL)
+		clksrc = parent_rate / 8;
+
+	div = FIELD_GET(AP_UART_DIVIDER, *reg);
+
+	/* rate = clksrc / divmode / (div+2) */
+	rate =  clksrc / 4 / (div + 2);
+
+	return rate;
+}
+
+static int apsys_cal_uart_clock(int freq)
+{
+	int new_freq = freq;
+
+	/*
+	 * To calculate maximum clock:
+	 *     freq = 26 MHz / div / (0 + 2)
+	 *
+	 * For lowest clock:
+	 *     freq = 26 MHz / div / (0x3FF + 2)
+	 */
+	if (freq > 3250000)
+		new_freq = 3250000;
+	else if (freq < 6342)
+		new_freq = 6342;
+
+	new_freq = (26000000 + 4 / 2 * new_freq) / (4 * new_freq) - 2;
+
+	return new_freq;
+}
+
+static int rda8810_clk_set_rate(struct clk_hw *clk, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct rda_clk_hw *rda_hw = to_rda_hw(clk);
+	struct rda_clk_priv *priv = rda_hw->priv;
+	struct device *dev = priv->dev;
+	int val, div2 = 0;
+	int ret;
+
+	switch (rda_hw->id) {
+	case CLK_CPU:
+		val = apsys_get_divreg(AP_PLL_CPU_FREQ, rate, NULL);
+		break;
+	case CLK_AXI:
+	case CLK_AHB1:
+	case CLK_APB1:
+	case CLK_APB2:
+	case CLK_GCG:
+	case CLK_GPU:
+	case CLK_SFLSH:
+	case CLK_VOC:
+	case CLK_VPU:
+		val = apsys_get_divreg(parent_rate, rate, &div2);
+		break;
+	case CLK_UART1:
+	case CLK_UART2:
+	case CLK_UART3:
+		val = apsys_cal_uart_clock(rate);
+		if (val == 0)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (div2)
+		val |= AP_PERI_SRC_DIV;
+
+	dev_dbg(dev, "clk_id: %d - rate: %ld - parent rate: %ld - val: %d - div: %d\n",
+			rda_hw->id, rate, parent_rate, val, div2);
+
+	ret = regmap_write(priv->regmap, rda_hw->reg, val);
+	if (ret < 0)
+		return ret;
+
+	return rate;
+}
+
+static unsigned long rda8810_clk_recalc_rate(struct clk_hw *clk,
+		unsigned long parent_rate)
+{
+	struct rda_clk_hw *rda_hw = to_rda_hw(clk);
+	u32 reg, div2;
+
+	apsys_get_reg_div(rda_hw, &reg, &div2);
+
+	switch (rda_hw->id) {
+	case CLK_CPU:
+		return apsys_cal_freq_by_divreg(AP_PLL_CPU_FREQ, reg, 0);
+	case CLK_BUS:
+		return AP_PLL_BUS_FREQ;
+	case CLK_MEM:
+		return AP_PLL_MEM_FREQ >> (2 + div2);
+	/* Bus peripherals */
+	case CLK_USB:
+		return AP_PLL_USB_FREQ;
+	case CLK_AXI:
+	case CLK_AHB1:
+	case CLK_APB1:
+	case CLK_APB2:
+	case CLK_GCG:
+	case CLK_GPU:
+	case CLK_SFLSH:
+	case CLK_VOC:
+	case CLK_VPU:
+		return apsys_cal_freq_by_divreg(parent_rate, reg, div2);
+	/* For UART clocks, we'll have to do more calculation */
+	case CLK_UART1:
+	case CLK_UART2:
+	case CLK_UART3:
+		return apsys_get_uart_clock(parent_rate, &reg);
+	default:
+		return 0;
+	}
+}
+
+static long rda8810_clk_round_rate(struct clk_hw *clk, unsigned long rate,
+		unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static int rda8810_clk_enable(struct clk_hw *clk)
+{
+	struct rda_clk_hw *rda_hw = to_rda_hw(clk);
+	struct rda_clk_priv *priv = rda_hw->priv;
+
+	if (rda_hw->ena_reg < 0 || rda_hw->ena_bit < 0)
+		return 0;
+
+	return regmap_write(priv->regmap, rda_hw->ena_reg, rda_hw->ena_bit);
+}
+
+static void rda8810_clk_disable(struct clk_hw *clk)
+{
+	struct rda_clk_hw *rda_hw = to_rda_hw(clk);
+	struct rda_clk_priv *priv = rda_hw->priv;
+
+	if (rda_hw->ena_reg < 0 || rda_hw->ena_bit < 0)
+		return;
+
+	regmap_write(priv->regmap, rda_hw->ena_reg + 4, rda_hw->ena_bit);
+}
+
+static const struct clk_ops rda8810_clk_ops = {
+	.enable = rda8810_clk_enable,
+	.disable = rda8810_clk_disable,
+
+	.recalc_rate = rda8810_clk_recalc_rate,
+	.round_rate = rda8810_clk_round_rate,
+	.set_rate = rda8810_clk_set_rate,
+};
+
+/* Root clocks */
+static struct rda_clk_hw rda8810_clk_cpu_desc =
+RDA_CLK_INIT_NO_PARENT(CLK_CPU, "cpu", CLK_IS_CRITICAL, 0xC8,
+		AP_REG_CPU_ENABLE, AP_ENABLE_CPU_CORE);
+static struct rda_clk_hw rda8810_clk_mem_desc =
+RDA_CLK_INIT_NO_PARENT(CLK_MEM, "mem", CLK_IS_CRITICAL, 0xE0, -1, -1);
+
+static struct rda_clk_hw rda8810_clk_bus_desc =
+RDA_CLK_INIT_NO_PARENT(CLK_BUS, "bus", CLK_IS_CRITICAL, -1, -1, -1);
+
+/* Bus clocks */
+static struct rda_clk_hw rda8810_clk_usb_desc = RDA_CLK_INIT(CLK_USB, "usb",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, -1, -1, -1);
+static struct rda_clk_hw rda8810_clk_axi_desc = RDA_CLK_INIT(CLK_AXI, "axi",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, 0xCC, -1, -1);
+static struct rda_clk_hw rda8810_clk_gcg_desc = RDA_CLK_INIT(CLK_GCG, "gcg",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, 0xD0, -1, -1);
+static struct rda_clk_hw rda8810_clk_ahb1_desc = RDA_CLK_INIT(CLK_AHB1, "ahb1",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, 0xD4, -1, -1);
+static struct rda_clk_hw rda8810_clk_apb1_desc = RDA_CLK_INIT(CLK_APB1, "apb1",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, 0xD8, -1, -1);
+static struct rda_clk_hw rda8810_clk_apb2_desc = RDA_CLK_INIT(CLK_APB2, "apb2",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, 0xDC, -1, -1);
+static struct rda_clk_hw rda8810_clk_gpu_desc = RDA_CLK_INIT(CLK_GPU, "gpu",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, 0xE4, AP_REG_APO_ENABLE, AP_ENABLE_APOC_GPU);
+static struct rda_clk_hw rda8810_clk_vpu_desc = RDA_CLK_INIT(CLK_VPU, "vpu",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, 0xE8, AP_REG_APO_ENABLE, AP_ENABLE_APOC_VPU);
+static struct rda_clk_hw rda8810_clk_voc_desc = RDA_CLK_INIT(CLK_VOC, "voc",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_bus_desc.hw } },
+		0, 0xEC, AP_REG_APO_ENABLE,
+		AP_ENABLE_APOC_VOC | AP_ENABLE_APOC_VOC_CORE | AP_ENABLE_APOC_VOC_ALWAYS);
+
+/* APB1 peripherals */
+static struct rda_clk_hw rda8810_clk_spiflash_desc = RDA_CLK_INIT(CLK_SFLSH, "spiflash",
+		(const struct clk_parent_data[]) { { .hw = &rda8810_clk_apb1_desc.hw } },
+		0, 0xF0, AP_REG_APO_ENABLE, AP_ENABLE_APOC_SPIFLASH);
+
+/* APB2 peripherals */
+static struct rda_clk_hw rda8810_clk_uart_desc[] = {
+	RDA_CLK_INIT(CLK_UART1, "uart1",
+			(const struct clk_parent_data[]) { { .hw = &rda8810_clk_apb2_desc.hw } },
+			0, 0xF4,
+			AP_REG_APO_ENABLE, AP_ENABLE_APOC_UART1),
+	RDA_CLK_INIT(CLK_UART2, "uart2",
+			(const struct clk_parent_data[]) { { .hw = &rda8810_clk_apb2_desc.hw } },
+			0, 0xF8,
+			AP_REG_APO_ENABLE, AP_ENABLE_APOC_UART2),
+	RDA_CLK_INIT(CLK_UART3, "uart3",
+			(const struct clk_parent_data[]) { { .hw = &rda8810_clk_apb2_desc.hw } },
+			0, 0xFC,
+			AP_REG_APO_ENABLE, AP_ENABLE_APOC_UART3),
+};
+
+static struct rda_clk_hw *const rda8810_clk_list[] = {
+	&rda8810_clk_cpu_desc,
+	&rda8810_clk_bus_desc,
+	&rda8810_clk_mem_desc,
+
+	&rda8810_clk_usb_desc,
+	&rda8810_clk_axi_desc,
+	&rda8810_clk_gcg_desc,
+	&rda8810_clk_ahb1_desc,
+	&rda8810_clk_apb1_desc,
+	&rda8810_clk_apb2_desc,
+
+	&rda8810_clk_gpu_desc,
+	&rda8810_clk_vpu_desc,
+	&rda8810_clk_voc_desc,
+
+	&rda8810_clk_spiflash_desc,
+
+	&rda8810_clk_uart_desc[0],
+	&rda8810_clk_uart_desc[1],
+	&rda8810_clk_uart_desc[2],
+};
+
+static const struct rda8810_reset_list rda8810_rst_data[] = {
+	/* ID, REG */
+
+	/* CPU */
+	[RST_CPU] = { AP_RST_CPU_REG, AP_RST_CPU_CORE },
+
+	/* AXI */
+	[RST_AXI_VOC] = { AP_RST_AXI_REG, AP_RST_AXI_VOC },
+	[RST_AXI_DMA] = { AP_RST_AXI_REG, AP_RST_AXI_DMA },
+	[RST_AXI_CONNECT] = { AP_RST_AXI_REG, AP_RST_AXI_CONNECT },
+	[RST_AXI_VPU] = { AP_RST_AXI_REG, AP_RST_AXI_VPU },
+
+	/* GCG */
+	[RST_GCG_GOUDA] = { AP_RST_GCG_REG, AP_RST_GCG_GOUDA },
+	[RST_GCG_CAMERA] = { AP_RST_GCG_REG, AP_RST_GCG_CAMERA },
+	[RST_GCG_LCDC] = { AP_RST_GCG_REG, AP_RST_GCG_LCDC },
+
+	/* AHB1 */
+	[RST_AHB1_USBC] = { AP_RST_AHB1_REG, AP_RST_AHB1_USBC },
+	[RST_AHB1_SPIFLASH] = { AP_RST_AHB1_REG, AP_RST_AHB1_SPIFLASH },
+
+	/* APB1 */
+	[RST_APB1_TIMER] = { AP_RST_APB1_REG, AP_RST_APB1_TIMER },
+	[RST_APB1_KEYPAD] = { AP_RST_APB1_REG, AP_RST_APB1_KEYPAD },
+	[RST_APB1_GPIO] = { AP_RST_APB1_REG, AP_RST_APB1_GPIO },
+	[RST_APB1_PWM] = { AP_RST_APB1_REG, AP_RST_APB1_PWM },
+	[RST_APB1_AIF] = { AP_RST_APB1_REG, AP_RST_APB1_AIF },
+	[RST_APB1_AUIFC] = { AP_RST_APB1_REG, AP_RST_APB1_AUIFC },
+	[RST_APB1_I2C1] = { AP_RST_APB1_REG, AP_RST_APB1_I2C1 },
+	[RST_APB1_I2C2] = { AP_RST_APB1_REG, AP_RST_APB1_I2C2 },
+	[RST_APB1_I2C3] = { AP_RST_APB1_REG, AP_RST_APB1_I2C3 },
+	[RST_APB1_COMREGS] = { AP_RST_APB1_REG, AP_RST_APB1_COMREGS },
+	[RST_APB1_DMC] = { AP_RST_APB1_REG, AP_RST_APB1_DMC },
+	[RST_APB1_DDRPHY_P] = { AP_RST_APB1_REG, AP_RST_APB1_DDRPHY_P },
+
+	/* APB2 */
+	[RST_APB2_IFC] = { AP_RST_APB2_REG, AP_RST_APB2_IFC },
+	[RST_APB2_UART1] = { AP_RST_APB2_REG, AP_RST_APB2_UART1 },
+	[RST_APB2_UART2] = { AP_RST_APB2_REG, AP_RST_APB2_UART2 },
+	[RST_APB2_UART3] = { AP_RST_APB2_REG, AP_RST_APB2_UART3 },
+	[RST_APB2_SPI1] = { AP_RST_APB2_REG, AP_RST_APB2_SPI1 },
+	[RST_APB2_SPI2] = { AP_RST_APB2_REG, AP_RST_APB2_SPI2 },
+	[RST_APB2_SPI3] = { AP_RST_APB2_REG, AP_RST_APB2_SPI3 },
+	[RST_APB2_SDMMC1] = { AP_RST_APB2_REG, AP_RST_APB2_SDMMC1 },
+	[RST_APB2_SDMMC2] = { AP_RST_APB2_REG, AP_RST_APB2_SDMMC2 },
+	[RST_APB2_SDMMC3] = { AP_RST_APB2_REG, AP_RST_APB2_SDMMC3 },
+	[RST_APB2_NAND] = { AP_RST_APB2_REG, AP_RST_APB2_NANDFLASH },
+
+	/* MEM */
+	[RST_MEM_GPU] = { AP_RST_MEM_REG, AP_RST_MEM_GPU },
+	[RST_MEM_VPU] = { AP_RST_MEM_REG, AP_RST_MEM_VPU },
+	[RST_MEM_DMC] = { AP_RST_MEM_REG, AP_RST_MEM_DMC },
+	[RST_MEM_DDRPHY_P] = { AP_RST_MEM_REG, AP_RST_MEM_DDRPHY_P },
+};
+
+static int rda8810_reset_assert(struct reset_controller_dev *rstctl, unsigned long id)
+{
+	struct rda_clk_priv *priv = to_rda_rst(rstctl);
+
+	return regmap_write(priv->regmap, rda8810_rst_data[id].reg, rda8810_rst_data[id].bit);
+}
+
+static int rda8810_reset_deassert(struct reset_controller_dev *rstctl, unsigned long id)
+{
+	struct rda_clk_priv *priv = to_rda_rst(rstctl);
+
+	return regmap_write(priv->regmap, rda8810_rst_data[id].reg + 4, rda8810_rst_data[id].bit);
+}
+
+static const struct reset_control_ops rda8810_rst_ops = {
+	.assert = &rda8810_reset_assert,
+	.deassert = &rda8810_reset_deassert,
+};
+
+static int rda8810_clk_register(struct rda_clk_priv *priv)
+{
+	struct device *dev = priv->dev;
+	struct clk_hw_onecell_data *onecell_data;
+	int ret;
+	int i;
+
+	onecell_data = devm_kzalloc(dev,
+			struct_size(onecell_data, hws, ARRAY_SIZE(rda8810_clk_list)),
+			GFP_KERNEL);
+	if (!onecell_data)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(rda8810_clk_list); i++) {
+		rda8810_clk_list[i]->priv = priv;
+
+		ret = devm_clk_hw_register(dev, &rda8810_clk_list[i]->hw);
+		if (ret) {
+			dev_err(dev, "Failed to register clock: %d\n", ret);
+			return ret;
+		}
+		onecell_data->hws[i] = &rda8810_clk_list[i]->hw;
+	}
+	onecell_data->num = i;
+	priv->onecell = onecell_data;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, onecell_data);
+}
+
+static int rda8810_rst_register(struct rda_clk_priv *priv)
+{
+	struct device *dev = priv->dev;
+
+	priv->rstctl.dev = priv->dev;
+	priv->rstctl.nr_resets = 37;
+	priv->rstctl.of_node = priv->dev->of_node;
+	priv->rstctl.ops = &rda8810_rst_ops;
+	priv->rstctl.owner = THIS_MODULE;
+
+	return devm_reset_controller_register(dev, &priv->rstctl);
+}
+
+static int rda8810_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rda_clk_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return dev_err_probe(dev, -ENOMEM, "Cannot allocate memory\n");
+
+	priv->dev = dev;
+
+	priv->regmap = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, -ENOMEM, "Cannot initialize regmap\n");
+
+	ret = rda8810_clk_register(priv);
+	if (ret)
+		return dev_err_probe(dev, -EINVAL, "Failed to setup clock: %d\n", ret);
+
+	ret = rda8810_rst_register(priv);
+	if (ret)
+		return dev_err_probe(dev, -EINVAL, "Failed to setup reset: %d\n", ret);
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static const struct of_device_id rda8810_clk_of_match_table[] = {
+	{ .compatible = "rda,8810pl-apsyscon", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rda8810_clk_of_match_table);
+
+static struct platform_driver rda8810_clk_driver = {
+	.probe = rda8810_clk_probe,
+	.driver = {
+		.name = "rda8810-clk",
+		.of_match_table = rda8810_clk_of_match_table,
+	},
+};
+module_platform_driver(rda8810_clk_driver);
+
+MODULE_AUTHOR("Dang Huynh <dang.huynh@mainlining.org>");
+MODULE_DESCRIPTION("RDA8810PL clock and reset driver");
+MODULE_LICENSE("GPL");

-- 
2.51.0



