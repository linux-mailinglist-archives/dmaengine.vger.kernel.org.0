Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477E51814FC
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 10:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgCKJeH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 05:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgCKJeH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 05:34:07 -0400
Received: from localhost (unknown [106.201.105.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834192146E;
        Wed, 11 Mar 2020 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583919247;
        bh=ApeadzLweGY/ff2YbQDLmBknTg/Dae6mZE6PM07a5H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nixXeKUWuovkgQW/RcVwa2/n8nq5gvCCoy2iEpUr2cMqP8yJXn6HtxOv3QsPCof8b
         bYr46Nbt8F9laNNGfvTVrsYHAdz/N1Zj4rJi/td7EEGjZVsxSDXuEAhgXIZicpS+wH
         9aLOZRXwPyU12buKXj817rYkpZS008wte9v0g/Fc=
Date:   Wed, 11 Mar 2020 15:04:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix off by one on cdev dwq refcount
Message-ID: <20200311093401.GO4885@vkoul-mobl>
References: <158385554998.72352.12513554686212831620.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158385554998.72352.12513554686212831620.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-03-20, 08:52, Dave Jiang wrote:
> The refcount check for dedicuated workqueue (dwq) is off by one and allows
                        
s/dedicuated/dedicated

> more than 1 user to open the char device. Fix check so only a single user
> can open the device.
> 
> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/cdev.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index e4379ba04a9a..f5e43f65a5ed 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -84,9 +84,9 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  	dev = &idxd->pdev->dev;
>  	idxd_cdev = &wq->idxd_cdev;
>  
> -	dev_dbg(dev, "%s called\n", __func__);
> +	dev_dbg(dev, "%s called: %d\n", __func__, idxd_wq_refcount(wq));
>  
> -	if (idxd_wq_refcount(wq) > 1 && wq_dedicated(wq))
> +	if (idxd_wq_refcount(wq) > 0 && wq_dedicated(wq))
>  		return -EBUSY;
>  
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);

-- 
~Vinod
