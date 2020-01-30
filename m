Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A3D14E389
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 21:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgA3UEp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 15:04:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38169 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3UEp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 15:04:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so3168198lfm.5;
        Thu, 30 Jan 2020 12:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rFCe8vloPLNWzxA538JrWua6vDo091Ev6JlOviqKEP8=;
        b=hkmfaAwjCxiyS3TEjul6A1H41o01HJLzovlUi76uHlvEOLOljPWTPv5u1R9ZDfktkI
         601diKCi7LzNYWk6MHxykXbHQjf4Kw05FUFKQhVh1c1m2Wm/i+LgGWK8p6AYnFjnYrW6
         EJCnjWGlVZvR/7NPqrHpPV51UJ2blzzvXKefUiWdIjK16OKQdeJNETv0+Z37XZsALl/4
         hxN0Ug5pArgLbUSDR7JQ8F4yCFP2oiCuq3r2kuJi0aSgGjRY1rqVhyqTkuNtjG4aG/nx
         0wSx1FnQ0MOYqcnDRaxm7bGXjgFpeSqu0FyaRTBykQDonBKLh2rqBomDWoEbjy48GgKG
         4dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFCe8vloPLNWzxA538JrWua6vDo091Ev6JlOviqKEP8=;
        b=frCRxEZf2JF3KrOKfButzkvMcEsbYPNhpKXgL1FwlX1tm7y225qAqKXGoEzerPBkFi
         Py+8+OWst24kUtPt0bjfziRgXw3MziGBCpImGORQ8Ox2I4dij1PjwDNwC3nlTzNAkLR7
         hjnfT6wKv5IEgjpNwI+fBLPS0m2LmXlXGMdM4vIrZ8++FMRQGHkENt0oOX8QLvFz6vW6
         RZz3IhXv0fccyrP6MAiRdmot7kW9ObAOb2vb/o9z6xJnb2625gAgDNJe3Gf1wLhUo95+
         X7944zEPW+go1xi8JcYvi/pnAgnXB4o7gam0XX383DwVNf3/iQCO1PPyVpa2nBvHFgqt
         ZNIg==
X-Gm-Message-State: APjAAAW47f2QtZCoCOKy47kUhZaZ+tAqkVWprU73yj2x4dQ1YBWvPewE
        8nHaqPlCquU7KAtNQ2V+5U77c96A
X-Google-Smtp-Source: APXvYqxSvFuYAVMVkR/q9WgOJ+MVbiERLV9W4owm/YZJFHbRSZjE01CZQrltoVaf4oP1fLp0byRugQ==
X-Received: by 2002:ac2:44bc:: with SMTP id c28mr3367481lfm.72.1580414681280;
        Thu, 30 Jan 2020 12:04:41 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a22sm3462498ljp.96.2020.01.30.12.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 12:04:40 -0800 (PST)
Subject: Re: [PATCH v6 11/16] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-12-digetx@gmail.com>
 <2442aee7-2c2a-bacc-7be9-8eed17498928@nvidia.com>
 <0c766352-700a-68bf-cf7b-9b1686ba9ca9@gmail.com>
 <e72d00ee-abee-9ae2-4654-da77420b440e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cedbf558-b15b-81ca-7833-c94aedce5c5c@gmail.com>
Date:   Thu, 30 Jan 2020 23:04:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e72d00ee-abee-9ae2-4654-da77420b440e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

