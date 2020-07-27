Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774C822F2F4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgG0Orl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 10:47:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:10415 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgG0Orl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 10:47:41 -0400
IronPort-SDR: ZP9BbRjwfCO+pVweiT5KbYbqdUnM9z61I/5/npECH+Ku5S1Uz/FCLK8rJ27nbc0HccHpk1TtW/
 ndCQELUpSFtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="148903826"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="148903826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 07:47:41 -0700
IronPort-SDR: sqgwRFBtb0v17tvROHI05mOZkwwEgCxFlcG2cqjWTuq+wSStisC0/SpYOkRI4Bej6l8BIyH/ZT
 INk6om6U/fdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="321831840"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.50.38]) ([10.212.50.38])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2020 07:47:40 -0700
Subject: Re: [PATCH] dmaengine: idxd: reset states after device disable or
 reset
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mona Hossain <mona.hossain@intel.com>, dmaengine@vger.kernel.org
References: <159535783121.44497.13003335997381621798.stgit@djiang5-desk3.ch.intel.com>
 <20200727091757.GT12965@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <3e41f488-4015-f980-53e4-ea58c31f253b@intel.com>
Date:   Mon, 27 Jul 2020 07:47:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727091757.GT12965@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/27/2020 2:17 AM, Vinod Koul wrote:
> On 21-07-20, 11:57, Dave Jiang wrote:
>> The state for WQs should be reset to disabled when a device is reset or
>> disabled.
>>
>> Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
>> Reported-by: Mona Hossain <mona.hossain@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/device.c |   21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 14b45853aa5f..d0290072d558 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -414,6 +414,7 @@ int idxd_device_disable(struct idxd_device *idxd)
>>   {
>>   	struct device *dev = &idxd->pdev->dev;
>>   	u32 status;
>> +	int i;
>>   
>>   	if (!idxd_is_enabled(idxd)) {
>>   		dev_dbg(dev, "Device is not enabled\n");
>> @@ -429,13 +430,33 @@ int idxd_device_disable(struct idxd_device *idxd)
>>   		return -ENXIO;
>>   	}
>>   
>> +	for (i = 0; i < idxd->max_wqs; i++) {
>> +		struct idxd_wq *wq = &idxd->wqs[i];
>> +
>> +		if (wq->state == IDXD_WQ_ENABLED) {
>> +			idxd_wq_disable_cleanup(wq);
>> +			wq->state = IDXD_WQ_DISABLED;
>> +		}
>> +	}
>>   	idxd->state = IDXD_DEV_CONF_READY;
>>   	return 0;
>>   }
>>   
>>   void idxd_device_reset(struct idxd_device *idxd)
>>   {
>> +	int i;
>> +
>>   	idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
>> +
>> +	for (i = 0; i < idxd->max_wqs; i++) {
>> +		struct idxd_wq *wq = &idxd->wqs[i];
>> +
>> +		if (wq->state == IDXD_WQ_ENABLED) {
>> +			idxd_wq_disable_cleanup(wq);
>> +			wq->state = IDXD_WQ_DISABLED;
>> +		}
>> +	}
> 
> Repeated, how about a helper for this?

Ok will fix.

> 
>> +	idxd->state = IDXD_DEV_CONF_READY;
>>   }
>>   
>>   /* Device configuration bits */
> 
