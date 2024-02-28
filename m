Return-Path: <dmaengine+bounces-1147-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709FA86A999
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 09:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AD71F22B54
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E86286BD;
	Wed, 28 Feb 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0ldcjGp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69125635
	for <dmaengine@vger.kernel.org>; Wed, 28 Feb 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107904; cv=none; b=dnE5iJUD51PMIUMriuPT1v3eLQfypimpPpa6wBIhIh44xug+WrqDeL2Us+/RxiO5dYiYo946f+Z1yuZfimYMyrURqjl7N3ndeLXlQHJ8W08dJ82RW05ehq88Gyk4CG5Ml8lm8Xhan15rZ0jJF1o04vucmxUVzmP6yF1VlFP+/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107904; c=relaxed/simple;
	bh=QS7YNNkQDOu5grDQWxuUzToe2z8+BYawhV09qx8T7zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CphtXdMhHJgcplbL8ERZdWMA+Gmq/5kIhl/ajgwDZGAaOFWfSahzP7SyRjXQQ1SGInB58JjH81SYJysb5ymTvlpRurAnYt1ZwMgl8aK8ynCfWmRwUoFussnrgjttRWRFQZt44CLTd0bqxoXHczWU+KRTQKZ8oDndCkpQMeFEeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0ldcjGp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so499085966b.1
        for <dmaengine@vger.kernel.org>; Wed, 28 Feb 2024 00:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709107900; x=1709712700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCpKFtWoNXjMkZqzAEtTMwYKmQm/ge/JJBiVBwRYrQM=;
        b=B0ldcjGp0pkSnyen7BP3g3C6yvV2ictDmYvVQurarefG8DTsSETCBnDc+zPJ84MqST
         v9S/FgLU3z0pgoHjSx997JXDw3nVHQkbYzLtZcT5kJVaQY40dLBBWWXaPKZWlOL+NMP8
         Rite1SK91aO5kd2XcoODS4r9Ea132nDZ6CQM4WpFWulVAjxWgkym96l/I4IwgWlglqN+
         B8Oe8GyJFM4ahwRgvh98+5zGS8VGdzcaamgaoBzfaUoVGz5GbGPpoHfHo2ZgpcR+seK0
         f2b3uOrMPgNwQDjZfvnzgmkECo7RbeL8+l4XUdJG6gFT7x08oaiOdyu30VhHtFlOW1PP
         BSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107900; x=1709712700;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCpKFtWoNXjMkZqzAEtTMwYKmQm/ge/JJBiVBwRYrQM=;
        b=QMkWj1WVHKIngUg1C1wZCPS/dk3TePrtjkWqgy7ApqOYYnwkA5GIw5TMB+XJP+rMOr
         rA1SzgFMfAqC8Eg8xpHiY5BOvNtk8tNMA3l9tJRL/8d6lwA6NLV2eSu+U3me5fTbslrm
         z5tzWoS1+vbWMC02QQw+M9H2oAegUPlOeYhuBFDz3TooYYivfoPuPxP1XyYy+gcWHI+z
         SRPLNKcLw7A2LAnc/8r6QkzGB4156cmTVD1Nyzi7+k0W4GI4k1IONwg3VqxwjH0OpVs/
         RjOBGnNoBp317THzZnD+Rg1RXudT5qXQmKo0i2g9JOY/Ed3hn4jS9A+fgSfVnYGNYmGW
         jeKg==
X-Forwarded-Encrypted: i=1; AJvYcCXUqk1E6iD5iAKA5C6aYjWAGvQGt0nZfJZHtnl2fStKiP1XbmCtN3VXPKeKFmEi51xRBN2TOJLBIjI43OHDjZgkLR7O5lofIXl6
X-Gm-Message-State: AOJu0Yxpo+hOvmympZ3RX0u8MX+/0co0Xz/jdDu25DgYN1rr1715Vuw7
	48nLBd6p7nrFQ1oWsryCgjbu4JWk9Os99+ExR587TG+j6a9CEfyza03FsW4bdUk=
X-Google-Smtp-Source: AGHT+IGn+FQkLl7iPcZ45FV+Js3bubPQ2UkZD8ox1ZrKtQTlry8KNrDBdF5SWkLt9L34g/qlBOm0UA==
X-Received: by 2002:a17:906:5594:b0:a43:f949:8e8d with SMTP id y20-20020a170906559400b00a43f9498e8dmr671209ejp.67.1709107899603;
        Wed, 28 Feb 2024 00:11:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b00a3f45b80559sm1575965ejc.139.2024.02.28.00.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 00:11:39 -0800 (PST)
