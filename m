Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD820F0395
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 17:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfKEQ7B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 11:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfKEQ7A (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Nov 2019 11:59:00 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6691E21A4A;
        Tue,  5 Nov 2019 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572973140;
        bh=/A2do6Mf/FPqPLM4v479lgV7kRc8ywC8Z/ymYhp6rms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFavqygrYcNdBWeIIKwJ+n+eOg6AKPGmrReLitjDZaCiWkjp+0njB3pWCDHKLFZTP
         SysI8QrUX1MoPkun18JjrtBovD5bHCDytIt/aJPY+SQGRy49gplo1SuPo5fPOQqzhu
         9iovrOO5Y3/2qhmWoliPXUHB5T4SYIfeTzTk/py0=
Date:   Tue, 5 Nov 2019 22:28:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/zx/remove: Removed dmam_pool_destroy from remove
 method
Message-ID: <20191105165855.GC952516@vkoul-mobl>
References: <20191024041623.24658-1-sst2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024041623.24658-1-sst2005@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-10-19, 09:46, Satendra Singh Thakur wrote:
> In the probe method dmam_pool_create is used. Therefore, there is no
> need to explicitly call dmam_pool_destroy in remove method as this
> will be automatically taken care by devres

Please do not reinvent system tags, git log is your friend to check for
the tags to be used.

In this case, it is dmaengine: zx: remove ...


> 
> Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
> ---
>  drivers/dma/zx_dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
> index 9f4436f7c914..7e4e457ac6d5 100644
> --- a/drivers/dma/zx_dma.c
> +++ b/drivers/dma/zx_dma.c
> @@ -894,7 +894,6 @@ static int zx_dma_remove(struct platform_device *op)
>  		list_del(&c->vc.chan.device_node);
>  	}
>  	clk_disable_unprepare(d->clk);
> -	dmam_pool_destroy(d->pool);
>  
>  	return 0;
>  }
> -- 
> 2.17.1

-- 
~Vinod
