Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E537BF129
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 13:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfIZLUz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 07:20:55 -0400
Received: from foss.arm.com ([217.140.110.172]:46496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfIZLUy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 07:20:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9053B142F;
        Thu, 26 Sep 2019 04:20:53 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8D1D3F67D;
        Thu, 26 Sep 2019 04:20:50 -0700 (PDT)
Subject: Re: [PATCH 00/11] of: Fix DMA configuration for non-DT masters
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        etnaviv@lists.freedesktop.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Dan Williams <dan.j.williams@intel.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
 <CAL_Jsq+v+svTyna7UzQdRVqfNc5Z_bgWzxNRXv7-Wqv3NwDu2g@mail.gmail.com>
 <d1a31a2ec8eb2f226b1fb41f6c24ffb47c3bf7c7.camel@suse.de>
 <e404c65b-5a66-6f91-5b38-8bf89a7697b2@arm.com>
 <43fb5fe1de317d65a4edf592f88ea150c6e3b8cc.camel@suse.de>
 <CAL_JsqLhx500cx3YLoC7HL1ux3bBpV+fEA2Qnk7D5RFGgiGzSw@mail.gmail.com>
 <aa4c8d62-7990-e385-2bb1-cec55148f0a8@arm.com>
 <CAL_JsqKKYcHPnA80ZwLY=Sk3e5MqrimedUhWQ5+iuPZXQxYHdA@mail.gmail.com>
 <307b988d0c67fb1c42166eca12742bcfda09d92d.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c27a51e1-1adf-ae6a-dc67-ae76222a1163@arm.com>
Date:   Thu, 26 Sep 2019 12:20:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <307b988d0c67fb1c42166eca12742bcfda09d92d.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019-09-26 11:44 am, Nicolas Saenz Julienne wrote:
>>>>> Robin, have you looked into supporting multiple dma-ranges? It's the
>>>>> next thing
>>>>> we need for BCM STB's PCIe. I'll have a go at it myself if nothing is in
>>>>> the
>>>>> works already.
>>>>
>>>> Multiple dma-ranges as far as configuring inbound windows should work
>>>> already other than the bug when there's any parent translation. But if
>>>> you mean supporting multiple DMA offsets and masks per device in the
>>>> DMA API, there's nothing in the works yet.
> 
> Sorry, I meant supporting multiple DMA offsets[1]. I think I could still make
> it with a single DMA mask though.

The main problem for supporting that case in general is the disgusting 
carving up of the physical memory map you may have to do to guarantee 
that a single buffer allocation cannot ever span two windows with 
different offsets. I don't think we ever reached a conclusion on whether 
that was even achievable in practice.

>>> There's also the in-between step of making of_dma_get_range() return a
>>> size based on all the dma-ranges entries rather than only the first one
>>> - otherwise, something like [1] can lead to pretty unworkable default
>>> masks. We implemented that when doing acpi_dma_get_range(), it's just
>>> that the OF counterpart never caught up.
>>
>> Right. I suppose we assume any holes in the ranges are addressable by
>> the device but won't get used for other reasons (such as no memory
>> there). However, to be correct, the range of the dma offset plus mask
>> would need to be within the min start and max end addresses. IOW,
>> while we need to round up (0xa_8000_0000 - 0x2c1c_0000) to the next
>> power of 2, the 'correct' thing to do is round down.
> 
> IIUC I also have this issue on my list. The RPi4 PCIe block has an integration
> bug that only allows DMA to the lower 3GB. With dma-ranges of size 0xc000_0000
> you get a 32bit DMA mask wich is not what you need. So far I faked it in the
> device-tree but I guess it be better to add an extra check in
> of_dma_configure(), decrease the mask and print some kind of warning stating
> that DMA addressing is suboptimal.

Yeah, there's just no way for masks to describe that the device can 
drive all the individual bits, just not in certain combinations :(

The plan I have sketched out there is to merge dma_pfn_offset and 
bus_dma_mask into a "DMA range" descriptor, so we can then hang one or 
more of those off a device to properly cope with all these weird 
interconnects. Conceptually it feels pretty straightforward; I think 
most of the challenge is in implementing it efficiently. Plus there's 
the question of whether it could also subsume the dma_mask as well.

Robin.
