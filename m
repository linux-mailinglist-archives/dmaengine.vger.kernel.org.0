Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2750447A6C
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2019 09:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfFQHHp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jun 2019 03:07:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16748 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFQHHp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jun 2019 03:07:45 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d073c400000>; Mon, 17 Jun 2019 00:07:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 00:07:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Jun 2019 00:07:43 -0700
Received: from [10.24.47.23] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 07:07:40 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>, <mkumard@nvidia.com>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
Date:   Mon, 17 Jun 2019 12:37:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190613044352.GC9160@vkoul-mobl.Dlink>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560755264; bh=fQ5zngc9DCaICNEHs2kdSF0gET/YTvZczUqPlLXKJYA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=j2NCynJopuXWCINkBGiy6gqLsgk3tZH3iRTvSzFQ5rAaoVXiF2zkvipMjtZQWIYXZ
         dWSBEj8aGA2YMmTaRrCnhIkaB02LeWub16eCD11RoLLQ+uxIgzS48oX8Fd0+4aAysQ
         uw1W2EKrvztVDrP5FWU1JuZF9z7r6oPVqzht/jyQbuAmff57wjpuR5yqzexSAL6n6B
         FMW5+M+zac+K7BL5EkE0khippUr/GqLlLuHC+CbAfMuRaek4hex76B2m+QN8vUcc85
         EYGPvsoLi/hmtp92XjXZHSTjR7pMdIZgqYPTKuHGM8lGiLVoeb7ktNRe+FUq38w+Lr
         HIKBYwaIp/cnQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 6/13/2019 10:13 AM, Vinod Koul wrote:
> On 06-06-19, 09:19, Sameer Pujar wrote:
>
>>> you are really going other way around about the whole picture. FWIW tha=
t
>>> is how *other* folks do audio with dmaengine!
>> I discussed this internally with HW folks and below is the reason why DM=
A
>> needs
>> to know FIFO size.
>>
>> - FIFOs reside in peripheral device(ADMAIF), which is the ADMA interface=
 to
>> the audio sub-system.
>> - ADMAIF has multiple channels and share FIFO buffer for individual
>> operations. There is a provision
>>  =C2=A0 to allocate specific fifo size for each individual ADMAIF channe=
l from the
>> shared buffer.
>> - Tegra Audio DMA(ADMA) architecture is different from the usual DMA
>> engines, which you described earlier.
>> - The flow control logic is placed inside ADMA. Slave peripheral
>> device(ADMAIF) signals ADMA whenever a
>>  =C2=A0 read or write happens on the FIFO(per WORD basis). Please note t=
hat the
>> signaling is per channel. There is
>>  =C2=A0 no other signaling present from ADMAIF to ADMA.
>> - ADMA keeps a counter related to above signaling. Whenever a sufficient
> when is signal triggered? When there is space available or some
> threshold of space is reached?
Signal is triggered when FIFO read/write happens on the peripheral side.=20
In other words
this happens when data is pushed/popped out of ADMAIF from/to one of the=20
AHUB modules (I2S
for example) This is on peripheral side and ADMAIF signals ADMA per WORD=20
basis.
ADMA <---(1. DMA transfers)---> ADMAIF <------ (2. FIFO read/write)=20
------> I2S
To be more clear ADMAIF signals ADMA when [2] happens.

FIFO_THRESHOLD field in ADMAIF is just to indicate when can ADMAIF do=20
operation [2].
Also please note FIFO_THRESHOLD field is present only for=20
memory---->AHUB path (playback path)
and there is no such threshold concept for AHUB----> memory path=20
(capture path)
>> space is available, it initiates a transfer.
>>  =C2=A0 But the question is, how does it know when to transfer. This is =
the
>> reason, why ADMA has to be aware of FIFO
>>  =C2=A0 depth of ADMAIF channel. Depending on the counters and FIFO dept=
h, it
>> knows exactly when a free space is available
>>  =C2=A0 in the context of a specific channel. On ADMA, FIFO_SIZE is just=
 a value
>> which should match to actual FIFO_DEPTH/SIZE
>>  =C2=A0 of ADMAIF channel.
> That doesn't sound too different from typical dmaengine. To give an
> example of a platform (and general DMAengine principles as well) I worked
> on the FIFO was 16 word deep. DMA didn't knew!
>
> Peripheral driver would signal to DMA when a threshold is reached and
No, In our case ADMAIF does not do any threshold based signalling to ADMA.
> DMA would send a burst controlled by src/dst_burst_size. For example if
> you have a FIFO with 16 words depth, typical burst_size would be 8 words
> and peripheral will configure signalling for FIFO having 8 words, so
> signal from peripheral will make dma transfer 8 words.
The scenario is different in ADMA case, as ADMAIF cannot configure the
signalling based on FIFO_THRESHOLD settings.
>
> Here the peripheral driver FIFO is important, but the driver
> configures it and sets burst_size accordingly.
>
> So can you explain me what is the difference here that the peripheral
> cannot configure and use burst size with passing fifo depth?
Say for example FIFO_THRESHOLD is programmed as 16 WORDS, BURST_SIZE as=20
8 WORDS.
ADMAIF does not push data to AHUB(operation [2]) till threshold of 16=20
WORDS is
reached in ADMAIF FIFO. Hence 2 burst transfers are needed to reach the=20
threshold.
As mentioned earlier, threshold here is to just indicate when data=20
transfer can happen
to AHUB modules.

Once the data is popped from ADMAIF FIFO, ADMAIF signals ADMA. ADMA is=20
the master
and it keeps track of the buffer occupancy by knowing the FIFO_DEPTH and=20
the signalling.
Then finally it decides when to do next burst transfer depending on the=20
free space
available in ADMAIF.
>> - Now consider two cases based on above logic,
>>  =C2=A0 * Case 1: when DMA_FIFO_SIZE > SLAVE_FIFO_SIZE
>>  =C2=A0=C2=A0=C2=A0 In this case, ADMA thinks that there is enough space=
 available for
>> transfer, when actually the FIFO data
>>  =C2=A0=C2=A0=C2=A0 on slave is not consumed yet. It would result in OVE=
RRUN.
>>  =C2=A0 * Case 2: when DMA_FIFO_SIZE < SLAVE_FIFO_SIZE
>>  =C2=A0=C2=A0=C2=A0 This is case where ADMA won=E2=80=99t transfer, even=
 though sufficient space is
>> available, resulting in UNDERRUN.
>> - The guideline is to program, DMA_FIFO_SIZE(on ADMA side) =3D
>> SLAVE_FIFO_SIZE(on ADMAIF side) and hence we need a
>>  =C2=A0 way to communicate fifo size info to ADMA.
