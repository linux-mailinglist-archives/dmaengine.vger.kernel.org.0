Return-Path: <dmaengine+bounces-7871-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8DCD8F3B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1017230AB247
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EA324B1F;
	Tue, 23 Dec 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehXOHZRH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083661B4F0A;
	Tue, 23 Dec 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486508; cv=none; b=nOrbRFcAZgu4o4w6CooviXO7yYfBxGjPWg1kRZYK3EN5N+1nCRfX3yA8ZjpWAH7twz7nf65P3wF3clseaXqLQB3MydKENfhDl3SpSp7vBz+yx7SRab1/rMG6uuugoCwjAgFV6EdXQ04qtIgCLDBzKvpKCZbjMhSpEQKRP1Bm91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486508; c=relaxed/simple;
	bh=dh1LliqkmgcxlRpXE4EKf7TKTcpUvkSiqOpQkRgrNGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN/IaS8PUSLSnb9ivLwmjy79Q+6BDfftKI9rxvnmGX1vzhGNdDxa0zXxpeDOzYETAB3HYP6QoafKJKdeXQEzqUFu5zjUcIadzILigzT9QNdyOjGWJP5fl9k/av1xNHtiNFzGs//pb7e1AkolbnrZGfGrk1WWLpeTmICfYQQM01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehXOHZRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EA8C113D0;
	Tue, 23 Dec 2025 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766486507;
	bh=dh1LliqkmgcxlRpXE4EKf7TKTcpUvkSiqOpQkRgrNGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehXOHZRH3fe4YvnWKEw6pTVW2pbWT5bBgiBswCQP+mCqQuswq1dDSeRBBW6rQPwsc
	 dVR1KzAR1jQesyvFk2/8iKqEUA7IRQyq0Aqaiuv3B8arbU7hB1ECpNxYlOaw2stzMd
	 5YdxjHkHMOUeEM4UnXoM/CtL49zQg4f0CE9rmQNeeeNs2eh7Y9NiquWHtPs/zHDs/9
	 DuVhdm3T7PaXeCoFR+P48FnRL2KNsRcoAyGDS2yEiGrkxHtQA+5V0vnDIWFgMjBVfb
	 dihF+oI+uNHyjra+sM2iijAVYTDaHzpPf8w+oAXzEtzismq6MbeLlFQciymiYGglzd
	 RH7lvTqmlUMPQ==
Date: Tue, 23 Dec 2025 16:11:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <aUpx59CeT4XfL5i1@vaman>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>

On 18-12-25, 10:56, Frank Li wrote:
> Previously, configuration and preparation required two separate calls. This
> works well when configuration is done only once during initialization.
> 
> However, in cases where the burst length or source/destination address must
> be adjusted for each transfer, calling two functions is verbose and
> requires additional locking to ensure both steps complete atomically.
> 
> Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> and callback device_prep_config_sg() that combines configuration and
> preparation into a single operation. If the configuration argument is
> passed as NULL, fall back to the existing implementation.
> 
> Add a new API dmaengine_prep_config_single_safe() and
> dmaengine_prep_config_sg_safe() for re-entrancy, which require driver
> implement callback device_prep_config_sg().
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - add () for function
> - use short name device_prep_sg(), remove "slave" and "config". the 'slave'
> is reduntant. after remove slave, the function name is difference existed
> one, so remove _config suffix.
> ---
>  Documentation/driver-api/dmaengine/client.rst |   9 +++
>  include/linux/dmaengine.h                     | 103 ++++++++++++++++++++++++--
>  2 files changed, 105 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> index d491e385d61a98b8a804cd823caf254a2dc62cf4..02c45b7d7a779421411eb9c68325cdedafcfe3b1 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -80,6 +80,10 @@ The details of these operations are:
>  
>    - slave_sg: DMA a list of scatter gather buffers from/to a peripheral
>  
> +  - config_sg: Similar with slave_sg, just pass down dma_slave_config
> +    struct to avoid call dmaengine_slave_config() every time if need
> +    adjust burst length or FIFO address.
> +
>    - peripheral_dma_vec: DMA an array of scatter gather buffers from/to a
>      peripheral. Similar to slave_sg, but uses an array of dma_vec
>      structures instead of a scatterlist.
> @@ -106,6 +110,11 @@ The details of these operations are:
>  		unsigned int sg_len, enum dma_data_direction direction,
>  		unsigned long flags);
>  
> +     struct dma_async_tx_descriptor *dmaengine_prep_config_sg(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction dir,
> +		unsigned long flags, struct dma_slave_config *config);
> +
>       struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
>  		struct dma_chan *chan, const struct dma_vec *vecs,
>  		size_t nents, enum dma_data_direction direction,
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 99efe2b9b4ea9844ca6161208362ef18ef111d96..276dca760f95e1131f5ff5bf69752c4c9cb1bcad 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -835,6 +835,8 @@ struct dma_filter {
>   *	where the address and size of each segment is located in one entry of
>   *	the dma_vec array.
>   * @device_prep_slave_sg: prepares a slave dma operation
> + *	(Deprecated, use @device_prep_config_sg)

Sorry that is _not_ deprecated, we are adding another way to do this in
a single shot

> + * @device_prep_config_sg: prepares a slave DMA operation with dma_slave_config
>   * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
>   *	The function takes a buffer of size buf_len. The callback function will
>   *	be called after period_len bytes have been transferred.
> @@ -934,6 +936,11 @@ struct dma_device {
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
>  		unsigned long flags, void *context);
> +	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, struct dma_slave_config *config,
> +		void *context);
>  	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
>  		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  		size_t period_len, enum dma_transfer_direction direction,
> @@ -974,22 +981,85 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
>  	       (direction == DMA_DEV_TO_DEV);
>  }
>  
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
> -	struct dma_chan *chan, dma_addr_t buf, size_t len,
> -	enum dma_transfer_direction dir, unsigned long flags)
> +/*
> + * Re-entrancy and locking considerations for callers:
> + *
> + * dmaengine_prep_config_single(sg)_safe() is re-entrant and requires the
> + * DMA engine driver to implement device_prep_config_sg(). It returns NULL
> + * if device_prep_config_sg() is not implemented.
> + *
> + * The unsafe variant (without the _safe suffix) falls back to calling
> + * dmaengine_slave_config() and dmaengine_prep_slave_sg() separately.
> + * In this case, additional locking may be required, depending on the
> + * DMA consumer's usage.
> + */
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist *sgl,
> +	unsigned int sg_len, enum dma_transfer_direction dir,
> +	unsigned long flags, struct dma_slave_config *config)
> +{
> +	if (!chan || !chan->device || !chan->device->device_prep_config_sg)
> +		return NULL;
> +
> +	return chan->device->device_prep_config_sg(chan, sgl, sg_len,
> +						   dir, flags, config, NULL);
> +}
> +
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
> +	size_t len, enum dma_transfer_direction dir, unsigned long flags,
> +	struct dma_slave_config *config)

Agree with Damien, this could look better!

-- 
~Vinod

