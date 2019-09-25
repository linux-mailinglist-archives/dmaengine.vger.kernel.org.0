Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB50BE2DE
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392033AbfIYQwr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 12:52:47 -0400
Received: from foss.arm.com ([217.140.110.172]:54720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731087AbfIYQwr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Sep 2019 12:52:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37EA81570;
        Wed, 25 Sep 2019 09:52:46 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5133F67D;
        Wed, 25 Sep 2019 09:52:41 -0700 (PDT)
Subject: Re: [PATCH 00/11] of: Fix DMA configuration for non-DT masters
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        etnaviv@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, xen-devel@lists.xenproject.org,
        Dan Williams <dan.j.williams@intel.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
 <CAL_Jsq+v+svTyna7UzQdRVqfNc5Z_bgWzxNRXv7-Wqv3NwDu2g@mail.gmail.com>
 <d1a31a2ec8eb2f226b1fb41f6c24ffb47c3bf7c7.camel@suse.de>
 <e404c65b-5a66-6f91-5b38-8bf89a7697b2@arm.com>
 <43fb5fe1de317d65a4edf592f88ea150c6e3b8cc.camel@suse.de>
 <CAL_JsqLhx500cx3YLoC7HL1ux3bBpV+fEA2Qnk7D5RFGgiGzSw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aa4c8d62-7990-e385-2bb1-cec55148f0a8@arm.com>
Date:   Wed, 25 Sep 2019 17:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLhx500cx3YLoC7HL1ux3bBpV+fEA2Qnk7D5RFGgiGzSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25/09/2019 17:16, Rob Herring wrote:
> On Wed, Sep 25, 2019 at 10:30 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
>>
>> On Wed, 2019-09-25 at 16:09 +0100, Robin Murphy wrote:
>>> On 25/09/2019 15:52, Nicolas Saenz Julienne wrote:
>>>> On Tue, 2019-09-24 at 16:59 -0500, Rob Herring wrote:
>>>>> On Tue, Sep 24, 2019 at 1:12 PM Nicolas Saenz Julienne
>>>>> <nsaenzjulienne@suse.de> wrote:
>>>>>> Hi All,
>>>>>> this series tries to address one of the issues blocking us from
>>>>>> upstreaming Broadcom's STB PCIe controller[1]. Namely, the fact that
>>>>>> devices not represented in DT which sit behind a PCI bus fail to get the
>>>>>> bus' DMA addressing constraints.
>>>>>>
>>>>>> This is due to the fact that of_dma_configure() assumes it's receiving a
>>>>>> DT node representing the device being configured, as opposed to the PCIe
>>>>>> bridge node we currently pass. This causes the code to directly jump
>>>>>> into PCI's parent node when checking for 'dma-ranges' and misses
>>>>>> whatever was set there.
>>>>>>
>>>>>> To address this I create a new API in OF - inspired from Robin Murphys
>>>>>> original proposal[2] - which accepts a bus DT node as it's input in
>>>>>> order to configure a device's DMA constraints. The changes go deep into
>>>>>> of/address.c's implementation, as a device being having a DT node
>>>>>> assumption was pretty strong.
>>>>>>
>>>>>> On top of this work, I also cleaned up of_dma_configure() removing its
>>>>>> redundant arguments and creating an alternative function for the special
>>>>>> cases
>>>>>> not applicable to either the above case or the default usage.
>>>>>>
>>>>>> IMO the resulting functions are more explicit. They will probably
>>>>>> surface some hacky usages that can be properly fixed as I show with the
>>>>>> DT fixes on the Layerscape platform.
>>>>>>
>>>>>> This was also tested on a Raspberry Pi 4 with a custom PCIe driver and
>>>>>> on a Seattle AMD board.
>>>>>
>>>>> Humm, I've been working on this issue too. Looks similar though yours
>>>>> has a lot more churn and there's some other bugs I've found.
>>>>
>>>> That's good news, and yes now that I see it, some stuff on my series is
>>>> overly
>>>> complicated. Specially around of_translate_*().
>>>>
>>>> On top of that, you removed in of_dma_get_range():
>>>>
>>>> -   /*
>>>> -    * At least empty ranges has to be defined for parent node if
>>>> -    * DMA is supported
>>>> -    */
>>>> -   if (!ranges)
>>>> -           break;
>>>>
>>>> Which I assumed was bound to the standard and makes things easier.
>>>>
>>>>> Can you test out this branch[1]. I don't have any h/w needing this,
>>>>> but wrote a unittest and tested with modified QEMU.
>>>>
>>>> I reviewed everything, I did find a minor issue, see the patch attached.
>>>
>>> WRT that patch, the original intent of "force_dma" was purely to
>>> consider a device DMA-capable regardless of the presence of
>>> "dma-ranges". Expecting of_dma_configure() to do anything for a non-OF
>>> device has always been bogus - magic paravirt devices which appear out
>>> of nowhere and expect to be treated as genuine DMA masters are a
>>> separate problem that we haven't really approached yet.
>>
>> I agree it's clearly abusing the function. I have no problem with the behaviour
>> change if it's OK with you.

Thinking about it, you could probably just remove that call from the Xen 
DRM driver now anyway - since the dma-direct rework, we lost the ability 
to set dma_dummy_ops by default, and NULL ops now represent what it 
(presumably) wants.

>> Robin, have you looked into supporting multiple dma-ranges? It's the next thing
>> we need for BCM STB's PCIe. I'll have a go at it myself if nothing is in the
>> works already.
> 
> Multiple dma-ranges as far as configuring inbound windows should work
> already other than the bug when there's any parent translation. But if
> you mean supporting multiple DMA offsets and masks per device in the
> DMA API, there's nothing in the works yet.

There's also the in-between step of making of_dma_get_range() return a 
size based on all the dma-ranges entries rather than only the first one 
- otherwise, something like [1] can lead to pretty unworkable default 
masks. We implemented that when doing acpi_dma_get_range(), it's just 
that the OF counterpart never caught up.

Robin.

[1] 
http://linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=a2814af56b3486c2985a95540a88d8f9fa3a699f
