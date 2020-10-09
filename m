Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B62887D5
	for <lists+dmaengine@lfdr.de>; Fri,  9 Oct 2020 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbgJIL31 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Oct 2020 07:29:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40530 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbgJIL31 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Oct 2020 07:29:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099BTOPp107366;
        Fri, 9 Oct 2020 06:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602242964;
        bh=q6u9Pd3dT1hwzuDIvPAhbx3jYlVHO6hTBvtJP9LAh4E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IqO3f7KJjHZZpGUOUhcSkg1ajwbN3DPHG9nYdSwXRNCkKO/LVhzLgezLfd62XY9N7
         QzihVZvNUjdraouZyZhxwW1ghL82zRe4BP5Wqp0wPaM5EWWBPtkabSyjWlpCX26Vt3
         7nBpGY1al6DQFR+WspS/dAobE3BdOLU0hj0Auh7k=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099BTOFR043345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 06:29:24 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 06:29:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 06:29:24 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099BTMsC021715;
        Fri, 9 Oct 2020 06:29:22 -0500
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <13fdee71-5060-83fc-d69d-8ec73f82fac4@ti.com>
Date:   Fri, 9 Oct 2020 14:29:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009111515.GF2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 09/10/2020 14.15, Vinod Koul wrote:
>>> If for any any reason subsequent txn is for different direction, I would
>>> expect that parameters are set again before prep_ calls
>>
>> But in DEV_TO_DEV?
> 
> Do we support that :D
> 
>> If we have two peripherals, both needs config:
>> p1_config and p2_config
>>
>> What and how would one use the single peripheral_config?
> 
> Since the config is implementation specific, I do not think it limits.
> You may create
> 
> struct peter_config {
>         struct p1_config;
>         struct p2_config;
> };

The use case is:
MEM -DMA-> P1 -DMA-> P2
or
P2 -DMA-> P1 -DMA-> MEM
or
MEM -DMA-> P2
or
P2 -DMA-> MEM
or
MEM -DMA-> P1 -DMA-> MEM

How would the DMA guess what it should do? How would the independent P1
and P2 would know how to set up the config?

>>
>> If only one of them needs config, then sure, the driver can pin-point
>> which one the single config might apply to.
>>
>> Or you chain the same type of peripheral and you would need different
>> config for tx and rx?
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
