Return-Path: <dmaengine+bounces-3867-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDC99E1272
	for <lists+dmaengine@lfdr.de>; Tue,  3 Dec 2024 05:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F62F164134
	for <lists+dmaengine@lfdr.de>; Tue,  3 Dec 2024 04:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090BF2AF0B;
	Tue,  3 Dec 2024 04:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8vtJOIH"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410A1F95A;
	Tue,  3 Dec 2024 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200516; cv=none; b=Vr7MiwLT5bNEDmB21h9Pua31V/pW0UyoYF7r8cV8QNqov8BV65U21GzBWSiK4eBdDX4u5yyOyN4lGA+PqXXKss/RboWTSqZB+KrLbZx9/7sT272Dx8D/v/acA4mDv/3sVIInXEcRO6CX3RLjozDvMtGegigpnewZLU60uzQK0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200516; c=relaxed/simple;
	bh=mbsW/ARIuD2vy8RZbk+udmThgWvGm8bknX/AfBua4Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PURHltrLXTia7LJipdHiEIKBmQivgS29O06ZANlAmQR1rTJbdtfp/h2uYdmzvduizPOvz2WflCK2gx595NGdq10OOKLaZJJmIlprAVlhJsoopc91oQTHho5X9Re1qL9jQ62jCJXMyWEOJsZS755jQrRYOgKWnVVCFXJUKkFten0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S8vtJOIH; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B34Z1we1580937
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 22:35:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733200501;
	bh=XZiLn0fNXNUQNsxbGJtC50AjyGfClD9qv9AZMF0zfcU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=S8vtJOIHnehJpTz1k+Eg39H1Gtv3IkGRhaO81a+sWpxXmuxVeKMdNZwj2qNuP7wWA
	 wNbp3jUJccZoqpmk/9C0QUuMazIJd2SyG7+NgVXE/zrTUf+kC1AevcH9aF7/C7RKjn
	 /SqF5nBfaeZjepc2E6k6jKxyN/9DhdrpGvz3oX5g=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B34Z1el019282
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 22:35:01 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Dec 2024 22:35:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Dec 2024 22:35:01 -0600
Received: from [10.24.72.152] (uda0132425.dhcp.ti.com [10.24.72.152])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B34YwkB055318;
	Mon, 2 Dec 2024 22:34:59 -0600
Message-ID: <ffccf100-469f-4e5b-a32c-5c06e196aacd@ti.com>
Date: Tue, 3 Dec 2024 10:04:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: dma_request_chan_by_mask() defer probing
 unconditionally
To: Robin Murphy <robin.murphy@arm.com>,
        Enric Balletbo i Serra
	<eballetb@redhat.com>,
        Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>, <nm@ti.com>
References: <20241127-defer-dma-request-chan-v1-1-203db7baf470@redhat.com>
 <4dd1caa7-4b95-4e06-a5ac-e2d33ce88d04@arm.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <4dd1caa7-4b95-4e06-a5ac-e2d33ce88d04@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Enric,

On 29/11/24 22:14, Robin Murphy wrote:
> On 2024-11-27 8:23 am, Enric Balletbo i Serra wrote:
>> Having no DMA devices registered is not a guarantee that the device
>> doesn't exist, it could be that is not registered yet, so return
>> EPROBE_DEFER unconditionally so the caller can wait for the required
>> DMA device registered.
>>
>> Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
>> ---
>> This patch fixes the following error on TI AM69-SK
>>
>> [    2.854501] cadence-qspi 47040000.spi: error -ENODEV: No Rx DMA
>> available
>>
>> The DMA device is probed after cadence-qspi driver, so deferring it
>> solves the problem.
> 
> Conversely, though, it does carry some risk that if there really is no
> DMA device/driver, other callers (e.g. spi-ti-qspi) may now get stuck
> deferring forever where the -ENODEV would have let them proceed with a
> fallback to non-DMA operation. driver_deferred_probe_check_state() is
> typically a good tool for these situations, but I guess it's a bit
> tricky in a context where we don't actually have the dependent device to
> hand :/


+1. There is no explicit dependency that can be modeled (via DT or
otherwise) for memcpy DMA channels. And the IP (cadence-qspi) is not
specific to TI platforms. Its very much possible that a non TI platform
may not have memcpy DMA channel at all. Wont this end up breaking such
platforms wrt using SPI flash using CPU bound IO?

> 
> Thanks,
> Robin.
> 
>> ---
>>   drivers/dma/dmaengine.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index
>> c1357d7f3dc6ca7899c4d68a039567e73b0f089d..57f07b477a5d9ad8f2656584b8c0d6dffb2ab469 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -889,10 +889,10 @@ struct dma_chan *dma_request_chan_by_mask(const
>> dma_cap_mask_t *mask)
>>       chan = __dma_request_channel(mask, NULL, NULL, NULL);
>>       if (!chan) {
>>           mutex_lock(&dma_list_mutex);
>> -        if (list_empty(&dma_device_list))
>> -            chan = ERR_PTR(-EPROBE_DEFER);
>> -        else
>> -            chan = ERR_PTR(-ENODEV);
>> +        /* If the required DMA device is not registered yet,
>> +         * return EPROBE_DEFER
>> +         */
>> +        chan = ERR_PTR(-EPROBE_DEFER);
>>           mutex_unlock(&dma_list_mutex);
>>       }
>>  
>> ---
>> base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
>> change-id: 20241127-defer-dma-request-chan-4f26c62c8691
>>
>> Best regards,
> 

-- 
Regards
Vignesh
https://ti.com/opensource


