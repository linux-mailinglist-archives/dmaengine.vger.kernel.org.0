Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE50130AA97
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 16:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBAPKM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 10:10:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:52887 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhBAPFS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 10:05:18 -0500
IronPort-SDR: DlA8JowM3Ouj8G6h6T2anGg5SrAO4+SCi8QQxqgS1MqxU5cb/xGhJX4U4rQjkihtAddkIxSC53
 6QMeLYIlezag==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="244779523"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="244779523"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:05:04 -0800
IronPort-SDR: s0eQY/uMpg9NCPVMW4axPyVjGqqwD9x6BBlXb95pgt9oopFkGHc5NMdFNTG61CzCSA8AULmrBs
 ZMx772LUgIJw==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="371577756"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.254.79.194]) ([10.254.79.194])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 07:05:03 -0800
Subject: Re: [PATCH] dmaengine: idxd: check device state before issue command
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
References: <161161231309.406594.6061304765472136401.stgit@djiang5-desk3.ch.intel.com>
 <20210201061140.GL2771@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <99457095-4878-33eb-a800-e0bdc150054c@intel.com>
Date:   Mon, 1 Feb 2021 08:05:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201061140.GL2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 1/31/2021 11:11 PM, Vinod Koul wrote:
> On 25-01-21, 15:05, Dave Jiang wrote:
>> Add device state check before executing command. Without the check the
>> command can be issued while device is in halt state and causes the driver to
>> block while waiting for the completion of the command.
>>
>> Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Fixes: 0d5c10b4c84d ("dmaengine: idxd: add work queue drain support")
>> ---
>>   drivers/dma/idxd/device.c |   25 ++++++++++++++++++++++++-
>>   drivers/dma/idxd/idxd.h   |    2 +-
>>   drivers/dma/idxd/init.c   |    5 ++++-
>>   3 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 95f94a3ed6be..45077727ce5b 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -398,17 +398,33 @@ static inline bool idxd_is_enabled(struct idxd_device *idxd)
>>   	return false;
>>   }
>>   
>> +static inline bool idxd_device_is_halted(struct idxd_device *idxd)
>> +{
>> +	union gensts_reg gensts;
>> +
>> +	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
>> +
>> +	if (gensts.state == IDXD_DEVICE_STATE_HALT)
>> +		return true;
>> +	return false;
> return (gensts.state == IDXD_DEVICE_STATE_HALT) ??
Ok I'll send v2.
