Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49CED14A8B
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 15:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfEFNEy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 09:04:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1666 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFNEy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 09:04:54 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd030d10000>; Mon, 06 May 2019 06:04:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 May 2019 06:04:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 06 May 2019 06:04:51 -0700
Received: from [10.24.45.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 May
 2019 13:04:48 +0000
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
Date:   Mon, 6 May 2019 18:34:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504102304.GZ3845@vkoul-mobl.Dlink>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557147857; bh=mumrUBbdUYqX0ghF8OegxnxbeYI8W3YkayjPjU3GNLg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=h8HVnFhrM55cXksQPT+DOa2lPcoqGtmqXtJ+EAeWhrusZ1gxCbiMJJjVhwKpLuqEF
         gZafPFzNXycxVgWQoKReMfAFti6Dfb/SI8JbdNImXqxQEyCIgbbXTjMyM6ukQ3vRnK
         VETjgKA9iuxgU0KwfHu7HHBKkD2XO5ieyb/J9b8HGUkaHw04uw8PTO/1XK/4Ggla+G
         DAEYD0Xw3s6QEKppixUTZEFuE19V1hRlv6rSGg6FnakzWD6TO/jfvftnzohWlhxqNk
         GviRj4fNCwGrb1kE2ZFcuqoPe1zsJV0d38wnE9vmbhVjjmXlL/R6+WbqivB82vD5FX
         BoFi8KK0q6y2g==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/4/2019 3:53 PM, Vinod Koul wrote:
> On 02-05-19, 18:59, Sameer Pujar wrote:
>> On 5/2/2019 5:55 PM, Vinod Koul wrote:
>>> On 02-05-19, 16:23, Sameer Pujar wrote:
>>>> On 5/2/2019 11:34 AM, Vinod Koul wrote:
>>>>> On 30-04-19, 17:00, Sameer Pujar wrote:
>>>>>> During the DMA transfers from memory to I/O, it was observed that tr=
ansfers
>>>>>> were inconsistent and resulted in glitches for audio playback. It ha=
ppened
>>>>>> because fifo size on DMA did not match with slave channel configurat=
ion.
>>>>>>
>>>>>> currently 'dma_slave_config' structure does not have a field for fif=
o size.
>>>>>> Hence the platform pcm driver cannot pass the fifo size as a slave_c=
onfig.
>>>>>> Note that 'snd_dmaengine_dai_dma_data' structure has fifo_size field=
 which
>>>>>> cannot be used to pass the size info. This patch introduces fifo_siz=
e field
>>>>>> and the same can be populated on slave side. Users can set required =
size
>>>>>> for slave peripheral (multiple channels can be independently running=
 with
>>>>>> different fifo sizes) and the corresponding sizes are programmed thr=
ough
>>>>>> dma_slave_config on DMA side.
>>>>> FIFO size is a hardware property not sure why you would want an
>>>>> interface to program that?
>>>>>
>>>>> On mismatch, I guess you need to take care of src/dst_maxburst..
>>>> Yes, FIFO size is a HW property. But it is SW configurable(atleast in =
my
>>>> case) on
>>>> slave side and can be set to different sizes. The src/dst_maxburst is
>>> Are you sure, have you talked to HW folks on that? IIUC you are
>>> programming the data to be used in FIFO not the FIFO length!
>> Yes, I mentioned about FIFO length.
>>
>> 1. MAX FIFO size is fixed in HW. But there is a way to limit the usage p=
er
>> channel
>>  =C2=A0=C2=A0 in multiples of 64 bytes.
>> 2. Having a separate member would give independent control over MAX BURS=
T
>> SIZE and
>>  =C2=A0=C2=A0 FIFO SIZE.
>>>> programmed
>>>> for specific values, I think this depends on few factors related to
>>>> bandwidth
>>>> needs of client, DMA needs of the system etc.,
>>> Precisely
>>>
>>>> In such cases how does DMA know the actual FIFO depth of slave periphe=
ral?
>>> Why should DMA know? Its job is to push/pull data as configured by
>>> peripheral driver. The peripheral driver knows and configures DMA
>>> accordingly.
>> I am not sure if there is any HW logic that mandates DMA to know the siz=
e
>> of configured FIFO depth on slave side. I will speak to HW folks and
>> would update here.
> I still do not comprehend why dma would care about slave side
> configuration. In the absence of patch which uses this I am not sure
> what you are trying to do...

I am using DMA HW in cyclic mode for data transfers to Audio sub-system.
In such cases flow control on DMA transfers is essential, since I/O is
consuming/producing the data at slower rate. The DMA tranfer is enabled/
disabled during start/stop of audio playback/capture sessions through ALSA
callbacks and DMA runs in cyclic mode. Hence DMA is the one which is doing
flow control and it is necessary for it to know the peripheral FIFO depth
to avoid overruns/underruns.

Also please note that, peripheral device has multiple channels and share
a fixed MAX FIFO buffer. But SW can program different FIFO sizes for
individual channels.

>>>>>> Request for feedback/suggestions.
>>>>>>
>>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>>>> ---
>>>>>>     include/linux/dmaengine.h | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>>>>>> index d49ec5c..9ec198b 100644
>>>>>> --- a/include/linux/dmaengine.h
>>>>>> +++ b/include/linux/dmaengine.h
>>>>>> @@ -351,6 +351,8 @@ enum dma_slave_buswidth {
>>>>>>      * @slave_id: Slave requester id. Only valid for slave channels.=
 The dma
>>>>>>      * slave peripheral will have unique id as dma requester which n=
eed to be
>>>>>>      * pass as slave config.
>>>>>> + * @fifo_size: Fifo size value. The dma slave peripheral can config=
ure required
>>>>>> + * fifo size and the same needs to be passed as slave config.
>>>>>>      *
>>>>>>      * This struct is passed in as configuration data to a DMA engin=
e
>>>>>>      * in order to set up a certain channel for DMA transport at run=
time.
>>>>>> @@ -376,6 +378,7 @@ struct dma_slave_config {
>>>>>>     	u32 dst_port_window_size;
>>>>>>     	bool device_fc;
>>>>>>     	unsigned int slave_id;
>>>>>> +	u32 fifo_size;
>>>>>>     };
>>>>>>     /**
>>>>>> --=20
>>>>>> 2.7.4
