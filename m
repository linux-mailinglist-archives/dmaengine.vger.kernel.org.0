Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2057D3B00F
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jun 2019 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbfFJH5g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 03:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbfFJH5f (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jun 2019 03:57:35 -0400
Received: from localhost (unknown [122.178.227.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7206120859;
        Mon, 10 Jun 2019 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560153455;
        bh=0J5cz45KXdQEbC0zP9NDZ6yJHvqD3V+zR61spu7qeCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNmT+sq6h4g+GUszEkq0f7ULAAPg8TMdX+o7uMtCkkOHxR+2c17Jlkh/ieYVwB5/d
         lFk6rRtWpg6OYkmoXBK+TnaHzF4BeeLKtiT1KS5d+GMAjULZMa7u4Nir4c9lSL4x2f
         qV+4ummAhbKbok5tLKME4d8egrLfzuBKTqd8E7yU=
Date:   Mon, 10 Jun 2019 13:24:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] dmaengine: Create symlinks from DMA channels to
 slaves
Message-ID: <20190610075427.GP9160@vkoul-mobl.Dlink>
References: <20190607113835.15376-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607113835.15376-1-geert+renesas@glider.be>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-06-19, 13:38, Geert Uytterhoeven wrote:
> Currently it is not easy to find out which DMA channels are in use, and
> by which slave devices.
> 
> Fix this by creating in sysfs a "slave" symlink from the DMA channel to
> the actual slave device when a channel is requested, and removing it
> again when the channel is released.
> 
> For now this is limited to DT and ACPI.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Questions:
>   1. Do you think this is useful?

Yes for me at least :)

>   2. Should backlinks (e.g. "dma:<name>") be created from the slave
>      device to the DMA channel?
>      This requires storing the name in struct dma_chan, for later
>      symlink removal.

that would certainly be more helpful

>   3. Should this be extended to other ways of requesting channels?
>      In many cases, no device pointer is available, so a device pointer
>      parameter has to be added to all DMA channel request APIs that
>      don't have it yet.

I think that would need to be done.

> ---
>  drivers/dma/dmaengine.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 03ac4b96117cd8db..c11476f76fc96bcf 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -706,6 +706,10 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  
>  	if (chan) {
>  		/* Valid channel found or requester needs to be deferred */
> +		if (!IS_ERR(chan) &&
> +		     sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
> +				       "slave"))
> +			dev_err(dev, "Cannot create DMA slave symlink\n");
>  		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
>  			return chan;
>  	}
> @@ -786,6 +790,7 @@ void dma_release_channel(struct dma_chan *chan)
>  	/* drop PRIVATE cap enabled by __dma_request_channel() */
>  	if (--chan->device->privatecnt == 0)
>  		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
> +	sysfs_remove_link(&chan->dev->device.kobj, "slave");
>  	mutex_unlock(&dma_list_mutex);
>  }
>  EXPORT_SYMBOL_GPL(dma_release_channel);
> -- 
> 2.17.1

-- 
~Vinod
