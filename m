Return-Path: <dmaengine+bounces-1756-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D835789B09E
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C31F214D1
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 11:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB76208B4;
	Sun,  7 Apr 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZwXwvpI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC8156E4;
	Sun,  7 Apr 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712489384; cv=none; b=F2Uo0ka/fUyxB5Trbtq3azSbUv3NGx91u80OFePVN40vlHZmtmHse258PH60mRy5qrnsDhLN9zI5r7M9LYhpJehPiP5VY75kb9IJIngLv6dObiSj8qDJDXKigEvpTFRE251vaRGqBM8i0xOiXhamhle8FqOT4PmITOyPMmCDxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712489384; c=relaxed/simple;
	bh=CcqODA5ep9HsLQe1D3mefuMmarhzF6LU1C89Wm6VHew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBsXnNIJ+q4usaTWTuarXXQ5tjovhSbBJFR+lrtBe2CLsxrB2RxrjvZZ03R5n+bohl+ns3y6vRwWyc13iXNQihYrKj9dLZwBM3tmMxzmo4l2MsJOHBjglWABy3N3OGT5fbbUd2KztKUsXfDE7HKTEbUHYgOM2A0Jj9obiYDCWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZwXwvpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FC5C433C7;
	Sun,  7 Apr 2024 11:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712489383;
	bh=CcqODA5ep9HsLQe1D3mefuMmarhzF6LU1C89Wm6VHew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZwXwvpIJQZlLJ/Lg/73SD7MVpH1ojZ1TwF6sSHOfmtCgRELSijINSZrajmxsJMM0
	 ttCzylkKKQq2k6lh3SCF1gNbUMpp6DWYdlo5cicOR3kv5a9ytJGEGNprWtApIiXmoI
	 VzdJ4Zjrk/ab5twQmFQQmMgiySHXeLjFOHNE1FbZupsadyTF5aD5Vf4qMYZEbR/Q0g
	 XOSTYCJFGbiObAOHSKxOx6r+GBeSMFCR8+d+dFtXv763YjnytBLpUCBT5LUjyopt/D
	 vUhIeultnD/3Wkf8p7LBD0beXx/jXRzTBSsKAkyT/bZ9aYPEStTSaBs+73LZAksHnb
	 /A8OwYZYtFzvQ==
Date: Sun, 7 Apr 2024 16:59:39 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
Message-ID: <ZhKDo0GCpvffUcd8@matsya>
References: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953AE1184DD09F9203C665CBB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953AE1184DD09F9203C665CBB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>

On 29-03-24, 10:04, Inochi Amaoto wrote:
> Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
> its request lines. The multiplexer supports at most 8 request lines.
> 
> Add driver for Sophgo CV18XX/SG200X DMA multiplexer.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  drivers/dma/Kconfig         |   9 ++
>  drivers/dma/Makefile        |   1 +
>  drivers/dma/cv1800-dmamux.c | 267 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 drivers/dma/cv1800-dmamux.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 002a5ec80620..cb31520b9f86 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -546,6 +546,15 @@ config PLX_DMA
>  	  These are exposed via extra functions on the switch's
>  	  upstream port. Each function exposes one DMA channel.
> 
> +config SOPHGO_CV1800_DMAMUX
> +	tristate "Sophgo CV1800/SG2000 series SoC DMA multiplexer support"
> +	depends on MFD_SYSCON
> +	depends on ARCH_SOPHGO
> +	help
> +	  Support for the DMA multiplexer on Sophgo CV1800/SG2000
> +	  series SoCs.
> +	  Say Y here if your board have this soc.
> +
>  config STE_DMA40
>  	bool "ST-Ericsson DMA40 support"
>  	depends on ARCH_U8500
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index dfd40d14e408..7465f249ee47 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
>  obj-$(CONFIG_PXA_DMA) += pxa_dma.o
>  obj-$(CONFIG_RENESAS_DMA) += sh/
>  obj-$(CONFIG_SF_PDMA) += sf-pdma/
> +obj-$(CONFIG_SOPHGO_CV1800_DMAMUX) += cv1800-dmamux.o
>  obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
>  obj-$(CONFIG_STM32_DMA) += stm32-dma.o
>  obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
> diff --git a/drivers/dma/cv1800-dmamux.c b/drivers/dma/cv1800-dmamux.c
> new file mode 100644
> index 000000000000..709414898b67
> --- /dev/null
> +++ b/drivers/dma/cv1800-dmamux.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>

