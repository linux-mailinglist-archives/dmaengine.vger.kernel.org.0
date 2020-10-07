Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648B5287093
	for <lists+dmaengine@lfdr.de>; Thu,  8 Oct 2020 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgJHIQf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Oct 2020 04:16:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33056 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJHIQf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 8 Oct 2020 04:16:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09787mQJ058891;
        Wed, 7 Oct 2020 03:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602058068;
        bh=HBdm4jMYOIuFapa+zEYL7vDmmKD8A9YuA8HzW2ojmgQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gESAPEWJbVi7NFAK+NpiJIg1oKLvWNHCfXRImxDjfMXErUyg9yRkIHtoUduq+tGmR
         leUgKvW8EnBo1t0dCKiaggeZQm9+hme8PSuI4S+F8vZu/D3LGbAa24j7IgigjmpTRv
         ASye8b1mWpVKnohV4uLRCyjSuTC6eHDQ8MVN5yaA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09787mfk056031
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Oct 2020 03:07:48 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 7 Oct
 2020 03:07:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 7 Oct 2020 03:07:48 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09787jjn059638;
        Wed, 7 Oct 2020 03:07:45 -0500
Subject: Re: [PATCH 01/18] dmaengine: of-dma: Add support for optional router
 configuration callback
To:     Vinod Koul <vkoul@kernel.org>
CC:     <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>,
        <vigneshr@ti.com>, <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-2-peter.ujfalusi@ti.com>
 <20201007054404.GR2968@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <be615881-1eb4-f8fe-a32d-04fabb6cb27b@ti.com>
Date:   Wed, 7 Oct 2020 11:08:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007054404.GR2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/10/2020 8.44, Vinod Koul wrote:
> Hi Peter,
> 
> On 30-09-20, 12:13, Peter Ujfalusi wrote:
>> Additional configuration for the DMA event router might be needed for a
>> channel which can not be done during device_alloc_chan_resources callback
>> since the router information is not yet present for the drivers.
>>
>> If there is a need for additional configuration for the channel if DMA
>> router is in use, then the driver can implement the device_router_config
>> callback.
> 
> So what is the additional information you need, I am looking at the code
> below and xlate invokes device_router_config() which driver will
> implement..

The router driver is not yet ready due to external dependencies, it will
come a bit later.

> Are you using this to configure channels based on info from DT?

Not really. In DT an event triggered channel can be requested via router
(when this is used) for example:

dmas = <&inta_l2g a b c>;
a - the input number of the DMA request in l2g
b - edge or level trigger to be selected
c - ASEL number for the channel for coherency

The l2g router driver then translate this to:
<&main_bcdma 1 0 c>
1 - Global trigger 0 is used by the DMA
0 - ignored
c - ASEL number.

The router needs to send an event which is going to be received by the
channel we have picked up, this event number can only be known when we
do have the channel.

So the flow in this case:
router converts the dma_spec for the DMA, but it does not yet know what
is the event number it has to use.
The BCDMA driver will pick an available bchan and notes that the
transfers will be triggered by global event 0.
When we have the channel, the core saves the router information and
calls the device_router_config of BCDMA.
In there we call back to the router and give the event number it has to
use to send the trigger for the channel.

>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/of-dma.c      | 10 ++++++++++
>>  include/linux/dmaengine.h |  2 ++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
>> index 8a4f608904b9..ec00b20ae8e4 100644
>> --- a/drivers/dma/of-dma.c
>> +++ b/drivers/dma/of-dma.c
>> @@ -75,8 +75,18 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
>>  		ofdma->dma_router->route_free(ofdma->dma_router->dev,
>>  					      route_data);
>>  	} else {
>> +		int ret = 0;
>> +
>>  		chan->router = ofdma->dma_router;
>>  		chan->route_data = route_data;
>> +
>> +		if (chan->device->device_router_config)
>> +			ret = chan->device->device_router_config(chan);
>> +
>> +		if (ret) {
>> +			dma_release_channel(chan);
>> +			chan = ERR_PTR(ret);
>> +		}
>>  	}
>>  
>>  	/*
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index dd357a747780..d6197fe875af 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -800,6 +800,7 @@ struct dma_filter {
>>   *	by tx_status
>>   * @device_alloc_chan_resources: allocate resources and return the
>>   *	number of allocated descriptors
>> + * @device_router_config: optional callback for DMA router configuration
>>   * @device_free_chan_resources: release DMA channel's resources
>>   * @device_prep_dma_memcpy: prepares a memcpy operation
>>   * @device_prep_dma_xor: prepares a xor operation
>> @@ -874,6 +875,7 @@ struct dma_device {
>>  	enum dma_residue_granularity residue_granularity;
>>  
>>  	int (*device_alloc_chan_resources)(struct dma_chan *chan);
>> +	int (*device_router_config)(struct dma_chan *chan);
>>  	void (*device_free_chan_resources)(struct dma_chan *chan);
>>  
>>  	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
