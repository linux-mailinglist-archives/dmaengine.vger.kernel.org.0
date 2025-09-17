Return-Path: <dmaengine+bounces-6591-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004AAB7DB29
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B835327250
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 00:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1312153D8;
	Wed, 17 Sep 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7tiI+yJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E01FCF41;
	Wed, 17 Sep 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069792; cv=none; b=AkcwIghmw1BRFk3JAyBvGlAodxGq6y3CwZxiiQBxFy5XJMnDf0SiCoEl0bD1+ULliQajr8X4RXtj5mM59mkM8JhZHZrvrkngo51/0Rw1rPPZ17+4nuy3DwVUe8l8ebPM6FyYdzFqObMup47tQG9gGvBp6kCVZr7Y9KG+Z0BjJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069792; c=relaxed/simple;
	bh=urrfAhMmJ6Kb44KmW9Nxz3cezw7izNitJ3wa7v9K97Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIvmzGCe7AnuTP9kHPqQ2co8Om0W92M2uIP7ST69812oLv7ap5opGL1Xr8zJSyifegrys10gqDlqp4ACxBl56I7zau/EoGTYyFqKvrrehFZpvyEnitSsJF3SebhN32K6rH8sIXZkcr0pIyJ+0RXDdMLa1dj8m2q1QljGF1+cOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7tiI+yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FD7C4CEEB;
	Wed, 17 Sep 2025 00:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758069792;
	bh=urrfAhMmJ6Kb44KmW9Nxz3cezw7izNitJ3wa7v9K97Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u7tiI+yJ5vXDuuZpEd58bRVhwUKvd+vkdWn6eFrbnu9sidFirWqjY8vtV37x2rQy3
	 sxnp1xdAdMX/ZNLQDlz+48/WaJZ9H3KIscwlR025r+O1LqyiQGCsFoG7068ozhyQkO
	 ZpZ8SWL2DSSiXgAAnFYXmXMCHKGEsOop1iW5gTB4f/0sdsaW/PtKBTNZe1m8mE/Zjj
	 lqPAZ/TIgvESg9RWGE8fCRVwqrgcXlptw9a6NADOuwl0LI/MejswHFlyIL5jYC6+zQ
	 BZ4u4qIfexcHzZyzbzjS4a7jbuN/IR+cyUzX0tJ4RtCzOlksNxizaKwA6oD631m/90
	 T9RFMrKnmv4ig==
Message-ID: <8e1f4728-1ba6-4db7-8e04-a8dde165ca72@kernel.org>
Date: Wed, 17 Sep 2025 09:43:05 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/25] dt-bindings: clock: Add RDA Micro RDA8810PL
 clock/reset controller
To: dang.huynh@mainlining.org, Manivannan Sadhasivam <mani@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
 <20250917-rda8810pl-drivers-v1-9-9ca9184ca977@mainlining.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250917-rda8810pl-drivers-v1-9-9ca9184ca977@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2025 22:25, Dang Huynh via B4 Relay wrote:
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"

Use consistent quotes, either ' or "

> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rda,8810pl-apclk.h>
> +
> +    ap_syscon: syscon@0 {
> +      compatible = "rda,8810pl-apsyscon", "syscon";
> +      reg = <0x0 0x1000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/rda,8810pl-apclk.h b/include/dt-bindings/clock/rda,8810pl-apclk.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..372358e72436a28c0775519f49626c9c5f4c6046
> --- /dev/null
> +++ b/include/dt-bindings/clock/rda,8810pl-apclk.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_RDA8810_H_
> +#define _DT_BINDINGS_CLK_RDA8810_H_
> +
> +/* soc clocks */
> +#define CLK_CPU 0
> +#define CLK_BUS 1
> +#define CLK_MEM 2
> +
> +#define CLK_USB 3
> +#define CLK_AXI 4
> +#define CLK_GCG 5
> +#define CLK_AHB1 6
> +#define CLK_APB1 7
> +#define CLK_APB2 8
> +
> +#define CLK_GPU 9
> +#define CLK_VPU 10
> +#define CLK_VOC 11
> +#define CLK_SFLSH 12
> +
> +#define CLK_UART1 13
> +#define CLK_UART2 14
> +#define CLK_UART3 15
> +
> +#define CLK_VOC2 16
> +#define CLK_EMMC 17
> +
> +#define CLK_COUNT (CLK_EMMC + 1)

Drop, not a binding.

> +
> +/* resets */
> +#define RST_CPU 0


Missing indentation before the values, everywhere.

> +
> +#define RST_AXI_VOC 1
> +#define RST_AXI_DMA 2
> +#define RST_AXI_CONNECT 3
> +#define RST_AXI_VPU 4
> +
> +#define RST_GCG_GOUDA 5
> +#define RST_GCG_CAMERA 6
> +#define RST_GCG_LCDC 7
> +
> +#define RST_AHB1_USBC 8
> +#define RST_AHB1_SPIFLASH 9
> +
> +#define RST_APB1_TIMER 10
> +#define RST_APB1_KEYPAD 11
> +#define RST_APB1_GPIO 12
> +#define RST_APB1_PWM 13
> +#define RST_APB1_AIF 14
> +#define RST_APB1_AUIFC 15
> +#define RST_APB1_I2C1 16
> +#define RST_APB1_I2C2 17
> +#define RST_APB1_I2C3 18
> +#define RST_APB1_COMREGS 19
> +#define RST_APB1_DMC 20
> +#define RST_APB1_DDRPHY_P 21
> +
> +#define RST_APB2_IFC 22
> +#define RST_APB2_UART1 23
> +#define RST_APB2_UART2 24
> +#define RST_APB2_UART3 25
> +#define RST_APB2_SPI1 26
> +#define RST_APB2_SPI2 27
> +#define RST_APB2_SPI3 28
> +#define RST_APB2_SDMMC1 29
> +#define RST_APB2_SDMMC2 30
> +#define RST_APB2_SDMMC3 31
> +#define RST_APB2_NAND 32
> +
> +#define RST_MEM_GPU 33
> +#define RST_MEM_VPU 34
> +#define RST_MEM_DMC 35
> +#define RST_MEM_DDRPHY_P 36
> +
> +#define RST_COUNT (RST_MEM_DDRPHY_P + 1)

Drop, not a binding.

> +
> +#endif /* _DT_BINDINGS_CLK_RDA8810_H_ */
> 


Best regards,
Krzysztof

