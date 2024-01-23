Return-Path: <dmaengine+bounces-804-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD44837E89
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 02:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C1F1C2777E
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F279913AA33;
	Tue, 23 Jan 2024 00:44:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446F5732A;
	Tue, 23 Jan 2024 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970649; cv=none; b=o98KmMWx1IDkIufgHE7xrbLQwZADTQEuU8mXy8sPg2aNNK78h+x5Vn/w/QD1Hu9K/FY3GiIc218WcSwj/OZtJ0q7iWj3vLlxi/41MopvCX3THii+h1MAYKTbtV3b3kX0tL+S5OjkzSr0ZxAta+1PGuk26OqI6QB4q16TYUPMIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970649; c=relaxed/simple;
	bh=EqkaQAa8ngABIEr8F8P6NKP5vlleTQIiI2bXwG/sbHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsxutwFL+0jsx5L42lSYs0r1qJnpuNouwD8J36uFs7JyGHDgHTObIeTvQ2CafcE2nOtLokve0Rc+TMD3g04oljdwDozxqGbB2RZWzTmyDBu6H4dsiWotTJLVB3Ic4K/7wtwt2oGy85JDsNg9xp8Vio0enJ3K+qpfSaXoC6yJmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91A0E1FB;
	Mon, 22 Jan 2024 16:44:52 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A275B3F73F;
	Mon, 22 Jan 2024 16:44:04 -0800 (PST)
Date: Tue, 23 Jan 2024 00:43:15 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: allwinner: h616: Add SPDIF device node
Message-ID: <20240123004315.068adcba@minigeek.lan>
In-Reply-To: <20240122170518.3090814-8-wens@kernel.org>
References: <20240122170518.3090814-1-wens@kernel.org>
	<20240122170518.3090814-8-wens@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 01:05:18 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi,

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The H616 SoC has an SPDIF transmitter hardware block, which has the same
> layout as the one in the H6, minus the receiver side.
> 
> Add a device node for it, and a default pinmux.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Compared the details against the manual, the clock driver, and the
binding, they match:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index a0268439f3be..fd4c080b8e62 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -253,6 +253,11 @@ spi1_cs0_pin: spi1-cs0-pin {
>  				function = "spi1";
>  			};
>  
> +			spdif_tx_pin: spdif-tx-pin {
> +				pins = "PH4";
> +				function = "spdif";
> +			};
> +
>  			uart0_ph_pins: uart0-ph-pins {
>  				pins = "PH0", "PH1";
>  				function = "uart0";
> @@ -550,6 +555,21 @@ mdio0: mdio {
>  			};
>  		};
>  
> +		spdif: spdif@5093000 {
> +			compatible = "allwinner,sun50i-h616-spdif";
> +			reg = <0x05093000 0x400>;
> +			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
> +			clock-names = "apb", "spdif";
> +			resets = <&ccu RST_BUS_SPDIF>;
> +			dmas = <&dma 2>;
> +			dma-names = "tx";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spdif_tx_pin>;
> +			#sound-dai-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		usbotg: usb@5100000 {
>  			compatible = "allwinner,sun50i-h616-musb",
>  				     "allwinner,sun8i-h3-musb";


