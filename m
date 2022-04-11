Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1408E4FBAD8
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiDKL1P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDKL1O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 07:27:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533372654E;
        Mon, 11 Apr 2022 04:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08E7DB812AB;
        Mon, 11 Apr 2022 11:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26DDC385A4;
        Mon, 11 Apr 2022 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649676297;
        bh=wg7y9W7+1wtuUP8K8s5H/JdupTDeh8S8WNk1NMp09l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qitRrUFkz04RxBchZcJrkV33p9Op3aPYQ1tIZupjpDjFpB32yEKZwwr3AKOSvFKJH
         VesCSnofR3mZSl3nYvfZioYZzwhXeHcLU52NnEuhyfCF6nUmaKN7PS0jPWSE5b6X9d
         BMiqbUK2Uz3f6YePIbz4hmsP4WMIOehw+9wBL+lM6njAyvQ9qqpEGsA+AJVsjLvqfr
         jkjf8h0i3OqfzzpVBKVNyvqGwqJKT+dIW/w6wJ8Ng905RDsO9CziouM7Bxb+rR3k27
         vOLCn/5z6EB6Ow70PbxMcvQl4FwP8P2S+ohn9DQnCXnrcR49t1xS2j61ROdmrD4Vz+
         mIuUPiAPX+8rg==
Date:   Mon, 11 Apr 2022 16:54:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <YlQQBIeM0GZQ6UOE@matsya>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
 <20220406161856.1669069-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406161856.1669069-6-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-04-22, 18:18, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
> 
> We need two additional information from the 'dmas' property: the channel
> (bit in the dmamux register) that must be accessed and the value of the
> mux for this channel.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/Kconfig       |   9 ++
>  drivers/dma/dw/Makefile      |   2 +
>  drivers/dma/dw/rzn1-dmamux.c | 157 +++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+)
>  create mode 100644 drivers/dma/dw/rzn1-dmamux.c
> 
> diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
> index db25f9b7778c..a9828ddd6d06 100644
> --- a/drivers/dma/dw/Kconfig
> +++ b/drivers/dma/dw/Kconfig
> @@ -16,6 +16,15 @@ config DW_DMAC
>  	  Support the Synopsys DesignWare AHB DMA controller. This
>  	  can be integrated in chips such as the Intel Cherrytrail.
>  
> +config RZN1_DMAMUX
> +	tristate "Renesas RZ/N1 DMAMUX driver"
> +	depends on DW_DMAC
> +	depends on ARCH_RZN1 || COMPILE_TEST
> +	help
> +	  Support the Renesas RZ/N1 DMAMUX which is located in front of
> +	  the Synopsys DesignWare AHB DMA controller located on Renesas
> +	  SoCs.
> +
>  config DW_DMAC_PCI
>  	tristate "Synopsys DesignWare AHB DMA PCI driver"
>  	depends on PCI
> diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
> index a6f358ad8591..e1796015f213 100644
> --- a/drivers/dma/dw/Makefile
> +++ b/drivers/dma/dw/Makefile
> @@ -9,3 +9,5 @@ dw_dmac-$(CONFIG_OF)		+= of.o
>  
>  obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
>  dw_dmac_pci-y			:= pci.o
> +
> +obj-$(CONFIG_RZN1_DMAMUX)	+= rzn1-dmamux.o
> diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
> new file mode 100644
> index 000000000000..5f878a55158f
> --- /dev/null
> +++ b/drivers/dma/dw/rzn1-dmamux.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Schneider-Electric
> + * Author: Miquel Raynal <miquel.raynal@bootlin.com
> + * Based on TI crossbar driver written by Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/slab.h>
> +#include <linux/soc/renesas/r9a06g032-sysctrl.h>
> +
> +#define RZN1_DMAMUX_LINES 64
> +#define RZN1_DMAMUX_MAX_LINES 16
> +
> +struct rzn1_dmamux_data {
> +	struct dma_router dmarouter;
> +	u32 used_chans;
> +	struct mutex lock;
> +};
> +
> +struct rzn1_dmamux_map {
> +	unsigned int req_idx;
> +};
> +
> +static void rzn1_dmamux_free(struct device *dev, void *route_data)
> +{
> +	struct rzn1_dmamux_data *dmamux = dev_get_drvdata(dev);
> +	struct rzn1_dmamux_map *map = route_data;
> +
> +	dev_dbg(dev, "Unmapping DMAMUX request %u\n", map->req_idx);
> +
> +	mutex_lock(&dmamux->lock);
> +	dmamux->used_chans &= ~BIT(map->req_idx);
> +	mutex_unlock(&dmamux->lock);

Why not use idr or bitmap for this. Hint: former does locking as well

> +
> +	kfree(map);
> +}
> +
> +static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> +					struct of_dma *ofdma)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +	struct rzn1_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +	struct rzn1_dmamux_map *map;
> +	unsigned int dmac_idx, chan, val;
> +	u32 mask;
> +	int ret;
> +
> +	if (dma_spec->args_count != 6)

magic

> +		return ERR_PTR(-EINVAL);
> +
> +	map = kzalloc(sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);
> +
> +	chan = dma_spec->args[0];
> +	map->req_idx = dma_spec->args[4];
> +	val = dma_spec->args[5];
> +	dma_spec->args_count -= 2;
> +
> +	if (chan >= RZN1_DMAMUX_MAX_LINES) {
> +		dev_err(&pdev->dev, "Invalid DMA request line: %u\n", chan);
> +		ret = -EINVAL;
> +		goto free_map;
> +	}
> +
> +	if (map->req_idx >= RZN1_DMAMUX_LINES ||
> +	    (map->req_idx % RZN1_DMAMUX_MAX_LINES) != chan) {
> +		dev_err(&pdev->dev, "Invalid MUX request line: %u\n", map->req_idx);
> +		ret = -EINVAL;
> +		goto free_map;
> +	}
> +
> +	dmac_idx = map->req_idx >= RZN1_DMAMUX_MAX_LINES ? 1 : 0;
> +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", dmac_idx);
> +	if (!dma_spec->np) {
> +		dev_err(&pdev->dev, "Can't get DMA master\n");
> +		ret = -EINVAL;
> +		goto free_map;
> +	}
> +
> +	dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u request %u\n",
> +		map->req_idx, dmac_idx, chan);
> +
> +	mask = BIT(map->req_idx);
> +	mutex_lock(&dmamux->lock);
> +	dmamux->used_chans |= mask;
> +	ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);

I guess due to this it would be merged by whosoever merges this api.
Please mention this in cover letter and how you propose this should be
merged

-- 
~Vinod
