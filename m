Return-Path: <dmaengine+bounces-5352-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59577AD515B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C41E02D8
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F10D26A1BB;
	Wed, 11 Jun 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="KAUWvv+C"
X-Original-To: dmaengine@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280AC2367B0;
	Wed, 11 Jun 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636514; cv=pass; b=VmtT0Zh0W3Yk8yCS5mAPAccau24NyzVdHd28lEHz0LKG0uVf8VrHEuIkDV1vS63+D2fr2hoK7Z8iIl9um+9ut69ioW7bU7p1HjXygJuf99DBydtz518NubyaLjPRSFMwK2f6YmvKU5T2r16jklbZUsW+fBQTuFEO13HtmpTJarY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636514; c=relaxed/simple;
	bh=krfXaGWPWeAKxyBQJ3Hwwim48lN8w7H+7UHIhj3U+0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3kzc0mKhH+WcL7yZ38bWAoS9qX0qkQd83YyJ7I62HNEINyzkDd5JIl3HMS2UJAdAM/yG8GFBAvtVdJpIBwXVYue7wAjmwsKKzkcXLQWUZ4Lm/rEYtoPwQOhGBcHFQhZXXrR+IF3RZT2ifKujCanKhY1REI/j9m0EfBcBNA9/Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=KAUWvv+C; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1749636463; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lQfMgKfOmLVOpcLUR/+VhI5pBBYy2/8J2KOx1d6voAV6TOzeR+6bcfYgHTxdeouzw0C7sqKgHyBJU8luD2eQTfNZBVuocJvCodJ+lva4jeyTPCVkVwwFA8y9hqgHoTFHw53PYa2PgwFdBOXowOXJA+8Z7D4b7lYpARqexIozu8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749636463; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wA+1W3QDgotum1F06+IYBuatyuO2UnnGGcdD3JcEpmY=; 
	b=LCyvGF7zjpp7j+gJg/fe4Q0AraW1IGlC/Dyon5oONqBCVlfOsEBi24z9vv90detXzW1Qrn4mCRvXf3RC9mCMcbSOnQddRTvN+CQVGu75CD8HEzAvB+mzqVjK02fcpDsfx0SXNLn2+EAEfuI7cNkB23aBHCsw76am/vdPT5vtH4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749636463;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wA+1W3QDgotum1F06+IYBuatyuO2UnnGGcdD3JcEpmY=;
	b=KAUWvv+CTibdRGx8zsnTanoPkINanbET+iB/y6jswbIToOCWONTi6R2tbI2L0gFV
	tHkbdSUlYCIvUhw5VYFgueXW5slaN4NFbZJIfT+D5BG6cpZpwLphv5vl1pgtUL8Xrkf
	QeofLTigqI29/mspdElMSPNht+7lCys2p6tjVGL8=
Received: by mx.zohomail.com with SMTPS id 1749636461743401.7062159364368;
	Wed, 11 Jun 2025 03:07:41 -0700 (PDT)
Message-ID: <bf41966c-cda2-4767-b9a5-5bf4db7f21b6@pigmoral.tech>
Date: Wed, 11 Jun 2025 18:07:30 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] riscv: dts: sophgo: add reset generator for Sophgo
 CV1800 series SoC
To: Inochi Amaoto <inochiama@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vinod Koul <vkoul@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dmaengine@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20250611075321.1160973-1-inochiama@gmail.com>
 <20250611075321.1160973-4-inochiama@gmail.com>
From: Junhui Liu <junhui.liu@pigmoral.tech>
In-Reply-To: <20250611075321.1160973-4-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 2025/6/11 15:53, Inochi Amaoto wrote:
> Add reset generator node for all CV18XX series SoC.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Test RST_CPUSYS2 ok with the C906L remoteproc driver. Thanks!

Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>

