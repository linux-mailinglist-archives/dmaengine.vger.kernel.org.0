Return-Path: <dmaengine+bounces-966-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372FF84C620
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733541C21376
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402120310;
	Wed,  7 Feb 2024 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFRkqTVX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02062030D;
	Wed,  7 Feb 2024 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294134; cv=none; b=DkA4UC16wi/4AKgFiEcZYxHtxE8B/JNovdmXqQXWmfKP1+HmL/eMAJlcHgk8HbzaZYAcJ2HEXqCkx5kd9cDxaSm2ls4ZtfIY7f8iDwGfy6zfQJs5h0/saSQtRbmd1Qeu+MW/v57BvCyfTusErB3cIyaWC9PGjWkOnrLQGiDb/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294134; c=relaxed/simple;
	bh=ONyfgYZpeNqlc+twIxjgoeZr/daOvsSeNW0AuvuRyrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs0GpodgShufppbeDZ9Mt+GKP+eXxmuk0ZuMg5VrtEyoU64xzeJrwuwSrwx11DCqcybdgWT9meTNyds1zt6I4PIkLSOcXLlKbNohAVL8mbC+p1CtSKp8oZD0qbIjNLe+7nLNHuu6zdaa+75lZTAgaC9TP+HmAm+KMhJl9pRlGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFRkqTVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C6DC433F1;
	Wed,  7 Feb 2024 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707294133;
	bh=ONyfgYZpeNqlc+twIxjgoeZr/daOvsSeNW0AuvuRyrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFRkqTVXJP/LrrxAulBnht89YU8gjhBMPmIBHvCcPhp6f6YxyBHeWezLZZE34gZOS
	 IU2JCGkUciXPkSTswXwub4IzKzhzd1DPHhEYhS9lL07WYcfQPQos2JwatEHlP4z7rl
	 xNqZjRWAzM/y2Q/LwzxU8/A2LVwVTo7+5gTnO23fxTHOYnUuay4gswThtob/U4pL6v
	 NZ+PMrKh456IV1hTci6j6R0SU+5pjRnKp6kfTVXE4Mm1PkGm51v5Ls78JYshD5udqF
	 xe4k/YM5hAuQRznHiJx4GdohNQef5dJLrXcyrrkcLKAl1YT1Pd44Nw/kY9A0r8O3W1
	 kTiprXynIGUwQ==
Date: Wed, 7 Feb 2024 09:22:10 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Ripard <maxime@cerno.tech>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 07/12] bcm2835-dma: Support dma flags for multi-beat burst
Message-ID: <ZcM9slv_x-CltW6y@matsya>
References: <cover.1706948717.git.andrea.porta@suse.com>
 <570953f9532e2dc46568674d3c1348cdf26488b6.1706948717.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570953f9532e2dc46568674d3c1348cdf26488b6.1706948717.git.andrea.porta@suse.com>

