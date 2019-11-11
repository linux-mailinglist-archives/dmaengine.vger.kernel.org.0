Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9CF6F4E
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 08:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKKH7v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 02:59:51 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55172 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfKKH7v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 02:59:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAB7xf7o026902;
        Mon, 11 Nov 2019 01:59:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573459181;
        bh=Lz8MXx9Ipzrc2GJ3x5jttN6h2LWeeejmmWOpGkLe3GA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b18hgvTxSvyb/8sGeN9WquAaxtxGP5I1R2C/nuG64urQaoOt5TlTLK3H8ykY6eK2u
         dElAXU8CtAF83saXafzu0I93nyQP6UJtFDdXr/e2amfMp6YhIXrjKS8v+YcQ09Pgih
         pGuPs8g+ea+bfUxIFx75PIqPteOepDlV0BahpAWY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAB7xf0J074396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 01:59:41 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 01:59:39 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 01:59:22 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB7xZZH105987;
        Mon, 11 Nov 2019 01:59:36 -0600
Subject: Re: [PATCH v4 05/15] dmaengine: Add support for reporting DMA cached
 data amount
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-6-peter.ujfalusi@ti.com>
 <20191111043957.GL952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <796d2a17-0807-c0f3-fda8-434357edeccf@ti.com>
Date:   Mon, 11 Nov 2019 10:00:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111043957.GL952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/11/2019 6.39, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
>> A DMA hardware can have big cache or FIFO and the amount of data sitting in
>> the DMA fabric can be an interest for the clients.
>>
>> For example in audio we want to know the delay in the data flow and in case
>> the DMA have significantly large FIFO/cache, it can affect the latenc/delay
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Reviewed-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>  drivers/dma/dmaengine.h   | 8 ++++++++
>>  include/linux/dmaengine.h | 2 ++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
>> index 501c0b063f85..b0b97475707a 100644
>> --- a/drivers/dma/dmaengine.h
>> +++ b/drivers/dma/dmaengine.h
>> @@ -77,6 +77,7 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
>>  		state->last = complete;
>>  		state->used = used;
>>  		state->residue = 0;
>> +		state->in_flight_bytes = 0;
>>  	}
>>  	return dma_async_is_complete(cookie, complete, used);
>>  }
>> @@ -87,6 +88,13 @@ static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
>>  		state->residue = residue;
>>  }
>>  
>> +static inline void dma_set_in_flight_bytes(struct dma_tx_state *state,
>> +					   u32 in_flight_bytes)
>> +{
>> +	if (state)
>> +		state->in_flight_bytes = in_flight_bytes;
>> +}
>> +
>>  struct dmaengine_desc_callback {
>>  	dma_async_tx_callback callback;
>>  	dma_async_tx_callback_result callback_result;
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 0e8b426bbde9..c4c5219030a6 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -682,11 +682,13 @@ static inline struct dma_async_tx_descriptor *txd_next(struct dma_async_tx_descr
>>   * @residue: the remaining number of bytes left to transmit
>>   *	on the selected transfer for states DMA_IN_PROGRESS and
>>   *	DMA_PAUSED if this is implemented in the driver, else 0
>> + * @in_flight_bytes: amount of data in bytes cached by the DMA.
>>   */
>>  struct dma_tx_state {
>>  	dma_cookie_t last;
>>  	dma_cookie_t used;
>>  	u32 residue;
>> +	u32 in_flight_bytes;
> 
> Should we add this here or use the dmaengine_result()

Ideally at the time dmaengine_result is used (at tx completion callback)
there should be nothing in flight ;)

The reason why it is added to dma_tx_state is that clients can check at
any time while the DMA is running the number of cached bytes.
Audio needs this for cyclic and UART also needs to know it.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
