Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8BB439B21
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhJYQFc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 12:05:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:43226 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhJYQFb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 12:05:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="216597348"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="216597348"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 09:03:09 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="446294392"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.129.126]) ([10.251.129.126])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 09:03:08 -0700
Message-ID: <fc48be27-823a-1238-04b8-ac29dcf7ee32@intel.com>
Date:   Mon, 25 Oct 2021 09:03:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/7] dmaengine: idxd: rework descriptor free path on
 failure
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
 <163474882126.2608004.7014964789204798071.stgit@djiang5-desk3.ch.intel.com>
 <YXY4/f0gQBtnoBNI@matsya>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <YXY4/f0gQBtnoBNI@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 10/24/2021 9:56 PM, Vinod Koul wrote:
> On 20-10-21, 09:53, Dave Jiang wrote:
>> Refactor the completion function to allow skipping of descriptor freeing on
>> the submission failiure path. This completely removes descriptor freeing
> s/failiure/failure
>
>> from the submit failure path and leave the responsibility to the caller.
>>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/dma.c    |   10 ++++++++--
>>   drivers/dma/idxd/idxd.h   |    8 +-------
>>   drivers/dma/idxd/init.c   |    9 +++------
>>   drivers/dma/idxd/irq.c    |    8 ++++----
>>   drivers/dma/idxd/submit.c |   12 +++---------
>>   5 files changed, 19 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
>> index c39e9483206a..1ea663215909 100644
>> --- a/drivers/dma/idxd/dma.c
>> +++ b/drivers/dma/idxd/dma.c
>> @@ -21,7 +21,8 @@ static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
>>   }
>>   
>>   void idxd_dma_complete_txd(struct idxd_desc *desc,
>> -			   enum idxd_complete_type comp_type)
>> +			   enum idxd_complete_type comp_type,
>> +			   bool free_desc)
>>   {
>>   	struct dma_async_tx_descriptor *tx;
>>   	struct dmaengine_result res;
>> @@ -44,6 +45,9 @@ void idxd_dma_complete_txd(struct idxd_desc *desc,
>>   		tx->callback = NULL;
>>   		tx->callback_result = NULL;
>>   	}
>> +
>> +	if (free_desc)
>> +		idxd_free_desc(desc->wq, desc);
>>   }
>>   
>>   static void op_flag_setup(unsigned long flags, u32 *desc_flags)
>> @@ -153,8 +157,10 @@ static dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>>   	cookie = dma_cookie_assign(tx);
>>   
>>   	rc = idxd_submit_desc(wq, desc);
>> -	if (rc < 0)
>> +	if (rc < 0) {
>> +		idxd_free_desc(wq, desc);
> if there is an error in submit, should the caller not invoke terminate()
> and get the cleanup done?
The driver doesn't have a terminate() implemented. This is the only 
place we can free the descriptor that has been allocated in prep() if 
the submission has failed. Also terminate takes chan as the parameter. 
The chan would not have any access to this failed descriptor. The 
submission failed and the descriptor is not in the submission list or 
has been aborted and removed from the submission list. So calling 
terminate would not actually free the said descriptor. Also there's no 
reason to stop the channel due to a failed descriptor. In this 
particular condition, simplest thing would be to just return the 
allocated descriptor back to the driver.
