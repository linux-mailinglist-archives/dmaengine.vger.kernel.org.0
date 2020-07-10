Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3621B446
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2020 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGJLuv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jul 2020 07:50:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42456 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgGJLut (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jul 2020 07:50:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06ABoVRb120001;
        Fri, 10 Jul 2020 06:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594381831;
        bh=k8R8ueoWrckBVnJIXngXqqYA2m1bpgdK9FsVJSyK4cA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nxEjUPrUkD1SYfpI36HASLn924kLRQca+UsNW6rUTwtkq0MKKaiqeCs5xswqfZHOV
         6ntIX6dfB5+5Wk6LTGH6PPtYCDyrUg84gdRyhuNzhpjWYYsVagf4YJv4BI41qKrxnM
         vXppq6ZHT1cl3XMqOZYdch9kAP/QXUEANYSzILIY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06ABoV0j089013
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 06:50:31 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 10
 Jul 2020 06:50:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 10 Jul 2020 06:50:31 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06ABoS0w112002;
        Fri, 10 Jul 2020 06:50:29 -0500
Subject: Re: [PATCH v7 04/11] dmaengine: Introduce max SG list entries
 capability
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-5-Sergey.Semin@baikalelectronics.ru>
 <d667adda-6576-623d-6976-30f60ab3c3dc@ti.com>
 <20200710092738.z7zyywe46mp7uuf3@mobilestation>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <427bc5c8-0325-bc25-8637-a7627bcac26f@ti.com>
Date:   Fri, 10 Jul 2020 14:51:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710092738.z7zyywe46mp7uuf3@mobilestation>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sergey,

On 10/07/2020 12.27, Serge Semin wrote:
> Hello Peter
>=20
> On Fri, Jul 10, 2020 at 11:31:47AM +0300, Peter Ujfalusi wrote:
>>
>>
>> On 10/07/2020 1.45, Serge Semin wrote:
>>> Some devices may lack the support of the hardware accelerated SG list=

>>> entries automatic walking through and execution. In this case a burde=
n of
>>> the SG list traversal and DMA engine re-initialization lies on the
>>> DMA engine driver (normally implemented by using a DMA transfer compl=
etion
>>> IRQ to recharge the DMA device with a next SG list entry). But such
>>> solution may not be suitable for some DMA consumers. In particular SP=
I
>>> devices need both Tx and Rx DMA channels work synchronously in order
>>> to avoid the Rx FIFO overflow. In case if Rx DMA channel is paused fo=
r
>>> some time while the Tx DMA channel works implicitly pulling data into=
 the
>>> Rx FIFO, the later will be eventually overflown, which will cause the=
 data
>>> loss. So if SG list entries aren't automatically fetched by the DMA
>>> engine, but are one-by-one manually selected for execution in the
>>> ISRs/deferred work/etc., such problem will eventually happen due to t=
he
>>> non-deterministic latencies of the service execution.
>>
>=20
>> It is not really the number of sg nents which is the problem, but the
>> combination of total number of bytes _and_ the number of nents used to=

>> map them.
>=20
> No, in the case described above the latency only matters.

Sure, the latency comes in (at least for EDMA) when moving from one
sub-sg_list to the next one when needing to break the long list into
smaller chunks. In the sub-completion we need to move to the next chunk.

> The length of the SG
> entries doesn't (at most of extents). The same is with the nents. If th=
ere are
> more than one SG entries in the Rx SG-list handled with the non-determi=
nistic
> latency, the problem may happen at the moment of any Rx SG entry reload=
=2E

You have latency in the hardware when progressing between the sg entries?=


> (In fact the DW DMAC driver is working with so called Linked-List entri=
es,
> which are used to map the SG-list entries into the list of items with l=
ength
> less than or equal to the max block size the engine supports. But for
> simplicity I call them the SG-list entries, since if dma_set_max_seg_si=
ze()
> is specified the mapping will be uniform.)

Right, I'll come back to the dma_set_max_seq_size() later for my cases ;)=


>> The EDMA from TI have similar limitation (we set the limit to 20 nents=
).
>> Longer lists will be broken up to maximum of 20 segment transfers.
>> This setup has bigger impact on audio (cyclic) as we need to limit the=

>> number of periods to not exceed this limit of 20.
>=20
> As I said the problem described above isn't about the number of entries=
, but
> about how they are handled. If there is a latency, then the problem may=
 and most
> like will eventually happen.
>=20
> The complexity of the situation is that the DW DMAC driver may split a =
SG-list
> entry up if its length exceeds max block size the engine supports. That=
's
> why in order to fix the problem described in the patch log the DMA clie=
nt driver
> developed needs to take into account the next two points:
> 1) Detect the maximum number of SG entries the DMA engine can handle wi=
thout the
> non-deterministic latency (you called it max_sg_nents_burst). So the cl=
ient
> drivers would know, that the DMA-channels responsible for Tx and Rx tra=
nsfers
> may be executed with latencies.

This is really useful information for the clients. But in some cases
they just don't care how the list is going to be processed, given if
they have large enough internal FIFO to hold on while the DMA moves from
one chunk to another.

