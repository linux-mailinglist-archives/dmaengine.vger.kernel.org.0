Return-Path: <dmaengine+bounces-4224-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CABA229CF
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEAB166896
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F81B0434;
	Thu, 30 Jan 2025 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8nqdkgk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EF1A8F71;
	Thu, 30 Jan 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226894; cv=none; b=RzVSJ8Soz6Fz8afL2qKFfZp6xXyTiF03o2XpciEg46cj7shuSW0I3QGZCcVfAUfz7oNpTIVZBnao63q/dyLAz6ywq/2POFj4W9mnjRQ4xcnWgh1vPI2FJ5nLdx9gjBFCmiEKbIE89Mk/ZNhWeXim7wNnMsHaWpcG+aXYEpueSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226894; c=relaxed/simple;
	bh=FWJwQiogQ+hxCJVsbSYT68kgHA+GtG0m8mRQyC9+PGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOvnlMlIEakrNXSmZonY/nqIUkWD95at3KnlNf7OGjgmhspGAkHtt16mppNbWqVsF/689oibhwk99os1NQdDo1zMdCbbsXOQYTD8Dv2oa3isMSmHZHdmUR6OAnKkMo8PlRUISxwfJdzomy5ux+Tn6tXbD9keFaGz5vhWPkW4P/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8nqdkgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6E7C4CED2;
	Thu, 30 Jan 2025 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738226893;
	bh=FWJwQiogQ+hxCJVsbSYT68kgHA+GtG0m8mRQyC9+PGs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n8nqdkgk1zoGYhcUzBBCkhmcFB0QYcJE3pH2NeziUqcUn1RF/jZiCMFKZQT2vZo9S
	 IMa2HHiLn/ZM63yHUFgndiQy6I0wbsu1KIeFHYvlB+vLYnvzkhig2OBLFY8pGVwXFh
	 0ncqLYFtA+d9FAA+JFOsfJg7xrpOHvq0MiYHclxnER3LweTOWY5LD4KWG6RdboXp8B
	 SLYz/qI9RMD5nxZCYvEYRUfjOKdUiqUcCT+e9pstAuHyyJtRgymrniKyF/NFQ+4bgi
	 AfysMqz2FdXWbWxRAXL+llPYgzucRD+rsCnFJKdw2e8chGd/m/7itZXwfBUB3WekyU
	 MerEow4OpYnyg==
Message-ID: <ac1ea985-15cd-4001-9700-a185ceb338d7@kernel.org>
Date: Thu, 30 Jan 2025 09:48:07 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: s32g: add the eDMA nodes
To: Larisa Grigore <larisa.grigore@oss.nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20250130072951.373027-1-larisa.grigore@oss.nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250130072951.373027-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2025 08:29, Larisa Grigore wrote:
> Add the two eDMA nodes in the device tree in order to enable the probing
> of the S32G2/S32G3 eDMA driver.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi | 34 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/s32g3.dtsi | 34 ++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 7be430b78c83..f73cd5a0906d 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -317,6 +317,23 @@ usdhc0-200mhz-grp4 {
>  			};
>  		};
>  
> +		edma0: dma-controller@40144000 {
> +			#dma-cells = <2>;

Any reason for not following DTS coding style in order of properties?
This is odd style.

> +			compatible = "nxp,s32g2-edma";
> +			reg = <0x40144000 0x24000>,
> +			      <0x4012c000 0x3000>,
> +			      <0x40130000 0x3000>;
> +			dma-channels = <32>;
> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "tx-0-15",
> +					  "tx-16-31",
> +					  "err";
> +			clock-names = "dmamux0", "dmamux1";
> +			clocks = <&clks 63>, <&clks 64>;
> +		};
> +
>  		uart0: serial@401c8000 {
>  			compatible = "nxp,s32g2-linflexuart",
>  				     "fsl,s32v234-linflexuart";
> @@ -333,6 +350,23 @@ uart1: serial@401cc000 {
>  			status = "disabled";
>  		};
>  
> +		edma1: dma-controller@40244000 {
> +			#dma-cells = <2>;
> +			compatible = "nxp,s32g2-edma";
> +			reg = <0x40244000 0x24000>,
> +			      <0x4022c000 0x3000>,
> +			      <0x40230000 0x3000>;
> +			dma-channels = <32>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "tx-0-15",
> +					  "tx-16-31",
> +					  "err";

interrupts, then interrupt-names but:

> +			clock-names = "dmamux0", "dmamux1";
> +			clocks = <&clks 63>, <&clks 64>;

here reversed.

Best regards,
Krzysztof

