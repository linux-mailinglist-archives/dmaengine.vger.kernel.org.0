Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B76326DD8
	for <lists+dmaengine@lfdr.de>; Sat, 27 Feb 2021 17:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhB0Q2y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Feb 2021 11:28:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:13828 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhB0Q2l (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 27 Feb 2021 11:28:41 -0500
IronPort-SDR: vzxMh0xaF4NXN4B8x9FT9wYa5QFOYtBxHYa1Tu8zJe6X0zvVi0NslczzgZsGPaGf6R+EdlR4QO
 ZK58MLfpQe1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="173272945"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="173272945"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 08:27:56 -0800
IronPort-SDR: oHMWS31PF0XC+CdpEcQvmglUb1kF8x4USn568BHhA3fK39KM5vGmwQ/RT5jZq0avX8A6Q4/LKp
 WDcfNpZfAEZg==
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="434797908"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.15.239]) ([10.212.15.239])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 08:27:32 -0800
Subject: Re: [PATCH v3] dmaengine: idxd: Do not use devm for 'struct device'
 object allocation
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
References: <161420602220.1987219.16867019403434743794.stgit@djiang5-desk3.ch.intel.com>
 <20210227013641.GC4247@nvidia.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <1482a4fc-3359-e807-d8ac-8fa7a2e110ab@intel.com>
Date:   Sat, 27 Feb 2021 09:27:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210227013641.GC4247@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2/26/2021 6:36 PM, Jason Gunthorpe wrote:
> On Wed, Feb 24, 2021 at 03:35:19PM -0700, Dave Jiang wrote:
>> Remove devm_* allocation of memory of 'struct device' objects.
>> The devm_* lifetime is incompatible with device->release() lifetime.
>> Address issues flagged by CONFIG_DEBUG_KOBJECT_RELEASE. Add release
>> functions for each component in order to free the allocated memory at
>> the appropriate time. Each component such as wq, engine, and group now
>> needs to be allocated individually in order to setup the lifetime properly.
> You've tested this now with kasn and all the other debugging turned
> on?

Only with DEBUG_KOBJECT_RELEASE. I wasn't aware of the kasn tests. I'll 
go test with those. Thanks for the thorough review. Really appreciate it.


> I poked around a bit and there are other bugs in here too:
>
> static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
> {
>          idxd_cdev->dev = kzalloc(sizeof(*idxd_cdev->dev), GFP_KERNEL);
>          dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd), idxd->id, wq->id);
>          ^^^ Missing error check
>
>          if (minor < 0) {
>                  rc = minor;
>                  kfree(dev);
>                  ^^^^ leaks the memory dev_set_name allocated
>
> You must call device_initialize before calling dev_set_name and once
> device_initialize is called it must do put_device to clean
> up. put_device will free memory allocated by dev_set_name
>
> Isn't this a use after free kasn should flag?
>
>          device_unregister(idxd_cdev->dev);
>          ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
>                                                  ^^^^^^
>                                               idxd_cdev may
> 					have been freed by device_unregister
>
> Probably a good idea to check all the places working with struct
> device carefully to see that they are right
>
> Jason
