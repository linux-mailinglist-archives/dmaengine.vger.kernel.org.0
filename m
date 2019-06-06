Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9CB3768F
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 16:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfFFOZN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 10:25:13 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16508 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfFFOZN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 10:25:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf922380001>; Thu, 06 Jun 2019 07:24:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 07:25:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 07:25:10 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 14:25:05 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Dmitry Osipenko <digetx@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
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
 <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
 <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
 <deae510a-f6ae-6a51-2875-a7463cac9169@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ac9a965d-0166-3d80-5ac4-ae841d7ae726@nvidia.com>
Date:   Thu, 6 Jun 2019 15:25:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <deae510a-f6ae-6a51-2875-a7463cac9169@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559831096; bh=t+tKC+EGTYGC+QMvXfn241RfTbKDiYGV7tALtJGBqB0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LaFN5H0KNPnS6jBiXARz7+/mBgDuj23yLfHD8ru1kkHNqVLvUlAAkPCpsfk4yh8uU
         CXwbgHYYJtISocqOlYvuQciSZBGXE7jjvbkzSGagZrdKJW90phXoEV0bTQulU+AtPT
         7OYegMhoEvBH3nR5GT9o0sObAzXjhcIGSonyYFJDYlsbx8EYsQEL+w0A/yWrrwQsr9
         ui6abD1umzv8YFcSL3SKb5cBnIp1v0MkJNq10QcUhxvz2efNQwU3xWqG2ArrvkN9fW
         lZvDANQa33ESmrQsI5eJNMb6Y/AfVlHr2bcCOe4tczU9lZC+wMcijRHc/wl7p0T83e
         n3RH6B5vCWKGw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 06/06/2019 14:45, Dmitry Osipenko wrote:
> 06.06.2019 15:37, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 06/06/2019 12:54, Peter Ujfalusi wrote:
>>>
>>>
>>> On 06/06/2019 13.49, Jon Hunter wrote:
>>>>
>>>> On 06/06/2019 11:22, Peter Ujfalusi wrote:
>>>>
>>>> ...
>>>>
>>>>>>>> It does sounds like that FIFO_SIZE =3D=3D src/dst_maxburst in your=
 case as
>>>>>>>> well.
>>>>>>> Not exactly equal.
>>>>>>> ADMA burst_size can range from 1(WORD) to 16(WORDS)
>>>>>>> FIFO_SIZE can be adjusted from 16(WORDS) to 1024(WORDS) [can vary i=
n
>>>>>>> multiples of 16]
>>>>>>
>>>>>> So I think that the key thing to highlight here, is that the as Same=
er
>>>>>> highlighted above for the Tegra ADMA there are two values that need =
to
>>>>>> be programmed; the DMA client FIFO size and the max burst size. The =
ADMA
>>>>>> has register fields for both of these.
>>>>>
>>>>> How does the ADMA uses the 'client FIFO size' and 'max burst size'
>>>>> values and what is the relation of these values to the peripheral sid=
e
>>>>> (ADMAIF)?
>>>>
>>>> Per Sameer's previous comment, the FIFO size is used by the ADMA to
>>>> determine how much space is available in the FIFO. I assume the burst
>>>> size just limits how much data is transferred per transaction.
>>>>
>>>>>> As you can see from the above the FIFO size can be much greater than=
 the
