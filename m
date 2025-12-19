Return-Path: <dmaengine+bounces-7834-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE4ECCF600
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EE5F300DCD3
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B210230270;
	Fri, 19 Dec 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvhFZA9m"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10D2253FC;
	Fri, 19 Dec 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140427; cv=none; b=eowBTuve2CMfj6dyC920xQmSPvTMDPZLvZlIR4NBN3H/BVpFyjnRvEZo2O0ykulpbYuAAleV2Yp+zi9W6bEJWEjr2f3Pa7RxEqbRrdSfwYx2HHpJj3vPjo/WUVj61gNi3rL8ONQC9kELjg3Ep4aGFAKlDAxQbjgpTVfNGFQ1koY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140427; c=relaxed/simple;
	bh=dtZQq9Tz8X9IApzFIIAr/KFy4FgR9nC4AkGBbD+ruV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKIfwxWWMEBo/7AhgwVRXoU98YQD1tZhZsPjMk3Ejy4ecsfn95Yk9VF40ktBn9h/TV9p/Ozl30DghYI4WDu1eEcsdi/kRZnkjRfMmX7asK6mFewGC6ur5STcDHoivZEXHcsZOs0vtQyrjdNMqv+4F1ykgZI8T4vFtmSrkvxpk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvhFZA9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CA0C4CEF1;
	Fri, 19 Dec 2025 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766140426;
	bh=dtZQq9Tz8X9IApzFIIAr/KFy4FgR9nC4AkGBbD+ruV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dvhFZA9mSqbLJ4yx1jwkajLjdYyJpg/f+9SuszQZkDtJpoVGrKr+VuyI2UpSTAk63
	 TbgkCcHbt6vnU8Dl3ct5fdt4iBv5tNkB3tpX0Ymis8/x5zv4SfOtQfEcVOrNwoPr9d
	 o/TqZs5FaoTMNrlNnl00Lylv9lHjgr2455clLXs9cY+cW7ut5VonZQRs2WBZw5JhQN
	 qr7EiJyCLb8rxiesfFq0oCoVFmMig7iSpgXbkpL+6dL9bdP2ZAwrUZLFqsJjtL4uF8
	 Cq4Odqpe3E285Sx/9maLb8nrVVpavMQg9va7oh7H1FeAJgKgnoLQPS5eiDC9K7Z9/y
	 a8J56MSdiktog==
Message-ID: <b081d13b-4af2-4b60-83e5-3553939c1749@kernel.org>
Date: Fri, 19 Dec 2025 19:33:42 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>,
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 00:56, Frank Li wrote:
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

...struct to avoid calling dmaengine_slave_config() every time adjusting the
burst length or the FIFO address is needed.

> +    adjust burst length or FIFO address.
> +

> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
> +	size_t len, enum dma_transfer_direction dir, unsigned long flags,
> +	struct dma_slave_config *config)
>  {
>  	struct scatterlist sg;
> +
>  	sg_init_table(&sg, 1);
>  	sg_dma_address(&sg) = buf;
>  	sg_dma_len(&sg) = len;
>  
> -	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
> +	if (!chan || !chan->device || !chan->device->device_prep_config_sg)
> +		return NULL;

While at it, please move this arguments check before the sg initialization.
Otherwise, this is a little odd (argument checks generally are done first).

> +
> +	return chan->device->device_prep_config_sg(chan, &sg, 1, dir,
> +						   flags, config, NULL);
> +}
> +
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
> +	enum dma_transfer_direction dir, unsigned long flags,
> +	struct dma_slave_config *config)
> +{
> +	struct scatterlist sg;
> +
> +	sg_init_table(&sg, 1);
> +	sg_dma_address(&sg) = buf;
> +	sg_dma_len(&sg) = len;
> +
> +	if (!chan || !chan->device)
> +		return NULL;

Same here. Check these before initializing sg.

> +
> +	if (chan->device->device_prep_config_sg)
> +		return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir,
> +						     flags, config);
> +
> +	if (config)
> +		if (dmaengine_slave_config(chan, config))
> +			return NULL;
> +
> +	if (!chan->device->device_prep_slave_sg)
>  		return NULL;
>  
>  	return chan->device->device_prep_slave_sg(chan, &sg, 1,
>  						  dir, flags, NULL);
>  }
>  
> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_slave_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
> +			    enum dma_transfer_direction dir,
> +			    unsigned long flags)
> +{
> +	return dmaengine_prep_config_single(chan, buf, len, dir, flags, NULL);
> +}
> +
>  /**
>   * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
>   * @chan: The channel to be used for this descriptor
> @@ -1009,17 +1079,36 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
>  							    dir, flags);
>  }
>  
> -static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_config_sg(

Very odd line split. Please split this after the "*" of the return type.

>  	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
> -	enum dma_transfer_direction dir, unsigned long flags)
> +	enum dma_transfer_direction dir, unsigned long flags,
> +	struct dma_slave_config *config)
>  {
> -	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
> +	if (!chan || !chan->device)
> +		return NULL;
> +
> +	if (chan->device->device_prep_config_sg)
> +		return dmaengine_prep_config_sg_safe(chan, sgl, sg_len,
> +					dir, flags, config);
> +
> +	if (config)
> +		if (dmaengine_slave_config(chan, config))
> +			return NULL;
> +
> +	if (!chan->device->device_prep_slave_sg)
>  		return NULL;
>  
>  	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
>  						  dir, flags, NULL);
>  }
>  
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(

Same comment here.

> +	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sg_len,
> +	enum dma_transfer_direction dir, unsigned long flags)
> +{
> +	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
> +}
> +
>  #ifdef CONFIG_RAPIDIO_DMA_ENGINE
>  struct rio_dma_ext;
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
> 


-- 
Damien Le Moal
Western Digital Research

