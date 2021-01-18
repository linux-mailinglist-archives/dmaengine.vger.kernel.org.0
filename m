Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444972FA718
	for <lists+dmaengine@lfdr.de>; Mon, 18 Jan 2021 18:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406667AbhARRJ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Jan 2021 12:09:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:13611 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406880AbhARRHl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Jan 2021 12:07:41 -0500
IronPort-SDR: RIeyGNqd3NVgpiSsGbOouhnEV/Ohm6AUK9pQEy9yMht/EjFxVL6n4It6f9R6uK2lQaUHtJ41SA
 Q992Qg4H4AWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="178977326"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="178977326"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 09:06:57 -0800
IronPort-SDR: U5JT+MfrOpfaWgOTd/2j0BpU6Ti07aLVhLOKjxVoBH+DTOq9xGfUKf34UTK2l6cpuBPul2vU5d
 gNSTnrwp9hHQ==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="365391282"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.181.223]) ([10.212.181.223])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 09:06:57 -0800
Subject: Re: [PATCH] dmaengine: idxd: add module parameter to force disable of
 SVA
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org
References: <161074811013.2184257.13335125853932003159.stgit@djiang5-desk3.ch.intel.com>
 <20210117065115.GL2771@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <a7b50b40-ee4a-24c3-d4ba-40c770c970f1@intel.com>
Date:   Mon, 18 Jan 2021 10:06:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210117065115.GL2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 1/16/2021 11:51 PM, Vinod Koul wrote:
> On 15-01-21, 15:01, Dave Jiang wrote:
>> Add a module parameter that overrides the SVA feature enabling. This keeps
>> the driver in legacy mode even when intel_iommu=sm_on is set. In this mode,
>> the descriptor fields must be programmed with dma_addr_t from the Linux DMA
>> API for source, destination, and completion descriptors.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/init.c |    8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 25cc947c6179..9687a24ff982 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -26,6 +26,10 @@ MODULE_VERSION(IDXD_DRIVER_VERSION);
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_AUTHOR("Intel Corporation");
>>   
>> +static bool sva = true;
>> +module_param(sva, bool, 0644);
>> +MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
> Documentation for this please..

Just comments or is there somewhere specific for driver module parameter 
documentations?

>
>> +
>>   #define DRV_NAME "idxd"
>>   
>>   bool support_enqcmd;
>> @@ -338,12 +342,14 @@ static int idxd_probe(struct idxd_device *idxd)
>>   	idxd_device_init_reset(idxd);
>>   	dev_dbg(dev, "IDXD reset complete\n");
>>   
>> -	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM)) {
>> +	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
>>   		rc = idxd_enable_system_pasid(idxd);
>>   		if (rc < 0)
>>   			dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
>>   		else
>>   			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
>> +	} else if (!sva) {
>> +		dev_warn(dev, "User forced SVA off via module param.\n");
>>   	}
>>   
>>   	idxd_read_caps(idxd);
>>
