Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95836C6A
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 08:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFFGlr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 02:41:47 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15564 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGlr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 02:41:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf8b59b0000>; Wed, 05 Jun 2019 23:41:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Jun 2019 23:41:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Jun 2019 23:41:45 -0700
Received: from [10.24.45.153] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 06:41:40 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
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
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
Date:   Thu, 6 Jun 2019 12:11:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559803291; bh=yXiFe6CcblklZnWE+RSzm+Y7LB1BEpqh58XWi1fEdII=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=BdXUcaT5mWaFkvex9In9E9VjyzIAGi91tzaZCoMeVyYJxfiwQqJJwMaYnSiTKafHk
         f/QIKjXHUjHTIeLxamAfkM8mcyCOFoppTrKhDe1UCCv8N4UuXaDr9jnnx6af6+b+xp
         ku5VsxluQnPMX0Y1R1UAvpSnWteS4w+yQhyNqe3KNIkKeQYTYVHpZblctsVVujkj5A
         ynRqFHxmLL94nAnoIAn0II9KT9TdWRXlxhxzkk0nbHarVANkXNqYuk/yxXCn3ooWmx
         /wGox61OhTP3KY/4Kj3ON5EF64Xad6CjPJM5DrM5KO7rhW2gysBLk1sWtARi3FS0zO
         gjdQXMub9aRag==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 6/6/2019 11:30 AM, Peter Ujfalusi wrote:
> Hi Sameer,
>
> On 06/06/2019 6.49, Sameer Pujar wrote:
>> Sorry for late reply.
>> [Resending the reply since delivery failed for few recipients]
>> I discussed this internally with HW folks and below is the reason why
>> DMA needs
>> to know FIFO size.
>>
>> - FIFOs reside in peripheral device(ADMAIF), which is the ADMA interface
>> to the audio sub-system.
>> - ADMAIF has multiple channels and share FIFO buffer for individual
>> operations. There is a provision
>>  =C2=A0 to allocate specific fifo size for each individual ADMAIF channe=
l from
>> the shared buffer.
>> - Tegra Audio DMA(ADMA) architecture is different from the usual DMA
>> engines, which you described earlier.
> It is not really different than what other DMAs are doing.
>
>> - The flow control logic is placed inside ADMA. Slave peripheral
>> device(ADMAIF) signals ADMA whenever a
>>  =C2=A0 read or write happens on the FIFO(per WORD basis). Please note t=
hat
>> the signaling is per channel. There is
>>  =C2=A0 no other signaling present from ADMAIF to ADMA.
>> - ADMA keeps a counter related to above signaling. Whenever a sufficient
>> space is available, it initiates a transfer.
>>  =C2=A0 But the question is, how does it know when to transfer. This is =
the
>> reason, why ADMA has to be aware of FIFO
>>  =C2=A0 depth of ADMAIF channel. Depending on the counters and FIFO dept=
h, it
>> knows exactly when a free space is available
>>  =C2=A0 in the context of a specific channel. On ADMA, FIFO_SIZE is just=
 a
>> value which should match to actual FIFO_DEPTH/SIZE
>>  =C2=A0 of ADMAIF channel.
>> - Now consider two cases based on above logic,
>>  =C2=A0 * Case 1: when DMA_FIFO_SIZE > SLAVE_FIFO_SIZE
>>  =C2=A0=C2=A0=C2=A0 In this case, ADMA thinks that there is enough space=
 available for
>> transfer, when actually the FIFO data
>>  =C2=A0=C2=A0=C2=A0 on slave is not consumed yet. It would result in OVE=
RRUN.
>>  =C2=A0 * Case 2: when DMA_FIFO_SIZE < SLAVE_FIFO_SIZE
>>  =C2=A0=C2=A0=C2=A0 This is case where ADMA won=E2=80=99t transfer, even=
 though sufficient space
>> is available, resulting in UNDERRUN.
>> - The guideline is to program, DMA_FIFO_SIZE(on ADMA side) =3D
>> SLAVE_FIFO_SIZE(on ADMAIF side) and hence we need a
>>  =C2=A0 way to communicate fifo size info to ADMA.
> The src_maxburst / dst_maxburst is exactly for this reason. To
> communicate how much data should be transferred per DMA request to/from
> peripheral.
>
> In TI land we have now 3 DMA engines servicing McASP. McASP has FIFO
> which is dynamically configured (you can see the AFIFO of McASP as a
> small DMA: on McASP side it services the peripheral, on the other side
> it interacts with the given system DMA used by the SoC - EDMA, sDMA or
> UDMAP). All DMAs needs a bit different configuration, but the AFIFO
> depth on the McASP side is coming in via the src/dst_maxburst and the
> drivers just need to interpret it correctly.
>
> It does sounds like that FIFO_SIZE =3D=3D src/dst_maxburst in your case a=
s well.
Not exactly equal.
ADMA burst_size can range from 1(WORD) to 16(WORDS)
FIFO_SIZE can be adjusted from 16(WORDS) to 1024(WORDS) [can vary in=20
multiples of 16]

So without this RFC patch, I need to do following.
- pass FIFO_SIZE via src/dst_maxburst (from peripheral ADMAIF driver)
- DMA driver can have following code,
 =C2=A0 * Program DMA_FIFO_SIZE value from src/dst_maxburst
 =C2=A0 * Add below logic
 =C2=A0=C2=A0=C2=A0 if (src/dst_maxburst > 16)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 program ADMA burst_size =3D 16
 =C2=A0=C2=A0=C2=A0 else
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 program ADMA burst_size =3D 8 (=
1/2 of minimum FIFO depth of=20
ADMAIF channel)

With above, the flexibility to program ADMA burst_size to any of the=20
required values in the specified range is not there.
Hence ideally would have liked to have independent control over=20
burst_size and fifo_size on ADMA side.
If there is no merit in this, I will update ADMA/ADMAIF driver as=20
mentioned above.

Thanks,
Sameer.

>
> - P=C3=A9ter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
