Return-Path: <dmaengine+bounces-896-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993138428C8
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 17:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F72289F67
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F586151;
	Tue, 30 Jan 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmIFW2K2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C2605A6;
	Tue, 30 Jan 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630928; cv=none; b=ZB5cl9jPmLXoaSD5BrkPXqOC6Zf6uEhFjqSCjnLCqm9+Z2/BqBueJLqbcULP+PxwhHbuvYPKXjZbnXtcluAKi2V6PZqSdawN2D8A+/ysbUY7axtbaihVqcRBHBp7JRLHE0/7Fgub57Cqfz5M3akpD9caR5Aexn6dT/SLCspS+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630928; c=relaxed/simple;
	bh=sPfj1j3becXJ7FsukmBOZKFUKuKhbginVe76VML0cXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kElmla3eJaDJdyM21AqHsafQ4rtvRfxYH+43HOn0KlNJXLbPH2hKQND2x7P9re6zugsSVT4c+aQ91ilkLXqKcd0iuvqMGisrbPKhFgIz/berXh4bj8oRcB9b6P17dC3Hf2/GVX15xP1RL3fUN4Q36To2lIx/F9fmFG2KIdc0mz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmIFW2K2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2BFC433B1;
	Tue, 30 Jan 2024 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630927;
	bh=sPfj1j3becXJ7FsukmBOZKFUKuKhbginVe76VML0cXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmIFW2K2WgTsKXQmDdtFbEnUjOrbNCF8PYC4VvIFsGwbw34L19U9MYFsKAMIPCycY
	 LC/VcY6WWhHTYIMox8e4CI2JJNi1bbfjUrGSfJdFg/SGj8Xvn87HbUGCo3GcxG6zCO
	 37P6GVi/kqcp5mLJbkxUDbApSuGsX9yVjfcY6GXrZyUcID/fgA8XuxTPFF6DaGEg4X
	 0sMYfPheUUaDyV+9PqMuZX/DdKs8mTx0h8HW4+nKLGDsGEF8cCLSOyu0rSRWIXHw9m
	 avnV2CMbsJpUWj4scBQGRAktSei4fsapCkjhweRp+1TWvmxmAira22HmAcznJJUQyb
	 ocuRD83nX5Kfw==
Date: Tue, 30 Jan 2024 21:38:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v6 1/6] dmaengine: Add API function
 dmaengine_prep_slave_dma_vec()
Message-ID: <ZbkfC31eWBUQ3kSl@matsya>
References: <20240129170201.133785-1-paul@crapouillou.net>
 <20240129170201.133785-2-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129170201.133785-2-paul@crapouillou.net>

On 29-01-24, 18:01, Paul Cercueil wrote:
> This function can be used to initiate a scatter-gather DMA transfer,
> where the address and size of each segment is located in one entry of
> the dma_vec array.
> 
> The major difference with dmaengine_prep_slave_sg() is that it supports
> specifying the lengths of each DMA transfer; as trying to override the
> length of the transfer with dmaengine_prep_slave_sg() is a very tedious
> process. The introduction of a new API function is also justified by the
> fact that scatterlists are on their way out.
> 
> Note that dmaengine_prep_interleaved_dma() is not helpful either in that
> case, as it assumes that the address of each segment will be higher than
> the one of the previous segment, which we just cannot guarantee in case
> of a scatter-gather transfer.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> ---
> v3: New patch
> 
> v5: Replace with function dmaengine_prep_slave_dma_vec(), and struct
>     'dma_vec'.
>     Note that at some point we will need to support cyclic transfers
>     using dmaengine_prep_slave_dma_vec(). Maybe with a new "flags"
>     parameter to the function?

that would be better

> ---
>  include/linux/dmaengine.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 3df70d6131c8..ee5931ddb42f 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -160,6 +160,16 @@ struct dma_interleaved_template {
>  	struct data_chunk sgl[];
>  };
>  
> +/**
> + * struct dma_vec - DMA vector
> + * @addr: Bus address of the start of the vector
> + * @len: Length in bytes of the DMA vector
> + */
> +struct dma_vec {
> +	dma_addr_t addr;
> +	size_t len;
> +};
> +
>  /**
>   * enum dma_ctrl_flags - DMA flags to augment operation preparation,
>   *  control completion, and communicate status.
> @@ -910,6 +920,10 @@ struct dma_device {
>  	struct dma_async_tx_descriptor *(*device_prep_dma_interrupt)(
>  		struct dma_chan *chan, unsigned long flags);
>  
> +	struct dma_async_tx_descriptor *(*device_prep_slave_dma_vec)(
> +		struct dma_chan *chan, const struct dma_vec *vecs,
> +		size_t nents, enum dma_transfer_direction direction,
> +		unsigned long flags);

s/slave/peripheral

I had requested it a bit while ago as well

>  	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
> @@ -972,6 +986,17 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
>  						  dir, flags, NULL);
>  }
>  
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_dma_vec(
> +	struct dma_chan *chan, const struct dma_vec *vecs, size_t nents,
> +	enum dma_transfer_direction dir, unsigned long flags)
> +{
> +	if (!chan || !chan->device || !chan->device->device_prep_slave_dma_vec)
> +		return NULL;
> +
> +	return chan->device->device_prep_slave_dma_vec(chan, vecs, nents,
> +						       dir, flags);
> +}
> +
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
>  	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
>  	enum dma_transfer_direction dir, unsigned long flags)
> -- 
> 2.43.0

-- 
~Vinod

