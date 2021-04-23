Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6155C369904
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 20:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbhDWSQL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 14:16:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:9349 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243743AbhDWSPo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Apr 2021 14:15:44 -0400
IronPort-SDR: PamKz+ZdjvVq4eTqhAJkhwQb9B7JfbVubhizrNlRbATUutYaX+m2P5ZoGNeffDtnHgy0CwRX9E
 eRd6ESN/DIAA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="281440628"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="281440628"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:15:04 -0700
IronPort-SDR: DYEa+ZiFmx7GrvC+NvoTuIHB5o4Su+UVywa5GYtk99dVWzgeQTCBepazR40pTf3O84wpEQsvix
 AyHTEPk0dFbg==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="453647439"
Received: from tzanussi-mobl4.amr.corp.intel.com (HELO [10.209.163.164]) ([10.209.163.164])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:15:03 -0700
Subject: Re: [PATCH v3 0/2] dmaengine: idxd: IDXD pmu support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <cover.1619033785.git.zanussi@kernel.org>
 <YIMHzx6gerPEzbKJ@vkoul-mobl.Dlink>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <d46d7b54-7d2f-4bdc-74f2-2077409f1996@linux.intel.com>
Date:   Fri, 23 Apr 2021 13:15:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIMHzx6gerPEzbKJ@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 4/23/2021 12:45 PM, Vinod Koul wrote:
> On 21-04-21, 16:04, Tom Zanussi wrote:
>> Hi,
>>
>> This is v3 of the IDXD pmu support patch, which addresses the comments
>> from Vinod:
>>
>>   - Removed the default line for INTEL_IDXD_PERFMON making it default 'n'
>>
>>   - Replaced #ifdef CONFIG_INTEL_IDXD_PERFMON with IS_ENABLED()
>>
>>   - Split the patch into two separate patches, the perfmon
>>     implementation and the code that uses it in the IDXD driver.
>>
>>   - Added a new file,
>>     Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa that
>>     documents the new format and cpumask attributes, and added better
>>     comments for those in the code.
>>
>>   - Changed 'dogrp' to 'do_group' in perfmon_collect_events()
>>
>>   - Moved 'int idx' inside the loop in perfmon_validate_group() to the
>>     top of function.
>>
>>   - In perfmon_pmu_read_counter(), return ioread64() directly and get
>>     rid of cntrdata.
>>
>> I also fixed some erroneous code in perfmon_counter_overflow() that
>> because of my misreading of the spec caused unintended clearing of
>> wrong bits.  According to the spec you need to write 1 rather than 0
>> to an OVFSTATUS bit to clear it.
> 
> Applied, thanks
> 
> This conflicted with Daves patches, I managed to resolve, pls check the
> end result
> 

Thanks!

However, it looks like the new files in '[PATCH v3 1/2] dmaengine: idxd: Add
IDXD performance monitor support' didn't make it in, maybe didn't get 'added'
after resolving the conflicts...

+ create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa
+ create mode 100644 drivers/dma/idxd/perfmon.c
+ create mode 100644 drivers/dma/idxd/perfmon.h

Tom