> ---
>   arch/riscv/boot/dts/sophgo/cv180x.dtsi    |  7 ++
>   arch/riscv/boot/dts/sophgo/cv18xx-reset.h | 98 +++++++++++++++++++++++
>   2 files changed, 105 insertions(+)
>   create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-reset.h
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> index ed06c3609fb2..4c3d16764131 100644
> --- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> @@ -7,6 +7,7 @@
>   #include <dt-bindings/clock/sophgo,cv1800.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include "cv18xx-reset.h"
>   
>   / {
>   	#address-cells = <1>;
> @@ -24,6 +25,12 @@ soc {
>   		#size-cells = <1>;
>   		ranges;
>   
> +		rst: reset-controller@3003000 {
> +			compatible = "sophgo,cv1800b-reset";
> +			reg = <0x3003000 0x1000>;
> +			#reset-cells = <1>;
> +		};
> +
>   		gpio0: gpio@3020000 {
>   			compatible = "snps,dw-apb-gpio";
>   			reg = <0x3020000 0x1000>;
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx-reset.h b/arch/riscv/boot/dts/sophgo/cv18xx-reset.h
> new file mode 100644
> index 000000000000..7e7c5ca2dbbd
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx-reset.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (C) 2025 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +#ifndef _SOPHGO_CV18XX_RESET
> +#define _SOPHGO_CV18XX_RESET
> +
> +#define RST_DDR				2
> +#define RST_H264C			3
> +#define RST_JPEG			4
> +#define RST_H265C			5
> +#define RST_VIPSYS			6
> +#define RST_TDMA			7
> +#define RST_TPU				8
> +#define RST_TPUSYS			9
> +#define RST_USB				11
> +#define RST_ETH0			12
> +#define RST_ETH1			13
> +#define RST_NAND			14
> +#define RST_EMMC			15
> +#define RST_SD0				16
> +#define RST_SDMA			18
> +#define RST_I2S0			19
> +#define RST_I2S1			20
> +#define RST_I2S2			21
> +#define RST_I2S3			22
> +#define RST_UART0			23
> +#define RST_UART1			24
> +#define RST_UART2			25
> +#define RST_UART3			26
> +#define RST_I2C0			27
> +#define RST_I2C1			28
> +#define RST_I2C2			29
> +#define RST_I2C3			30
> +#define RST_I2C4			31
> +#define RST_PWM0			32
> +#define RST_PWM1			33
> +#define RST_PWM2			34
> +#define RST_PWM3			35
> +#define RST_SPI0			40
> +#define RST_SPI1			41
> +#define RST_SPI2			42
> +#define RST_SPI3			43
> +#define RST_GPIO0			44
> +#define RST_GPIO1			45
> +#define RST_GPIO2			46
> +#define RST_EFUSE			47
> +#define RST_WDT				48
> +#define RST_AHB_ROM			49
> +#define RST_SPIC			50
> +#define RST_TEMPSEN			51
> +#define RST_SARADC			52
> +#define RST_COMBO_PHY0			58
> +#define RST_SPI_NAND			61
> +#define RST_SE				62
> +#define RST_UART4			74
> +#define RST_GPIO3			75
> +#define RST_SYSTEM			76
> +#define RST_TIMER			77
> +#define RST_TIMER0			78
> +#define RST_TIMER1			79
> +#define RST_TIMER2			80
> +#define RST_TIMER3			81
> +#define RST_TIMER4			82
> +#define RST_TIMER5			83
> +#define RST_TIMER6			84
> +#define RST_TIMER7			85
> +#define RST_WGN0			86
> +#define RST_WGN1			87
> +#define RST_WGN2			88
> +#define RST_KEYSCAN			89
> +#define RST_AUDDAC			91
> +#define RST_AUDDAC_APB			92
> +#define RST_AUDADC			93
> +#define RST_VCSYS			95
> +#define RST_ETHPHY			96
> +#define RST_ETHPHY_APB			97
> +#define RST_AUDSRC			98
> +#define RST_VIP_CAM0			99
> +#define RST_WDT1			100
> +#define RST_WDT2			101
> +#define RST_AUTOCLEAR_CPUCORE0		256
> +#define RST_AUTOCLEAR_CPUCORE1		257
> +#define RST_AUTOCLEAR_CPUCORE2		258
> +#define RST_AUTOCLEAR_CPUCORE3		259
> +#define RST_AUTOCLEAR_CPUSYS0		260
> +#define RST_AUTOCLEAR_CPUSYS1		261
> +#define RST_AUTOCLEAR_CPUSYS2		262
> +#define RST_CPUCORE0			288
> +#define RST_CPUCORE1			289
> +#define RST_CPUCORE2			290
> +#define RST_CPUCORE3			291
> +#define RST_CPUSYS0			292
> +#define RST_CPUSYS1			293
> +#define RST_CPUSYS2			294
> +
> +#endif /* _SOPHGO_CV18XX_RESET */

-- 
Best regards,
Junhui Liu


