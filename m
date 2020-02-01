Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8630E14F862
	for <lists+dmaengine@lfdr.de>; Sat,  1 Feb 2020 16:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgBAPN5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Feb 2020 10:13:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46631 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgBAPN5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Feb 2020 10:13:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so10125864ljd.13;
        Sat, 01 Feb 2020 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x8auQfYSjBpZuOhTuDNeJ3x3bvJ53JLG86ep/bJMnbM=;
        b=KRaPo/P5+/A3UdshhvRtEXEma+O6VULl7vV5J6EfVsQR3/LFLIcOcUlZ8UIgdmUuzE
         6Gcxjp0JaCPX/1pLX94YcUeJLMQP6Clh4JvkM4SAnaVWuG6YaKeRQpjb9Kblf7sRNc9p
         fyeH1RMCrr+LSHUG9v3ysJsjBQufsHB6vyr58bqPAdpvsDgACBQDWXKcjqa9yMD+q0ie
         UWP51YtMTI43YUrJAMOcccwMJkLwgvcicZo3efYBonvwsJWlvX8qzPqh8FHhhoB9/YrU
         A11hFUiUddOnbU6HN3DX7fT9phg7XKdGOd4dOrUD++6qz0qTOJq350YMj+iX5c9U9EWT
         VmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8auQfYSjBpZuOhTuDNeJ3x3bvJ53JLG86ep/bJMnbM=;
        b=Fgy1XwU/hp7drY+3OIRNsMZw+fY79pMOVP9EWoFHy9y8tE7M9eC8jMnRDRG8TRHPzM
         R0QjOkkBAoozFnsIvd0D/d1GoezXbgQrrrgFybdvybnXItivnDefS5IHJESq083zYGoW
         ph88vGwTevLuLO53hcyqxE5H3n9E0eEQ9CY5S4mizYF611Vvi14uenSUcbiMwMGTq5Nz
         QZFlDfxHzeVX8mHQMo0sRzH7HaAsNoknNEmD9Hian/o0GIoJXgeFW+0PiRKHbawT5i8m
         yEIbWjF3EIOEY/DFb2zBeH+3a3OETjf2Vy3s3hAxsB3f9FiqMOJtfBnfnWa2Ju9pVz+W
         YJng==
X-Gm-Message-State: APjAAAVZS9yQrkwQgWiNcfCw54M2kL6NnssMAkD/4KBn+4baddjGqWg6
        V+G1bUNoXq2YXkOAz2ChnXajFRqk
X-Google-Smtp-Source: APXvYqx1q4UYJfxBrUTrc4rMfdFSOYKP0jUe9QjqckWSglTHxUz3YCCHUlwOhNCo0UVBafW18vaU9w==
X-Received: by 2002:a2e:3e13:: with SMTP id l19mr8813755lja.11.1580570034026;
        Sat, 01 Feb 2020 07:13:54 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id c8sm6113348lfm.65.2020.02.01.07.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 07:13:53 -0800 (PST)
Subject: Re: [PATCH v6 11/16] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <cedbf558-b15b-81ca-7833-c94aedce5c5c@gmail.com>
 <315241b5-f5a2-aaa0-7327-24055ff306c7@nvidia.com>
 <1b64a3c6-a8b9-34d7-96cc-95b93ca1a392@gmail.com>
Message-ID: <bf459b54-fa4c-b0ff-0af8-b7cb66b0a43c@gmail.com>
Date:   Sat, 1 Feb 2020 18:13:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1b64a3c6-a8b9-34d7-96cc-95b93ca1a392@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

31.01.2020 17:22, Dmitry Osipenko пишет:
> 31.01.2020 12:02, Jon Hunter пишет:
>>
>> On 30/01/2020 20:04, Dmitry Osipenko wrote:
>>
>> ...
>>
>>>>> The tegra_dma_stop() should put RPM anyways, which is missed in yours
>>>>> sample. Please see handle_continuous_head_request().
>>>>
>>>> Yes and that is deliberate. The cyclic transfers the transfers *should*
>>>> not stop until terminate_all is called. The tegra_dma_stop in
>>>> handle_continuous_head_request() is an error condition and so I am not
>>>> sure it is actually necessary to call pm_runtime_put() here.
>>>
>>> But then tegra_dma_stop() shouldn't unset the "busy" mark.
>>
>> True.
>>
>>>>> I'm also finding the explicit get/put a bit easier to follow in the
>>>>> code, don't you think so?
>>>>
>>>> I can see that, but I was thinking that in the case of cyclic transfers,
>>>> it should only really be necessary to call the get/put at the beginning
>>>> and end. So in my mind there should only be two exit points which are
>>>> the ISR handler for SG and terminate_all for SG and cyclic.
>>>
>>> Alright, I'll update this patch.
>>
>> Hmmm ... I am wondering if we should not mess with that and leave how
>> you have it.
> 
> I took another look and seems my current v6 should be more correct because:
> 
> 1. If "busy" is unset in tegra_dma_stop(), then the RPM should be put
> there since tegra_dma_terminate_all() won't put RPM in this case:
> 
> 	if (!tdc->busy)
> 		goto skip_dma_stop;
> 
> 2. We can't move the "busy" unsetting into the terminate because then
> tegra_dma_stop() will be invoked twice. Although, one option could be to
> remove the tegra_dma_stop() from the error paths of
> handle_continuous_head_request(), but I'm not sure that this is correct
> to do.

Jon, I realized that my v6 variant is wrong too because
tegra_dma_terminate_all() -> tdc->isr_handler() will put RPM, and thus,
the RPM enable-count will be wrecked in this case.

I'm now leaning to adopt yours variant and simply remove the
tegra_dma_stop() from handle_continuous_head_request() because there
shouldn't be any harm in keeping DMA active in the case of error
condition. Besides, these error conditions are very extreme cases that
should never happen in practice.

The "list_empty(&tdc->pending_sg_req)" error seems couldn't ever happen
at all, I'll remove it in v7.
