Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD8127781
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 09:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLTItt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 03:49:49 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37080 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfLTItt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 03:49:49 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBK8ndb2019139;
        Fri, 20 Dec 2019 02:49:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576831779;
        bh=tk22WolYB8BNRlJKA3l1OQpPiF/uHGCR6nzT2IFL+64=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y5xUQt7tZox9pBfIRCjAS8Pe5hD6nPL90Q+qFhpq4R27TBM/lCNt97e7E+Ue2r1G7
         1+Wh0mF+fBvsBgmK/3AvX3yIKf8NJOvqameS1fLTvAXQ2uxT1EA7EZRANU3cHfAcyP
         YoqH7TmF9pTPaprsyqjDeCDrUZIFRqQLDvIW8rn4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBK8ndZT097784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Dec 2019 02:49:39 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 02:49:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 02:49:38 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBK8nYH9105823;
        Fri, 20 Dec 2019 02:49:35 -0600
Subject: Re: [PATCH v7 05/12] dmaengine: Add support for reporting DMA cached
 data amount
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-6-peter.ujfalusi@ti.com>
 <20191220083713.GL2536@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f28301f7-4624-b4f8-d781-7ebfa4ae7856@ti.com>
Date:   Fri, 20 Dec 2019 10:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191220083713.GL2536@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 20/12/2019 10.37, Vinod Koul wrote:
> On 09-12-19, 11:43, Peter Ujfalusi wrote:
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
> 
> This would be used by dmaengine drivers right, so lets move it to drivers/dma/dmaengine.h
> 
> lets not expose this to users :)

I have put it where the dma_set_residue() was.
I can add a patch first to move dma_set_residue() then add
dma_set_in_flight_bytes() there as well?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
