Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 689C1247E6
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 08:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfEUGQK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 02:16:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47702 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfEUGQK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 May 2019 02:16:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4L6Fxjl001707;
        Tue, 21 May 2019 01:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558419359;
        bh=BOlHodlIMYLCPqU3G35mi/bOn4BFg+tVJAITFyiE5m8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nZPL69h8s6y0ddhR/IbOVZ3IErJ86Zy4vfk7PFQn6L/VfX7sXYqFo8J35bmQotYVu
         MOpVBYmx2l2DaKh62mcpTYKvsRu8oQaT0pdo2jmdcJaRQXxgbuZF7RkCEAoXI9N87W
         GHyr4arkkL9Dc5leRzaWr5RPXkFvJMC/dPkEvN0E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4L6Fxst101552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 May 2019 01:15:59 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 21
 May 2019 01:15:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 21 May 2019 01:15:58 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4L6FuUi073060;
        Tue, 21 May 2019 01:15:57 -0500
Subject: Re: [PATCH] dmaengine: ti: edma: Enable support for polled (memcpy)
 completion
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
References: <20190514080909.10306-1-peter.ujfalusi@ti.com>
 <20190521050430.GS15118@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ce1a2e96-bc4b-3998-0c36-362867907177@ti.com>
Date:   Tue, 21 May 2019 09:16:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190521050430.GS15118@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 21/05/2019 8.04, Vinod Koul wrote:
> On 14-05-19, 11:09, Peter Ujfalusi wrote:
>> When a DMA client driver decides that it is not providing callback for
>> completion of a transfer (and/or does not set the DMA_PREP_INTERRUPT) but
>> it will poll the status of the transfer (in case of short memcpy for
>> example) we will not get interrupt for the completion of the transfer and
>> will not mark the transaction as done.
>>
>> Check the event registers (ER and EER) and if the channel is inactive then
>> return wioth DMA_COMPLETE to let the client know that the transfer is
>         ^^^^^
> Typo

Ok

> 
>> completed.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/ti/edma.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
>> index ceabdea40ae0..7501445af069 100644
>> --- a/drivers/dma/ti/edma.c
>> +++ b/drivers/dma/ti/edma.c
>> @@ -1211,8 +1211,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>>  
>>  	edesc->pset[0].param.opt |= ITCCHEN;
>>  	if (nslots == 1) {
>> -		/* Enable transfer complete interrupt */
>> -		edesc->pset[0].param.opt |= TCINTEN;
>> +		/* Enable transfer complete interrupt if requested */
>> +		if (tx_flags & DMA_PREP_INTERRUPT)
>> +			edesc->pset[0].param.opt |= TCINTEN;
>>  	} else {
>>  		/* Enable transfer complete chaining for the first slot */
>>  		edesc->pset[0].param.opt |= TCCHEN;
>> @@ -1239,7 +1240,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>>  		}
>>  
>>  		edesc->pset[1].param.opt |= ITCCHEN;
>> -		edesc->pset[1].param.opt |= TCINTEN;
>> +		/* Enable transfer complete interrupt if requested */
>> +		if (tx_flags & DMA_PREP_INTERRUPT)
>> +			edesc->pset[1].param.opt |= TCINTEN;
>>  	}
>>  
>>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
>> @@ -1801,6 +1804,20 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
>>  	unsigned long flags;
>>  
>>  	ret = dma_cookie_status(chan, cookie, txstate);
>> +
>> +	if (ret != DMA_COMPLETE && echan->edesc && !echan->edesc->cyclic) {
>> +		struct edma_cc *ecc = echan->ecc;
>> +		int channel = EDMA_CHAN_SLOT(echan->ch_num);
>> +		int j = (channel >> 5);
>> +		unsigned int mask = BIT(channel & 0x1f);
> 
> GENMASK or define a macro instead of a magic number?

So it is better to change the other places first from where I have just
copied this.

> 
>> +		unsigned int sh_er = edma_shadow0_read_array(ecc, SH_ER, j);
>> +		unsigned int sh_eer = edma_shadow0_read_array(ecc, SH_EER, j);
>> +
>> +		/* The channel is no longer active */
>> +		if (!(sh_er & mask) && !(sh_eer & mask))
>> +			ret = DMA_COMPLETE;
>> +	}
>> +
>>  	if (ret == DMA_COMPLETE || !txstate)
>>  		return ret;
>>  
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
