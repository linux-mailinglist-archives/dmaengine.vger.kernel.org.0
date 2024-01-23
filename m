Return-Path: <dmaengine+bounces-801-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3B837E26
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 02:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC751F2466A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 01:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4A5B217;
	Tue, 23 Jan 2024 00:40:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266459154;
	Tue, 23 Jan 2024 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970413; cv=none; b=fVjv9ev4QIHqAoY/Xst76433zEzCT77y+D5MF7tdB/K6T5FNLuJyKmcHkP67FS7IsLI5iPlNe0A/ElsS6LLaZeQGlBQcdikzSuMyE9GOesjFQ+Rq8OAJtHupEAFV7xa75NRGhJLCfX+5Ut9CrKAAbwCThKvW7AAPgy8UXJMEutU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970413; c=relaxed/simple;
	bh=HK1pRkQ0hzPNI4jNHlfS/gFmz3+HSJPrYT+o7/tAoK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oec1TtzfccGi4gegasrfKK8PTRSpWgXfgVQVV69Ok00XZ14VlyB0sGHfYkIvvqI4JPXGz4uyx2kwT3mupbb/1KXEEV5zXuRXWx+W+dNvn/tpMOXAqWVI6+/uNV99ieGq1VDr11G0+3GWQhPJl+S9mXcSmNKwypnaHh0fKaa/Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B27BFEC;
	Mon, 22 Jan 2024 16:40:57 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 128A13F73F;
	Mon, 22 Jan 2024 16:40:08 -0800 (PST)
Date: Tue, 23 Jan 2024 00:39:20 +0000
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
Subject: Re: [PATCH 5/7] arm64: dts: allwinner: h6: Add RX DMA channel for
 SPDIF
Message-ID: <20240123003920.08813e16@minigeek.lan>
In-Reply-To: <20240122170518.3090814-6-wens@kernel.org>
References: <20240122170518.3090814-1-wens@kernel.org>
	<20240122170518.3090814-6-wens@kernel.org>
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

On Tue, 23 Jan 2024 01:05:16 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The SPDIF hardware found on the H6 supports both transmit and receive
> functions. However it is missing the RX DMA channel.
> 
> Add the SPDIF hardware block's RX DMA channel. Also remove the
> by-default pinmux, since the end device can choose to implement
> either or both functionalities.
> 
> Fixes: f95b598df419 ("arm64: dts: allwinner: Add SPDIF node for Allwinner H6")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Looks alright, just moving lines around, order of rx, tx DMA is correct:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi      | 2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi            | 7 +++----
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index 9ec49ac2f6fd..381d58cea092 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -291,6 +291,8 @@ sw {
>  };
>  
>  &spdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spdif_tx_pin>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
> index 4903d6358112..855b7d43bc50 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
> @@ -166,6 +166,8 @@ &r_ir {
>  };
>  
>  &spdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spdif_tx_pin>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index ca1d287a0a01..d11e5041bae9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -406,6 +406,7 @@ spi1_cs_pin: spi1-cs-pin {
>  				function = "spi1";
>  			};
>  
> +			/omit-if-no-ref/
>  			spdif_tx_pin: spdif-tx-pin {
>  				pins = "PH7";
>  				function = "spdif";
> @@ -655,10 +656,8 @@ spdif: spdif@5093000 {
>  			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
>  			clock-names = "apb", "spdif";
>  			resets = <&ccu RST_BUS_SPDIF>;
> -			dmas = <&dma 2>;
> -			dma-names = "tx";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&spdif_tx_pin>;
> +			dmas = <&dma 2>, <&dma 2>;
> +			dma-names = "rx", "tx";
>  			status = "disabled";
>  		};
>  


