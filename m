Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4F36A8C
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 05:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFFDtY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jun 2019 23:49:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7954 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFFDtX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jun 2019 23:49:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf88d330000>; Wed, 05 Jun 2019 20:49:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Jun 2019 20:49:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Jun 2019 20:49:21 -0700
Received: from [10.25.74.60] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 03:49:16 +0000
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
Date:   Thu, 6 Jun 2019 09:19:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190506155046.GH3845@vkoul-mobl.Dlink>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559792947; bh=uXh40GWGn50UX9UW6R+vmfVqkConjIwsgIO17SfK1Fs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=TMdGaINXduoVerYnzznBFGxOCJf1RgQ5MyjzvInlabRrzUk5hD6z1weTvRtUApki/
         VO1U0EFWnLUrYZ+cy6B/hCJ0ISajG9ciHKKg6MF4mOYfXViFjRuDBAQ6PZm1tjaJ3T
         UdiXlYlnh3GSjG3aHOt4IUWNl7SoZ7eNzbzXKM9KjjhZ8MFuNhMDIg5cCOpoQi1yPU
         MVaK9d9uRW3dbC5kiUpXsURtecyfuTZrPeJpmlf3dwOYUuq2yQrqxYfdjEsQqKjXH2
         ahv69UfGthE1Gl1XdpM1yJrUZMsPERAy/jGfIlXOpPi0Ubs3ujm6iXFZhRD4kjRbK6
         vdvccYWcDBkeA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sorry for late reply.
[Resending the reply since delivery failed for few recipients]

On 5/6/2019 9:20 PM, Vinod Koul wrote:
> On 06-05-19, 18:34, Sameer Pujar wrote:
>> On 5/4/2019 3:53 PM, Vinod Koul wrote:
>>> On 02-05-19, 18:59, Sameer Pujar wrote:
>>>> On 5/2/2019 5:55 PM, Vinod Koul wrote:
>>>>> On 02-05-19, 16:23, Sameer Pujar wrote:
>>>>>> On 5/2/2019 11:34 AM, Vinod Koul wrote:
>>>>>>> On 30-04-19, 17:00, Sameer Pujar wrote:
>>>>>>>> During the DMA transfers from memory to I/O, it was observed that =
transfers
>>>>>>>> were inconsistent and resulted in glitches for audio playback. It =
happened
>>>>>>>> because fifo size on DMA did not match with slave channel configur=
ation.
>>>>>>>>
>>>>>>>> currently 'dma_slave_config' structure does not have a field for f=
ifo size.
>>>>>>>> Hence the platform pcm driver cannot pass the fifo size as a slave=
_config.
>>>>>>>> Note that 'snd_dmaengine_dai_dma_data' structure has fifo_size fie=
ld which
>>>>>>>> cannot be used to pass the size info. This patch introduces fifo_s=
ize field
>>>>>>>> and the same can be populated on slave side. Users can set require=
d size
>>>>>>>> for slave peripheral (multiple channels can be independently runni=
ng with
>>>>>>>> different fifo sizes) and the corresponding sizes are programmed t=
hrough
>>>>>>>> dma_slave_config on DMA side.
>>>>>>> FIFO size is a hardware property not sure why you would want an
>>>>>>> interface to program that?
>>>>>>>
>>>>>>> On mismatch, I guess you need to take care of src/dst_maxburst..
>>>>>> Yes, FIFO size is a HW property. But it is SW configurable(atleast i=
n my
>>>>>> case) on
>>>>>> slave side and can be set to different sizes. The src/dst_maxburst i=
s
>>>>> Are you sure, have you talked to HW folks on that? IIUC you are
>>>>> programming the data to be used in FIFO not the FIFO length!
>>>> Yes, I mentioned about FIFO length.
>>>>
>>>> 1. MAX FIFO size is fixed in HW. But there is a way to limit the usage=
 per
