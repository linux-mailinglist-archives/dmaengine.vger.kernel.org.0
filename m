Return-Path: <dmaengine+bounces-610-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5328881BBA2
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2628DE23
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856B059908;
	Thu, 21 Dec 2023 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQbBRiV2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D75821A;
	Thu, 21 Dec 2023 16:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4218C433CB;
	Thu, 21 Dec 2023 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703175195;
	bh=KVesujFyxk8g+PzjFWaKsdIwlbPbsy9MmO8ani2Ia+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQbBRiV2NxFUlEtQl9y5+GPe98N7iyUbmlEtAJYC69/jn5YMiEp1tfhq/lyTEFOGn
	 fdRPQMVVnE1xFlCoa3XIHzGdf2/7FfSm0loSmFlaeWDW8gPEfT2ZfXlukBd0aLLy3l
	 qyiWwUipdrLQHBBDY5IUzQV8xVXYAc33ENr9DFcqCc6Y9YMfJgrKshGdN+bVjWdwBy
	 bIdM8FsrbnbjT4D4d0E8htI1K0bodi1FkJ9SREYSRULMgFLxVKZsBEwJ/J/v8aTcye
	 9aqYrHcTGq0q68Eln1R4BfbgPOBj3TOIWa44/Gr7WzeQQ5Mx7DQgLLYpNiUfQp9Uhz
	 3GYgpXjn6n3QA==
Date: Thu, 21 Dec 2023 16:12:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Vinod Koul <vkoul@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 7/8] iio: buffer-dmaengine: Support new DMABUF based
 userspace API
Message-ID: <20231221161258.056f5ce4@jic23-huawei>
In-Reply-To: <20231219175009.65482-8-paul@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
	<20231219175009.65482-8-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 18:50:08 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Use the functions provided by the buffer-dma core to implement the
> DMABUF userspace API in the buffer-dmaengine IIO buffer implementation.
> 
> Since we want to be able to transfer an arbitrary number of bytes and
> not necesarily the full DMABUF, the associated scatterlist is converted
> to an array of DMA addresses + lengths, which is then passed to
> dmaengine_prep_slave_dma_array().
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
One question inline. Otherwise looks fine to me.

J
> 
> ---
> v3: Use the new dmaengine_prep_slave_dma_array(), and adapt the code to
>     work with the new functions introduced in industrialio-buffer-dma.c.
> 
> v5: - Use the new dmaengine_prep_slave_dma_vec().
>     - Restrict to input buffers, since output buffers are not yet
>       supported by IIO buffers.
> ---
>  .../buffer/industrialio-buffer-dmaengine.c    | 52 ++++++++++++++++---
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 5f85ba38e6f6..825d76a24a67 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -64,15 +64,51 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  	struct dmaengine_buffer *dmaengine_buffer =
>  		iio_buffer_to_dmaengine_buffer(&queue->buffer);
>  	struct dma_async_tx_descriptor *desc;
> +	unsigned int i, nents;
> +	struct scatterlist *sgl;
> +	struct dma_vec *vecs;
> +	size_t max_size;
>  	dma_cookie_t cookie;
> +	size_t len_total;
>  
> -	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
> -	block->bytes_used = round_down(block->bytes_used,
> -			dmaengine_buffer->align);
> +	if (queue->buffer.direction != IIO_BUFFER_DIRECTION_IN) {
> +		/* We do not yet support output buffers. */
> +		return -EINVAL;
> +	}
>  
> -	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> -		block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
> -		DMA_PREP_INTERRUPT);
> +	if (block->sg_table) {
> +		sgl = block->sg_table->sgl;
> +		nents = sg_nents_for_len(sgl, block->bytes_used);

Are we guaranteed the length in the sglist is enough?  If not this
can return an error code.


> +
> +		vecs = kmalloc_array(nents, sizeof(*vecs), GFP_KERNEL);
> +		if (!vecs)
> +			return -ENOMEM;
> +
> +		len_total = block->bytes_used;
> +
> +		for (i = 0; i < nents; i++) {
> +			vecs[i].addr = sg_dma_address(sgl);
> +			vecs[i].len = min(sg_dma_len(sgl), len_total);
> +			len_total -= vecs[i].len;
> +
> +			sgl = sg_next(sgl);
> +		}
> +
> +		desc = dmaengine_prep_slave_dma_vec(dmaengine_buffer->chan,
> +						    vecs, nents, DMA_DEV_TO_MEM,
> +						    DMA_PREP_INTERRUPT);
> +		kfree(vecs);
> +	} else {
> +		max_size = min(block->size, dmaengine_buffer->max_size);
> +		max_size = round_down(max_size, dmaengine_buffer->align);
> +		block->bytes_used = max_size;
> +
> +		desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> +						   block->phys_addr,
> +						   block->bytes_used,
> +						   DMA_DEV_TO_MEM,
> +						   DMA_PREP_INTERRUPT);
> +	}
>  	if (!desc)
>  		return -ENOMEM;
>  