>>>>>> burst size and so ideally both of these values would be passed to th=
e DMA.
>>>>>>
>>>>>> We could get by with just passing the FIFO size (as the max burst si=
ze)
>>>>>> and then have the DMA driver set the max burst size depending on thi=
s,
>>>>>> but this does feel quite correct for this DMA. Hence, ideally, we wo=
uld
>>>>>> like to pass both.
>>>>>>
>>>>>> We are also open to other ideas.
>>>>>
>>>>> I can not find public documentation (I think they are walled off by
>>>>> registration), but correct me if I'm wrong:
>>>>
>>>> No unfortunately, you are not wrong here :-(
>>>>
>>>>> ADMAIF - peripheral side
>>>>>  - kind of a small DMA for audio preipheral(s)?
>>>>
>>>> Yes this is the interface to the APE (audio processing engine) and dat=
a
>>>> sent to the ADMAIF is then sent across a crossbar to one of many
>>>> devices/interfaces (I2S, DMIC, etc). Basically a large mux that is use=
r
>>>> configurable depending on the use-case.
>>>>
>>>>>  - Variable FIFO size
>>>>
>>>> Yes.
>>>>
>>>>>  - sends DMA request to ADMA per words
>>>>
>>>> From Sameer's notes it says the ADMAIF send a signal to the ADMA per
>>>> word, yes.
>>>>
>>>>> ADMA - system DMA
>>>>>  - receives the DMA requests from ADMAIF
>>>>>  - counts the requests
>>>>>  - based on some threshold of the counter it will send/read from ADMA=
IF?
>>>>>   - maxburst number of words probably?
>>>>
>>>> Sounds about right to me.
>>>>
>>>>> ADMA needs to know the ADMAIF's FIFO size because, it is the one who =
is
>>>>> managing that FIFO from the outside, making sure that it does not ove=
r
>>>>> or underrun?
>>>>
>>>> Yes.
>>>>
>>>>> And it is the one who sets the pace (in effect the DMA burst size - h=
ow
>>>>> many bytes the DMA jumps between refills) of refills to the ADMAIF's =
FIFO?
>>>>
>>>> Yes.
>>>>
>>>> So currently, if you look at the ADMA driver
>>>> (drivers/dma/tegra210-adma.c) you will see we use the src/dst_maxburst
>>>> for the burst, but the FIFO size is hard-coded (see the
>>>> TEGRA210_FIFO_CTRL_DEFAULT and TEGRA186_FIFO_CTRL_DEFAULT definitions)=
.
>>>> Ideally, we should not hard-code this but pass it.
>>>
>>> Sure, hardcoding is never good ;)
>>>
>>>> Given that there are no current users of the ADMA upstream, we could
>>>> change the usage of the src/dst_maxburst, but being able to set the FI=
FO
>>>> size as well would be ideal.
>>>
>>> Looking at the drivers/dma/tegra210-adma.c for the
>>> TEGRA*_FIFO_CTRL_DEFAULT definition it is still not clear where the
>>> remote FIFO size would fit.
>>> There are fields for overflow and starvation(?) thresholds and TX/RX
>>> size (assuming word length, 3 =3D=3D 32bits?).
>>
>> The TX/RX size are the FIFO size. So 3 equates to a FIFO size of 3 * 64
>> bytes.
>>
>>> Both threshold is set to one, so I assume currently ADMA is
>>> pushing/pulling data word by word.
>>
>> That's different. That indicates thresholds when transfers start.
>>
>>> Not sure what the burst size is used for, my guess would be that it is
>>> used on the memory (DDR) side for optimized, more efficient accesses?
>>
>> That is the actual burst size.
>>
>>> My guess is that the threshold values are the counter limits, if the DM=
A
>>> request counter reaches it then ADMA would do a threshold limit worth o=
f
>>> push/pull to ADMAIF.
>>> Or there is another register where the remote FIFO size can be written
>>> and ADMA is counting back from there until it reaches the threshold (an=
d
>>> pushes/pulling again threshold amount of data) so it keeps the FIFO
>>> filled with at least threshold amount of data?
>>>
>>> I think in both cases the threshold would be the maxburst.
>>>
>>> I suppose you have the patch for adma on how to use the fifo_size
>>> parameter? That would help understand what you are trying to achieve be=
tter.
>>
>> Its quite simple, we would just use the FIFO size to set the fields
>> TEGRAXXX_ADMA_CH_FIFO_CTRL_TXSIZE/RXSIZE in the
>> TEGRAXXX_ADMA_CH_FIFO_CTRL register. That's all.
>>
>> Jon
>>
>=20
> Hi,
>=20
> If I understood everything correctly, the FIFO buffer is shared among
> all of the ADMA clients and hence it should be up to the ADMA driver to
> manage the quotas of the clients. So if there is only one client that
> uses ADMA at a time, then this client will get a whole FIFO buffer, but
> once another client starts to use ADMA, then the ADMA driver will have
> to reconfigure hardware to split the quotas.

The FIFO quotas are managed by the ADMAIF driver (does not exist in
mainline currently but we are working to upstream this) because it is
this device that owns and needs to configure the FIFOs. So it is really
a means to pass the information from the ADMAIF to the ADMA.

Jon

--=20
nvpublic