> 2) Make sure the length of each SG-list entry doesn't exceed the max bl=
ock size
> the DW DMAC supports. If some of them does, then the DW DMAC code will =
break
> these SG-entries up into the smaller DMA Linked-list entries, which wil=
l get us
> back to the re-submission latency problem described in the patch log. T=
his
> peculiarity is covered by calling dma_set_max_seg_size() method in the =
DW DMAC
> driver (at least for SPI subsystem it works out-of-box).

This is what does not work for me for neither EDMA or sDMA... The
max_seq_size depends on the src/dst_addr_width the peripheral is
configured. It is different for each DMA_SLAVE_BUSWIDTH_*_BYTES _and_
also for the burst used.

It is on my to-do list to clean up and send this:
https://github.com/omap-audio/linux-audio/commit/dd81de1a343810468b6e7a60=
1e90a9161f46cab1

For EDMA the implementation is:
https://github.com/omap-audio/linux-audio/commit/ee93c45667d0f250baa1e224=
e5d1266fae2e7c80

along the same lines for sDMA:
https://github.com/omap-audio/linux-audio/commit/d6ac68692efcdac8ec233c70=
b802d37f594d6d4d

What is obviously missing is that if the driver does not implement the
device_get_max_len, then dma_get_max_seg_size() of the device should be
returned.

Other option would be:
https://github.com/omap-audio/linux-audio/commit/95dda19c92a3843774185030=
9374a2ca4ef1e361

I'm still hesitating which would be more generic to be acceptable.

And to make things a bit more interesting the UDMA have also different
dma_sg_len() supported depending on what mode the channel is used (TR or
packet mode), but that's another story in itself.

>> The sDMA on the other hand has different limits. Earlier versions
>> without linking support can execute one SG chunk at the time and needs=

>> to reconfigure for the next one -> max_sg_nents is 1 for the older sDM=
As...
>=20
> Yes, this is our case.

Interesting. So you prefer that your clients will use
dmaengine_prep_slave_single() if possible?

>>> In order to let the DMA consumer know about the DMA device capabiliti=
es
>>> regarding the hardware accelerated SG list traversal we introduce the=

>>> max_sg_list capability. It is supposed to be initialized by the DMA e=
ngine
>>> driver with 0 if there is no limitation for the number of SG entries
>>> atomically executed and with non-zero value if there is such constrai=
nts,
>>> so the upper limit is determined by the number set to the property.
>>>
>>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
>>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: linux-mips@vger.kernel.org
>>> Cc: devicetree@vger.kernel.org
>>>
>>> ---
>>>
>>> Changelog v3:
>>> - This is a new patch created as a result of the discussion with Vinu=
d and
>>>   Andy in the framework of DW DMA burst and LLP capabilities.
>>>
>>> Changelog v4:
>>> - Fix of->if typo. It should be definitely of.
>>> ---
>>>  drivers/dma/dmaengine.c   | 1 +
>>>  include/linux/dmaengine.h | 8 ++++++++
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>>> index b332ffe52780..ad56ad58932c 100644
>>> --- a/drivers/dma/dmaengine.c
>>> +++ b/drivers/dma/dmaengine.c
>>> @@ -592,6 +592,7 @@ int dma_get_slave_caps(struct dma_chan *chan, str=
uct dma_slave_caps *caps)
>>>  	caps->directions =3D device->directions;
>>>  	caps->min_burst =3D device->min_burst;
>>>  	caps->max_burst =3D device->max_burst;
>>> +	caps->max_sg_nents =3D device->max_sg_nents;
>>>  	caps->residue_granularity =3D device->residue_granularity;
>>>  	caps->descriptor_reuse =3D device->descriptor_reuse;
>>>  	caps->cmd_pause =3D !!device->device_pause;
>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>>> index 0c7403b27133..a7e4d8dfdd19 100644
>>> --- a/include/linux/dmaengine.h
>>> +++ b/include/linux/dmaengine.h
>>> @@ -467,6 +467,9 @@ enum dma_residue_granularity {
>>>   *	should be checked by controller as well
>>>   * @min_burst: min burst capability per-transfer
>>>   * @max_burst: max burst capability per-transfer
>>> + * @max_sg_nents: max number of SG list entries executed in a single=
 atomic
>>> + *	DMA tansaction with no intermediate IRQ for reinitialization. Zer=
o
>>> + *	value means unlimited number of entries.
>>
>=20
>> Without looking at the comment the name max_sg_nents implies that the
>> DMA can not handle longer lists, but it is not really true.
>> max_sg_nents_burst might be a bit cleaner for the first look?
>=20
> Seems reasonable. I also thought of a better naming so there wouldn't b=
e need to
> read a comment in order get a notion what exactly the parameter is resp=
onsible
> for. Although at the moment of the patchset preparation nothing better =
got in my
> mind.
>=20
> I like what you suggest, but I'd better make it "max_sg_burst" or "max_=
sg_chain".
> What do you think?

Since we should be able to handle longer lists and this is kind of a
hint for clients that above this number of nents the list will be broken
up to smaller 'bursts', which when traversing could cause latency.

sg_chunk_len might be another candidate.

> Vinod?
> Andy (since you've already acked the patch)?
>=20
> -Sergey

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

