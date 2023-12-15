Return-Path: <dmaengine+bounces-535-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4048141B9
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 07:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A2A1F22E45
	for <lists+dmaengine@lfdr.de>; Fri, 15 Dec 2023 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A09D2E5;
	Fri, 15 Dec 2023 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BsVtzUpS"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DBD27A;
	Fri, 15 Dec 2023 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BF68Brr075312;
	Fri, 15 Dec 2023 00:08:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702620491;
	bh=BeKZu3v+C341pkrfual1kxWg7C5cxKjvd4oyNcT7yl0=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=BsVtzUpSPVVVcrfElj1hDWhiNESb14RlrsoY2BB0tre/fKAPmkh/dQvB927MNSsDR
	 1w12mLuhHgyI44V+ZCbjplKJOb5lmbM+Qofo8UfXVEIyaKOEiW/C3WloGn8Alv0buq
	 etaUO5+TVINPpsNEA3Os0iDJ2hgWcAQjXnNC1BTU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BF68B6q029112
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Dec 2023 00:08:11 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Dec 2023 00:08:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Dec 2023 00:08:10 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BF687Rs101417;
	Fri, 15 Dec 2023 00:08:08 -0600
Message-ID: <4f13681a-dc13-4de2-a0d5-9f85a4c350d4@ti.com>
Date: Fri, 15 Dec 2023 11:38:07 +0530
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
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <800ccf2e-65cc-4524-8a42-1657a5906482@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Péter,

On 14/12/23 21:11, Péter Ujfalusi wrote:
> 
> 
> On 12/12/2023 13:10, Siddharth Vadapalli wrote:
>> The existing function k3_udma_glue_request_tx_chn() supports requesting
>> a TX DMA channel by its name. Add support to request TX channel by ID in
>> the form of a new function k3_udma_glue_request_tx_chn_by_id() and export
>> it for use by drivers which are probed by alternate methods (non
>> device-tree) but still wish to make use of the existing DMA APIs. Such
>> drivers could be informed about the TX channel to use by RPMsg for example.
>>
>> Since the implementation of k3_udma_glue_request_tx_chn_by_id() reuses
>> most of the code in k3_udma_glue_request_tx_chn(), create a new function
>> for the common code named as k3_udma_glue_request_tx_chn_common().
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>> Changes since v1:
>> - Updated commit message indicating the use-case for which the patch is
>>   being added.
>>
>>  drivers/dma/ti/k3-udma-glue.c    | 101 +++++++++++++++++++++++--------
>>  include/linux/dma/k3-udma-glue.h |   4 ++
>>  2 files changed, 79 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
>> index eff1ae3d3efe..ea5119a5e8eb 100644
>> --- a/drivers/dma/ti/k3-udma-glue.c
>> +++ b/drivers/dma/ti/k3-udma-glue.c
>> @@ -274,29 +274,13 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
>>  	return tisci_rm->tisci_udmap_ops->tx_ch_cfg(tisci_rm->tisci, &req);
>>  }
>>  

...

>>  
>>  err:
>> @@ -395,6 +410,40 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn);
>>  
>> +struct k3_udma_glue_tx_channel *
>> +k3_udma_glue_request_tx_chn_by_id(struct device *dev, struct k3_udma_glue_tx_channel_cfg *cfg,
>> +				  struct device_node *udmax_np, u32 thread_id)
> 
> udmax_np is not dev->of_node ?

I am not sure I fully understand the question. If you meant to ask if the driver
which uses this API will not have its device's of_node set to udmax_np, then yes
that's correct.

The driver shall be probed over RPMsg-bus, due to which its device's of_node
will not be udmax_np. Additionally, the udmax_np is the device-tree node of one
of the DMA Controllers described in the device-tree. The driver shall obtain the
reference to the udmax_np node using the API:
of_find_compatible_node()
with the compatible to be passed to the above API being a part of the driver's
data. Thus, it is possible to specify which DMA Controller to use by specifying
the compatible in the driver's data. I hope that I have answered your question.
Please let me know otherwise.

> 
>> +{
>> +	struct k3_udma_glue_tx_channel *tx_chn;
>> +	int ret;
>> +
>> +	tx_chn = devm_kzalloc(dev, sizeof(*tx_chn), GFP_KERNEL);
>> +	if (!tx_chn)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	tx_chn->common.dev = dev;
>> +	tx_chn->common.swdata_size = cfg->swdata_size;
>> +	tx_chn->tx_pause_on_err = cfg->tx_pause_on_err;
>> +	tx_chn->tx_filt_einfo = cfg->tx_filt_einfo;
>> +	tx_chn->tx_filt_pswords = cfg->tx_filt_pswords;
>> +	tx_chn->tx_supr_tdpkt = cfg->tx_supr_tdpkt;
>> +
>> +	ret = of_k3_udma_glue_parse_chn_by_id(udmax_np, &tx_chn->common, true, thread_id);
>> +	if (ret)
>> +		goto err;
>> +
>> +	ret = k3_udma_glue_request_tx_chn_common(dev, tx_chn, cfg);
>> +	if (ret)
>> +		goto err;
>> +
>> +	return tx_chn;
>> +
>> +err:
>> +	k3_udma_glue_release_tx_chn(tx_chn);
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(k3_udma_glue_request_tx_chn_by_id);
>> +
>>  void k3_udma_glue_release_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
>>  {
>>  	if (tx_chn->psil_paired) {
>> diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
>> index e443be4d3b4b..6205d84430ca 100644
>> --- a/include/linux/dma/k3-udma-glue.h
>> +++ b/include/linux/dma/k3-udma-glue.h
>> @@ -26,6 +26,10 @@ struct k3_udma_glue_tx_channel;
>>  struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>>  		const char *name, struct k3_udma_glue_tx_channel_cfg *cfg);
>>  
>> +struct k3_udma_glue_tx_channel *
>> +k3_udma_glue_request_tx_chn_by_id(struct device *dev, struct k3_udma_glue_tx_channel_cfg *cfg,
> 
> I know it is going to be longer, but can the function be named more
> precisely?
> k3_udma_glue_request_tx_chn_by_thread_id
> 
> For TX/RX: a channel is always for one thread, right?
> Probably:
> k3_udma_glue_request_tx_chn_for_thread_id()
> 
> ?

Sure, I will rename it to:
k3_udma_glue_request_tx_chn_for_thread_id()
as suggested by you.

> 
> Other then this the series looks OK.

Thank you for reviewing the series. I will rename the API as mentioned above and
if the question you had above regarding the of_node has been addressed, I will
post the v3 series. Kindly let me know.

-- 
Regards,
Siddharth.

