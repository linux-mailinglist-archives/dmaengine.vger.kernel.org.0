Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DCA26B647
	for <lists+dmaengine@lfdr.de>; Wed, 16 Sep 2020 02:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgIPABv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Sep 2020 20:01:51 -0400
Received: from foss.arm.com ([217.140.110.172]:36958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgIOOaQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Sep 2020 10:30:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74F231B;
        Tue, 15 Sep 2020 07:19:37 -0700 (PDT)
Received: from [10.57.18.138] (unknown [10.57.18.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9727A3F68F;
        Tue, 15 Sep 2020 07:19:36 -0700 (PDT)
Subject: Re: 6b41030fdc790 broke dmatest badly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20200904173401.GH1891694@smile.fi.intel.com>
 <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
 <20200907120440.GC1891694@smile.fi.intel.com>
 <004640d8-e236-4b75-1bfd-cc386bbf08a6@arm.com>
 <20200907140502.GK1891694@smile.fi.intel.com>
 <54ba60c3-9a04-51ac-688c-425b85202b18@arm.com>
 <578f9c4d-3d29-d1f3-17f7-94dfe24403c4@arm.com>
 <20200915123537.GU3956970@smile.fi.intel.com>
 <d2d43434-d75a-a6cd-c6f9-daaa20260e58@arm.com>
 <20200915134625.GZ3956970@smile.fi.intel.com>
 <20200915135659.GA3956970@smile.fi.intel.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <63be07b9-721b-44fe-14f5-a52ab36ce954@arm.com>
Date:   Tue, 15 Sep 2020 15:20:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200915135659.GA3956970@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 9/15/20 2:56 PM, Andy Shevchenko wrote:
> On Tue, Sep 15, 2020 at 04:46:25PM +0300, Andy Shevchenko wrote:
>> On Tue, Sep 15, 2020 at 01:46:12PM +0100, Vladimir Murzin wrote:
>>> On 9/15/20 1:35 PM, Andy Shevchenko wrote:
>>>> On Fri, Sep 11, 2020 at 09:34:04AM +0100, Vladimir Murzin wrote:
>>>>> On 9/7/20 5:52 PM, Vladimir Murzin wrote:
>>
>> ...
>>
>>>>> An update on this?
>>>>
>>>> Sorry for delay. I have tested your patch and it works for my case. Though I
>>>> would amend it a bit (commit message is still a due).
>>>
>>>
>>> That's good, but what about behaviour prior d53513d5dc28? Did you (or somebody
>>> else) have a chance to confirm that it won't run with plain defaults?
> 
> Yes, I may confirm this. I have taken dmatest just before that commit as of
>   % git checkout 3f3c75541ffe -- drivers/dma/dmatest.c
> and it simple returns 0 and nothing happens.

Thanks a lot for confirmation!

> 
> So, please provide a commit message to your fix, I'll incorporate it and send as a part of the series.
> 

dmaengine: dmatest: Fix regression in run command with mis-configured channel

Andy reported that commit 6b41030fdc79 ("dmaengine: dmatest:
Restore default for channel") broke his scripts for the case
where "busy" channel is used for configuration with expectation
that run command would do nothing (and return 0). Instead,
behavior was (unintentionally) changed to treat such case as
under-configuration and progress with defaults, i.e. run command
would start a test with default setting for channel (which would
use all channels).

Restore original behavior with tracking status of channel setter
so we can distinguish between mis-configured and under-configured
cases in run command and act accordingly.

Fixes: 6b41030fdc79086db5d673c5ed7169f3ee8c13b9 ("dmaengine: dmatest: Restore default for channel")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir

