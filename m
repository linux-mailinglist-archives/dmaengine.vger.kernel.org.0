Return-Path: <dmaengine+bounces-3798-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628D9D97DC
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 14:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B72628266D
	for <lists+dmaengine@lfdr.de>; Tue, 26 Nov 2024 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27481CD219;
	Tue, 26 Nov 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e17Ru0lW"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot05.ext.ti.com (lelvem-ot05.ext.ti.com [198.47.23.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72517489;
	Tue, 26 Nov 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626038; cv=none; b=jPNbfCtIJYpcbz1BIsodjxNBZqB1/0BrhSl+b/20O6Dabpbo3RzQ24MMvBCg+Mw3XSM5g2uofyVIAbbFIWFx5W8nBmpZIXrA9bC0cEDQqGO93Ycj1D6Dl7Mphg7o93kJbfU79qrBhs2of7iDkY25Lz0wEhnaHPk9qzZhbLzS9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626038; c=relaxed/simple;
	bh=rb4RKEfu0UEtBVz6z1dX9J6uuYRBunQZLoY/ueS2YSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P+3xTOLXST2DjilIgoO/FMmFCb3jglGxnk/7CjlBe8DyoELVZp37pqpYGTsDsDSMQJnfx6OCcTRVWiFjrRpfgJJCZkHLUezSfJKf9xL5cbNZhw/tB3N0kZ+SO7BzXNST0I9Ln7JQ8322rH3f8g7im09wM/cpX/HEyFS+oeXbSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e17Ru0lW; arc=none smtp.client-ip=198.47.23.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot05.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQCwYKb675617
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 Nov 2024 06:58:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732625914;
	bh=J0JZ8DiQ4nkkyJ4v4OOJuFMwA5FpDWZfEAp+egaaJ/U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=e17Ru0lW+ltXO0ID357PPUFJetmCJqUhSb40sfMFUG6PK4pAlkQ2w6zaxAP7bsWm6
	 +6/bTppQj4KWTgKH+HpzpW+/oQdk6FNSKIybzgrhrWdG4SwiR1ffl5BzUjTL0BJOwt
	 kh44V6Bbgm+cN/C4wfyXk9dPAKMFOlrPfaA27o/8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQCwY0a026953;
	Tue, 26 Nov 2024 06:58:34 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 06:58:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 06:58:34 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQCwUaP106029;
	Tue, 26 Nov 2024 06:58:30 -0600
Message-ID: <8fe8eb6c-2ec7-4f07-9043-99a8d87e2613@ti.com>
Date: Tue, 26 Nov 2024 18:28:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: ti: k3-udma: Add TX channel data in AM62A
 CSIRX DMSS
To: Conor Dooley <conor@kernel.org>
CC: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>, <vigneshr@ti.com>
References: <20241125083914.2934815-1-vaishnav.a@ti.com>
 <20241125083914.2934815-2-vaishnav.a@ti.com>
 <20241125-hardener-jockey-d8d57f6a9430@spud>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20241125-hardener-jockey-d8d57f6a9430@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Conor,

On 26/11/24 00:01, Conor Dooley wrote:
> On Mon, Nov 25, 2024 at 02:09:14PM +0530, Vaishnav Achath wrote:
>> J722S/AM67 uses the same BCDMA CSIRX IP as AM62A, but it supports
>> TX channels as well in addition to RX.
> 
> This doesn't make sense. You say that the am62a doesn't have a tx
> channel ("but it supports TX as well") but then modify the struct for
> the am62a to add a tx channel. Does that not break things on the am62a?
> 

Thank you for the review, I have sent a v2 of this series adding new 
compatible as suggested, after looking at it again, the J722S BCDMA CSI
is more similar to J721S2 in terms of having RX and TX support, so 
updated in that way.

The below changes did not really break AM62A since the driver checks 
hardware capability registers (TCHAN_CNT) to detect presence of TX 
channels and then only use the Output Event Steering(OES) data below.

V2:

https://lore.kernel.org/all/20241126125158.37744-1-vaishnav.a@ti.com/

Thanks and Regards,
Vaishnav

> 
>> Add the BCDMA TCHAN information
>> in the am62a_dmss_csi_soc_data so as to support all the platforms in the
>> family with same compatible. UDMA_CAP2_TCHAN_CNT indicates the presence
>> of TX channels and it will be 0 for platforms without TX support.
>>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>
>> CSI2RX capture test results on J722S EVM with IMX219:
>> https://gist.github.com/vaishnavachath/e2eaed62ee8f53428ee9b830aaa02cc3
>>
>>   drivers/dma/ti/k3-udma.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index b3f27b3f9209..4130f50979d4 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -4340,6 +4340,8 @@ static struct udma_match_data j721e_mcu_data = {
>>   
>>   static struct udma_soc_data am62a_dmss_csi_soc_data = {
>>   	.oes = {
>> +		.bcdma_tchan_data = 0x800,
>> +		.bcdma_tchan_ring = 0xa00,
>>   		.bcdma_rchan_data = 0xe00,
>>   		.bcdma_rchan_ring = 0x1000,
>>   	},
>> -- 
>> 2.34.1
>>

