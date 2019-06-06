Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE40737380
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 13:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfFFLyV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 07:54:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39416 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfFFLyV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 07:54:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x56BsDCx085147;
        Thu, 6 Jun 2019 06:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559822053;
        bh=muC3ZVoaXdyRnjntNAZk0RlDaLb2ntCL0f7txF8lLm4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ayCzE/G8bDxPQzfJ+IppvEOurHkIR5wyKGBL6QQIRnvBUuU//LmxNQFdrN8HVYhDC
         +B2VYr87HQ3+FL9nDFlG3YuTIvhtk3F6E2WcUkD9xbnZXRz3oMNMWhT+X8tgg/x8us
         fXoMsyuE8YjTT2w+1OXexTGqXUNUv5wmRf46ikqM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x56BsDI8054160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 06:54:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 06:54:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 06:54:12 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x56BsAue056641;
        Thu, 6 Jun 2019 06:54:10 -0500
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Jon Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
 <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
 <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
 <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
 <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
Date:   Thu, 6 Jun 2019 14:54:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 06/06/2019 13.49, Jon Hunter wrote:
> 
> On 06/06/2019 11:22, Peter Ujfalusi wrote:
> 
> ...
> 
>>>>> It does sounds like that FIFO_SIZE == src/dst_maxburst in your case as
>>>>> well.
>>>> Not exactly equal.
>>>> ADMA burst_size can range from 1(WORD) to 16(WORDS)
>>>> FIFO_SIZE can be adjusted from 16(WORDS) to 1024(WORDS) [can vary in
>>>> multiples of 16]
>>>
>>> So I think that the key thing to highlight here, is that the as Sameer
>>> highlighted above for the Tegra ADMA there are two values that need to
>>> be programmed; the DMA client FIFO size and the max burst size. The ADMA
>>> has register fields for both of these.
>>
>> How does the ADMA uses the 'client FIFO size' and 'max burst size'
>> values and what is the relation of these values to the peripheral side
>> (ADMAIF)?
> 
> Per Sameer's previous comment, the FIFO size is used by the ADMA to
> determine how much space is available in the FIFO. I assume the burst
> size just limits how much data is transferred per transaction.
> 
>>> As you can see from the above the FIFO size can be much greater than the
>>> burst size and so ideally both of these values would be passed to the DMA.
>>>
>>> We could get by with just passing the FIFO size (as the max burst size)
>>> and then have the DMA driver set the max burst size depending on this,
>>> but this does feel quite correct for this DMA. Hence, ideally, we would
>>> like to pass both.
>>>
>>> We are also open to other ideas.
>>
>> I can not find public documentation (I think they are walled off by
>> registration), but correct me if I'm wrong:
> 
> No unfortunately, you are not wrong here :-(
> 
>> ADMAIF - peripheral side
>>  - kind of a small DMA for audio preipheral(s)?
> 
> Yes this is the interface to the APE (audio processing engine) and data
> sent to the ADMAIF is then sent across a crossbar to one of many
> devices/interfaces (I2S, DMIC, etc). Basically a large mux that is user
> configurable depending on the use-case.
> 
>>  - Variable FIFO size
> 
> Yes.
> 
>>  - sends DMA request to ADMA per words
> 
> From Sameer's notes it says the ADMAIF send a signal to the ADMA per
> word, yes.
> 
>> ADMA - system DMA
>>  - receives the DMA requests from ADMAIF
>>  - counts the requests
>>  - based on some threshold of the counter it will send/read from ADMAIF?
>>   - maxburst number of words probably?
> 
> Sounds about right to me.
> 
>> ADMA needs to know the ADMAIF's FIFO size because, it is the one who is
>> managing that FIFO from the outside, making sure that it does not over
>> or underrun?
> 
> Yes.
> 
>> And it is the one who sets the pace (in effect the DMA burst size - how
>> many bytes the DMA jumps between refills) of refills to the ADMAIF's FIFO?
> 
> Yes.
> 
> So currently, if you look at the ADMA driver
> (drivers/dma/tegra210-adma.c) you will see we use the src/dst_maxburst
> for the burst, but the FIFO size is hard-coded (see the
> TEGRA210_FIFO_CTRL_DEFAULT and TEGRA186_FIFO_CTRL_DEFAULT definitions).
> Ideally, we should not hard-code this but pass it.

Sure, hardcoding is never good ;)

> Given that there are no current users of the ADMA upstream, we could
> change the usage of the src/dst_maxburst, but being able to set the FIFO
> size as well would be ideal.

Looking at the drivers/dma/tegra210-adma.c for the
TEGRA*_FIFO_CTRL_DEFAULT definition it is still not clear where the
remote FIFO size would fit.
There are fields for overflow and starvation(?) thresholds and TX/RX
size (assuming word length, 3 == 32bits?).
Both threshold is set to one, so I assume currently ADMA is
pushing/pulling data word by word.

Not sure what the burst size is used for, my guess would be that it is
used on the memory (DDR) side for optimized, more efficient accesses?

My guess is that the threshold values are the counter limits, if the DMA
request counter reaches it then ADMA would do a threshold limit worth of
push/pull to ADMAIF.
Or there is another register where the remote FIFO size can be written
and ADMA is counting back from there until it reaches the threshold (and
pushes/pulling again threshold amount of data) so it keeps the FIFO
filled with at least threshold amount of data?

I think in both cases the threshold would be the maxburst.

I suppose you have the patch for adma on how to use the fifo_size
parameter? That would help understand what you are trying to achieve better.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
