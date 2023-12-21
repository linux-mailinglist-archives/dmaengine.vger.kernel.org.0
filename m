Return-Path: <dmaengine+bounces-626-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CB981BCB3
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 18:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210351F2535C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41559925;
	Thu, 21 Dec 2023 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Fq+Hnp7d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B15990A;
	Thu, 21 Dec 2023 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BLGr2tN023358;
	Thu, 21 Dec 2023 18:11:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=dxmkweGMh19Sc2/yX4ifon/v2Dk/DFKokt/84XbR2Vo=; b=Fq
	+Hnp7dUngZ5rsy/RLGFZ4LClwcMeEQR8kL2q2M+0gOv+WLeZbCGbPy5CKHDPFIOe
	oNjzQW9qHatXHs3LQrxBb3p5R1lAhQZ1slZhH9vF/P2Po2gA9c1vH2XMxSKva8VS
	Uxflg22Bov1nAOYarU24Aiwe54llbRSI1MkOWR/g/SVLkY+B00/Y9a8gry329PUI
	qfiuU1P2QlEaCYyqP7l8FMMOVhCB+qpq9sOQSZHLV4PVhEW+QBFV4eThrpR/Eg+b
	cEat7jY7Gwj0MFLnzJGEyFdi4spWqi72Vlt2ubPgmwWZtPJXafYbBRTSzdj68Lbr
	Q47yKhiu5UP/xD+LMg0w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v3q811wjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:11:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 64770100053;
	Thu, 21 Dec 2023 18:11:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2F006252E58;
	Thu, 21 Dec 2023 18:11:35 +0100 (CET)
Received: from [10.201.20.208] (10.201.20.208) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 18:11:34 +0100
Message-ID: <5e007fe4-d6cd-4ec3-b9c1-ef7841e29851@foss.st.com>
Date: Thu, 21 Dec 2023 18:11:33 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: add channel device name to channel
 registration
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231213174021.3074759-1-amelie.delaunay@foss.st.com>
 <ZYRkP-m_sra8qUNZ@matsya>
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <ZYRkP-m_sra8qUNZ@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_09,2023-12-21_02,2023-05-22_02

Hi Vinod,

On 12/21/23 17:13, Vinod Koul wrote:
> On 13-12-23, 18:40, Amelie Delaunay wrote:
>> Channel device name is used for sysfs, but also by dmatest filter function.
>>
>> With dynamic channel registration, channels can be registered after dma
>> controller registration. Users may want to have specific channel names.
>>
>> If name is NULL, the channel name relies on previous implementation,
>> dma<controller_device_id>chan<channel_device_id>.
> 
> lgtm, where is the user for this..?
> 

I'll send beginning of next year a DMA controller driver for STM32MP25 
SoC family. It relies on the dynamic channel registration. It will be a 
user of this dma_async_device_channel_register(struct dma_device 
*device, struct dma_chan *chan, const char *name).

Regards,
Amelie

>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
>> ---
>>   drivers/dma/dmaengine.c   | 16 ++++++++++------
>>   drivers/dma/idxd/dma.c    |  2 +-
>>   include/linux/dmaengine.h |  3 ++-
>>   3 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index b7388ae62d7f..7848428da2d6 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -1037,7 +1037,8 @@ static int get_dma_id(struct dma_device *device)
>>   }
>>   
>>   static int __dma_async_device_channel_register(struct dma_device *device,
>> -					       struct dma_chan *chan)
>> +					       struct dma_chan *chan,
>> +					       const char *name)
>>   {
>>   	int rc;
>>   
>> @@ -1066,8 +1067,10 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>>   	chan->dev->device.parent = device->dev;
>>   	chan->dev->chan = chan;
>>   	chan->dev->dev_id = device->dev_id;
>> -	dev_set_name(&chan->dev->device, "dma%dchan%d",
>> -		     device->dev_id, chan->chan_id);
>> +	if (!name)
>> +		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
>> +	else
>> +		dev_set_name(&chan->dev->device, name);
>>   	rc = device_register(&chan->dev->device);
>>   	if (rc)
>>   		goto err_out_ida;
>> @@ -1087,11 +1090,12 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>>   }
>>   
>>   int dma_async_device_channel_register(struct dma_device *device,
>> -				      struct dma_chan *chan)
>> +				      struct dma_chan *chan,
>> +				      const char *name)
>>   {
>>   	int rc;
>>   
>> -	rc = __dma_async_device_channel_register(device, chan);
>> +	rc = __dma_async_device_channel_register(device, chan, name);
>>   	if (rc < 0)
>>   		return rc;
>>   
>> @@ -1200,7 +1204,7 @@ int dma_async_device_register(struct dma_device *device)
>>   
>>   	/* represent channels in sysfs. Probably want devs too */
>>   	list_for_each_entry(chan, &device->channels, device_node) {
>> -		rc = __dma_async_device_channel_register(device, chan);
>> +		rc = __dma_async_device_channel_register(device, chan, NULL);
>>   		if (rc < 0)
>>   			goto err_out;
>>   	}
>> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
>> index 47a01893cfdb..101a265567a9 100644
>> --- a/drivers/dma/idxd/dma.c
>> +++ b/drivers/dma/idxd/dma.c
>> @@ -269,7 +269,7 @@ static int idxd_register_dma_channel(struct idxd_wq *wq)
>>   		desc->txd.tx_submit = idxd_dma_tx_submit;
>>   	}
>>   
>> -	rc = dma_async_device_channel_register(dma, chan);
>> +	rc = dma_async_device_channel_register(dma, chan, NULL);
>>   	if (rc < 0) {
>>   		kfree(idxd_chan);
>>   		return rc;
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 3df70d6131c8..cbad92cc3e0b 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -1574,7 +1574,8 @@ int dma_async_device_register(struct dma_device *device);
>>   int dmaenginem_async_device_register(struct dma_device *device);
>>   void dma_async_device_unregister(struct dma_device *device);
>>   int dma_async_device_channel_register(struct dma_device *device,
>> -				      struct dma_chan *chan);
>> +				      struct dma_chan *chan,
>> +				      const char *name);
>>   void dma_async_device_channel_unregister(struct dma_device *device,
>>   					 struct dma_chan *chan);
>>   void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>> -- 
>> 2.25.1
> 

