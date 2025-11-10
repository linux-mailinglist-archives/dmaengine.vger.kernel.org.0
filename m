Return-Path: <dmaengine+bounces-7126-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B0C4764C
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 16:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3110188678B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B432E31283C;
	Mon, 10 Nov 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8PXbnaQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728B228CBC;
	Mon, 10 Nov 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787031; cv=none; b=Bobth2WbPm9hCWEQO4aJUatalDqqfcEfxIsAAvdz6Qbvh0poj2iqslvSG2KRefvyJyU5il9PYYgbzJuP4moDRthwQM/lK7sOWAduiU+hq2qf6uWJLUedjy5SfyttBLdQE1nCdSZTznjYtiXE5IwcSq2thwrY8G4kwzxwvqcHPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787031; c=relaxed/simple;
	bh=sbDuCxiH4BWmq1jNsQnpgU8AKhximrB4rxK/Jdna2kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSdYabM/VGFTQsWTb6Yyxb5X03IJp3jxBNynSqEoDySwpf53kA7tKniCVsFr/YdPyEnSJPP3IY47sEnT3YsR/pOY8+LrB+Otn3V/JxrLV8B7TISKPpW+e8GfN9zSYDkqHqp1sfdjWvTw+ji1pNr3Lj5nBX5dd09N0ISkVEXGxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8PXbnaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9B3C19425;
	Mon, 10 Nov 2025 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787031;
	bh=sbDuCxiH4BWmq1jNsQnpgU8AKhximrB4rxK/Jdna2kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8PXbnaQMWmMJIx1higvqx2H6vt9K1FdO5kEhsnasDcPZtMs5a6sbExVxrxIcq5TK
	 wTJPJZOAjz7lAWe8alVoFxMIFMZP04jkyvZizkiF9kaatFcwS5ZO4+bvM+TtvlKOvC
	 I11LXqM8yr56kRauiBRBO9ynO/qF9VIaI9/7mgfm36ydUYt9s4qinZ7qROKHAMWogc
	 iRio20p8f9Bs2x3TTycyByUCIlhh/EdayCDnE6+9FaIyj/1kXDK6oOyFM+oVt7aQgw
	 G8lnvqumVp8Bur7sr0HTcWyn8L/ZBiiD7wAGyp02AZkBEOfCbWe/czoS7jxTgNsZ61
	 shRuRsgMwLZgA==
Date: Mon, 10 Nov 2025 09:07:56 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>, 
	Thomas Andreatta <thomasandreatta2000@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Olivier Dautricourt <olivierdautricourt@gmail.com>, 
	Stefan Roese <sr@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 10/13] dmaengine: qcom: bam_dma: use
 sg_nents_for_dma() helper
Message-ID: <ibcqximr6bt7ed7eizuyhhsaqadgvuomy7qpefito26fjpiqwf@ptsxovmyt3le>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
 <20251110103805.3562136-11-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110103805.3562136-11-andriy.shevchenko@linux.intel.com>

On Mon, Nov 10, 2025 at 11:23:37AM +0100, Andy Shevchenko wrote:
> Instead of open coded variant let's use recently introduced helper.
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/qcom/bam_dma.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 2cf060174795..62b3921f0d11 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -655,22 +655,17 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  	struct scatterlist *sg;
>  	u32 i;
>  	struct bam_desc_hw *desc;
> -	unsigned int num_alloc = 0;
> -
> +	unsigned int num_alloc;
>  
>  	if (!is_slave_direction(direction)) {
>  		dev_err(bdev->dev, "invalid dma direction\n");
>  		return NULL;
>  	}
>  
> -	/* calculate number of required entries */
> -	for_each_sg(sgl, sg, sg_len, i)
> -		num_alloc += DIV_ROUND_UP(sg_dma_len(sg), BAM_FIFO_SIZE);
> -
>  	/* allocate enough room to accommodate the number of entries */
> +	num_alloc = sg_nents_for_dma(sgl, sg_len, BAM_FIFO_SIZE);
>  	async_desc = kzalloc(struct_size(async_desc, desc, num_alloc),
>  			     GFP_NOWAIT);
> -
>  	if (!async_desc)
>  		return NULL;
>  
> -- 
> 2.50.1
> 
> 

