Return-Path: <dmaengine+bounces-4836-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC1A7CED7
	for <lists+dmaengine@lfdr.de>; Sun,  6 Apr 2025 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EBD3AFAA3
	for <lists+dmaengine@lfdr.de>; Sun,  6 Apr 2025 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F64218AD4;
	Sun,  6 Apr 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFOKNqiB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAAA14A82;
	Sun,  6 Apr 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743955242; cv=none; b=g2tIpV1aOJ2g2oO9j3QireDrlijAQtQCRMGIqfuFYb/Z/GS9UedcPYjUcuJifp7SHrxaoEANSmuz/92preqTNQkYTej0ZNGJwtaxBIsFXW6Wncm2T6g8n/wYJVvLtPc+fnLDUmeUapuHQg2gPvFOBLvmcq66ChMKlQTD8LcUcp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743955242; c=relaxed/simple;
	bh=RO3Fva6C5rubffpqvk0iOcGbSHQiQfjf9ScrJ5YVv1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ft7b3AHlyc8PugGqrPbIE3Ij21IB3PRGTJWQysu5Cg8UrF0VxuEvAhqf+v+6ATHqfQOzFPsASt61AsDl6t0HGu37Pl3CSxtnqrj1NPNIYs4d8qUCLJ1PUeq+5w0cI8KZcgWsh9/jFn09hyJamP3ly99yaKHcxO7qegnncZXeuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFOKNqiB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30de488cf81so38340871fa.1;
        Sun, 06 Apr 2025 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743955239; x=1744560039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rg1IZxVIsoxxnX9zNo6u1mHR3g+eGTUaEGGW7uVyRVc=;
        b=aFOKNqiBBFUMVs5S8O3/uRNXeK+3fxLiKPsNW114obbAOe5BQUD8drZclPGYfFaprV
         aJTvB+HT54Nwhn6JLxRQK9PpZvTB/AvdaSRudCWBOTcTPqr/k1QJB9zY8bQ+8KwgH2OH
         K49e9Chls0Zie65pB1eTfL2fVQaUakYdmoohvjznoj3aU99W4Iw1btQcXGky02BWwnc/
         5AaSr5r9lnfkoLknLl0GS0lJqucpQ48Fo5Tq/uzzyaF6MLkm0LF/7qEw8KBnv2APZ3p7
         tCOJn6wh8dRReyrznVSMqIwjhKB1f5nnhmVUAJe4VZQqxPdUE0/oC26h5TNE675y4biN
         m0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743955239; x=1744560039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg1IZxVIsoxxnX9zNo6u1mHR3g+eGTUaEGGW7uVyRVc=;
        b=rk6roMxGajBM4UDpe1s3VP3gpAdpzDh3fiaO1RPpnQ6nzhisHY9lzvwasIy0yXnj03
         LK299R4OHyaGzW5DoUZUySmynt8voSqeJy0X4Tpz0GQngKnmZWcqkrYCOHucKjWZxXJr
         0YndCZ1twtw/uXTcyHJm+ECPlJJBOTvU40avkhJ5WerQE7kqPxVenbK5MZJo6zXfGzS0
         NqmRlL6WMJA/cnJqDesTukxC82uO8CtBQ/tFC2QxYZzmXxg4OewYs8b5dUpaCKDoAoa2
         5Cw/7+9lVb1Nr0jMYYmLnH3SC41BtBcr2Nyby+Vz8spHclxgw9ddzyBXuHlqIoRQ/pFi
         w3pg==
X-Forwarded-Encrypted: i=1; AJvYcCV9Tvag/cCqPNC48bZTY2XQbBKKu+tOfSRfTNWo88e2Q/AQHDCq95fcwARWmfI+qaXGS+vqOv2/Oh8=@vger.kernel.org, AJvYcCWCMVbmgN2UL3CafTFF0lu1v0QvQOZ8POssuRYpBfoYsln8UdtHLmnikqTJ/rk2qkMRIxCOyD4oro98BVc7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0TyDyhF30FWUN7PPWO8OSYmRmAPT8TrFKY/aBYbP0IFS526O
	nRcl/LOafqxxoDYLwsE3NYdCojGVY668LW9/mDliCcpfO+F89MtEMNTNaw==
X-Gm-Gg: ASbGncuUtJ7lT5Q0VrIF8/WwATTDHE8jjkXDDEXKgWb9GNh4BkcH8U9+Ocz0dLPm90+
	TID9Ht2/b8o2PL6XGF32oFb4debYheoG/ybmeyCPm/KvqHfyjlkn2SqqMuXoejKf3c+3jwUVzGN
	6ftuKVJGfajTfZFgmJqHtSC/QYcwNOkZ82wAmT1H2mwPw9WhBWUIAvRQwD9t7/fJDaJ0+dRvcaW
	XlK555UhZdMuirj0TDfSX7/P/IBtEKvXJhaVloFqz8+qoIJIlfluD4RhopwruSn5pjyygm6glJI
	UPvYz18fa0QGFRqfzA/FAuCA0pKLXZ9SpqCBYsmAvAdsr0w/J9jXYANlmp5SmLyLOsEdhIa0362
	af3vZIomyGLnvy0E=
X-Google-Smtp-Source: AGHT+IHrgPYsO2t8vEWRf3ilswM+YWn+p5xb3JdNzhhTXrZUQ15d1Bb8vbY3ATHDqfRflmvR1P6QTg==
X-Received: by 2002:a05:651c:1593:b0:30b:d4a9:947c with SMTP id 38308e7fff4ca-30f16527185mr12655981fa.24.1743955238864;
        Sun, 06 Apr 2025 09:00:38 -0700 (PDT)
Received: from [10.0.0.42] (host-185-69-73-15.kaisa-laajakaista.fi. [185.69.73.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0313f3e2sm12956961fa.26.2025.04.06.09.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 09:00:38 -0700 (PDT)
Message-ID: <033fe56b-3f07-4fa7-98a1-84ad53034ace@gmail.com>
Date: Sun, 6 Apr 2025 19:08:01 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: ti: Do not enable by default during
 compile testing
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
 <20250404122114.359087-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20250404122114.359087-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/4/25 3:21 PM, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers.

The scope of compile test has changed?
These drivers will likely not going to be compile tested from now on in
practice on other that the platforms they are used?

It gave a piece of mind to know that the code compiles on ppc/x86/etc
also or it is no longer important sanity check?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/dma/ti/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index 2adc2cca10e9..dbf168146d35 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -17,7 +17,7 @@ config TI_EDMA
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	select TI_DMA_CROSSBAR if (ARCH_OMAP || COMPILE_TEST)
> -	default y
> +	default ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
>  	help
>  	  Enable support for the TI EDMA (Enhanced DMA) controller. This DMA
>  	  engine is found on TI DaVinci, AM33xx, AM43xx, DRA7xx and Keystone 2
> @@ -29,7 +29,7 @@ config DMA_OMAP
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	select TI_DMA_CROSSBAR if (SOC_DRA7XX || COMPILE_TEST)
> -	default y
> +	default ARCH_OMAP
>  	help
>  	  Enable support for the TI sDMA (System DMA or DMA4) controller. This
>  	  DMA engine is found on OMAP and DRA7xx parts.

-- 
Péter


