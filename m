Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054C03578B2
	for <lists+dmaengine@lfdr.de>; Thu,  8 Apr 2021 02:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhDHAAd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 20:00:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:54917 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhDHAAc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 20:00:32 -0400
IronPort-SDR: ZO2jGQqiuGQHhqetRelxmSoB2yPopCvDH+WkHVaro90coNS9leWbGQntrayPLjrPgIPWmN3lXf
 BrJ9uDtbVyFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="173500720"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="173500720"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 17:00:22 -0700
IronPort-SDR: /NI1+mhGJTc+5/idLLLdpjtsCto+hFWJ9G1VrO4okxtAMg0xsCd7AUNlW0Y+p817IbCASBsc/e
 6cYuAngpNi1A==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="448439951"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.254.185.156]) ([10.254.185.156])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 17:00:22 -0700
Subject: Re: [PATCH v9 00/11] idxd 'struct device' lifetime handling fixes
From:   Dave Jiang <dave.jiang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
References: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
Message-ID: <8ba1ad4c-c6da-a511-91ae-b02a374965db@intel.com>
Date:   Wed, 7 Apr 2021 17:00:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <161739324574.2945060.13103097793006713734.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 4/2/2021 12:56 PM, Dave Jiang wrote:
> v9:
> - Fill in details for commit messages (Jason)
> - Fix wrong indentation (Jason)
> - Move stray change to the right patch (Jason)
> - Remove idxd_free() and refactor 'struct device' setup so we can use
>    ->release() calls to clean up. (Jason)
> - Change idr to ida. (Jason)
> - Remove static type detection for each device type (Dan)

Hi Jason, thanks for all your reviews. Do you have any additional 
comments with this series? I'd like this series to be accepted by Vinod 
for 5.12-rc if possible. Thanks!



>
> v8:
> - Do not emit negative value for sysfs 'minor' attrib (Dan)
> - Use sysfs_emit() to emit sysfs 'minor' attrib (Jason)
> - Fix interation of unwind cleanup of various allocation. (DanC)
>
> v7:
> - Fix up the 'struct device' setup in char device code (Jason)
> - Split out the char dev fixes (Jason)
> - Split out the DMA dev fixes (Dan)
> - Split out the each of the conf_dev fixes
> - Split out removal of the pcim_* calls
> - Split out removal of the devm_* calls
> - Split out the fixes for interrupt config calls
> - Reviewed by Dan.
>
> v6:
> - Fix char dev initialization issues (Jason)
> - Fix other 'struct device' initialization issues.
>
> v5:
> - Rebased against 5.12-rc dmaengine/fixes
> v4:
> - fix up the life time of cdev creation/destruction (Jason)
> - Tested with KASAN and other memory allocation leak detections. (Jason)
>
> v3:
> - Remove devm_* for irq request and cleanup related bits (Jason)
> v2:
> - Remove all devm_* alloc for idxd_device (Jason)
> - Add kref dep for dma_dev (Jason)
>
> Vinod,
> The series fixes the various 'struct device' lifetime handling in the
> idxd driver. The devm managed lifetime is incompatible with 'struct device'
> objects that resides in the idxd context. Tested with
> CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.
>
> Please consider for damengine/fixes for the 5.12-rc.
>
> ---
>
> Dave Jiang (11):
>        dmaengine: idxd: fix dma device lifetime
>        dmaengine: idxd: cleanup pci interrupt vector allocation management
>        dmaengine: idxd: removal of pcim managed mmio mapping
>        dmaengine: idxd: use ida for device instance enumeration
>        dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime
>        dmaengine: idxd: fix wq conf_dev 'struct device' lifetime
>        dmaengine: idxd: fix engine conf_dev lifetime
>        dmaengine: idxd: fix group conf_dev lifetime
>        dmaengine: idxd: fix cdev setup and free device lifetime issues
>        dmaengine: idxd: iax bus removal
>        dmaengine: idxd: remove detection of device type
>
>
>   drivers/dma/idxd/cdev.c   | 132 +++++-------
>   drivers/dma/idxd/device.c |  36 ++--
>   drivers/dma/idxd/idxd.h   |  83 +++++---
>   drivers/dma/idxd/init.c   | 383 ++++++++++++++++++++++-------------
>   drivers/dma/idxd/irq.c    |  10 +-
>   drivers/dma/idxd/submit.c |   2 +-
>   drivers/dma/idxd/sysfs.c  | 410 ++++++++++++++------------------------
>   7 files changed, 525 insertions(+), 531 deletions(-)
>
> --
>
