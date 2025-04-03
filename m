Return-Path: <dmaengine+bounces-4812-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D483A79D0E
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A46E3AFC8B
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ACF1F130F;
	Thu,  3 Apr 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VGVD78GE"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D018E050;
	Thu,  3 Apr 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665733; cv=none; b=mv4RGZZdGPF3WzEMz7H/tqE+7Dcj6JX7wTwAzC0ausU31FBqMceBM1dURdsV3Ay9Gfy/O4slzK5tnCdu4b5lCFbTWbixOblKN3A2kM7rUM43LVJ53geVpxcmvTt19zYilSGyqbHNrE6nmnM1spdqiwPVUQS2851CGvQhilP0xp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665733; c=relaxed/simple;
	bh=ybOZWos/CKtiQmILQhqcpjTtsYhSJRQGznwv17cQ31c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IJBdjleBedEPI4CqoUxOdkyBFqKrOiiXvcIu+LXWkMIUvszeC+y7zwg6i2UxFrXVH8lLTKXXNfSiAYHJWNHz6yTKKwdQFN3I2F74zyK5quCRBCL0848fXa9p8kLJmniw/JoBHE9oY+uLZF6ZyWbEIXL+kitQ1DRKLbmNxotKL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VGVD78GE; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5337ZQWF3633633
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Apr 2025 02:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743665726;
	bh=c163/YlshR8HZvV9HdI76auDna84Br+di/qDlvMFRBY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VGVD78GEi9cRv7nUiAGNeLRRpv5dhLggGaQaY8dU0uSCto72EUuUq0gEST/p0lrE8
	 jMjB71gEjHh/K4zhQULUBo3UqtRD6URBr4U5/Ou6OQY8laD9w1jjUyfFoWeac7lytL
	 6eVbHN/dEEqk+GqOI1LJQGtEktSqMlmG/AMhgrGk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5337ZQDS072383
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Apr 2025 02:35:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 02:35:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 02:35:26 -0500
Received: from [172.24.227.115] (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5337ZNuj005499;
	Thu, 3 Apr 2025 02:35:24 -0500
Message-ID: <77329c0d-2839-4af3-aa71-f65cc96864b7@ti.com>
Date: Thu, 3 Apr 2025 13:05:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Use cap_mask directly from
 dma_device structure instead of a local copy
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC: <vaishnav.a@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Kumar, Udit" <u-kumar1@ti.com>
References: <20250203074915.3634508-1-y-abhilashchandra@ti.com>
 <f9396cec-bc07-4304-a57c-76311d95f62c@ti.com>
Content-Language: en-US
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
In-Reply-To: <f9396cec-bc07-4304-a57c-76311d95f62c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vinod,

On 03/02/25 19:02, Kumar, Udit wrote:
> 
> On 2/3/2025 1:19 PM, Yemike Abhilash Chandra wrote:
>> Currently, a local dma_cap_mask_t variable is used to store device
>> cap_mask within udma_of_xlate(). However, the DMA_PRIVATE flag in
>> the device cap_mask can get cleared when the last channel is released.
>> This can happen right after storing the cap_mask locally in
>> udma_of_xlate(), and subsequent dma_request_channel() can fail due to
>> mismatch in the cap_mask. Fix this by removing the local dma_cap_mask_t
>> variable and directly using the one from the dma_device structure.
>>
>> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
>> Cc: stable@vger.kernel.org
> 
> I don't see  patch is sent to stable in cc , please check if you 
> suppressed cc list.
> 
> For rest
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 

May I kindly ask if this patch is in line to be merged for the 6.15 window?
I just wanted to check if you are waiting for anything.

Please let me know if you prefer me to resend the patch.
I can do that as well.

Thanks and Regards
Yemike Abhilash Chandra


>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>> ---
>> RFC: 
>> https://lore.kernel.org/all/20250117121728.203452-1-y-abhilashchandra@ti.com/
>>
>>   drivers/dma/ti/k3-udma.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 7ed1956b4642..c775a2284e86 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -4246,7 +4246,6 @@ static struct dma_chan *udma_of_xlate(struct 
>> of_phandle_args *dma_spec,
>>                         struct of_dma *ofdma)
>>   {
>>       struct udma_dev *ud = ofdma->of_dma_data;
>> -    dma_cap_mask_t mask = ud->ddev.cap_mask;
>>       struct udma_filter_param filter_param;
>>       struct dma_chan *chan;
>> @@ -4278,7 +4277,7 @@ static struct dma_chan *udma_of_xlate(struct 
>> of_phandle_args *dma_spec,
>>           }
>>       }
>> -    chan = __dma_request_channel(&mask, udma_dma_filter_fn, 
>> &filter_param,
>> +    chan = __dma_request_channel(&ud->ddev.cap_mask, 
>> udma_dma_filter_fn, &filter_param,
>>                        ofdma->of_node);
>>       if (!chan) {
>>           dev_err(ud->dev, "get channel fail in %s.\n", __func__);

