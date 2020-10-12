Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D76E28B455
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 14:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbgJLMEw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 08:04:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45466 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388209AbgJLMEt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Oct 2020 08:04:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CC4liq100601;
        Mon, 12 Oct 2020 07:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602504287;
        bh=SblS3eNJU3ed7uUT1OdEfRWLSXZf81u3pH3jCxFggXc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dR/DEABbPKrPo3d3Xn8A1K+1Hd75Br80o1FmIzBhSlg/Mz4sgmKynZa5plyc4vyQy
         Y3QTg1St9Zzgvj/zI/wuCM2gPgIICLbo9wFzbi9hhqV3tCyBLg7qgdCDUfWeYrbAZe
         vSmqP34DX48M5oG9uuI1whLQm0NkDBqQLBaFh4OI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CC4lmX067886
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 07:04:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 07:04:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 07:04:47 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CC4igL126083;
        Mon, 12 Oct 2020 07:04:45 -0500
Subject: Re: [PATCH v4 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-3-vkoul@kernel.org>
 <e2c0323b-4f41-1926-5930-c63624fe1dd1@ti.com>
 <20201009103019.GD2968@vkoul-mobl>
 <a44af464-7d13-1254-54dd-f7783ccfaa0f@ti.com>
 <20201009111515.GF2968@vkoul-mobl>
 <13fdee71-5060-83fc-d69d-8ec73f82fac4@ti.com>
 <20201012060916.GI2968@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6ddaa8c1-0703-4910-f5a8-2e30bddd2642@ti.com>
Date:   Mon, 12 Oct 2020 15:05:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201012060916.GI2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/10/2020 9.09, Vinod Koul wrote:
> On 09-10-20, 14:29, Peter Ujfalusi wrote:
>>
>>
>> On 09/10/2020 14.15, Vinod Koul wrote:
>>>>> If for any any reason subsequent txn is for different direction, I would
>>>>> expect that parameters are set again before prep_ calls
>>>>
>>>> But in DEV_TO_DEV?
>>>
>>> Do we support that :D
>>>
>>>> If we have two peripherals, both needs config:
>>>> p1_config and p2_config
>>>>
>>>> What and how would one use the single peripheral_config?
>>>
>>> Since the config is implementation specific, I do not think it limits.
>>> You may create
>>>
>>> struct peter_config {
>>>         struct p1_config;
>>>         struct p2_config;
>>> };
>>
>> The use case is:
>> MEM -DMA-> P1 -DMA-> P2
>> or
>> P2 -DMA-> P1 -DMA-> MEM
>> or
>> MEM -DMA-> P2
>> or
>> P2 -DMA-> MEM
>> or
>> MEM -DMA-> P1 -DMA-> MEM
>>
>> How would the DMA guess what it should do? How would the independent P1
>> and P2 would know how to set up the config?
> 
> As I said, we do not support DEV_TO_DEV yet :)
> 
> Question is how would p1<-->p2 look, will p1 initiate a DMA txn or p2..?
> who will configure these..

That's a good question, I have not really thought about that.
If we have MEM in the picture, then it is a bit cleaner, but I would guess.

> Do you have a real world example in horizon...

In j721e we have AASRC module which needs special PDMA configuration to
match with it's setup, AASRC can be chained with McASP, which in turn
have different type of PDMA.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
