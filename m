Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B622824917C
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 01:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHRXl3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 19:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHRXl3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 19:41:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616DC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 16:41:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B0A529E;
        Wed, 19 Aug 2020 01:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597794085;
        bh=FL8lTdjHtNTiufyBf6aXCHIrsCwhOgHhz0pNGh2e54s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCdRDquMGv+gJsaSyEoULngie1MWFCogUObH2TduN68bXUx3CbYVqgvWW3ihvEdn2
         yekt8RuVzSktM+UmrKjZF9Byn6WgoiSnzxFNdQx+I38UZIVcvivXin6nYuvCRYSJn7
         9VvEbVvl3tBn5vZqvr1BM5ovN1I/GXhB9OA5Ioss=
Date:   Wed, 19 Aug 2020 02:41:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] dmaengine: xilinx: dpdma: Make symbol
 'dpdma_debugfs_reqs' static
Message-ID: <20200818234107.GC2360@pendragon.ideasonboard.com>
References: <20200818112217.43816-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818112217.43816-1-weiyongjun1@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Wei,

Thank you for the patch.

On Tue, Aug 18, 2020 at 07:22:17PM +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/dma/xilinx/xilinx_dpdma.c:349:37: warning:
>  symbol 'dpdma_debugfs_reqs' was not declared. Should it be static?
> 
> This variable is not used outside of xilinx_dpdma.c, so this commit
> marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1d220435cab3 ("dmaengine: xilinx: dpdma: Add debugfs support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Vinod, could you pick this up as a v5.9 fix ?

> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 7db70d226e89..81ed1e482878 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -346,7 +346,7 @@ static int xilinx_dpdma_debugfs_desc_done_irq_write(char *args)
>  }
>  
>  /* Match xilinx_dpdma_testcases vs dpdma_debugfs_reqs[] entry */
> -struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
> +static struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
>  	{
>  		.name = "DESCRIPTOR_DONE_INTR",
>  		.tc = DPDMA_TC_INTR_DONE,
> 

-- 
Regards,

Laurent Pinchart
