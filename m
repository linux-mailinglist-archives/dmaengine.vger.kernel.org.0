Return-Path: <dmaengine+bounces-2323-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3990155E
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 11:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2092AB21257
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA751CD35;
	Sun,  9 Jun 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIEEKDMr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C8EED8;
	Sun,  9 Jun 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717926822; cv=none; b=CbtAypBtOgLiV/VsU3UWMFxys+maXCRm7FeZc/IhyyHZKFyDGc/LG4FygMuc5j1ltS/Cs7EqNHPE8bpYOlF/xoZj1expjhJrLYFwJ6x6kXXyhMrqA9II500P5uSvyH6O1BnmRc0WUcszezhYCvdYvlwE7KN4px1y3orPGzS386c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717926822; c=relaxed/simple;
	bh=Fx1CFy/u8QJt4DN2buBsiMU8aZaiixCcuBcpda3WzMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDYkCHoT9szSMLO/Zm5mMYXoxoW3RWaThq1/71NZv8AfE67OrkBE7b657zoAF7DtLpBMGFTDeQPaV7c9zFJ8wwkqfhpor152ryVhVNzE/TejhhKbp/2zHxhh/1by0ML4c6ijKfJseelN05VT60s2p73rnoayL3F+1L6VQMixaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIEEKDMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA36C2BD10;
	Sun,  9 Jun 2024 09:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717926822;
	bh=Fx1CFy/u8QJt4DN2buBsiMU8aZaiixCcuBcpda3WzMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bIEEKDMrec9mguFYy0W/Btn/AQPGRsat5rKnIcsWo/4LRpQEFgOf5fYrOT7Jh+AnT
	 PWu5Nr/9LceG/yyf4465Q3CdvfLLdQqYm9a9pVTtxg80DmMl1ue90d0wY/tNc9OXxz
	 yQuRFxnJfrPAut+LkX7kbwxZ17wruMRfsRNNuTv/bqaMhd5/8v9Tn0J9XgWFdgIwG4
	 zITp4K328Nots1/H9Zm/RtHeHfJ6zs7FWDcv8KVkeA3rr/A6WJQjIHYrxYyUIQb7pA
	 Zu4HW1443zO62SM0+oHq6vAJAk1Ot7fyvZHgafvWQuDdWnamfRzuMU2MXf94+fH+cb
	 ELV29zWwcNMJw==
Date: Sun, 9 Jun 2024 10:53:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Jonathan Corbet <corbet@lwn.net>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v10 3/6] iio: core: Add new DMABUF interface
 infrastructure
Message-ID: <20240609105302.07de907a@jic23-huawei>
In-Reply-To: <20240605110845.86740-4-paul@crapouillou.net>
References: <20240605110845.86740-1-paul@crapouillou.net>
	<20240605110845.86740-4-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 13:08:42 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Add the necessary infrastructure to the IIO core to support a new
> optional DMABUF based interface.
> 
> With this new interface, DMABUF objects (externally created) can be
> attached to a IIO buffer, and subsequently used for data transfer.
> 
> A userspace application can then use this interface to share DMABUF
> objects between several interfaces, allowing it to transfer data in a
> zero-copy fashion, for instance between IIO and the USB stack.
> 
> The userspace application can also memory-map the DMABUF objects, and
> access the sample data directly. The advantage of doing this vs. the
> read() interface is that it avoids an extra copy of the data between the
> kernel and userspace. This is particularly userful for high-speed
> devices which produce several megabytes or even gigabytes of data per
> second.
> 
> As part of the interface, 3 new IOCTLs have been added:
> 
> IIO_BUFFER_DMABUF_ATTACH_IOCTL(int fd):
>  Attach the DMABUF object identified by the given file descriptor to the
>  buffer.
> 
> IIO_BUFFER_DMABUF_DETACH_IOCTL(int fd):
>  Detach the DMABUF object identified by the given file descriptor from
>  the buffer. Note that closing the IIO buffer's file descriptor will
>  automatically detach all previously attached DMABUF objects.
> 
> IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
>  Request a data transfer to/from the given DMABUF object. Its file
>  descriptor, as well as the transfer size and flags are provided in the
>  "iio_dmabuf" structure.
> 
> These three IOCTLs have to be performed on the IIO buffer's file
> descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Need a brief note on the sign off chain.
What is Nuno's role in this series as he's not sending the emails and not
marked with Co-developed-by 

I gave this a much more thorough look in earlier versions than I have today but
a few really minor things inline (that I might have fixed up whilst applying)
but looks like you'll be done a v11 for Randy's docs comments anyway :(

Jonathan


> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 0138b21b244f..c98c8ac83785 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c

> +struct iio_dmabuf_priv {
> +	struct list_head entry;
> +	struct kref ref;
> +
> +	struct iio_buffer *buffer;
> +	struct iio_dma_buffer_block *block;
> +
> +	u64 context;
> +	spinlock_t lock;

Given you are going to have a v11, please add a comment to this lock
to say what data it is protecting. 

> +
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +	enum dma_data_direction dir;
> +	atomic_t seqno;
> +};


> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 89c3fd7c29ca..1a221c1d7736 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -9,8 +9,12 @@
>  #include <uapi/linux/iio/buffer.h>
>  #include <linux/iio/buffer.h>
>  
> +struct dma_buf_attachment;
> +struct dma_fence;
>  struct iio_dev;
> +struct iio_dma_buffer_block;
>  struct iio_buffer;
> +struct sg_table;
>  
>  /**
>   * INDIO_BUFFER_FLAG_FIXED_WATERMARK - Watermark level of the buffer can not be
> @@ -39,6 +43,13 @@ struct iio_buffer;
>   *                      device stops sampling. Calles are balanced with @enable.
>   * @release:		called when the last reference to the buffer is dropped,
>   *			should free all resources allocated by the buffer.
> + * @attach_dmabuf:	called from userspace via ioctl to attach one external
> + *			DMABUF.
> + * @detach_dmabuf:	called from userspace via ioctl to detach one previously
> + *			attached DMABUF.
> + * @enqueue_dmabuf:	called from userspace via ioctl to queue this DMABUF
> + *			object to this buffer. Requires a valid DMABUF fd, that
> + *			was previouly attached to this buffer.

Missing docs for lock_queue() and unlock_queue()

Kernel-doc must be complete or bots are going to moan at us :(

>   * @modes:		Supported operating modes by this buffer type
>   * @flags:		A bitmask combination of INDIO_BUFFER_FLAG_*
>   *
> @@ -68,6 +79,17 @@ struct iio_buffer_access_funcs {
>  
>  	void (*release)(struct iio_buffer *buffer);
>  
> +	struct iio_dma_buffer_block * (*attach_dmabuf)(struct iio_buffer *buffer,
> +						       struct dma_buf_attachment *attach);
> +	void (*detach_dmabuf)(struct iio_buffer *buffer,
> +			      struct iio_dma_buffer_block *block);
> +	int (*enqueue_dmabuf)(struct iio_buffer *buffer,
> +			      struct iio_dma_buffer_block *block,
> +			      struct dma_fence *fence, struct sg_table *sgt,
> +			      size_t size, bool cyclic);
> +	void (*lock_queue)(struct iio_buffer *buffer);
> +	void (*unlock_queue)(struct iio_buffer *buffer);
> +



