Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6815BE0E4
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfIYPJV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 11:09:21 -0400
Received: from foss.arm.com ([217.140.110.172]:51802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437241AbfIYPJU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Sep 2019 11:09:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E381000;
        Wed, 25 Sep 2019 08:09:19 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A1433F59C;
        Wed, 25 Sep 2019 08:09:14 -0700 (PDT)
Subject: Re: [PATCH 00/11] of: Fix DMA configuration for non-DT masters
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, etnaviv@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-pci@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        james.quinlan@broadcom.com, Stefan Wahren <wahrenst@gmx.net>,
        Dan Williams <dan.j.williams@intel.com>,
        freedreno <freedreno@lists.freedesktop.org>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
 <CAL_Jsq+v+svTyna7UzQdRVqfNc5Z_bgWzxNRXv7-Wqv3NwDu2g@mail.gmail.com>
 <d1a31a2ec8eb2f226b1fb41f6c24ffb47c3bf7c7.camel@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e404c65b-5a66-6f91-5b38-8bf89a7697b2@arm.com>
Date:   Wed, 25 Sep 2019 16:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d1a31a2ec8eb2f226b1fb41f6c24ffb47c3bf7c7.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25/09/2019 15:52, Nicolas Saenz Julienne wrote:
> On Tue, 2019-09-24 at 16:59 -0500, Rob Herring wrote:
>> On Tue, Sep 24, 2019 at 1:12 PM Nicolas Saenz Julienne
>> <nsaenzjulienne@suse.de> wrote:
>>> Hi All,
>>> this series tries to address one of the issues blocking us from
>>> upstreaming Broadcom's STB PCIe controller[1]. Namely, the fact that
>>> devices not represented in DT which sit behind a PCI bus fail to get the
>>> bus' DMA addressing constraints.
>>>
>>> This is due to the fact that of_dma_configure() assumes it's receiving a
>>> DT node representing the device being configured, as opposed to the PCIe
>>> bridge node we currently pass. This causes the code to directly jump
>>> into PCI's parent node when checking for 'dma-ranges' and misses
>>> whatever was set there.
>>>
>>> To address this I create a new API in OF - inspired from Robin Murphys
>>> original proposal[2] - which accepts a bus DT node as it's input in
>>> order to configure a device's DMA constraints. The changes go deep into
>>> of/address.c's implementation, as a device being having a DT node
>>> assumption was pretty strong.
>>>
>>> On top of this work, I also cleaned up of_dma_configure() removing its
>>> redundant arguments and creating an alternative function for the special
>>> cases
>>> not applicable to either the above case or the default usage.
>>>
>>> IMO the resulting functions are more explicit. They will probably
>>> surface some hacky usages that can be properly fixed as I show with the
>>> DT fixes on the Layerscape platform.
>>>
>>> This was also tested on a Raspberry Pi 4 with a custom PCIe driver and
>>> on a Seattle AMD board.
>>
>> Humm, I've been working on this issue too. Looks similar though yours
>> has a lot more churn and there's some other bugs I've found.
> 
> That's good news, and yes now that I see it, some stuff on my series is overly
> complicated. Specially around of_translate_*().
> 
> On top of that, you removed in of_dma_get_range():
> 
> -	/*
> -	 * At least empty ranges has to be defined for parent node if
> -	 * DMA is supported
> -	 */
> -	if (!ranges)
> -		break;
> 
> Which I assumed was bound to the standard and makes things easier.
> 
>> Can you test out this branch[1]. I don't have any h/w needing this,
>> but wrote a unittest and tested with modified QEMU.
> 
> I reviewed everything, I did find a minor issue, see the patch attached.

WRT that patch, the original intent of "force_dma" was purely to 
consider a device DMA-capable regardless of the presence of 
"dma-ranges". Expecting of_dma_configure() to do anything for a non-OF 
device has always been bogus - magic paravirt devices which appear out 
of nowhere and expect to be treated as genuine DMA masters are a 
separate problem that we haven't really approached yet.

Robin.
