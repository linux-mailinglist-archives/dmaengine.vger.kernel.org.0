Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE80133E0
	for <lists+dmaengine@lfdr.de>; Fri,  3 May 2019 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfECTHm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 May 2019 15:07:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60288 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfECTHl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 May 2019 15:07:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x43J7Xcc110358;
        Fri, 3 May 2019 14:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556910453;
        bh=pYv6PEbbvUQ4QwW2nRLlz/8c0qEeR+Fe/OgZ13lvx2A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fPiDCoIN1R4UFVQ/5AlFFA+C9j5DIR3CpAV5TlaLCthE8K5ImPqRPjXyO4fOqsiWC
         T7lE1Z4XI5TD5lP+bYcG81iDmuF9G1jmy/1cRtNwwTltf8o9tctM1m6aOh9/yMeniG
         yXkuK+nTd91QrvOtzv7KzudIB+dqMmAo8KsFFDxE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x43J7XbQ044522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 May 2019 14:07:33 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 3 May
 2019 14:07:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 3 May 2019 14:07:31 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x43J7UXi101169;
        Fri, 3 May 2019 14:07:30 -0500
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <076bd6cc-aff2-693e-2c68-837d0d552df1@ti.com>
Date:   Fri, 3 May 2019 22:10:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/2/19 4:29 PM, Sameer Pujar wrote:
> 
> On 5/2/2019 5:55 PM, Vinod Koul wrote:
>> On 02-05-19, 16:23, Sameer Pujar wrote:
>>> On 5/2/2019 11:34 AM, Vinod Koul wrote:
>>>> On 30-04-19, 17:00, Sameer Pujar wrote:
>>>>> During the DMA transfers from memory to I/O, it was observed that
>>>>> transfers
>>>>> were inconsistent and resulted in glitches for audio playback. It
>>>>> happened
>>>>> because fifo size on DMA did not match with slave channel
>>>>> configuration.
>>>>>
>>>>> currently 'dma_slave_config' structure does not have a field for
>>>>> fifo size.
>>>>> Hence the platform pcm driver cannot pass the fifo size as a
>>>>> slave_config.
>>>>> Note that 'snd_dmaengine_dai_dma_data' structure has fifo_size
>>>>> field which
>>>>> cannot be used to pass the size info. This patch introduces
>>>>> fifo_size field
>>>>> and the same can be populated on slave side. Users can set required
>>>>> size
>>>>> for slave peripheral (multiple channels can be independently
>>>>> running with
>>>>> different fifo sizes) and the corresponding sizes are programmed
>>>>> through
>>>>> dma_slave_config on DMA side.
>>>> FIFO size is a hardware property not sure why you would want an
>>>> interface to program that?
>>>>
>>>> On mismatch, I guess you need to take care of src/dst_maxburst..
>>> Yes, FIFO size is a HW property. But it is SW configurable(atleast in my
>>> case) on
>>> slave side and can be set to different sizes. The src/dst_maxburst is
>> Are you sure, have you talked to HW folks on that? IIUC you are
>> programming the data to be used in FIFO not the FIFO length!
> Yes, I mentioned about FIFO length.
> 
> 1. MAX FIFO size is fixed in HW. But there is a way to limit the usage
> per channel
>    in multiples of 64 bytes.
> 2. Having a separate member would give independent control over MAX
> BURST SIZE and
>    FIFO SIZE.

Why would the DMA care about the FIFO size of a peripheral?
All it should be concerned that how many bytes it should transfer per
DMA request from the peripheral.
It is the task of the peripheral driver to choose the maxburst to match
with the peripheral's configuration and the peripheral configuration
should not allow maxburst to overflow (or underflow) the peripheral FIFO.

>>
>>> programmed
>>> for specific values, I think this depends on few factors related to
>>> bandwidth
>>> needs of client, DMA needs of the system etc.,
>> Precisely
>>
>>> In such cases how does DMA know the actual FIFO depth of slave
>>> peripheral?
>> Why should DMA know? Its job is to push/pull data as configured by
>> peripheral driver. The peripheral driver knows and configures DMA
>> accordingly.
> I am not sure if there is any HW logic that mandates DMA to know the size
> of configured FIFO depth on slave side. I will speak to HW folks and
> would update here.
>>  
>>>>> Request for feedback/suggestions.
>>>>>
>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>>> ---
>>>>>    include/linux/dmaengine.h | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>>>>> index d49ec5c..9ec198b 100644
>>>>> --- a/include/linux/dmaengine.h
>>>>> +++ b/include/linux/dmaengine.h
>>>>> @@ -351,6 +351,8 @@ enum dma_slave_buswidth {
>>>>>     * @slave_id: Slave requester id. Only valid for slave channels.
>>>>> The dma
>>>>>     * slave peripheral will have unique id as dma requester which
>>>>> need to be
>>>>>     * pass as slave config.
>>>>> + * @fifo_size: Fifo size value. The dma slave peripheral can
>>>>> configure required
>>>>> + * fifo size and the same needs to be passed as slave config.
>>>>>     *
>>>>>     * This struct is passed in as configuration data to a DMA engine
>>>>>     * in order to set up a certain channel for DMA transport at
>>>>> runtime.
>>>>> @@ -376,6 +378,7 @@ struct dma_slave_config {
>>>>>        u32 dst_port_window_size;
>>>>>        bool device_fc;
>>>>>        unsigned int slave_id;
>>>>> +    u32 fifo_size;
>>>>>    };
>>>>>    /**
>>>>> -- 
>>>>> 2.7.4

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
