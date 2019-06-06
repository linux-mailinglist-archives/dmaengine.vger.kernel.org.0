Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F637209
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFFKtX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 06:49:23 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18957 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFFKtX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 06:49:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf8efb00000>; Thu, 06 Jun 2019 03:49:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 03:49:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 03:49:20 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 10:49:18 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
Date:   Thu, 6 Jun 2019 11:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559818160; bh=WzzhEJK2De3f43eCu/BsQHMI4/xvHgWD7ruox2mfSOg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k57U96xj4MeWVr4uU7VFDpQyr5ZsS+4muuzcTIAQ1QtIWGfjypzQHPUBi3Fv92EcI
         LzBIVxGr0iSFMR09zDaT/+vfJQmf7fObPdj0cJpoPZAKdwiH3TkFu5zVaK3gGbVUQd
         yL/LH5aNtSW0Fqds4Nwcr7gRJVk9J195aBM4yzyAfIdG3+h1T9a6bhmwbgdgM+fSEr
         5KyHDYOlYrhWwdCtrzJEQhrAgIjNIw5Yx6Nk/cIs0qfQ7F8DD2r3UPsBHtW+LXGiUL
         HJXIn3J8Fw6s1AHDxhXX+64j+tOhQkuU4aBxqgmYj+O1BSlvNaC6sGgDc9E9rOqlPV
         CvTDb6pOlE5PQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/06/2019 11:22, Peter Ujfalusi wrote:

...

>>>> It does sounds like that FIFO_SIZE == src/dst_maxburst in your case as
>>>> well.
>>> Not exactly equal.
>>> ADMA burst_size can range from 1(WORD) to 16(WORDS)
>>> FIFO_SIZE can be adjusted from 16(WORDS) to 1024(WORDS) [can vary in
>>> multiples of 16]
>>
>> So I think that the key thing to highlight here, is that the as Sameer
>> highlighted above for the Tegra ADMA there are two values that need to
>> be programmed; the DMA client FIFO size and the max burst size. The ADMA
>> has register fields for both of these.
> 
> How does the ADMA uses the 'client FIFO size' and 'max burst size'
> values and what is the relation of these values to the peripheral side
> (ADMAIF)?

Per Sameer's previous comment, the FIFO size is used by the ADMA to
determine how much space is available in the FIFO. I assume the burst
size just limits how much data is transferred per transaction.

>> As you can see from the above the FIFO size can be much greater than the
>> burst size and so ideally both of these values would be passed to the DMA.
>>
>> We could get by with just passing the FIFO size (as the max burst size)
>> and then have the DMA driver set the max burst size depending on this,
>> but this does feel quite correct for this DMA. Hence, ideally, we would
>> like to pass both.
>>
>> We are also open to other ideas.
> 
> I can not find public documentation (I think they are walled off by
> registration), but correct me if I'm wrong:

No unfortunately, you are not wrong here :-(

> ADMAIF - peripheral side
>  - kind of a small DMA for audio preipheral(s)?

Yes this is the interface to the APE (audio processing engine) and data
sent to the ADMAIF is then sent across a crossbar to one of many
devices/interfaces (I2S, DMIC, etc). Basically a large mux that is user
configurable depending on the use-case.

>  - Variable FIFO size

Yes.

>  - sends DMA request to ADMA per words

From Sameer's notes it says the ADMAIF send a signal to the ADMA per
word, yes.

> ADMA - system DMA
>  - receives the DMA requests from ADMAIF
>  - counts the requests
>  - based on some threshold of the counter it will send/read from ADMAIF?
>   - maxburst number of words probably?

Sounds about right to me.

> ADMA needs to know the ADMAIF's FIFO size because, it is the one who is
> managing that FIFO from the outside, making sure that it does not over
> or underrun?

Yes.

> And it is the one who sets the pace (in effect the DMA burst size - how
> many bytes the DMA jumps between refills) of refills to the ADMAIF's FIFO?

Yes.

So currently, if you look at the ADMA driver
(drivers/dma/tegra210-adma.c) you will see we use the src/dst_maxburst
for the burst, but the FIFO size is hard-coded (see the
TEGRA210_FIFO_CTRL_DEFAULT and TEGRA186_FIFO_CTRL_DEFAULT definitions).
Ideally, we should not hard-code this but pass it.

Given that there are no current users of the ADMA upstream, we could
change the usage of the src/dst_maxburst, but being able to set the FIFO
size as well would be ideal.

Cheers
Jon

-- 
nvpublic
