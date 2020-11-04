Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDFC2A5CE1
	for <lists+dmaengine@lfdr.de>; Wed,  4 Nov 2020 04:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgKDDF3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Nov 2020 22:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgKDDF2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Nov 2020 22:05:28 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780BC061A4D
        for <dmaengine@vger.kernel.org>; Tue,  3 Nov 2020 19:05:27 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b3so16134489pfo.2
        for <dmaengine@vger.kernel.org>; Tue, 03 Nov 2020 19:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PBhB0BBdyJJ641/oOiczzR080xdXJah54mcoPizb3Mc=;
        b=NacZGxYVbJUMFHbN/XDz+gfyVdPVgdO31vA+lDjPEI664orxMlNVMBRxTvCLkxddYt
         aEH3/EnUXMJPlrs1lJlCOPC5W4JcNCvDQIKCgBjboLlTsazXAaem0sXB/KwE+Sm46NQw
         YVEzFVOPFhdoowkent98MXiT/b8Y3TjzqBhANUCglMB6fLTiZPw752nkK2cneoKi8ztt
         ygDRhuEXq7OwSUD6R8MztEr/NhRUjTFjjNwYG71xMCPJbQYV0lPUmFmso0LRROK+TxwJ
         wNV/lbcMO8SjDHG7yVYK24Z8H4byPYM1lLUZzu+3MX3HcDubOpiYult6r9lhUhicKC07
         27/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PBhB0BBdyJJ641/oOiczzR080xdXJah54mcoPizb3Mc=;
        b=uJOV83+c1rkNDqSwqskBMCMaGnUaZ+q009UsMlRxsV1A5EXExQ0IV1PzLR8BpIUVtE
         pFkOrnriyRaDhyUywbn6O8emoo5rZpL/YPyYshfHHQCt6zE5du1eafC9o8rJ3hJvAQ9C
         5qPber3lNg4D6QiPgZwRTxEf0NCodv7BE4t13DUNzc5fTdIbzQIn4B5Z+hosS3JsnjRD
         yp3YQqsNRQ5QTvGrYuUwI1rKV1s2yIsLOdIo1W2qx3sHLjh+DCw9p3h2NVWYrcg2dH23
         T9QFGwDB5LKbQfXknmbckpJ9Ut2e9sctjk9W1d4ne0VMdRBPtiJWv2MBgufv7Q5SmUly
         DRJg==
X-Gm-Message-State: AOAM530gVPbxEk/Xk7/zHVEnlZ4sreKoLwghEbpK/Ug67R+XO0V8QdK/
        OBbK3MEQukpQXz3BxzbXtCk9B3DiI/Bk+g==
X-Google-Smtp-Source: ABdhPJx781fbuRfx6onuD9bVDAbcY5ctwt6xr8FkYpo6u1WdVzjBWGj8o2yHPm38NFXxgmQk9/Th5Q==
X-Received: by 2002:a65:6649:: with SMTP id z9mr14674221pgv.18.1604459127036;
        Tue, 03 Nov 2020 19:05:27 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id b3sm504516pfd.66.2020.11.03.19.05.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 19:05:26 -0800 (PST)
Date:   Wed, 4 Nov 2020 08:35:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v1] dmaengine: dw: Enable runtime PM
Message-ID: <20201104030522.rwvs6vxkqpnzectk@vireshk-i7>
References: <20201103183938.64752-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103183938.64752-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-11-20, 20:39, Andy Shevchenko wrote:
> When consumer requests channel power on the DMA controller device
> and otherwise on the freeing channel resources.
> 
> Note, in some cases consumer acquires channel at the ->probe() stage and
> releases it at the ->remove() stage. It will mean that DMA controller device
> will be powered during all this time if there is no assist from hardware
> to idle it. The above mentioned cases should be investigated separately
> and individually.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 7ab83fe601ed..19a23767533a 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -982,8 +982,11 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
>  
>  	dev_vdbg(chan2dev(chan), "%s\n", __func__);
>  
> +	pm_runtime_get_sync(dw->dma.dev);
> +
>  	/* ASSERT:  channel is idle */
>  	if (dma_readl(dw, CH_EN) & dwc->mask) {
> +		pm_runtime_put_sync_suspend(dw->dma.dev);
>  		dev_dbg(chan2dev(chan), "DMA channel not idle?\n");
>  		return -EIO;
>  	}
> @@ -1000,6 +1003,7 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
>  	 * We need controller-specific data to set up slave transfers.
>  	 */
>  	if (chan->private && !dw_dma_filter(chan, chan->private)) {
> +		pm_runtime_put_sync_suspend(dw->dma.dev);
>  		dev_warn(chan2dev(chan), "Wrong controller-specific data\n");
>  		return -EINVAL;
>  	}
> @@ -1043,6 +1047,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	if (!dw->in_use)
>  		do_dw_dma_off(dw);
>  
> +	pm_runtime_put_sync_suspend(dw->dma.dev);
> +
>  	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
