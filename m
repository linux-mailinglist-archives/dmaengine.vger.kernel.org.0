Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56E3B6715
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jun 2021 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhF1Q4Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Jun 2021 12:56:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:41568 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231848AbhF1Q4Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 28 Jun 2021 12:56:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="195289751"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="195289751"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 09:53:58 -0700
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="640976540"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.8.157]) ([10.212.8.157])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 09:53:57 -0700
Subject: Re: [PATCH 00/18] Fix idxd sub-drivers setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
 <4212b8af-0f02-d2b9-a128-0576a2a8b4e5@intel.com>
Message-ID: <cdf50526-8179-c5ef-b45a-d737f6d3acfd@intel.com>
Date:   Mon, 28 Jun 2021 09:53:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4212b8af-0f02-d2b9-a128-0576a2a8b4e5@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 6/14/2021 10:18 AM, Dave Jiang wrote:
>
> On 5/21/2021 3:21 PM, Dave Jiang wrote:
>> Vinod,
>> Please consider this series for the 5.14 merge window. Thank you!
>
> Hi Vinod. Gently ping on this series. Thanks!

Hi Vinod, any chance this series make it into 5.14 merge window? Thanks!


>
>
>>
>> The original dsa_bus_type did not use idiomatic mechanisms for attaching
>> dsa-devices to dsa-drivers. Switch to the idiomatic style. Once this
>> cleanup is in place it will ease the addition of the VFIO mdev driver
>> as another dsa-driver.
>>
>> ---
>>
>> Dave Jiang (18):
>>        dmaengine: idxd: add driver register helper
>>        dmaengine: idxd: add driver name
>>        dmaengine: idxd: add 'struct idxd_dev' as wrapper for conf_dev
>>        dmaengine: idxd: remove IDXD_DEV_CONF_READY
>>        dmaengine: idxd: move wq_enable() to device.c
>>        dmaengine: idxd: move wq_disable() to device.c
>>        dmaengine: idxd: remove bus shutdown
>>        dmaengine: idxd: remove iax_bus_type prototype
>>        dmaengine: idxd: fix bus_probe() and bus_remove() for dsa_bus
>>        dmaengine: idxd: move probe() bits for idxd 'struct device' to 
>> device.c
>>        dmaengine: idxd: idxd: move remove() bits for idxd 'struct 
>> device' to device.c
>>        dmanegine: idxd: open code the dsa_drv registration
>>        dmaengine: idxd: add type to driver in order to allow device 
>> matching
>>        dmaengine: idxd: create idxd_device sub-driver
>>        dmaengine: idxd: create dmaengine driver for wq 'device'
>>        dmaengine: idxd: create user driver for wq 'device'
>>        dmaengine: dsa: move dsa_bus_type out of idxd driver to 
>> standalone
>>        dmaengine: idxd: move dsa_drv support to compatible mode
>>
>>
>>   drivers/dma/Kconfig       |  21 ++
>>   drivers/dma/Makefile      |   2 +-
>>   drivers/dma/idxd/Makefile |   8 +
>>   drivers/dma/idxd/bus.c    |  92 +++++++
>>   drivers/dma/idxd/cdev.c   |  65 ++++-
>>   drivers/dma/idxd/compat.c | 114 ++++++++
>>   drivers/dma/idxd/device.c | 207 +++++++++++++-
>>   drivers/dma/idxd/dma.c    |  82 +++++-
>>   drivers/dma/idxd/idxd.h   | 129 +++++++--
>>   drivers/dma/idxd/init.c   | 132 ++++-----
>>   drivers/dma/idxd/irq.c    |   2 +-
>>   drivers/dma/idxd/sysfs.c  | 553 +++++++-------------------------------
>>   12 files changed, 868 insertions(+), 539 deletions(-)
>>   create mode 100644 drivers/dma/idxd/bus.c
>>   create mode 100644 drivers/dma/idxd/compat.c
>>
>> -- 
>>
