Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571FD285A58
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgJGIWq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 04:22:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45210 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgJGIWq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Oct 2020 04:22:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0978McFf110394;
        Wed, 7 Oct 2020 03:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602058958;
        bh=fQFE7sGDqZdok5OvK6iGtl1lyFb8J/X+nm8IT+21uSg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fMGtC0/S0jbk1EMLXNwUvXRaszFWa2NOfPXH4bHHiO7YvmLkBmgAMfMS5ukD5eb83
         OI1eJNr+PWItT+zp6hF3TMekb07vTOXSwh2qE7IVcEHQQ1M92E+1pslWFrLLrw6bLS
         N7BJ9dIDQxyStn2qOkKUKPozD6hCYaVv9AQxFv34=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0978MbSr082643
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Oct 2020 03:22:37 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 7 Oct
 2020 03:22:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 7 Oct 2020 03:22:37 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0978MYqc012043;
        Wed, 7 Oct 2020 03:22:35 -0500
Subject: Re: [PATCH 07/18] dmaengine: ti: k3-udma-glue: Add function to get
 device pointer for DMA API
To:     Vinod Koul <vkoul@kernel.org>
CC:     <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>,
        <vigneshr@ti.com>, <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-8-peter.ujfalusi@ti.com>
 <20201007065305.GS2968@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <71d190e7-5654-e873-16b0-3b9bd6e8bf7a@ti.com>
Date:   Wed, 7 Oct 2020 11:22:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007065305.GS2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/10/2020 9.53, Vinod Koul wrote:
> On 30-09-20, 12:14, Peter Ujfalusi wrote:
>> Glue layer users should use the device of the DMA for DMA mapping and
>> allocations as it is the DMA which accesses to descriptors and buffers,
>> not the clients
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma-glue.c    | 14 ++++++++++++++
>>  drivers/dma/ti/k3-udma-private.c |  6 ++++++
>>  drivers/dma/ti/k3-udma.h         |  1 +
>>  include/linux/dma/k3-udma-glue.h |  4 ++++
>>  4 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
>> index a367584f0d7b..a53bc4707ae8 100644
>> --- a/drivers/dma/ti/k3-udma-glue.c
>> +++ b/drivers/dma/ti/k3-udma-glue.c
>> @@ -487,6 +487,13 @@ int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn)
>>  }
>>  EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_irq);
>>  
>> +struct device *
>> +	k3_udma_glue_tx_get_dma_device(struct k3_udma_glue_tx_channel *tx_chn)
> 
> How about..
> 
> struct device *
> k3_udma_glue_tx_get_dma_device(struct k3_udma_glue_tx_channel *tx_chn)

OK.

> 
>> +{
>> +	return xudma_get_device(tx_chn->common.udmax);
>> +}
>> +EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_dma_device);
> 
> Hmm why would you need to export this device.. Can you please outline
> all the devices involved here...

In upstream we have one user of the udma-glue layer:
drivers/net/ethernet/ti/am65-cpsw-nuss.c

It is allocating memory to be used with DMA (descriptor pool), it needs
to use correct device for DMA API.
The cpsw atm using it's own dev for allocation, which is wrong, but it
worked fine as am654/j721e/j7200 is all coherent.

> why not use dmaI_dev->dev or chan->dev?

The glue layer does not use DMAengine API to request a channel as it
require special resource setup compared to what is possible via generic
API. We have kept the DMAengine and Glue layer as separate until I have
time to extend the core to support the features we would need to remove
the Glue layer.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
