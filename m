Return-Path: <dmaengine+bounces-1464-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ACA8855D7
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 09:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6F2281DBD
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F712B81;
	Thu, 21 Mar 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VHtHIZkk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6AF519
	for <dmaengine@vger.kernel.org>; Thu, 21 Mar 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010248; cv=none; b=Zrz2PZEUjVgOOkbKgMGWqzvc8G8otSVehul7nuX9iu0WwzR/8rp4nsc9JCAeUBcweP+7zbZ28HHBnWOXeOlnAcSS4SNRG7WkCoxNDUU+kan2WydtUxIKgNEu6vWoVFh0RQBhKzLbVYOPHguO7UKu4uVfBLczCLI0tddt7r8MuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010248; c=relaxed/simple;
	bh=PAw9lHqYDnapYYW64NJkyIltJxb0RSurl0mSUrSxLPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+SBkaIJXybSjzE88chmlLcZOYlYgZ50yUWZfyNF3xSYioB5+Zg5I0lKV/JOaeUUTyGiVOvTt0AEzDSDlDYttpeYkXe84+Cp3TJMIQX7rYS/onhkm9ygaKhWrgztZsVKdMR4FoXYU4Tp1GbLEVu8bdb+lA/ZsmVCjxfF+d5zJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VHtHIZkk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso641870a12.2
        for <dmaengine@vger.kernel.org>; Thu, 21 Mar 2024 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711010244; x=1711615044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1LJdX5HINEABbkAABFqbmX72U+4J6Fq5DjsUiL3/oFM=;
        b=VHtHIZkkhdTTZ2S9U/5X+TbePY8bLO/rZ12zSf2VbHpJ7bVBExUFpiljsh4A/Q+V9g
         LbtLpncBWzuvj7sGYk4L9sm/WHF9PGZI00oSKvC+tk+wAeE3VxSXSJvyKkRkfsD3ZOVL
         rmY2rV49uVdW+kYSFRrqo3eTYGbdDgvP8QbXM1KXFKgB2I/bREh0Q+Tufvk5A1iqgAqL
         nDA4/o9L1ts0mqbLqGVoyRxcHiypb27uZ7RDiLYEy80FXobj+1OipWsr2zF2b8CUhQpK
         kPTh/WftpFUzAzikORwHDxlbi1ou/mUSJlpmJkU6TuFre86vFXsneck3pGWCM/GMpA+u
         FfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711010244; x=1711615044;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LJdX5HINEABbkAABFqbmX72U+4J6Fq5DjsUiL3/oFM=;
        b=mnsJMqdC3F0PCHyyQX5qaMKryFDHJHFnA8gZkKXseUP/qFA1eVhGjBkibA6v1cOGEw
         GJgDNn4pCRj8jzxepWJZN3yoizkH+45hN7gOPop61SbdL46gR1OcU7RBEyFBUpTQvWt0
         4V0aV9dM67+aiKEqzHLZaoQ3fprGhp+LGLD3dTTNW0G1le6qSkmzk1CKWnrI4o74NqUh
         j7hcriR1XCPGFo9dxJUbDllABEjdcw7J06O5iH0LlmLmRPXdjow0hBTAcfsaovWmutXx
         20uF8hdJWrJTPAhykAGajz5zh0O2P5drWi3cUts7Ws0Imt8zbimjGKzIk0WrHYySs2r0
         D2cA==
X-Forwarded-Encrypted: i=1; AJvYcCX6P+50uMZn6a+1uYFBGKg7wM0pF2RcJ5LKulwz1oQ/2uYXjSj4yfqlR9xnKX4vyd+8tC44YydTULUKclIAN3tICkHty4J3Pvld
X-Gm-Message-State: AOJu0Yy842onvUaiS4rt9XJpKrH5DFNnNxeCuS7tGqqiL7c0AGrH2QV9
	eSnguGIVBZB9ZwXIK9mhaaDK4QZTkCT9YrAV5AkFbvr+hZPQFdMyNPATquDq8AQ=
X-Google-Smtp-Source: AGHT+IG6zJglxzpL3+82jfITASQmJOCWIwdnfUuLTIM2+eo2I1Az4z278xjCcrw8ML8UvOyNmRBQwA==
X-Received: by 2002:a17:906:c411:b0:a46:635b:bb3e with SMTP id u17-20020a170906c41100b00a46635bbb3emr11536587ejz.52.1711010244441;
        Thu, 21 Mar 2024 01:37:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id la10-20020a170906ad8a00b00a46ee3c31afsm1951096ejb.154.2024.03.21.01.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:37:23 -0700 (PDT)
