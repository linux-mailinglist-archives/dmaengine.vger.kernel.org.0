Return-Path: <dmaengine+bounces-7188-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E12C627BF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 07:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCFE3A6185
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8F30F812;
	Mon, 17 Nov 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8v0/MGP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568C28695;
	Mon, 17 Nov 2025 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763360020; cv=none; b=Jq4msBMhtHfqG/CdpsTeTdiORYH3JgLX/c0h7qvjprfd+aWw0Nk41gWucrn5kE8HA35g+Fq0uznCRth4tDreZQufcqgie4mkwxYTiitk91AYMqTG4ZyN1/WTFn6+mR0nJ6uELZvH5dASj0aGcKtfh/89HNOBokqvZ6aUniSc6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763360020; c=relaxed/simple;
	bh=WozaX26Br/hJkf7juysZBW8xkHyrBSYtURe8aeOGYVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqyGrcbIq3rcmEPcj30HB28YntMaJkfGdiC5DiHuPOMFyWa6qO/yiVPQ6D6DZsWRPQFZCXfVMZc0Fb3yZ79Ny5asGWcz6NrhOZwKNYE8dfnpMq08DLhcva03OdVqVCwqDwyQ9Hoi3VV76z7WxtKjzbcdhhw4iHm+0W5Rdpjc69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8v0/MGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA842C19424;
	Mon, 17 Nov 2025 06:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763360020;
	bh=WozaX26Br/hJkf7juysZBW8xkHyrBSYtURe8aeOGYVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m8v0/MGPo4Y/cS0KZADeGDwcKNWrYxfH5C68XuEapIplOal5ymCTj2FW9qzpWIfXM
	 0Q0vccmV92wGN26mvVPtVgcG+qwAgTKsC3VNlIvyEqSL8RSPxl4TaE9iC3fEOe8MA2
	 KRRDbZGdm0WUNrk12SR6Vt2DT0+FAK7dNWflq4iJC6AqcV2bup3iqOvXgqfxxwZXaP
	 1naVQRQm4DxXmCw8vZN4sf1B+u84z644O3ohcBZCH/6dE04RA3SPcX90fz8fRpSZD0
	 SPFSGU3PKvNC2iehI/1KZJQb3L4JXQktSNum6Ggwz7IAkxBlKuhdr6dwoBiAEKzjG+
	 lSI+wXju9+pyg==
Message-ID: <eb9eae64-f414-4b04-9a10-4dd8a9088e96@kernel.org>
Date: Mon, 17 Nov 2025 07:13:34 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma: arm-dma350: add support for shared interrupt
 mode
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20251117015943.2858-1-jun.guo@cixtech.com>
 <20251117015943.2858-3-jun.guo@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251117015943.2858-3-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 02:59, Jun Guo wrote:
> - The arm dma350 controller's hardware implementation varies: some

That's not a list. Look at git history to learn how to write expected
commit messages.

>  designs dedicate a separate interrupt line for each channel, while
>  others have all channels sharing a single interrupt.This patch adds
>  support for the hardware design where all DMA channels share a
>  single interrupt.
> 
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>  drivers/dma/ar



> @@ -526,7 +593,7 @@ static void d350_free_chan_resources(struct dma_chan *chan)
>  static int d350_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct d350 *dmac;
> +	struct d350 *dmac = NULL;
>  	void __iomem *base;
>  	u32 reg;
>  	int ret, nchan, dw, aw, r, p;
> @@ -556,6 +623,7 @@ static int d350_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	dmac->nchan = nchan;
> +	dmac->base = base;
>  
>  	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
>  	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
> @@ -582,6 +650,26 @@ static int d350_probe(struct platform_device *pdev)
>  	dmac->dma.device_issue_pending = d350_issue_pending;
>  	INIT_LIST_HEAD(&dmac->dma.channels);
>  
> +	/* Cix Sky1 has a common host IRQ for all its channels. */
> +	if (of_device_is_compatible(pdev->dev.of_node, "cix,sky1-dma-350")) {

No, see further

> +		int host_irq = platform_get_irq(pdev, 0);
> +
> +		if (host_irq < 0)
> +			return dev_err_probe(dev, host_irq,
> +					     "Failed to get IRQ\n");
> +
> +		ret = devm_request_irq(&pdev->dev, host_irq, d350_global_irq,
> +				       IRQF_SHARED, DRIVER_NAME, dmac);
> +		if (ret)
> +			return dev_err_probe(
> +				dev, ret,
> +				"Failed to request the combined IRQ %d\n",
> +				host_irq);
> +
> +		/* Combined Non-Secure Channel Interrupt Enable */
> +		writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);
> +	}
> +
>  	/* Would be nice to have per-channel caps for this... */
>  	memset = true;
>  	for (int i = 0; i < nchan; i++) {
> @@ -595,10 +683,16 @@ static int d350_probe(struct platform_device *pdev)
>  			dev_warn(dev, "No command link support on channel %d\n", i);
>  			continue;
>  		}
> -		dch->irq = platform_get_irq(pdev, i);
> -		if (dch->irq < 0)
> -			return dev_err_probe(dev, dch->irq,
> -					     "Failed to get IRQ for channel %d\n", i);
> +
> +		if (!of_device_is_compatible(pdev->dev.of_node,
> +					     "cix,sky1-dma-350")) {

No, use driver match data for that. Sprinkling compatibles everywhere
does not scale.

Also, this is in contrary with the binding, which did not say your
device has no interrupts.


Best regards,
Krzysztof

