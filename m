Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D20F8D6
	for <lists+dmaengine@lfdr.de>; Tue, 30 Apr 2019 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfD3MZv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Apr 2019 08:25:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33010 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3MZv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Apr 2019 08:25:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so10732266lfm.0;
        Tue, 30 Apr 2019 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JtJJcrr1YUaija/plxCDljz53xsSCTHi3l74LdDf5uo=;
        b=G9owVerU7Y9XrMhaOHiO47i6Af//jA6FA+UfEGn8nJ1hxZC8NB/H18Gmaskkt27SPH
         Q7WTMBVMLSrOvc8+S5VTdJ8/4IbMoNBA9XwpNIyrxAJkmUB/bhrkvMLpkuh2BXU8QlSO
         sT9GfMcYl8hDGO/fIYJIDGqz55FwoyMS2cUedDYzm5ZAN62yaU/cg80rdNp4YqWhXVQ6
         WFfte/HcJgAUjU3cw3tzdzB9LZOyo+LTrYlDkOcKmTgpAqM+QYPTMbg9kOEb5Q7ncT4B
         hMe3gyqinZNkr+ZaMxaGMSRnFd1/3jpWICDDt6Zc3sS8FQxyZz2TELU+Kgc0wLPx/PbI
         7+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JtJJcrr1YUaija/plxCDljz53xsSCTHi3l74LdDf5uo=;
        b=aZjwDHkUo83XUPwDsue5Xw9vErFVVud3RHK/T+UI/Fg5HIyf8QEM06qXhz7wes2Xt/
         /NJd76f9G/IpdaHtzApk3seQFcTL8DADL6VmW14LtMQTJKH7kQCp0iZmfB5ibVtb1Xqb
         f8gpz+vV8CUiH2ukcVcL4YG7Vy6kUVxSPJ63ua3+vdXRB6jAKhGC3Tu24Ctj7u5bLGZj
         Bw9eFTA0TrAEG1CFbRJHthSv+E7Q2EGlDWeqTDZGEw24auR3gcm1A4xa9bSPfi3ZTn/6
         pT2HCqK28HfAX5Dky7RQkEI3CiSNpLP2oxW2dqguyeljahK30rvbb3RhALEz2XiwY9kS
         zrCw==
X-Gm-Message-State: APjAAAUtlBV3a8a+ujSXIpPnFGI58i15DooyK93dDBYJck9pE4Uo7n1l
        J+lXkI3VOeuQIKQDXQm4Hwjau7jt
X-Google-Smtp-Source: APXvYqy0+soB0EXAAwuP477AarxeHWGQ+XxhuNSWu35/9+dNVMS4AquL20oHg8Izo8AGZVCyyeeCsQ==
X-Received: by 2002:ac2:454d:: with SMTP id j13mr37055905lfm.139.1556627147874;
        Tue, 30 Apr 2019 05:25:47 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id z206sm7915425lfa.53.2019.04.30.05.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 05:25:46 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190424231708.21219-1-digetx@gmail.com>
 <d789f1bc-44d1-abf6-a046-7cf835416e8f@nvidia.com>
 <4a315b63-bc71-3c3e-f1ae-8638bcf4033d@gmail.com>
 <bff59709-426b-32d2-08eb-d8f51cd7d5c1@nvidia.com>
 <49392c02-6dcc-9a95-0035-27c4c0d14820@gmail.com>
 <242863b9-b75e-4b37-178a-5aa03e56d3e1@gmail.com>
 <d6d1e420-6707-f446-a531-4b38e4e82c19@gmail.com>
 <20190426151157.GA19559@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cbe75689-fb54-6d5d-c7d0-91bf7ea50cbb@gmail.com>
Date:   Tue, 30 Apr 2019 15:25:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426151157.GA19559@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

