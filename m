Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF726F67A
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 09:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIRHKu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 03:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgIRHKu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Sep 2020 03:10:50 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349012067C;
        Fri, 18 Sep 2020 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600413050;
        bh=UcFYRiojSL4wjmOqdsdUtVNUDrkP8yA+FquGKhTMmMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vut+RtHhYZhvozfiLBoHsSxyTjcIT1/9PjLXqwo2o/qNkudvWcRrhMwK5SB119O4L
         HW2OZZkG2JLDDkDFU01WMt9EBvfJSEY0oHBH4y0b5Ec2xakNqmTYY9jfMbhkNDroES
         VdyC+Ni/GVjxZQpzx7O2tBGBaNKsjGV7mZ/l2mHQ=
Date:   Fri, 18 Sep 2020 12:40:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Green Wan <green.wan@sifive.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: sf-pdma: Remove set but not used
 variable "desc"
Message-ID: <20200918071046.GI2968@vkoul-mobl>
References: <20200917071756.1915449-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917071756.1915449-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-09-20, 15:17, Liu Shixin wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/dma/sf-pdma/sf-pdma.c: In function 'sf_pdma_donebh_tasklet':
> drivers/dma/sf-pdma/sf-pdma.c:287:23: warning: unused variable 'desc' [-Wunused-variable]
> 
> After commit 8f6b6d060602 ("dmaengine: sf-pdma: Fix an error that calls callback twice"),
> variable 'desc' is never used. Remove it to avoid build warning.

This was already reported by SFR and patch posted, so picked that one

> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 754994087e5f..1e66c6990d81 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -284,7 +284,6 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
>  static void sf_pdma_donebh_tasklet(unsigned long arg)
>  {
>  	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
> -	struct sf_pdma_desc *desc = chan->desc;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&chan->lock, flags);
> -- 
> 2.25.1

-- 
~Vinod
