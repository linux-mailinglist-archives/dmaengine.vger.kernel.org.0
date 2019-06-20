Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9874CBDA
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfFTKaI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 06:30:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13822 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfFTKaI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 06:30:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0b602f0000>; Thu, 20 Jun 2019 03:30:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 03:30:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 03:30:06 -0700
Received: from [10.24.70.43] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 10:29:48 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>, <mkumard@nvidia.com>
References: <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
 <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
Date:   Thu, 20 Jun 2019 15:59:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618043308.GJ2962@vkoul-mobl>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561026607; bh=/T2uOMlZKYc5u4/29BGD3OfxcVf8QWFNAabrGHXnAOY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=IfaM//V6X7wPJeGfRP3vd8Z9EmCyBlYTvVfhJw91LDPLvPR1TVVeadukngDTLNUVl
         Ps9z+a4YXgZhb5Wuk2rdMx61H6IfRa+PzUvBPnaGeRJEI5z3IB8qlcS4efS8JCTyPo
         7MDuMm8cM+Qtdfkps4WaLFdQUHsjiuLtJ3Svng3YisiCkrySx2Vki1J3/zJx7QrL23
         Ge4cGuSg3cIfkQCqLUPZrAI+m1YIEkeSUYgfcL668bw0IBCE+WZuus04stXZ/YLNoM
         X/3RpdnIBGOwVSUPaWICOu9RGADTFEBKc8z3JDjCAXBIO9Lg0qv45mQPWvrUAQow37
         9y/aNaQSXTkBw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 6/18/2019 10:03 AM, Vinod Koul wrote:
> On 17-06-19, 12:37, Sameer Pujar wrote:
>> On 6/13/2019 10:13 AM, Vinod Koul wrote:
>>> On 06-06-19, 09:19, Sameer Pujar wrote:
>>>
>>>>> you are really going other way around about the whole picture. FWIW t=
hat
>>>>> is how *other* folks do audio with dmaengine!
>>>> I discussed this internally with HW folks and below is the reason why =
DMA
>>>> needs
>>>> to know FIFO size.
>>>>
>>>> - FIFOs reside in peripheral device(ADMAIF), which is the ADMA interfa=
ce to
>>>> the audio sub-system.
>>>> - ADMAIF has multiple channels and share FIFO buffer for individual
>>>> operations. There is a provision
>>>>   =C2=A0 to allocate specific fifo size for each individual ADMAIF cha=
nnel from the
>>>> shared buffer.
>>>> - Tegra Audio DMA(ADMA) architecture is different from the usual DMA
>>>> engines, which you described earlier.
>>>> - The flow control logic is placed inside ADMA. Slave peripheral
>>>> device(ADMAIF) signals ADMA whenever a
>>>>   =C2=A0 read or write happens on the FIFO(per WORD basis). Please not=
e that the
>>>> signaling is per channel. There is
>>>>   =C2=A0 no other signaling present from ADMAIF to ADMA.
>>>> - ADMA keeps a counter related to above signaling. Whenever a sufficie=
nt
>>> when is signal triggered? When there is space available or some
>>> threshold of space is reached?
>> Signal is triggered when FIFO read/write happens on the peripheral side.=
 In
