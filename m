Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB03F529A
	for <lists+dmaengine@lfdr.de>; Mon, 23 Aug 2021 23:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhHWVMR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Aug 2021 17:12:17 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:29932 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232503AbhHWVMR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Aug 2021 17:12:17 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d73 with ME
        id l9BV250033riaq2039BVFG; Mon, 23 Aug 2021 23:11:32 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Aug 2021 23:11:32 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH] dmaengine: switch from 'pci_' to 'dma_' API
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        vireshk@kernel.org, wangzhou1@hisilicon.com, logang@deltatee.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <547fae4abef1ca3bf2198ca68e6c361b4d02f13c.1629635852.git.christophe.jaillet@wanadoo.fr>
 <YSNOTX68ltbt2hwf@smile.fi.intel.com>
 <fe9d57ff-bd44-3cee-516e-6815213ef467@wanadoo.fr>
 <alpine.DEB.2.22.394.2108232145590.17496@hadrien>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <48a26eaf-513e-d989-7432-ceffc7d6328b@wanadoo.fr>
Date:   Mon, 23 Aug 2021 23:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2108232145590.17496@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 23/08/2021 à 21:47, Julia Lawall a écrit :
> 
> 
> On Mon, 23 Aug 2021, Christophe JAILLET wrote:
> 
>> Le 23/08/2021 à 09:29, Andy Shevchenko a écrit :
>>> On Sun, Aug 22, 2021 at 02:40:22PM +0200, Christophe JAILLET wrote:
>>>> The wrappers in include/linux/pci-dma-compat.h should go away.
>>>>
>>>> The patch has been generated with the coccinelle script below.
>>>>
>>>> It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
>>>> 'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
>>>> This is less verbose.
>>>>
>>>> It has been compile tested.
>>>
>>>> @@
>>>> expression e1, e2;
>>>> @@
>>>> -    pci_set_consistent_dma_mask(e1, e2)
>>>> +    dma_set_coherent_mask(&e1->dev, e2)
>>>
>>> Can we, please, replace this long noise in the commit message with a link to
>>> a
>>> script in coccinelle data base?
>>
>> Hi,
>>
>> There is no script in the coccinelle data base up to now, and there is no
>> point in adding one now.
>> The goal of these patches is to remove a deprecated API, so when the job will
>> be finished, this script would be of no use and would be removed.
>>
>> However, I agree that the script as-is is noisy.
>>
>> I'll replace it with a link to a message already available in lore.
> 
> You can perhaps include a script that represents a very typical case or
> the specific case that is relevant to the patch.
> 
> julia
> 
> 
Hi julia,

I still have to post ~9 of such patches.
I'll try your proposal to only include relevant part of the script.
It should be do-able.

The most puzzling in the remaining files is:
    drivers/char/xillybus/xillybus_pcie.c

In this driver, 'xilly_pci_direction()' looks odd and somewhat useless 
(but I'll let it more or less as-is. It may catch corner cases)

What puzzles me is "struct xilly_mapping" where the "void *" seems to
hold different kinds of pointer depending of the context.

I could add some casting but would prefer to avoid this and have a 
cleaner solution.

I've not look in detail yet but my first attempt were not very conclusive.



"message/fusion" has not been Acked yet.
All patches have been posted but there are huge and I can easily 
understand that reviewing them is complex because of the GFP_KERNEL I 
introduce. Only one has been merged yet.
Moreover, according to -next logs, no single other patch has been merged 
since end of June.

CJ
