Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DCC366F65
	for <lists+dmaengine@lfdr.de>; Wed, 21 Apr 2021 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbhDUPr5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Apr 2021 11:47:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:7332 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240048AbhDUPr5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Apr 2021 11:47:57 -0400
IronPort-SDR: 59K++GrGpblefWecCRlbGl7/HaLBLLSiEwudbnEbsgznJMTX2lZr2nuRancwVfdER88aPaOlyJ
 3b8NOFeWjCDw==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195746871"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="195746871"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 08:47:23 -0700
IronPort-SDR: +6mU2LlNAdxcSaBl9c99E4D6p7vlikuzZy16GF4EzYw2UcnMcI6qk4E8ig7vDbEfoNn49jTwHE
 +ybThPtXXhvQ==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="602931060"
Received: from tzanussi-mobl4.amr.corp.intel.com (HELO [10.212.81.216]) ([10.212.81.216])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 08:47:22 -0700
Subject: Re: [PATCH v2 1/1] dmaengine: idxd: Add IDXD performance monitor
 support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <cover.1617467772.git.zanussi@kernel.org>
 <d38a8b3a5d087f1df918fa98627938ef0c898208.1617467772.git.zanussi@kernel.org>
 <YH623ULPRbdi1ker@vkoul-mobl.Dlink>
 <34f61cc9-a6d6-e5a3-5f8c-6ffae8858cce@linux.intel.com>
 <YH+/qyUVtlHwWQJ/@vkoul-mobl.Dlink>
 <410134d7-5a4d-3537-e9cc-c4c8e7068cde@linux.intel.com>
 <YIA+ycNfqwytoy/Z@vkoul-mobl.Dlink>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <fa867751-0019-1950-bdc4-019737f29e4b@linux.intel.com>
Date:   Wed, 21 Apr 2021 10:47:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIA+ycNfqwytoy/Z@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/21/2021 10:03 AM, Vinod Koul wrote:
> On 21-04-21, 07:50, Zanussi, Tom wrote:
> 
>>>>>> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>>>>>> +			    char *buf);
>>>>>> +
>>>>>> +static cpumask_t		perfmon_dsa_cpu_mask;
>>>>>> +static bool			cpuhp_set_up;
>>>>>> +static enum cpuhp_state		cpuhp_slot;
>>>>>> +
>>>>>> +static DEVICE_ATTR_RO(cpumask);
>>>>>
>>>>> Pls document these new attributes added
>>>
>>> ?
>>>
>>
>> Yes, I'll add comments to all the attributes (also I'm assuming they don't need to be documented elsewhere).
> 
> They need to be, all new sysfs attributes are ABI and need to be
> documented in Documentation/ABI/
> 

OK, will do that as well, thanks for letting me know.

Tom

> Thanks
> 
