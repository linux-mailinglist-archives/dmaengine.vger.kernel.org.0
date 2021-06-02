Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85158398DAD
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFBPCs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 11:02:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:20829 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhFBPCs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Jun 2021 11:02:48 -0400
IronPort-SDR: 1TCTk3OuZg1JBjCteus9LJJqrobJsaktq6Ve0Q++ayI32XFIyBN1p9sMqUAQKVA4WXK6N7KhR3
 TeIcwQlCn0dQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203618574"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="203618574"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:00:59 -0700
IronPort-SDR: Cd+uXJb63GiwoEBc50BsSOY6scdBxuwpVtC9XSXEORYi71h0i8IJ7PTNAA0OU8qHEzNIF7GVDB
 J9GFUIO1l8qw==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="416921576"
Received: from rgstilwe-mobl.amr.corp.intel.com (HELO [10.254.187.108]) ([10.254.187.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:00:58 -0700
Subject: Re: [PATCH] dmaengine: idxd: Fix missing error code in
 idxd_cdev_open()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1622628446-87909-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <f4e25e75-35cc-23dc-667a-0d7feb9dc35b@intel.com>
Date:   Wed, 2 Jun 2021 08:00:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1622628446-87909-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 6/2/2021 3:07 AM, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'rc'.
>
> Eliminate the follow smatch warning:
>
> drivers/dma/idxd/cdev.c:113 idxd_cdev_open() warn: missing error code
> 'rc'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/dma/idxd/cdev.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 302cba5..d4419bf 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -110,6 +110,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>   		pasid = iommu_sva_get_pasid(sva);
>   		if (pasid == IOMMU_PASID_INVALID) {
>   			iommu_sva_unbind_device(sva);
> +			rc = -EINVAL;
>   			goto failed;
>   		}
>   
