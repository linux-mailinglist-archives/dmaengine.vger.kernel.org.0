Return-Path: <dmaengine+bounces-7277-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21880C7835A
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 56443345BE
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64A2D29CE;
	Fri, 21 Nov 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLZ+LOeX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D133F8D3
	for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717161; cv=none; b=HShqv6BMrU/HsFo4Jlji4tdfNxuZy9L5ohplJvHAf3UnVHghvJQTkJdHNQ8VOnQYtMbYimzLeQQbXzh/KHURhyEfQkSMAo51bSrwNP31w2azwLJQnKb51oj/3x1GlEt9aP3B3rYLj1jD1ho0/P/vD+zY2Jwt8FjmjAV/H59x2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717161; c=relaxed/simple;
	bh=iznXwiKM+BjhiSIg9K9OnWtD6qsiuHwK6Bo3UcexD38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxmbH6zoYpX4OlSi3rnFMJOHEl3wRHru2OLotZ6HUpgOynbbgP/XTaPEQMuVkiQFnh6hv2eXkDgLa1mXQZ5IvsFOCazLaOHk9gyzcPhW1oofiAzSBaEPAND549hJjKpkGmJDf+e28gIpxzpCMQcE0TpVXo9Q75qyOocLfYHbtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mLZ+LOeX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso10951085e9.1
        for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 01:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763717156; x=1764321956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58wLSjoCtJmPW1lQLR4kpgVeNHbmr/e22y2z3O0EZnY=;
        b=mLZ+LOeXlL8veNAaGUD/xOaktZCGR/5YWiXeF0XSbNMrAnu5hKUvMYUuSOiSokqhXt
         HxKOxw70FbPO4USh8kGkaJwB+1wZyYJVLPTCH/QbFbciMwgKSi2hcfbm8fLwZEJB8zgd
         2Fm58OEF1kOtprGsqLUbDQA8s2aaG4nw52exV+kwPe02g0tROQ+bK12E7RRw6M/XvOSn
         0M45M7Beb9UicjVAdKiVY1DWkku6EqoMm5pdKo4V80N6jzKEx4cJA3wN+RZ3yF1/Aasw
         MjkggF8afoZse7BD0v5lE7cjjcJtIOkMtjwh0pHWZM1Z74FPeDbqg/93G2uzFZIJpnMQ
         VnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763717156; x=1764321956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58wLSjoCtJmPW1lQLR4kpgVeNHbmr/e22y2z3O0EZnY=;
        b=PlOeAco78IiT03+P7DmsXeruzBFJGv7xwisAME6EDwX/ngaleNxln3PL+IQtT/ENk7
         nAqerXb6Kd3TuxlTjc55fzK+6PRr0CxVN0PcJy43JQ0FChDe4h588J/cUhkkW0+55e8Q
         pjjv7rtrcEz0fieXm2lJwVme5trOEsKW4w7Wfq/lqOL/39ksVmSpuhDgTeRiy7Fga0zV
         1tejvGzO6MlcPXOrXhbEh4TUUg/58KuIdXT/PSwbWNVzajxLg/Oic7KmroVXnxonNh/Z
         NZcHiTYBp2Ra9FCwtI3UfnTcwzhrYgoR3nt11+we+C0tEvov5IWkyijgdHXYfFp1gHeP
         T6Nw==
X-Gm-Message-State: AOJu0YywBoLpmhBQDM9sri5LJfpcmYT9QRoitg6fS2BG8zxgr+q5Y53g
	/E7a/8NnNzc9eHFsjhQHpvNDICaegWyP9ZfpzkOMMmg+xoAXDBYXTjqJZbHHQqZnpB4=
X-Gm-Gg: ASbGncuuKIsxcDaNj7QT2m5E4ssCb90UnwPuKKmPBeoIfHB63SviiyMy0Y4jCGqPUAx
	jkRnjgLB8dIFUJKE//+j3B8t+Nxla9k0yki85VmzpNg6GZ+gL3RHgloRPNMGPqHCj3Mq7uJNlC2
	Ox8mvO7VNjDgvTqAJ2siwXnsS1YR75UfSHNbH308Q3JC2A4P6DlU1VZdRupq7JQKLB4IIALAWjE
	/sIKpOSezyFYR4DnjrZOR5bfvWPsKfYhT0q3chUsD6AB4xLimo/xYiFfaii3TYU4kZCKWBHE5Hx
	7SkVh+DXa/kLOTMjrPv7Y+AMnPiptWb54GLNW1KF2rDsfAcDREvGBEAfcVilgAtIPkKydJOJz2g
	1RXoDAh7wPpzUmnry7d/M01du60fpAQ9oxeVlQbGKOjlTnfF21MAbYDrMzU+CGX6nKv9jSGbv3s
	nmuMOzOrOLUB6aOY5wew==
X-Google-Smtp-Source: AGHT+IEFUMDrJEcj1YdLI40b8qr8K1kgEr1NPgybegm0BhMiyY1WM8obZIXGtWivL6UxNUN6wVEB4g==
X-Received: by 2002:a05:600c:5249:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-477c10c858bmr13810195e9.4.1763717156078;
        Fri, 21 Nov 2025 01:25:56 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3aef57sm31489005e9.11.2025.11.21.01.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 01:25:55 -0800 (PST)
Message-ID: <85f08f72-7608-4076-a474-579eb4c7dc4c@linaro.org>
Date: Fri, 21 Nov 2025 11:25:54 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dmaengine: stm32-dma3: introduce ddata2dev helper
To: Amelie Delaunay <amelie.delaunay@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251103-dma3_improv-v1-0-57f048bf2877@foss.st.com>
 <20251103-dma3_improv-v1-4-57f048bf2877@foss.st.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251103-dma3_improv-v1-4-57f048bf2877@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 12:15, Amelie Delaunay wrote:
