Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718F1142A09
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2020 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgATMG2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jan 2020 07:06:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49776 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgATMG2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jan 2020 07:06:28 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00KC6HuV076287;
        Mon, 20 Jan 2020 06:06:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579521977;
        bh=Z9noDxBqHLJiwsDBGAYw1GuUMNodrJKgcOswZfE6cEM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fc4gDPS98yw0zZlTP7pDNEQraGkMWtEi8eY9kSajObZDK0FBUzXa3EjZOWGGfKxRs
         kR8dz1FJbInEYqLZY3V5tvjTkqQQcCj2Ga7ZALJFYZNO58aMlh/yDIanq79PXBj0YC
         2lWOFuIk6mRMF4mTwH4PQcjJkXcKdE+x153wTWQo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00KC6Ho7025613;
        Mon, 20 Jan 2020 06:06:17 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 20
 Jan 2020 06:06:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 20 Jan 2020 06:06:16 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00KC6E86055498;
        Mon, 20 Jan 2020 06:06:14 -0600
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
 <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
 <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com>
 <CAMuHMdU=-Eo29=DQmq96OegdYAvW7Vw9PpgNWSTfjDWVF5jd-A@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f7bbb132-1278-7030-7f40-b89733bcbd83@ti.com>
Date:   Mon, 20 Jan 2020 14:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU=-Eo29=DQmq96OegdYAvW7Vw9PpgNWSTfjDWVF5jd-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 20/01/2020 12.51, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Mon, Jan 20, 2020 at 11:16 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> On 20/01/2020 11.01, Geert Uytterhoeven wrote:
>>> On Fri, Jan 17, 2020 at 9:08 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>>> On 1/17/20 5:30 PM, Geert Uytterhoeven wrote:
>>>>> Currently it is not easy to find out which DMA channels are in use, and
>>>>> which slave devices are using which channels.
>>>>>
>>>>> Fix this by creating two symlinks between the DMA channel and the actual
>>>>> slave device when a channel is requested:
>>>>>   1. A "slave" symlink from DMA channel to slave device,
>>>>
>>>> Have you considered similar link name as on the slave device:
>>>> slave:<name>
>>>>
>>>> That way it would be easier to grasp which channel is used for what
>>>> purpose by only looking under /sys/class/dma/ and no need to check the
>>>> slave device.
>>>
>>> Would this really provide more information?
>>> The device name is already provided in the target of the symlink:
>>>
>>> root@koelsch:~# readlink
>>> /sys/devices/platform/soc/e6720000.dma-controller/dma/dma1chan2/slave
>>> ../../../ee140000.sd
>>
>> e6720000.dma-controller/dma/dma1chan2/slave -> ../../../ee140000.sd
>> e6720000.dma-controller/dma/dma1chan3/slave -> ../../../ee140000.sd
>>
>> It is hard to tell which one is the tx and RX channel without looking
>> under the ee140000.sd:
>>
>> ee140000.sd/dma:rx -> ../e6720000.dma-controller/dma/dma1chan3
>> ee140000.sd/dma:tx -> ../e6720000.dma-controller/dma/dma1chan2
> 
> Oh, you meant the name of the channel, not the name of the device.
> My mistake.
>
> As this name is a property of the slave device, not of the DMA channel,
> I don't think it belongs under dma*chan*.

Right, but it gives me only half the information I need to be a link useful.
I know that device X is using two channels but I need to check the
device X's directory to know which channel is used for what purpose.

>> Another option would be to not have symlinks, but a debugfs file where
>> this information can be extracted and would only compiled if debugfs is
>> enabled.
> 
> Like /proc/interrupts?

More like /sys/kernel/debug/gpio

> That brings the complexity of traversing all channels etc.

Sure, but only when the file is read.
You can add
#ifdef CONFIG_DEBUG_FS
#endif

around the slave_device and name in struct dma_chan {}

and when user reads the file you print out something like this:
cat /sys/kernel/debug/dmaengine

e6700000.dma-controller:
dma0chan0		e6e20000.spi:tx
dma0chan1		e6e20000.spi:rx
dma0chan2		ee100000.sd:tx
dma0chan3		ee100000.sd:rx
...
dma0chan14		non slave
...

e6720000.dma-controller:
dma1chan0		e6b10000.spi:tx
dma1chan1		e6b10000.spi:rx
...

This way we will have all the information in one place, easy to look up
and you don't need to manage symlinks dynamically, just check all
channels if they have slave_device/name when they are in_use (in_use w/o
slave_device is 'non slave')

Some drivers are requesting and releasing the DMA channel per transfer
or when they are opened/closed or other variations.

> What do other people think?
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
