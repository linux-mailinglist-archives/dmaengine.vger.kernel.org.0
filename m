Return-Path: <dmaengine+bounces-549-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7538165A8
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 05:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5A0B20D4D
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 04:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594EB566A;
	Mon, 18 Dec 2023 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lNRMfDNB"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE2566E;
	Mon, 18 Dec 2023 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BI4Ucc9088169;
	Sun, 17 Dec 2023 22:30:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702873838;
	bh=vGmCg4Mp8B+JjXs/7nAxIenV+8KYuMwdscLZTOUU4gs=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=lNRMfDNByrxwoxRb3CWyO6bjHIZYNn60+dZtK68+icSEJ/DZWpS3chrzfHwZgSC/C
	 ylKZ2idRb5ySskAJPOA+nYDQrAfwFia6hMUXezBbS2HLJSiPZrkCLi31qMEm/qYtMl
	 LXSEM0co/SOu5lA2FLAoKR9k8O7C3e/ec87NVj8w=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BI4UcSo007405
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 17 Dec 2023 22:30:38 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 17
 Dec 2023 22:30:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 17 Dec 2023 22:30:37 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BI4UYJ9057180;
	Sun, 17 Dec 2023 22:30:35 -0600
Message-ID: <cb93763e-28d3-402a-a5fa-34936646bc0a@ti.com>
Date: Mon, 18 Dec 2023 10:00:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 3/4] dmaengine: ti: k3-udma-glue: Add function to
 request TX channel by ID
Content-Language: en-US
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
References: <20231212111011.1401641-1-s-vadapalli@ti.com>
 <20231212111011.1401641-4-s-vadapalli@ti.com>
 <800ccf2e-65cc-4524-8a42-1657a5906482@gmail.com>
 <4f13681a-dc13-4de2-a0d5-9f85a4c350d4@ti.com>
 <604657b5-0b88-4108-afd3-8cc88e10b16c@gmail.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <604657b5-0b88-4108-afd3-8cc88e10b16c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 17/12/23 16:48, Péter Ujfalusi wrote:
> 
> 
> On 15/12/2023 08:08, Siddharth Vadapalli wrote:
>>>>  err:
>>>> @@ -395,6 +410,40 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn);
>>>>  
>>>> +struct k3_udma_glue_tx_channel *
>>>> +k3_udma_glue_request_tx_chn_by_id(struct device *dev, struct k3_udma_glue_tx_channel_cfg *cfg,
>>>> +				  struct device_node *udmax_np, u32 thread_id)
>>>
>>> udmax_np is not dev->of_node ?
>>
>> I am not sure I fully understand the question. If you meant to ask if the driver
>> which uses this API will not have its device's of_node set to udmax_np, then yes
>> that's correct.
>>
>> The driver shall be probed over RPMsg-bus, due to which its device's of_node
>> will not be udmax_np. Additionally, the udmax_np is the device-tree node of one
>> of the DMA Controllers described in the device-tree. The driver shall obtain the
>> reference to the udmax_np node using the API:
>> of_find_compatible_node()
>> with the compatible to be passed to the above API being a part of the driver's
>> data. Thus, it is possible to specify which DMA Controller to use by specifying
>> the compatible in the driver's data. I hope that I have answered your question.
>> Please let me know otherwise.
> 
> I see, thank you for the detailed explanation!
> 
>> Thank you for reviewing the series. I will rename the API as mentioned above and
>> if the question you had above regarding the of_node has been addressed, I will
>> post the v3 series. Kindly let me know.
> 
> I don't have other open issues, thanks for the updates
> 

Thank you for the confirmation. I will implement your suggestions and post the
v3 series.

-- 
Regards,
Siddharth.

