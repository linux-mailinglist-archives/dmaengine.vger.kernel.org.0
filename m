Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB92377982
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 02:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhEJA12 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 May 2021 20:27:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:40054 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhEJA12 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 9 May 2021 20:27:28 -0400
IronPort-SDR: Ymok5Zpx1FIS3j91FJtW4PyRdqNwawCOJzjS+qbWx8vhrF02ligM6EnlF22xPYz80xpfJ4450W
 abzTCjwP/THQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="179347107"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="179347107"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 17:26:23 -0700
IronPort-SDR: auz3ZelrNtgXEXorSRtI4PIBt5E5vqH+dZM6V67lTDG0Iz9Shbpb9zsIEUuI9xg8Fc1gLlM4H7
 Aa/2Xv4MYFDA==
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="433480864"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.97.165]) ([10.212.97.165])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 17:26:23 -0700
Subject: Re: [PATCH 1/1] dmaengine: idxd: remove unused variable 'cdev_ctx'
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210508063012.2624-1-thunder.leizhen@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <3181e59b-727b-50fd-2c14-78d68a5e09e9@intel.com>
Date:   Sun, 9 May 2021 17:26:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210508063012.2624-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/7/2021 11:30 PM, Zhen Lei wrote:
> GCC reports the following warning with W=1:
>
> drivers/dma/idxd/cdev.c:298:28: warning:
>   variable 'cdev_ctx' set but not used [-Wunused-but-set-variable]
>    298 |  struct idxd_cdev_context *cdev_ctx;
>        |                            ^~~~~~~~
>
> The variable 'cdev_ctx' is not used, remove it to fix the warning.
>
> Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>


Thank you. Issue already reported and fix posted here.

https://lore.kernel.org/dmaengine/324261b0-1fa6-29f7-071a-a3c0ac09b506@intel.com/T/#t


> ---
>   drivers/dma/idxd/cdev.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 302cba5ff779..6c72089ca31a 100644
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
