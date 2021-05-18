Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C63877CF
	for <lists+dmaengine@lfdr.de>; Tue, 18 May 2021 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbhERLh4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 May 2021 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244645AbhERLhv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 May 2021 07:37:51 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8860EC061573;
        Tue, 18 May 2021 04:36:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p20so11137801ljj.8;
        Tue, 18 May 2021 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GeYpDH8KIiHyvyOgBJyYU9dAvZ03Qo4M8bY5+5RVXJw=;
        b=UawL9dedq7VBzwYF7D1fxtxy4gg4nrtXKL9VkYc0iqy7HDlGW4bjZ6EaDL19SjOIAn
         BDBaVIWJ78iNNN4+DLriWPHmb2jxkKMhMklxRo9RBy0kjfvM+GIT85v7PlS2pc261zDU
         VJLTb9uTvxpztq6rUIh8BWwxTEyHRG56l4CLdlN3q5W2loNfQE+FRRTyojxXj3yy0zUy
         R5ra2nRbECF+AsxYAyt+2eh+EA05kIbp1pAdidraZ+w5aGbGj5mxaxUAuwEDpl8mHtjU
         v7r0qAbe9qFRxYM3cgT8CLcZUiAvglz40WnnRzQsdZ1CtY5xvPCB8GoSl7K/ErLi2hWp
         RM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GeYpDH8KIiHyvyOgBJyYU9dAvZ03Qo4M8bY5+5RVXJw=;
        b=OkimuvgNfML+xz2ChvYyUe77UMO1Hlu7jraVL9igyz0/cuFk0of9qmMov9nCDYO4lM
         HuIgsSnGT9oMTGNCp4ckjeXkbwWBT96WGv0FWS56IhcyTzqYPvKUjhmmWYQNyY4Z9lP+
         Rar/zH15+Y7CUZSCDDHtK7do00Es7YrafoF6WyqKsbeexZD8KJOkxYAiknC8eBWp5FUZ
         LtQGOSHrkYf+sMOHNsfL510ZwTnCbgUk1U1ClLk2+gaNvJh7WlAzbda9c4cisZIcyczv
         iJ+/r5iAcKIflP7YF6k4ypW35b7Cm5YRylDUjd8454dUMj102aYKAAfDhzhWRgwxiOKE
         wklA==
X-Gm-Message-State: AOAM531wHq+2eAreAJMqy+0jSodFlTy0wUHxdh/WgJfMaOjIMQo5VFy7
        sL7ag+FExwld7LFRDGwHkdY=
X-Google-Smtp-Source: ABdhPJwvEsmP2hHazRAMnqONB8o4upGBKKJ7eDG5O2qPWf2IE0dcLRjpbH/WzyqqMALp2lnK7YMCFg==
X-Received: by 2002:a2e:b60c:: with SMTP id r12mr3708824ljn.460.1621337791133;
        Tue, 18 May 2021 04:36:31 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id a25sm2254255lfl.38.2021.05.18.04.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 04:36:30 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Skip pointless cpu_pm context
 restore on errors
To:     Tony Lindgren <tony@atomide.com>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
References: <20210518074347.16908-1-tony@atomide.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <fa4e06c9-4296-1fb2-278e-23b493d220cc@gmail.com>
Date:   Tue, 18 May 2021 14:36:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518074347.16908-1-tony@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/05/2021 10:43, Tony Lindgren wrote:
> There's no need to restore DMA context on CPU_CLUSTER_PM_ENTER_FAILED as
> the DMA context won't be lost on errors.
> 
> Note that this does not cause invalid context restore as we already check
> for busy DMA with omap_dma_busy() in CPU_CLUSTER_PM_ENTER, and block any
> deeper idle states for the SoC by returning NOTIFY_BAD if busy.
> 
> If other drivers block deeper idle states with cpu_pm, we now just do a
> pointless restore, but only if dma was not busy on CPU_CLUSTER_PM_ENTER.
> 
> Let's update the CPU_CLUSTER_PM_ENTER_FAILED handling for correctness,
> and add a comment.

Make sense,

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/dma/ti/omap-dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1608,7 +1608,8 @@ static int omap_dma_context_notifier(struct notifier_block *nb,
>  			return NOTIFY_BAD;
>  		omap_dma_context_save(od);
>  		break;
> -	case CPU_CLUSTER_PM_ENTER_FAILED:
> +	case CPU_CLUSTER_PM_ENTER_FAILED:	/* No need to restore context */
> +		break;
>  	case CPU_CLUSTER_PM_EXIT:
>  		omap_dma_context_restore(od);
>  		break;
> 

-- 
Péter
