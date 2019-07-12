Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA867610
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2019 23:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfGLVCQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jul 2019 17:02:16 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60888 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfGLVCQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 Jul 2019 17:02:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6CL22jW058997;
        Fri, 12 Jul 2019 16:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562965322;
        bh=coaQynstDqA5HGnoz6Wom66HS4fobTvO2GZTeSoACMM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ig42kFf8tlOkVjHazoZ8sTZbCcIGBlfhM5Bmp/TBps7/4hxzvDP6Pis5eyATGhC3u
         5MU4E/LfOCRRNqku1GlthgklNRLp3OgImfvFAsy9q4KwF7zFNJHreOCh4ZTfCxyDY9
         cOflcveCEpSTthHmoBDzUX7OhDy4UlvhOQ5bTyqE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6CL22pk016056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jul 2019 16:02:02 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Jul 2019 16:02:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Jul 2019 16:02:02 -0500
Received: from [10.250.145.87] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6CL20Ke100886;
        Fri, 12 Jul 2019 16:02:00 -0500
Subject: Re: [PATCH v4 3/3] dmaengine: ti: edma: Support for polled (memcpy)
 completion
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
References: <20190618132148.26468-1-peter.ujfalusi@ti.com>
 <20190618132148.26468-4-peter.ujfalusi@ti.com>
 <20190705061714.GU2911@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d695a2fa-61d4-e312-11d9-b501b6bc18a7@ti.com>
Date:   Sat, 13 Jul 2019 00:05:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705061714.GU2911@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5.7.2019 9.17, Vinod Koul wrote:
>> @@ -1840,18 +1847,40 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
>>  {
>>  	struct edma_chan *echan = to_edma_chan(chan);
>>  	struct virt_dma_desc *vdesc;
>> +	struct dma_tx_state txstate_tmp;
>>  	enum dma_status ret;
>>  	unsigned long flags;
>>  
>>  	ret = dma_cookie_status(chan, cookie, txstate);
>> -	if (ret == DMA_COMPLETE || !txstate)
>> +
>> +	/* Provide a dummy dma_tx_state for completion checking */
>> +	if (ret != DMA_COMPLETE && !txstate)
>> +		txstate = &txstate_tmp;
>> +
>> +	if (ret == DMA_COMPLETE)
>>  		return ret;
> 
> why not do:
> 
>         if (ret == DMA_COMPLETE)
>                 return ret;
> 
>         if (!txstate)
>                 txstate = &txstate_tmp;
>

Indeed it is much cleaner this way. Will send an updated series next week.

>> +	txstate->residue = 0;
>>  	spin_lock_irqsave(&echan->vchan.lock, flags);
>>  	if (echan->edesc && echan->edesc->vdesc.tx.cookie == cookie)
>>  		txstate->residue = edma_residue(echan->edesc);
>>  	else if ((vdesc = vchan_find_desc(&echan->vchan, cookie)))
>>  		txstate->residue = to_edma_desc(&vdesc->tx)->residue;
>> +
>> +	/*
>> +	 * Mark the cookie completed if the residue is 0 for non cyclic
>> +	 * transfers
>> +	 */
>> +	if (ret != DMA_COMPLETE && !txstate->residue &&
>> +	    echan->edesc && echan->edesc->polled &&
>> +	    echan->edesc->vdesc.tx.cookie == cookie) {
>> +		edma_stop(echan);
>> +		vchan_cookie_complete(&echan->edesc->vdesc);
>> +		echan->edesc = NULL;
>> +		edma_execute(echan);
>> +		ret = DMA_COMPLETE;
>> +	}
>> +
>>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>>  
>>  	return ret;
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
