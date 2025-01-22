Return-Path: <dmaengine+bounces-4174-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A72DA19501
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2025 16:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7D67A3450
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2025 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A659E213E8A;
	Wed, 22 Jan 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSOn10Zp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598B211279;
	Wed, 22 Jan 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559325; cv=none; b=bxBNlUE4xN5gT7b/A1kiYi5KucQe7wMseCPAPwQxKDQSddyg3rjMMrlRoI6QuS+6Q8wxiOcg8ayrPVECDPCjTbWK6u6H5UQ/m3qIYGgb67Y5N+SLcDSC8KvWonqwKBcft2Ny/EYY8BluQbficrJ6MIDqjDhF2K56pohKXYXbock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559325; c=relaxed/simple;
	bh=Zg03Ed84HvtEbsD1Aw6vVpIlk1xxfMKEas6YCDGPyvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWX0q0lzc1cVW2mXwvKEYvgIbDHC4OQ/WGVPUIBi4wzh0zIg81qu5Aj5Dy6MWEOO0fd++3EPG91I3MP9MYbg5kYGyBE4ZggnwgG4OH4ufjdDOpuJgXNLXxCKZ8DvS1+dWOyQnO4+E1cgI0KlkZOqHLAO3cQTFiI77SeU6MH/NHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSOn10Zp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54287a3ba3cso968054e87.0;
        Wed, 22 Jan 2025 07:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737559322; x=1738164122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfR2QuXYijMIlLz5oYgnTkJ+AuUzzbL/VtKzXAQBewk=;
        b=fSOn10Zp1Gf5ONzF/RCuWzSpZNhucNHv9+qFGu2juALfZyEucvk1oyI3PCESOB7hZK
         uaFJMZgsc1vwbcVHli4HBNolknVJLAAorkvmYs9Y/vKIBuInCzbIWHZ6wKtW+A4CuYj5
         bVAlgbJiIXPgjcoIU4GguOjoMe+ML8bIgNHjGllqBALTAo2NpoVj9HGd+L3UfprkI1gK
         iIFjTWM/tYRfUYd/6GxgF1yhSWO/ejtGVbU3oMPD8KHjhPfRNgNDCi86ucS9aAv+MVu1
         fqO+X60PgLY2ejDRj2y9F6DOZS07e701ykdikVhKAudWX1O3u6qGjmjNw4qVFk2+Cf+u
         24ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737559322; x=1738164122;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfR2QuXYijMIlLz5oYgnTkJ+AuUzzbL/VtKzXAQBewk=;
        b=VebDFmDxvM7r5N0K0vh7WGTF5ceCa9cTsIBdpzlNT7+a0elOucaTnGaNwFIYeqQism
         r41VBghCpBEp3+8EO8oow6D1NWSS0LfqkOdNWBJiMV9qciae93V/qcwCFwdEebFztBqI
         6/pe55Lfh7xz2zjuCaVXn2FhQsh1qKdTaYDjnNHqMtiilWLMwFUhxprZMF9Ns4BtKqxg
         6rbR7CuqP/RsUQ0SBDrqwapSoOPiOYeODCBsfath2+f3eNvhInLPPSNwH1xsHC5B0gQx
         wEx39OHdUuL/ukAV5eUSD/Hs07jcD9vR3RDOi0tdjwJhOrAsCAJ0z6PgCVoGiT+yBzYf
         bs4A==
X-Forwarded-Encrypted: i=1; AJvYcCWX8NSH75eDqOZbMS0GQBRrURZqmtR2+DdAWCUii6s6uAivomNeZgrJltP956ra1bq8g13IWSeuPIabDxc+@vger.kernel.org, AJvYcCXTPGo3hUC+J6donmJXgwZBuemENGyRbvmrp1haB6b/WoI4RkkjzsN/bhZy3YLuWVdd5K/234ZR7hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SzhCqgYXoP0aDbqZjsTxCxlyPVskpfMNm24whJMmrMuCzN2N
	Qw+j7naEI4GrEKuRELhfC81sIaPaJucOEmfKOpSaAd73fpkXoQpykvZcxbWz8J4=
X-Gm-Gg: ASbGncvNi4YeQbBFd7GYnBt7Bk1GGY7J2SQ5fzAMzRqqdOX7/QukXHq5JMRf8bk449G
	PwyTj3zu55jqS7ZmOcMeJzJussAGKIwAV3Tp/oYhuQh2DjRzRYkL8K6q5Xmrr1W8Gme2Z4OyCPN
	wDO6kI4mLqy2rPVpFyTlT0AUAsVgZAKBvXZ9ZiLE+sItgp5TFAkSfWu+M1FbXExGpMEDdvmY19G
	BtTGaj34C0PNAir/36xLUQWv5T3OU3FOiHk9+tg7s4yYSI9yV+H/83rJnBaR5kqOmyThZ12K0yT
	OGyUXj00MBAHrNuOLM/pr/w2nqDfYRRR1Ec3gaJ0k5tsmZ8HCZ2RFe55I6Sfz1AWRBC12dnPAnc
	JAhjEWWJvVhLDx6o=
X-Google-Smtp-Source: AGHT+IGH9pPUpqVGP5xQfPR9zXXvfeokEX23hwTlpCQw6AQAyqTd3y8dV/Hsl1Wl68MCtEls7cYFiA==
X-Received: by 2002:a05:6512:3f0b:b0:542:978b:e3b with SMTP id 2adb3069b0e04-5439bf615c8mr7912598e87.4.1737559321435;
        Wed, 22 Jan 2025 07:22:01 -0800 (PST)
Received: from ?IPV6:2001:999:584:a1be:41d4:8b85:aace:5430? (n5ykva7sx9871hnihio-1.v6.elisa-mobile.fi. [2001:999:584:a1be:41d4:8b85:aace:5430])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af732d2sm2246691e87.176.2025.01.22.07.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 07:22:01 -0800 (PST)
Message-ID: <0fca4108-a24c-4259-af88-82114ce3c1d3@gmail.com>
Date: Wed, 22 Jan 2025 17:24:22 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] dmaengine: ti: k3-udma: Use cap_mask directly from
 dma_device structure instead of a local copy
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, vkoul@kernel.org
Cc: vaishnav.a@ti.com, u-kumar1@ti.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250117121728.203452-1-y-abhilashchandra@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20250117121728.203452-1-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/01/2025 14:17, Yemike Abhilash Chandra wrote:
> Currently, a local dma_cap_mask_t variable is used to store device
> cap_mask within udma_of_xlate(). However, the DMA_PRIVATE flag in
> the device cap_mask can get cleared when the last channel is released.
> This can happen right after storing the cap_mask locally in
> udma_of_xlate() and subsequent dma_request_channel() can fail due to
> mismatch in the cap_mask. Fix this by removing the local dma_cap_mask_t
> variable and directly using the one from the dma_device structure.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 7ed1956b4642..c775a2284e86 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4246,7 +4246,6 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
>  				      struct of_dma *ofdma)
>  {
>  	struct udma_dev *ud = ofdma->of_dma_data;
> -	dma_cap_mask_t mask = ud->ddev.cap_mask;
>  	struct udma_filter_param filter_param;
>  	struct dma_chan *chan;
>  
> @@ -4278,7 +4277,7 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
>  		}
>  	}
>  
> -	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
> +	chan = __dma_request_channel(&ud->ddev.cap_mask, udma_dma_filter_fn, &filter_param,
>  				     ofdma->of_node);
>  	if (!chan) {
>  		dev_err(ud->dev, "get channel fail in %s.\n", __func__);

-- 
Péter


