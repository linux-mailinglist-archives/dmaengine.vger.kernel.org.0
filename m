Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB36FC9FA
	for <lists+dmaengine@lfdr.de>; Tue,  9 May 2023 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjEIPNs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 May 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjEIPNr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 May 2023 11:13:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FED44AC;
        Tue,  9 May 2023 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683645224; x=1715181224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sDIaRhN9LwUxhy8X7r7FslkiOl4KGP7DqZP3VkptV7U=;
  b=D17WbPDl5viGwTJ0ndZm1m8n/00/GDY/YOaf9cP0tHtlDqiDT8tOIUvN
   QnCmvn4cnh7n6uSlNV0hM+9/n5Df8DOBewYMBwykoC0KtWb9xplLVbi13
   s9N3dMp3mTDFvMKnajyOZYQ0j7kCYvOTj5xWqtf5uxCJGGCgxC0mbuoeQ
   vJ/3Dl8LSTxtpskHlPzVgElXYpdPCszrcvT49E/gQt0k7tDMaU4sZVX5Q
   22zwuo7WEYOPOIT31llPlde9g4lV7ypwpiG9pz4wqG4/llXlu9+hlYHWx
   gVMESM1AdHb+Ct7ADkHfL2lwYl0QYAX9vOHGHCmdl4jdZh23/zNNrLgz/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="329580623"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="329580623"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 08:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="873220589"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="873220589"
Received: from dcovax-mobl.amr.corp.intel.com (HELO [10.212.97.226]) ([10.212.97.226])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 08:13:43 -0700
Message-ID: <a33ff0bb-28c8-0bdf-4367-8354a9e1af9d@intel.com>
Date:   Tue, 9 May 2023 08:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] dmaengine: idxd: Fix passing freed memory in
 idxd_cdev_open()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, kernel-janitors@vger.kernel.org,
        dan.carpenter@linaro.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230509060716.2830630-1-harshit.m.mogalapalli@oracle.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230509060716.2830630-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/8/23 11:07 PM, Harshit Mogalapalli wrote:
> Smatch warns:
> 	drivers/dma/idxd/cdev.c:327:
> 		idxd_cdev_open() warn: 'sva' was already freed.
> 
> When idxd_wq_set_pasid() fails, the current code unbinds sva and then
> goes to 'failed_set_pasid' where iommu_sva_unbind_device is called
> again causing the above warning.
> [ device_user_pasid_enabled(idxd) is still true when calling
> failed_set_pasid ]
> 
> Fix this by removing additional unbind when idxd_wq_set_pasid() fails
> 
> Fixes: b022f59725f0 ("dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thank you!
> ---
> This is purely based on static analysis. Only compile tested.
> ---
>   drivers/dma/idxd/cdev.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index ecbf67c2ad2b..d32deb9b4e3d 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -277,7 +277,6 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>   		if (wq_dedicated(wq)) {
>   			rc = idxd_wq_set_pasid(wq, pasid);
>   			if (rc < 0) {
> -				iommu_sva_unbind_device(sva);
>   				dev_err(dev, "wq set pasid failed: %d\n", rc);
>   				goto failed_set_pasid;
>   			}