> ddata2dev helper returns the device pointer from struct dma_device stored
> in stm32_dma3_ddata structure.
> Device pointer from struct dma_device has been initialized with &pdev->dev,
> so the ddata2dev helper returns &pdev->dev.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  drivers/dma/stm32/stm32-dma3.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 29ea510fa539..9f49ef8e2972 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -333,6 +333,11 @@ static struct device *chan2dev(struct stm32_dma3_chan *chan)
>  	return &chan->vchan.chan.dev->device;
>  }
>  
> +static struct device *ddata2dev(struct stm32_dma3_ddata *ddata)
> +{
> +	return ddata->dma_dev.dev;
> +}

Not really sure how much this helper actually simplifies the code. To me
it appears as if there is no improvement, but this is a personal
preference.> +
>  static void stm32_dma3_chan_dump_reg(struct stm32_dma3_chan *chan)
>  {
>  	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> @@ -392,6 +397,7 @@ static void stm32_dma3_chan_dump_hwdesc(struct stm32_dma3_chan *chan,
>  	} else {
>  		dev_dbg(chan2dev(chan), "X\n");
>  	}
> +
This newline here appears to be unintended >  }
>  
>  static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_chan *chan, u32 count)
> @@ -1110,7 +1116,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
>  	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
> +	ret = pm_runtime_resume_and_get(ddata2dev(ddata));
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1144,7 +1150,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
>  	chan->lli_pool = NULL;
>  
>  err_put_sync:
> -	pm_runtime_put_sync(ddata->dma_dev.dev);
> +	pm_runtime_put_sync(ddata2dev(ddata));
>  
>  	return ret;
>  }
> @@ -1170,7 +1176,7 @@ static void stm32_dma3_free_chan_resources(struct dma_chan *c)
>  	if (chan->semaphore_mode)
>  		stm32_dma3_put_chan_sem(chan);
>  
> -	pm_runtime_put_sync(ddata->dma_dev.dev);
> +	pm_runtime_put_sync(ddata2dev(ddata));
>  
>  	/* Reset configuration */
>  	memset(&chan->dt_config, 0, sizeof(chan->dt_config));
> @@ -1610,11 +1616,11 @@ static bool stm32_dma3_filter_fn(struct dma_chan *c, void *fn_param)
>  		if (!(mask & BIT(chan->id)))
>  			return false;
>  
> -	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
> +	ret = pm_runtime_resume_and_get(ddata2dev(ddata));
>  	if (ret < 0)
>  		return false;
>  	semcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id));
> -	pm_runtime_put_sync(ddata->dma_dev.dev);
> +	pm_runtime_put_sync(ddata2dev(ddata));
>  
>  	/* Check if chan is free */
>  	if (semcr & CSEMCR_SEM_MUTEX)
> @@ -1636,7 +1642,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
>  	struct dma_chan *c;
>  
>  	if (dma_spec->args_count < 3) {
> -		dev_err(ddata->dma_dev.dev, "Invalid args count\n");
> +		dev_err(ddata2dev(ddata), "Invalid args count\n");
>  		return NULL;
>  	}
>  
> @@ -1645,14 +1651,14 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
>  	conf.tr_conf = dma_spec->args[2];
>  
>  	if (conf.req_line >= ddata->dma_requests) {
> -		dev_err(ddata->dma_dev.dev, "Invalid request line\n");
> +		dev_err(ddata2dev(ddata), "Invalid request line\n");
>  		return NULL;
>  	}
>  
>  	/* Request dma channel among the generic dma controller list */
>  	c = dma_request_channel(mask, stm32_dma3_filter_fn, &conf);
>  	if (!c) {
> -		dev_err(ddata->dma_dev.dev, "No suitable channel found\n");
> +		dev_err(ddata2dev(ddata), "No suitable channel found\n");
>  		return NULL;
>  	}
>  
> @@ -1665,6 +1671,7 @@ static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, st
>  
>  static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
>  {
> +	struct device *dev = ddata2dev(ddata);
>  	u32 chan_reserved, mask = 0, i, ccidcfgr, invalid_cid = 0;
>  
>  	/* Reserve Secure channels */
> @@ -1676,7 +1683,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
>  	 * In case CID filtering is not configured, dma-channel-mask property can be used to
>  	 * specify available DMA channels to the kernel.
>  	 */
> -	of_property_read_u32(ddata->dma_dev.dev->of_node, "dma-channel-mask", &mask);
> +	of_property_read_u32(dev->of_node, "dma-channel-mask", &mask);
>  
>  	/* Reserve !CID-filtered not in dma-channel-mask, static CID != CID1, CID1 not allowed */
>  	for (i = 0; i < ddata->dma_channels; i++) {
> @@ -1696,7 +1703,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
>  				ddata->chans[i].semaphore_mode = true;
>  			}
>  		}
> -		dev_dbg(ddata->dma_dev.dev, "chan%d: %s mode, %s\n", i,
> +		dev_dbg(dev, "chan%d: %s mode, %s\n", i,
>  			!(ccidcfgr & CCIDCFGR_CFEN) ? "!CID-filtered" :
>  			ddata->chans[i].semaphore_mode ? "Semaphore" : "Static CID",
>  			(chan_reserved & BIT(i)) ? "denied" :
> @@ -1704,7 +1711,7 @@ static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
>  	}
>  
>  	if (invalid_cid)
> -		dev_warn(ddata->dma_dev.dev, "chan%*pbl have invalid CID configuration\n",
> +		dev_warn(dev, "chan%*pbl have invalid CID configuration\n",
>  			 ddata->dma_channels, &invalid_cid);
>  
>  	return chan_reserved;
> 