Message-ID: <c7dd4333-bece-4d26-a7a4-6751b6ba4431@linaro.org>
Date: Wed, 28 Feb 2024 09:11:37 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma: Add Ingenic PDMA driver support
Content-Language: en-US
To: "bin.yao" <bin.yao@ingenic.com>, vkoul@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org, quic_bjorande@quicinc.com,
 rick <rick.tyliu@ingenic.com>
References: <20240228012420.4223-1-bin.yao@ingenic.com>
 <20240228012420.4223-2-bin.yao@ingenic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240228012420.4223-2-bin.yao@ingenic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 02:24, bin.yao wrote:
> From: byao <bin.yao@ingenic.com>
> 
> Add Ingenic PDMA controller support.
> This module can be found on ingenic victory soc.
> 
> Signed-off-by: byao <bin.yao@ingenic.com>
> Signed-off-by: rick <rick.tyliu@ingenic.com>

Full names


Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> ---
>  drivers/dma/Kconfig               |   14 +
>  drivers/dma/Makefile              |    1 +
>  drivers/dma/ingenic/Makefile      |    1 +
>  drivers/dma/ingenic/ingenic_dma.c | 1053 +++++++++++++++++++++++++++++
>  drivers/dma/ingenic/ingenic_dma.h |  250 +++++++
>  5 files changed, 1319 insertions(+)
>  create mode 100644 drivers/dma/ingenic/Makefile
>  create mode 100644 drivers/dma/ingenic/ingenic_dma.c
>  create mode 100644 drivers/dma/ingenic/ingenic_dma.h
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index e928f2ca0f1e..3214c72aef31 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -179,6 +179,20 @@ config DMA_SUN6I
>  	help
>  	  Support for the DMA engine first found in Allwinner A31 SoCs.
>  
> +config DMA_JZ4780
> +	tristate "Ingenic JZ SoC DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support the DMA engine found on Ingenic Jz SoCs.
> +
> +config DMA_INGENIC_SOC
> +	tristate "Ingenic SoC DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support the DMA engine found on Ingenic T41 SoCs.
> +
>  config DW_AXI_DMAC
>  	tristate "Synopsys DesignWare AXI DMA support"
>  	depends on OF
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index dfd40d14e408..8a56175bbfbb 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
>  obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  obj-$(CONFIG_INTEL_LDMA) += lgm/
> +obj-$(CONFIG_DMA_INGENIC_SOC) += ingenic/
>  
>  obj-y += mediatek/
>  obj-y += qcom/
> diff --git a/drivers/dma/ingenic/Makefile b/drivers/dma/ingenic/Makefile
> new file mode 100644
> index 000000000000..2028a6f0b0c8
> --- /dev/null
> +++ b/drivers/dma/ingenic/Makefile
> @@ -0,0 +1 @@
> +obj-y += ingenic_dma.o
> diff --git a/drivers/dma/ingenic/ingenic_dma.c b/drivers/dma/ingenic/ingenic_dma.c
> new file mode 100644
> index 000000000000..066325e35a92
> --- /dev/null
> +++ b/drivers/dma/ingenic/ingenic_dma.c
> @@ -0,0 +1,1053 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2016 Ingenic Semiconductor Co., Ltd.
> + * Author: cli <chen.li@ingenic.com>
> + *
> + * Programmable DMA Controller Driver For Ingenic's SOC,
> + * such as X1000, and so on. (kernel.4.4)
> + *
> + *  Author:	cli <chen.li@ingenic.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/irq.h>
> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/dmapool.h>
> +#include "ingenic_dma.h"
> +
> +static void dump_dma(struct ingenic_dma_chan *master)
> +{
> +	pr_debug("CH_DSA = 0x%08x\n", readl(master->iomem + CH_DSA));
> +	pr_debug("CH_DTA = 0x%08x\n", readl(master->iomem + CH_DTA));
> +	pr_debug("CH_DTC = 0x%08x\n", readl(master->iomem + CH_DTC));
> +	pr_debug("CH_DRT = 0x%08x\n", readl(master->iomem + CH_DRT));
> +	pr_debug("CH_DCS = 0x%08x\n", readl(master->iomem + CH_DCS));
> +	pr_debug("CH_DCM = 0x%08x\n", readl(master->iomem + CH_DCM));
> +	pr_debug("CH_DDA = 0x%08x\n", readl(master->iomem + CH_DDA));
> +	pr_debug("CH_DSD = 0x%08x\n", readl(master->iomem + CH_DSD));
> +}
> +
> +static int dump_dma_hdesc(struct hdma_desc *desc, const char *d)
> +{
> +	int i;
> +	unsigned long *p = (unsigned long *)desc;
> +
> +	pr_debug("%s(): %s\n", __func__, d);
> +	for (i = 0; i < 8; i++)
> +		pr_debug("\t%08lx\n", (unsigned long)*p++);
> +
> +	return 0;
> +}
> +
> +void jzdma_dump(struct dma_chan *chan)
> +{
> +	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
> +
> +	dump_dma(dmac);
> +}
> +EXPORT_SYMBOL_GPL(jzdma_dump);

