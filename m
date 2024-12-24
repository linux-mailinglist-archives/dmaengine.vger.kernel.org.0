Return-Path: <dmaengine+bounces-4055-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4517D9FBB14
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A786D1883EB4
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585518EFED;
	Tue, 24 Dec 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvNUtkcp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C412D1F1;
	Tue, 24 Dec 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032045; cv=none; b=tf6x3Z8u0BPeW+eJKYUgp4b7A4MMkXHx4qazUbq9z3RKZBPGDsQMw7o0R50C2/uT0909Z2+8PAuRBHOGz6K+TyC/k/RS+ipL/6jefW84kBiT82XTCFyC9/Jja+0oEftl+DCEaG4SWUqGJk8icDvBOpk2fBJ6TfomWjFTwCt00Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032045; c=relaxed/simple;
	bh=1YWNMtYiky3Tjiq4gAF71+FN4C5n6op2xo87ngMa+os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9F4LAxOH4LZ/r1SYfYmdDNa6M8q2SJ4JpgizxdfnR3MT7uGv2090GGSsOICaoMQunA4CDArhtHNOC5ZvmVe/cBEBuMo/qaClGFa6NQjWtjNwosehJuCuYgxZnQVthbRwDvMA+UBJCajseuEcIlogV36/nLEVaS/N+UYSzJ7wjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvNUtkcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF72C4CED0;
	Tue, 24 Dec 2024 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735032044;
	bh=1YWNMtYiky3Tjiq4gAF71+FN4C5n6op2xo87ngMa+os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvNUtkcpTmzfzUKnsuYMIHq0ioQYWaUWvDLSPchu+z0Ua89R0pn8o9zfu4g/Bt0Ga
	 D2pWsNcYercDZnhZUuiRD9EXV860XAJdYfyO2miCvrin2/ruYjozEGuNkt0bmaeo8X
	 ln4BR1kXflUHROkPcbbcrxh0bAcqmiKgneHv7beZJDeWkbjX8AcmUpKDL11Cac2KnY
	 tumLbGehetHWC771s/sjcn3T24Jdn7Aq3NuCarAWFPcCfS3RrQbzqAKQgfEXPehfU4
	 yBdurhhekTcdepW27TPfi6y9QiXi17VamcHB/SANjC21ytT/Y2icPbX0Lo/aLiHMgs
	 Crq+67F+oINvA==
Date: Tue, 24 Dec 2024 14:50:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma: Add devm_dma_request_chan()
Message-ID: <Z2p86Z8B/qVSFwn8@vaman>
References: <20241222141427.819222-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241222141427.819222-1-csokas.bence@prolan.hu>

On 22-12-24, 15:14, Bence Csókás wrote:
> Expand the arsenal of devm functions for DMA
> devices, this time for requesting channels.

Looks good, users for this?

> 
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> ---
> 
> Notes:
>     Changes in v2:
>     * add prototype to header
>     * fix ERR_PTR() mixup
> 
>  drivers/dma/dmaengine.c   | 30 ++++++++++++++++++++++++++++++
>  include/linux/dmaengine.h |  7 +++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c1357d7f3dc6..02c29d26ac85 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -926,6 +926,36 @@ void dma_release_channel(struct dma_chan *chan)
>  }
>  EXPORT_SYMBOL_GPL(dma_release_channel);
>  
> +static void dmaenginem_release_channel(void *chan)
> +{
> +	dma_release_channel(chan);
> +}
> +
> +/**
> + * devm_dma_request_chan - try to allocate an exclusive slave channel
> + * @dev:	pointer to client device structure
> + * @name:	slave channel name
> + *
> + * Returns pointer to appropriate DMA channel on success or an error pointer.
> + *
> + * The operation is managed and will be undone on driver detach.
> + */
> +
> +struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
> +{
> +	struct dma_chan *chan = dma_request_chan(dev, name);
> +	int ret = 0;
> +
> +	if (!IS_ERR(chan))
> +		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return chan;
> +}
> +EXPORT_SYMBOL_GPL(devm_dma_request_chan);
> +
>  /**
>   * dmaengine_get - register interest in dma_channels
>   */
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b137fdb56093..631519552c5a 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1521,6 +1521,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  
>  struct dma_chan *dma_request_chan(struct device *dev, const char *name);
>  struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
> +struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
>  
>  void dma_release_channel(struct dma_chan *chan);
>  int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
> @@ -1557,6 +1558,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> +
> +static inline struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>  static inline void dma_release_channel(struct dma_chan *chan)
>  {
>  }
> -- 
> 2.34.1
> 

-- 
~Vinod

