Return-Path: <dmaengine+bounces-1438-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3A87F613
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 04:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2344EB215F4
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 03:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2907BAFE;
	Tue, 19 Mar 2024 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="daJ82FT6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E357BAF7
	for <dmaengine@vger.kernel.org>; Tue, 19 Mar 2024 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819366; cv=none; b=fcxDl1Vha4Xo7V3K4JE5txKszXTnK+BXPWr7WnF9MV90DdCJXCPvfOmAaakjRmNckKemnVInYUeOl0GgqFmOgtQgEqcrtFMXRFLITsfpOQRGCVac5+qYcFScrbS0QJX/XT4UhmgkyR36DxxDbirlhD1qDS0NOmqsMvBCJloVBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819366; c=relaxed/simple;
	bh=IqCk3wWDwH0nNe+9317xIgOiS7c6KsfAuF3R1+vLskw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdFJfT4zobNxUweLElWlpjskS3hfZmWvn5VJmsB0ev+9eBhNlpaCkfIuoT7LqdEWXTZIPQleaGhdKd6Om8u1OlzE9pdWZg+uviwkSdMDiLAS4kaRi6q8GR/YD5mr7CpE6Y9hdBFLLqC8BNCe5/AcxVKAmJcVzo2OWXmsSTia914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=daJ82FT6; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36699481c87so14718755ab.3
        for <dmaengine@vger.kernel.org>; Mon, 18 Mar 2024 20:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710819364; x=1711424164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PoILBoe//KVPW1Y8tmEvAG+XkFT1iDwcYoIgG3ixCPU=;
        b=daJ82FT65L2/X87VE2YsdGm0iX3rgUQoYgsc5FPpX5fS/PhEskdehATrB0zPEmBmtq
         j7dn1naBvvh4uBMKlohGuubjEmwpoAsfY/dDyMZIwxNn1CizDkmGewVh8WK4pBy1Nr1F
         Ck79OFG/UcY0H3NMz6tl8QxsE/HIGfAgQvHqQQfn7GpSexSv1gBHrfkg9WHUx3/BIaQ1
         Jsw2Q6SprrXmsf/ZaTj+m/2nufaY1AgSAa1PxhmPFiQzpBoWF2Tldqy2OILed9WhrOjX
         vqdj9dI8zXisJCl8kBmH3nOqPdzSof/A7juwuZ1UCN+KLZ/rLXLZzWerjHTAXQSzTNVy
         5CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710819364; x=1711424164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoILBoe//KVPW1Y8tmEvAG+XkFT1iDwcYoIgG3ixCPU=;
        b=q/BiFbtQO3U0I3ksX7+P8+HlewD0G6X/Jt6z18K+bc58pcpWg9B4DBNGR+JtFDdMRc
         vclhSHbhf3PidVFY2jv2BI4p/c8BMAId4pns959Yw41lZiK1yKnhpAX7LDpfitjJb9Up
         QIzNu1dlFDu1Wfy53QUPVYA0H3+wYbwHM+Tzz4EvhUmsQqvLw1ttUejIXgLnROQnjrNZ
         u/Z5X4sD2nMqx6XfDW4RE771sjuoRQS1uE13rQjc0YQfpJWYEH+bJVMxyfhwxKzWrPcW
         //GYF3pauZntHc6z98/cwBf5hmNyhAJqko2jxSYUwcz77HcO7X7kuJISeRv70DY4pnOQ
         lX6g==
X-Forwarded-Encrypted: i=1; AJvYcCVuQ7yEM9/HldYTFH1q47DYuWzBNqTey/luTLxN0kamg0vq5UA1ZOsq8gwdT8kb2eJjz60j0gw+xGIAJRcsGuKQDt11oMjNVYir
X-Gm-Message-State: AOJu0YyXI+D/SjUzwgXSKXq9knGXEO2wUTwDjfgUMk++epNGA7b79y0L
	RBp7QymLuW3ZJjQrXSwGuBvp6TJa4SttQRcRcRX3e0fpwe8r43vyUtr+INMp7PA=
