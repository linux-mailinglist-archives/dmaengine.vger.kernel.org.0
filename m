Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33B3B3C8
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jun 2019 13:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfFJLLg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 07:11:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44692 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfFJLLf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jun 2019 07:11:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5ABBV29100306;
        Mon, 10 Jun 2019 06:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560165091;
        bh=B51ZvcAM9+Asulzy4hrbXlCctlUQOGbhN8igWASkei0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cjPSbIFmvrlknLBiiN3Lur+Em763KtbcF7sLf4ONpGTHaAxpWiDCOFc42kBl8ldwB
         wK0ivxbE6Dr6yrB6vXgFzoiqpAq8TrjWam7yXHnsj5XkhvujLx/MgdEoqA8Lnn8Fcm
         RRYVtkCmOGQckPWoHUNNA2gzDF71o8Jawa2QAfKQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5ABBVkg105893
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jun 2019 06:11:31 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 10
 Jun 2019 06:11:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 10 Jun 2019 06:11:30 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5ABBTXb066787;
        Mon, 10 Jun 2019 06:11:29 -0500
Subject: Re: [PATCH] dmaengine: dmatest: Add support for completion polling
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>
References: <20190529083724.18182-1-peter.ujfalusi@ti.com>
 <4f327f4a-9e3d-c9d2-fe48-14e492b07417@ti.com>
 <793f9f48-0609-4aa5-2688-bf30525e229c@ti.com>
 <20190604124527.GG15118@vkoul-mobl>
 <0e909b8a-8296-7c6a-058a-3fc780d66195@ti.com>
 <20190610070435.GL9160@vkoul-mobl.Dlink>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <01766659-4b81-cf58-8b00-458b6272c7ef@ti.com>
Date:   Mon, 10 Jun 2019 14:12:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610070435.GL9160@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/06/2019 10.04, Vinod Koul wrote:
>>> I think we should view DMA_PREP_INTERRUPT from client pov, but
>>> controller cannot get away with disabling interrupts IMO.
>>
>> What happens if client is issuing a DMA memcpy (short one) while
>> interrupts are disabled?
>>
>> The user for this is:
>> drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>>
>> commit: f5b9930b85dc6319fd6bcc259e447eff62fc691c
>>
>> The interrupt based completion is not going to work in some cases, the
>> DMA driver should obey that the missing DMA_PREP_INTERRUPT really
>> implies that interrupts can not be used.
> 
> well yes but how do we *assume* completion and issue subsequent txns?
> Does driver create a task and poll?

The client driver will poll on tx_status, like using dma_sync_wait().
The DMA driver is expected to check if the transfer is completed by
other means than relying on the interrupt for transfer completion.

>>
>>> Assuming I had enough caffeine before I thought process, then client would
>>> poll descriptor status using cookie and should free up once the cookie
>>> is freed, makes sense?
>>
>> OK, so clients are expected to call dmaengine_terminate_*
>> unconditionally after the transfer is completed, right?
> 
> How do you know/detect transfer is completed?

This is a bit tricky and depends on the DMA hardware.
For sDMA (omap-dma) we already do this by checking the channel status.
The channel will be switched to idle if the transfer is completed.

EDMA on the other hand does not provide straight forward way to check if
the transfer is completed w/o interrupts, however we can see it if the
CC loaded the closing dummy paRAM slot (address is 0).

If I want to enable this for UDMAP then I would check the return ring if
I got back the descriptor or not.

>> If we use interrupts then the handler would anyway free up the
>> descriptor, so terminating should not do any harm, if we can not have
>> interrupts then terminate will clear up the completed descriptor
>> proactively.
> 
> yes terminate part is fine.

OK, so I don't need to change this patch for dmatest, right?

I'll prepare the EDMA patch and an update for omap-dma as well.

>> In any case I have updated the EDMA patch to do the same thing in case
>> of polling w/o interrupts as it would do in the completion irq handler,
>> and similar approach prepared for omap-dma as well.
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
