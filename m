Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B251135B45
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jan 2020 15:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgAIOYR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jan 2020 09:24:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42232 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgAIOYQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jan 2020 09:24:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so7406478ljj.9;
        Thu, 09 Jan 2020 06:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MoqmXAxGo4n6apMGzF9n/VnxI31PFNeDGlCPbkHxfQk=;
        b=D6pSdriLHh8g6eu9pwXCmK0ZOp83kh0r5ImPr35Afg/5vWZCauVlQWgMdenHFspuGB
         wDSwpgKwPBEDO7A8xTqoFKWExJZMjJw7Hku01cpgXOcx15UkUCUZaft9bi5JrMgguZ52
         ng1xSPAlmvAhh2qAXVJxCC/z/g3IDeCx/IUSIItqseMhkH1mU4XK0PpX/pN677PttPn4
         N8AFth/QKR1iH9ckHJcAb7z6exgR5uOcPI5Tz40AKhrmZiv39LaZQO8xHC1Yr8jd0IjC
         2JUJprFH3kt2Raiae5C3bJbHU/BRMdqxDiXpBQw+2ZCEKSa7QL1tomhyBL6Rzs75MzGZ
         Q9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MoqmXAxGo4n6apMGzF9n/VnxI31PFNeDGlCPbkHxfQk=;
        b=IgS0DriPTyK4J7bDddRbpmaVCEJet5v3GcKIR/oCesDNqa5Ys4D7osZl3xstXESVLI
         D+WG3HOe7BmXgH61vezryi35ZFUKMOugOxdlv1EWBYrUT9afZlO3mZ6cqGqAq3UW9+UX
         sBpXFV4XWVOkMFAh6DchiUMCSbIgjK/pq42G1uKKaANWno2NF3ELOilhdL1w109YqY4q
         pOmBT4ArzYXbwRk4ypvld8xi4UWH6UuVl0U+D59SPvGxJLjw49LpOAX+o1fU4gToRX1c
         41jWG3YGj5NyqzIl8EYfgPxvc9kZozbuLT6JuMZ8ARxW5WeaEjXZzLAzNze5JUOsL7Rn
         gRRQ==
X-Gm-Message-State: APjAAAWm7N0M7WYcz3eA9HIqgGPsj0/wiPMs6dfyBOPe/6pY/1YD6oD6
        ohkCK/YnZ7q8jew6yacr5HJjFt7Z
X-Google-Smtp-Source: APXvYqwRlr/wi51hG62x9NcJDoflp6FB7pfIgWzl9lVs1zg75nNAm2JWYsU/eeAtZpt3xY1kpmlU7w==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr6486693ljh.187.1578579853763;
        Thu, 09 Jan 2020 06:24:13 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e17sm3087809ljg.101.2020.01.09.06.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 06:24:13 -0800 (PST)
Subject: Re: [PATCH v3 00/13] NVIDIA Tegra APB DMA driver fixes and
 improvements
To:     Thierry Reding <treding@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCIGF3?= <mirq-linux@rere.qmqm.pl>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200106011708.7463-1-digetx@gmail.com>
 <85d8ea335734417081399a082d44024c@HQMAIL105.nvidia.com>
 <c68cde59-0571-f58f-bf3c-8ce1cbdcc387@gmail.com>
 <20200109100442.GA2008067@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f873269b-541a-363c-353a-191a88a65d06@gmail.com>
Date:   Thu, 9 Jan 2020 17:24:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200109100442.GA2008067@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

