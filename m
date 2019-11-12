Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEEF8996
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 08:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfKLHVr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 02:21:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56730 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfKLHVr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Nov 2019 02:21:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAC7LVf2088839;
        Tue, 12 Nov 2019 01:21:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573543291;
        bh=woQZTsKk2OYK92qovCWNbbXV0PHk/eUYSwCK3xC7AAY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ml6kIdY/D3Pk57pR/ISnCy1mReqQOqi/pEuYbG7qD94Wmf6BTfezl8lghQ0smAYrN
         CPdQqerXhDgQdCwg//Rlg5l52uiSeEoHvEuBD1Ly8rcCtyvF61TKIGxl5GY8Dys4Yv
         OAR52Hnz9jlDy054X9haVvAyLupTvrNNi3XF/eOw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAC7LVhj046541;
        Tue, 12 Nov 2019 01:21:31 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 01:21:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 01:21:13 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAC7LRRS015248;
        Tue, 12 Nov 2019 01:21:27 -0600
Subject: Re: [PATCH v4 10/15] dmaengine: ti: New driver for K3 UDMA - split#2:
 probe/remove, xlate and filter_fn
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-11-peter.ujfalusi@ti.com>
 <20191111053301.GO952516@vkoul-mobl>
 <9b0f8bec-4964-8136-4173-7b45e479c0c5@ti.com>
 <20191112053440.GV952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <faa0f80d-ab8f-effc-07da-f1328a3d9c01@ti.com>
Date:   Tue, 12 Nov 2019 09:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112053440.GV952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/11/2019 7.34, Vinod Koul wrote:
> On 11-11-19, 11:16, Peter Ujfalusi wrote:
>>
>>
>> On 11/11/2019 7.33, Vinod Koul wrote:
>>> On 01-11-19, 10:41, Peter Ujfalusi wrote:
>>>
>>>> +static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
>>>> +{
>>>> +	struct psil_endpoint_config *ep_config;
>>>> +	struct udma_chan *uc;
>>>> +	struct udma_dev *ud;
>>>> +	u32 *args;
>>>> +
>>>> +	if (chan->device->dev->driver != &udma_driver.driver)
>>>> +		return false;
>>>> +
>>>> +	uc = to_udma_chan(chan);
>>>> +	ud = uc->ud;
>>>> +	args = param;
>>>> +	uc->remote_thread_id = args[0];
>>>> +
>>>> +	if (uc->remote_thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)
>>>> +		uc->dir = DMA_MEM_TO_DEV;
>>>> +	else
>>>> +		uc->dir = DMA_DEV_TO_MEM;
>>>
>>> Can you explain this a bit?
>>
>> The UDMAP in K3 works between two PSI-L endpoint. The source and
>> destination needs to be paired to allow data flow.
>> Source thread IDs are in range of 0x0000 - 0x7fff, while destination
>> thread IDs are 0x8000 - 0xffff.
>>
>> If the remote thread ID have the bit 31 set (0x8000) then the transfer
>> is MEM_TO_DEV and I need to pick one unused tchan for it. If the remote
>> is the source then it can be handled by rchan.
>>
>> dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
>> dma-names = "tx", "rx";
>>
>> 0xc400 is a destination thread ID, so it is MEM_TO_DEV
>> 0x4400 is a source thread ID, so it is DEV_TO_MEM
>>
>> Even in MEM_TO_MEM case I need to pair two UDMAP channels:
>> UDMAP source threads are starting at offset 0x1000, UDMAP destination
>> threads are 0x9000+
> 
> Okay so a channel is set for a direction until teardown. Also this and
> other patch comments are quite useful, can we add them here?

The direction checks in the prep callbacks do print the reason why the
transfer is rejected when it comes to not matching direction.

Having said that, I can add comment to the udma_alloc_chan_resources()
function about this restriction, or better a dev_dbg() to say that the
given channel is allocated for a given direction.

>> Changing direction runtime is hardly possible as it would involve
>> tearing down the channel, removing interrupts, destroying rings,
>> removing the PSI-L pairing and redoing everything.
> 
> okay I would expect the prep_ to check for direction and reject the call
> if direction is different.

They do check, udma_prep_slave_sg() and udma_prep_dma_cyclic():
if (dir != uc->dir) {
	dev_err(chan->device->dev,
		"%s: chan%d is for %s, not supporting %s\n",
		__func__, uc->id, udma_get_dir_text(uc->dir),
		udma_get_dir_text(dir));
	return NULL;
}

udma_prep_dma_memcpy():
if (uc->dir != DMA_MEM_TO_MEM) {
	dev_err(chan->device->dev,
		"%s: chan%d is for %s, not supporting %s\n",
		__func__, uc->id, udma_get_dir_text(uc->dir),
		udma_get_dir_text(DMA_MEM_TO_MEM));
	return NULL;
}

> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
