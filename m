Return-Path: <dmaengine+bounces-4536-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE6A3C32B
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 16:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852AE3AE936
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE821F3D53;
	Wed, 19 Feb 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdiTlEY5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65401F4195;
	Wed, 19 Feb 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977619; cv=none; b=gl8odxm9n1gJG5D0cboslJtKd7AngcfUsnNOmYmo7hKKyIpFKcXG2T2zrJZ6AaHyv2wUymW8ZjkY6jkWGgY0dtu697RM9Dc9I7pTWfF2CS5PAhA0iXy2E2bVuTHckGwVS7TgHt1ksFCX97+QTqclnsu34nQltQYiY6dav6H2Zc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977619; c=relaxed/simple;
	bh=gV8SHYBIC1MRrvAo6UD5l94mHWIUoHpvSZ2HNTzC13g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okm4VWdJsULfSPkueopS3zuZEq4TrKhDn7oTl3rU4dAMGS77gbk36OUNOhC08zquF/OJzksN8Ge4yQ2LuhgMHV8/tZACpRZAE0gdYQNqHcXo+7/EJ371jjm+jPzm8ezPCtzurNcltSkg/XPggbG04xKqiazkAcebujuH+i5X0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdiTlEY5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a2f240156so35345141fa.3;
        Wed, 19 Feb 2025 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739977616; x=1740582416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgV97x/vQ/whH7vk6tSNveDGHR7Aye2btAEtKhwCZ7A=;
        b=KdiTlEY5gMrWG2GT8HjUCocDmVd63J6+hhjqc8SVIq87I2OdydElBi6XmTigmVcM3R
         7SdGgSy2QZNgtib7HoU099f1Oy0OxYggggOAa0qo59oyplgCiXlx26uuhceQUuMN/hyL
         99uEDk5Psapd9zbwHjXmJQ3wGYD8A/6ZQNmsHEXlV9UwuxwJlkVHwpd2TBGcw+gmgmjZ
         1MhiQdXzBEbMqrpC3MgMRlMSgX7KyoZpF5q93WezEN2YAqnceL3o8uxk147ev4vPRuuX
         2f7HDZdusnAW44rrYX9EUNJIqU1w+anoXqxSL+1H6L/YSHR9o9lD0GIa+CZRtL/bYx3I
         9GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977616; x=1740582416;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgV97x/vQ/whH7vk6tSNveDGHR7Aye2btAEtKhwCZ7A=;
        b=v0WrEQOwpCUQqm2iTio6T2hWCiq8OLhkUYXPazim0qTSY24gzVbCZiJ3KLZPMsUi3N
         F5oIHlBPCiN7CwoMoNsv8yrKi1qJXx5wc8FgzIcrvKGL3aqT/JjA/rVYGIj26fL+Lpsi
         gos/gDoQ85N8H5IKs0O0Zntb+CVmkLpv0LzKwfGAZJw9msfwdeqlliWvUm7NM4FSTnZW
         fw5OffZ0WiqNHd98oJNf7wK3LSkL35SABTg4LEdAy4xAeveeuVnrwOs/UU74PjDFOxGW
         XrXXxiiOl2UwbDWmSgfabnZl4iwChCY5/S4gmvvwOIhr16maqPeB38IW2hVrwYEeC0gI
         HAVA==
X-Forwarded-Encrypted: i=1; AJvYcCUAv3B2vQu3KuCKOHQxt6B1sGAvi4Q3zARI3cIbhTOpze9LQfFp+hX6wdeDMehr4E5Eex9goj9bsIo20XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnrDPGFGoYIorMu8LGeOGvaPBf7Zfs/QOfEUQ6CRkyH4FjOfN
	0AT6yQsDVdPtnmQ19OmO7D+pZbXUYmiT2zOvlbMqsK/JnBOVcJTdB02l4Md2
X-Gm-Gg: ASbGncu/OTDDTWoFfOOpG2aKaqAkQBYUcrcPJlWfp/Q+cn1U06k1QS3qJt5jXxUoBeG
	VL63CNF0br067gGxXo9A7cSeUJP1boMw0+DAAVB+BYTQcGDIxCenwhFsx3JoylYwrqk7OJ3pJ5r
	FLP07TtvKE+jXqSTjiBmVTcJZdfo1wrzrvul7cwqAC5me4sqTgsQTPAjakJEmCc/PUKM1gIyVGc
	VoN+yWbnZsZwHDIc7+4fs2uFmoTX0bG9hdJinao2ipPxK1pCbXIR/Yb5Xuf3K9fFbjmgsHlr2D3
	Prd77RKFw7rhBdV9uIaqxEpDV/ExN9IRV4gS6D59FgcTkrIeBtjD4zmyHT+CqV9hE/VsT3ACJVS
	mO1MwNIG8rPFRZ1Adi5ZXjfQnMf40gKmgO9BB
X-Google-Smtp-Source: AGHT+IH3NEn440FuqyNHJ3LPI/XaJig8Wk5u/s4h5uGYDLuaGxcEoQGndw46vqTZzl19OWGjFt+fQA==
X-Received: by 2002:a2e:9911:0:b0:307:2aea:5594 with SMTP id 38308e7fff4ca-30a44ed1aeamr13192091fa.18.1739977615236;
        Wed, 19 Feb 2025 07:06:55 -0800 (PST)
Received: from ?IPV6:2001:999:400:2a04:e774:ddfe:347f:bb68? (n4bkk9yqra8wbkrzgx4-1.v6.elisa-mobile.fi. [2001:999:400:2a04:e774:ddfe:347f:bb68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30928c24a47sm16259691fa.93.2025.02.19.07.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 07:06:54 -0800 (PST)
Message-ID: <55d56d32-64b5-4cef-8c1c-fb29b7b93b87@gmail.com>
Date: Wed, 19 Feb 2025 17:06:54 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: edma: support sw triggered chans in
 of_edma_xlate()
To: Matthew Majewski <mattwmajewski@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250216214741.207538-1-mattwmajewski@gmail.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20250216214741.207538-1-mattwmajewski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16/02/2025 23:47, Matthew Majewski wrote:
> The .of_edma_xlate() function always sets the hw_triggered flag to
> true. This causes sw triggered channels consumed via the device-tree
> to not function properly, as the driver incorrectly assumes they are
> hw triggered. Modify the xlate() function to correctly set the
> hw_triggered flag to false for channels reserved for memcpy
> operation (ie, sw triggered).
> 
> Signed-off-by: Matthew Majewski <mattwmajewski@gmail.com>

Good catch,
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> ---
>  drivers/dma/ti/edma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 4ece125b2ae7..0554a18d84ba 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2258,8 +2258,12 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
>  
>  	return NULL;
>  out:
> -	/* The channel is going to be used as HW synchronized */
> -	echan->hw_triggered = true;
> +	/*
> +	 * The channel is going to be HW synchronized, unless it was
> +	 * reserved as a memcpy channel
> +	 */
> +	echan->hw_triggered =
> +		!edma_is_memcpy_channel(i, ecc->info->memcpy_channels);
>  	return dma_get_slave_channel(chan);
>  }
>  #else

-- 
Péter


