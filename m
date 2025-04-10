Return-Path: <dmaengine+bounces-4867-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4221A83BAF
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF774A2953
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28DB1E0B91;
	Thu, 10 Apr 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM5njTKT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14D1DF985;
	Thu, 10 Apr 2025 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271424; cv=none; b=NByYmpxeY50vOGaF51hCBr2w9QapMhr3kOi0OzAc0gE8WN9OB2uwJEN1T/RUauQI/+N1UQ1KUAcB+PU0PNYsox+7ipkbWa3NokuKVhA9Azr99IISDsGQYrnI3a7VErjDdcXHLUmdQREsKtPLoje7VsXJ5OuupGdldnyOoWEVb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271424; c=relaxed/simple;
	bh=XJ8C56dpgh7I3PapWIvW5bS5auRCwUc0h+lB9fhDO6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+kocV7dCxOzgt/AZbfkBORACp5H3f/HxhVlijItuZE2O1ZROpD9F9AFfledfT0OOmXWwR2Mf3fS1JTxIjHSd5zbNL1j9PoQL3FBxMudHCqOnWy/+AFagkTFOgtXeoqvrXIeoP8lBoaSe6UPXS64bGbAK4nlR2P1M2V+xcDzb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM5njTKT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso90267266b.1;
        Thu, 10 Apr 2025 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744271421; x=1744876221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mex8Z9dzfxz3hW33N8AMNQUPFzwP3mz+qG8H/RfxWWU=;
        b=aM5njTKTrKaULscH0EIBdfsIrXKoMQjOmP3U+vrFtj9S8f90ZpL3MNWnwlDqW8Gg4o
         UibWIQ63o1STs4AjXbNOgG8JL/0NHySeJwMhWrI0tu09BotsbtQ99Xn3cYcFErj5S8fL
         YWXNnBA4ahD2+pKHdLfdOAEr+q5wdDOotPz4i4RWD5Dcf3nQCJKmcmeolrTChhGoDJJy
         QnV/FGNFPiV3gjS/Bqn5yHbYaYF2aY6AfBFazEiBHEzQXJazyH7oJ5abdxqVx8vrw/N/
         dhXZUJQROoW9QeNVCULSvCV3LsBcTGtiKIgynVsWu7t8c6V+dFFJVnyMbqFvefZDnmSa
         S8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744271421; x=1744876221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mex8Z9dzfxz3hW33N8AMNQUPFzwP3mz+qG8H/RfxWWU=;
        b=j5CtgmeSNeKA/14rmn6BUud6NdzM3nxMa6bmNmOAk6+nf5GGsQw6Azdvc72a5WN9Pf
         DZns+JKWxzAJEPTBsN+2GNOq+MkR4kqadnXvUP/WlbjO8pOquU0OlUnD0D0S6xP2vCj6
         TBkaApi3BHIByduCCWUeUjeODYeZ6lqQEQB38byFBEqXuPEOWh4mRlwvsVgD2jwvp9XV
         s1cFgbCNJXkw8pe9kO5blHRWIp8mmnfOKq2mScmDSe6FPpV3wZULPZ/DxlylTPmTnWed
         GSeXSbpR68QCQvbwsXlsywW4qoP2zi0lAJea3Zf9PYOxTLDlNHjLJpBrLhaPMSDLrFqX
         eYEw==
X-Forwarded-Encrypted: i=1; AJvYcCUEC/qiRQBnOyqloAUuHQWS6WBASUWwsiZFWyZsF6eQlZWTYd8mEaiOjiAAredTVJG1A5yiA+eLIauo@vger.kernel.org, AJvYcCUVTnOHot1EjKjyEecC22tq39ZyA3V7JkNdMhejDqMwqbfQOeCsCPPIIHVYYEQPRZDBdAC8e3llK+KA@vger.kernel.org, AJvYcCWA8iJVlnQo9jMnnF7I+jARuPjxsuC62lPiJ4Pnfgkd6NIjm5jh+dRYmDM1Z6dXHocE1rDG+UVDXSwse2Ou@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6R31w5cGaTjQONCf4l+yxHaWEaakTuLdGOh692EN1JcNGTNi
	Pp/R+ZQ/xJqV1uExQTQsZUicFLHEy+QaG5BPS+im9g2hZePVVIjn
X-Gm-Gg: ASbGncu6y/0C8aQpQNZxc07seBizQfK4ZZqm7o4GUQxE/8KNpQh10Pt4v+PMfVhDneJ
	fJ2uF7Zm0PsTikLRrkTPjnP/vp7QjuM9dcbz/sRBA0f1SPW/2ywBdNNkbn91o7321ve53hhO4mK
	ql3Q+LtcNWNctLhsx0HfDEZ0KsQ8hqZE6/sWywUnz5ZJQkw0mEVoElAK7aEC8o56VJ4ppLriJDV
	xzDCywuq4zksi76R2YIJW1/mfiKKj3/hrQbipK57wLKe4oWxiyKiuDKWsxGrh/ylMqZvYyfI/6B
	i2mqHW0hYtmtw+fWEL5IPT10OAebntgpNrnsfU47EAME4KI2vxjFXgKpOZPHNYJg9JWDLAIH1vy
	NngEXOV4h+OJcE3IFWA2acig/u2VGhRWkKH00a+4=
X-Google-Smtp-Source: AGHT+IEUKtIECQHfvCCQHEULrOOyIkJYLflU4RweKbQ5LyEXFJ2aLZNpy2NRTB84slWGKlTEWqpvyA==
X-Received: by 2002:a17:906:7310:b0:ac6:edd3:e466 with SMTP id a640c23a62f3a-acac008e44dmr102214566b.19.1744271421157;
        Thu, 10 Apr 2025 00:50:21 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-79-37-123-173.retail.telecomitalia.it. [79.37.123.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd195sm225096366b.130.2025.04.10.00.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:50:20 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:50:18 +0200
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v2 3/3] arm64: dtsi: imx93: add edma error interrupt
 support
Message-ID: <Z/d4OlTG6uDXtl49@alb3rt0-ThinkPad-P15-Gen-1>
References: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
 <20250407-edma_err-v2-3-9d7e5b77fcc4@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-edma_err-v2-3-9d7e5b77fcc4@nxp.com>

On Mon, Apr 07, 2025 at 12:46:37PM -0400, Frank Li wrote:
> From: Joy Zou <joy.zou@nxp.com>
> 
> Add edma error irq for imx93.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 64cd0776b43d3..9f6ac3c8f9455 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -297,7 +297,8 @@ edma1: dma-controller@44000000 {
>  					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>, // 27: TMP2 CH1/CH3
>  					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, // 28: TMP2 Overflow
>  					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>, // 29: PDM
> -					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>; // 30: ADC1
> +					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>, // 30: ADC1
> +					     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;  // err
>  				clocks = <&clk IMX93_CLK_EDMA1_GATE>;
>  				clock-names = "dma";
>  			};
> @@ -667,7 +668,8 @@ edma2: dma-controller@42000000 {
>  					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
> +					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_EDMA2_GATE>;
>  				clock-names = "dma";
>  			};
> 
> -- 
> 2.34.1
> 
> 
Reviewed-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Tested-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>

