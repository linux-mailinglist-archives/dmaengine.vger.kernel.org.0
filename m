Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69C14D8D9
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 11:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgA3KWI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 05:22:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47828 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgA3KWI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 05:22:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00UALqEk116713;
        Thu, 30 Jan 2020 04:21:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580379712;
        bh=kfF8u1Xp5NL1vqZWDVbstWL95hLxrd0Jlnj/4YhudLA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iQQD7TMZ8qDhhjjRaizXsbs/ppQPdYbHwKbYXVC7qrgW4EHYKChs/OuEoA4YOMyFO
         fBNeNxpfW+LJX5EVAIij8jbyqmo+NwO5uMSVI+HgqRswAWGFwNWzYI0wNPZLoe+Zv3
         9UEJC9WCJs0bcjEitxDIMrq29Woj01TNPJC6ChxE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00UALqZw070734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jan 2020 04:21:52 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 30
 Jan 2020 04:21:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 30 Jan 2020 04:21:51 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UALn2A106430;
        Thu, 30 Jan 2020 04:21:50 -0600
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <e219bc58-0d30-582f-4872-559097f212d2@ti.com>
 <CAMuHMdWim4kq=JCrprybMOA+ipaxNTm4+zgjrmoFxffM+nSnPw@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <bdba1ecd-b47a-f790-7385-cfad364423df@ti.com>
Date:   Thu, 30 Jan 2020 12:22:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWim4kq=JCrprybMOA+ipaxNTm4+zgjrmoFxffM+nSnPw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 30/01/2020 11.51, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Thu, Jan 30, 2020 at 10:42 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> On 17/01/2020 17.30, Geert Uytterhoeven wrote:
>>> Currently it is not easy to find out which DMA channels are in use, and
>>> which slave devices are using which channels.
>>>
>>> Fix this by creating two symlinks between the DMA channel and the actual
>>> slave device when a channel is requested:
>>>   1. A "slave" symlink from DMA channel to slave device,
>>>   2. A "dma:<name>" symlink slave device to DMA channel.
>>> When the channel is released, the symlinks are removed again.
>>> The latter requires keeping track of the slave device and the channel
>>> name in the dma_chan structure.
>>>
>>> Note that this is limited to channel request functions for requesting an
>>> exclusive slave channel that take a device pointer (dma_request_chan()
>>> and dma_request_slave_channel*()).
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>>> --- a/drivers/dma/dmaengine.c
>>> +++ b/drivers/dma/dmaengine.c
>>> @@ -60,6 +60,8 @@ static long dmaengine_ref_count;
>>>
>>>  /* --- sysfs implementation --- */
>>>
>>> +#define DMA_SLAVE_NAME       "slave"
>>> +
>>>  /**
>>>   * dev_to_dma_chan - convert a device pointer to its sysfs container object
>>>   * @dev - device node
>>> @@ -730,11 +732,11 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>>>       if (has_acpi_companion(dev) && !chan)
>>>               chan = acpi_dma_request_slave_chan_by_name(dev, name);
>>>
>>> -     if (chan) {
>>> -             /* Valid channel found or requester needs to be deferred */
>>> -             if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
>>> -                     return chan;
>>> -     }
>>> +     if (PTR_ERR(chan) == -EPROBE_DEFER)
>>> +             return chan;
>>> +
>>> +     if (!IS_ERR_OR_NULL(chan))
>>> +             goto found;
>>>
>>>       /* Try to find the channel via the DMA filter map(s) */
>>>       mutex_lock(&dma_list_mutex);
>>> @@ -754,7 +756,23 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>>>       }
>>>       mutex_unlock(&dma_list_mutex);
>>>
>>> -     return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>>> +     if (!IS_ERR_OR_NULL(chan))
>>> +             goto found;
>>> +
>>> +     return ERR_PTR(-EPROBE_DEFER);
>>> +
>>> +found:
>>> +     chan->slave = dev;
>>> +     chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
>>> +     if (!chan->name)
>>> +             return ERR_PTR(-ENOMEM);
>>
>> You will lock the channel... It is requested, but it is not released in
>> case of failure.
> 
> True. Perhaps this error should just be ignored, cfr. below.
> However, if this operation fails, chances are high the system will die very soon
> anyway.

Yeah, I'll fix it up in a series I'm preparing.

> 
>>> +
>>> +     if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
>>> +                           DMA_SLAVE_NAME))
>>> +             dev_err(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
>>> +     if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
>>> +             dev_err(dev, "Cannot create DMA %s symlink\n", chan->name);
>>
>> It is not a problem if these fail?
> 
> IMHO, a failure to create these links is not fatal for the operation of
> the device, and thus can be ignored.  Just like for debugfs.

OK, then these should not be dev_err, but dev_warn.
I'll include this is also in a fixup patch.

> 
>>> +     return chan;
>>>  }
>>>  EXPORT_SYMBOL_GPL(dma_request_chan);
>>>
>>> @@ -812,6 +830,13 @@ void dma_release_channel(struct dma_chan *chan)
>>>       /* drop PRIVATE cap enabled by __dma_request_channel() */
>>>       if (--chan->device->privatecnt == 0)
>>>               dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
>>> +     if (chan->slave) {
>>> +             sysfs_remove_link(&chan->slave->kobj, chan->name);
>>> +             kfree(chan->name);
>>> +             chan->name = NULL;
>>> +             chan->slave = NULL;
>>> +     }
>>> +     sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
>>
>> If a non slave channel is released, then you remove the link you have
>> never created?
>>
>> What happens if the link creation fails and here you attempt to remove
>> the failed ones?
> 
> sysfs_remove_link() should handle removing non-existent links, and just
> return -ENOENT.

True, just followed the call chain and tested as well, but the
DMA_SLAVE_NAME symlink should be also removed within the
if (chan->slave) {} block as it is never created for non slave channels.

Also including inn my fixup patch.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