>>>> channel
>>>>   =C2=A0=C2=A0 in multiples of 64 bytes.
>>>> 2. Having a separate member would give independent control over MAX BU=
RST
>>>> SIZE and
>>>>   =C2=A0=C2=A0 FIFO SIZE.
>>>>>> programmed
>>>>>> for specific values, I think this depends on few factors related to
>>>>>> bandwidth
>>>>>> needs of client, DMA needs of the system etc.,
>>>>> Precisely
>>>>>
>>>>>> In such cases how does DMA know the actual FIFO depth of slave perip=
heral?
>>>>> Why should DMA know? Its job is to push/pull data as configured by
>>>>> peripheral driver. The peripheral driver knows and configures DMA
>>>>> accordingly.
>>>> I am not sure if there is any HW logic that mandates DMA to know the s=
ize
>>>> of configured FIFO depth on slave side. I will speak to HW folks and
>>>> would update here.
>>> I still do not comprehend why dma would care about slave side
>>> configuration. In the absence of patch which uses this I am not sure
>>> what you are trying to do...
>> I am using DMA HW in cyclic mode for data transfers to Audio sub-system.
>> In such cases flow control on DMA transfers is essential, since I/O is
> right and people use burst size for precisely that!
>
>> consuming/producing the data at slower rate. The DMA tranfer is enabled/
>> disabled during start/stop of audio playback/capture sessions through AL=
SA
>> callbacks and DMA runs in cyclic mode. Hence DMA is the one which is doi=
ng
>> flow control and it is necessary for it to know the peripheral FIFO dept=
h
>> to avoid overruns/underruns.
> not really, knowing that doesnt help anyway you have described! DMA
> pushes/pulls data and that is controlled by burst configured by slave
> (so it know what to expect and porgrams things accordingly)
>
> you are really going other way around about the whole picture. FWIW that
> is how *other* folks do audio with dmaengine!
I discussed this internally with HW folks and below is the reason why=20
DMA needs
to know FIFO size.

- FIFOs reside in peripheral device(ADMAIF), which is the ADMA interface=20
to the audio sub-system.
- ADMAIF has multiple channels and share FIFO buffer for individual=20
operations. There is a provision
 =C2=A0 to allocate specific fifo size for each individual ADMAIF channel=20
from the shared buffer.
- Tegra Audio DMA(ADMA) architecture is different from the usual DMA=20
engines, which you described earlier.
- The flow control logic is placed inside ADMA. Slave peripheral=20
device(ADMAIF) signals ADMA whenever a
 =C2=A0 read or write happens on the FIFO(per WORD basis). Please note that=
=20
the signaling is per channel. There is
 =C2=A0 no other signaling present from ADMAIF to ADMA.
- ADMA keeps a counter related to above signaling. Whenever a sufficient=20
space is available, it initiates a transfer.
 =C2=A0 But the question is, how does it know when to transfer. This is the=
=20
reason, why ADMA has to be aware of FIFO
 =C2=A0 depth of ADMAIF channel. Depending on the counters and FIFO depth, =
it=20
knows exactly when a free space is available
 =C2=A0 in the context of a specific channel. On ADMA, FIFO_SIZE is just a=
=20
value which should match to actual FIFO_DEPTH/SIZE
 =C2=A0 of ADMAIF channel.
- Now consider two cases based on above logic,
 =C2=A0 * Case 1: when DMA_FIFO_SIZE > SLAVE_FIFO_SIZE
 =C2=A0=C2=A0=C2=A0 In this case, ADMA thinks that there is enough space av=
ailable for=20
transfer, when actually the FIFO data
 =C2=A0=C2=A0=C2=A0 on slave is not consumed yet. It would result in OVERRU=
N.
 =C2=A0 * Case 2: when DMA_FIFO_SIZE < SLAVE_FIFO_SIZE
 =C2=A0=C2=A0=C2=A0 This is case where ADMA won=E2=80=99t transfer, even th=
ough sufficient=20
space is available, resulting in UNDERRUN.
- The guideline is to program, DMA_FIFO_SIZE(on ADMA side) =3D=20
SLAVE_FIFO_SIZE(on ADMAIF side) and hence we need a
 =C2=A0 way to communicate fifo size info to ADMA.

Thanks,
Sameer.
>> Also please note that, peripheral device has multiple channels and share
>> a fixed MAX FIFO buffer. But SW can program different FIFO sizes for
>> individual channels.
> yeah peripheral driver, yes. DMA driver nope!
>
