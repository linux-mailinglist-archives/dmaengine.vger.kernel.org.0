Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6661914E98B
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2020 09:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgAaI2p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Jan 2020 03:28:45 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42586 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgAaI2p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Jan 2020 03:28:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00V8SZds077240;
        Fri, 31 Jan 2020 02:28:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580459315;
        bh=Q6+uODC6UU0RZ60lAwhGLHFnFw4uX3uuIGYWRdW03N8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jT+scpwXJ5spXLxOTFrgAUTD7cHyKsadc6D+HNBWJXgcYzPhmgOXA+YBHVfA5xDEX
         qee9RQh1Ngzy1+8AUpV7HK4ze+ir2gK7pawKiXCM8/jd1NJpJJJJjfu/+8foNXidLX
         cYUB+kD8dKYk9YTgXbewu0kObONgMaunBE3CKqz8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00V8SZo6092704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jan 2020 02:28:35 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 02:28:34 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 02:28:34 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00V8SXkX022605;
        Fri, 31 Jan 2020 02:28:33 -0600
Subject: Re: [PATCH 2/2] dmaengine: Add basic debugfs support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200130114220.23538-1-peter.ujfalusi@ti.com>
 <20200130114220.23538-3-peter.ujfalusi@ti.com>
 <CAMuHMdWXuoWX=AgB=RY=5At_yw6nZJGBOK_8TXjwgYQN27JcQQ@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <aa574e2e-222c-de76-dbc5-b117190648d6@ti.com>
Date:   Fri, 31 Jan 2020 10:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWXuoWX=AgB=RY=5At_yw6nZJGBOK_8TXjwgYQN27JcQQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 30/01/2020 17.42, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Thu, Jan 30, 2020 at 12:41 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> Via the /sys/kernel/debug/dmaengine users can get information about the
>> DMA devices and the used channels.
>>
>> Example output on am654-evm with audio using two channels and after running
>> dmatest on 6 channels:
>>
>>  # cat /sys/kernel/debug/dmaengine
>> dma0 (285c0000.dma-controller): number of channels: 96
>>
>> dma1 (31150000.dma-controller): number of channels: 267
>>  dma1chan0:             2b00000.mcasp:tx
>>  dma1chan1:             2b00000.mcasp:rx
>>  dma1chan2:             in-use
>>  dma1chan3:             in-use
>>  dma1chan4:             in-use
>>  dma1chan5:             in-use
>>  dma1chan6:             in-use
>>  dma1chan7:             in-use
>>
>> For slave channels we can show the device and the channel name a given
>> channel is requested.
>> For non slave devices the only information we know is that the channel is
>> in use.
>>
>> DMA drivers can implement the optional dbg_show callback to provide
>> controller specific information instead of the generic one.
>>
>> It is easy to extend the generic dmaengine_dbg_show() to print additional
>> information about the used channels.
>>
>> I have taken the idea from gpiolib.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Thanks for your patch!
> 
> On Salvator-XS with R-Car H3 ES2.0:
> 
>     dma0 (ec700000.dma-controller): number of channels: 15
> 
>     dma1 (ec720000.dma-controller): number of channels: 15
> 
>     dma2 (e65a0000.dma-controller): number of channels: 2
>      dma2chan0: e6590000.usb:ch0
>      dma2chan1: e6590000.usb:ch1
> 
>     dma3 (e65b0000.dma-controller): number of channels: 2
>      dma3chan0: e6590000.usb:ch2
>      dma3chan1: e6590000.usb:ch3
> 
>     dma4 (e6460000.dma-controller): number of channels: 2
>      dma4chan0: e659c000.usb:ch0
>      dma4chan1: e659c000.usb:ch1
> 
>     dma5 (e6470000.dma-controller): number of channels: 2
>      dma5chan0: e659c000.usb:ch2
>      dma5chan1: e659c000.usb:ch3
> 
>     dma6 (e6700000.dma-controller): number of channels: 15
> 
>     dma7 (e7300000.dma-controller): number of channels: 15
>      dma7chan0: e6510000.i2c:tx
> 
>     dma8 (e7310000.dma-controller): number of channels: 15
>      dma8chan0: e6550000.serial:tx
>      dma8chan1: e6550000.serial:rx

You have lots of DMAs over there ;)

