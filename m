Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E94322D87
	for <lists+dmaengine@lfdr.de>; Tue, 23 Feb 2021 16:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhBWP3A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 10:29:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:17269 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233222AbhBWP2o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Feb 2021 10:28:44 -0500
IronPort-SDR: 8CoagLKGottnCUV4p1p0ZnxGjQ+xN81nKe6FgVFkM5qqdFuwDheM5+HAIpo9myBcyGerWFLRSb
 ONQtJyNZj6Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="164683965"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="164683965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 07:27:48 -0800
IronPort-SDR: Zxd9ayzvvla5UG83Ky+QPTAF3bVc+bCIm+ZWo9TyNSgo7cPpWpyYPIMRwemXooUUfSls6bZpqA
 HMUuPc4NC11w==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="430806095"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.140.167]) ([10.209.140.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 07:27:47 -0800
Subject: Re: [PATCH] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
References: <161368391486.325538.12829531932377771231.stgit@djiang5-desk3.ch.intel.com>
 <20210223125956.GY4247@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <397867c3-0b0d-82aa-37c1-deccd24d8f6c@intel.com>
Date:   Tue, 23 Feb 2021 08:27:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223125956.GY4247@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/23/2021 5:59 AM, Jason Gunthorpe wrote:
> On Thu, Feb 18, 2021 at 02:31:54PM -0700, Dave Jiang wrote:
>> Remove devm_* allocation of memory of 'struct device' objects.
>> The devm_* lifetime is incompatible with device->release() lifetime.
>> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
>> functions for each component in order to free the allocated memory at
>> the appropriate time. Each component such as wq, engine, and group now
>> needs to be allocated individually in order to setup the lifetime properly.
> I really don't understand why idxd has so many struct device objects.
>
> Typically I expect a simple driver to have exactly one, usually
> provided by its subsystem.
>
> What is the purpose?

When we initially designed this, Dan suggested to tie the device and 
workqueue enabling to the Linux device model so that the 
enabling/disabling can be done via bind/unbind of the sub drivers. So 
that's how we ended up with all the 'struct device' under idxd and one 
for each configurable component of the hardware device.


>
> And it is still messed up because it has:
>
> struct idxd_device {
>          enum idxd_type type;
>          struct device conf_dev; <-- This is a kref
>
>          struct dma_device dma_dev; <-- And this is also a kref
> }
>
> The first kref does kfree() and the second does
> idxd_conf_device_release() which does nothing - this is obviously
> wrong too.

Yes I need to fix this. I forgot about the dma_dev.


>> +static int idxd_allocate_wqs(struct idxd_device *idxd)
>> +{
>> +	struct device *dev = &idxd->pdev->dev;
>> +	struct idxd_wq *wq;
>> +	int i, rc;
>> +
>> +	idxd->wqs = devm_kcalloc(dev, idxd->max_wqs, sizeof(struct idxd_wq *),
>> +				 GFP_KERNEL);
> Memory stored in the idxd_device should be freed by the release
> function, not by devm.

These memory are not tied to 'struct device' and should be able to 
managed by devm right?


>
> And since the sub objects already have a pointer to the idxd_device,
> I'd keep all the types the same but have the sub structs carry a kref
> on the idxd_device, so their release function is just kref_put
>
> Would be much less code

I think I see what you are saying. Let me have another go at it.


>
> But even better would be to get rid of the struct device embedded in
> the sub objects
>
> Jason
