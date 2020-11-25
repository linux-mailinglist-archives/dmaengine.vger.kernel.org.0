Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4AD2C391F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Nov 2020 07:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKYGgG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Nov 2020 01:36:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43408 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYGgG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Nov 2020 01:36:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AP6ZsIJ046843;
        Wed, 25 Nov 2020 00:35:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606286154;
        bh=RHvlvHq5pgevhCwKiVpCBU8BhDi25jMSJCNJ6nVT8wY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k2qKisQ3Qf6SGOveCnLeKbw68PoX1K4xzrAoyPuGFNd23KpurSEbDB6GCgHzRqci6
         M02/I1K/bX2/zb0MqZYc+61QOnlzdoDdGgtIUqkz01E7Cjn78FojX59sioL0UIFjYK
         KQUAEt9yQ77lA21A7AGXYTbiufL3DCGpU4WTPMHk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AP6ZrGR112251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Nov 2020 00:35:53 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 25
 Nov 2020 00:35:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 25 Nov 2020 00:35:53 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AP6ZqbI001906;
        Wed, 25 Nov 2020 00:35:52 -0600
Subject: Re: [PATCH] dmaengine: ti: edma: Fix reference count leaks due to
 pm_runtime_get_sync
To:     Vinod Koul <vkoul@kernel.org>,
        Wang Xiaojun <wangxiaojun11@huawei.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>
References: <20201123135928.2702845-1-wangxiaojun11@huawei.com>
 <20201124172421.GV8403@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a8ccf849-35f3-87c2-96bc-c3e3b6e76a11@ti.com>
Date:   Wed, 25 Nov 2020 08:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124172421.GV8403@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 24/11/2020 19.24, Vinod Koul wrote:
> On 23-11-20, 21:59, Wang Xiaojun wrote:
>> On calling pm_runtime_get_sync() the reference count of the device
>> is incremented. In case of failure, should decrement the reference
>> count before returning the error. So we fixed it by replacing it
>> with pm_runtime_resume_and_get.
> 
> Peter?

Looks good.

fwiw, the pm_runtime_resume_and_get() landed in mainline with v5.10-rc5,
so it is fresh, but what it does is legit.

Wang: thank you for the patch.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
>>
>> Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
>> ---
>>  drivers/dma/ti/edma.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
>> index 35d81bd857f1..38af8b596e1c 100644
>> --- a/drivers/dma/ti/edma.c
>> +++ b/drivers/dma/ti/edma.c
>> @@ -2399,7 +2399,7 @@ static int edma_probe(struct platform_device *pdev)
>>  	platform_set_drvdata(pdev, ecc);
>>  
>>  	pm_runtime_enable(dev);
>> -	ret = pm_runtime_get_sync(dev);
>> +	ret = pm_runtime_resume_and_get(dev);
>>  	if (ret < 0) {
>>  		dev_err(dev, "pm_runtime_get_sync() failed\n");
>>  		pm_runtime_disable(dev);
>> -- 
>> 2.25.1
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
