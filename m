Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2730A206C3F
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 08:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgFXGPf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 02:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387817AbgFXGPf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 02:15:35 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225022078A;
        Wed, 24 Jun 2020 06:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592979334;
        bh=+2ifJ5qyTzzo8WHwSQDmoxhEJggCz1bEjLqjCJez3qY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8BvXRazexy8f25Y8p2nmzQZmuOsD1OjLnJBHPxcjmfE7/O/5MKS5PNKZGZ7yMwsA
         AWxbO/39muxLIQGZCjTOnM+4OD/lCYDGEJGyTAuk/ypdloPBdZAj1SJYTSb5tOm5t3
         Gn1lrqsTL6R4nCXa9PxgNPU6/qd0L14eOk8ZYvbc=
Date:   Wed, 24 Jun 2020 11:45:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA
 engine
Message-ID: <20200624061529.GF2324254@vkoul-mobl>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591697830-16311-3-git-send-email-amittomer25@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Amit,

On 09-06-20, 15:47, Amit Singh Tomar wrote:

> @@ -372,6 +383,7 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  				  struct dma_slave_config *sconfig,
>  				  bool is_cyclic)
>  {
> +	struct owl_dma *od = to_owl_dma(vchan->vc.chan.device);
>  	u32 mode, ctrlb;
>  
>  	mode = OWL_DMA_MODE_PW(0);
> @@ -427,14 +439,26 @@ static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
>  	lli->hw[OWL_DMADESC_DADDR] = dst;
>  	lli->hw[OWL_DMADESC_SRC_STRIDE] = 0;
>  	lli->hw[OWL_DMADESC_DST_STRIDE] = 0;
> -	/*
> -	 * Word starts from offset 0xC is shared between frame length
> -	 * (max frame length is 1MB) and frame count, where first 20
> -	 * bits are for frame length and rest of 12 bits are for frame
> -	 * count.
> -	 */
> -	lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
> -	lli->hw[OWL_DMADESC_CTRLB] = ctrlb;
> +
> +	if (od->devid == S700_DMA) {
> +		/* Max frame length is 1MB */
> +		lli->hw[OWL_DMADESC_FLEN] = len;
> +		/*
> +		 * On S700, word starts from offset 0x1C is shared between
> +		 * frame count and ctrlb, where first 12 bits are for frame
> +		 * count and rest of 20 bits are for ctrlb.
> +		 */
> +		lli->hw[OWL_DMADESC_CTRLB] = FCNT_VAL | ctrlb;
> +	} else {
> +		/*
> +		 * On S900, word starts from offset 0xC is shared between
> +		 * frame length (max frame length is 1MB) and frame count,
> +		 * where first 20 bits are for frame length and rest of
> +		 * 12 bits are for frame count.
> +		 */
> +		lli->hw[OWL_DMADESC_FLEN] = len | FCNT_VAL << 20;
> +		lli->hw[OWL_DMADESC_CTRLB] = ctrlb;

Unfortunately this wont scale, we will keep adding new conditions for
newer SoC's! So rather than this why not encode max frame length in
driver_data rather than S900_DMA/S700_DMA.. In future one can add values
for newer SoC and not code above logic again.

> +static const struct of_device_id owl_dma_match[] = {
> +	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
> +	{ .compatible = "actions,s700-dma", .data = (void *)S700_DMA,},

Is the .compatible documented, Documentation patch should come before
the driver use patch in a series

>  static int owl_dma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct owl_dma *od;
>  	int ret, i, nr_channels, nr_requests;
> +	const struct of_device_id *of_id =
> +				of_match_device(owl_dma_match, &pdev->dev);

You care about driver_data rather than of_id, so using
of_device_get_match_data() would be better..

>  	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
>  	if (!od)
> @@ -1083,6 +1116,8 @@ static int owl_dma_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
>  		 nr_channels, nr_requests);
>  
> +	od->devid = (enum owl_dma_id)(uintptr_t)of_id->data;

Funny casts, I dont think you need uintptr_t!
-- 
~Vinod
