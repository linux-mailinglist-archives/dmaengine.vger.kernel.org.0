Return-Path: <dmaengine+bounces-3925-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEAA9E8A4C
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 05:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE96A1884C6B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2024 04:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B4115B122;
	Mon,  9 Dec 2024 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bMXbkevV"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D534158534;
	Mon,  9 Dec 2024 04:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718591; cv=none; b=IrUOjQJiOxgWhAaRfMA4JKiRbb6wtcZmpojtOaPhvE8gBRTzCRUhjrBQEkq8VOkLP3lnrQFAn11R3RHerRy4GSWUQBoONsUwlFikVOfO9ZE+0jE8aO9EDaFc0KuERa6YYQ/a1JKxQ8QZfykRW2u+rkmwDHhzOb5Ri9K1iYpFzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718591; c=relaxed/simple;
	bh=8wOwAXU2F/nyxGG2by6ki7uPGENf2of8aDoylsljgVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZM8GdkjBWJrgC9plZxgnHKy5+hoXksFdL5Qwqy6Dv5RjffPyozPCVPzhi4B2s5JE48vk3yryvtaiDQ71/E3JZjfSnZRWLogpawxGeBTyo0R3OxVpbZs8EPoLI4/f5NPwfIAdrLGjN1forqzhxiVRY15gxxgPoXSvJn0VDxwRqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bMXbkevV; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B94TWdf2251515
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 8 Dec 2024 22:29:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733718572;
	bh=BJNrJJLNwAXr6x0VrIFFCHP4wB2iiBaTAcH1RnvbheA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bMXbkevVKAw4sy5L0Gk1I+xdPikVvkgtK6trzuQuG3e1jjl//1gJ6i2EtOfcxbWrU
	 SSg1n09Cc2CK4W6gDOzRoYIgm3Ljfa4O7mrVnYun056NSXm1//PcpanTwToSjcTpHo
	 LVfEvhrJJYyffLYLARoA7eHABNh98kGWkXh+HOFc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B94TWHe117987
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 8 Dec 2024 22:29:32 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 8
 Dec 2024 22:29:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 8 Dec 2024 22:29:31 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B94TSR2007661;
	Sun, 8 Dec 2024 22:29:28 -0600
Message-ID: <a6a4805c-3983-4514-84cf-a1f0a4356b74@ti.com>
Date: Mon, 9 Dec 2024 09:59:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dmaengine: ti: k3-udma: Add support for J722S CSI
 BCDMA
To: Vinod Koul <vkoul@kernel.org>
CC: <peter.ujfalusi@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vigneshr@ti.com>
References: <20241127101627.617537-1-vaishnav.a@ti.com>
 <20241127101627.617537-3-vaishnav.a@ti.com> <Z1BLWYY8/eVXZxVu@vaman>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <Z1BLWYY8/eVXZxVu@vaman>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vinod,

On 04/12/24 18:00, Vinod Koul wrote:
> On 27-11-24, 15:46, Vaishnav Achath wrote:
>> J722S CSI BCDMA is similar to J721S2 CSI BCDMA but there are slight
>> integration differences like different PSIL thread base ID which is
>> currently handled in the driver based on udma_of_match data. Add an
>> entry to support J722S CSIRX.
>>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> ---
>>
>> V2->V3 : Minor edit in commit message.
>>
>> V1->V2:
>> 	* Add new compatible for J722S instead of modifying AM62A
>>
>>   drivers/dma/ti/k3-udma.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index b3f27b3f9209..7ed1956b4642 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -4404,6 +4404,18 @@ static struct udma_match_data j721s2_bcdma_csi_data = {
>>   	.soc_data = &j721s2_bcdma_csi_soc_data,
>>   };
>>   
>> +static struct udma_match_data j722s_bcdma_csi_data = {
>> +	.type = DMA_TYPE_BCDMA,
>> +	.psil_base = 0x3100,
>> +	.enable_memcpy_support = false,
>> +	.burst_size = {
>> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
>> +		0, /* No H Channels */
>> +		0, /* No UH Channels */
> 
> Why are these zeros? we expect valid size...
> 

Sorry for the delay in response, this instance does not have High 
capacity/Ultra high capacity channels, the burst_size for normal 
channels is non-zero in the above, this is done similar to other 
instances supported in the driver:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/ti/k3-udma.c#n4363

Please let me know if something need to be fixed.

Thanks and Regards,
Vaishnav

>> +	},
>> +	.soc_data = &j721s2_bcdma_csi_soc_data,
>> +};
>> +
>>   static const struct of_device_id udma_of_match[] = {
>>   	{
>>   		.compatible = "ti,am654-navss-main-udmap",
>> @@ -4435,6 +4447,10 @@ static const struct of_device_id udma_of_match[] = {
>>   		.compatible = "ti,j721s2-dmss-bcdma-csi",
>>   		.data = &j721s2_bcdma_csi_data,
>>   	},
>> +	{
>> +		.compatible = "ti,j722s-dmss-bcdma-csi",
>> +		.data = &j722s_bcdma_csi_data,
>> +	},
>>   	{ /* Sentinel */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, udma_of_match);
>> -- 
>> 2.34.1
> 

