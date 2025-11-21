Return-Path: <dmaengine+bounces-7278-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AAAC78282
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C9BD3420DD
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4473074B7;
	Fri, 21 Nov 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhecCm5P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A12FDC5B
	for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717213; cv=none; b=pmYxnQLfoTk7Wre/7DK3D9gQGZ+mPu69jTeTpzTFR40Jc45zGCDvvx5HfbJHLXI6eb5XMxbT3tPSgQCpNJQI5aHTj+LuxovOmx000EK5kj1tvbq3aoRnh8tswroTWSMEpsJUsWd/ozgN67pA7SFvoQxkgAWD5EK+l6sAse0mX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717213; c=relaxed/simple;
	bh=L4tt6uJ4RFB+KxsL6/s8O8l15oJPsSzKKLyHBNT2Rr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb8uENsxyTLMCDeCEFEK4SLOiryOIfz93XPE6PFP2lLhLCbyqC3/SxVZnGr9G7/e3ffG4EcH8o/XeWKp+bW49d1n8OrR4D4RM8X+YoX9WjyAlx6GhhXNEublABxGgoO2uZL3Gf13HF/o6hFPqBBt/6yEgbDSkmN+lnbNfW2XX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DhecCm5P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so4864085e9.0
        for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 01:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763717210; x=1764322010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDp2iG5BTBVt/GPrCjnqeO98ZCL9PVStlkdxlxkQjj0=;
        b=DhecCm5PP/0Vg0XMOkBtgxagcK232d12moPT6CHExZxe/9O1VHm9Bgiqn4hPJmX2FP
         OEed/EtGNHZRcy1vFtamDhAWt5EdGWD/arnaBamvTxwRMhfHbLOdUjFultaKiZidjU/a
         h43qbTIqLhgrosSLVOMC/0gq1V6A5/3PL7Loo46cB6JYFY9FwzZm6V0X/QZkT43lH4yk
         gedk47u0RsTsDYSGnI1Tg8Hg48FuzTXg56GaW4OyyfEbdipjZcJ6Jb+hHibldcyYbyrM
         EWYKXB1uM8imr9lKskv8mMV9fGB0npbl9tRIar3wpWTVAL7AYDJ2VLX3j1+XRAfYUcOT
         tD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763717210; x=1764322010;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDp2iG5BTBVt/GPrCjnqeO98ZCL9PVStlkdxlxkQjj0=;
        b=IYlQD2fyOTihDzLY7v4EYzMeEKiJvLjfZLP1aocmf9gNkrmR/MFbMuU0wjYBUvj3+8
         0MH7I3nN6wIbt0FcPDU37PYB+OFxabydd8/pXdzqql5OmzmbZTczhsITFYHpHEK/SBE5
         DDAK88ZXi/UPALWtb7HsV1OaODezl0Hc2o5Y90sia5SAhLP0oQs4nbMH6KcDKO7cmF03
         1KKzXqAZ4tLmW3860agtB3jZ/J+ZbR1R6ak6YQR5dGFJu4Zw7mM7HYqhjt54u/HY+wbG
         alHrfkaaJBxpJ8+plxHWckWckT7DRdCM2ZIPunOPCsnHf0DSZmalsDjurlnTqf0zGPkV
         6mYg==
X-Gm-Message-State: AOJu0Yx2cEuL1QO5m7XkmEIOPogT+dMoRyyOdxkcLaV3ZV1sOCbJIQPP
	zOsmmtqT4STNrPvYw5vv8B8bxAxUydHsjW1PryHu+EI0D+EIdtLl2KnvwRNmS7cG8uA=
X-Gm-Gg: ASbGnctxm5sF/NfywXk3KEOy0+HZRhbLAHo/Il9ShPAcIq8FQnmqGkrRugxMrag5TUm
	KW9GdbsnkBmPOIjLHnf7S9LV8JePDvVI9WjNggE15roquWq6yFTtc4IcY3//vUNxb8P5ADXyurL
	cCvEDsLxUwy6BQ4vs0lflnsiPZbQK4MsWAf60ROsGLTrcvyxqI0ug5h17lW1GCPx61rzdyqnJdk
	HqYtabpYfsfKSkIZpkLNrkV2XnWEqX/2WERnIQbaxO3sQGPWs4ziBuSG7s6HoFmFX2NWBrMtwy+
	QEMpW84mUAw1kGI44mf6V0nEx8aX/2Ia0P+9hJawhv8zQyWFMPyl0tVSizuUK2VgGFUp+BZF8xu
	JrVJSlC+r98QthUfrqDfIIbe3iaRdoPTHYj9dlpL63i3HbNwFavffuHT6CEJVxGqPXqhic+YzUi
	iPGit4SH7C6rjb5e/vbw==
X-Google-Smtp-Source: AGHT+IFFoQKN4lvZpPcX6YcwQEY2oYp+D9yrpDQzITsjrjlHpyL9s6Wn+65FnIuxFxbiNVzQkT63aA==
X-Received: by 2002:a05:600c:3b09:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-477c0185b65mr19721245e9.12.1763717209146;
        Fri, 21 Nov 2025 01:26:49 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3b4fafsm34690175e9.14.2025.11.21.01.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 01:26:48 -0800 (PST)
Message-ID: <e7f489db-e04f-4e45-b331-51666b244a69@linaro.org>
Date: Fri, 21 Nov 2025 11:26:47 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dmaengine: stm32-dma3: use module_platform_driver
To: Amelie Delaunay <amelie.delaunay@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251103-dma3_improv-v1-0-57f048bf2877@foss.st.com>
 <20251103-dma3_improv-v1-1-57f048bf2877@foss.st.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103-dma3_improv-v1-1-57f048bf2877@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 12:15, Amelie Delaunay wrote:
> Without module_platform_driver(), stm32-dma3 doesn't have a
> module_exit procedure. Once stm32-dma3 module is inserted, it
> can't be removed, marked busy.
> Use module_platform_driver() instead of subsys_initcall() to register
> (insmod) and unregister (rmmod) stm32-dma3 driver.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> ---
>  drivers/dma/stm32/stm32-dma3.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 50e7106c5cb7..9500164c8f68 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -1914,12 +1914,7 @@ static struct platform_driver stm32_dma3_driver = {
>  	},
>  };
>  
> -static int __init stm32_dma3_init(void)
> -{
> -	return platform_driver_register(&stm32_dma3_driver);
> -}
> -
> -subsys_initcall(stm32_dma3_init);
> +module_platform_driver(stm32_dma3_driver);
>  
>  MODULE_DESCRIPTION("STM32 DMA3 controller driver");
>  MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@foss.st.com>");
> 


