Return-Path: <dmaengine+bounces-3213-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762BF98648F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2024 18:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC4F1F28A21
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2024 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0EF208D1;
	Wed, 25 Sep 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvEHNsqt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4418D8825;
	Wed, 25 Sep 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280853; cv=none; b=FuF8ost+mU1L76wk4KoEAmNlDp5hEj67ffBjmX0nKdW1pSwhjdFIL26wXETzxyE+g/p5NGr1EBRLIy/3tQbeF5NgBupEYFOrECesi23rxFJL+MduaqD6LTQMvbhSXXxUYIPMv9SGq9ZNWMUNimIW6AZzX4jPB4hf2E2EFtDwj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280853; c=relaxed/simple;
	bh=JeT1tP97JWtZMoukRTG3ep5x12b8sALK7YvRj95sFwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNZXSVPBt+FKsQaKuTWiNwrhUdWkl9tja+VkUfoPLjDAazY1laHk8qUsMJrw8mlk+8V/9ept0s6Id3Nq/BDT2VFuFSOcIe72p/hq8X0lvjybQHkcFe3nQ4QLYLRbp3FMkt5YpvsbajyHw7BqP/BzMT/FJy0uNObclIn3qVzMtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvEHNsqt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-536562739baso37104e87.1;
        Wed, 25 Sep 2024 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727280849; x=1727885649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/3srR/7Dc/ygG3VbUm2KuEZBBfnrxCN82A0gNSvNdk=;
        b=lvEHNsqtwKnXhuZ+N43diYnodDrlggIusna0/oJPr9Hna7aR6TLa4ifwPkPElak4qB
         6/UuOeBUvJQyKaXQUao1yVasGFsKgzhprXKsH886Rdf54m+pH2+t+tsh5bln7IUDb57u
         3o56UGGG8+KrjNsnDE7QcW5Q3vDgisHdx2Wa3W/nNmJGrLuy5Mrj4nhvptcyl9IjIQ3E
         wK/csNYi3KUIJ85jdvFGgDnL71XW3e/cDXAxTXYRDuI7pcGgAmGlRvkA0i5ELz6okwhu
         LJ+aGtdRTrLmDmIn20tVmPL1guu6zhdCTsZV8ou8gg/5u4KAozzIMquFC3Wg9vxrrw2L
         0DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727280849; x=1727885649;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/3srR/7Dc/ygG3VbUm2KuEZBBfnrxCN82A0gNSvNdk=;
        b=B6zRi8kN0Utx1FJ3nObbYe+zmgaLhp3+E1O3ZvczlIUpciNfsK9J4+03Dn+oaBfTla
         yxth0I9kimRbz2g+qmYcrYcQdskgg4/tLlyyC6wl6UL8r2fXYM3DEL1jh3tcBaeb6DxG
         UHNOMiHhTyMROlhuikSnu3rOngp78fFzf1YL2k3FCbCzkDCWCtSShyA5TMCtgJY318ty
         Uc5DRZeYRcHhLzuBUbt8rfTNJZdiEmbSnjgOP2SWK1uBzk8XGdSmo/p3pmk8t6/LECdE
         EfLVCmeYO91BEMNzBaa10vaYrIodBN4le47xxcAy/5rodfjI38RdAKvGn+L+qk8cngfY
         p7YA==
X-Forwarded-Encrypted: i=1; AJvYcCXZgIqaZslU/jEiGHX29rb3BybPvQkEdSylOCUrZ8IH09KMLQJJc/ZpUrYaKhl8yyRRVbzs03tEmEE=@vger.kernel.org, AJvYcCXl759paWNDZBSugQrX/W06Pyg7hPua2KYKOapcFFg8KY5rbdgFi2eQGJbTFHyrVaNbW82LlfUAKa5o6Y6j@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xtefWFJ1S7fx2eU5LjmDKQBBzHms8uxjLV0Ex2hqIgGVUEGg
	Ts66RNYjlSJYaxfBDndX1XzcNyIxuVXvCaymuc6pppK5PmFi1788
X-Google-Smtp-Source: AGHT+IH8XMhWDQkI2PqMp87FHZcq03bgmhoyRG1cV/OeGNjOJwBrnWUp1r+7WFsEtzSv455ijaKk5A==
X-Received: by 2002:ac2:4c48:0:b0:52f:c14e:2533 with SMTP id 2adb3069b0e04-5387755b8b3mr1819913e87.48.1727280848987;
        Wed, 25 Sep 2024 09:14:08 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e0e4asm562592e87.26.2024.09.25.09.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:14:08 -0700 (PDT)
Message-ID: <5a25044d-b8e6-4260-ad90-95e8f0c7c5c5@gmail.com>
Date: Wed, 25 Sep 2024 19:14:46 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: edma: Check return value of
 of_dma_controller_register
To: Mikhail Arkhipov <m.arhipov@rosa.ru>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240923193703.36645-1-m.arhipov@rosa.ru>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20240923193703.36645-1-m.arhipov@rosa.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/09/2024 22:37, Mikhail Arkhipov wrote:
> If of_dma_controller_register() fails within the edma_probe() function,
> the driver does not check the return value or log the failure. This
> oversight can cause other drivers that rely on this DMA controller to fail
> during their probe phase. Specifically, when other drivers call
> of_dma_request_slave_channel(), they may receive an error code
> -EPROBE_DEFER, causing their initialization to be delayed or fail without
> clear logging of the root cause.
> 
> Add a check for the return value of of_dma_controller_register() in the
> edma_probe() function. If the function returns an error, log an appropriate
> error message and handle the failure by cleaning up resources and returning
> the error code. This ensures that the failure is properly reported, which
> aids in debugging and maintains system stability.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Fixes: dc9b60552f6a ("ARM/dmaengine: edma: Move of_dma_controller_register to the dmaengine driver")
> Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>
> ---
>  drivers/dma/ti/edma.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 5f8d2e93ff3f..9fcbd97d346f 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2529,18 +2529,27 @@ static int edma_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(dev, "memcpy ddev registration failed (%d)\n",
>  				ret);
> -			dma_async_device_unregister(&ecc->dma_slave);
> -			goto err_reg1;
> +			goto err_unregister_dma_slave;
>  		}
>  	}
>  
> -	if (node)
> -		of_dma_controller_register(node, of_edma_xlate, ecc);
> +	if (node) {
> +		ret = of_dma_controller_register(node, of_edma_xlate, ecc);
> +		if (ret) {
> +			dev_err(dev, "Failed to register DMA controller (%d)\n", ret);
> +			goto err_unregister_dma_memcpy;
> +		}
> +	}
> 
>  	dev_info(dev, "TI EDMA DMA engine driver\n");
>  
>  	return 0;
>  
> +err_unregister_dma_memcpy:
> +	if (ecc->dma_memcpy)
> +		dma_async_device_unregister(ecc->dma_memcpy);
> +err_unregister_dma_slave:
> +	dma_async_device_unregister(&ecc->dma_slave);
>  err_reg1:
>  	edma_free_slot(ecc, ecc->dummy_slot);
>  err_disable_pm:

-- 
Péter


