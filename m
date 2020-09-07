Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C881260340
	for <lists+dmaengine@lfdr.de>; Mon,  7 Sep 2020 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgIGNGH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Sep 2020 09:06:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgIGNFy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Sep 2020 09:05:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198841045;
        Mon,  7 Sep 2020 06:05:54 -0700 (PDT)
Received: from [10.57.13.150] (unknown [10.57.13.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215773F66E;
        Mon,  7 Sep 2020 06:05:52 -0700 (PDT)
Subject: Re: 6b41030fdc790 broke dmatest badly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20200904173401.GH1891694@smile.fi.intel.com>
 <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
 <20200907120440.GC1891694@smile.fi.intel.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <004640d8-e236-4b75-1bfd-cc386bbf08a6@arm.com>
Date:   Mon, 7 Sep 2020 14:06:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200907120440.GC1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 9/7/20 1:06 PM, Andy Shevchenko wrote:
> On Mon, Sep 07, 2020 at 12:03:26PM +0100, Vladimir Murzin wrote:
>> On 9/4/20 6:34 PM, Andy Shevchenko wrote:
>>> It becomes a bit annoying to fix dmatest after almost each release.
>>> The commit 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
>>> broke my use case when I tried to start busy channel.
>>>
>>> So, before this patch
>>> 	...
>>> 	echo "busy_chan" > channel
>>> 	echo 1 > run
>>> 	sh: write error: Device or resource busy
>>> 	[ 1013.868313] dmatest: Could not start test, no channels configured
>>>
>>> After I have got it run on *ALL* available channels.
>>
>> Is not that controlled with max_channels? 
> 
> How? I would like to run the test against specific channel. That channel is
> occupied and thus I should get an error. This is how it suppose to work and
> actually did before your patch.

Since you highlighted "ALL" I though that was an issue, yet looks like you
expect run command would do nothing, correct?

IIUC attempt to add already occupied channel is producing error regardless of
my patch and I do not see how error could come from run command.

As for my patch it restores behaviour of how it supposed to work prior d53513d5dc28
where run command would execute with default settings if under-configured.

Cheers
Vladimir

> 
>>> dmatest compiled as a module.
>>>
>>> Fix this ASAP, otherwise I will send revert of this and followed up patch next
>>> week.
>>
>> I don't quite get it, you are sending revert and then a fix rather then helping
>> with a fix?
> 
> Correct.
> 
>> What is reason for such extreme (and non-cooperative) flow?
> 
> There are few reasons:
>  - the patch made a clear regression
>  - I do not understand what that patch is doing and how
>  - I do not have time to look at it
>  - we are now at v5.9-rc4 and it seems like one or two weeks time to get it
>    into v5.9 release
>  - and I'm annoyed by breaking this module not the first time for the last
>    couple of years
> 
> And on top of that it's not how OSS community works. Since you replied, I give
> you time to figure out what's going on and provide necessary testing if needed.
> 
>> P.S.
>> Unfortunately, I do not have access to hardware to run reproducer.
> 
> So, please, propose a fix without it. I will test myself.
> 