>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -760,6 +761,13 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>>                 return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>>
>>  found:
>> +#ifdef CONFIG_DEBUG_FS
>> +       chan->slave_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev), name);
>> +       if (!chan->slave_name)
>> +               dev_warn(dev,
>> +                        "Cannot allocate memory for slave name (debugfs)\n");
> 
> No need to print a message, as the memory allocation core already takes
> care of that.

Right.

> But, do you really need chan->slave_name?
> You already have chan->slave and chan->name.

The chan->name is prefixed with "dma:" it would not look right.
In production this all go away as debugfs most likely disabled.
But I will change the name to dbg_client_name.

> 
>> +#endif
>> +
>>         chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
>>         if (!chan->name) {
>>                 dev_warn(dev,
> 
>> @@ -1562,3 +1577,108 @@ static int __init dma_bus_init(void)
>>         return class_register(&dma_devclass);
>>  }
>>  arch_initcall(dma_bus_init);
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +static void *dmaengine_seq_start(struct seq_file *s, loff_t *pos)
>> +{
>> +       struct dma_device *dma_dev = NULL;
>> +       loff_t index = *pos;
>> +
>> +       s->private = "";
>> +
>> +       mutex_lock(&dma_list_mutex);
>> +       list_for_each_entry(dma_dev, &dma_device_list, global_node)
>> +               if (index-- == 0) {
>> +                       mutex_unlock(&dma_list_mutex);
>> +                       return dma_dev;
> 
> Can the dma_device go away after unlocking the list?
> Unlike dma_request_chan(), this doesn't increase a refcnt.

It could, let me see what I can do. Probably locking the dma_device_list
for the duration of the show.

>> +               }
>> +       mutex_unlock(&dma_list_mutex);
>> +
>> +       return NULL;
>> +}
>> +
>> +static void *dmaengine_seq_next(struct seq_file *s, void *v, loff_t *pos)
>> +{
>> +       struct dma_device *dma_dev = v;
>> +       void *ret = NULL;
>> +
>> +       mutex_lock(&dma_list_mutex);
>> +       if (list_is_last(&dma_dev->global_node, &dma_device_list))
>> +               ret = NULL;
>> +       else
>> +               ret = list_entry(dma_dev->global_node.next,
>> +                                struct dma_device, global_node);
>> +       mutex_unlock(&dma_list_mutex);
> 
> Likewise.
> 
>> +
>> +       s->private = "\n";
>> +       ++*pos;
>> +
>> +       return ret;
>> +}
>> +
>> +static void dmaengine_seq_stop(struct seq_file *s, void *v)
>> +{
>> +}
>> +
>> +static void dmaengine_dbg_show(struct seq_file *s, struct dma_device *dma_dev)
>> +{
>> +       struct dma_chan *chan;
>> +
>> +       list_for_each_entry(chan, &dma_dev->channels, device_node) {
>> +               if (chan->client_count) {
>> +                       seq_printf(s, " dma%dchan%d:", dma_dev->dev_id,
>> +                                  chan->chan_id);
>> +                       if (chan->slave_name)
>> +                               seq_printf(s, "\t\t%s\n", chan->slave_name);
>> +                       else
>> +                               seq_printf(s, "\t\t%s\n", "in-use");
> 
> The truncated ternary operator might help here:
> 
>         seq_printf(s, "\t\t%s\n", chan->slave_name ?: "in-use");
> 
> However, you might as well just use dev_name(chan->slave) and chan->name
> instead of chan->slave_name.

"2b00000.mcasp" + "dma:tx" would be an awkward combination ;)

> 
>> +               }
>> +       }
>> +}
>> +
>> +static int dmaengine_seq_show(struct seq_file *s, void *v)
>> +{
>> +       struct dma_device *dma_dev = v;
>> +
>> +       seq_printf(s, "%sdma%d (%s): number of channels: %u\n",
>> +                  (char *)s->private, dma_dev->dev_id, dev_name(dma_dev->dev),
>> +                  dma_dev->chancnt);
>> +
>> +       if (dma_dev->dbg_show)
>> +               dma_dev->dbg_show(s, dma_dev);
> 
> So providing a custom .dbg_show() means replacing the standard info, not
> augmenting it?

Correct, if a DMA driver decides to implement it, then it is it's
responsibility to show things after the
"dma%d (%s): number of channels: %u\n" line.

The standard infor is pretty minimal and not sure if it can be more verbose.
Oh, I can add the router information if it is used.

> 
>> +       else
>> +               dmaengine_dbg_show(s, dma_dev);
>> +
>> +       return 0;
>> +}
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
