Return-Path: <dmaengine+bounces-2324-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0FA901563
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 11:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAA12820DE
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5AA1804E;
	Sun,  9 Jun 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh4rp+nY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27BEED8;
	Sun,  9 Jun 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717926953; cv=none; b=fZYRHMh0KJXQUdFRqGKFTc8F3XQpEiLyqHwsD25RP5lZLDRqfDutkLPJp8FBFGVjcJInp1eIofkdTj64A/J4h1a6PFYLe2Mcf7VStedH5boDT2Uneg/7YyBi51pkE38PW6oeTODPMWidhUiiQlH0B4ss9mrtClZzmlPX4w/e55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717926953; c=relaxed/simple;
	bh=J3+LkAlthj2AJZLov9TBAoYftU77dGSFi6J0sALU0co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQb1m9R2eVmPyfMwS/t3W/VPPwnvp3BB0u8R/h9+y/VK1Jts37iYVUivA2c1P3lRUXgnnqtIev1thKF20yI6DZq3SDj3tIG1E2ezntNuma8/Mv0Mhgl/EotyI96WWYPBgJBoWGdLCWgjvAsqpi3DR6LggfgiI+N9sVjnRuX53KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh4rp+nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331BCC2BD10;
	Sun,  9 Jun 2024 09:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717926953;
	bh=J3+LkAlthj2AJZLov9TBAoYftU77dGSFi6J0sALU0co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vh4rp+nYjUUgM1+TcsBri2M5y1fvrGCXzGe1V+fo6MKCK7rJqsTLooYlf65NCjVvt
	 Tt9m3WeDWASFpGNXmjb+rs3eHqJn0RbGDc7ct4c1lAnocGLbGO1mNyycpM6DDVfO1A
	 JeK4MbJisCPaj+nU3ayutUVe9FG1kyr4Jfd6kKDSUl6zrRjcgj8qK67oEjwmCoxIUK
	 1anrNBYEO/rzthGsyH0348ZLzBWlrqQpH7kfnsRkVy+fPsxegcic5G7VnH9hvMGgJu
	 K41rX/QAmAH4t2kwexgm09vL3cgBuu/GvkzWZKe4axa5KScy2nlGDfRI7BgaWhqciu
	 0MgiMFDAimjQw==
Date: Sun, 9 Jun 2024 10:55:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Jonathan Corbet <corbet@lwn.net>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v10 4/6] iio: buffer-dma: Enable support for DMABUFs
Message-ID: <20240609105501.0f836684@jic23-huawei>
In-Reply-To: <20240605110845.86740-5-paul@crapouillou.net>
References: <20240605110845.86740-1-paul@crapouillou.net>
	<20240605110845.86740-5-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 13:08:43 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Implement iio_dma_buffer_attach_dmabuf(), iio_dma_buffer_detach_dmabuf()
> and iio_dma_buffer_transfer_dmabuf(), which can then be used by the IIO
> DMA buffer implementations.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> 
Same thing on SoB.
Also another missing structure field related docs comment inline.

> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index 6e27e47077d5..e54158e53fd6 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -7,6 +7,7 @@
>  #ifndef __INDUSTRIALIO_DMA_BUFFER_H__
>  #define __INDUSTRIALIO_DMA_BUFFER_H__
>  
> +#include <linux/atomic.h>
>  #include <linux/list.h>
>  #include <linux/kref.h>
>  #include <linux/spinlock.h>
> @@ -16,6 +17,9 @@
>  struct iio_dma_buffer_queue;
>  struct iio_dma_buffer_ops;
>  struct device;
> +struct dma_buf_attachment;
> +struct dma_fence;
> +struct sg_table;
>  
>  /**
>   * enum iio_block_state - State of a struct iio_dma_buffer_block
> @@ -41,6 +45,8 @@ enum iio_block_state {
>   * @queue: Parent DMA buffer queue
>   * @kref: kref used to manage the lifetime of block
>   * @state: Current state of the block
> + * @cyclic: True if this is a cyclic buffer
> + * @fileio: True if this buffer is used for fileio mode

kernel doc needs to be complete. So missing attach, sg_table and fence.

>   */
>  struct iio_dma_buffer_block {
>  	/* May only be accessed by the owner of the block */
> @@ -63,6 +69,14 @@ struct iio_dma_buffer_block {
>  	 * queue->list_lock if the block is not owned by the core.
>  	 */
>  	enum iio_block_state state;
> +
> +	bool cyclic;
> +	bool fileio;
> +
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sg_table;
> +
> +	struct dma_fence *fence;
>  };