X-Google-Smtp-Source: AGHT+IGUnS9HGEO7xlGdfqCPY6g7i3+V8E6dv/rN+WqWNaVT/dUYtdS3/p5LTDvg5Jpl5hA4qWwf1g==
X-Received: by 2002:a6b:d917:0:b0:7ce:f8fc:e096 with SMTP id r23-20020a6bd917000000b007cef8fce096mr545938ioc.9.1710819363721;
        Mon, 18 Mar 2024 20:36:03 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id t27-20020a6b5f1b000000b007cbf94d8698sm2336618iob.4.2024.03.18.20.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 20:36:03 -0700 (PDT)
Message-ID: <6d901851-ad57-4ba0-8503-076a0d3e430c@sifive.com>
Date: Mon, 18 Mar 2024 22:36:01 -0500
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
Content-Language: en-US
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49533E6C8C18337E5F6519D0BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <IA1PR20MB49533E6C8C18337E5F6519D0BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-18 1:38 AM, Inochi Amaoto wrote:
> Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
> its request lines. The multiplexer supports at most 8 request lines.
> 
> Add driver for Sophgo CV18XX/SG200X DMA multiplexer.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  drivers/dma/Kconfig         |   9 ++
>  drivers/dma/Makefile        |   1 +
>  drivers/dma/cv1800-dmamux.c | 232 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 242 insertions(+)
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
> index 000000000000..b41c39f2e338
> --- /dev/null
> +++ b/drivers/dma/cv1800-dmamux.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <soc/sophgo/cv1800-sysctl.h>
> +#include <dt-bindings/dma/cv1800-dma.h>
> +
> +#define DMAMUX_NCELLS			3
> +#define MAX_DMA_MAPPING_ID		DMA_SPI_NOR1
> +#define MAX_DMA_CPU_ID			DMA_CPU_C906_1
> +#define MAX_DMA_CH_ID			7
> +
> +#define DMAMUX_INTMUX_REGISTER_LEN	4
> +#define DMAMUX_NR_CH_PER_REGISTER	4
> +#define DMAMUX_BIT_PER_CH		8
> +#define DMAMUX_CH_MASk			GENMASK(5, 0)
> +#define DMAMUX_INT_BIT_PER_CPU		10
> +#define DMAMUX_CH_UPDATE_BIT		BIT(31)
> +
> +#define DMAMUX_CH_SET(chid, val) \
> +	(((val) << ((chid) * DMAMUX_BIT_PER_CH)) | DMAMUX_CH_UPDATE_BIT)
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
> +	(DMAMUX_INT_BIT(chid, DMA_CPU_A53) | \
> +	 DMAMUX_INT_BIT(chid, DMA_CPU_C906_0) | \
> +	 DMAMUX_INT_BIT(chid, DMA_CPU_C906_1))
> +#define DMAMUX_INT_CH_MASK(chid, cpuid) \
> +	(DMAMUX_INT_MASK(chid) | DMAMUX_INTEN_BIT(cpuid))
> +
> +struct cv1800_dmamux_data {
> +	struct dma_router	dmarouter;
> +	struct regmap		*regmap;
> +	spinlock_t		lock;
> +	DECLARE_BITMAP(used_chans, MAX_DMA_CH_ID);
> +	DECLARE_BITMAP(mapped_peripherals, MAX_DMA_MAPPING_ID);
> +};
> +
> +struct cv1800_dmamux_map {
> +	unsigned int channel;
> +	unsigned int peripheral;
> +	unsigned int cpu;
> +};
> +
> +static void cv1800_dmamux_free(struct device *dev, void *route_data)
> +{
> +	struct cv1800_dmamux_data *dmamux = dev_get_drvdata(dev);
> +	struct cv1800_dmamux_map *map = route_data;
> +	u32 regoff = map->channel % DMAMUX_NR_CH_PER_REGISTER;
> +	u32 regpos = map->channel / DMAMUX_NR_CH_PER_REGISTER;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +
> +	regmap_update_bits(dmamux->regmap,
> +			   regpos + CV1800_SDMA_DMA_CHANNEL_REMAP0,
> +			   DMAMUX_CH_MASK(regoff),
> +			   DMAMUX_CH_UPDATE_BIT);
> +
> +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> +			   DMAMUX_INT_CH_MASK(map->channel, map->cpu),
> +			   DMAMUX_INTEN_BIT(map->cpu));
> +
> +	clear_bit(map->channel, dmamux->used_chans);
> +	clear_bit(map->peripheral, dmamux->mapped_peripherals);
> +
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
> +	kfree(map);
> +}
> +
> +static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
> +					  struct of_dma *ofdma)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
> +	struct cv1800_dmamux_data *dmamux = platform_get_drvdata(pdev);
> +	struct cv1800_dmamux_map *map;
> +	unsigned long flags;
> +	unsigned int chid, devid, cpuid;
> +	u32 regoff, regpos;
> +
> +	if (dma_spec->args_count != DMAMUX_NCELLS) {
> +		dev_err(&pdev->dev, "invalid number of dma mux args\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	chid = dma_spec->args[0];
> +	devid = dma_spec->args[1];
> +	cpuid = dma_spec->args[2];
> +	dma_spec->args_count -= 2;
> +
> +	if (chid > MAX_DMA_CH_ID) {
> +		dev_err(&pdev->dev, "invalid channel id: %u\n", chid);
> +		return ERR_PTR(-EINVAL);
> +	}
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
> +	map = kzalloc(sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);
> +
> +	map->channel = chid;
> +	map->peripheral = devid;
> +	map->cpu = cpuid;
> +
> +	regoff = chid % DMAMUX_NR_CH_PER_REGISTER;
> +	regpos = chid / DMAMUX_NR_CH_PER_REGISTER;
> +
> +	spin_lock_irqsave(&dmamux->lock, flags);
> +
> +	if (test_and_set_bit(devid, dmamux->mapped_peripherals)) {
> +		dev_err(&pdev->dev, "already used device mapping: %u\n", devid);
> +		goto failed;
> +	}
> +
> +	if (test_and_set_bit(chid, dmamux->used_chans)) {
> +		clear_bit(devid, dmamux->mapped_peripherals);
> +		dev_err(&pdev->dev, "already used channel id: %u\n", chid);
> +		goto failed;
> +	}
> +
> +	regmap_set_bits(dmamux->regmap,
> +			regpos + CV1800_SDMA_DMA_CHANNEL_REMAP0,
> +			DMAMUX_CH_SET(regoff, devid));
> +
> +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> +			   DMAMUX_INT_CH_MASK(chid, cpuid),
> +			   DMAMUX_INT_CH_BIT(chid, cpuid));
> +
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
> +	dev_info(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
> +		 chid, devid, cpuid);
> +
> +	return map;
> +
> +failed:
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +	dev_err(&pdev->dev, "already used channel id: %u\n", chid);

This error is already logged above.

> +	return ERR_PTR(-EBUSY);
> +}
> +
> +static int cv1800_dmamux_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *mux_node = dev->of_node;
> +	struct cv1800_dmamux_data *data;
> +	struct device *parent = dev->parent;
> +	struct device_node *dma_master;
> +	struct regmap *map = NULL;
> +
> +	if (!parent)
> +		return -ENODEV;
> +
> +	map = device_node_to_regmap(parent->of_node);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	dma_master = of_parse_phandle(mux_node, "dma-masters", 0);
> +	if (!dma_master) {
> +		dev_err(dev, "invalid dma-requests property\n");

This error message doesn't match the property the code looks at.

> +		return -ENODEV;
> +	}
> +	of_node_put(dma_master);
> +
> +	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&data->lock);
> +	data->regmap = map;
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
> +static const struct of_device_id cv1800_dmamux_ids[] = {
> +	{ .compatible = "sophgo,cv1800-dmamux", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cv1800_dmamux_ids);
> +
> +static struct platform_driver cv1800_dmamux_driver = {
> +	.driver = {
> +		.name = "fsl-raideng",

copy-paste error?

> +		.of_match_table = cv1800_dmamux_ids,
> +	},
> +	.probe = cv1800_dmamux_probe,
> +};
> +module_platform_driver(cv1800_dmamux_driver);

This driver can be built as an unloadable module, so it needs a .remove_new
function calling at least of_dma_controller_free().

Regards,
Samuel

> +
> +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> +MODULE_DESCRIPTION("Sophgo CV1800/SG2000 Series Soc DMAMUX driver");
> +MODULE_LICENSE("GPL");
> --
> 2.44.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


