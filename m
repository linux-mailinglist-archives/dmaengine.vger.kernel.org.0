Return-Path: <dmaengine+bounces-6661-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262DB8BF4E
	for <lists+dmaengine@lfdr.de>; Sat, 20 Sep 2025 06:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BD91C03A4E
	for <lists+dmaengine@lfdr.de>; Sat, 20 Sep 2025 04:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5422156B;
	Sat, 20 Sep 2025 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/jGVXwM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622714A4DB;
	Sat, 20 Sep 2025 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758343819; cv=none; b=q8XJh7dYUpc9HMYELn/HngeaZqngELwQbPoBdLMbauZi0WX6MwVpN2u2p/23uJ8as1INsrC8g4Pk+q+ODo5kuHGtmL6Rg+C8abGFai7crTjv1tv65xQzBCBvmuDDDuxfvtARSe7q/YMYqqiBMeWmqXLXfj5GxFG3qmijYkgwNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758343819; c=relaxed/simple;
	bh=Vf7kopvIIprch/M1jSMlY0FSOG7KoU9xh1jYiJfyxaQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=OxLC+h/a+AAH6rTpb2/b6Vt0YLlyfTYb6iOLbd8xihN7694XKJl3qFWmXN0yocXWCoWBFIlon9qLkpcigoMAgRmnuMtHAx1WB6JfkvU/gqW/ZEwcw6YJBY0lg72TMh8R4jsEQoagX6CryNU1t+ZcNc8lXfVIBjnVLfEqaV+ymQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/jGVXwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3C8C4CEEB;
	Sat, 20 Sep 2025 04:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758343819;
	bh=Vf7kopvIIprch/M1jSMlY0FSOG7KoU9xh1jYiJfyxaQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=A/jGVXwMlKpCsEQokQd8/ve/OKvYqZDmCH9iePG3mMveDXKpi3F5/f10Dd7LGn/aC
	 7GMOE+t3UsbEAozYBEx52yzOIhESKRBJe2nKiB9cAfgzBtfWsIWHdFt4sCJefPoMpL
	 KlSXxtfCzo4GPatJ2wkzF6+T5ZrUGUSel1/GCgTXRDjH5QkqE7+ogwX3aU73Z7vtLB
	 Pw3sKdYWHJbOomPOLn/h7kMf9XFco8eBtx0TRkjGgigw/hhsI08NxfKUIzX63+B3Bt
	 WvNuR8kej4FlA9K4i9fLBuj/RBxWFahxTRcH5L57HcLL3AxdhHF5K7roGKstlOIz20
	 fP6QAzOfUACkQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250917-rda8810pl-drivers-v1-10-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org> <20250917-rda8810pl-drivers-v1-10-9ca9184ca977@mainlining.org>
Subject: Re: [PATCH 10/25] drivers: clk: Add Clock and Reset Driver for RDA Micro RDA8810PL SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>, Gustavo A. R. Silva <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Vinod Koul <vkoul@kernel.org>, dang.huynh@mainlining.org
Date: Fri, 19 Sep 2025 21:50:18 -0700
Message-ID: <175834381800.4354.236139690917902046@lazor>
User-Agent: alot/0.11

Quoting Dang Huynh via B4 Relay (2025-09-16 13:25:07)
> diff --git a/drivers/clk/rda/Kconfig b/drivers/clk/rda/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..b505e3e552cef1e7ea3da4aa4=
6d61d0d0a3d5db0
> --- /dev/null
> +++ b/drivers/clk/rda/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config CLK_RDA8810
> +       bool "RDA Micro RDA8810PL Clock and Reset Controller"

Can it be tristate?

> +       depends on ARCH_RDA || COMPILE_TEST
> +       select MFD_SYSCON
> +       select REGMAP_MMIO
> +       select RESET_CONTROLLER
> +       help
> +         This driver supports clock and reset for RDA Micro RDA8810 plat=
form.
> +         If you have a board with the RDA8810PL SoC, say Y to use most o=
f the
> +         board peripherals.
> +
> +         If unsure, say N.
> +
> new file mode 100644
> index 0000000000000000000000000000000000000000..8bea60d5376aeb4c67cd15bc1=
a64dbcf7a0a1f7c
> --- /dev/null
> +++ b/drivers/clk/rda/clk-rda8810.c
> @@ -0,0 +1,770 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * RDA8810PL Clock and Reset driver
> + *
> + * Copyright (C) 2013 RDA Microelectronics Inc.
> + * Copyright (c) 2025 Dang Huynh <dang.huynh@mainlining.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>

Is this used?

> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

Is this used?

> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/reset-controller.h>
> +#include <dt-bindings/clock/rda,8810pl-apclk.h>
> +
> +#define MHZ 1000000U
> +
> +/*
> + * Some registers are protected, we need to write AP_CTRL_PROTECT_UNLOCK=
 to
> + * AP_REG_DBG then we can make changes to them.
> + */
> +#define AP_CTRL_PROTECT_LOCK   0xA50000
> +#define AP_CTRL_PROTECT_UNLOCK 0xA50001

Lowercase hex please. I don't see these used though so what's going on?

