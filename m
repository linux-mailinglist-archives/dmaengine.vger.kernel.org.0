Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2CBB19F8
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2019 10:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbfIMIq4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Sep 2019 04:46:56 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:43558 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbfIMIq4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Sep 2019 04:46:56 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1F2D825AEB1;
        Fri, 13 Sep 2019 18:46:54 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 122CD940513; Fri, 13 Sep 2019 10:46:52 +0200 (CEST)
Date:   Fri, 13 Sep 2019 10:46:51 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     vinod.koul@intel.com, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dmaengine: rcar-dmac: Use
 devm_platform_ioremap_resource()
Message-ID: <20190913084651.ggmrs6nyxalqr3jc@verge.net.au>
References: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1568010892-17606-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568010892-17606-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 09, 2019 at 03:34:51PM +0900, Yoshihiro Shimoda wrote:
> This patch uses devm_platform_ioremap_resource() instead of
> using platform_get_resource() and devm_ioremap_resource() together
> to simplify.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/dma/sh/rcar-dmac.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 74996a0..542786d 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1824,7 +1824,6 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  	struct dma_device *engine;
>  	struct rcar_dmac *dmac;
>  	const struct rcar_dmac_of_data *data;
> -	struct resource *mem;
>  	unsigned int i;
>  	int ret;
>  
> @@ -1863,8 +1862,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* Request resources. */
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dmac->iomem = devm_ioremap_resource(&pdev->dev, mem);
> +	dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(dmac->iomem))
>  		return PTR_ERR(dmac->iomem);
>  
> -- 
> 2.7.4
> 