2024

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/llist.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <soc/sophgo/cv1800-sysctl.h>
> +
> +#define DMAMUX_NCELLS			2
> +#define MAX_DMA_MAPPING_ID		42
> +#define MAX_DMA_CPU_ID			2
> +#define MAX_DMA_CH_ID			7
> +
> +#define DMAMUX_INTMUX_REGISTER_LEN	4
> +#define DMAMUX_NR_CH_PER_REGISTER	4
> +#define DMAMUX_BIT_PER_CH		8
> +#define DMAMUX_CH_MASk			GENMASK(5, 0)
> +#define DMAMUX_INT_BIT_PER_CPU		10
> +#define DMAMUX_CH_UPDATE_BIT		BIT(31)
> +
> +#define DMAMUX_CH_REGPOS(chid) \
> +	((chid) / DMAMUX_NR_CH_PER_REGISTER)
> +#define DMAMUX_CH_REGOFF(chid) \
> +	((chid) % DMAMUX_NR_CH_PER_REGISTER)
> +#define DMAMUX_CH_REG(chid) \
> +	((DMAMUX_CH_REGPOS(chid) * sizeof(u32)) + \
> +	 CV1800_SDMA_DMA_CHANNEL_REMAP0)
> +#define DMAMUX_CH_SET(chid, val) \
> +	(((val) << (DMAMUX_CH_REGOFF(chid) * DMAMUX_BIT_PER_CH)) | \
> +	 DMAMUX_CH_UPDATE_BIT)
> +#define DMAMUX_CH_MASK(chid) \
> +	DMAMUX_CH_SET(chid, DMAMUX_CH_MASk)
> +
> +#define DMAMUX_INT_BIT(chid, cpuid) \
> +	BIT((cpuid) * DMAMUX_INT_BIT_PER_CPU + (chid))
> +#define DMAMUX_INTEN_BIT(cpuid) \
> +	DMAMUX_INT_BIT(8, cpuid)
> +#define DMAMUX_INT_CH_BIT(chid, cpuid) \
> +	(DMAMUX_INT_BIT(chid, cpuid) | DMAMUX_INTEN_BIT(cpuid))
> +#define DMAMUX_INT_MASK(chid) \
> +	(DMAMUX_INT_BIT(chid, 0) | \
> +	 DMAMUX_INT_BIT(chid, 1) | \
> +	 DMAMUX_INT_BIT(chid, 2))
> +#define DMAMUX_INT_CH_MASK(chid, cpuid) \
> +	(DMAMUX_INT_MASK(chid) | DMAMUX_INTEN_BIT(cpuid))
> +
> +struct cv1800_dmamux_data {
> +	struct dma_router	dmarouter;
> +	struct regmap		*regmap;
> +	spinlock_t		lock;
> +	struct llist_head	free_maps;
> +	struct llist_head	reserve_maps;
> +	DECLARE_BITMAP(mapped_peripherals, MAX_DMA_MAPPING_ID);
> +};
> +
> +struct cv1800_dmamux_map {
> +	struct llist_node node;
> +	unsigned int channel;
> +	unsigned int peripheral;
> +	unsigned int cpu;
> +};
> +
> +static void cv1800_dmamux_free(struct device *dev, void *route_data)
> +{
> +	struct cv1800_dmamux_data *dmamux = dev_get_drvdata(dev);
> +	struct cv1800_dmamux_map *map = route_data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +
> +	regmap_update_bits(dmamux->regmap,
> +			   DMAMUX_CH_REG(map->channel),
> +			   DMAMUX_CH_MASK(map->channel),
> +			   DMAMUX_CH_UPDATE_BIT);
> +
> +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> +			   DMAMUX_INT_CH_MASK(map->channel, map->cpu),
> +			   DMAMUX_INTEN_BIT(map->cpu));
> +
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
> +	dev_info(dev, "free channel %u for req %u (cpu %u)\n",
> +		 map->channel, map->peripheral, map->cpu);

debug at most please

