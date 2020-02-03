Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B321505E2
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 13:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgBCMJe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 07:09:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37570 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBCMJe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 07:09:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 013C9UFg015233;
        Mon, 3 Feb 2020 06:09:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580731770;
        bh=Azrd1Ga5O4/syHeRQpUf0nWLHJyST0WafXdUhsLe1do=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yPqwuhTiPKFrHxk0+wyqxYYE7fET9ZZf1jFsTSAa26ZRsOVIudcHlvzOmmPw2JjVZ
         iVzcitpAA5pGl5W4htaSL7Bc4kBJHFRgPDbPIeva327keFBqhI5Bd+9KQrPuRmbsEM
         2VwziHX+KTYBkow+8OGjrXpZ+t3KSJZhPGIJGaOM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 013C9U30121750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Feb 2020 06:09:30 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 06:09:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 06:09:30 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013C9SKQ091675;
        Mon, 3 Feb 2020 06:09:28 -0600
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
 <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
Date:   Mon, 3 Feb 2020 14:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

On 03/02/2020 13.16, Andy Shevchenko wrote:
> On Mon, Feb 3, 2020 at 12:59 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> On 03/02/2020 12.37, Andy Shevchenko wrote:
>>> On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
>>>> Advise users of dma_request_slave_channel() and
>>>> dma_request_slave_channel_compat() to move to dma_request_slave_chan()
>>>
>>> How? There are legacy ARM boards you have to care / remove before.
>>> DMAengine subsystem makes a p*s off decisions
>>
>> The dma_slave_map support is added few years back for the legacy ARM
>> boards, because we do care.
>> daVinci, OMAP1, pxa, s3cx4xx and even m68k/coldfire moved over.
> 
> Then why simple not to convert (start converting) those few drivers to
> new API and simple remove the old one?

_if_ the dma_request_slave_channel_compat() is really falling back after
dma_request_chan() - this is what it calls first, then it is not a
simple convert to a new API.
1. The arch needs to define the dma_slave_map for the SoC.
2. The dma driver needs few lines to add it to DMAengine core (+pdata
change).
After this the _compat() can be replaced with dma_request_chan()

In most cases I do not have access to documentation and boards to test.

Looking at the output of 'git grep dma_request_slave_channel_compat':
drivers/mmc/host/renesas_sdhi_sys_dmac.c
drivers/spi/spi-pxa2xx-dma.c
drivers/spi/spi-rspi.c
drivers/spi/spi-sh-msiof.c
drivers/tty/serial/8250/8250_dma.c

From these rspi boots only in DT and I'm not sure about the others.
8250_dma is a tricky one as it is used as generic DMA layer for many arch.

>> Imho it is confusing to have 4+ APIs to do the same thing, but in a
>> slightly different way.
> 
> It was always an excuse by authors "that too many drivers to convert..."

Sure, but before you accuse anyone with neglect, can you check the git
log for 'dma_request_slave_channel' in the commit messages?

>>> without taking care of
>>> (I'm talking now about dma release callback, for example) end users.
>>
>> I have been converting users in the background, but the _compat() is a
>> bit more problematic as I need to maintainers of those legacy platforms
>> to craft the map. If they care.
> 
> Why not to remove them and don't punish users of new drivers / platforms?

The _compat() can not be removed, but we just don't know who really
needs the fallback after dma_request_chan().
With the print the hope is that users will come forward and we can help
migrate or address their specific needs.

>> Obviously the APIs are not going to be removed if we have a single user
>> and if there is clearly a need for something the _compat() was doing and
>> it can not be done via the dma_slave_map, then rest assured there will
>> be a clean API to achieve just that.
>>
>>> They will be scary for no reason.
>>
>> There is a reason: to clean up the API to make it non confusing for the
>> users.
> 
> No, it's a reason when you first take care of existing users and
> decide to obsolete an API followed by removal few releases later.

I'm fine to drop the pr_info() and the __deprecated mark for
dma_request_slave_channel.

> But
> I see no reason to keep such APIs at all, so, instead of this
> *wonderful* messages perhaps somebody should do better work?

To touch the _compat() variant one needs to have access to the
documentation of the SoC on which the code falls back. It is not a
matter of sloppy/poor/ignorant/etc work attitude.
I have kept clear on touching those few drivers using it [1] as I don't
have documentation.

>> New drivers should not use the old API i new code and developers tend to
>> pick the API they use after a quick 'git grep dma_request_' and see what
>> the majority is using.
> 
> Isn't it a point to do better review rather than scary end users?

Sure, but we rarely CCd on new client drivers for DMAengine API usage.

[1] fwiw, there are drivers using dma_request_channel() and by the look
their use is either _compat() or the dma_request_chan_by_mask() style
and some even have a twist here and there...

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
