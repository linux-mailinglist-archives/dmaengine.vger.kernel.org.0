Return-Path: <dmaengine+bounces-600-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20EE81BA59
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB8C288D7D
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310E482EA;
	Thu, 21 Dec 2023 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjVkJIRr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB43608F;
	Thu, 21 Dec 2023 15:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713ECC433C8;
	Thu, 21 Dec 2023 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703171698;
	bh=zjMfiDs6kuBp3zb318oBQPY1juh8+chwNv23H/5VPqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjVkJIRr0l/QKKHAEq6W0JQWKU9zm4mdJtgRJdsNkdoHJLY1yYKYlFxsl/AhOas6D
	 zf+cdRsl7tvsOjwwSNI162tHelvqRcUjt7yOLe0x3b+z88zehvVHi2F9+Dsx0E+m1R
	 ZHgrpb6QRlTGZ7j2J1ZyXraHtcyZG4lGfCtcJQYMgcvptNrZOn9PSV77vrv++c5cvR
	 Jqrw7znWqIW9eOeuQsmcizySvD0tdM1q0SuRUd2CBn3/4kRv9kXVprBvUgR3UNAiY1
	 DcAf2DdBxYeI/E66Blf5046DcDmyYSZLvMJR6o1IOooAygmJr3pVhx1xCp9kWR9QRB
	 CQiT3yIWYrYAg==
Date: Thu, 21 Dec 2023 20:44:53 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 3/8] dmaengine: Add API function
 dmaengine_prep_slave_dma_vec()
Message-ID: <ZYRWbROAuMXftH07@matsya>
References: <20231219175009.65482-1-paul@crapouillou.net>
 <20231219175009.65482-4-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219175009.65482-4-paul@crapouillou.net>

On 19-12-23, 18:50, Paul Cercueil wrote:
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

so you want to transfer multiple buffers, right? why not use
dmaengine_prep_slave_sg(). If there is reason for not using that one?

Furthermore I missed replying to your email earlier on use of
dmaengine_prep_interleaved_dma(), my apologies.
That can be made to work for you as well. Please see the notes where icg
can be ignored and it does not need icg value to be set

Infact, interleaved api can be made to work in most of these cases I can
think of...


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