> +}
> +
> +static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> +					  struct of_dma *ofdma)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +	struct cv1800_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +	struct cv1800_dmamux_map *map;
> +	struct llist_node *node;
> +	unsigned long flags;
> +	unsigned int chid, devid, cpuid;
> +	int ret;
> +
> +	if (dma_spec->args_count != DMAMUX_NCELLS) {
> +		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	devid = dma_spec->args[0];
> +	cpuid = dma_spec->args[1];
> +	dma_spec->args_count = 1;
> +
> +	if (devid > MAX_DMA_MAPPING_ID) {
> +		dev_err(&pdev->dev, "invalid device id: %u\n", devid);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (cpuid > MAX_DMA_CPU_ID) {
> +		dev_err(&pdev->dev, "invalid cpu id: %u\n", cpuid);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
> +	if (!dma_spec->np) {
> +		dev_err(&pdev->dev, "can't get dma master\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +
> +	if (test_bit(devid, dmamux->mapped_peripherals)) {
> +		llist_for_each_entry(map, dmamux->reserve_maps.first, node) {
> +			if (map->peripheral == devid && map->cpu == cpuid)
> +				goto found;
> +		}
> +
> +		ret = -EINVAL;
> +		goto failed;
> +	} else {
> +		node = llist_del_first(&dmamux->free_maps);
> +		if (!node) {
> +			ret = -ENODEV;
> +			goto failed;
> +		}
> +
> +		map = llist_entry(node, struct cv1800_dmamux_map, node);
> +		llist_add(&map->node, &dmamux->reserve_maps);
> +		set_bit(devid, dmamux->mapped_peripherals);
> +	}
> +
> +found:
> +	chid = map->channel;
> +	map->peripheral = devid;
> +	map->cpu = cpuid;
> +
> +	regmap_set_bits(dmamux->regmap,
> +			DMAMUX_CH_REG(chid),
> +			DMAMUX_CH_SET(chid, devid));
> +
> +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> +			   DMAMUX_INT_CH_MASK(chid, cpuid),
> +			   DMAMUX_INT_CH_BIT(chid, cpuid));
> +
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
> +	dma_spec->args[0] = chid;
> +
> +	dev_info(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
> +		 chid, devid, cpuid);

Here as well

> +
> +	return map;
> +
> +failed:
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +	of_node_put(dma_spec->np);
> +	dev_err(&pdev->dev, "errno %d\n", ret);
> +	return ERR_PTR(ret);
> +
> +}
> +
> +static int cv1800_dmamux_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *mux_node = dev->of_node;
> +	struct cv1800_dmamux_data *data;
> +	struct cv1800_dmamux_map *tmp;
> +	struct device *parent = dev->parent;
> +	struct device_node *dma_master;
> +	struct regmap *regmap = NULL;
> +	unsigned int i;
> +
> +	if (!parent)
> +		return -ENODEV;
> +
> +	regmap = device_node_to_regmap(parent->of_node);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	dma_master = of_parse_phandle(mux_node, "dma-masters", 0);
> +	if (!dma_master) {
> +		dev_err(dev, "invalid dma-requests property\n");
> +		return -ENODEV;
> +	}
> +	of_node_put(dma_master);

why do this if you dont need it??

> +
> +	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&data->lock);
> +	init_llist_head(&data->free_maps);
> +
> +	for (i = 0; i <= MAX_DMA_CH_ID; i++) {
> +		tmp = devm_kmalloc(dev, sizeof(*tmp), GFP_KERNEL);
> +		if (!tmp) {
> +			/* It is OK for not allocating all channel */
> +			dev_warn(dev, "can not allocate channel %u\n", i);
> +			continue;
> +		}
> +
> +		init_llist_node(&tmp->node);
> +		tmp->channel = i;
> +		llist_add(&tmp->node, &data->free_maps);
> +	}
> +
> +	/* if no channel is allocated, the probe must fail */
> +	if (llist_empty(&data->free_maps))
> +		return -ENOMEM;
> +
> +	data->regmap = regmap;
> +	data->dmarouter.dev = dev;
> +	data->dmarouter.route_free = cv1800_dmamux_free;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return of_dma_router_register(mux_node,
> +				      cv1800_dmamux_route_allocate,
> +				      &data->dmarouter);
> +}
> +
> +static void cv1800_dmamux_remove(struct platform_device *pdev)
> +{
> +	of_dma_controller_free(pdev->dev.of_node);
> +}
> +
> +static const struct of_device_id cv1800_dmamux_ids[] = {
> +	{ .compatible = "sophgo,cv1800-dmamux", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cv1800_dmamux_ids);
> +
> +static struct platform_driver cv1800_dmamux_driver = {
> +	.driver = {
> +		.name = "cv1800-dmamux",
> +		.of_match_table = cv1800_dmamux_ids,
> +	},
> +	.probe = cv1800_dmamux_probe,
> +	.remove_new = cv1800_dmamux_remove,
> +};
> +module_platform_driver(cv1800_dmamux_driver);
> +
> +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> +MODULE_DESCRIPTION("Sophgo CV1800/SG2000 Series Soc DMAMUX driver");
> +MODULE_LICENSE("GPL");
> --
> 2.44.0

-- 
~Vinod

