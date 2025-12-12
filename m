Return-Path: <dmaengine+bounces-7581-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 622DBCB7A61
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 03:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C1D3027A65
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 02:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A13C38;
	Fri, 12 Dec 2025 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXN58Ofj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C21299952
	for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505606; cv=none; b=aUJEfFWx3eSjUpDmXkW0l6x50OKTtAcR2cKx3NcaGPQo3EX3cimL0DBYWuqEGwv9cEXJjppRCu1qLee71lFVlSi2MWEl+qSORwmFYaj9R/sPXSiBETm059q64s4RxBJrw7fG6grLu0J5jzkWA2JZk2417+cOSgN2wnw70bckYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505606; c=relaxed/simple;
	bh=lMh5gyRgOgI3Gg8xwXr6aZ8HjJ+IhzZdmNU1UulS3wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx6Um7isuZ3BQae1e55r6ADHhPoIZv4HMsehXSvHb7fSoviWhLsDxYBl8N5f/m+nsP746CDnvLpvd6OMXbaXax456ioPLJAeyPHR91tp4jZ6V/zgWJf4r6+mWzlAQNwOyGu7FjRcda7ZiUhEpieOSQSaXEVuwEQXm5jJZv+XXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXN58Ofj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3436a97f092so934432a91.3
        for <dmaengine@vger.kernel.org>; Thu, 11 Dec 2025 18:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765505604; x=1766110404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EabbPpdsKQF/LvpgU7ZF68TbCGaov1k1AWkfBxFyBFQ=;
        b=DXN58OfjiiNiIIm7dxvGBKhFCDN48QpkKzvpbMpTx9HAvkvWj7nUab/ZtuG5e91MAa
         cYtd7WszwF7Df2T6ROyZTdJNHgaVkfu/rl0azX32yTkWgImVMO7m0DBXS6wvwbhkH7Ip
         BJ2myFcQQkoWP6BKlZqnxj+5e1YNJCZKwFSQVe0bWhC1dxYjoGyXDt7rGYv+PAiSTvBe
         rINzTJXKFDzrQQiUjc9yIXkfAlJEvugxspbZHSG/42j00fSPUka+9PCXDd17jKKVRRD7
         JTcrSMjcoebeYaLfdBbAr90ZL1T33zRXt5d735/qA8izCfQSYO/QySNlx/EyfFOcUT8+
         /prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505604; x=1766110404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EabbPpdsKQF/LvpgU7ZF68TbCGaov1k1AWkfBxFyBFQ=;
        b=PtV/HKAI8OJPOrK09j6hPlXyVGZeR/nEV0/1SHOcHJ+dug1v2yWqzzZYJMnkGqKXmI
         XZY3tyYSxO8J8jUXgO175jENr+9tenIrnVrS2V219bHYZ6ock2Sot4M4mL9QAcpQWLYo
         7Ub116xEvc8Rv0qdlsZfjLuPLhVQQiRID/aBZnFPUhQUC/B3B+rM6VGK9e5ZA8KjbmPr
         UD2W7GIT8ELcCEphmexW1jcc0ghZzNM5Py2qygYC4Rdg+VlFhYfFvwj393DbyBInbfnf
         WShkVjSWrfPTcEEpBmHsXanleiiZuuBPqSZIOrQfi0qlor2pHL8sb2pL+K8NXEd/PgVN
         HNfA==
X-Forwarded-Encrypted: i=1; AJvYcCX8yVkvBLfLaPP609YS+DC7P3duKYUX7iUFR9ohuW4C7bQW5WFltEB4Jl4tMPjs6OJv+Yw7lmEVuZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNybIpx9Mpec6744yxTaHLW3ERdPQLcQZZLqY7o0haaHtgRzsR
	F6Nehwtjn1Sj56jVNbYa5qyq96Xjlymet7HlHQ1tv0FNwT/ZQOMD6YO8