On 04-02-24, 07:59, Andrea della Porta wrote:
> From: Dom Cobley <popcornmix@gmail.com>
> 
> Add a control bit to enable a multi-beat burst on a DMA.
> This improves DMA performance and is required for HDMI audio.
> 
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  drivers/dma/bcm2835-dma.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index d8d1f9ba2572..a20700a400a2 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -156,7 +156,8 @@ struct bcm2835_desc {
>  #define BCM2835_DMA_S_WIDTH	BIT(9) /* 128bit writes if set */
>  #define BCM2835_DMA_S_DREQ	BIT(10) /* enable SREQ for source */
>  #define BCM2835_DMA_S_IGNORE	BIT(11) /* ignore source reads - read 0 */
> -#define BCM2835_DMA_BURST_LENGTH(x) ((x & 15) << 12)
> +#define BCM2835_DMA_BURST_LENGTH(x) (((x) & 15) << 12)

why this changes, sounds like it does not belong here.. 


> +#define BCM2835_DMA_GET_BURST_LENGTH(x) (((x) >> 12) & 15)
>  #define BCM2835_DMA_CS_FLAGS(x) ((x) & (BCM2835_DMA_PRIORITY(15) | \
>  				      BCM2835_DMA_PANIC_PRIORITY(15) | \
>  				      BCM2835_DMA_WAIT_FOR_WRITES | \
> @@ -180,6 +181,11 @@ struct bcm2835_desc {
>  #define WIDE_DEST(x) (((x) & BCM2835_DMA_WIDE_DEST) ? \
>  		      BCM2835_DMA_D_WIDTH : 0)
>  
> +/* A fake bit to request that the driver requires multi-beat burst */
> +#define BCM2835_DMA_BURST BIT(30)
> +#define BURST_LENGTH(x) (((x) & BCM2835_DMA_BURST) ? \
> +			 BCM2835_DMA_BURST_LENGTH(3) : 0)
> +
>  /* debug register bits */
>  #define BCM2835_DMA_DEBUG_LAST_NOT_SET_ERR	BIT(0)
>  #define BCM2835_DMA_DEBUG_FIFO_ERR		BIT(1)
> @@ -282,7 +288,7 @@ struct bcm2835_desc {
>  /* the max dma length for different channels */
>  #define MAX_DMA40_LEN SZ_1G
>  
> -#define BCM2711_DMA40_BURST_LEN(x)	((min(x, 16) - 1) << 8)
> +#define BCM2711_DMA40_BURST_LEN(x)	(((x) & 15) << 8)
>  #define BCM2711_DMA40_INC		BIT(12)
>  #define BCM2711_DMA40_SIZE_32		(0 << 13)
>  #define BCM2711_DMA40_SIZE_64		(1 << 13)
> @@ -359,12 +365,16 @@ static inline uint32_t to_bcm2711_ti(uint32_t info)
>  
>  static inline uint32_t to_bcm2711_srci(uint32_t info)
>  {
> -	return ((info & BCM2835_DMA_S_INC) ? BCM2711_DMA40_INC : 0);
> +	return ((info & BCM2835_DMA_S_INC) ? BCM2711_DMA40_INC : 0) |
> +	       ((info & BCM2835_DMA_S_WIDTH) ? BCM2711_DMA40_SIZE_128 : 0) |
> +	       BCM2711_DMA40_BURST_LEN(BCM2835_DMA_GET_BURST_LENGTH(info));
>  }
>  
>  static inline uint32_t to_bcm2711_dsti(uint32_t info)
>  {
> -	return ((info & BCM2835_DMA_D_INC) ? BCM2711_DMA40_INC : 0);
> +	return ((info & BCM2835_DMA_D_INC) ? BCM2711_DMA40_INC : 0) |
> +	       ((info & BCM2835_DMA_D_WIDTH) ? BCM2711_DMA40_SIZE_128 : 0) |
> +	       BCM2711_DMA40_BURST_LEN(BCM2835_DMA_GET_BURST_LENGTH(info));
>  }
>  
>  static inline uint32_t to_bcm2711_cbaddr(dma_addr_t addr)
> @@ -933,7 +943,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
>  	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>  	struct bcm2835_desc *d;
>  	u32 info = BCM2835_DMA_D_INC | BCM2835_DMA_S_INC |
> -		   WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
> +		   WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
> +		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
>  	u32 extra = BCM2835_DMA_INT_EN;
>  	size_t max_len = bcm2835_dma_max_frame_length(c);
>  	size_t frames;
> @@ -964,8 +975,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
>  	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>  	struct bcm2835_desc *d;
>  	dma_addr_t src = 0, dst = 0;
> -	u32 info = WAIT_RESP(c->dreq) |
> -		   WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
> +	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
> +		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
>  	u32 extra = BCM2835_DMA_INT_EN;
>  	size_t frames;
>  
> @@ -1017,7 +1028,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
>  	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>  	struct bcm2835_desc *d;
>  	dma_addr_t src, dst;
> -	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) | WIDE_DEST(c->dreq);
> +	u32 info = WAIT_RESP(c->dreq) | WIDE_SOURCE(c->dreq) |
> +		   WIDE_DEST(c->dreq) | BURST_LENGTH(c->dreq);
>  	u32 extra = 0;
>  	size_t max_len = bcm2835_dma_max_frame_length(c);
>  	size_t frames;
> -- 
> 2.41.0

-- 
~Vinod

