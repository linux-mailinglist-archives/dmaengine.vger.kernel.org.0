Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585AA153542
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBEQcH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Feb 2020 11:32:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:11026 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgBEQcH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 5 Feb 2020 11:32:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 08:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="430207755"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005.fm.intel.com with ESMTP; 05 Feb 2020 08:32:05 -0800
Subject: Re: [PATCH] dmaengine: idxd: Fix error handling in
 idxd_wq_cdev_dev_setup()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200205123248.hmtog7qa2eiqaagh@kili.mountain>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <34f96682-a9c4-ee41-5bbb-320025b7d632@intel.com>
Date:   Wed, 5 Feb 2020 09:32:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200205123248.hmtog7qa2eiqaagh@kili.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/5/20 5:32 AM, Dan Carpenter wrote:
> We can't call kfree(dev) after calling device_register(dev).  The "dev"
> pointer has to be freed using put_device().
> 
> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/idxd/cdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 1d7347825b95..df47be612ebb 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -204,6 +204,7 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>   	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
>   	if (minor < 0) {
>   		rc = minor;
> +		kfree(dev);
>   		goto ida_err;
>   	}
>   
> @@ -212,7 +213,6 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>   	rc = device_register(dev);
>   	if (rc < 0) {
>   		dev_err(&idxd->pdev->dev, "device register failed\n");
> -		put_device(dev);
>   		goto dev_reg_err;
>   	}
>   	idxd_cdev->minor = minor;
> @@ -221,8 +221,8 @@ static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
>   
>    dev_reg_err:
>   	ida_simple_remove(&cdev_ctx->minor_ida, MINOR(dev->devt));
> +	put_device(dev);
>    ida_err:
> -	kfree(dev);
>   	idxd_cdev->dev = NULL;
>   	return rc;
>   }
> 
