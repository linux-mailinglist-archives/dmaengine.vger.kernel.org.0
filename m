Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD732D96F
	for <lists+dmaengine@lfdr.de>; Thu,  4 Mar 2021 19:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhCDS0w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Mar 2021 13:26:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:32829 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234222AbhCDS0m (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 4 Mar 2021 13:26:42 -0500
IronPort-SDR: /xJVBTU5921LBHreWizLl/B1Qy3063xz5p0k2ohxXJCTzpQToFF6/IOoKrGWnKn8oGhjswNulL
 IaaNROB6dQkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="187528354"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="187528354"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 10:20:10 -0800
IronPort-SDR: R0zaHhwuj7B4kAnf0qDWE33GLaRzGpv1z49kFNdnbmN+B/4g8EwYhfTnNexaA59b5x9yC+eUOb
 UlcbZLGbs9Xw==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="445831643"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.13.184]) ([10.251.13.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 10:20:10 -0800
Subject: Re: [PATCH v5] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
References: <161478326635.3900104.2067961356060195664.stgit@djiang5-desk3.ch.intel.com>
 <20210304180308.GH4247@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <011768f2-4194-809b-5d3d-f50734d55fb3@intel.com>
Date:   Thu, 4 Mar 2021 11:20:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304180308.GH4247@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/4/2021 11:03 AM, Jason Gunthorpe wrote:
> On Wed, Mar 03, 2021 at 07:56:30AM -0700, Dave Jiang wrote:
>> Remove devm_* allocation of memory of 'struct device' objects.
>> The devm_* lifetime is incompatible with device->release() lifetime.
>> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
>> functions for each component in order to free the allocated memory at
>> the appropriate time. Each component such as wq, engine, and group now
>> needs to be allocated individually in order to setup the lifetime properly.
>> In the process also fix up issues from the fallout of the changes.
>>
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> v5:
>> - Rebased against 5.12-rc dmaengine/fixes
>> v4:
>> - fix up the life time of cdev creation/destruction (Jason)
>> - Tested with KASAN and other memory allocation leak detections. (Jason)
>>
>> v3:
>> - Remove devm_* for irq request and cleanup related bits (Jason)
>> v2:
>> - Remove all devm_* alloc for idxd_device (Jason)
>> - Add kref dep for dma_dev (Jason)
>>
>>   drivers/dma/idxd/cdev.c   |   32 +++---
>>   drivers/dma/idxd/device.c |   20 ++-
>>   drivers/dma/idxd/dma.c    |   13 ++
>>   drivers/dma/idxd/idxd.h   |    8 +
>>   drivers/dma/idxd/init.c   |  261 +++++++++++++++++++++++++++++++++------------
>>   drivers/dma/idxd/irq.c    |    6 +
>>   drivers/dma/idxd/sysfs.c  |   77 +++++++++----
>>   7 files changed, 290 insertions(+), 127 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index 0db9b82ed8cf..1b98e06fa228 100644
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -259,6 +259,7 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>>   		return -ENOMEM;
>>   
>>   	dev = idxd_cdev->dev;
>> +	device_initialize(dev);
>>   	dev->parent = &idxd->pdev->dev;
>>   	dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
>>   		     idxd->id, wq->id);
> dev_set_name() can fail
>
>> @@ -268,25 +269,17 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>>   	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
>>   	if (minor < 0) {
>>   		rc = minor;
>> -		kfree(dev);
>>   		goto ida_err;
> This doesn't work
>
>>   	}
>>   
>>   	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
>>   	dev->type = &idxd_cdev_device_type;
> Because this hasn't been done yet and release is thus NULL, will leak memory.

Uck! I fixed this in one version somewhere and dropped it somehow. :( 
Thanks.


>
> Also the order here is wrong:
>
> 	rc = cdev_device_add(cdev, dev);
> 	 [..]
> 	init_waitqueue_head(&idxd_cdev->err_queue);
>
> Userspace can race a call to poll() before err_queue is setup.

Ok will fix.


>
> And probably more. Please check your code carefully!

Sometimes you stare at your own code so much that you just stop seeing 
things. :( Really do appreciate you finding the issues. I'm also looking 
to deprecate this char device code and convert it over to UACCE soon.


>
> Jason
