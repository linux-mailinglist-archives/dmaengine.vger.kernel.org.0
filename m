Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB977212B6
	for <lists+dmaengine@lfdr.de>; Sat,  3 Jun 2023 22:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjFCUjK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Jun 2023 16:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjFCUjJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Jun 2023 16:39:09 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF001A9
        for <dmaengine@vger.kernel.org>; Sat,  3 Jun 2023 13:39:07 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id ae644b8c-024e-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 23:39:05 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:39:05 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v1 22/43] dma: cirrus: add DT support for Cirrus EP93xx
Message-ID: <ZHuk6Tc8_MNzGxO4@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-4-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-4-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Thu, Jun 01, 2023 at 08:45:27AM +0300, Nikita Shubin kirjoitti:
> - find register range from the device tree
> - get clocks, interrupts from device tree

...

> --- a/arch/arm/mach-ep93xx/dma.c
> +++ b/arch/arm/mach-ep93xx/dma.c
> @@ -19,6 +19,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include <linux/platform_data/dma-ep93xx.h>

Stray change.

...

> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -20,6 +20,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>

...

> -	struct ep93xx_dma_chan	channels[];
> +	struct ep93xx_dma_chan	*channels;

Why? This is helpful to allocate main structure and channels in one go.

...

> @@ -875,9 +881,11 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
>  	if (!edmac->edma->m2m) {
>  		if (!data)
>  			return -EINVAL;
> +
>  		if (data->port < EP93XX_DMA_I2S1 ||
>  		    data->port > EP93XX_DMA_IRDA)
>  			return -EINVAL;
> +
>  		if (data->direction != ep93xx_dma_chan_direction(chan))
>  			return -EINVAL;
>  	} else {

Seems unrelated change.

>  	ep93xx_dma_advance_work(to_ep93xx_dma_chan(chan));
>  }

...

> +static const struct of_device_id ep93xx_dma_of_ids[] = {
> +	{ .compatible = "cirrus,ep9301-dma-m2p", .data = &edma_m2p },
> +	{ .compatible = "cirrus,ep9301-dma-m2m", .data = &edma_m2m },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_dma_of_ids);

Move this closer to the real user (see below).
Also this ID table shouldn't be under ifdeffery.

...

> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *match = of_match_node(ep93xx_dma_of_ids, pdev->dev.of_node);
> +	const struct ep93xx_edma_data *data = match->data;

No NULL check? Why do you have this duplication, btw?

> +	struct dma_device *dma_dev = &edma->dma_dev;
> +	int num_channels;
> +	int i;
> +
> +	match = of_match_device((ep93xx_dma_of_ids), &pdev->dev);
> +	if (!match || !match->data) {
> +		dev_err(&pdev->dev, "No device match found\n");
> +		return -ENODEV;
> +	}

Use of_device_get_match_data().

...

> +	edma->channels = devm_kzalloc(&pdev->dev,
> +				      num_channels * sizeof(struct ep93xx_dma_chan),
> +				      GFP_KERNEL);
> +	if (!edma->channels)
> +		return -ENOMEM;

Simply no. See below what to do.

...

> +	for (i = 0; i < num_channels; i++) {
> +		struct ep93xx_dma_chan *edmac = &edma->channels[i];
> +
> +		edmac->chan.device = dma_dev;
> +		edmac->regs = devm_platform_ioremap_resource(pdev, i);

No error check?

> +		edmac->irq = platform_get_irq(pdev, i);

No error check?

> +		edmac->edma = edma;
> +
> +		edmac->clk = of_clk_get(np, i);

Can this actually use clk_get() or its devm_*() variant?

> +

Redundant blank line.

> +		if (IS_ERR(edmac->clk)) {
> +			dev_warn(&pdev->dev, "failed to get clock\n");
> +			continue;
> +		}
> +
> +		spin_lock_init(&edmac->lock);
> +		INIT_LIST_HEAD(&edmac->active);
> +		INIT_LIST_HEAD(&edmac->queue);
> +		INIT_LIST_HEAD(&edmac->free_list);
> +		tasklet_setup(&edmac->tasklet, ep93xx_dma_tasklet);
> +
> +		list_add_tail(&edmac->chan.device_node,
> +			      &dma_dev->channels);
> +	}

...

> -	edma_size = pdata->num_channels * sizeof(struct ep93xx_dma_chan);
> -	edma = kzalloc(sizeof(*edma) + edma_size, GFP_KERNEL);
> -	if (!edma)
> +	edma->channels = devm_kzalloc(&pdev->dev,
> +				      pdata->num_channels * sizeof(struct ep93xx_dma_chan),
> +				      GFP_KERNEL);
> +	if (!edma->channels)
>  		return -ENOMEM;

No. Just include overflow.h and use struct_size().

...

> +	edma = devm_kzalloc(&pdev->dev, sizeof(*edma), GFP_KERNEL);
> +

No error check?!

...

> +	if (platform_get_device_id(pdev))
> +		ret = ep93xx_init_from_pdata(pdev, edma);
> +	else
> +		ret = ep93xx_dma_of_probe(pdev, edma);

> +

Redundant blank line.

> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