Message-ID: <2528ae13-a84e-484c-bcf1-278025394c49@linaro.org>
Date: Thu, 21 Mar 2024 09:37:21 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: ingenic: add Ingenic PDMA controller
 support.
To: bin.yao@ingenic.com, vkoul@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 1587636487@qq.com
References: <20240321080228.24147-1-bin.yao@ingenic.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321080228.24147-1-bin.yao@ingenic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 09:02, bin.yao@ingenic.com wrote:
> From: "bin.yao" <bin.yao@ingenic.com>
> 
> This module can be found on ingenic victory soc.
> 
> Signed-off-by: bin.yao <bin.yao@ingenic.com>
> ---
>  drivers/dma/Kconfig        |    6 +
>  drivers/dma/Makefile       |    1 +
>  drivers/dma/ingenic-pdma.c | 1356 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1363 insertions(+)
>  create mode 100644 drivers/dma/ingenic-pdma.c

...

> +static int ingenic_dma_chan_init(struct ingenic_dma_engine *dma, int id)
> +{
> +	struct ingenic_dma_chan *dmac = NULL;
> +
> +	if ((id < 0) || (id >= INGENIC_DMA_CHAN_CNT))
> +		return -EINVAL;
> +
> +	dmac = devm_kzalloc(dma->dev, sizeof(*dmac), GFP_KERNEL);
> +	if (!dmac)
> +		return -ENOMEM;
> +
> +	dmac->id = id;
> +	dmac->iomem = dma->iomem + dmac->id * DMACH_OFF;
> +	dmac->engine = dma;
> +
> +	spin_lock_init(&dmac->hdesc_lock);
> +	init_completion(&dmac->completion);
> +
> +	dmac->slave_id = pdma_maps[id] & INGENIC_DMA_TYPE_REQ_MSK;
> +	dma->chan[id] = dmac;
> +	INIT_LIST_HEAD(&dmac->ingenic_dma_sdesc_list_submitted);
> +	INIT_LIST_HEAD(&dmac->ingenic_dma_sdesc_list_issued);
> +
> +	dma_cookie_init(&dmac->chan);
> +	dmac->chan.device = &dma->dma_device;
> +	dmac->working_sdesc = NULL;
> +	list_add_tail(&dmac->chan.device_node, &dma->dma_device.channels);
> +	tasklet_init(&dmac->task, ingenic_dma_complete, (unsigned long)dmac);
> +
> +	return 0;
> +}
> +
> +static int ingenic_dma_probe(struct platform_device *pdev)
> +{
> +	struct ingenic_dma_engine *ingenic_dma = NULL;
> +	unsigned int reg_dmac = DMAC_DMAE;
> +	struct device *dev = &pdev->dev;
> +	struct resource *iores;
> +	int i, ret = 0;
> +
> +	if (!dev->of_node) {
> +		dev_err(dev, "This driver must be probed from devicetree\n");

This driver cannot be probed other way. Drop.

> +		return -EINVAL;
> +	}
> +
> +	ingenic_dma = devm_kzalloc(&pdev->dev, sizeof(struct ingenic_dma_engine),

ssizeof(*(

> +				   GFP_KERNEL);
> +	if (!ingenic_dma)
> +		return -ENOMEM;
> +
> +	ingenic_dma->dma_data = (struct ingenic_dma_data *)device_get_match_data(dev);

Why the cast?

> +	if (!ingenic_dma->dma_data)
> +		return -EINVAL;
> +
> +	/*
> +	 * Obtaining parameters from the device tree.
> +	 */

Drop obvious comments.

> +	ingenic_dma->dev = dev;
> +	if (!of_property_read_u32(pdev->dev.of_node, "programed-chs",

No, there is no such property. NAK.

Upstream your DTS or I will be NAKing your patches. Because otherwise
you try to sneak a lot of undocumented stuff here.

> +				  &ingenic_dma->chan_programed))
> +		ingenic_dma->chan_reserved |= ingenic_dma->chan_programed;
> +
> +	if (HWATTR_SPECIAL_CH01_SUP(ingenic_dma->dma_data->hwattr) &&
> +	    of_property_read_bool(pdev->dev.of_node, "special-chs")) {
> +		ingenic_dma->chan_reserved  |= DMA_SPECAIL_CHS;
> +		ingenic_dma->chan_programed |= DMA_SPECAIL_CHS;
> +		ingenic_dma->special_ch = true;
> +	}
> +
> +	ingenic_dma->intc_ch = -1;
> +	if (HWATTR_INTC_IRQ_SUP(ingenic_dma->dma_data->hwattr) &&
> +	    !of_property_read_u32(pdev->dev.of_node, "intc-ch",
> +				  &ingenic_dma->intc_ch)) {
> +
> +		if (BIT(ingenic_dma->intc_ch) & ingenic_dma->chan_reserved)
> +			dev_warn(ingenic_dma->dev,
> +				 "intc irq channel %d is already reserved\n",
> +				 ingenic_dma->intc_ch);
> +
> +		ingenic_dma->chan_reserved |= BIT(ingenic_dma->intc_ch);
> +	}
> +
> +	/*
> +	 * obtaining the base address of the DMA peripheral.
> +	 */

Drop obvious comments.

> +	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (iores) {
> +		ingenic_dma->iomem = devm_ioremap_resource(&pdev->dev, iores);

Combine these two, there's helper for this.

> +		if (IS_ERR(ingenic_dma->iomem))
> +			return PTR_ERR(ingenic_dma->iomem);
> +	} else {
> +		dev_err(dev, "Failed to get I/O memory\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Get PDMA interrupt.
> +	 */

Drop

> +	ingenic_dma->irq_pdma = platform_get_irq_byname(pdev, "pdma");
> +	if (ingenic_dma->irq_pdma < 0) {
> +		dev_err(dev, "Unable to get pdma irq\n");
> +		return ingenic_dma->irq_pdma;

Syntax is return dev_err_probe().

> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, ingenic_dma->irq_pdma,
> +			       pdma_int_handler, 0, "pdma", ingenic_dma);
> +	if (ret) {
> +		dev_err(dev, "Failed to request pdma irq\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Get PDMA descriptor interrupt.
> +	 */
> +	if (HWATTR_DESC_INTER_SUP(ingenic_dma->dma_data->hwattr)) {
> +		ingenic_dma->irq_pdmad = platform_get_irq_byname(pdev, "pdmad");

NAK, you must be joking. You do not have second interrupt.

You must clean your code before upstream from all downstream weirdness
and incorrectness. You cannot send different binding than driver.

What's more, I don't trust that you will send usable binding, judging by
the driver, so I expect to see upstreamed DTS.

> +		if (ingenic_dma->irq_pdmad < 0) {
> +			dev_err(&pdev->dev, "Unable to get pdmad irq\n");
> +			return ingenic_dma->irq_pdmad;
> +		}
> +		ret = devm_request_irq(&pdev->dev, ingenic_dma->irq_pdmad,
> +				       pdmad_int_handler, 0, "pdmad", ingenic_dma);
> +		if (ret) {
> +			dev_err(dev, "Failed to request pdmad irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Initialize dma channel.
> +	 */
> +	INIT_LIST_HEAD(&ingenic_dma->dma_device.channels);
> +	for (i = 0; i < ingenic_dma->dma_data->nb_channels; i++) {
> +		/*reserved one channel for intc interrupt*/
> +		if (ingenic_dma->intc_ch == i)
> +			continue;
> +		ingenic_dma_chan_init(ingenic_dma, i);
> +	}
> +
> +	dma_cap_set(DMA_MEMCPY, ingenic_dma->dma_device.cap_mask);
> +	dma_cap_set(DMA_SLAVE, ingenic_dma->dma_device.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, ingenic_dma->dma_device.cap_mask);
> +
> +	ingenic_dma->dma_device.dev = &pdev->dev;
> +	ingenic_dma->dma_device.device_alloc_chan_resources = ingenic_dma_alloc_chan_resources;
> +	ingenic_dma->dma_device.device_free_chan_resources = ingenic_dma_free_chan_resources;
> +	ingenic_dma->dma_device.device_tx_status = ingenic_dma_tx_status;
> +	ingenic_dma->dma_device.device_prep_slave_sg = ingenic_dma_prep_slave_sg;
> +	ingenic_dma->dma_device.device_prep_dma_cyclic = ingenic_dma_prep_dma_cyclic;
> +	ingenic_dma->dma_device.device_prep_dma_memcpy = ingenic_dma_prep_dma_memcpy;
> +	ingenic_dma->dma_device.device_config = ingenic_dma_config;
> +	ingenic_dma->dma_device.device_terminate_all = ingenic_dma_terminate_all;
> +	ingenic_dma->dma_device.device_issue_pending = ingenic_dma_issue_pending;
> +	ingenic_dma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
> +	ingenic_dma->dma_device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +	ingenic_dma->dma_device.dst_addr_widths = ingenic_dma->dma_device.src_addr_widths;
> +	ingenic_dma->dma_device.directions = BIT(DMA_DEV_TO_MEM) |
> +					     BIT(DMA_MEM_TO_DEV) |
> +					     BIT(DMA_MEM_TO_MEM);
> +	ingenic_dma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +
> +	dma_set_max_seg_size(ingenic_dma->dma_device.dev, DTC_TC_MSK);
> +
> +	ingenic_dma->gate_clk = devm_clk_get(&pdev->dev, "gate_pdma");
> +	if (IS_ERR(ingenic_dma->gate_clk))
> +		return PTR_ERR(ingenic_dma->gate_clk);
> +
> +	ret = dma_async_device_register(&ingenic_dma->dma_device);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to register dma\n");
> +		clk_disable(ingenic_dma->gate_clk);
> +		return ret;
> +	}
> +
> +	of_ingenic_dma_info.dma_cap = ingenic_dma->dma_device.cap_mask;
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 of_dma_simple_xlate,
> +					 &of_ingenic_dma_info);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to register dma to device tree\n");
> +		dma_async_device_unregister(&ingenic_dma->dma_device);
> +		clk_disable(ingenic_dma->gate_clk);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, ingenic_dma);
> +
> +	clk_prepare_enable(ingenic_dma->gate_clk);
> +
> +	if (ingenic_dma->chan_programed)
> +		writel(ingenic_dma->chan_programed, ingenic_dma->iomem + DMACP);
> +	if (ingenic_dma->intc_ch >= 0)
> +		reg_dmac |= DMAC_INTCE |
> +			    ((ingenic_dma->intc_ch << DMAC_INTCC_SFT) & DMAC_INTCC_MSK);
> +	if (ingenic_dma->special_ch)
> +		reg_dmac |= DMAC_CH01;
> +	writel(reg_dmac, ingenic_dma->iomem + DMAC);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ingenic_dma_suspend(struct device *dev)
> +{
> +	struct ingenic_dma_engine *ingenic_dma = dev_get_drvdata(dev);
> +	struct ingenic_dma_chan *dmac;
> +	unsigned long flg;
> +	int i;
> +
> +	for (i = 0; i < ingenic_dma->dma_data->nb_channels; i++) {
> +		dmac = ingenic_dma->chan[i];
> +		spin_lock_irqsave(&dmac->hdesc_lock, flg);
> +		if (!list_empty(&dmac->ingenic_dma_sdesc_list_submitted)) {
> +			spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
> +			return -EBUSY;
> +		}
> +		if (!list_empty(&dmac->ingenic_dma_sdesc_list_issued)) {
> +			spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
> +			return -EBUSY;
> +		}
> +		spin_unlock_irqrestore(&dmac->hdesc_lock, flg);
> +	}
> +	clk_disable_unprepare(ingenic_dma->gate_clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ingenic_dma_resume(struct device *dev)
> +{
> +	struct ingenic_dma_engine *ingenic_dma = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(ingenic_dma->gate_clk);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ingenic_dma_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(ingenic_dma_suspend, ingenic_dma_resume)
> +};
> +
> +static const struct ingenic_dma_data t33_soc_data = {
> +	.nb_channels = 32,
> +};
> +
> +static const struct of_device_id ingenic_dma_dt_match[] = {
> +	{ .compatible = "ingenic,t33-pdma",   .data = &t33_soc_data },

Don't merge lines. Open existing code and look how it is done there.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ingenic_dma_dt_match);
> +
> +static struct platform_driver ingenic_dma_driver = {
> +	.probe			= ingenic_dma_probe,
> +	.driver = {
> +		.name		= "ingenic-dma",
> +		.of_match_table = ingenic_dma_dt_match,
> +		.pm		= &ingenic_dma_dev_pm_ops,
> +	},
> +};
> +
> +static int __init ingenic_dma_init(void)
> +{
> +	return platform_driver_register(&ingenic_dma_driver);
> +}
> +subsys_initcall(ingenic_dma_init);
> +
> +static void __exit ingenic_dma_exit(void)
> +{
> +	platform_driver_unregister(&ingenic_dma_driver);
> +}
> +module_exit(ingenic_dma_exit);
> +
> +MODULE_AUTHOR("bin.yao <bin.yao@ingenic.com>");
> +MODULE_DESCRIPTION("Ingenic dma driver");

Why do you add second Ingenic dma driver? That's duplication.

Best regards,
Krzysztof