> +
> +/* Register Base */
> +#define AP_REG_DBG 0x0
> +#define AP_REG_CPU_ENABLE 0x60
> +#define AP_REG_AXI_ENABLE 0x6C
> +#define AP_REG_AXIDIV2_ENABLE 0x78
> +#define AP_REG_GCG_ENABLE 0x84
> +#define AP_REG_AHB1_ENABLE 0x90
> +#define AP_REG_APB1_ENABLE 0x9C
> +#define AP_REG_APB2_ENABLE 0xA8
> +#define AP_REG_MEM_ENABLE 0xB4
> +#define AP_REG_APO_ENABLE 0xC0
> +
> +/* AP Clk Config Bits */
> +#define AP_PERI_SRC_DIV BIT(12)
> +
> +/* UART Clock Bits */
> +#define AP_UART_DIVIDER GENMASK(9, 0)
> +#define AP_UART_SET_PLL BIT(12)
> +
> +/* AP Clk Enable */
> +#define AP_ENABLE_CPU_CORE BIT(0)
> +#define AP_ENABLE_CPU_DUMMY BIT(1)
> +#define AP_ENABLE_AHB0_CONF BIT(0)
> +#define AP_ENABLE_APB0_CONF BIT(1)
> +#define AP_ENABLE_AXI_VOC  BIT(2)
> +#define AP_ENABLE_AXI_DMA  BIT(3)
> +#define AP_ENABLE_AXI_ALWAYS BIT(4)
> +#define AP_ENABLE_AXI_CONNECT BIT(5)
> +#define AP_ENABLE_APB0_IRQ BIT(6)
> +#define AP_ENABLE_AXIDIV2_IMEM BIT(0)
> +#define AP_ENABLE_AXIDIV2_ALWAYS BIT(1)
> +#define AP_ENABLE_AXIDIV2_CONNECT BIT(2)
> +#define AP_ENABLE_AXIDIV2_VPU BIT(3)
> +#define AP_ENABLE_GCG_APB_CONF BIT(0)
> +#define AP_ENABLE_GCG_GOUDA BIT(1)
> +#define AP_ENABLE_GCG_CAMERA BIT(2)
> +#define AP_ENABLE_GCG_ALWAYS BIT(3)
> +#define AP_ENABLE_GCG_CONNECT BIT(4)
> +#define AP_ENABLE_GCG_DPI BIT(7)
> +#define AP_ENABLE_AHB1_USBC BIT(0)
> +#define AP_ENABLE_AHB1_ALWAYS BIT(1)
> +#define AP_ENABLE_AHB1_SPIFLASH BIT(2)
> +#define AP_ENABLE_APB1_CONF BIT(0)
> +#define AP_ENABLE_APB1_AIF BIT(1)
> +#define AP_ENABLE_APB1_AUIFC BIT(2)
> +#define AP_ENABLE_APB1_AUIFC_CH0 BIT(3)
> +#define AP_ENABLE_APB1_AUIFC_CH1 BIT(4)
> +#define AP_ENABLE_APB1_I2C1 BIT(5)
> +#define AP_ENABLE_APB1_I2C2 BIT(6)
> +#define AP_ENABLE_APB1_I2C3 BIT(7)
> +#define AP_ENABLE_APB1D_OSC BIT(8)
> +#define AP_ENABLE_APB1D_PWM BIT(9)
> +#define AP_ENABLE_APB1_ALWAYS BIT(10)
> +#define AP_ENABLE_APB1_DAPLITE BIT(11)
> +#define AP_ENABLE_APB1_TIMER BIT(12)
> +#define AP_ENABLE_APB1_GPIO BIT(13)
> +#define AP_ENABLE_APB2_CONF BIT(0)
> +#define AP_ENABLE_APB2_IFC BIT(1)
> +#define AP_ENABLE_APB2_IFC_CH0 BIT(2)
> +#define AP_ENABLE_APB2_IFC_CH1 BIT(3)
> +#define AP_ENABLE_APB2_IFC_CH2 BIT(4)
> +#define AP_ENABLE_APB2_IFC_CH3 BIT(5)
> +#define AP_ENABLE_APB2_IFC_CH4 BIT(6)
> +#define AP_ENABLE_APB2_IFC_CH5 BIT(7)
> +#define AP_ENABLE_APB2_IFC_CH6 BIT(8)
> +#define AP_ENABLE_APB2_IFC_CH7 BIT(9)
> +#define AP_ENABLE_APB2_UART1 BIT(10)
> +#define AP_ENABLE_APB2_UART2 BIT(11)
> +#define AP_ENABLE_APB2_UART3 BIT(12)
> +#define AP_ENABLE_APB2_SPI1 BIT(13)
> +#define AP_ENABLE_APB2_SPI2 BIT(14)
> +#define AP_ENABLE_APB2_SPI3 BIT(15)
> +#define AP_ENABLE_APB2_SDMMC1 BIT(16)
> +#define AP_ENABLE_APB2_SDMMC2 BIT(17)
> +#define AP_ENABLE_APB2_SDMMC3 BIT(18)
> +#define AP_ENABLE_APB2_ALWAYS BIT(19)
> +#define AP_ENABLE_APB2_NANDFLASH BIT(20)
> +#define AP_ENABLE_MEM_CONF BIT(0)
> +#define AP_ENABLE_MEM_DMC  BIT(1)
> +#define AP_ENABLE_MEM_GPU  BIT(2)
> +#define AP_ENABLE_MEM_VPU  BIT(3)
> +#define AP_ENABLE_MEM_DDRPHY_P BIT(4)
> +#define AP_ENABLE_MEM_CONNECT BIT(5)
> +#define AP_ENABLE_APOC_VPU BIT(0)
> +#define AP_ENABLE_APOC_BCK BIT(1)
> +#define AP_ENABLE_APOC_UART1 BIT(2)
> +#define AP_ENABLE_APOC_UART2 BIT(3)
> +#define AP_ENABLE_APOC_UART3 BIT(4)
> +#define AP_ENABLE_APOC_VOC_CORE BIT(5)
> +#define AP_ENABLE_APOC_VOC BIT(6)
> +#define AP_ENABLE_APOC_VOC_ALWAYS BIT(7)
> +#define AP_ENABLE_APOC_DDRPHY_N BIT(8)
> +#define AP_ENABLE_APOC_DDRPHY2XP BIT(9)
> +#define AP_ENABLE_APOC_DDRPHY2XN BIT(10)
> +#define AP_ENABLE_APOC_GPU BIT(11)
> +#define AP_ENABLE_APOC_USBPHY BIT(12)
> +#define AP_ENABLE_APOC_CSI BIT(13)
> +#define AP_ENABLE_APOC_DSI BIT(14)
> +#define AP_ENABLE_APOC_GPIO BIT(15)
> +#define AP_ENABLE_APOC_SPIFLASH BIT(16)
> +#define AP_ENABLE_APOC_PIX BIT(17)
> +#define AP_ENABLE_APOC_PDGB BIT(18)
> +
> +/* AP Reset */
> +#define AP_RST_CPU_REG 0x1C
> +#define AP_RST_AXI_REG 0x24
> +#define AP_RST_AXIDIV2_REG 0x2C
> +#define AP_RST_GCG_REG 0x34
> +#define AP_RST_AHB1_REG 0x3C
> +#define AP_RST_APB1_REG 0x44
> +#define AP_RST_APB2_REG 0x4C
> +#define AP_RST_MEM_REG 0x54
> +
> +/* Bits */
> +#define AP_RST_CPU_CORE BIT(0)
> +#define AP_RST_CPU_SYS BIT(1)

