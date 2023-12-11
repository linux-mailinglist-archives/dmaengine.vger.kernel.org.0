Return-Path: <dmaengine+bounces-441-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823980C8D7
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 13:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F811B21401
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE738FA1;
	Mon, 11 Dec 2023 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdoPj2K2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1EB38FA0
	for <dmaengine@vger.kernel.org>; Mon, 11 Dec 2023 12:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DC0C433C8;
	Mon, 11 Dec 2023 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702296099;
	bh=oCr5WivpKHnBfuV05fpWq2BCfxH42ssUJX2KXJJzi2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdoPj2K21OzXKLz2Sa5CGfHq6A/EDzr2G1ZE31IeG9Ec8+9XpMdWmmDZEysg1zZAo
	 0TBXLWYhr1dAOEc3ZJ6i533NEDrEFnuINndFDAE776FXRbQqrvBA0xGPe+i1Jt2lO7
	 gGJQgmJAWmLaCvlCrcGBTqjViaT/YMeyuBYYM7OVnsNYnLw97OxcSMztWkndp2oJW2
	 JksAUOY2mQ2w3vPAnuOh4VL9XBU8J4Jr//FBP26hEB5lLbXxw0I8MSFbdB4vqI/MFs
	 Fs+Fm/QcaOylvzTOpQkDHXp/JcnJlp33+AzIX4eqIiBKCkJQPb+FFex2e1PBz/G2KT
	 LJBpmziPF0emw==
Date: Mon, 11 Dec 2023 17:31:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: axi-dmac: Use only EOT interrupts when
 doing scatter-gather
Message-ID: <ZXb6FE5Z1zcmRFKO@matsya>
References: <20231204140352.30420-1-paul@crapouillou.net>
 <20231204140352.30420-5-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204140352.30420-5-paul@crapouillou.net>

On 04-12-23, 15:03, Paul Cercueil wrote:
> Instead of notifying userspace in the end-of-transfer (EOT) interrupt
> and program the hardware in the start-of-transfer (SOT) interrupt, we
> can do both things in the EOT, allowing us to mask the SOT, and halve
> the number of interrupts sent by the HDL core.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-axi-dmac.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 5109530b66de..beed91a8238c 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -415,6 +415,7 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
>  			list_del(&active->vdesc.node);
>  			vchan_cookie_complete(&active->vdesc);
>  			active = axi_dmac_active_desc(chan);
> +			start_next = !!active;

Should this be in current patch, sounds like this should be a different
patch?

>  		}
>  	} else {
>  		do {
> @@ -1000,6 +1001,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	struct axi_dmac *dmac;
>  	struct regmap *regmap;
>  	unsigned int version;
> +	u32 irq_mask = 0;
>  	int ret;
>  
>  	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> @@ -1067,7 +1069,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  
>  	dma_dev->copy_align = (dmac->chan.address_align_mask + 1);
>  
> -	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
> +	if (dmac->chan.hw_sg)
> +		irq_mask |= AXI_DMAC_IRQ_SOT;
> +
> +	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, irq_mask);
>  
>  	if (of_dma_is_coherent(pdev->dev.of_node)) {
>  		ret = axi_dmac_read(dmac, AXI_DMAC_REG_COHERENCY_DESC);
> -- 
> 2.42.0
> 

-- 
~Vinod

