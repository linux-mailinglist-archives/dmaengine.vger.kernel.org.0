Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7714E910
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2020 08:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgAaHNm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jan 2020 02:13:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33138 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgAaHNl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jan 2020 02:13:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00V7DZnN057099;
        Fri, 31 Jan 2020 01:13:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580454815;
        bh=n7YRRXxTreq+7HAtJOKxQ41+gApgSjQtvS2mF0Li8+U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dJfDrIIzOnBFJQ0rjnMAohy6qhC7OjKOFrPlJwOquaRnDHsmtSkuO8P8IG6drvKmD
         NhGdhG5ifW18OyQKn9ymgYgoUO8646fS9x3FglMBJAj353yM1dCPO9CG2CriujQNkc
         4MRippftiJfk9tYiVb90vU9Fk67FPHoD+mBUi6l0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00V7DZD5116750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jan 2020 01:13:35 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 01:13:34 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 01:13:35 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00V7DXLg070011;
        Fri, 31 Jan 2020 01:13:33 -0600
Subject: Re: [PATCH 1/2] dmaengine: Cleanups for the slave <-> channel symlink
 support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200130114220.23538-1-peter.ujfalusi@ti.com>
 <20200130114220.23538-2-peter.ujfalusi@ti.com>
 <CAMuHMdUdhqRU8NmHrcgKQpiVDsuFosWUykZs47HdF9RRCDv-KA@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <fef9eeac-f088-61e8-eecc-a106a6f09224@ti.com>
Date:   Fri, 31 Jan 2020 09:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUdhqRU8NmHrcgKQpiVDsuFosWUykZs47HdF9RRCDv-KA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 30/01/2020 17.20, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Thu, Jan 30, 2020 at 12:41 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> No need to use goto to jump over the
>> return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>> We can just revert the check and return right there.
>>
>> Do not fail the channel request if the chan->name allocation fails, but
>> print a warning about it.
>>
>> Change the dev_err to dev_warn if sysfs_create_link() fails as it is not
>> fatal.
>>
>> Only attempt to remove the DMA_SLAVE_NAME symlink if it is created - or it
>> was attempted to be created.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -756,22 +756,24 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>>         }
>>         mutex_unlock(&dma_list_mutex);
>>
>> -       if (!IS_ERR_OR_NULL(chan))
>> -               goto found;
>> -
>> -       return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>> +       if (IS_ERR_OR_NULL(chan))
>> +               return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>>
>>  found:
>> -       chan->slave = dev;
>>         chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
>> -       if (!chan->name)
>> -               return ERR_PTR(-ENOMEM);
>> +       if (!chan->name) {
>> +               dev_warn(dev,
>> +                        "Cannot allocate memory for slave symlink name\n");
> 
> No need to print a message, as the memory allocator core will have
> screamed already.

Right, I tend to forget this ;)

> 
>> +               return chan;
>> +       }
>> +       chan->slave = dev;
>>
>>         if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
>>                               DMA_SLAVE_NAME))
>> -               dev_err(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
>> +               dev_warn(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
>>         if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
>> -               dev_err(dev, "Cannot create DMA %s symlink\n", chan->name);
>> +               dev_warn(dev, "Cannot create DMA %s symlink\n", chan->name);
>> +
>>         return chan;
>>  }
>>  EXPORT_SYMBOL_GPL(dma_request_chan);
> 
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks,
- Péter

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