Please add tabs because this is really hard to read when the define is
one space away from the definition.

> +#define AP_RST_AXI_VOC BIT(0)
> +#define AP_RST_AXI_DMA BIT(1)
> +#define AP_RST_AXI_SYS BIT(2)
> +#define AP_RST_AXI_CONNECT BIT(3)
> +#define AP_RST_AXI_VPU BIT(5)
> +#define AP_RST_AXIDIV2_IMEM BIT(0)
> +#define AP_RST_AXIDIV2_SYS BIT(1)
> +#define AP_RST_AXIDIV2_VPU BIT(2)
> +#define AP_RST_GCG_SYS BIT(0)
> +#define AP_RST_GCG_GOUDA BIT(1)
> +#define AP_RST_GCG_CAMERA BIT(2)
> +#define AP_RST_GCG_LCDC BIT(4)
> +#define AP_RST_AHB1_SYS BIT(0)
> +#define AP_RST_AHB1_USBC BIT(1)
> +#define AP_RST_AHB1_SPIFLASH BIT(2)
> +#define AP_RST_APB1_SYS BIT(0)
> +#define AP_RST_APB1_TIMER BIT(1)
> +#define AP_RST_APB1_KEYPAD BIT(2)
> +#define AP_RST_APB1_GPIO BIT(3)
> +#define AP_RST_APB1_PWM BIT(4)
> +#define AP_RST_APB1_AIF BIT(5)
> +#define AP_RST_APB1_AUIFC BIT(6)
> +#define AP_RST_APB1_I2C1 BIT(7)
> +#define AP_RST_APB1_I2C2 BIT(8)
> +#define AP_RST_APB1_I2C3 BIT(9)
> +#define AP_RST_APB1_COMREGS BIT(10)
> +#define AP_RST_APB1_DMC BIT(11)
> +#define AP_RST_APB1_DDRPHY_P BIT(12)
> +#define AP_RST_APB2_SYS BIT(0)
> +#define AP_RST_APB2_IFC BIT(1)
> +#define AP_RST_APB2_UART1 BIT(2)
> +#define AP_RST_APB2_UART2 BIT(3)
> +#define AP_RST_APB2_UART3 BIT(4)
> +#define AP_RST_APB2_SPI1 BIT(5)
> +#define AP_RST_APB2_SPI2 BIT(6)
> +#define AP_RST_APB2_SPI3 BIT(7)
> +#define AP_RST_APB2_SDMMC1 BIT(8)
> +#define AP_RST_APB2_SDMMC2 BIT(9)
> +#define AP_RST_APB2_SDMMC3 BIT(10)
> +#define AP_RST_APB2_NANDFLASH BIT(11)
> +#define AP_RST_MEM_SYS BIT(0)
> +#define AP_RST_MEM_GPU BIT(1)
> +#define AP_RST_MEM_VPU BIT(2)
> +#define AP_RST_MEM_DMC BIT(3)
> +#define AP_RST_MEM_DDRPHY_P BIT(4)
> +
> +/* Default PLL frequency */
> +#define AP_PLL_CPU_FREQ (988 * MHZ)
> +#define AP_PLL_BUS_FREQ (800 * MHZ)
> +#define AP_PLL_MEM_FREQ (260 * MHZ)
> +#define AP_PLL_USB_FREQ (480 * MHZ)