09.01.2020 13:04, Thierry Reding пишет:
> On Wed, Jan 08, 2020 at 06:07:46PM +0300, Dmitry Osipenko wrote:
>> 08.01.2020 15:51, Thierry Reding пишет:
>>> On Mon, 06 Jan 2020 04:16:55 +0300, Dmitry Osipenko wrote:
>>>> Hello,
>>>>
>>>> This is series fixes some problems that I spotted recently, secondly the
>>>> driver's code gets a cleanup. Please review and apply, thanks in advance!
>>>>
>>>> Changelog:
>>>>
>>>> v3: - In the review comment to v1 Michał Mirosław suggested that "Prevent
>>>>       race conditions on channel's freeing" does changes that deserve to
>>>>       be separated into two patches. I factored out and improved tasklet
>>>>       releasing into this new patch:
>>>>
>>>>         dmaengine: tegra-apb: Clean up tasklet releasing
>>>>
>>>>     - The "Fix use-after-free" patch got an improved commit message.
>>>>
>>>> v2: - I took another look at the driver and spotted few more things that
>>>>       could be improved, which resulted in these new patches:
>>>>
>>>>         dmaengine: tegra-apb: Remove runtime PM usage
>>>>         dmaengine: tegra-apb: Clean up suspend-resume
>>>>         dmaengine: tegra-apb: Add missing of_dma_controller_free
>>>>         dmaengine: tegra-apb: Allow to compile as a loadable kernel module
>>>>         dmaengine: tegra-apb: Remove MODULE_ALIAS
>>>>
>>>> Dmitry Osipenko (13):
>>>>   dmaengine: tegra-apb: Fix use-after-free
>>>>   dmaengine: tegra-apb: Implement synchronization callback
>>>>   dmaengine: tegra-apb: Prevent race conditions on channel's freeing
>>>>   dmaengine: tegra-apb: Clean up tasklet releasing
>>>>   dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
>>>>   dmaengine: tegra-apb: Use devm_platform_ioremap_resource
>>>>   dmaengine: tegra-apb: Use devm_request_irq
>>>>   dmaengine: tegra-apb: Fix coding style problems
>>>>   dmaengine: tegra-apb: Remove runtime PM usage
>>>>   dmaengine: tegra-apb: Clean up suspend-resume
>>>>   dmaengine: tegra-apb: Add missing of_dma_controller_free
>>>>   dmaengine: tegra-apb: Allow to compile as a loadable kernel module
>>>>   dmaengine: tegra-apb: Remove MODULE_ALIAS
>>>>
>>>>  drivers/dma/Kconfig           |   2 +-
>>>>  drivers/dma/tegra20-apb-dma.c | 481 ++++++++++++++++------------------
>>>>  2 files changed, 220 insertions(+), 263 deletions(-)
>>>
>>> Test results:
>>>   13 builds: 13 pass, 0 fail
>>>   12 boots:  11 pass, 1 fail
>>
>> I'm not sure how to interpret this result. Could you please explain what
>> that fail means?
> 
> Yeah, Jon and I have been discussing about whether to expose this as
> failure or not. Basically what I'm trying to do here is to provide
> automated test results. The way that I'm currently doing this is to run
> these patches through our internal test farm and if the tests succeed,
> send out the results and reply with a Tested-by: to all patches so that
> patchwork has a record of it.
> 
> So just the fact that the test results were sent means the tests passed.
> I do see now that that's not at all clear, so I'm going to have to tweak
> the summary a bit to clarify that.
> 
> I've also added something like this to the bottom of the summary:
> 
> 	Warnings:
> 	- 1 failure for board tegra186-p2771-0000 but tests passed
> 
> This is supposed to indicate that the one failure that you're seeing in
> the test results is an intermittent failure. Looking at the logs I see
> that at some point there was an intermittent boot failure for Jetson TX2
> but then the test farm rebooted the system and then it succeeded and ran
> the tests successfully.
> 
> So I guess in general this means that if you get that test summary and a
> list of Tested-by: replies to the patches, all is well. Unfortunately I
> don't really have a useful way of reporting failure, so I'm not sending
> out a summary in that case. That means you currently can't distinguish
> between whether the series hasn't been tested at all or whether it
> failed. Although, I have also started to use patchwork checks to track
> this in patchwork, so you could look at the patches in patchwork and see
> if they have been tested, and that does record success or failure.

The patchwork now says that all patches in this series failed.

Perhaps something needs to be done about filtering out the unimportant
intermittent noise.

>>>   38 tests:  38 pass, 0 fail
>>>
>>> Linux version: 5.5.0-rc5-gf9d40c056c0f
>>> Boards tested: tegra20-ventana, tegra30-cardhu-a04, tegra124-jetson-tk1,
>>>                tegra186-p2771-0000, tegra194-p2972-0000,
>>>                tegra210-p2371-2180
>>>
>>
>> Will be awesome to see the detailed testing results, at least console
>> log like it was with NVTB.
> 
> Yeah, I'm working on that. It's the only reason I'm not sending out
> failure reports because it would just say that things failed without
> giving you any indication about why.
> 
> Currently the plan is to upload more detailed test results to a public
> location (perhaps github, like nvtb used to) and provide a link to them
> in patchwork and the test summary.
> 
> Do you think that would be helpful?

Yes, the full log is absolutely necessary in a case of problem.

> Anything else you think would be useful to have in these reports?

Optionally, there should be instructions about how to reproduce problem,
which includes rootfs, toolchain and etc.

> Or anything about the above that you think is impractical for you as a contributor?

The intermittent noise should be impractical to report in the short
logs, telling that tests failed. But probably it won't hurt to have a
warning, like you suggested above, and then also to have everything
reported in the detailed log.
