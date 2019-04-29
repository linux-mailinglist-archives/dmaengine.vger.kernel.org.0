Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516EFE1B2
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfD2L5g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 07:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfD2L5g (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Apr 2019 07:57:36 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC40C2053B;
        Mon, 29 Apr 2019 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556539055;
        bh=9E4n//XhLrusSp/ZBe0cf0ZsUJGhMtsRxSteX/xX3xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kg+w/vRo3mOfoo2iApVJxCMkdueILTqmIPtwGQk8ZpFgpz8mLWsC7QuXB/bZyc8lW
         hzzUEqgmYj8CdBoTWrTd/FsYnmm+3Nz2L2W8LhjQ2vJmpUh6HREz0O59z/lmqHTnX9
         xQ8RGkM6FvxeJbD2+KA20bLTU9JVPzOhBd4ODymA=
Date:   Mon, 29 Apr 2019 17:27:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, eric.long@unisoc.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dmaengine: sprd: Add device validation to support
 multiple controllers
Message-ID: <20190429115723.GK3845@vkoul-mobl.Dlink>
References: <cover.1555330115.git.baolin.wang@linaro.org>
 <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-04-19, 20:14, Baolin Wang wrote:
> From: Eric Long <eric.long@unisoc.com>
> 
> Since we can support multiple DMA engine controllers, we should add
> device validation in filter function to check if the correct controller
> to be requested.
> 
> Signed-off-by: Eric Long <eric.long@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/dma/sprd-dma.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 0f92e60..9f99d4b 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
>  static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
>  {
>  	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> +	struct of_phandle_args *dma_spec =
> +		container_of(param, struct of_phandle_args, args[0]);
>  	u32 slave_id = *(u32 *)param;
>  
> +	if (chan->device->dev->of_node != dma_spec->np)

Are you not using of_dma_find_controller() that does this, so this would
be useless!

> +		return false;
> +
>  	schan->dev_id = slave_id;
>  	return true;
>  }
> -- 
> 1.7.9.5

-- 
~Vinod
