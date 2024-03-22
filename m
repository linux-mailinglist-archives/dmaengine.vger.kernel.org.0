Return-Path: <dmaengine+bounces-1472-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DD1886EA1
	for <lists+dmaengine@lfdr.de>; Fri, 22 Mar 2024 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B15B2159C
	for <lists+dmaengine@lfdr.de>; Fri, 22 Mar 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4446F481BF;
	Fri, 22 Mar 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOvwDaNf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE6482FF
	for <dmaengine@vger.kernel.org>; Fri, 22 Mar 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117940; cv=none; b=KddpyquIO7+u4qkj0lbEHY5gQfucRtdRmJlt6rNa+alrjQJGQ7EdPNBdoW9gkbFoLNunvaY8ZiHc+/WaQnUhiKQbv6Xj8Fd2TgSyHrwvv7JFqfGW9TbWhJ8rBCNtsVw2j+wmYYAopaAehlfMBfl8z1bLQuzDnFlEbWtpyiSfI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117940; c=relaxed/simple;
	bh=69ZdVrReaf8DDgejMv4nU6fGqoatnYxGMkDl317L/q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6ekWneOo2tLH+d6qhME53L7zdSijLGKmZY8YJP5XskjmlW6bRtOvPJ5FGU0jjJMue7OIa7SxwSzOv/cnjZoAqqw0pUpRHTRZVsgDArQ41guaN2U9N75vHJZ380gWaabPI52vYUDwD93IR4f7JHRyplqxzHLavzw0D+gQz1AEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOvwDaNf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dee27acf7aso14851635ad.2
        for <dmaengine@vger.kernel.org>; Fri, 22 Mar 2024 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711117938; x=1711722738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bsQoTDol9HPR9N3ln/StyK4/449TM2DZcvuKewqwWVs=;
        b=mOvwDaNfg8VlqvhvBlpr/kYqGhx0zPOascdWwuU/dfNzTjQMP6eyJjweDUT2AKhhpa
         raCRcmf4vIUPZ6XMPkeImLzcSneY1ZwQok4rR08vYS6Iucsa9DWe0q9fA7GsqdlspaWC
         v2LcEQNEmmISMW1eB0CcKTXaq7tlbeds/Ibes2eRmt+uhuUrgDyBIy1KpSUyRj25TzQc
         j+thRb6O45+Hz7wZi+afDMblRqfSCKG9x/Mv9WRGoQmQxZnyZJgscJktjBOc/sBKUqzT
         vabjQkC4yGkaLcagzyvZDOmfEsabZfFGsoOmZJZPYD/r66fTuXI6Hj8JWRsVS5LKQiNB
         tKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711117938; x=1711722738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsQoTDol9HPR9N3ln/StyK4/449TM2DZcvuKewqwWVs=;
        b=So4hqa5nfL5XTsXmmsdi1c8Ntv4E4TzH7EZ8rbOH07DYOh/jiK7gs9IzLjjHgiaP7D
         dvLriT7CZzVovz63CClNLbGv9jz5Kj4tD+bc5n7xPFvqtqEaJ1sc1cZqpDOq9hIgBSR+
         n2tkltXCrg5V4dk4yqAaoSIKM1nEoZ/w8ERODbnH26S6kW3RmM72OIfQrFRTE0sTjUZA
         CKzJvO2dNBVP2hPTXgslBMuib78aOK33xJcTpXZlZ3SYKwwcU6i6ZCjM96MM3n+Og61E
         nYzGjkMMkAbfucBxkzHNuJ+hxrh7UV9jCze30xUxBWGvkQnEML3LXuqkZax3upBB5QY6
         1gpw==
X-Forwarded-Encrypted: i=1; AJvYcCWXDZdnxGi7fBmHgn26kRAFcH7uGGp9X6wxYr2K/17N8NUoiUtO1fOto9NhNSax88sh5VKN2u46OPK0TbzUvQ/y1o18ipA+ZD1y
X-Gm-Message-State: AOJu0YxsABuwKSPExFzD70tFHseWneU3ElqDhjHAvGqDNCOiBhPOANYz
	AwOs4N29vHkxVbCAeleFtYKzznEbfyugMCAG0+WulayGBism58y3gI1ZMyTua3sO4rAUdW9KwTY
	=
X-Google-Smtp-Source: AGHT+IGjsRnNYOq/KugmVVWK06RZmJQVOgzrvCR0cZJUdpBKhV8wEEXZP7kz9AS2YSen6KzO7otn8Q==
X-Received: by 2002:a17:903:1207:b0:1dd:2e6:b951 with SMTP id l7-20020a170903120700b001dd02e6b951mr3625855plh.12.1711117937731;
        Fri, 22 Mar 2024 07:32:17 -0700 (PDT)
Received: from thinkpad ([103.28.246.103])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b001dd7a97a266sm1987075plk.282.2024.03.22.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:32:17 -0700 (PDT)
Date: Fri, 22 Mar 2024 20:02:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>,
	Zhang Jianhua <chris.zjh@huawei.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] dmaengine: owl: fix register access functions
Message-ID: <20240322143211.GA3333@thinkpad>
References: <20240322132116.906475-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322132116.906475-1-arnd@kernel.org>

On Fri, Mar 22, 2024 at 02:21:07PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When building with 'make W=1', clang notices that the computed register
> values are never actually written back but instead the wrong variable
> is set:
> 
> drivers/dma/owl-dma.c:244:6: error: variable 'regval' set but not used [-Werror,-Wunused-but-set-variable]
>   244 |         u32 regval;
>       |             ^
> drivers/dma/owl-dma.c:268:6: error: variable 'regval' set but not used [-Werror,-Wunused-but-set-variable]
>   268 |         u32 regval;
>       |             ^
> 
> Change these to what was most likely intended.
> 

Wow... Thanks for spotting. Well thanks to Clang also ;)

> Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Cc: stable@vger.kernel.org # 4.19

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/dma/owl-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> index 4e76c4ec2d39..e001f4f7aa64 100644
> --- a/drivers/dma/owl-dma.c
> +++ b/drivers/dma/owl-dma.c
> @@ -250,7 +250,7 @@ static void pchan_update(struct owl_dma_pchan *pchan, u32 reg,
>  	else
>  		regval &= ~val;
>  
> -	writel(val, pchan->base + reg);
> +	writel(regval, pchan->base + reg);
>  }
>  
>  static void pchan_writel(struct owl_dma_pchan *pchan, u32 reg, u32 data)
> @@ -274,7 +274,7 @@ static void dma_update(struct owl_dma *od, u32 reg, u32 val, bool state)
>  	else
>  		regval &= ~val;
>  
> -	writel(val, od->base + reg);
> +	writel(regval, od->base + reg);
>  }
>  
>  static void dma_writel(struct owl_dma *od, u32 reg, u32 data)
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

