Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3D36D21
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFFHO5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 03:14:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17236 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfFFHO5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 03:14:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf8bd610000>; Thu, 06 Jun 2019 00:14:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 00:14:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Jun 2019 00:14:55 -0700
Received: from [10.26.11.84] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 07:14:52 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Sameer Pujar <spujar@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
Date:   Thu, 6 Jun 2019 08:14:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559805281; bh=we28DS5X7xSaXXYFzfR6qcpRQdJw/oBKVHGphgNpg4A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=REIYkTdhXJCPwnw46/cgBu6vzj3ghvF1f1+O+Q/SLGOHwSjmwxZYujmv4gFnwH5wm
         9iuZc/sEsHjcnDLEmqeHBvI/+/wUtDC6PIWQyQ5aZ4rPLtoOS5iqUFjxa0L0Y4kMhN
         pLe5iTHBxjuE6SKrS+iJiNwyUVqQJjEl3I/3mNkHTZEGDsclbU+1rVTvhV1uv8CV5a
         PUFgh1N2ITEu9vu5pxlUH7DNS9jbS7BuyUV9d8HkV7I87/kaC6TEQV201S5l2+V1aE
         o91BIpvmvKbR2bf6MQw+BYyepLQ8MYc1Ctc/fCfvbzAdChVZK9nccXCGTDQbzOf0mS
         QeBmYIghpRgiQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/06/2019 07:41, Sameer Pujar wrote:
>=20
> On 6/6/2019 11:30 AM, Peter Ujfalusi wrote:
>> Hi Sameer,
>>
>> On 06/06/2019 6.49, Sameer Pujar wrote:
>>> Sorry for late reply.
>>> [Resending the reply since delivery failed for few recipients]
>>> I discussed this internally with HW folks and below is the reason why
>>> DMA needs
>>> to know FIFO size.
>>>
>>> - FIFOs reside in peripheral device(ADMAIF), which is the ADMA interfac=
e
>>> to the audio sub-system.
>>> - ADMAIF has multiple channels and share FIFO buffer for individual
>>> operations. There is a provision
>>> =C2=A0=C2=A0 to allocate specific fifo size for each individual ADMAIF =
channel
>>> from
>>> the shared buffer.
>>> - Tegra Audio DMA(ADMA) architecture is different from the usual DMA
>>> engines, which you described earlier.
>> It is not really different than what other DMAs are doing.
>>
>>> - The flow control logic is placed inside ADMA. Slave peripheral
>>> device(ADMAIF) signals ADMA whenever a
>>> =C2=A0=C2=A0 read or write happens on the FIFO(per WORD basis). Please =
note that
>>> the signaling is per channel. There is
>>> =C2=A0=C2=A0 no other signaling present from ADMAIF to ADMA.
>>> - ADMA keeps a counter related to above signaling. Whenever a sufficien=
t
>>> space is available, it initiates a transfer.
>>> =C2=A0=C2=A0 But the question is, how does it know when to transfer. Th=
is is the
>>> reason, why ADMA has to be aware of FIFO
>>> =C2=A0=C2=A0 depth of ADMAIF channel. Depending on the counters and FIF=
O depth, it
>>> knows exactly when a free space is available
>>> =C2=A0=C2=A0 in the context of a specific channel. On ADMA, FIFO_SIZE i=
s just a
>>> value which should match to actual FIFO_DEPTH/SIZE
>>> =C2=A0=C2=A0 of ADMAIF channel.
>>> - Now consider two cases based on above logic,
>>> =C2=A0=C2=A0 * Case 1: when DMA_FIFO_SIZE > SLAVE_FIFO_SIZE
>>> =C2=A0=C2=A0=C2=A0=C2=A0 In this case, ADMA thinks that there is enough=
 space available for
>>> transfer, when actually the FIFO data
>>> =C2=A0=C2=A0=C2=A0=C2=A0 on slave is not consumed yet. It would result =
in OVERRUN.
>>> =C2=A0=C2=A0 * Case 2: when DMA_FIFO_SIZE < SLAVE_FIFO_SIZE
>>> =C2=A0=C2=A0=C2=A0=C2=A0 This is case where ADMA won=E2=80=99t transfer=
, even though sufficient
>>> space
>>> is available, resulting in UNDERRUN.
>>> - The guideline is to program, DMA_FIFO_SIZE(on ADMA side) =3D
>>> SLAVE_FIFO_SIZE(on ADMAIF side) and hence we need a
>>> =C2=A0=C2=A0 way to communicate fifo size info to ADMA.
>> The src_maxburst / dst_maxburst is exactly for this reason. To
>> communicate how much data should be transferred per DMA request to/from
>> peripheral.
>>
>> In TI land we have now 3 DMA engines servicing McASP. McASP has FIFO
>> which is dynamically configured (you can see the AFIFO of McASP as a
>> small DMA: on McASP side it services the peripheral, on the other side
>> it interacts with the given system DMA used by the SoC - EDMA, sDMA or
>> UDMAP). All DMAs needs a bit different configuration, but the AFIFO
>> depth on the McASP side is coming in via the src/dst_maxburst and the
>> drivers just need to interpret it correctly.
>>
>> It does sounds like that FIFO_SIZE =3D=3D src/dst_maxburst in your case =
as
>> well.
> Not exactly equal.
> ADMA burst_size can range from 1(WORD) to 16(WORDS)
> FIFO_SIZE can be adjusted from 16(WORDS) to 1024(WORDS) [can vary in
> multiples of 16]

So I think that the key thing to highlight here, is that the as Sameer
highlighted above for the Tegra ADMA there are two values that need to
be programmed; the DMA client FIFO size and the max burst size. The ADMA
has register fields for both of these.

As you can see from the above the FIFO size can be much greater than the
burst size and so ideally both of these values would be passed to the DMA.

We could get by with just passing the FIFO size (as the max burst size)
and then have the DMA driver set the max burst size depending on this,
but this does feel quite correct for this DMA. Hence, ideally, we would
like to pass both.

We are also open to other ideas.

Cheers
Jon

--=20
nvpublic
