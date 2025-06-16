Return-Path: <dmaengine+bounces-5481-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70EADA8B4
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 08:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6183AE758
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 06:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168819CCF5;
	Mon, 16 Jun 2025 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoauAYjd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D91494C2
	for <dmaengine@vger.kernel.org>; Mon, 16 Jun 2025 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750057059; cv=none; b=OM143DBo5fl/yDwj3XucFi8VfG763T0J9IH5fHkiNc1WrVG9iuu4+S1N9rq0sETnl94kJjKIfyBdWmvzp2HpzBz92g0jPJs55hvfTlT05+Co2hTjT3RdXolSsTbOsdM5ykkYxww1qNtq48aW6pcU1CXMhyaCXDCkXhPIZTlT+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750057059; c=relaxed/simple;
	bh=YjB88UBSVsnAqTwOpkq03DmbKTMee/O0rDci21YJxjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5HCLFDIrJRmUDUNuxSFNKLCy0aeswD13KxHr3CeMWFXq1FeB6EkGpFnWoHnKu+sDERJhBabR50PTe1dio4wbYsUB3b9mOZ3EVki6s0LH38anPC8y9rHZxU+9xQNUwyigI4GeWvkCebTobXBiqSOaFk8uGaV7goYVvOwsSmVNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoauAYjd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad574992fcaso637989666b.1
        for <dmaengine@vger.kernel.org>; Sun, 15 Jun 2025 23:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750057056; x=1750661856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gtV1rZVMGwEdKZN2cNY4PElvgVuiPb0Q4ZvaOK51qQ=;
        b=DoauAYjdf48OMXEYuUoGbgOVbqHsbj9/QqSB61BBB93edQbzbdXAsRCOw1pwzYRzwq
         xzVX7M896MWWp7cVoJte04LN1NmYrdrqCFL1bhhrJrSl/2LktDFU0QsBuQbjJhe0Y5ZT
         HNgqF6opo3WsbvHmqofCrVgLtShH+fW7zapz1iUYcCdPlCh7c0IsmcuWLrh5yA6DbqRS
         tIzPNiarF55yh8G/DiEq3kYn0gBd1ota57zHjwRyFaBYCpFvgG0zJG5hpgzty2ujFROh
         O6b2RbegexXvtPNF8nuSnGyObAieTlA9IEdIeLCRjUO83gFXUHUV5EcNjP8KnS9oEcfX
         CcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750057056; x=1750661856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gtV1rZVMGwEdKZN2cNY4PElvgVuiPb0Q4ZvaOK51qQ=;
        b=UiAzklao2ImhrE8kqGnvLK1bQ1NdIKPSeZsn0rtZoxgWuhBQnFdk+dGcOqCY/qDZqM
         kPNPEB2pg7fKBVihHt1wAjlk3jD8cJRfWe5KLQIT1WJnKsmao9d51q5p1PRoVpfB1LyJ
         jyTwKxzaKPYzTJJUqkmkMHQEIVIPY6+KdsMy+ndtsOM/8+KAQr+4wUtbiUAzyJBU9wBk
         7986k1xv5gPiH9sCUHEoJaVhKtvBG1AHUW5m/VgBL5EMy3URIyX3QqtrFi53uPP6jgxx
         lV3gDiV8PWGWZzoxIFF6Ipu923DUrG9yqcQLQmPN683Z5Zz+UveH5+2a8Fqr8fENWtrG
         Sz6g==
X-Gm-Message-State: AOJu0YyW/wZxF3XibvRCynLX3jrCRdwtf4UW68+uz5h0WHzYbDugKLDu
	CEhHFLNBmdjRcYNQyOeCIsT8COoKbXZTlmVFuzLZkL3XG403yAAarjw5vVBW48dkd2s=
X-Gm-Gg: ASbGncvLkV0SBtIqyBp9xLYxHebjTkH4IQAUelpHrmxkhfA6XDWmYuff3+UcVUu0d77
	z6N3ppmFrFZlhdL6dQxkcTsvCupFyj0TrjMSiXF3EkBOh1gyC5Wq4oHw8LACUfZKM0dW8Wv+wcK
	hkXjDrJuTH+PEQCH5odTiyHRkMr3YE4+4ZfhqIJ+uelPFr8xsFPf5aDrNQMsvwu5FbjkOCvWNJb
	NwS7MXKBeWeMCKMz6vM3r7/wQ7IaPYhSe04+M/roJPYiCJpK6DHrDm7a1Ezjasp+szYoKMaZvuA
	WVJkxzClJcFSrceeq64psW69c/Io8DEcHmy8klSWoXmM+5gPIrcvUlqhxQgwpZRzb/k6yg==
X-Google-Smtp-Source: AGHT+IHOPqpWs/bEljRavIVMEjqIgNiUcWesMvNiRC3Z2rgdIApjZ4oCO/f0xQlOdJfvEukvSCkvSw==
X-Received: by 2002:a17:907:c25:b0:ade:470b:d5ac with SMTP id a640c23a62f3a-adfad4f6209mr738394066b.56.1750057056147;
        Sun, 15 Jun 2025 23:57:36 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c5bedsm602221266b.66.2025.06.15.23.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 23:57:35 -0700 (PDT)
Message-ID: <dd2bf2eb-d0a0-4bc4-b4be-a60a671222f9@linaro.org>
Date: Mon, 16 Jun 2025 09:57:34 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: Add NULL check in lpc18xx_dmamux_reserve()
To: Charles Han <hanchunchao@inspur.com>, vkoul@kernel.org, vz@mleia.com,
 manabian@gmail.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250616060212.1560-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250616060212.1560-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/16/25 09:02, Charles Han wrote:
> The function of_find_device_by_node() may return NULL if the device
> node is not found or CONFIG_OF not defined.
> Add  check whether the return value is NULL and set the error code
> to be returned as -ENODEV.
> 
> Fixes: e5f4ae84be74 ("dmaengine: add driver for lpc18xx dmamux")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/dma/lpc18xx-dmamux.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
> index 2b6436f4b193..ef9aed4ba173 100644
> --- a/drivers/dma/lpc18xx-dmamux.c
> +++ b/drivers/dma/lpc18xx-dmamux.c
> @@ -53,11 +53,16 @@ static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
>  static void *lpc18xx_dmamux_reserve(struct of_phandle_args *dma_spec,
>  				    struct of_dma *ofdma)
>  {
> -	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> -	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
>  	unsigned long flags;
>  	unsigned mux;
>  
> +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +
> +	if (!pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	struct lpc18xx_dmamux_data *dmamux = platform_get_drvdata(pdev);

I believe you should still declare all the variables at the beginning of
the function, even if you initialize them later.

> +
>  	if (dma_spec->args_count != 3) {
>  		dev_err(&pdev->dev, "invalid number of dma mux args\n");
>  		return ERR_PTR(-EINVAL);


