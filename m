Return-Path: <dmaengine+bounces-2845-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1494E030
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 08:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD8A2818E3
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32918E20;
	Sun, 11 Aug 2024 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="f8sWuXEu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CD291E;
	Sun, 11 Aug 2024 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723356022; cv=none; b=BMdrcnzUhKMAkD4xI3OhHgoNcScX7GKN+Yiv+RXUIqwS7uZMcYbg2xJYMxkdLy9NYeEJ4d+2buXTdMl4JwjC6tufdi+LFpJuAqLu6Rn9lpqmWcMagnIJ0RFeaRuMX/eZ/ze4XhUxp5MowROSZ5MKC9N6OHq/zQYxoeOpEIuO2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723356022; c=relaxed/simple;
	bh=JuMLIa27s8EkpSzyIH8/+w1g/u0A6oHfh0oWdPU+STI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk6y3BFkybZEln2x0gG/i3R5/c6x/M/1cRVmbVbZ0lGNePUvz2jxyHxAcj7ij4uNWdhWv7yUq09Wyilo09aBG6i6/tAf2xG/ejowZqxLP8sSn8zUU+5MaPQX0ixQoxms7qsD3JJEAFxXKLlmUQpKmNVA6IKlOnk3JaQf0YX6GT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=f8sWuXEu; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id d1cesT0px3VI6d1cesqN8q; Sun, 11 Aug 2024 08:00:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723356009;
	bh=J+JwXICX6ZzQ0JiaWAjb8FuEa8I8yjuyVEqSpGAhSNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=f8sWuXEufGWZ8gvOyucxFEXRfUVzZuoCXIaug8XCY6HPFKUXOf41cpTRRHFSA1fBB
	 kkPz+JmobeEBBxSsXAn0+5jqZKzJJDDsMASCxb1OnIXJiDkDkFiHgIyKSi6uoKTw2i
	 AhM2EhRewQXLFwYflmZyPeZ2++tUYpVADL0H1s3DMLMjHDvoIhfN/E95LIbe+QSF0p
	 phETbBdoP+H6Pyu6OCJiB6mINCA0fNDCa27jsTcUAzIUTe6amWcnRwJwOrGLMgX+7r
	 9tJ5l6+G2d5HOzF6KKE1MotdMJ3Pr+n04OU6NSEUsn0BfP23cE6WlCzKEzQXp8NS5b
	 1PkMF6Q0YXLYA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 11 Aug 2024 08:00:09 +0200
X-ME-IP: 90.11.132.44
Message-ID: <6246542f-6059-4bf8-91f7-6de713707711@wanadoo.fr>
Date: Sun, 11 Aug 2024 08:00:05 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49533EAD95963C2E99D27B88BB842@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <IA1PR20MB49533EAD95963C2E99D27B88BB842@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/08/2024 à 07:16, Inochi Amaoto a écrit :
> Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
> its request lines. The multiplexer supports at most 8 request lines.
> 
> Add driver for Sophgo CV18XX/SG200X DMA multiplexer.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---

Hi,

...

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
> +	dev_dbg(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
> +		chid, devid, cpuid);
> +
> +	return map;
> +
> +failed:
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +	of_node_put(dma_spec->np);
> +	dev_err(&pdev->dev, "errno %d\n", ret);
> +	return ERR_PTR(ret);
> +

Nitpick: Unneeded empty new line.

> +}
> +
> +static int cv1800_dmamux_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *mux_node = dev->of_node;
> +	struct cv1800_dmamux_data *data;
> +	struct cv1800_dmamux_map *tmp;
> +	struct device *parent = dev->parent;
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
> +	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&data->lock);
> +	init_llist_head(&data->free_maps);

Why init free_maps and not reserve_maps?
'data' is not zeroed, so it should be needed, IMHO.

Same for mapped_peripherals. It is not initialized.

I think that using devm_kzalloc() above is needed. (and 
init_llist_head(&data->free_maps) could then be removed, if you want)

Just my 2c.

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

...

CJ