>> other words
>> this happens when data is pushed/popped out of ADMAIF from/to one of the
>> AHUB modules (I2S
>> for example) This is on peripheral side and ADMAIF signals ADMA per WORD
>> basis.
>> ADMA <---(1. DMA transfers)---> ADMAIF <------ (2. FIFO read/write) ----=
-->
>> I2S
>> To be more clear ADMAIF signals ADMA when [2] happens.
> That is on every word read/write?
yes this per WORD read/write
>
>> FIFO_THRESHOLD field in ADMAIF is just to indicate when can ADMAIF do
>> operation [2].
>> Also please note FIFO_THRESHOLD field is present only for memory---->AHU=
B
>> path (playback path)
>> and there is no such threshold concept for AHUB----> memory path (captur=
e
>> path)
> That is sane and common. For memory you dont have a constraint so you
> transfer at full throttle.
>
>>>> space is available, it initiates a transfer.
>>>>   =C2=A0 But the question is, how does it know when to transfer. This =
is the
>>>> reason, why ADMA has to be aware of FIFO
>>>>   =C2=A0 depth of ADMAIF channel. Depending on the counters and FIFO d=
epth, it
>>>> knows exactly when a free space is available
>>>>   =C2=A0 in the context of a specific channel. On ADMA, FIFO_SIZE is j=
ust a value
>>>> which should match to actual FIFO_DEPTH/SIZE
>>>>   =C2=A0 of ADMAIF channel.
>>> That doesn't sound too different from typical dmaengine. To give an
>>> example of a platform (and general DMAengine principles as well) I work=
ed
>>> on the FIFO was 16 word deep. DMA didn't knew!
>>>
>>> Peripheral driver would signal to DMA when a threshold is reached and
>> No, In our case ADMAIF does not do any threshold based signalling to ADM=
A.
>>> DMA would send a burst controlled by src/dst_burst_size. For example if
>>> you have a FIFO with 16 words depth, typical burst_size would be 8 word=
s
>>> and peripheral will configure signalling for FIFO having 8 words, so
>>> signal from peripheral will make dma transfer 8 words.
>> The scenario is different in ADMA case, as ADMAIF cannot configure the
>> signalling based on FIFO_THRESHOLD settings.
>>> Here the peripheral driver FIFO is important, but the driver
>>> configures it and sets burst_size accordingly.
>>>
>>> So can you explain me what is the difference here that the peripheral
>>> cannot configure and use burst size with passing fifo depth?
>> Say for example FIFO_THRESHOLD is programmed as 16 WORDS, BURST_SIZE as =
8
>> WORDS.
>> ADMAIF does not push data to AHUB(operation [2]) till threshold of 16 WO=
RDS
>> is
>> reached in ADMAIF FIFO. Hence 2 burst transfers are needed to reach the
>> threshold.
>> As mentioned earlier, threshold here is to just indicate when data trans=
fer
>> can happen
>> to AHUB modules.
> So we have ADMA and AHUB and peripheral. You are talking to AHUB and that
> is _not_ peripheral and if I have guess right the fifo depth is for AHUB
> right?
Yes the communication is between ADMA and AHUB. ADMAIF is the interface=20
between
ADMA and AHUB. ADMA channel sending data to AHUB pairs with ADMAIF TX=20
channel.
Similary ADMA channel receiving data from AHUB pairs with ADMAIF RX channel=
.
FIFO DEPTH we are talking is about each ADMAIF TX/RX channel and it is=20
configurable.
DMA transfers happen to/from ADMAIF FIFOs and whenever data(per WORD) is=20
popped/pushed
out of ADMAIF to/from AHUB, asseration is made to ADMA. ADMA keeps=20
counters based on
these assertions. By knowing FIFO DEPTH and these counters, ADMA knows=20
when to wait or
when to transfer data.
>
>> Once the data is popped from ADMAIF FIFO, ADMAIF signals ADMA. ADMA is t=
he
>> master
>> and it keeps track of the buffer occupancy by knowing the FIFO_DEPTH and=
 the
>> signalling.
>> Then finally it decides when to do next burst transfer depending on the =
free
>> space
>> available in ADMAIF.
>>>> - Now consider two cases based on above logic,
>>>>   =C2=A0 * Case 1: when DMA_FIFO_SIZE > SLAVE_FIFO_SIZE
>>>>   =C2=A0=C2=A0=C2=A0 In this case, ADMA thinks that there is enough sp=
ace available for
>>>> transfer, when actually the FIFO data
>>>>   =C2=A0=C2=A0=C2=A0 on slave is not consumed yet. It would result in =
OVERRUN.
>>>>   =C2=A0 * Case 2: when DMA_FIFO_SIZE < SLAVE_FIFO_SIZE
>>>>   =C2=A0=C2=A0=C2=A0 This is case where ADMA won=E2=80=99t transfer, e=
ven though sufficient space is
>>>> available, resulting in UNDERRUN.
>>>> - The guideline is to program, DMA_FIFO_SIZE(on ADMA side) =3D
>>>> SLAVE_FIFO_SIZE(on ADMAIF side) and hence we need a
>>>>   =C2=A0 way to communicate fifo size info to ADMA.
