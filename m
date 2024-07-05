Return-Path: <dmaengine+bounces-2636-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36D8928A6C
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 16:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3F52826A5
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56F14A62E;
	Fri,  5 Jul 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItN222xh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB4166318
	for <dmaengine@vger.kernel.org>; Fri,  5 Jul 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188768; cv=none; b=IwVLVjBTK1nod4acu0Y+kCHNpd86TlnU/unZ0a8qNJN9LUJvNGQ6CJaU4GGal8+FVqtYBF6WXyY7+7MW2q5aODPyrwF4gPeqN+v1dLyNwe4x3MvySZBgy9Sck/Vvlop7SaQL3cAHwOG2NZLp0Okpp+Q/0FP4LdpSza3wtyyo5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188768; c=relaxed/simple;
	bh=L2jMgSNNDpYU705Lv93KSDM8EUW4k3nlnNnjPsrXYyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB+B+iR/aJdFVULiX2h4VRZ9XpXNkFolz8T0JnL5591BChIYC/L4RnVu6Mq5PniTTx+HZyl+8693mFZ0LD4D40t/6EgGz7KNRZiENFUDI73qBrF3BUDandDoRENjos1JwTwqT/+ToJa1Trgd7n4bQJnFlGpaPv/MkwU0Wz12z2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ItN222xh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70aff4e3f6dso1234519b3a.3
        for <dmaengine@vger.kernel.org>; Fri, 05 Jul 2024 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720188766; x=1720793566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3zt/R6s+CF8FDx0ZTAP6lqJlfiuIpUU0rsoTOnmk7Q=;
        b=ItN222xhxCjZUqzjZuAY86z0zan0+1zoawI1YqE0D3CWcfmA6aMRSxfQZAWs6vOKfv
         317OYQqQbzQqz+dkgxlY1uquZxrO/mzDcKlYt3ooKy3WP0Ggc1gB0kvqnb+bXhITl9xB
         LNEsejleEpGvPbQVCmzdm3Ahs5JDArN5qyzHJRDzxmfQBRbLgX/C4tkHwdBZrIJkwEWp
         vv8JomTjBTbrZyf7F4cT4vUB/bJWCUbaHKXpwDOaU6XnOrFCoHjnBqTwfp3+gtqstCSG
         +LcnSHAQZJiaR2GStvXixbEo2MGipGP+ng5PHp9d7syWNaURvQKdnBveuDqNcQxQjSta
         0jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720188766; x=1720793566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3zt/R6s+CF8FDx0ZTAP6lqJlfiuIpUU0rsoTOnmk7Q=;
        b=bbLreW6eqscGkv0zKsPKHQ7cxsUHk/D6GSvgtW3ZTEoxFeCxAAE+pFFrO+ZbTgp+Zc
         Juh3AI3MREeIxCGFAUuomcDn7dn4rQqgk2hdreBKZZBMtrDFwl+RaKUz2VOhs3dIuzul
         zcwdJA4iz6H3WyGlCOkuWbKec7vqtVb6gg7db0SFIZau86Nwy+9WEfJyBAn0/UNaqP2T
         WxRWzLmIK4WlGfpBNoMnn3kGYz7bmfTbbEEkpuTGwfp7wXhxCkutb1Ro5XEKy8c0phT/
         kD2US/Qz1ooO6V4yysI8wBPn5tPnuKAbeDGZ9GSWn4mNgJArSKTpLEbaEE2R6mg3Kiz2
         ZMeg==
X-Forwarded-Encrypted: i=1; AJvYcCWjT8u4SaN0w8lDF/o0RTnTIAU/hZLKIcGgDabjT+tqmMnRzC36wY31bcfOgT+gMie/mmy3gMxEg0KaNnhhEoM5VmRqi4TexmN5
X-Gm-Message-State: AOJu0Yw/pejFU+r4oLc21lVhxrB4TxyadE1bp/wDf1TFI7uTBhlLvekP
	8y7DYzFfdqxrRwn/51eC30lYUxLyWzf5hOxxA5zIdYiV4omMtrrG/WHp9DZMZQ==
X-Google-Smtp-Source: AGHT+IGs/uf/pNfHm5JUOHmh0UYGvkXU++HXpYgTdsLDX62zY+fKG9Gs8P7AKgo/IpGB8buR6oldtg==
X-Received: by 2002:a05:6a00:4f8c:b0:70b:a97:de23 with SMTP id d2e1a72fcca58-70b0a97e129mr3265194b3a.25.1720188766007;
        Fri, 05 Jul 2024 07:12:46 -0700 (PDT)
Received: from thinkpad ([220.158.156.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf764sm14069678b3a.106.2024.07.05.07.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:12:45 -0700 (PDT)
Date: Fri, 5 Jul 2024 19:42:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "zheng.dongxiong" <zheng.dongxiong@outlook.com>
Cc: fancer.lancer@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] dmaengine: dw-edma: Move "Set consumer cycle"
 into first condition in dw_hdma_v0_core_start()
Message-ID: <20240705141241.GB57780@thinkpad>
References: <cover.1720176660.git.zheng.dongxiong@outlook.com>
 <SY4P282MB26240D98F157B616B3AA2E2EF9DF2@SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SY4P282MB26240D98F157B616B3AA2E2EF9DF2@SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM>

On Fri, Jul 05, 2024 at 06:57:34PM +0800, zheng.dongxiong wrote:
> Two or more chunks are used in a transfer,
> Consumer cycle only needs to be set on the first transfer.
> 

Can you please reference the section of the spec that mentions this behavior?

- Mani

> Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 10e8f0715..d77051d1e 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -262,10 +262,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			  lower_32_bits(chunk->ll_region.paddr));
>  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  			  upper_32_bits(chunk->ll_region.paddr));
> +		/* Set consumer cycle */
> +		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> +			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
>  	}
> -	/* Set consumer cycle */
> -	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> -		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
>  
>  	dw_hdma_v0_sync_ll_data(chunk);
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

