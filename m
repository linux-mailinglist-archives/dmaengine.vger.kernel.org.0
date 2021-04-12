Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753C035CA92
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhDLQAi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 12:00:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:57490 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238498AbhDLQAi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 12:00:38 -0400
IronPort-SDR: /mHsN5GZqO9Y/2uSHOUrEKt0uC8fO5W0tQjPNzp8GM5CECKA56NZrU9KXsjHl9Hq9e/flcde1D
 lyPzEsEN6pmw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="192093259"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="192093259"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 09:00:18 -0700
IronPort-SDR: 49bd1nD1Vz6ehzJJiMIh4sNFlvkoMAp+4hhxJG/7tA7SrSKSLfiuE5YVy+kJGeqjka901FGFo/
 5gWtrPmReJjQ==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="600039212"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.123.241]) ([10.212.123.241])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 09:00:14 -0700
Subject: Re: [PATCH v3 repost] dmaengine: idxd: fix wq cleanup of WQCFG
 registers
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Shreenivaas Devarajan <shreenivaas.devarajan@intel.com>,
        dmaengine@vger.kernel.org
References: <161785385072.113280.16444287329349568724.stgit@djiang5-desk3.ch.intel.com>
 <YHP47/rRfKaGmqVq@vkoul-mobl.Dlink>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <f3fc8e59-df6c-d0d8-b64f-43573bca7a20@intel.com>
Date:   Mon, 12 Apr 2021 09:00:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHP47/rRfKaGmqVq@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 4/12/2021 12:38 AM, Vinod Koul wrote:
> On 07-04-21, 20:51, Dave Jiang wrote:
>
>> +void idxd_wq_reset(struct idxd_wq *wq)
>> +{
>> +	struct idxd_device *idxd = wq->idxd;
>> +	struct device *dev = &idxd->pdev->dev;
>> +	u32 operand;
>> +
>> +	if (wq->state != IDXD_WQ_ENABLED) {
>> +		dev_dbg(dev, "WQ %d in wrong state: %d\n", wq->id, wq->state);
> should this not be dev_err?

This typically can happen if the WQ is already disabled. If we make it 
dev_err, it becomes noisy. Mostly it's harmless and should just be FYI 
for debug.


>
>> +		return;
>> +	}
>> +
>> +	dev_dbg(dev, "Resetting WQ %d\n", wq->id);
> Noisy..?

Will remove.


>> +	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
>> +	idxd_cmd_exec(idxd, IDXD_CMD_RESET_WQ, operand, NULL);
>> +	wq->state = IDXD_WQ_DISABLED;
>> +}
>> +
>>   int idxd_wq_map_portal(struct idxd_wq *wq)
>>   {
>>   	struct idxd_device *idxd = wq->idxd;
>> @@ -357,8 +374,6 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
>>   void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>>   {
>>   	struct idxd_device *idxd = wq->idxd;
>> -	struct device *dev = &idxd->pdev->dev;
>> -	int i, wq_offset;
>>   
>>   	lockdep_assert_held(&idxd->dev_lock);
>>   	memset(wq->wqcfg, 0, idxd->wqcfg_size);
>> @@ -370,14 +385,6 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>>   	wq->ats_dis = 0;
>>   	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
>>   	memset(wq->name, 0, WQ_NAME_SIZE);
>> -
>> -	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
>> -		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
>> -		iowrite32(0, idxd->reg_base + wq_offset);
>> -		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
>> -			wq->id, i, wq_offset,
>> -			ioread32(idxd->reg_base + wq_offset));
>> -	}
>>   }
>>   
>>   /* Device control bits */
>> @@ -636,7 +643,14 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
>>   	if (!wq->group)
>>   		return 0;
>>   
>> -	memset(wq->wqcfg, 0, idxd->wqcfg_size);
>> +	/*
>> +	 * Instead of memset the entire shadow copy of WQCFG, copy from the hardware after
>> +	 * wq reset. This will copy back the sticky values that are present on some devices.
>> +	 */
>> +	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
>> +		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
>> +		wq->wqcfg->bits[i] = ioread32(idxd->reg_base + wq_offset);
>> +	}
>>   
>>   	/* byte 0-3 */
>>   	wq->wqcfg->wq_size = wq->size;
>> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>> index eee94121991e..21aa6e2017c8 100644
>> --- a/drivers/dma/idxd/idxd.h
>> +++ b/drivers/dma/idxd/idxd.h
>> @@ -387,6 +387,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq);
>>   int idxd_wq_enable(struct idxd_wq *wq);
>>   int idxd_wq_disable(struct idxd_wq *wq);
>>   void idxd_wq_drain(struct idxd_wq *wq);
>> +void idxd_wq_reset(struct idxd_wq *wq);
>>   int idxd_wq_map_portal(struct idxd_wq *wq);
>>   void idxd_wq_unmap_portal(struct idxd_wq *wq);
>>   void idxd_wq_disable_cleanup(struct idxd_wq *wq);
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 6d38bf9034e6..0155c1b4f2ef 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -212,7 +212,6 @@ static void disable_wq(struct idxd_wq *wq)
>>   {
>>   	struct idxd_device *idxd = wq->idxd;
>>   	struct device *dev = &idxd->pdev->dev;
>> -	int rc;
>>   
>>   	mutex_lock(&wq->wq_lock);
>>   	dev_dbg(dev, "%s removing WQ %s\n", __func__, dev_name(&wq->conf_dev));
>> @@ -233,17 +232,13 @@ static void disable_wq(struct idxd_wq *wq)
>>   	idxd_wq_unmap_portal(wq);
>>   
>>   	idxd_wq_drain(wq);
>> -	rc = idxd_wq_disable(wq);
>> +	idxd_wq_reset(wq);
>>   
>>   	idxd_wq_free_resources(wq);
>>   	wq->client_count = 0;
>>   	mutex_unlock(&wq->wq_lock);
>>   
>> -	if (rc < 0)
>> -		dev_warn(dev, "Failed to disable %s: %d\n",
>> -			 dev_name(&wq->conf_dev), rc);
>> -	else
>> -		dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));
>> +	dev_info(dev, "wq %s disabled\n", dev_name(&wq->conf_dev));
> noisy again

This is helpful for users enabling/disabling the WQ. If we want to 
remove this, then we should probably do it in a different patch and 
clean up all the enabling and disabling emits.


>
>>   }
>>   
>>   static int idxd_config_bus_remove(struct device *dev)
>>
