Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5698437563A
	for <lists+dmaengine@lfdr.de>; Thu,  6 May 2021 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhEFPIr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 May 2021 11:08:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:52602 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234961AbhEFPIq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 6 May 2021 11:08:46 -0400
IronPort-SDR: RLPNgw8CxtYQ1yohmdSCAN1zKSBSvqgXcZSMf4ITxdm1wJnxZ3e3+NuXbivPknY7rK0MsRf9bK
 QZiU4GfEJHyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="198137301"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="198137301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 08:07:46 -0700
IronPort-SDR: yUcbMR2gxObRQHfGVS2cOge7PbLAZT5xh1JgD7v7nYlEqmCFxR/odZ59yLkYQ/5LL72vQRDiam
 onCii0Ut7kww==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="464797366"
Received: from kavila-mobl.amr.corp.intel.com (HELO [10.212.121.180]) ([10.212.121.180])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 08:07:35 -0700
Subject: Re: [PATCH] dmaengine: idxd: Remove redundant variable cdev_ctx
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1620298847-33127-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <324261b0-1fa6-29f7-071a-a3c0ac09b506@intel.com>
Date:   Thu, 6 May 2021 08:07:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1620298847-33127-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/6/2021 4:00 AM, Jiapeng Chong wrote:
> Variable cdev_ctx is set to '&ictx[wq->idxd->data->type]' but this
> value is not used, hence it is a redundant assignment and can be
> removed.
>
> Clean up the following clang-analyzer warning:
>
> drivers/dma/idxd/cdev.c:300:2: warning: Value stored to 'cdev_ctx' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks.


> ---
>   drivers/dma/idxd/cdev.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 302cba5..6c72089 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -295,9 +295,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
>   void idxd_wq_del_cdev(struct idxd_wq *wq)
>   {
>   	struct idxd_cdev *idxd_cdev;
> -	struct idxd_cdev_context *cdev_ctx;
>   
> -	cdev_ctx = &ictx[wq->idxd->data->type];
>   	idxd_cdev = wq->idxd_cdev;
>   	wq->idxd_cdev = NULL;
>   	cdev_device_del(&idxd_cdev->cdev, &idxd_cdev->dev);
