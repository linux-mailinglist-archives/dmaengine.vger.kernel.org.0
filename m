Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B557B48604D
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jan 2022 06:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiAFF1P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jan 2022 00:27:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47748 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiAFF1P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jan 2022 00:27:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 504C9B81E50;
        Thu,  6 Jan 2022 05:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E4AC36AE5;
        Thu,  6 Jan 2022 05:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641446832;
        bh=rPpZNR2SG7V9Wodym/Wo3u8F0vCxyZV1DllX4+kqxuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtNRW0SEOWqyjICFBJLPnzdpDv6r34KKwX50DdmhSIS5Osgm7Pi7vc0M+JwXkpPBC
         h4okTODPOCg1vqR9xgWOBmUqFYPq4tSUcdyXGPy0yGPslxToQkUjxGWZ1ZL/ON0O06
         bHi9VuD1aQCuflOFyWf0vlVC5ZjMTpPC7oIxOZvpufqjcdtEIdGnnLz6py6zbirRni
         hpK8gz73UW3Idbn9oQa0RDJAFrLS5l2Y4AvkySDT5P9Pxf8QG98wBQwSQTiZEt2eCV
         sQ12ZTAxm809T+IJLip8gJAiMdi8UYa++QLF+CP/QOePnYhFYiXIsacAV+gpTTOvML
         SHYv2oilgl/6g==
Date:   Thu, 6 Jan 2022 10:57:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dmaengine: mediatek: mtk-hsdma: Use
 platform_get_irq() to get the interrupt
Message-ID: <YdZ9rDvYtdu8L8Vb@matsya>
References: <20220104163519.21929-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220104163519.21929-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104163519.21929-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-01-22, 16:35, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * No change
> ---
>  drivers/dma/mediatek/mtk-hsdma.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
> index 6ad8afbb95f2..c0fffde7fe08 100644
> --- a/drivers/dma/mediatek/mtk-hsdma.c
> +++ b/drivers/dma/mediatek/mtk-hsdma.c
> @@ -923,13 +923,10 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
>  		return PTR_ERR(hsdma->clk);
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "No irq resource for %s\n",
> -			dev_name(&pdev->dev));
> -		return -EINVAL;
> -	}
> -	hsdma->irq = res->start;
> +	err = platform_get_irq(pdev, 0);

why not platform_get_irq_optional() here and 3rd patch ?

> +	if (err < 0)
> +		return err;
> +	hsdma->irq = err;
>  
>  	refcount_set(&hsdma->pc_refcnt, 0);
>  	spin_lock_init(&hsdma->lock);
> -- 
> 2.17.1

-- 
~Vinod
