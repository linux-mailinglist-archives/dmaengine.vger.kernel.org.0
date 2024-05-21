Return-Path: <dmaengine+bounces-2127-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526A8CB09D
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC32C1F213B4
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683E142910;
	Tue, 21 May 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ntx25+97"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2AC13D29F;
	Tue, 21 May 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302621; cv=none; b=QSy8R/36jfaFUMEGCCJzGxATF76934J/8hZPb6x7U8yrnDa0ydh3qk8hEhJ53zMOsAgGV4NKoQfU/hDYkyjPYQ1u3UPVCd1jT+i69PZeP7Y1pUd2bNBJV/BAKlY0tQM8U8Zti33IAFp7lx3XEi0ZSTMqSlTOIWnyCrv2cfkFCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302621; c=relaxed/simple;
	bh=WtqB4ZExc+TpbBAgBJEG97RRkstJ14mqV9XnG7ZvxEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkiEz5kgHA0kIL2ubkhftS1cbwGtmkOQlVqxnx07uE5dL+5irpdzR3Fv+5uJSlDU4RdIWhnEvdimkD54SEAa33OjQEWKN5OeOjj5dA7meNeZey7MLYSBblC93NsbSSyjxSXrLOLLFh4m+9fpBygYD7uxznrsEZizQjLJv7ZZAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ntx25+97; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e576057c56so44267381fa.3;
        Tue, 21 May 2024 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716302617; x=1716907417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uaNo7E18+I1j2pf4ig9zACf6WJRqjU5bFQWYkpPsrc=;
        b=Ntx25+9797k3zeFtu20na38i0jGUWjiwgufOhngmGbB+KAMU+Uc+LpFrjiKETnC3BP
         HD30OvjBxytnlkg5RK3hXSndizovL3rUa8SeS5MO7BW8oVudkGHRrwtNRME739BGoJzJ
         w6UL5qeWkVg43FETQ+KOifCldDvJR6yRpCZXi/jJhEx8QfYPocoKyQqBWuCcGFlU+JHd
         LtINB3EyOIaAKoDUopZfxoMG9UbHjxWrjbHHKCaJfc0YZ4QdJ1EeYRhyncCoYnbMUqnM
         0fk7diywZkKZLRVr/YuOMIWrb1wT8c4akCm3fM9MpvQsZ7tr8usorafvq2nHFXOlqD3X
         yGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302617; x=1716907417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uaNo7E18+I1j2pf4ig9zACf6WJRqjU5bFQWYkpPsrc=;
        b=r8zQSKGuC3xG9vHw/VPzWzXPmEWvM3l21/uroDlPQceEoUtq0tJDKQMVffaed2eOvl
         /HhnxWZrL9PUpunVlic2OP8QELSbtB/Y/CARWMIdECPlHhijrbIWSD2IFEyA2vnOg3ff
         wcRjjzv+nRODJSJey4KEKsF3tC1Tc4QRRNZA4S7tELIynZr4seoI9CnM9CTwXLM2XnP8
         pJtMHWyk0kytWvJ8B4ii4wcIuPMu0lzSu3XVZxb1dDK7eyHPTQ7+GFOkzC2cIHhg7gzG
         NtQUM7FHQbqPy+CNT1BopAFUFKDVrwFFp99mBY1uLcNrWZWWGGFdx9VMQpxJZDAEr0zC
         /u5A==
X-Forwarded-Encrypted: i=1; AJvYcCV/+kYKbiI9Np2P7RqqutMM7HL2GOl6hDgVIQpUb4HHVSnczF9ssxlGSvpdiA94lTIlHz9cghMgEozEUz6+BNJA/k2OWo4TIM6g8gAS
X-Gm-Message-State: AOJu0Yzv3efnjCTmXzraVy6Ih2Tu1NoAU8JnwAI/QanXxGNQWEPWsYqi
	kIVCfcaj9l3N7i1/odYpSOQ1+4AA07IDDcyAdA5Z2AQkzvboScPQ
X-Google-Smtp-Source: AGHT+IGpyFNcPSQSk4QClUHzPHVhXEY1eCQlStj8EMfnBH8iVvhkaOSaJyWQOjGuMG6+XOGkFY3nfw==
X-Received: by 2002:a2e:bc06:0:b0:2d6:f69d:c74c with SMTP id 38308e7fff4ca-2e52028ae81mr246804331fa.38.1716302617208;
        Tue, 21 May 2024 07:43:37 -0700 (PDT)
Received: from ?IPV6:2001:999:50c:be0b:be3f:f73e:a5b6:8623? ([2001:999:50c:be0b:be3f:f73e:a5b6:8623])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d16227aesm36348521fa.109.2024.05.21.07.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 07:43:36 -0700 (PDT)
Message-ID: <8b2e4b7f-50ae-4017-adf2-2e990cd45a25@gmail.com>
Date: Tue, 21 May 2024 17:44:21 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Fix
 of_k3_udma_glue_parse_chn_by_id()
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240518100556.2551788-1-s-vadapalli@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240518100556.2551788-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/05/2024 13:05, Siddharth Vadapalli wrote:
> The of_k3_udma_glue_parse_chn_by_id() helper function erroneously
> invokes "of_node_put()" on the "udmax_np" device-node passed to it,
> without having incremented its reference at any point. Fix it.

Acked-by: Peter Ujfalusi@gmail.com

> 
> Fixes: 81a1f90f20af ("dmaengine: ti: k3-udma-glue: Add function to parse channel by ID")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 4b377b4868ef kprobe/ftrace: fix build error due to bad function definition
> of Mainline Linux.
> 
> Regards,
> Siddharth.
> 
>  drivers/dma/ti/k3-udma-glue.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index c9b93055dc9d..f0a399cf45b2 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -200,12 +200,9 @@ of_k3_udma_glue_parse_chn_by_id(struct device_node *udmax_np, struct k3_udma_glu
>  
>  	ret = of_k3_udma_glue_parse(udmax_np, common);
>  	if (ret)
> -		goto out_put_spec;
> +		return ret;
>  
>  	ret = of_k3_udma_glue_parse_chn_common(common, thread_id, tx_chn);
> -
> -out_put_spec:
> -	of_node_put(udmax_np);
>  	return ret;
>  }
>  

-- 
Péter

