Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF339D57C
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 08:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFGHBE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 03:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGHBE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 03:01:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A551C611ED;
        Mon,  7 Jun 2021 06:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623049153;
        bh=CJwQoGvE79OdB5eYRHptkf7GcTv7hS5ovcjpiMrOAAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1iQXjnW3zBKMCsDTcVypvyfS0M4IUWgntNdXwaFQeqFKzLc4zGWNGxq+UQeQpYK6
         UtVVR8/hyeA4TICEMAqSiNYhgvnTgXmeJFAQqNbXkXGnyx8kP+YzdnhUBqVA8EeOha
         GvUa5lgKfGUeg57pLOlqYL1aVRN8Z49q53mbxbtXrEji3eqpJWCZj1kgNS1RQX2NeA
         utSQdXfx67mWk7D5KDHzzKumTK+xjozOVFYywxcpahN0/GroEPmZ6ZF1eVwF2kQENh
         3X70hfA5nZV6csoIjAegh2EovHBSFVmy3AvV5mRSlGXHvyPyBZdfvHZAME3aVN/UnJ
         c9fKvGqGJk4yQ==
Date:   Mon, 7 Jun 2021 12:29:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] dmaengine: altera-msgdma: add OF support
Message-ID: <YL3DvQWhn+SsBqhJ@vkoul-mobl>
References: <7d77772f49b978e3d52d3815b8743fe54c816994.1621343877.git.olivier.dautricourt@orolia.com>
 <088a373c92bdee6e24da771c1ae2e4ed0887c0d7.1621343877.git.olivier.dautricourt@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088a373c92bdee6e24da771c1ae2e4ed0887c0d7.1621343877.git.olivier.dautricourt@orolia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-05-21, 15:25, Olivier Dautricourt wrote:
> This driver had no device tree support.
> 
> - add compatible field "altr,socfpga-msgdma"
> - define msgdma_of_xlate, with no argument
> - register dma controller with of_dma_controller_register
> 
> Reviewed-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> ---
> 
> Notes:
>     Changes in v2:
>         none
> 
>     Changes from v2 to v3:
>         Removed CONFIG_OF #ifdef's and use if (IS_ENABLED(CONFIG_OF))
>         only once.
> 
>     Changes from v3 to v4
>         Reintroduce #ifdef CONFIG_OF for msgdma_match
>         as it produces a unused variable warning
> 
>     Changes from v4 to v5
>         - As per Rob's comments on patch 1/2:
>           change compatible field from altr,msgdma to
>           altr,socfpga-msgdma.
>         - change commit title to fit previous commits naming
>         - As per Vinod's comments:
>           - use dma_get_slave_channel instead of dma_get_any_slave_channel which
>             makes more sense.
>           - remove if (IS_ENABLED(CONFIG_OF)) for of_dma_controller_register
>             as it is taken care by the core
> 
>  drivers/dma/altera-msgdma.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 9a841ce5f0c5..acf0990d73ae 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/of_dma.h>
> 
>  #include "dmaengine.h"
> 
> @@ -784,6 +785,14 @@ static int request_and_map(struct platform_device *pdev, const char *name,
>  	return 0;
>  }
> 
> +static struct dma_chan *msgdma_of_xlate(struct of_phandle_args *dma_spec,
> +					struct of_dma *ofdma)
> +{
> +	struct msgdma_device *d = ofdma->of_dma_data;
> +
> +	return dma_get_slave_channel(&d->dmachan);
> +}

Why not use of_dma_simple_xlate() instead?

> +
>  /**
>   * msgdma_probe - Driver probe function
>   * @pdev: Pointer to the platform_device structure
> @@ -888,6 +897,13 @@ static int msgdma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto fail;
> 
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 msgdma_of_xlate, mdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register dma controller");
> +		goto fail;

Should this be treated as an error.. the probe will be invoked on non of
systems too..

-- 
~Vinod