Drop, not used.

> +
> +/*tsz for 1,2,4,8,16,32,64 128bytes */
> +static const char dcm_tsz[8] = { 1, 2, 0, 0, 3, 4, 5, 6};

You have total mess here. Definitions of such data go before functions.
Don't mix them.

> +static inline unsigned int get_current_tsz(unsigned long dcmp)

Drop all these inlines.

> +{
> +	int i;
> +	int val = (dcmp & DCM_TSZ_MSK) >> DCM_TSZ_SFT;
> +
> +	if (val == DCM_TSZ_AUTO)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(dcm_tsz); i++) {
> +		if (val == dcm_tsz[i])
> +			break;
> +	}
> +
> +	return i;
> +}
> +
> +static inline unsigned char get_max_tsz(unsigned long val, unsigned int *shift)

Drop inline.

> +{
> +	int ord = ffs(val) - 1;
> +
> +	/*
> +	 * 8 byte transfer sizes unsupported so fall back on 4. If it's larger
> +	 * than the maximum, just limit it. It is perfectly safe to fall back
> +	 * in this way since we won't exceed the maximum burst size supported
> +	 * by the device, the only effect is reduced efficiency. This is better
> +	 * than refusing to perform the request at all.
> +	 */
> +	if (ord == 3)
> +		ord = 2;
> +	else if (ord > 7)
> +		ord = 7;
> +
> +	if (shift)
> +		*shift = ord;
> +
> +	return dcm_tsz[ord];
> +}
> +
> +static const struct of_device_id ingenic_dma_dt_match[];
> +
> +static struct ingenic_dma_engine *ingenic_dma_parse_dt(struct platform_device *pdev)

This should be just before probe function.

> +{
> +	const struct of_device_id *match;
> +	struct ingenic_dma_engine *ingenic_dma;
> +	u32 nr_chs;
> +
> +	if (!pdev->dev.of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	match = of_match_node(ingenic_dma_dt_match, pdev->dev.of_node);
> +	if (!match)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "#dma-channels", &nr_chs))
> +		nr_chs = 32;
> +
> +	ingenic_dma = devm_kzalloc(&pdev->dev, sizeof(*ingenic_dma) +
> +			sizeof(struct ingenic_dma_chan *) * nr_chs, GFP_KERNEL);

You should use struct_size

