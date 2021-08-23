Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459373F5140
	for <lists+dmaengine@lfdr.de>; Mon, 23 Aug 2021 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhHWT0x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Aug 2021 15:26:53 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:18175 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWT0x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Aug 2021 15:26:53 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d46 with ME
        id l7S6250083riaq2037S6H5; Mon, 23 Aug 2021 21:26:09 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Aug 2021 21:26:09 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH] dmaengine: switch from 'pci_' to 'dma_' API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        vireshk@kernel.org, wangzhou1@hisilicon.com, logang@deltatee.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <547fae4abef1ca3bf2198ca68e6c361b4d02f13c.1629635852.git.christophe.jaillet@wanadoo.fr>
 <YSNOTX68ltbt2hwf@smile.fi.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <fe9d57ff-bd44-3cee-516e-6815213ef467@wanadoo.fr>
Date:   Mon, 23 Aug 2021 21:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSNOTX68ltbt2hwf@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 23/08/2021 à 09:29, Andy Shevchenko a écrit :
> On Sun, Aug 22, 2021 at 02:40:22PM +0200, Christophe JAILLET wrote:
>> The wrappers in include/linux/pci-dma-compat.h should go away.
>>
>> The patch has been generated with the coccinelle script below.
>>
>> It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
>> 'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
>> This is less verbose.
>>
>> It has been compile tested.
> 
>> @@
>> expression e1, e2;
>> @@
>> -    pci_set_consistent_dma_mask(e1, e2)
>> +    dma_set_coherent_mask(&e1->dev, e2)
> 
> Can we, please, replace this long noise in the commit message with a link to a
> script in coccinelle data base?

Hi,

There is no script in the coccinelle data base up to now, and there is 
no point in adding one now.
The goal of these patches is to remove a deprecated API, so when the job 
will be finished, this script would be of no use and would be removed.

However, I agree that the script as-is is noisy.

I'll replace it with a link to a message already available in lore.

> 
> And the same comment for any future submission that are based on the scripts
> (esp. coccinelle ones).

I usually don't add my coccinelle scripts in the log, but I've been told 
times ago that adding them was a good practice (that I have never 
followed...).

In this particular case, I thought it was helpful for a reviewer to see 
how the automated part had been processed.

> 
> ...
> 
>> This patch is mostly mechanical and compile tested. I hope it is ok to
>> update the "drivers/dma/" directory all at once.
> 
> There is another discussion with Hellwig [1] about 64-bit DMA mask,
> i.e. it doesn't fail anymore,

Yes, I'm aware of this thread.

I've not taken it into account for 2 reasons:
    - it goes beyond the goal of these patches (i.e. the removal of a 
deprecated API)
    - I *was* not 100% confident about [1].

I *was* giving credit to comment such as [2]. And the pattern "if 64 
bits fails, then switch to 32 bits" is really common.
Maybe it made sense in the past and has remained as-is.


However, since then I've looked at all the architecture specific 
implementation of 'dma_supported()' and [1] looks indeed correct :)


I propose to make these changes in another serie which will mention [1] 
and see the acceptance rate in the different subsystems. (i.e. even if 
the patch is correct, removing what looks like straightforward code may 
puzzle a few of us)

I would start it once "pci-dma-compat.h" has been removed.

Do you agree, or do you want it integrated in the WIP?

Anyway, thanks for the review and comments.

CJ

> so you need to rework drivers accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 

[2]: 
https://elixir.bootlin.com/linux/v5.14-rc7/source/drivers/infiniband/hw/hfi1/pcie.c#L98
