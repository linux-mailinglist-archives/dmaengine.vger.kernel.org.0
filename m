Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15261FD341
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFQRQa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 13:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFQRQ3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 13:16:29 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27355208B8;
        Wed, 17 Jun 2020 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592414189;
        bh=XZFO2G9XoFtwyH8TQ8JAljAuAst2gpznPf6zQzokidA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v9ik+Orj3DDXShFU2npiIzSazmum6htKlsX0PT2wzsTciPIDZgx5q8PlrlV02VVRH
         J/7eElq0Ef4lDLBbJTlVSWHMAq/SR/9/T5rST4XhBNdkdUXzkBeR0O7ioralFwCrZC
         nIfG/Mxy90+npcI2b0gc3m5X/0JcYI1T+wNTnZFE=
Date:   Wed, 17 Jun 2020 22:46:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     gaurav singh <gaurav1086@gmail.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] txx9dmac_probe: Remove redundant null check
Message-ID: <20200617171624.GX2324254@vkoul-mobl>
References: <CAFAFadAYLEXCdR_yg+GXOSfsBZ879zL7+jaxooZY0Nd6CyA0NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFAFadAYLEXCdR_yg+GXOSfsBZ879zL7+jaxooZY0Nd6CyA0NA@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-06-20, 10:34, gaurav singh wrote:
> The check : if (pdata) is redundant since its already being dereferenced
> above :
> ddev->have_64bit_regs = pdata->have_64bit_regs;
> 
> pdata is not initialized after that hence no need for null check.
> 
> Please find the patch below. Let me know if there is any issue.

Please send the patch using git send-email..
> 
> Thanks and regards,
> Gaurav.
> 
> >From 757eafa0f5195f7dd4c06205e6fa78ff6a282919 Mon Sep 17 00:00:00 2001
> From: Gaurav Singh <gaurav1086@gmail.com>
> Date: Sat, 6 Jun 2020 10:30:56 -0400
> Subject: [PATCH] txx9dmac_probe: Remove redundant null check
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  drivers/dma/txx9dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
> index 628bdf4430c7..4c71eba06a69 100644
> --- a/drivers/dma/txx9dmac.c
> +++ b/drivers/dma/txx9dmac.c
> @@ -1209,7 +1209,7 @@ static int __init txx9dmac_probe(struct
> platform_device *pdev)
>   }
> 
>   mcr = TXX9_DMA_MCR_MSTEN | MCR_LE;
> - if (pdata && pdata->memcpy_chan >= 0)
> + if (pdata->memcpy_chan >= 0)

what happened to formatting here, please run ./scripts/checkpatch.pl to check for style issues

>   mcr |= TXX9_DMA_MCR_FIFUM(pdata->memcpy_chan);
>   dma_writel(ddev, MCR, mcr);
> 
> -- 
> 2.17.1

-- 
~Vinod
