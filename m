Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43603393D3
	for <lists+dmaengine@lfdr.de>; Fri, 12 Mar 2021 17:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhCLQnK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Mar 2021 11:43:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:28467 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233076AbhCLQms (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 12 Mar 2021 11:42:48 -0500
IronPort-SDR: gEAxyVrFRpsfKjLvjQdMcV3owJ7Psnoc3bby7I/RTYT2VCW7HlThSla6MtqSaKK4hOqrQhgeML
 Fvh6P8Btjg6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="175982902"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="175982902"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:42:47 -0800
IronPort-SDR: MhqkadPKtgCCuluw+SQ0B9sAZZm3lcDUuSmIx5oIO1+RjcM8mNcgh3dx/udkF6Ec3Ap/hFmPvN
 KXJWZjXnvd9g==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="448669902"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.189.242]) ([10.209.189.242])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:42:47 -0800
Subject: Re: [PATCH v6] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
References: <161496196189.574379.14498335339906166138.stgit@djiang5-desk3.ch.intel.com>
 <20210312144111.GC2356281@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <147d5977-814a-9f98-ba89-cc438a93f7e0@intel.com>
Date:   Fri, 12 Mar 2021 09:42:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312144111.GC2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 3/12/2021 7:41 AM, Jason Gunthorpe wrote:
> On Fri, Mar 05, 2021 at 09:36:02AM -0700, Dave Jiang wrote:
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
>> v6:
>> - Fix char dev initialization issues (Jason)
>> - Fix other 'struct device' initialization issues.
>>
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
>>   drivers/dma/idxd/cdev.c   |   44 ++++----
>>   drivers/dma/idxd/device.c |   20 ++-
>>   drivers/dma/idxd/dma.c    |   13 ++
>>   drivers/dma/idxd/idxd.h   |   43 +++++++
>>   drivers/dma/idxd/init.c   |  261 +++++++++++++++++++++++++++++++++------------
>>   drivers/dma/idxd/irq.c    |    6 +
>>   drivers/dma/idxd/sysfs.c  |  225 ++++++++++++++++++++-------------------
>>   7 files changed, 393 insertions(+), 219 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index 0db9b82ed8cf..56143336e88b 100644
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -259,34 +259,29 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>>   		return -ENOMEM;
>>   
>>   	dev = idxd_cdev->dev;
>> +	device_initialize(dev);
>>   	dev->parent = &idxd->pdev->dev;
>> -	dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
>> -		     idxd->id, wq->id);
>>   	dev->bus = idxd_get_bus_type(idxd);
>> +	dev->type = &idxd_cdev_device_type;
>> +	rc = dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
>> +			  idxd->id, wq->id);
>> +	if (rc < 0)
>> +		goto dev_set_err;
>>   
>>   	cdev_ctx = &ictx[wq->idxd->type];
>>   	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
>>   	if (minor < 0) {
>>   		rc = minor;
>> -		kfree(dev);
>> -		goto ida_err;
>> +		goto dev_set_err;
>>   	}
>>   
>>   	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
>> -	dev->type = &idxd_cdev_device_type;
>> -	rc = device_register(dev);
>> -	if (rc < 0) {
>> -		dev_err(&idxd->pdev->dev, "device register failed\n");
>> -		goto dev_reg_err;
>> -	}
>>   	idxd_cdev->minor = minor;
> The error unwind after this is wrong:
>
> int idxd_wq_add_cdev(struct idxd_wq *wq)
> {
> 	rc = idxd_wq_cdev_dev_setup(wq);
> 	if (rc < 0)
> 		return rc;
>
>          // At this point we have done device_initialize() only
> 	rc = cdev_device_add(cdev, dev);
> 	if (rc) {
> 		idxd_wq_cdev_cleanup(wq, CDEV_FAILED);
>
>
> static void idxd_wq_cdev_cleanup(struct idxd_wq *wq,
> 				 enum idxd_cdev_cleanup cdev_state)
> {
> 	if (cdev_state == CDEV_NORMAL) {
> 	} else {
> 		device_unregister(dev);  // But nobody called device_register!
>
> The 'enum idxd_cdev_cleanup' is really gross, you should avoid that.
>
> This feels like an error that crept in from splitting dev_setup and
> add_cdev wrongly
>
> There should be two functions 'allocate' which brings things to the
> point that 'put_device()' is the "undo"
>
> And then "add" which does the eventual device add.
>
> To get to that model here you want to move the ida_simple_remove into
> the release function
>
> And you need to split this patch up
Looks like I can split this out as an independent cleanup patch. I'll do 
that and open code the setup and cleanup as well as they don't need to 
have their own functions. I have the new patch and it looks much cleaner.