26.04.2019 18:11, Thierry Reding пишет:
> On Fri, Apr 26, 2019 at 04:03:08PM +0300, Dmitry Osipenko wrote:
>> 26.04.2019 15:42, Dmitry Osipenko пишет:
>>> 26.04.2019 15:18, Dmitry Osipenko пишет:
>>>> 26.04.2019 14:13, Jon Hunter пишет:
>>>>>
>>>>> On 26/04/2019 11:45, Dmitry Osipenko wrote:
>>>>>> 26.04.2019 12:52, Jon Hunter пишет:
>>>>>>>
>>>>>>> On 25/04/2019 00:17, Dmitry Osipenko wrote:
>>>>>>>> The readl/writel functions are inserting memory barrier in order to
>>>>>>>> ensure that memory stores are completed. On Tegra20 and Tegra30 this
>>>>>>>> results in L2 cache syncing which isn't a cheapest operation. The
>>>>>>>> tegra20-apb-dma driver doesn't need to synchronize generic memory
>>>>>>>> accesses, hence use the relaxed versions of the functions.
>>>>>>>
>>>>>>> Do you mean device-io accesses here as this is not generic memory?
>>>>>>
>>>>>> Yes. The IOMEM accesses within are always ordered and uncached, while
>>>>>> generic memory accesses are out-of-order and cached.
>>>>>>
>>>>>>> Although there may not be any issues with this change, I think I need a
>>>>>>> bit more convincing that we should do this given that we have had it
>>>>>>> this way for sometime and I would not like to see us introduce any
>>>>>>> regressions as this point without being 100% certain we would not.
>>>>>>> Ideally, if I had some good extensive tests I could run to hammer the
>>>>>>> DMA for all configurations with different combinations of channels
>>>>>>> running simultaneously then we could test this, but right now I don't :-(
>>>>>>>
>>>>>>> Have you ...
>>>>>>> 1. Tested both cyclic and scatter-gather transfers?
>>>>>>> 2. Stress tested simultaneous transfers with various different
>>>>>>>    configurations?
>>>>>>> 3. Quantified the actual performance benefit of this change so we can
>>>>>>>    understand how much of a performance boost this offers?
>>>>>>
>>>>>> Actually I found a case where this change causes a problem, I'm seeing
>>>>>> I2C transfer timeout for touchscreen and it breaks the touch input.
>>>>>> Indeed, I haven't tested this patch very well.
>>>>>>
>>>>>> And the fix is this:
>>>>>>
>>>>>> @@ -1592,6 +1592,8 @@ static int tegra_dma_runtime_suspend(struct device
>>>>>> *dev)
>>>>>>  						  TEGRA_APBDMA_CHAN_WCOUNT);
>>>>>>  	}
>>>>>>
>>>>>> +	dsb();
>>>>>> +
>>>>>>  	clk_disable_unprepare(tdma->dma_clk);
>>>>>>
>>>>>>  	return 0;
>>>>>>
>>>>>>
>>>>>> Apparently the problem is that CLK/DMA (PPSB/APB) accesses are
>>>>>> incoherent and CPU disables clock before writes are reaching DMA controller.
>>>>>>
>>>>>> I'd say that cyclic and scatter-gather transfers are now tested. I also
>>>>>> made some more testing of simultaneous transfers.
>>>>>>
>>>>>> Quantifying performance probably won't be easy to make as the DMA
>>>>>> read/writes are not on any kind of code's hot-path.
>>>>>
>>>>> So why make the change?
>>>>
>>>> For consistency.
>>>>
>>>>>> Jon, are you still insisting about to drop this patch or you will be
>>>>>> fine with the v2 that will have the dsb() in place?
>>>>>
>>>>> If we can't quantify the performance gain, then it is difficult to
>>>>> justify the change. I would also be concerned if that is the only place
>>>>> we need an explicit dsb.
>>>>
>>>> Maybe it won't hurt to add dsb to the ISR as well. But okay, let's drop
>>>> this patch for now.
>>>>
>>>
>>> Jon, it occurred to me that there still should be a problem with the
>>> writel() ordering in the driver because writel() ensures that memory
>>> stores are completed *before* the write occurs and hence translates into
>>> iowmb() + writel_relaxed() [0]. Thus the last write will always happen
>>> asynchronously in regards to clk accesses.
>>>
>>> [0]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/include/asm/io.h#n311
>>>
>>
>> Also please note that iowmb() translates into wmb() if
>> CONFIG_ARM_DMA_MEM_BUFFERABLE=y and sometime ago I was profiling host1x
>> driver job submission performance and have seen cases where wmb() could
>> take up to 1ms on T20 due to L2 syncing if there are outstanding memory
>> writes in the cache (or even more, I don't remember exactly already how
>> bad it was..).
> 
> This looks to be primarily caused by the fact that we have the L2X0
> cache on Tegra20. So there's not really anything that can be done there
> without potentially compromising correctness of the code.
> 
>> Altogether, I think the usage of readl/writel in pretty much all of
>> Tegra drivers is plainly wrong and explicit dsb() shall be used in
>> places where hardware synchronization is really needed.
> 
> I don't think that's an accurate observation. readl()/writel() are more
> likely to be correct than the relaxed versions. You already saw yourself
> that using the relaxed versions can easily introduce regressions.
> 
> Granted, readl()/writel() might add more memory barriers than strictly
> necessary, and therefore they might in many cases be suboptimal. But, we
> can't just go and engage in a wholesale conversion of all drivers. If we
> do this, we need to very carefully audit every conversion to make sure
> no regressions are introduced. This is especially complicated because
> these would be subtle regressions and may be difficult to catch or
> reproduce.
> 
> Also, we should avoid using primitives such as dsb in driver code to
> avoid making the code too architecture specific.

I was testing this a bit more for a couple of days and my current
conclusion that there is likely some problem that is getting masked by
writel/readl because I tried to manually insert the syncing that
writel/readl does for the relaxed versions (and more) and that slight
shuffling of the code makes the problem to occur intermittently. My
observations show that it's only the I2C-DMA that has the trouble, other
DMA clients are working fine. Maybe there is some timing problem or
missing ready-state polling somewhere, for now I don't know what's the
actual problem is.
