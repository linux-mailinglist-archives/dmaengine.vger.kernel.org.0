Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F11CBE695
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 22:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfIYUoR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Sep 2019 16:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbfIYUoR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Sep 2019 16:44:17 -0400
Received: from localhost (unknown [12.206.46.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E06121D79;
        Wed, 25 Sep 2019 20:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569444256;
        bh=BDZHp0eNrun4oNBdl/+/8wVxzKPCel7N+XQ75rREyFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvSZk6EmJYtebbar7RnApJACQRlI0QLUMPDYSjK2aT7BCs6xdyrelFGWXOU6x6xfn
         btFGu+hhdiedT/1UdTcG0vsFFGu0sZE2m9lEdCkKbyTSrXM2s0LKabUpFUx2O0RHWb
         ycSxoeylFrqoOP5TSLqKRa/ZgSnVhtP+geQnNNJU=
Date:   Wed, 25 Sep 2019 13:43:15 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: iop-adma: make array 'handler' static const,
 makes object smaller
Message-ID: <20190925204315.GK3824@vkoul-mobl>
References: <20190905163726.19690-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905163726.19690-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-09-19, 17:37, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array 'handler' on the stack but instead make it
> static const. Makes the object code smaller by 80 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   38225	   9084	     64	  47373	   b90d	drivers/dma/iop-adma.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   38081	   9148	     64	  47293	   b8bd	drivers/dma/iop-adma.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/dma/iop-adma.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
> index a3f942a6a946..4dc5478fc156 100644
> --- a/drivers/dma/iop-adma.c
> +++ b/drivers/dma/iop-adma.c
> @@ -1359,9 +1359,11 @@ static int iop_adma_probe(struct platform_device *pdev)
>  	iop_adma_device_clear_err_status(iop_chan);
>  
>  	for (i = 0; i < 3; i++) {
> -		irq_handler_t handler[] = { iop_adma_eot_handler,
> -					iop_adma_eoc_handler,
> -					iop_adma_err_handler };
> +		static const irq_handler_t handler[] = {
> +			iop_adma_eot_handler,
> +			iop_adma_eoc_handler,
> +			iop_adma_err_handler

would it not be more apt to declare the handler outside the loop!

> +		};
>  		int irq = platform_get_irq(pdev, i);
>  		if (irq < 0) {
>  			ret = -ENXIO;
> -- 
> 2.20.1

-- 
~Vinod
