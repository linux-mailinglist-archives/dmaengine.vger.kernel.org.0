Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53E15637EB
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiGAQ25 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiGAQ2x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 12:28:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1570433E99;
        Fri,  1 Jul 2022 09:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 787A7B82DDC;
        Fri,  1 Jul 2022 16:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862EAC341CD;
        Fri,  1 Jul 2022 16:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656692928;
        bh=R8iGcJ/q4R9xa0G3mQb3hMxAlVQoBfF30z8+ZZkTAVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7nnHPKmQ78xkG3MaFecuBEPoBXG6f1Qg+E/PH1vsnn06xDko5MYwE/leoTqSTj6i
         ozFze5Roamqux+noCahHYLuuH9rJfaTqgnc5i6FAEB9TPAubzHygIm34XiUvhbLl78
         bzxHUScSbhLaskc3vVwcQclgIqvnK4IFX02CtgYjHTOu/+XEmVxHG6jc6DHBIP0PQa
         jJrXCiDz1jxCeHnOPd0tYnfZCYA7a+xhZrq/SVs+xrd/9BH2uVaGfcVI2A6jcVH+/4
         cjb/ePzIPQvTKnkugwYZn9XoF1uMjgCNUKTxGoy9UN/TQ5/1GYzrEs4w+JPzubZUFq
         IESuBzxGTCZKg==
Date:   Fri, 1 Jul 2022 21:58:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] dmaengine: sun4i: Set the maximum segment size
Message-ID: <Yr8guz0No80hdgxi@matsya>
References: <20220621031350.36187-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621031350.36187-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-22, 22:13, Samuel Holland wrote:
> The sun4i DMA engine supports transfer sizes up to 128k for normal DMA
> and 16M for dedicated DMA, as documented in the A10 and A20 manuals.
> 
> Since this is larger than the default segment size limit (64k), exposing
> the real limit reduces the number of transfers needed for a transaction.
> However, because the device can only report one segment size limit, we
> have to expose the smaller limit from normal DMA.
> 
> One complication is that the driver combines pairs of periodic transfers
> to reduce programming overhead. This only works when the period size is
> at most half of the maximum transfer size. With the default 64k segment
> size limit, this was always the case, but for normal DMA it is no longer
> guaranteed. Skip the optimization if the period is too long; even
> without it, the overhead is less than before.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> I don't have any A10 or A20 boards I can test this on.
> 
>  drivers/dma/sun4i-dma.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index 93f1645ae928..f291b1b4db32 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -7,6 +7,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dmapool.h>
>  #include <linux/interrupt.h>
> @@ -122,6 +123,15 @@
>  	 SUN4I_DDMA_PARA_DST_WAIT_CYCLES(2) |				\
>  	 SUN4I_DDMA_PARA_SRC_WAIT_CYCLES(2))
>  
> +/*
> + * Normal DMA supports individual transfers (segments) up to 128k.
> + * Dedicated DMA supports transfers up to 16M. We can only report
> + * one size limit, so we have to use the smaller value.
> + */
> +#define SUN4I_NDMA_MAX_SEG_SIZE		SZ_128K
> +#define SUN4I_DDMA_MAX_SEG_SIZE		SZ_16M

This new define is not used, so why add?

> +#define SUN4I_DMA_MAX_SEG_SIZE		SUN4I_NDMA_MAX_SEG_SIZE
> +
>  struct sun4i_dma_pchan {
>  	/* Register base of channel */
>  	void __iomem			*base;
> @@ -155,7 +165,8 @@ struct sun4i_dma_contract {
>  	struct virt_dma_desc		vd;
>  	struct list_head		demands;
>  	struct list_head		completed_demands;
> -	int				is_cyclic;
> +	bool				is_cyclic : 1;
> +	bool				use_half_int : 1;
>  };
>  
>  struct sun4i_dma_dev {
> @@ -372,7 +383,7 @@ static int __execute_vchan_pending(struct sun4i_dma_dev *priv,
>  	if (promise) {
>  		vchan->contract = contract;
>  		vchan->pchan = pchan;
> -		set_pchan_interrupt(priv, pchan, contract->is_cyclic, 1);
> +		set_pchan_interrupt(priv, pchan, contract->use_half_int, 1);

not interrupt when cyclic?

>  		configure_pchan(pchan, promise);
>  	}
>  
> @@ -735,12 +746,21 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
>  	 *
>  	 * Which requires half the engine programming for the same
>  	 * functionality.
> +	 *
> +	 * This only works if two periods fit in a single promise. That will
> +	 * always be the case for dedicated DMA, where the hardware has a much
> +	 * larger maximum transfer size than advertised to clients.
>  	 */
> -	nr_periods = DIV_ROUND_UP(len / period_len, 2);
> +	if (vchan->is_dedicated || period_len <= SUN4I_NDMA_MAX_SEG_SIZE / 2) {
> +		period_len *= 2;
> +		contract->use_half_int = 1;
> +	}
> +
> +	nr_periods = DIV_ROUND_UP(len, period_len);
>  	for (i = 0; i < nr_periods; i++) {
>  		/* Calculate the offset in the buffer and the length needed */
> -		offset = i * period_len * 2;
> -		plength = min((len - offset), (period_len * 2));
> +		offset = i * period_len;
> +		plength = min((len - offset), period_len);
>  		if (dir == DMA_MEM_TO_DEV)
>  			src = buf + offset;
>  		else
> @@ -1149,6 +1169,8 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, priv);
>  	spin_lock_init(&priv->lock);
>  
> +	dma_set_max_seg_size(&pdev->dev, SUN4I_DMA_MAX_SEG_SIZE);
> +
>  	dma_cap_zero(priv->slave.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, priv->slave.cap_mask);
>  	dma_cap_set(DMA_MEMCPY, priv->slave.cap_mask);
> -- 
> 2.35.1

-- 
~Vinod
