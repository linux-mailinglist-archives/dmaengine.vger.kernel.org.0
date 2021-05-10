Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1937939C
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhEJQU6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 12:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhEJQU4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 12:20:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64EBF61132;
        Mon, 10 May 2021 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620663591;
        bh=FKfncr6iyOch3bNpClhjVGY6C/e1OSinUbAU2tU3DoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4Pwyg5bSQ83XzmjKyuq4aYPp+jBerH/hRfRyNMSDmfvGUUuHbn6M3wu3pzabgsBK
         clVR3gLbdA8yN0w27MHydUqLi8c0FGfnFqQjHjQZPgPrCbjKH7m8JhKfaIddBEcFVW
         EQUGat8EM2gW1GoH9GRWN7VMUkkSoYgseeekBTt8vVs6kiOReJeRzoWK3pUFvLZZd9
         pQ1PgxT5jwzqbuKww5TCELPekHuu4c5OFYqMH/pYzCXK54SRoNSAg+/l5G1zbdGJu4
         HwXGNsqqWFPz7nPTwtt3Ih2LsCz9W27IK+6MTQN6DO/7foR/t6r+xK0HFSdQDyx2kv
         ob2dbnT8QOPWw==
Date:   Mon, 10 May 2021 21:49:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drivers: dma: altera-msgdma: add OF support
Message-ID: <YJldI9WiFXdIPuUT@vkoul-mobl.Dlink>
References: <YIrAJce3Ej8hNbkA@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIrAJce3Ej8hNbkA@orolia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-04-21, 16:18, Olivier Dautricourt wrote:
> This driver had no device tree support.
> 
> - add compatible field "altr,msgdma"
> - define msgdma_of_xlate, with no argument
> - register dma controller with of_dma_controller_register
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> ---
> 
> Notes:
>     Changes in v2:
>     	none
> 
>     Changes from v2 to v3:
>     	Removed CONFIG_OF #ifdef's and use if (IS_ENABLED(CONFIG_OF))
>     	only once.
> 
>     Changes from v3 to v4
>     	Reintroduce #ifdef CONFIG_OF for msgdma_match
>     	as it produces a unused variable warning
> 
>  drivers/dma/altera-msgdma.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 9a841ce5f0c5..7e58385facef 100644
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
> +	return dma_get_any_slave_channel(&d->dmadev);

Interesting, why dma_get_any_slave_channel() dont you care for the right
slave channel which is required for your controller..?

> +}
> +
>  /**
>   * msgdma_probe - Driver probe function
>   * @pdev: Pointer to the platform_device structure
> @@ -888,6 +897,16 @@ static int msgdma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto fail;
> 
> +	if (IS_ENABLED(CONFIG_OF)) {

no need of this, it is taken care by the core

> +		ret = of_dma_controller_register(pdev->dev.of_node,
> +						 msgdma_of_xlate, mdev);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"failed to register dma controller");
> +			goto fail;
> +		}
> +	}
> +
>  	dev_notice(&pdev->dev, "Altera mSGDMA driver probe success\n");
> 
>  	return 0;
> @@ -916,9 +935,19 @@ static int msgdma_remove(struct platform_device *pdev)
>  	return 0;
>  }
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id msgdma_match[] = {
> +	{ .compatible = "altr,msgdma",},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, msgdma_match);
> +#endif
> +
>  static struct platform_driver msgdma_driver = {
>  	.driver = {
>  		.name = "altera-msgdma",
> +		.of_match_table = of_match_ptr(msgdma_match),
>  	},
>  	.probe = msgdma_probe,
>  	.remove = msgdma_remove,
> --
> 2.31.0.rc2

-- 
~Vinod