30.01.2020 21:45, Jon Hunter пишет:
> 
> On 30/01/2020 16:11, Dmitry Osipenko wrote:
>> 30.01.2020 17:09, Jon Hunter пишет:
>>>
>>> On 30/01/2020 04:37, Dmitry Osipenko wrote:
>>>> It's a bit impractical to enable hardware's clock at the time of DMA
>>>> channel's allocation because most of DMA client drivers allocate DMA
>>>> channel at the time of the driver's probing, and thus, DMA clock is kept
>>>> always-enabled in practice, defeating the whole purpose of runtime PM.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/dma/tegra20-apb-dma.c | 47 ++++++++++++++++++++++++-----------
>>>>  1 file changed, 32 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>>> index 22b88ccff05d..0ee28d8e3c96 100644
>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>> @@ -436,6 +436,8 @@ static void tegra_dma_stop(struct tegra_dma_channel *tdc)
>>>>  		tdc_write(tdc, TEGRA_APBDMA_CHAN_STATUS, status);
>>>>  	}
>>>>  	tdc->busy = false;
>>>> +
>>>> +	pm_runtime_put(tdc->tdma->dev);
>>>>  }
>>>>  
>>>>  static void tegra_dma_start(struct tegra_dma_channel *tdc,
>>>> @@ -500,18 +502,25 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
>>>>  	tegra_dma_resume(tdc);
>>>>  }
>>>>  
>>>> -static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>>>> +static bool tdc_start_head_req(struct tegra_dma_channel *tdc)
>>>>  {
>>>>  	struct tegra_dma_sg_req *sg_req;
>>>> +	int err;
>>>>  
>>>>  	if (list_empty(&tdc->pending_sg_req))
>>>> -		return;
>>>> +		return false;
>>>> +
>>>> +	err = pm_runtime_get_sync(tdc->tdma->dev);
>>>> +	if (WARN_ON_ONCE(err < 0))
>>>> +		return false;
>>>>  
>>>>  	sg_req = list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), node);
>>>>  	tegra_dma_start(tdc, sg_req);
>>>>  	sg_req->configured = true;
>>>>  	sg_req->words_xferred = 0;
>>>>  	tdc->busy = true;
>>>> +
>>>> +	return true;
>>>>  }
>>>>  
>>>>  static void tdc_configure_next_head_desc(struct tegra_dma_channel *tdc)
>>>> @@ -615,6 +624,8 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
>>>>  	}
>>>>  	list_add_tail(&sgreq->node, &tdc->free_sg_req);
>>>>  
>>>> +	pm_runtime_put(tdc->tdma->dev);
>>>> +
>>>>  	/* Do not start DMA if it is going to be terminate */
>>>>  	if (to_terminate || list_empty(&tdc->pending_sg_req))
>>>>  		return;
>>>> @@ -730,9 +741,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
>>>>  		dev_err(tdc2dev(tdc), "No DMA request\n");
>>>>  		goto end;
>>>>  	}
>>>> -	if (!tdc->busy) {
>>>> -		tdc_start_head_req(tdc);
>>>> -
>>>> +	if (!tdc->busy && tdc_start_head_req(tdc)) {
>>>>  		/* Continuous single mode: Configure next req */
>>>>  		if (tdc->cyclic) {
>>>>  			/*
>>>> @@ -775,6 +784,13 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>>  	else
>>>>  		wcount = status;
>>>>  
>>>> +	/*
>>>> +	 * tegra_dma_stop() will drop the RPM's usage refcount, but
>>>> +	 * tegra_dma_resume() touches hardware and thus we should keep
>>>> +	 * the DMA clock active while it's needed.
>>>> +	 */
>>>> +	pm_runtime_get(tdc->tdma->dev);
>>>> +
>>>
>>> Would it work and make it simpler to just enable in the issue_pending
>>> and disable in the handle_once_dma_done or terminate_all?
>>>
>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>> index 3a45079d11ec..86bbb45da93d 100644
>>> --- a/drivers/dma/tegra20-apb-dma.c
>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>> @@ -616,9 +616,14 @@ static void handle_once_dma_done(struct
>>> tegra_dma_channel *tdc,
>>>         list_add_tail(&sgreq->node, &tdc->free_sg_req);
>>>
>>>         /* Do not start DMA if it is going to be terminate */
>>> -       if (to_terminate || list_empty(&tdc->pending_sg_req))
>>> +       if (to_terminate)
>>>                 return;
>>>
>>> +       if (list_empty(&tdc->pending_sg_req)) {
>>> +               pm_runtime_put(tdc->tdma->dev);
>>> +               return;
>>> +       }
>>> +
>>>         tdc_start_head_req(tdc);
>>>  }
>>>
>>> @@ -729,6 +734,11 @@ static void tegra_dma_issue_pending(struct dma_chan
>>> *dc)
>>>                 goto end;
>>>         }
>>>         if (!tdc->busy) {
>>> +               if (pm_runtime_get_sync(tdc->tdma->dev) < 0) {
>>> +                       dev_err(tdc2dev(tdc), "Failed to enable DMA!\n");
>>> +                       goto end;
>>> +               }
>>> +
>>>                 tdc_start_head_req(tdc);
>>>
>>>                 /* Continuous single mode: Configure next req */
>>> @@ -788,6 +798,7 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>>>                                 get_current_xferred_count(tdc, sgreq,
>>> wcount);
>>>         }
>>>         tegra_dma_resume(tdc);
>>> +       pm_runtime_put(tdc->tdma->dev);
>>>
>>>  skip_dma_stop:
>>>         tegra_dma_abort_all(tdc);
>>>
>>
>> The tegra_dma_stop() should put RPM anyways, which is missed in yours
>> sample. Please see handle_continuous_head_request().
> 
> Yes and that is deliberate. The cyclic transfers the transfers *should*
> not stop until terminate_all is called. The tegra_dma_stop in
> handle_continuous_head_request() is an error condition and so I am not
> sure it is actually necessary to call pm_runtime_put() here.

But then tegra_dma_stop() shouldn't unset the "busy" mark.

>> I'm also finding the explicit get/put a bit easier to follow in the
>> code, don't you think so?
> 
> I can see that, but I was thinking that in the case of cyclic transfers,
> it should only really be necessary to call the get/put at the beginning
> and end. So in my mind there should only be two exit points which are
> the ISR handler for SG and terminate_all for SG and cyclic.

Alright, I'll update this patch.
