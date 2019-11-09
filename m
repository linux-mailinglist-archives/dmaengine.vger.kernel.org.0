Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA9F609B
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2019 18:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfKIRS7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Nov 2019 12:18:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfKIRS7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 9 Nov 2019 12:18:59 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F762075C;
        Sat,  9 Nov 2019 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573319937;
        bh=HzJ7dGmJxIILn40spE1JrouBnapRyxOA8oFRQa2+oEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFHEGeFMED+7A5jC+amrIsC3ZCxVOcSdC2rvONfCQS3Ixf5udq5kHzG/4XObnTcfE
         PMQ3NScJDWL5cqt19X9zTZ3TNe0aCvNI9H8xFlkisRBquq4CD1Q4VkQyc2N1P/KmkC
         u4oN1zI5Pzcyspa6Sf/vJSdF6y4WcS+OqGK4PVdo=
Date:   Sat, 9 Nov 2019 22:48:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
Message-ID: <20191109171853.GF952516@vkoul-mobl>
References: <20191022214616.7943-1-logang@deltatee.com>
 <20191022214616.7943-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022214616.7943-2-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Logan,

Sorry for delay in reply!

On 22-10-19, 15:46, Logan Gunthorpe wrote:
> dma_chan_to_owner() dereferences the driver from the struct device to
> obtain the owner and call module_[get|put](). However, if the backing
> device is unbound before the dma_device is unregistered, the driver
> will be cleared and this will cause a NULL pointer dereference.

Have you been able to repro this? If so how..?

The expectation is that the driver shall unregister before removed.
> 
> Instead, store a pointer to the owner module in the dma_device struct
> so the module reference can be properly put when the channel is put, even
> if the backing device was destroyed first.
> 
> This change helps to support a safer unbind of DMA engines.

For error cases which should be fixed, so maybe this is a right way and
gets things fixed :)

> If the dma_device is unregistered in the driver's remove function,
> there's no guarantee that there are no existing clients and a users
> action may trigger the WARN_ONCE in dma_async_device_unregister()
> which is unlikely to leave the system in a consistent state.
> Instead, a better approach is to allow the backing driver to go away
> and fail any subsequent requests to it.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/dmaengine.c   | 4 +++-
>  include/linux/dmaengine.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 03ac4b96117c..4b604086b1b3 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -179,7 +179,7 @@ __dma_device_satisfies_mask(struct dma_device *device,
>  
>  static struct module *dma_chan_to_owner(struct dma_chan *chan)
>  {
> -	return chan->device->dev->driver->owner;
> +	return chan->device->owner;
>  }
>  
>  /**
> @@ -919,6 +919,8 @@ int dma_async_device_register(struct dma_device *device)
>  		return -EIO;
>  	}
>  
> +	device->owner = device->dev->driver->owner;
> +
>  	if (dma_has_cap(DMA_MEMCPY, device->cap_mask) && !device->device_prep_dma_memcpy) {
>  		dev_err(device->dev,
>  			"Device claims capability %s, but op is not defined\n",
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 8fcdee1c0cf9..13aa0abb71de 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -674,6 +674,7 @@ struct dma_filter {
>   * @fill_align: alignment shift for memset operations
>   * @dev_id: unique device ID
>   * @dev: struct device reference for dma mapping api
> + * @owner: owner module (automatically set based on the provided dev)
>   * @src_addr_widths: bit mask of src addr widths the device supports
>   *	Width is specified in bytes, e.g. for a device supporting
>   *	a width of 4 the mask should have BIT(4) set.
> @@ -737,6 +738,7 @@ struct dma_device {
>  
>  	int dev_id;
>  	struct device *dev;
> +	struct module *owner;
>  
>  	u32 src_addr_widths;
>  	u32 dst_addr_widths;
> -- 
> 2.20.1

-- 
~Vinod