X-Gm-Gg: AY/fxX7yP3zV9ikb9nldeucX+pu/ANS0EnVxJZCZxD2G3npNa6fBM61k1wSXOTXTjRy
	fKaj/aeC6a0JQGW++dwm3ODlEOz78ru2h+Ie4ZNAlE946rPvB6WRHUSXVqWI3fvJDkBNu4gZHbS
	x00+BeBttLxecQOhgbBJKpwkubTDOm/ii3QPVE4uo8uluUWqZJNIlsrqqPgnY8JBesbsqohcyDR
	7SlF9VjiYdq19kYfOjuHunph+XiCCbOyz2zufN7Pj0RVSPbRnhdo7VyGVCd0Mi/GtSP2YrH2pOx
	AoQ44iSNjA9ikpcig3tZ8J9pl8gnvS3QZLlJD6u8GKvLUdcY9p/FPvBrsMfiic9/TG/s3QDG3GC
	F0/8qOeHcnGIPBBaLv4YDsrgpvcbXniYeB9pVTTBpnUP2y4ERncQtqZMzg3ceX+siAkauUX2Sii
	LnsPBhhQWhtPRf2GD8vHKH
X-Google-Smtp-Source: AGHT+IGSM62C6RPHXzSFleb1+VXxgl8F8RW6xLzTQUgKI9KOQcfinC/Xl4X+PvV8yl4OSV1F3XK1Tg==
X-Received: by 2002:a05:701a:ca0a:b0:11b:9386:7ed0 with SMTP id a92af1059eb24-11f34c500b1mr476321c88.45.1765505604302;
        Thu, 11 Dec 2025 18:13:24 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30497fsm13429561c88.15.2025.12.11.18.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:13:23 -0800 (PST)
Date: Fri, 12 Dec 2025 10:12:26 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, inochiama@gmail.com
Subject: Re: [PATCH] dmaengine: cv1800b-dmamux: fix channel allocation order
Message-ID: <dngobr5qbtk44qdnmiln7eyrwyunvh5t2bmrbhepdilzyi34rc@gwpurbtmeih2>
References: <20251210193011.567210-2-stavinsky@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210193011.567210-2-stavinsky@gmail.com>

On Wed, Dec 10, 2025 at 11:30:12PM +0400, Anton D. Stavinskii wrote:
> The dmamux builds the free_maps list using llist_add(), which inserts
> new nodes at the head. Using increasing channel indices causes the
> first allocation to use DMA channel 7 while the DMA engine hands out
> channel 0, leading to mismatched routing.
> 
> Reverse the channel index order so the first allocation gets channel 0.
> 
> Fixes: db7d07b5add4d ("dmaengine: add driver for Sophgo CV18XX/SG200X dmamux")
> Signed-off-by: Anton D. Stavinskii <stavinsky@gmail.com>
> ---
>  drivers/dma/cv1800b-dmamux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/cv1800b-dmamux.c b/drivers/dma/cv1800b-dmamux.c
> index e900d6595617..825e1614051d 100644
> --- a/drivers/dma/cv1800b-dmamux.c
> +++ b/drivers/dma/cv1800b-dmamux.c
> @@ -214,7 +214,7 @@ static int cv1800_dmamux_probe(struct platform_device *pdev)
>  		}
>  
>  		init_llist_node(&tmp->node);
> -		tmp->channel = i;
> +		tmp->channel = MAX_DMA_CH_ID - i;
>  		llist_add(&tmp->node, &data->free_maps);
>  	}
>  
> -- 
> 2.43.0
> 

The problem is caused by the dw-axi-dmac driver, which allocate
channel dynamically. And the dma multiplexer can only routes
the interrupt statically, so it has the wrong information about
the channel enabled.

This patch does not fix the problem actually, I have sent a new
patch for it.

https://lore.kernel.org/all/20251212020504.915616-1-inochiama@gmail.com/

Regards,
Inochi

