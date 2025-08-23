Return-Path: <dmaengine+bounces-6179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E13B32ACD
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A836E1890289
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2E2EB842;
	Sat, 23 Aug 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXzQD+JH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9E78F2F;
	Sat, 23 Aug 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965599; cv=none; b=BUI31AVjafyrcqdaV8VlDm4U8oIuxCwQ1AGgPe3PCSf7W8OAtCZhkvTI8lL9B/mBVaWyBzKntW9nQnoRPX+E0YvVkD0BiC/zG+xa+d6SoBn/PrruS97gpdm4BGsXk6rSVQV7zSeM6P7aLE2RGGBiBxvwuwMRlg2mqeEevTZ4U+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965599; c=relaxed/simple;
	bh=ZeW3RXOU2C8HuaW/Q/Dz90rTuwyjzrVLADpjszYvC1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJmEasy8lmcdXMKWv7xgQ26D/EYG8t4eFIhSehGOrqQziIjWGjBgit+FIuEeDsyWzaMReEA11NmyQhoy6bWNyzyqm0i1ETE3VPqAlR+2pyYwuPSKEh0EYiDEdX+d8J8uFBLpy6ZbG3jWaUHqFlj0BCkfzh5g2bG/u0u07xCVtW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXzQD+JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297E7C4CEE7;
	Sat, 23 Aug 2025 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755965598;
	bh=ZeW3RXOU2C8HuaW/Q/Dz90rTuwyjzrVLADpjszYvC1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eXzQD+JHWLMU00xgMRgN9cNl+cGT74Hsdz/NhBFkoFttFgacupR9Allwyt25mBwkU
	 Hg2LkyOh3BnY54dUhU7j1UhoS8Fd8aaTl2cqV74oW8Yx/3aDfAzC3SPurcRNrs1dGr
	 NedzZlufM63QkeCWBorIJzWtgapc2qovRPUn7zoHWfmhLB2yekE4OIQiq/W4zuQZgh
	 58y12DKdhoxyZPEekmbweViVD4UOyIEKstGtgImVZDZi+0MZNkpTTieeJm/ZSrWW1b
	 hHWyPTAnlGoiLjRL+sPM7Xpa7VYSJxEjat4Rdsi6WplNAD49PZ30z0Ns8sYuaCL2F4
	 xKedwPvF5gHEg==
Message-ID: <8995c33a-8ff2-4fec-8849-73f18d04a3ab@kernel.org>
Date: Sat, 23 Aug 2025 18:13:14 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] dmaengine: dma350: Support ARM DMA-250
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-15-jszhang@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250823154009.25992-15-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/2025 17:40, Jisheng Zhang wrote:
>  	struct device *dev = &pdev->dev;
> @@ -893,8 +1262,9 @@ static int d350_probe(struct platform_device *pdev)
>  	r = FIELD_GET(IIDR_VARIANT, reg);
>  	p = FIELD_GET(IIDR_REVISION, reg);
>  	if (FIELD_GET(IIDR_IMPLEMENTER, reg) != IMPLEMENTER_ARM ||
> -	    FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA350)
> -		return dev_err_probe(dev, -ENODEV, "Not a DMA-350!");
> +	    ((FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA350) &&
> +	    FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA250))
> +		return dev_err_probe(dev, -ENODEV, "Not a DMA-350/DMA-250!");
>  
>  	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG0);
>  	nchan = FIELD_GET(DMA_CFG_NUM_CHANNELS, reg) + 1;
> @@ -917,13 +1287,38 @@ static int d350_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	if (device_is_compatible(dev, "arm,dma-250")) {

No, don't sprinkle compatibles through driver code. driver match data is
for that.

> +		u32 cfg2;
> +		int secext_present;
> +
> +		dmac->is_d250 = true;
> +
> +		cfg2 = readl_relaxed(base + DMAINFO + DMA_BUILDCFG2);
> +		secext_present = (cfg2 & DMA_CFG_HAS_TZ) ? 1 : 0;
> +		dmac->cntx_mem_size = nchan * 64 * (1 + secext_present);
> +		dmac->cntx_mem = dma_alloc_coherent(dev, dmac->cntx_mem_size,
> +						    &dmac->cntx_mem_paddr,
> +						    GFP_KERNEL);
> +		if (!dmac->cntx_mem)
> +			return dev_err_probe(dev, -ENOMEM, "Failed to alloc context memory\n");
> +
> +		ret = devm_add_action_or_reset(dev, d250_cntx_mem_release, dmac);
> +		if (ret) {
> +			dma_free_coherent(dev, dmac->cntx_mem_size,
> +					  dmac->cntx_mem, dmac->cntx_mem_paddr);
> +			return ret;
> +		}
> +		writel_relaxed(dmac->cntx_mem_paddr, base + DMANSECCTRL + NSEC_CNTXBASE);
> +	}
> +
>  	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(aw));
>  	coherent = device_get_dma_attr(dev) == DEV_DMA_COHERENT;
>  
>  	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>  	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
>  
> -	dev_dbg(dev, "DMA-350 r%dp%d with %d channels, %d requests\n", r, p, dmac->nchan, dmac->nreq);
> +	dev_info(dev, "%s r%dp%d with %d channels, %d requests\n",
> +		 dmac->is_d250 ? "DMA-250" : "DMA-350", r, p, dmac->nchan, dmac->nreq);

