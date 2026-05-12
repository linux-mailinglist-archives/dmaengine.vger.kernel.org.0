Return-Path: <dmaengine+bounces-10365-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJBFIVA8A2oq2AEAu9opvQ
	(envelope-from <dmaengine+bounces-10365-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:42:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E52522C77
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 461B63160B96
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDBE3AB5DD;
	Tue, 12 May 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8Dz+yxW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961353A7197;
	Tue, 12 May 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594703; cv=none; b=PJmy2yVF0dMPSyxCH4SVi1glHGUD4YpUVuh+xI4/VpnieWE2M9ZT7kWDkVXNmoFTUZjZJCTNGYBnr2bVX0VGQ2N7qsJf4U6C6qx2HfD786+ckWWKs+zn/BTAtSyp8PXhVvWD2evOambNbANFT5Q6MMi2zc38Pkm8n/OhqQK4fSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594703; c=relaxed/simple;
	bh=BIPChrZ4UpoM72ZAiDAI8HWazP45rR6zIg1tu4Dy7mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfuXSDwey3rYUUcYuTXCDSKgEgs2GmrTSjRAaVR4GJQ7coh5b8w3pexSh8na0y8ZuDbzyCcIP5Q/tmEyhl/D+1alXD9BzkgQXtJUwiM2mNx2GXkc+jSzwH5SCjJYnJd5zMK2RKr3z0l5VPLVAjJmhQCevhM9e7tGD94f3+6B4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Dz+yxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56D0C2BCF5;
	Tue, 12 May 2026 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594703;
	bh=BIPChrZ4UpoM72ZAiDAI8HWazP45rR6zIg1tu4Dy7mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8Dz+yxWS9Dm/bT6dOvuuuc2q6WwbWt7taRbZ9XzSnJHfGvP0dAO58m+EUdSUKVji
	 sky0xYgEuhBWzvsr8LRabQsufhrtiKDW0962BhkqyVcI0VW1Raio2h5OO/hQG8CYcw
	 m/updJZpr/GR/9a7F3gLP1OMBpJ0MW3n5K2W1A7jmV5sAP0EICEIjbJjSrCEBu+mc8
	 GtBal0WTjrsxrbPyuwajM0ib3d0ACQeC/NJL3DZnmZDvZnRji8dG0d5cu+g3KIG7pz
	 1qZTeiuE+RSSxPzRT8Asj6QdrfkpKtpZ0Bx2z6OgdG0eAICrcx7WnH1JHgO6DNPAD8
	 hGmE2ALMemKvQ==
Date: Tue, 12 May 2026 19:34:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Message-ID: <35yqgcks3umcplmqq4q5qpbyqmjn2j2utk2tsyz6lbbtkgx7bi@ndbu2timf2ok>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-5-85b3d22babff@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-5-85b3d22babff@nxp.com>
X-Rspamd-Queue-Id: 86E52522C77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10365-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:44:17PM -0400, Frank Li wrote:
> Pass dma_slave_config to dw_edma_device_transfer() to support atomic
> configuration and descriptor preparation when a non-NULL config is
> provided to device_prep_config_sg().
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> change in v3
> - rewrite dw_edma_device_slave_config() according to Damien's suggestion.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index f7f58b0010e26b529ffb7382d5b166a703587c71..ec6f6b1e482568a27ebe90852d5679672b24a1e9 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -267,6 +267,20 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  	return 0;
>  }
>  
> +static struct dma_slave_config *
> +dw_edma_device_get_config(struct dma_chan *dchan,
> +			  struct dma_slave_config *config)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (config)
> +		return config;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +
> +	return &chan->config;
> +}
> +
>  static int dw_edma_device_pause(struct dma_chan *dchan)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> @@ -385,7 +399,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
>  }
>  
>  static struct dma_async_tx_descriptor *
> -dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> +dw_edma_device_transfer(struct dw_edma_transfer *xfer,
> +			struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
>  	enum dma_transfer_direction dir = xfer->direction;
> @@ -472,8 +487,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		src_addr = xfer->xfer.il->src_start;
>  		dst_addr = xfer->xfer.il->dst_start;
>  	} else {
> -		src_addr = chan->config.src_addr;
> -		dst_addr = chan->config.dst_addr;
> +		src_addr = config->src_addr;
> +		dst_addr = config->dst_addr;
>  	}
>  
>  	if (dir == DMA_DEV_TO_MEM)
> @@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>  	if (config)
>  		dw_edma_device_config(dchan, config);
>  
> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
>  }
>  
>  static struct dma_async_tx_descriptor *
> @@ -614,7 +629,7 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
>  	xfer.flags = flags;
>  	xfer.type = EDMA_XFER_CYCLIC;
>  
> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
>  }
>  
>  static struct dma_async_tx_descriptor *
> @@ -630,7 +645,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
>  	xfer.flags = flags;
>  	xfer.type = EDMA_XFER_INTERLEAVED;
>  
> -	return dw_edma_device_transfer(&xfer);
> +	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
>  }
>  
>  static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

