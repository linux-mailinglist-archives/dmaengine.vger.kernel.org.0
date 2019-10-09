Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0708D0AC7
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 11:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJIJSC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 05:18:02 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46390 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJIJSB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 05:18:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x999Hq59041429;
        Wed, 9 Oct 2019 04:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570612672;
        bh=BiA0D7K8f4yqHuNEy0TGXDKxAwiZ2tjyG1G/l4l31HE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xKQlY4cafMy8hP7XR/deImH1+FQhK2Bvt4/fu2SmKi+Lh8Z40j3nLuLcPKYuC/FNN
         haAXy0M9bBFvnoUuol5hOt5arOWOkyLtwUlOqjjEh9PUx4YhQHSgxQmX7m+zqQFCHU
         T3xjUvti6pjnwRS7d+VJUqe2/vBRJVF5hH8sa9is=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x999Hqqw083397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Oct 2019 04:17:52 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 04:17:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 04:17:51 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x999Hlcw101048;
        Wed, 9 Oct 2019 04:17:48 -0500
Subject: Re: [PATCH v3 05/14] dmaengine: Add support for reporting DMA cached
 data amount
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-6-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <b20087a9-6a1f-6e5c-9311-e921a1c63f13@ti.com>
Date:   Wed, 9 Oct 2019 12:17:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001061704.2399-6-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01/10/2019 09:16, Peter Ujfalusi wrote:
> A DMA hardware can have big cache or FIFO and the amount of data sitting in
> the DMA fabric can be an interest for the clients.
> 
> For example in audio we want to know the delay in the data flow and in case
> the DMA have significantly large FIFO/cache, it can affect the latenc/delay
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/dma/dmaengine.h   | 8 ++++++++
>   include/linux/dmaengine.h | 2 ++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 501c0b063f85..b0b97475707a 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -77,6 +77,7 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
>   		state->last = complete;
>   		state->used = used;
>   		state->residue = 0;
> +		state->in_flight_bytes = 0;
>   	}
>   	return dma_async_is_complete(cookie, complete, used);
>   }
> @@ -87,6 +88,13 @@ static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
>   		state->residue = residue;
>   }
>   
> +static inline void dma_set_in_flight_bytes(struct dma_tx_state *state,
> +					   u32 in_flight_bytes)
> +{
> +	if (state)
> +		state->in_flight_bytes = in_flight_bytes;
> +}
> +
>   struct dmaengine_desc_callback {
>   	dma_async_tx_callback callback;
>   	dma_async_tx_callback_result callback_result;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 40d062c3b359..02ceef95340a 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -682,11 +682,13 @@ static inline struct dma_async_tx_descriptor *txd_next(struct dma_async_tx_descr
>    * @residue: the remaining number of bytes left to transmit
>    *	on the selected transfer for states DMA_IN_PROGRESS and
>    *	DMA_PAUSED if this is implemented in the driver, else 0
> + * @in_flight_bytes: amount of data in bytes cached by the DMA.
>    */
>   struct dma_tx_state {
>   	dma_cookie_t last;
>   	dma_cookie_t used;
>   	u32 residue;
> +	u32 in_flight_bytes;
>   };
>   
>   /**
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