No, don't makek drivers more verbose. Please follow Linux driver
design/coding style - this should be silent on success.

>  
>  	for (int i = min(dw, 16); i > 0; i /= 2) {
>  		dmac->dma.src_addr_widths |= BIT(i);
> @@ -935,7 +1330,10 @@ static int d350_probe(struct platform_device *pdev)
>  	dmac->dma.device_alloc_chan_resources = d350_alloc_chan_resources;
>  	dmac->dma.device_free_chan_resources = d350_free_chan_resources;
>  	dma_cap_set(DMA_MEMCPY, dmac->dma.cap_mask);
> -	dmac->dma.device_prep_dma_memcpy = d350_prep_memcpy;
> +	if (dmac->is_d250)
> +		dmac->dma.device_prep_dma_memcpy = d250_prep_memcpy;
> +	else
> +		dmac->dma.device_prep_dma_memcpy = d350_prep_memcpy;
>  	dmac->dma.device_pause = d350_pause;
>  	dmac->dma.device_resume = d350_resume;
>  	dmac->dma.device_terminate_all = d350_terminate_all;
> @@ -971,8 +1369,8 @@ static int d350_probe(struct platform_device *pdev)
>  			return dch->irq;
>  
>  		dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
> -		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
> -				FIELD_GET(CH_CFG_HAS_TRIGSEL, reg);
> +		dch->has_xsizehi = FIELD_GET(CH_CFG_HAS_XSIZEHI, reg);
> +		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg);
>  
>  		/* Fill is a special case of Wrap */
>  		memset &= dch->has_wrap;
> @@ -994,8 +1392,13 @@ static int d350_probe(struct platform_device *pdev)
>  		dma_cap_set(DMA_SLAVE, dmac->dma.cap_mask);
>  		dma_cap_set(DMA_CYCLIC, dmac->dma.cap_mask);
>  		dmac->dma.device_config = d350_slave_config;
> -		dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
> -		dmac->dma.device_prep_dma_cyclic = d350_prep_cyclic;
> +		if (dmac->is_d250) {
> +			dmac->dma.device_prep_slave_sg = d250_prep_slave_sg;
> +			dmac->dma.device_prep_dma_cyclic = d250_prep_cyclic;
> +		} else {
> +			dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
> +			dmac->dma.device_prep_dma_cyclic = d350_prep_cyclic;
> +		}
>  	}
>  
>  	if (memset) {
> @@ -1019,6 +1422,7 @@ static void d350_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id d350_of_match[] __maybe_unused = {
>  	{ .compatible = "arm,dma-350" },
> +	{ .compatible = "arm,dma-250" },

And based on that devices would be compatible...

BTW, incorrect order - 2 < 3.



Best regards,
Krzysztof

