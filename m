Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09674304474
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbhAZGBT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 01:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbhAYMkh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Jan 2021 07:40:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363DBC06121E;
        Mon, 25 Jan 2021 03:11:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q12so17078101lfo.12;
        Mon, 25 Jan 2021 03:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mkFulIPCsoB/b5g0i/rfsI5cAgHAoXFR1p3T8KjUEhI=;
        b=G2Rsddlka1TkEcZCZ57d/jktPQt1Ge+Y77Y7wZJlV7EFIdunloe7k9EQoum05y/oi2
         cCv30PlohibKYXE4Oi5ihQ8ZshmO6WOUsWfFPCAnfIym+kbS3gHR5YG+MRDkjklhAa5v
         s4TmrfIv2iyGuLgpxmRbR848pXUFMNzn41oIimFHIDgFw6IXcIFYEENTRrmtWbrxoS7u
         LtdbqGaOJYD4kpgUTk3YVWPaV+U3KCMRevZzV9Iwfe327nuC8MdeXwBVGeE7p6LAGPGI
         czgfiVuT5u4MK5gIV5cqqZsJ/OrVexIUeU+3ZiK76lfDwRc/wCm/CLsWHJvFiFkon3DL
         9WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mkFulIPCsoB/b5g0i/rfsI5cAgHAoXFR1p3T8KjUEhI=;
        b=dkIDY3AW6ANxJawNonqLSa587YqCc1D/0tddi5y2s2BwINI3uF7HR9bQzo/Ati0rXU
         HbDtUe4rGCfnE2xNEJMrxoiE4pzAqsL+G/du1QRJ2I7rkCqjarG1rqyyKtHKituOsXzU
         XTWoNWj9+6JN8zP4N+MHf6aD0M+IsHvlpGKzfsjfrNJbjXtxRhdfLeSY3gjqpZ8cqH9N
         GL3FZeUUbTWBeyzpWAzZOrUSbAAhg7Bg7CKpXioAQlrb+aKe95iS9dwLIq3DQtp8MLtc
         iMojKV+8mPTzXSn9ulXk29t+7O0u8NC0JCFR3uIQc/TXml45vXjX/F3EuRJ0VE2hCulY
         fkQg==
X-Gm-Message-State: AOAM5300oZcl1Z4/TSpbiZ1KMN9wu1Nh1B9zTwtL0ujSwXi9yoJOPhoK
        hp350qLel4WKIaKjf2skfKylz4vxZqvKg931
X-Google-Smtp-Source: ABdhPJz3xQlsGu+rZV/WoZqeTxzmsyY3f66L2wgYUGzJcQvZjgBkp8nQP2Dry1YXE06LjxTmfHSHuA==
X-Received: by 2002:ac2:495a:: with SMTP id o26mr31631lfi.192.1611573066438;
        Mon, 25 Jan 2021 03:11:06 -0800 (PST)
Received: from [10.0.0.42] (91-157-86-155.elisa-laajakaista.fi. [91.157.86.155])
        by smtp.gmail.com with ESMTPSA id 8sm1432390lfz.113.2021.01.25.03.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 03:11:05 -0800 (PST)
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix a resource leak in an error
 handling path
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210124070923.724479-1-christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <f0b99332-fcac-093a-5f9e-997c9955ad7c@gmail.com>
Date:   Mon, 25 Jan 2021 13:13:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210124070923.724479-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 1/24/21 9:09 AM, Christophe JAILLET wrote:
> In 'dma_pool_create()', we return -ENOMEM, but don't release the resources
> already allocated, as in all the other error handling paths.
> 
> Go to 'err_res_free' instead of returning directly.

Interesting that I only had error for the bcdma path...

> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is not even compile tested.
> I don't have the needed configuration.

No issue, that patch is trivial,

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> ---
>   drivers/dma/ti/k3-udma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 8e3fd1119a77..96ad21869ba7 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2447,7 +2447,8 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
>   			dev_err(ud->ddev.dev,
>   				"Descriptor pool allocation failed\n");
>   			uc->use_dma_pool = false;
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto err_res_free;
>   		}
>   
>   		uc->use_dma_pool = true;
> 

-- 
Péter
