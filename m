Return-Path: <dmaengine+bounces-612-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B281BBB2
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF49B22F1A
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC755E4D;
	Thu, 21 Dec 2023 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7JID0qg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B155E43;
	Thu, 21 Dec 2023 16:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788CEC433C7;
	Thu, 21 Dec 2023 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703175349;
	bh=RiMSGgzKIJ2hWpvefMIbapvzTJWfetulkf8+NEdqvv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U7JID0qgL+Hj7Nm/E+Y4eU354Fh4oIXb7v/E0uzIOq9pP0ONsR+WJVW/CGPCcL0Z6
	 yQV589B+xZ9CKBs8eJCDvVloyeRwc+uUdeH7VsCz77tFdA318Tzsj057GLEACEbm3I
	 HUK7fBsCb5gGlEWSot6XE6lNHxGW4PxRJq5f4DLIm0nTLNnPl2My/oi7GLLl780QdJ
	 AvBjWLy1MoXBy+ivmi7RZSeCpMqwniu5Vh6GApTz+cgboEpaBvtISq3x0dsbekaV/M
	 lszpzqoIxypfHLbB67/rFKRbuzIrYXjjZrTaWnZ6AU7tDLtDf+0yLfOcR3ULzHGsOG
	 +vqMx+jZtiuWQ==
Date: Thu, 21 Dec 2023 16:15:31 +0000
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
Subject: Re: [PATCH v5 8/8] Documentation: iio: Document high-speed DMABUF
 based API
Message-ID: <20231221161531.17fcac72@jic23-huawei>
In-Reply-To: <20231219175009.65482-9-paul@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
	<20231219175009.65482-9-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 18:50:09 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Document the new DMABUF based API.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
One minor comment inline.

> 
> ---
> v2: - Explicitly state that the new interface is optional and is
>       not implemented by all drivers.
>     - The IOCTLs can now only be called on the buffer FD returned by
>       IIO_BUFFER_GET_FD_IOCTL.
>     - Move the page up a bit in the index since it is core stuff and not
>       driver-specific.
> 
> v3: Update the documentation to reflect the new API.
> 
> v5: Use description lists for the documentation of the three new IOCTLs
>     instead of abusing subsections.
> ---
>  Documentation/iio/dmabuf_api.rst | 54 ++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst      |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/iio/dmabuf_api.rst
> 
> diff --git a/Documentation/iio/dmabuf_api.rst b/Documentation/iio/dmabuf_api.rst
> new file mode 100644
> index 000000000000..1cd6cd51a582
> --- /dev/null
> +++ b/Documentation/iio/dmabuf_api.rst
> @@ -0,0 +1,54 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================
> +High-speed DMABUF interface for IIO
> +===================================
> +
> +1. Overview
> +===========
> +
> +The Industrial I/O subsystem supports access to buffers through a
> +file-based interface, with read() and write() access calls through the
> +IIO device's dev node.
> +
> +It additionally supports a DMABUF based interface, where the userspace
> +can attach DMABUF objects (externally created) to a IIO buffer, and
> +subsequently use them for data transfers.
> +
> +A userspace application can then use this interface to share DMABUF
> +objects between several interfaces, allowing it to transfer data in a
> +zero-copy fashion, for instance between IIO and the USB stack.
> +
> +The userspace application can also memory-map the DMABUF objects, and
> +access the sample data directly. The advantage of doing this vs. the
> +read() interface is that it avoids an extra copy of the data between the
> +kernel and userspace. This is particularly useful for high-speed devices
> +which produce several megabytes or even gigabytes of data per second.
> +It does however increase the userspace-kernelspace synchronization
> +overhead, as the DMA_BUF_SYNC_START and DMA_BUF_SYNC_END IOCTLs have to
> +be used for data integrity.
> +
> +2. User API
> +===========
> +
> +As part of this interface, three new IOCTLs have been added. These three
> +IOCTLs have to be performed on the IIO buffer's file descriptor,
> +obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.

I would call out that they do not work on the main file descriptor (which
is arguably also a IIO buffer file descriptor).

> +
> +  ``IIO_BUFFER_DMABUF_ATTACH_IOCTL(int)``
> +    Attach the DMABUF object, identified by its file descriptor, to the
> +    IIO buffer. Returns zero on success, and a negative errno value on
> +    error.
> +
> +  ``IIO_BUFFER_DMABUF_DETACH_IOCTL(int)``
> +    Detach the given DMABUF object, identified by its file descriptor,
> +    from the IIO buffer. Returns zero on success, and a negative errno
> +    value on error.
> +
> +    Note that closing the IIO buffer's file descriptor will
> +    automatically detach all previously attached DMABUF objects.
> +
> +  ``IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *iio_dmabuf)``
> +    Enqueue a previously attached DMABUF object to the buffer queue.
> +    Enqueued DMABUFs will be read from (if output buffer) or written to
> +    (if input buffer) as long as the buffer is enabled.


