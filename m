Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C03CD23
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2019 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbfFKNkn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jun 2019 09:40:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42676 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403885AbfFKNkn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jun 2019 09:40:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BDedh9101256;
        Tue, 11 Jun 2019 08:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560260439;
        bh=4LDOhMWM3skVbJlqD3cbqlNxDxWPIjK5XVVEplMzWfg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VGrbuIlaGQ5RGRGOdPq3UtJyNlGtCEHcSo2pcYQ9g/Ld6b69EikxxtMxoqyteWg/0
         KHnP7BU65VU9L3CCRvP4U05sZXKryWTXvgg5jT4sSlfeCxBOtifNmdVr9UO31tZFqa
         OmH1HORUqvncXIeGeO3p/WW9EbeWs5gB+6kOipkk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BDedqk008512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 08:40:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 08:40:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 08:40:38 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BDeawQ084603;
        Tue, 11 Jun 2019 08:40:37 -0500
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
 <01766659-4b81-cf58-8b00-458b6272c7ef@ti.com>
 <20190611044738.GT9160@vkoul-mobl.Dlink>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <33c33189-1c76-fe01-5d03-6bdd877c5e4b@ti.com>
Date:   Tue, 11 Jun 2019 16:41:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611044738.GT9160@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11/06/2019 7.47, Vinod Koul wrote:
> On 10-06-19, 14:12, Peter Ujfalusi wrote:
>>> How do you know/detect transfer is completed?
>>
>> This is a bit tricky and depends on the DMA hardware.
>> For sDMA (omap-dma) we already do this by checking the channel status.
>> The channel will be switched to idle if the transfer is completed.
> 
> Well we are talking about DMA and doing this kind of things doesn't make
> sense to me. Why not do memcpy/pio instead. DMA is designed to finish
> txn fast and move to next one, if we cannot do that, I would say lets
> not use dmaengine in those cases! Keeping dmaengine idle is not really
> good design.

The dra7 case is a special one: we have one errata (i878) for which the
workaround is to use something else than MCU to access DMM registers,
otherwise bus/system lockup can happen. The only feasible non MCU access
is to use DMA memcpy to read/write registers.

I've also encountered user who want to swap CPU memcpy with DMA based
one as it tends to lower the CPU load and it is faster.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
