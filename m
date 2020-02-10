Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A65157FE1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2020 17:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgBJQfi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Feb 2020 11:35:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:37096 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgBJQfi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Feb 2020 11:35:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 08:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="233158533"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2020 08:35:35 -0800
Subject: Re: [PATCH -next] dmaengine: idxd: remove set but not used variable
 'idxd_cdev'
To:     YueHaibing <yuehaibing@huawei.com>, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200210151855.55044-1-yuehaibing@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <af481087-388d-fe65-6a42-af5cccb9a46b@intel.com>
Date:   Mon, 10 Feb 2020 09:35:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200210151855.55044-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/10/20 8:18 AM, YueHaibing wrote:
> drivers/dma/idxd/cdev.c: In function idxd_cdev_open:
> drivers/dma/idxd/cdev.c:77:20: warning:
>   variable idxd_cdev set but not used [-Wunused-but-set-variable]
> 
> commit 42d279f9137a ("dmaengine: idxd: add char driver to
> expose submission portal to userland") involed this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/cdev.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 1d73478..8dfdbe3 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -74,12 +74,10 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>   	struct idxd_device *idxd;
>   	struct idxd_wq *wq;
>   	struct device *dev;
> -	struct idxd_cdev *idxd_cdev;
>   
>   	wq = inode_wq(inode);
>   	idxd = wq->idxd;
>   	dev = &idxd->pdev->dev;
> -	idxd_cdev = &wq->idxd_cdev;
>   
>   	dev_dbg(dev, "%s called\n", __func__);
>   
> 