> +	if (!ingenic_dma)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ingenic_dma->dev = &pdev->dev;
> +	ingenic_dma->nr_chs = nr_chs;
> +	ingenic_dma->hwattr = (unsigned long)match->data;
> +
> +	/* Property is optional, if it doesn't exist the value will remain 0. */
> +	of_property_read_u32(pdev->dev.of_node, "ingenic,reserved-chs",

NAK, there is no such property.

> +			&ingenic_dma->chan_reserved);
> +
> +	if (!of_property_read_u32(pdev->dev.of_node, "ingenic,programed-chs",

NAK, there is no such property.

Cleanup your driver before sending it upstream.



> +				&ingenic_dma->chan_programed))
> +		ingenic_dma->chan_reserved |= ingenic_dma->chan_programed;
> +
> +	if (HWATTR_SPECIAL_CH01_SUP(ingenic_dma->hwattr) &&
> +			of_property_read_bool(pdev->dev.of_node,
> +				"ingenic,special-chs")) {
> +		ingenic_dma->chan_reserved  |= DMA_SPECAIL_CHS;
> +		ingenic_dma->chan_programed |= DMA_SPECAIL_CHS;
> +		ingenic_dma->special_ch = true;
> +	}
> +
> +	ingenic_dma->intc_ch = -1;
> +	if (HWATTR_INTC_IRQ_SUP(ingenic_dma->hwattr) &&
> +			!of_property_read_u32(pdev->dev.of_node,
> +				"ingenic,intc-ch", (u32 *)&ingenic_dma->intc_ch)) {

NAK, cleanup your driver from such vendor stuff before sending upstream.


> +static unsigned int build_one_slave_desc(struct ingenic_dma_chan *dmac, dma_addr_t addr,
> +		unsigned int length,
> +		enum dma_transfer_direction direction,
> +		struct hdma_desc *desc)
> +{
> +	enum dma_transfer_direction dir;
> +	unsigned int rdil;
> +//	unsigned int tsz, transfer_shift;

???

Clean your driver before submitting it to upstream.


....


> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* must be delete it */

Or really?

> +	//if (config->slave_id & INGENIC_DMA_TYPE_REQ_MSK)
> +	//	dmac->slave_id = config->slave_id & INGENIC_DMA_TYPE_REQ_MSK;

Then please delete it.

> +
> +	return 0;
> +}
> +
> +static void pdma_handle_chan_irq(struct ingenic_dma_engine *ingenic_dma, int ch_id)
> +{
> +	struct ingenic_dma_chan *dmac = ingenic_dma->chan[ch_id];
> +	struct ingenic_dma_sdesc *sdesc;
> +	unsigned int dcs;
> +
> +	spin_lock(&dmac->vc.lock);
> +
> +	dcs = readl(dmac->iomem + CH_DCS);
> +	writel(0, dmac->iomem + CH_DCS);
> +
> +	if (dcs & DCS_AR)
> +		dev_warn(&dmac->vc.chan.dev->device,
> +				"address error (DCS=0x%x)\n", dcs);
> +
> +	if (dcs & DCS_HLT)
> +		dev_warn(&dmac->vc.chan.dev->device,
> +				"channel halt (DCS=0x%x)\n", dcs);
> +	sdesc = dmac->sdesc;
> +	if (sdesc) {
> +		if (sdesc->status == STAT_STOPPED) {
> +			dma_cookie_complete(&sdesc->vd.tx);
> +			ingenic_dma_free_swdesc(&sdesc->vd);
> +			complete(&dmac->completion);
> +		} else if (dmac->fake_cyclic && sdesc->cyclic) {
> +			vchan_cyclic_callback(&sdesc->vd);
> +		} else {
> +			vchan_cookie_complete(&sdesc->vd);
> +		}
> +		dmac->sdesc = NULL;
> +		ingenic_dma_start_trans(dmac);
> +	} else {
> +		dev_warn(&dmac->vc.chan.dev->device,
> +			"channel irq with no active transfer, channel stop\n");
> +	}
> +
> +	spin_unlock(&dmac->vc.lock);
> +}
> +
> +static irqreturn_t pdma_int_handler(int irq, void *dev)
> +{
> +	struct ingenic_dma_engine *ingenic_dma = (struct ingenic_dma_engine *)dev;
> +	unsigned long pending, dmac;
> +	int i;
> +
> +	pending = readl(ingenic_dma->iomem + DIRQP);
> +	writel(~pending, ingenic_dma->iomem + DIRQP);
> +
> +	for (i = 0; i < ingenic_dma->nr_chs ; i++) {
> +		if (!(pending & (1 << i)))
> +			continue;
> +		pdma_handle_chan_irq(ingenic_dma, i);
> +	}
> +
> +	dmac = readl(ingenic_dma->iomem + DMAC);
> +	dmac &= ~(DMAC_HLT | DMAC_AR);
> +	writel(dmac, ingenic_dma->iomem + DMAC);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t pdmam_int_handler(int irq, void *dev)
> +{
> +	/*TODO*/
> +	return IRQ_HANDLED;

???


> +}
> +
> +static irqreturn_t pdmad_int_handler(int irq, void *dev)
> +{
> +	struct ingenic_dma_engine *ingenic_dma = (struct ingenic_dma_engine *)dev;
> +	unsigned long pending;
> +	int i;
> +
> +	pending = readl(ingenic_dma->iomem + DIP);
> +	writel(readl(ingenic_dma->iomem + DIP) & (~pending), ingenic_dma->iomem + DIC);
> +
> +	for (i = 0; i < ingenic_dma->nr_chs; i++) {
> +		struct ingenic_dma_chan *dmac = ingenic_dma->chan[i];
> +		struct ingenic_dma_sdesc *sdesc;
> +
> +		if (!(pending & (1 << i)))
> +			continue;
> +		sdesc = dmac->sdesc;
> +		if (sdesc && sdesc->cyclic) {
> +			spin_lock(&dmac->vc.lock);
> +			vchan_cyclic_callback(&sdesc->vd);
> +			spin_unlock(&dmac->vc.lock);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ingenic_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
> +
> +	dmac->hdesc_pool = dma_pool_create(dev_name(&chan->dev->device),
> +			chan->device->dev, sizeof(struct hdma_desc), 0, PAGE_SIZE);
> +	if (!dmac->hdesc_pool) {
> +		dev_err(&chan->dev->device,
> +				"failed to allocate descriptor pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	dmac->hdesc_max = PAGE_SIZE / sizeof(struct hdma_desc);
> +	dmac->hdesc_num = 0;
> +
> +	return 0;
> +}
> +
> +static void ingenic_dma_synchronize(struct dma_chan *chan)
> +{
> +	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
> +
> +	vchan_synchronize(&dmac->vc);
> +}
> +
> +static void ingenic_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
> +	unsigned long flags;
> +
> +	ingenic_dma_terminate_all(chan);
> +
> +	ingenic_dma_wait_terminate_complete(chan);
> +
> +	dma_pool_destroy(dmac->hdesc_pool);
> +	spin_lock_irqsave(&dmac->hdesc_lock, flags);
> +	dmac->hdesc_pool = NULL;
> +	dmac->hdesc_max = 0;
> +	dmac->hdesc_num = 0;
> +	spin_unlock_irqrestore(&dmac->hdesc_lock, flags);
> +}
> +
> +static bool ingenic_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
> +	unsigned int private          = *(unsigned int *)param;
> +	unsigned long type             = (unsigned long)chan->private;

Fix your indentation.



...

> +
> +static int __init ingenic_dma_probe(struct platform_device *pdev)

Since when probe is an __init?

> +{
> +	struct ingenic_dma_engine *dma = NULL;
> +	struct resource *iores;
> +	u32 reg_dmac = DMAC_DMAE;
> +	int i, ret = 0;
> +
> +	/* check of first. if of failed, use platform */
> +
> +	dma = ingenic_dma_parse_dt(pdev);
> +	if (IS_ERR(dma))
> +		return PTR_ERR(dma);
> +
> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dma->iomem = devm_ioremap_resource(&pdev->dev, iores);

Use helper combining these two.

> +	if (IS_ERR(dma->iomem))
> +		return PTR_ERR(dma->iomem);
> +
> +	/* PDMA interrupt*/
> +	dma->irq_pdma = platform_get_irq_byname(pdev, "pdma");
> +	if (dma->irq_pdma < 0)
> +		return dma->irq_pdma;
> +
> +	ret = devm_request_irq(&pdev->dev, dma->irq_pdma, pdma_int_handler,
> +			0, "pdma", dma);
> +	if (ret)
> +		return ret;
> +
> +	/* PDMA mcu interrupt*/
> +	dma->irq_pdmam = platform_get_irq_byname(pdev, "pdmam");
> +	if (dma->irq_pdmam >= 0) {
> +		ret = devm_request_irq(&pdev->dev, dma->irq_pdmam, pdmam_int_handler,
> +				0, "pdmam", dma);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* PDMA descriptor interrupt */
> +	if (HWATTR_DESC_INTER_SUP(dma->hwattr)) {
> +		dma->irq_pdmad = platform_get_irq_byname(pdev, "pdmad");

Not really, you said you have only one interrupt.

> +		if (dma->irq_pdmad < 0) {
> +			dev_err(&pdev->dev, "unable to get pdmad irq\n");
> +			return dma->irq_pdmad;
> +		}
> +		ret = devm_request_irq(&pdev->dev, dma->irq_pdmad, pdmad_int_handler,
> +				0, "pdmad", dma);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Initialize dma engine */
> +	INIT_LIST_HEAD(&dma->dma_device.channels);
> +	for (i = 0; i < dma->nr_chs; i++) {
> +		/*reserved one channel for intc interrupt*/
> +		if (dma->intc_ch == i)
> +			continue;
> +		ingenic_dma_chan_init(dma, i);
> +	}
> +
> +	dma_cap_set(DMA_MEMCPY, dma->dma_device.cap_mask);
> +	dma_cap_set(DMA_SLAVE, dma->dma_device.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, dma->dma_device.cap_mask);
> +
> +	dma->dma_device.dev                         = &pdev->dev;
> +	dma->dma_device.device_alloc_chan_resources = ingenic_dma_alloc_chan_resources;
> +	dma->dma_device.device_free_chan_resources  = ingenic_dma_free_chan_resources;
> +	dma->dma_device.device_tx_status            = ingenic_dma_tx_status;
> +	dma->dma_device.device_prep_slave_sg        = ingenic_dma_prep_slave_sg;
> +	dma->dma_device.device_prep_dma_cyclic      = ingenic_dma_prep_dma_cyclic;
> +	dma->dma_device.device_prep_dma_memcpy      = ingenic_dma_prep_dma_memcpy;
> +	dma->dma_device.device_config               = ingenic_dma_config;
> +	dma->dma_device.device_terminate_all        = ingenic_dma_terminate_all;
> +	dma->dma_device.device_issue_pending        = ingenic_dma_issue_pending;
> +	dma->dma_device.device_synchronize          = ingenic_dma_synchronize;
> +	dma->dma_device.copy_align                  = DMAENGINE_ALIGN_4_BYTES;
> +	dma->dma_device.src_addr_widths             = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +							BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +								BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +	dma->dma_device.dst_addr_widths             = dma->dma_device.src_addr_widths;
> +	dma->dma_device.directions                  = BIT(DMA_DEV_TO_MEM) |
> +							BIT(DMA_MEM_TO_DEV) |
> +								BIT(DMA_MEM_TO_MEM);
> +	dma->dma_device.residue_granularity         = DMA_RESIDUE_GRANULARITY_BURST;
> +	dma->dma_device.dev->dma_parms              = &dma->dma_parms;
> +
> +	dma_set_max_seg_size(dma->dma_device.dev, DTC_TC_MSK);	/*At least*/
> +
> +	dma->gate_clk = devm_clk_get(&pdev->dev, "gate_pdma");
> +	if (IS_ERR(dma->gate_clk))
> +		return PTR_ERR(dma->gate_clk);
> +
> +	ret = dma_async_device_register(&dma->dma_device);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to register\n");
> +		clk_disable(dma->gate_clk);
> +		return ret;
> +	}
> +
> +	of_ingenic_dma_info.dma_cap = dma->dma_device.cap_mask;
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +			of_dma_simple_xlate, &of_ingenic_dma_info);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to register dma to device tree\n");
> +		dma_async_device_unregister(&dma->dma_device);
> +		clk_disable(dma->gate_clk);
> +		return ret;
> +	}
> +
> +
> +	platform_set_drvdata(pdev, dma);
> +
> +	/*enable pdma controller*/
> +	clk_prepare_enable(dma->gate_clk);
> +
> +	if (dma->chan_programed)
> +		writel(dma->chan_programed, dma->iomem + DMACP);
> +	if (dma->intc_ch >= 0)
> +		reg_dmac |= DMAC_INTCE | ((dma->intc_ch << DMAC_INTCC_SFT) & DMAC_INTCC_MSK);
> +	if (dma->special_ch)
> +		reg_dmac |= DMAC_CH01;
> +	writel(reg_dmac, dma->iomem + DMAC);
> +
> +	dev_info(dma->dev, "INGENIC SoC DMA initialized\n");

Drop simple success prints, useless.

> +
> +	return 0;
> +}
> +
> +static int ingenic_dma_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct ingenic_dma_engine *ingenic_dma = platform_get_drvdata(pdev);
> +	struct dma_chan *chan;
> +
> +	list_for_each_entry(chan, &ingenic_dma->dma_device.channels, device_node) {
> +		struct ingenic_dma_chan *dmac = to_ingenic_dma_chan(chan);
> +
> +		if (dmac->sdesc)
> +			return -EBUSY;
> +	}
> +	clk_disable_unprepare(ingenic_dma->gate_clk);
> +
> +	return 0;
> +}
> +
> +static int ingenic_dma_resume(struct platform_device *pdev)
> +{
> +	struct ingenic_dma_engine *ingenic_dma = platform_get_drvdata(pdev);
> +
> +	clk_prepare_enable(ingenic_dma->gate_clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ingenic_dma_dt_match[] = {
> +	{ .compatible = "ingenic,m200-pdma",  .data = (void *)(HWATTR_SPECIAL_CH01 |
> +							HWATTR_INTC_IRQ)},
> +	{ .compatible = "ingenic,x1000-pdma", .data = (void *)HWATTR_DESC_INTER },
> +	{ .compatible = "ingenic,t40-pdma",   .data = (void *)HWATTR_INTC_IRQ },
> +	/*{ .compatible = "ingenic,t41-pdma",   .data = (void *)HWATTR_INTC_IRQ },*/

This is a mess...

> +	{ .compatible = "ingenic,t33-pdma",   .data = (void *)NULL },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ingenic_dma_dt_match);
> +
> +static struct platform_driver ingenic_dma_driver = {
> +	.driver = {
> +		.name           = "ingenic-dma",
> +		.owner          = THIS_MODULE,

Come on... that's like 7 year or 10 year old code. Please don't dump on
us such old stuff, but clean it up before posting.

Run coccinelle/coccicheck and fix all the issues. Then run smatch. Then
run sparse.

> +		.of_match_table = of_match_ptr(ingenic_dma_dt_match),

Drop of_match_ptr

> +	},
> +	.suspend = ingenic_dma_suspend,
> +	.resume  = ingenic_dma_resume,
> +};
> +
> +static int __init ingenic_dma_module_init(void)
> +{
> +	return platform_driver_probe(&ingenic_dma_driver, ingenic_dma_probe);
> +}
> +
> +subsys_initcall(ingenic_dma_module_init);
> +MODULE_AUTHOR("Chen.li <chen.li@ingenic.cn>");
> +MODULE_DESCRIPTION("Ingenic dma driver");


...

> +
> +static inline struct ingenic_dma_chan *to_ingenic_dma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct ingenic_dma_chan, vc.chan);
> +}
> +
> +static inline struct ingenic_dma_sdesc *to_ingenic_dma_sdesc(struct virt_dma_desc *vd)
> +{
> +	return container_of(vd, struct ingenic_dma_sdesc, vd);
> +}
> +
> +#define INGENIC_DMA_REQ_AUTO 0xff
> +#define INGENIC_DMA_CHAN_CNT 32
> +unsigned long pdma_maps[INGENIC_DMA_CHAN_CNT] = {

This cannot be in the header.

> +	INGENIC_DMA_REQ_AUTO,
> +	INGENIC_DMA_REQ_AUTO,
> +	INGENIC_DMA_REQ_AIC_LOOP_RX,
> +	INGENIC_DMA_REQ_AIC_TX,
> +	INGENIC_DMA_REQ_AIC_F_RX,
> +	INGENIC_DMA_REQ_AUTO_TX,
> +	INGENIC_DMA_REQ_SADC_RX,
> +	INGENIC_DMA_REQ_UART5_TX,
> +	INGENIC_DMA_REQ_UART5_RX,
> +	INGENIC_DMA_REQ_UART4_TX,
> +	INGENIC_DMA_REQ_UART4_RX,
> +	INGENIC_DMA_REQ_UART3_TX,
> +	INGENIC_DMA_REQ_UART3_RX,
> +	INGENIC_DMA_REQ_UART2_TX,
> +	INGENIC_DMA_REQ_UART2_RX,
> +	INGENIC_DMA_REQ_UART1_TX,
> +	INGENIC_DMA_REQ_UART1_RX,
> +	INGENIC_DMA_REQ_UART0_TX,
> +	INGENIC_DMA_REQ_UART0_RX,
> +	INGENIC_DMA_REQ_SSI0_TX,
> +	INGENIC_DMA_REQ_SSI0_RX,
> +	INGENIC_DMA_REQ_SSI1_TX,
> +	INGENIC_DMA_REQ_SSI1_RX,
> +	INGENIC_DMA_REQ_SLV_TX,
> +	INGENIC_DMA_REQ_SLV_RX,
> +	INGENIC_DMA_REQ_I2C0_TX,
> +	INGENIC_DMA_REQ_I2C0_RX,
> +	INGENIC_DMA_REQ_I2C1_TX,
> +	INGENIC_DMA_REQ_I2C1_RX,
> +	INGENIC_DMA_REQ_DES_TX,
> +	INGENIC_DMA_REQ_DES_RX,
> +};
> +
> +void jzdma_dump(struct dma_chan *chan);

Drop

> +#endif /*__INGENIC_DMA_H__*/

Best regards,
Krzysztof