Are these inputs to the clk controller? Can we get these values from
fixed rate clk nodes in the DT instead of hard coding the rates in this
driver, especially if this is controllable outside of this device?

> +
> +struct rda8810_reset_list {
> +       int reg;
> +       int bit;

Why signed?

> +};
> +
> +struct rda_clk_priv {
> +       struct device *dev;
> +       struct regmap *regmap;
> +       struct clk_hw_onecell_data *onecell;
> +       struct reset_controller_dev rstctl;
> +       const struct rda8810_reset_list *rstlist;
> +};
> +
> +struct rda_clk_hw {
> +       int id;
> +       int reg;

Why signed?

> +       struct clk_hw hw;
> +
> +       int ena_reg;
> +       int ena_bit;

Why signed? Are they offsets? Use u32 or u8?

> +
> +       struct rda_clk_priv *priv;
> +};
> +
> +struct rda_clk_matchdata {
> +       const struct rda_clk_hw *clk_list;
> +       int max_clocks;
> +};
> +
> +static const struct clk_ops rda8810_clk_ops;

Presumably this can be defined instead of forward declared and then the
clk data can follow the functions?

> +
> +#define RDA_CLK_INIT(_id, _name, _parent, _flags, _reg, _ena_reg, _ena_b=
it) { \
> +       .id =3D _id, \
> +       .reg =3D _reg, \
> +       .ena_reg =3D _ena_reg, \
> +       .ena_bit =3D _ena_bit, \
> +       .hw.init =3D CLK_HW_INIT_PARENTS_DATA(_name, \
> +                       _parent, \
> +                       &rda8810_clk_ops, \
> +                       _flags) \
> +}
> +
> +#define RDA_CLK_INIT_NO_PARENT(_id, _name, _flags, _reg, _ena_reg, _ena_=
bit) { \
> +       .id =3D _id, \
> +       .reg =3D _reg, \
> +       .ena_reg =3D _ena_reg, \
> +       .ena_bit =3D _ena_bit, \
> +       .hw.init =3D CLK_HW_INIT_NO_PARENT(_name, &rda8810_clk_ops, _flag=
s) \
> +}
> +
> +#define to_rda_rst(p) container_of(p, struct rda_clk_priv, rstctl)
> +
> +static inline struct rda_clk_hw *to_rda_hw(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct rda_clk_hw, hw);
> +}
> +
> +/* clock division value map */
> +static const u8 clk_div_map[] =3D {
> +       4*60,   /* 0 */

Maybe
	[0 .. 7] =3D 4 * 60,
	[8] =3D 4 * 40,

etc. so the comment isn't needed and it is shorter.

> +       4*60,   /* 1 */
> +       4*60,   /* 2 */
> +       4*60,   /* 3 */
> +       4*60,   /* 4 */
> +       4*60,   /* 5 */
> +       4*60,   /* 6 */
> +       4*60,   /* 7 */
> +       4*40,   /* 8 */
> +       4*30,   /* 9 */
> +       4*24,   /* 10 */
> +       4*20,   /* 11 */
> +       4*17,   /* 12 */
> +       4*15,   /* 13 */
> +       4*13,   /* 14 */
> +       4*12,   /* 15 */
> +       4*11,   /* 16 */
> +       4*10,   /* 17 */
> +       4*9,    /* 18 */
> +       4*8,    /* 19 */
> +       4*7,    /* 20 */
> +       4*13/2, /* 21 */
> +       4*6,    /* 22 */
> +       4*11/2, /* 23 */
> +       4*5,    /* 24 */
> +       4*9/2,  /* 25 */
> +       4*4,    /* 26 */
> +       4*7/2,  /* 27 */
> +       4*3,    /* 28 */
> +       4*5/2,  /* 29 */
> +       4*2,    /* 30 */
> +       4*1,    /* 31 */
> +};
> +
> +static u32 apsys_get_divreg(u32 basefreq, u32 reqfreq, u32 *pdiv2)
> +{
> +       int i;
> +       int index;
> +       u32 adiv;
> +       u32 ndiv;
> +
> +       adiv =3D basefreq / (reqfreq >> 2);
> +       if (pdiv2) {
> +               /* try div2 mode first */
> +               ndiv =3D adiv >> 1;
> +       } else {
> +               ndiv =3D adiv;
> +       }
> +
> +       for (i =3D ARRAY_SIZE(clk_div_map) - 1; i >=3D 1; i--)
> +               if (ndiv < ((clk_div_map[i] + clk_div_map[i-1]) >> 1))
> +                       break;
> +       index =3D i;
> +
> +       if (pdiv2) {
> +               if (adiv =3D=3D (clk_div_map[index] << 1)) {
> +                       /* div2 mode is OK */
> +                       *pdiv2 =3D 1;
> +               } else {
> +                       /* try div1 mode */
> +                       for (i =3D ARRAY_SIZE(clk_div_map) - 1; i >=3D 1;=
 i--)
> +                               if (adiv < ((clk_div_map[i] + clk_div_map=
[i-1]) >> 1))
> +                                       break;
> +                       /* compare the results between div1 and div2 */
> +                       if (abs(adiv - (clk_div_map[index] << 1)) <=3D
> +                                       abs(adiv - clk_div_map[i])) {
> +                               *pdiv2 =3D 1;
> +                       } else {
> +                               *pdiv2 =3D 0;
> +                               index =3D i;
> +                       }
> +               }
> +       }
> +
> +       return index;
> +}
> +
> +static u32 apsys_cal_freq_by_divreg(u32 basefreq, u32 reg, u32 div2)
> +{
> +       u32 newfreq;
> +
> +       if (reg >=3D ARRAY_SIZE(clk_div_map))
> +               reg =3D ARRAY_SIZE(clk_div_map) - 1;
> +
> +       /* Assuming basefreq is smaller than 2^31 (2.147G Hz) */
> +       newfreq =3D (basefreq << (div2 ? 0 : 1)) / (clk_div_map[reg] >> 1=
);
> +       return newfreq;
> +}
> +
> +static void apsys_get_reg_div(struct rda_clk_hw *rda_hw, u32 *reg, u32 *=
div2)
> +{
> +       struct rda_clk_priv *priv =3D rda_hw->priv;
> +       int tmp_reg, tmp_div2;
> +       int ret;
> +
> +       ret =3D regmap_read(priv->regmap, rda_hw->reg, &tmp_reg);
> +       if (ret)
> +               return;
> +
> +       tmp_div2 =3D tmp_reg & AP_PERI_SRC_DIV;
> +
> +       *reg =3D tmp_reg;
> +       *div2 =3D tmp_div2;
> +}
> +
> +static int apsys_get_uart_clock(unsigned long parent_rate, u32 *reg)
> +{
> +       int clksrc =3D 26000000;
> +       u32 div;
> +       int rate =3D 0;
> +
> +       if (*reg & AP_UART_SET_PLL)
> +               clksrc =3D parent_rate / 8;
> +
> +       div =3D FIELD_GET(AP_UART_DIVIDER, *reg);
> +
> +       /* rate =3D clksrc / divmode / (div+2) */
> +       rate =3D  clksrc / 4 / (div + 2);

Maybe

	const unsigned int divmode =3D 4;

	rate =3D clksrc / divmode / (div + 2);

and then the comment is unnecessary.

> +
> +       return rate;
> +}
> +
> +static int apsys_cal_uart_clock(int freq)
> +{
> +       int new_freq =3D freq;
> +
> +       /*
> +        * To calculate maximum clock:
> +        *     freq =3D 26 MHz / div / (0 + 2)
> +        *
> +        * For lowest clock:
> +        *     freq =3D 26 MHz / div / (0x3FF + 2)
> +        */
> +       if (freq > 3250000)
> +               new_freq =3D 3250000;
> +       else if (freq < 6342)
> +               new_freq =3D 6342;

Use clamp()

> +
> +       new_freq =3D (26000000 + 4 / 2 * new_freq) / (4 * new_freq) - 2;
> +
> +       return new_freq;
> +}
> +
> +static int rda8810_clk_set_rate(struct clk_hw *clk, unsigned long rate,
> +               unsigned long parent_rate)
> +{
> +       struct rda_clk_hw *rda_hw =3D to_rda_hw(clk);
> +       struct rda_clk_priv *priv =3D rda_hw->priv;
> +       struct device *dev =3D priv->dev;
> +       int val, div2 =3D 0;
> +       int ret;
> +
> +       switch (rda_hw->id) {
> +       case CLK_CPU:
> +               val =3D apsys_get_divreg(AP_PLL_CPU_FREQ, rate, NULL);
> +               break;
> +       case CLK_AXI:
> +       case CLK_AHB1:
> +       case CLK_APB1:
> +       case CLK_APB2:
> +       case CLK_GCG:
> +       case CLK_GPU:
> +       case CLK_SFLSH:
> +       case CLK_VOC:
> +       case CLK_VPU:
> +               val =3D apsys_get_divreg(parent_rate, rate, &div2);
> +               break;
> +       case CLK_UART1:
> +       case CLK_UART2:
> +       case CLK_UART3:
> +               val =3D apsys_cal_uart_clock(rate);
> +               if (val =3D=3D 0)
> +                       return -EINVAL;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (div2)
> +               val |=3D AP_PERI_SRC_DIV;
> +
> +       dev_dbg(dev, "clk_id: %d - rate: %ld - parent rate: %ld - val: %d=
 - div: %d\n",
> +                       rda_hw->id, rate, parent_rate, val, div2);
> +
> +       ret =3D regmap_write(priv->regmap, rda_hw->reg, val);
> +       if (ret < 0)
> +               return ret;
> +
> +       return rate;
> +}
> +
> +static unsigned long rda8810_clk_recalc_rate(struct clk_hw *clk,
> +               unsigned long parent_rate)
> +{
> +       struct rda_clk_hw *rda_hw =3D to_rda_hw(clk);
> +       u32 reg, div2;
> +
> +       apsys_get_reg_div(rda_hw, &reg, &div2);
> +
> +       switch (rda_hw->id) {
> +       case CLK_CPU:
> +               return apsys_cal_freq_by_divreg(AP_PLL_CPU_FREQ, reg, 0);
> +       case CLK_BUS:
> +               return AP_PLL_BUS_FREQ;
> +       case CLK_MEM:
> +               return AP_PLL_MEM_FREQ >> (2 + div2);
> +       /* Bus peripherals */
> +       case CLK_USB:
> +               return AP_PLL_USB_FREQ;
> +       case CLK_AXI:
> +       case CLK_AHB1:
> +       case CLK_APB1:
> +       case CLK_APB2:
> +       case CLK_GCG:
> +       case CLK_GPU:
> +       case CLK_SFLSH:
> +       case CLK_VOC:
> +       case CLK_VPU:
> +               return apsys_cal_freq_by_divreg(parent_rate, reg, div2);
> +       /* For UART clocks, we'll have to do more calculation */
> +       case CLK_UART1:
> +       case CLK_UART2:
> +       case CLK_UART3:
> +               return apsys_get_uart_clock(parent_rate, &reg);
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static long rda8810_clk_round_rate(struct clk_hw *clk, unsigned long rat=
e,
> +               unsigned long *parent_rate)
> +{
> +       return rate;
> +}
> +
> +static int rda8810_clk_enable(struct clk_hw *clk)
> +{
> +       struct rda_clk_hw *rda_hw =3D to_rda_hw(clk);
> +       struct rda_clk_priv *priv =3D rda_hw->priv;
> +
> +       if (rda_hw->ena_reg < 0 || rda_hw->ena_bit < 0)
> +               return 0;
> +
> +       return regmap_write(priv->regmap, rda_hw->ena_reg, rda_hw->ena_bi=
t);
> +}
> +
> +static void rda8810_clk_disable(struct clk_hw *clk)
> +{
> +       struct rda_clk_hw *rda_hw =3D to_rda_hw(clk);
> +       struct rda_clk_priv *priv =3D rda_hw->priv;
> +
> +       if (rda_hw->ena_reg < 0 || rda_hw->ena_bit < 0)
> +               return;
> +
> +       regmap_write(priv->regmap, rda_hw->ena_reg + 4, rda_hw->ena_bit);
> +}
> +
> +static const struct clk_ops rda8810_clk_ops =3D {
> +       .enable =3D rda8810_clk_enable,
> +       .disable =3D rda8810_clk_disable,
> +
> +       .recalc_rate =3D rda8810_clk_recalc_rate,
> +       .round_rate =3D rda8810_clk_round_rate,
> +       .set_rate =3D rda8810_clk_set_rate,
> +};
> +
> +/* Root clocks */
> +static struct rda_clk_hw rda8810_clk_cpu_desc =3D
> +RDA_CLK_INIT_NO_PARENT(CLK_CPU, "cpu", CLK_IS_CRITICAL, 0xC8,
> +               AP_REG_CPU_ENABLE, AP_ENABLE_CPU_CORE);
> +static struct rda_clk_hw rda8810_clk_mem_desc =3D
> +RDA_CLK_INIT_NO_PARENT(CLK_MEM, "mem", CLK_IS_CRITICAL, 0xE0, -1, -1);
> +
> +static struct rda_clk_hw rda8810_clk_bus_desc =3D
> +RDA_CLK_INIT_NO_PARENT(CLK_BUS, "bus", CLK_IS_CRITICAL, -1, -1, -1);

If they're critical can we just enabled them once in probe and not make
structures in memory that are basically useless?

> +
> +/* Bus clocks */
> +static struct rda_clk_hw rda8810_clk_usb_desc =3D RDA_CLK_INIT(CLK_USB, =
"usb",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, -1, -1, -1);
> +static struct rda_clk_hw rda8810_clk_axi_desc =3D RDA_CLK_INIT(CLK_AXI, =
"axi",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, 0xCC, -1, -1);
> +static struct rda_clk_hw rda8810_clk_gcg_desc =3D RDA_CLK_INIT(CLK_GCG, =
"gcg",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, 0xD0, -1, -1);
> +static struct rda_clk_hw rda8810_clk_ahb1_desc =3D RDA_CLK_INIT(CLK_AHB1=
, "ahb1",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, 0xD4, -1, -1);
> +static struct rda_clk_hw rda8810_clk_apb1_desc =3D RDA_CLK_INIT(CLK_APB1=
, "apb1",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, 0xD8, -1, -1);
> +static struct rda_clk_hw rda8810_clk_apb2_desc =3D RDA_CLK_INIT(CLK_APB2=
, "apb2",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, 0xDC, -1, -1);
> +static struct rda_clk_hw rda8810_clk_gpu_desc =3D RDA_CLK_INIT(CLK_GPU, =
"gpu",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, 0xE4, AP_REG_APO_ENABLE, AP_ENABLE_APOC_GPU);
> +static struct rda_clk_hw rda8810_clk_vpu_desc =3D RDA_CLK_INIT(CLK_VPU, =
"vpu",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, 0xE8, AP_REG_APO_ENABLE, AP_ENABLE_APOC_VPU);
> +static struct rda_clk_hw rda8810_clk_voc_desc =3D RDA_CLK_INIT(CLK_VOC, =
"voc",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_bus_desc.hw } },
> +               0, 0xEC, AP_REG_APO_ENABLE,
> +               AP_ENABLE_APOC_VOC | AP_ENABLE_APOC_VOC_CORE | AP_ENABLE_=
APOC_VOC_ALWAYS);
> +
> +/* APB1 peripherals */
> +static struct rda_clk_hw rda8810_clk_spiflash_desc =3D RDA_CLK_INIT(CLK_=
SFLSH, "spiflash",
> +               (const struct clk_parent_data[]) { { .hw =3D &rda8810_clk=
_apb1_desc.hw } },
> +               0, 0xF0, AP_REG_APO_ENABLE, AP_ENABLE_APOC_SPIFLASH);
> +
> +/* APB2 peripherals */
> +static struct rda_clk_hw rda8810_clk_uart_desc[] =3D {
> +       RDA_CLK_INIT(CLK_UART1, "uart1",
> +                       (const struct clk_parent_data[]) { { .hw =3D &rda=
8810_clk_apb2_desc.hw } },

If the only parent is a clk_hw pointer please use clk_hws in struct
clk_init_data instead of parent_data.

> +                       0, 0xF4,
> +                       AP_REG_APO_ENABLE, AP_ENABLE_APOC_UART1),
> +       RDA_CLK_INIT(CLK_UART2, "uart2",
> +                       (const struct clk_parent_data[]) { { .hw =3D &rda=
8810_clk_apb2_desc.hw } },
> +                       0, 0xF8,
> +                       AP_REG_APO_ENABLE, AP_ENABLE_APOC_UART2),
> +       RDA_CLK_INIT(CLK_UART3, "uart3",
> +                       (const struct clk_parent_data[]) { { .hw =3D &rda=
8810_clk_apb2_desc.hw } },
> +                       0, 0xFC,
> +                       AP_REG_APO_ENABLE, AP_ENABLE_APOC_UART3),
> +};
> +
> +static struct rda_clk_hw *const rda8810_clk_list[] =3D {
> +       &rda8810_clk_cpu_desc,
> +       &rda8810_clk_bus_desc,
> +       &rda8810_clk_mem_desc,
> +
> +       &rda8810_clk_usb_desc,
> +       &rda8810_clk_axi_desc,
> +       &rda8810_clk_gcg_desc,
> +       &rda8810_clk_ahb1_desc,
> +       &rda8810_clk_apb1_desc,
> +       &rda8810_clk_apb2_desc,
> +
> +       &rda8810_clk_gpu_desc,
> +       &rda8810_clk_vpu_desc,
> +       &rda8810_clk_voc_desc,
> +
> +       &rda8810_clk_spiflash_desc,
> +
> +       &rda8810_clk_uart_desc[0],
> +       &rda8810_clk_uart_desc[1],
> +       &rda8810_clk_uart_desc[2],
> +};
> +
> +static const struct rda8810_reset_list rda8810_rst_data[] =3D {
> +       /* ID, REG */
> +
> +       /* CPU */
> +       [RST_CPU] =3D { AP_RST_CPU_REG, AP_RST_CPU_CORE },
> +
> +       /* AXI */
> +       [RST_AXI_VOC] =3D { AP_RST_AXI_REG, AP_RST_AXI_VOC },
> +       [RST_AXI_DMA] =3D { AP_RST_AXI_REG, AP_RST_AXI_DMA },
> +       [RST_AXI_CONNECT] =3D { AP_RST_AXI_REG, AP_RST_AXI_CONNECT },
> +       [RST_AXI_VPU] =3D { AP_RST_AXI_REG, AP_RST_AXI_VPU },
> +
> +       /* GCG */
> +       [RST_GCG_GOUDA] =3D { AP_RST_GCG_REG, AP_RST_GCG_GOUDA },
> +       [RST_GCG_CAMERA] =3D { AP_RST_GCG_REG, AP_RST_GCG_CAMERA },
> +       [RST_GCG_LCDC] =3D { AP_RST_GCG_REG, AP_RST_GCG_LCDC },
> +
> +       /* AHB1 */
> +       [RST_AHB1_USBC] =3D { AP_RST_AHB1_REG, AP_RST_AHB1_USBC },
> +       [RST_AHB1_SPIFLASH] =3D { AP_RST_AHB1_REG, AP_RST_AHB1_SPIFLASH },
> +
> +       /* APB1 */
> +       [RST_APB1_TIMER] =3D { AP_RST_APB1_REG, AP_RST_APB1_TIMER },
> +       [RST_APB1_KEYPAD] =3D { AP_RST_APB1_REG, AP_RST_APB1_KEYPAD },
> +       [RST_APB1_GPIO] =3D { AP_RST_APB1_REG, AP_RST_APB1_GPIO },
> +       [RST_APB1_PWM] =3D { AP_RST_APB1_REG, AP_RST_APB1_PWM },
> +       [RST_APB1_AIF] =3D { AP_RST_APB1_REG, AP_RST_APB1_AIF },
> +       [RST_APB1_AUIFC] =3D { AP_RST_APB1_REG, AP_RST_APB1_AUIFC },
> +       [RST_APB1_I2C1] =3D { AP_RST_APB1_REG, AP_RST_APB1_I2C1 },
> +       [RST_APB1_I2C2] =3D { AP_RST_APB1_REG, AP_RST_APB1_I2C2 },
> +       [RST_APB1_I2C3] =3D { AP_RST_APB1_REG, AP_RST_APB1_I2C3 },
> +       [RST_APB1_COMREGS] =3D { AP_RST_APB1_REG, AP_RST_APB1_COMREGS },
> +       [RST_APB1_DMC] =3D { AP_RST_APB1_REG, AP_RST_APB1_DMC },
> +       [RST_APB1_DDRPHY_P] =3D { AP_RST_APB1_REG, AP_RST_APB1_DDRPHY_P },
> +
> +       /* APB2 */
> +       [RST_APB2_IFC] =3D { AP_RST_APB2_REG, AP_RST_APB2_IFC },
> +       [RST_APB2_UART1] =3D { AP_RST_APB2_REG, AP_RST_APB2_UART1 },
> +       [RST_APB2_UART2] =3D { AP_RST_APB2_REG, AP_RST_APB2_UART2 },
> +       [RST_APB2_UART3] =3D { AP_RST_APB2_REG, AP_RST_APB2_UART3 },
> +       [RST_APB2_SPI1] =3D { AP_RST_APB2_REG, AP_RST_APB2_SPI1 },
> +       [RST_APB2_SPI2] =3D { AP_RST_APB2_REG, AP_RST_APB2_SPI2 },
> +       [RST_APB2_SPI3] =3D { AP_RST_APB2_REG, AP_RST_APB2_SPI3 },
> +       [RST_APB2_SDMMC1] =3D { AP_RST_APB2_REG, AP_RST_APB2_SDMMC1 },
> +       [RST_APB2_SDMMC2] =3D { AP_RST_APB2_REG, AP_RST_APB2_SDMMC2 },
> +       [RST_APB2_SDMMC3] =3D { AP_RST_APB2_REG, AP_RST_APB2_SDMMC3 },
> +       [RST_APB2_NAND] =3D { AP_RST_APB2_REG, AP_RST_APB2_NANDFLASH },
> +
> +       /* MEM */
> +       [RST_MEM_GPU] =3D { AP_RST_MEM_REG, AP_RST_MEM_GPU },
> +       [RST_MEM_VPU] =3D { AP_RST_MEM_REG, AP_RST_MEM_VPU },
> +       [RST_MEM_DMC] =3D { AP_RST_MEM_REG, AP_RST_MEM_DMC },
> +       [RST_MEM_DDRPHY_P] =3D { AP_RST_MEM_REG, AP_RST_MEM_DDRPHY_P },
> +};
> +
> +static int rda8810_reset_assert(struct reset_controller_dev *rstctl, uns=
igned long id)
> +{
> +       struct rda_clk_priv *priv =3D to_rda_rst(rstctl);
> +
> +       return regmap_write(priv->regmap, rda8810_rst_data[id].reg, rda88=
10_rst_data[id].bit);
> +}
> +
> +static int rda8810_reset_deassert(struct reset_controller_dev *rstctl, u=
nsigned long id)
> +{
> +       struct rda_clk_priv *priv =3D to_rda_rst(rstctl);
> +
> +       return regmap_write(priv->regmap, rda8810_rst_data[id].reg + 4, r=
da8810_rst_data[id].bit);
> +}
> +
> +static const struct reset_control_ops rda8810_rst_ops =3D {
> +       .assert =3D &rda8810_reset_assert,
> +       .deassert =3D &rda8810_reset_deassert,
> +};
> +
> +static int rda8810_clk_register(struct rda_clk_priv *priv)
> +{
> +       struct device *dev =3D priv->dev;
> +       struct clk_hw_onecell_data *onecell_data;
> +       int ret;
> +       int i;
> +
> +       onecell_data =3D devm_kzalloc(dev,
> +                       struct_size(onecell_data, hws, ARRAY_SIZE(rda8810=
_clk_list)),
> +                       GFP_KERNEL);
> +       if (!onecell_data)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(rda8810_clk_list); i++) {
> +               rda8810_clk_list[i]->priv =3D priv;
> +
> +               ret =3D devm_clk_hw_register(dev, &rda8810_clk_list[i]->h=
w);
> +               if (ret) {
> +                       dev_err(dev, "Failed to register clock: %d\n", re=
t);
> +                       return ret;
> +               }
> +               onecell_data->hws[i] =3D &rda8810_clk_list[i]->hw;
> +       }
> +       onecell_data->num =3D i;
> +       priv->onecell =3D onecell_data;
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, on=
ecell_data);
> +}
> +
> +static int rda8810_rst_register(struct rda_clk_priv *priv)
> +{
> +       struct device *dev =3D priv->dev;
> +
> +       priv->rstctl.dev =3D priv->dev;
> +       priv->rstctl.nr_resets =3D RST_COUNT;
> +       priv->rstctl.of_node =3D priv->dev->of_node;
> +       priv->rstctl.ops =3D &rda8810_rst_ops;
> +       priv->rstctl.owner =3D THIS_MODULE;
> +
> +       return devm_reset_controller_register(dev, &priv->rstctl);

Please use auxiliary bus and put the reset driver in drivers/reset/

> +}
> +
> +static int rda8810_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct rda_clk_priv *priv;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return dev_err_probe(dev, -ENOMEM, "Cannot allocate memor=
y\n");

No error messages for allocation failures please. The allocator already
has a more informative message.

> +
> +       priv->dev =3D dev;
> +
> +       priv->regmap =3D syscon_node_to_regmap(dev->of_node);

Why is it a syscon?

> +       if (IS_ERR(priv->regmap))
> +               return dev_err_probe(dev, -ENOMEM, "Cannot initialize reg=
map\n");
> +
> +       ret =3D rda8810_clk_register(priv);
> +       if (ret)
> +               return dev_err_probe(dev, -EINVAL, "Failed to setup clock=
: %d\n", ret);
> +
> +       ret =3D rda8810_rst_register(priv);
> +       if (ret)
> +               return dev_err_probe(dev, -EINVAL, "Failed to setup reset=
: %d\n", ret);
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       return 0;

