Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42881C3DD6
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 16:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEDO7s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 May 2020 10:59:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:52237 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDO7s (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 May 2020 10:59:48 -0400
IronPort-SDR: GRk+6ZL1qYTfSpKgPRppBx6rwSo8KQxedUGDj5M1jpxd6+VL3Ixf6qmKRRtWY4JLw7cZQLQE2B
 YHB68NfA8M6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 07:59:47 -0700
IronPort-SDR: BCzkAPXCzI1qOas20gSGlMh1vNWgPQpbvE6VN4QhUEYVTqSRajGtAdpXSfLFZ7kwhM7s4aGzcJ
 33w5wfteVJYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="295519559"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.231.155]) ([10.251.231.155])
  by orsmga008.jf.intel.com with ESMTP; 04 May 2020 07:59:46 -0700
Subject: Re: [PATCH] dmaengine: cookie bypass for out of order completion
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com,
        Dan Williams <dan.j.williams@intel.com>
References: <158827174736.34343.16479132955205930987.stgit@djiang5-desk3.ch.intel.com>
 <20200504053959.GI1375924@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <f5207da6-f54e-1402-f5b1-7f52baa58132@intel.com>
Date:   Mon, 4 May 2020 07:59:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504053959.GI1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/3/2020 10:39 PM, Vinod Koul wrote:
> Hi Dave,
> 
> On 30-04-20, 11:35, Dave Jiang wrote:
>> The cookie tracking in dmaengine expects all submissions completed in
> 
> Correct and that is a *very* fundamental assumption of the cookie
> management. Modifying this will cause impact to other as well..

The current modification only impacts drivers that opt out of this. So 
all existing or future driver does not return the out of order flag 
should remain unimpacted.

> 
>> order. Some DMA devices like Intel DSA can complete submissions out of
>> order, especially if configured with a work queue sharing multiple DMA
>> engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
> 
> We should add this as a capability in dmaengine. How else would users
> know if they can expect out of order completion..

Hmmm...this is more an attribute of the hardware rather than a 
capability that a user would request right? Should we add a new function 
that would provide an avenue for users to query the device on such 
attributes and others like channel depth or SGL max size?

> 
>> those DMA devices. The user should use callbacks to track the completion
>> rather than the DMA cookie. This would address the issue of dmatest
>> complaining that descriptors are "busy" when the cookie count goes
>> backwards due to out of order completion.
> 
> Can we add some documentation for this behaviour as well

sure thing.

> 
>>
>> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> ---
>>   drivers/dma/dmatest.c     |    3 ++-
>>   drivers/dma/idxd/dma.c    |    2 +-
>>   include/linux/dmaengine.h |    1 +
>>   3 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>> index a2cadfa2e6d7..60a4a9cec3c8 100644
>> --- a/drivers/dma/dmatest.c
>> +++ b/drivers/dma/dmatest.c
>> @@ -821,7 +821,8 @@ static int dmatest_func(void *data)
>>   			result("test timed out", total_tests, src->off, dst->off,
>>   			       len, 0);
>>   			goto error_unmap_continue;
>> -		} else if (status != DMA_COMPLETE) {
>> +		} else if (status != DMA_COMPLETE &&
>> +			   status != DMA_OUT_OF_ORDER) {
>>   			result(status == DMA_ERROR ?
>>   			       "completion error status" :
>>   			       "completion busy status", total_tests, src->off,
>> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
>> index c64c1429d160..3f54826abc12 100644
>> --- a/drivers/dma/idxd/dma.c
>> +++ b/drivers/dma/idxd/dma.c
>> @@ -133,7 +133,7 @@ static enum dma_status idxd_dma_tx_status(struct dma_chan *dma_chan,
>>   					  dma_cookie_t cookie,
>>   					  struct dma_tx_state *txstate)
>>   {
>> -	return dma_cookie_status(dma_chan, cookie, txstate);
>> +	return DMA_OUT_OF_ORDER;
> 
> So you are returning out of order always?

Yes. The hardware does not gaurantee in order processing at all. The 
only way to do so is to submit a batched operation with fence set on 
every descriptor in the batch.

> 
>>   }
>>   
>>   /*
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 21065c04c4ac..a0c130131e45 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -39,6 +39,7 @@ enum dma_status {
>>   	DMA_IN_PROGRESS,
>>   	DMA_PAUSED,
>>   	DMA_ERROR,
>> +	DMA_OUT_OF_ORDER,
>>   };
>>   
>>   /**
> 
