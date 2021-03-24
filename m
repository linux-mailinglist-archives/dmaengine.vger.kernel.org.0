Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266FB3482EC
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 21:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhCXUbd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 16:31:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:26369 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237807AbhCXUbU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 16:31:20 -0400
IronPort-SDR: shq8Y93JhL7tJ/tmcG49bdvi6BJ6vfLTn8ArvCl/rOBRQzFDQNuWpS4AWXzmBEqe9zmJ9YXp3p
 Je+oPt1Z/WrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190875671"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190875671"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 13:31:20 -0700
IronPort-SDR: F2C0cVKeNVSm3TOee2syc+fK5ns/fVIRt3qngstnLEguz+xvuycHdaemUNSmIu+qYq/mFQMuwb
 NLeJC7j5GpBw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="452740160"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.87.203]) ([10.255.87.203])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 13:31:19 -0700
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
 <CAPcyv4ibhLP=sGf3iNwoE8Qtr_5nXqcRr7NTsx648bPFWaJjrg@mail.gmail.com>
 <20210324115645.GS2356281@nvidia.com>
 <CAPcyv4jUJa9V1TrcVsEjf3NR6p10x8=0jZ1iCATLNiJ9Tz_YWA@mail.gmail.com>
 <20210324165246.GK2356281@nvidia.com> <20210324195252.GQ1667@kadam>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <a7bfe317-84f2-3ea4-56a6-617040333d90@intel.com>
Date:   Wed, 24 Mar 2021 13:31:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324195252.GQ1667@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/24/2021 12:52 PM, Dan Carpenter wrote:
> On Wed, Mar 24, 2021 at 01:52:46PM -0300, Jason Gunthorpe wrote:
>> On Wed, Mar 24, 2021 at 09:13:35AM -0700, Dan Williams wrote:
>>
>>> Which is just:
>>>
>>> device_initialize()
>>> dev_set_name()
>>>
>>> ...then the name is set as early as the device is ready to filled in
>>> with other details. Just checking for dev_set_name() failures does not
>>> move the api forward in my opinion.
>> This doesn't work either as the release function must be set after
>> initialize but before dev_set_name(), otherwise we both can't and must
>> call put_device() after something like this fails.
>>
>> I can't see an option other than bite the bullet and fix things.
>>
>> A static tool to look for these special lifetime rules around the
>> driver core would be nice.
> If y'all are specific enough about what you want, then I can write the
> check for you.  What I really want is some buggy sample code and the
> warning you want me to print.  I kind of vaguely know that devm_ life
> time rules are tricky but I don't know the details.
>
> https://lore.kernel.org/dmaengine/CAPcyv4g2Odzusx621vatPbA041NXMmc1JK_3oSNM-EOPwDaxqA@mail.gmail.com/T/#m18d39df4097b12a9a5bdf51bb86b31cd0c6c0136
>
> The error handling in idxd_setup_interrupts() and
> idxd_allocate_wqs/engines/groups() is faulty.
>
> +	for (i = 0; i < idxd->max_engines; i++) {
> +		engine = kzalloc_node(sizeof(*engine), GFP_KERNEL, dev_to_node(dev));
> +		if (!engine) {
> +			rc = -ENOMEM;
> +			goto err;
>
> Imagine that kzalloc_node() fails on the first iteration.
>
> +		}
> +
> +		idxd->engines[i] = engine;
> +	}
> +
> +	return 0;
> +
> + err:
> +	while (--i)
> +		kfree(idxd->engines[i]);
>
> The while loop should be while (i--) or while (--i >= 0).  Otherwise,
> --i is -1 so this will loop downwards until it crashes.

Thanks Dan. I'll fix that in the next rev.


> regards,
> dan carpenter
>
