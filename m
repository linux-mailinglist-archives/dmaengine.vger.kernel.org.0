Return-Path: <dmaengine+bounces-10363-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AA5AZw9A2po2AEAu9opvQ
	(envelope-from <dmaengine+bounces-10363-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:47:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBEC522E1B
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09A23316DB3
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6373ABDBE;
	Tue, 12 May 2026 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX7jChaU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A73ABD9B;
	Tue, 12 May 2026 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594606; cv=none; b=a2+E9emIFZRDUWLwgZcskACpqNPu29iHWx6GUkH1YED0OSgjKKb5VXFRA11yRkr0iLPUrRCTYJoZ7Lm2j6fSdikeKXKtIggNs4GuDlAwmIbKnXWzNv//42WF7jozo/MqGjibvQdOBnQL6eUwt2vV0Azv7/fP/gIaTZk4p45P+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594606; c=relaxed/simple;
	bh=GjrbKqt7UhV0Fd7/x9yogisk1zMvp87XUhU2BO+jtOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDxynR7x/9K4qwYn6OVOtfJXf+ndyirHzzN2/j7Ix0D75k3cH5BX9JCMg6DGT+evAfiCZ67poTXRJohPEwox1d8iCmSgLcZFYq5geY4BD9CpCR+D3Kzw13jN/dELpo//CAXm75Qgv4uAn3gv/xSdVoPcycN2jOI/d32Xf/aQigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX7jChaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F40C2BCF6;
	Tue, 12 May 2026 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594606;
	bh=GjrbKqt7UhV0Fd7/x9yogisk1zMvp87XUhU2BO+jtOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gX7jChaUGVKoBPZH/623LQEbqKANOyAyzsgX07zPjtXQUkJ9Hrc4sSMclR6oEhB9l
	 BBi153bMAkA/PjdEBfqppW9jl3rlG2FMvTmLqXZIylLYVnKt7xCBn12YQoWliOEqJo
	 e0aEXfKBLYqE3/bkb0iWwjKLOA1JDOY4uY0vRBpvmjjwK+tkbdmWxugDX0f9gvKg2T
	 prICu0IymXygx5olXk6vqboutJujjEscqoPhn7ZXhCQ4/fMwE/bbxB988pVIu+XmOA
	 q8sNTePhE4v4/589EAltLChYFbtotfWdqcBPpeeEN75hY2o51JK4Ajue4m2UmZK2sc
	 rub6PZ9aElcyA==
Date: Tue, 12 May 2026 19:33:15 +0530
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
Subject: Re: [PATCH v4 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Message-ID: <zaf2zeguq7oyrygv5fdokuo4w3btbcoysi2wmtyzremmdov3xe@reo3hnu7wpgi>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
 <20260506-dma_prep_config-v4-2-85b3d22babff@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-dma_prep_config-v4-2-85b3d22babff@nxp.com>
X-Rspamd-Queue-Id: 4DBEC522E1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10363-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 04:44:14PM -0400, Frank Li wrote:
> Introduce dmaengine_prep_config_single_safe() and
> dmaengine_prep_config_sg_safe() to provide a reentrant-safe way to
> combine slave configuration and transfer preparation.
> 
> Drivers may implement the new device_prep_config_sg() callback to perform
> both steps atomically. If the callback is not provided, the helpers fall
> back to calling dmaengine_slave_config() followed by
> dmaengine_prep_slave_sg() under per-channel mutex protection.
> 
> Tested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> chagne in v4
> - use spinlock() to protect config() and prep()
> 
> change in v3
> - new patch
> ---
>  drivers/dma/dmaengine.c   |  2 ++
>  include/linux/dmaengine.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 405bd2fbb4a3b94fd0bf44526f656f6a19feaad0..ba29e60160c1a0148793bb299849bccfebb6d32b 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1099,6 +1099,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
>  	chan->dev->device.parent = device->dev;
>  	chan->dev->chan = chan;
>  	chan->dev->dev_id = device->dev_id;
> +	spin_lock_init(&chan->lock);
> +
>  	if (!name)
>  		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
>  	else
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index defa377d2ef54d94e6337cdfa7826a091295535e..23728f3d60804e49cd4cbbd3a513c4936eed5836 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -322,6 +322,8 @@ struct dma_router {
>   * @slave: ptr to the device using this channel
>   * @cookie: last cookie value returned to client
>   * @completed_cookie: last completed cookie for this channel
> + * @lock: protect between config and prepare transfer when driver have not
> + *	  implemented callback device_prep_config_sg().
>   * @chan_id: channel ID for sysfs
>   * @dev: class device for sysfs
>   * @name: backlink name for sysfs
> @@ -341,6 +343,12 @@ struct dma_chan {
>  	dma_cookie_t cookie;
>  	dma_cookie_t completed_cookie;
>  
> +	/*
> +	 * protect between config and prepare transfer because *_prep() may be
> +	 * called from complete callback, which is in GFP_NOSLEEP context.
> +	 */
> +	spinlock_t lock; /* protect between config and prepare transfer since */

Why two comments?

> +
>  	/* sysfs */
>  	int chan_id;
>  	struct dma_chan_dev *dev;
> @@ -1068,6 +1076,56 @@ dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
>  }
>  
> +/*
> + * dmaengine_prep_config_single(sg)_safe() is re-entrant version.
> + *
> + * The unsafe variant (without the _safe suffix) falls back to calling
> + * dmaengine_slave_config() and dmaengine_prep_slave_sg() separately.
> + * In this case, additional locking may be required, depending on the
> + * DMA consumer's usage.
> + *
> + * If dmaengine driver have not implemented call back device_prep_config_sg()
> + * safe version use per-channel spinlock to protect call dmaengine_slave_config()
> + * and dmaengine_prep_slave_sg().
> + */

Use proper kernel-doc comments please...

> +static inline struct dma_async_tx_descriptor *
> +dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist *sgl,
> +			      unsigned int sg_len,
> +			      enum dma_transfer_direction dir,
> +			      unsigned long flags,
> +			      struct dma_slave_config *config)
> +{
> +	struct dma_async_tx_descriptor *tx;
> +
> +	if (!chan || !chan->device)
> +		return NULL;
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_lock(&chan->lock);
> +
> +	tx = dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
> +
> +	if (!chan->device->device_prep_config_sg)
> +		spin_unlock(&chan->lock);
> +
> +	return tx;
> +}
> +

Missing kernel-doc.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

