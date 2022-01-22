Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAEC496ADA
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jan 2022 09:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiAVIEo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jan 2022 03:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiAVIEo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jan 2022 03:04:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD743C06173B;
        Sat, 22 Jan 2022 00:04:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a28so8503506lfl.7;
        Sat, 22 Jan 2022 00:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=vwIhpb/GRQT9jpgpKpepqMS4V09yBBWcr16UJyQ5HyQ=;
        b=CDhtYN34A9GRhEySLf8Ncs3oD9rLP/GubJxxfYEIUaBB1nr80d2oLCwnX7HN4Z6XHr
         fIlY+RIijjxNx5z6UDZ0o3WFs0ryEWhPO5WRYfpPp0RBIuvaL+al3MRDvHZw7CPPxDtU
         JbycuUoZg61PEB65BvWOS6e5VMd8rty6CHxBX64THupPiwzHAbfDN9GGfVV3qX8MkoHt
         8hCjihpBnGmBB0sUV3hCw/PFOKMTE7gmk0Pmi/5JUQ8UrknTPO11Z0oq4KsXPBCci8WG
         944/wTb9QTJY6wAHguqmexy6o4S4oAYX64D1GTmVy4/gR4MsTxpiyG4z8AWcAIfJax/Q
         PQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=vwIhpb/GRQT9jpgpKpepqMS4V09yBBWcr16UJyQ5HyQ=;
        b=KbXmIxQQlbN2yXCuZflLOXcR/Z4WRkxMtraiUfZJVUot6FWQi7YtPi8m/C2XR13G4E
         FwSDxgOzoSyB/gVt4Hpi/8fK5yEWMHRe1/VaV6fHJQticN861MR+GiRLX+/qFskIj5zf
         0CGnRgtXIcO1Fb2J7q2i1HXnud5Nz19w382NLuT/uSiZWV18lXRacX33lJoxpOmSTrZv
         6x8Fy3ZGkoinlJP4tE5SM9GZ3GCn1eX72YxVH43EARzZ46BUUOVS1WzhPcK2F8i+sWzb
         MCn+QC4xdErlWvckHUzAfQDqKYSQ/KkpfVDgpB0OkAYK9DLyBNo6es3n8+sxXpEvxeMk
         Mqqw==
X-Gm-Message-State: AOAM533Uq3lyPCwUpmDfkMpZ8Jibza/7HjX88RB1SeGgkYsZJHmkSjS+
        YOz97O3MFGeI6uROCqs1C2c=
X-Google-Smtp-Source: ABdhPJxfB8UlE9V6CjmsMEzFYixiZrP20LbDnREygtPcOULQ/Pn/q3wfmlckUx7Gpm+5gh0gSLGCyw==
X-Received: by 2002:a05:6512:1398:: with SMTP id p24mr6082790lfa.547.1642838682010;
        Sat, 22 Jan 2022 00:04:42 -0800 (PST)
Received: from [10.0.0.42] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id a21sm383132ljn.112.2022.01.22.00.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 00:04:41 -0800 (PST)
Message-ID: <6169df3d-3d04-644c-fc70-a184ecfa97c8@gmail.com>
Date:   Sat, 22 Jan 2022 10:09:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1642332702-126304-1-git-send-email-lyz_cs@pku.edu.cn>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: Fix runtime PM imbalance on error
In-Reply-To: <1642332702-126304-1-git-send-email-lyz_cs@pku.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1/16/22 13:31, Yongzhi Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code, thus a matching decrement is needed on
> the error handling path to keep the counter balanced.

The patch is correct, however the commit message is a bit incorrect.

We are not adding any visible matching decrement, we are switching to
pm_runtime_resume_and_get() which only increments the usage counter if
pm_runtime_resume() is successful.
Granted internally it does a pm_runtime_put_noidle() if resume call fails.

Switch to pm_runtime_resume_and_get() to keep the device's use caunt
balanced?

> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>  drivers/dma/ti/edma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 08e47f4..a73f779 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2398,9 +2398,9 @@ static int edma_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, ecc);
>  
>  	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0) {
> -		dev_err(dev, "pm_runtime_get_sync() failed\n");
> +		dev_err(dev, "pm_runtime_resume_and_get() failed\n");
>  		pm_runtime_disable(dev);
>  		return ret;
>  	}

-- 
Péter
