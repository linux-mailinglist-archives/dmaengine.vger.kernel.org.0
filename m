Return-Path: <dmaengine+bounces-2296-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488568FF3CF
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 19:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468FE1C265D1
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2024 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD36198E86;
	Thu,  6 Jun 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YjgG7Vov"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BDD15253E;
	Thu,  6 Jun 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695179; cv=none; b=uSrg/wd4/MolU5TGC3kyMEBmXjAEJ0r6/RO6aDf89WemRPnqTSJJ8Y5sFLc5fPGCRfmLJflkHealzbbp2bRHiELTCIZw3BC02GMMZybGIdLw4CDvLMZzXWM47nI9KrsHl4JSN/T17L0dQ6FCw3pYUFvx04E+l9EY8efEv/uzOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695179; c=relaxed/simple;
	bh=tvNSjOg8mx3j+RpQ0huRviLFFC0DGjMakF1YpHzl9p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDVzI9hsV9VIW3WwO61FpEk1Dyn6/o9dFv9hRYYZyJMT4wzben+HEm0gw9J6VX2P8X87oyCPB5daqwxpVh7D05vhSFUd2kFw3jc37IMCooy2Zy1YtfHkhIyfpyb/1W/2sESL6Z3Uavdn2np+Q339vw5tBlv9J7EJ0mcqbk3jquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YjgG7Vov; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6C3828TkhUBt3LMHxNw+f5eKbQSK74nm3cDfcfA+ESQ=; b=YjgG7Vov4whzGWtff+CpF/oKgO
	S3i5UR/b7npg7U4tVrxl3/D4ZmVvyFwLuag78KKpUhLwsakb4RRuKd+b+fvTmuvICnqfNxp6Mmwb+
	m8qm8ei8eE7zOW7hJpzGnDF/99H35cAwMFrDaHJ8pWLHqwo3ULZoC6aVMUzDzpK3UgH+tt+fio3q+
	rfntirFQ7pDVbXz+c05AEXWBLgme0hSzKmAmCpLaKc9pxe2XJgMaZm/2lF17eM9JfIjJOewvm84eV
	cloM0LYjQ5T2r2CcHxsslcAhPDYArfm4Kf+iQ9Ddu3DECTWahfCAv33BCBI6HW4F9kNSNrdMmQtEE
	ZTzE5uxg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFGyq-0000000Alrg-33v6;
	Thu, 06 Jun 2024 17:32:52 +0000
Message-ID: <5052adab-5b5e-4ac2-902c-bb373c00bbbb@infradead.org>
Date: Thu, 6 Jun 2024 10:32:51 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/6] Documentation: iio: Document high-speed DMABUF
 based API
To: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Vinod Koul <vkoul@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240605110845.86740-1-paul@crapouillou.net>
 <20240605110845.86740-7-paul@crapouillou.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240605110845.86740-7-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/5/24 4:08 AM, Paul Cercueil wrote:
> Document the new DMABUF based API.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
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
> 
> v8: Renamed dmabuf_api.rst -> iio_dmabuf_api.rst, and updated index.rst
>     whose format changed in iio/togreg.
> ---
>  Documentation/iio/iio_dmabuf_api.rst | 54 ++++++++++++++++++++++++++++
>  Documentation/iio/index.rst          |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/iio/iio_dmabuf_api.rst
> 
> diff --git a/Documentation/iio/iio_dmabuf_api.rst b/Documentation/iio/iio_dmabuf_api.rst
> new file mode 100644
> index 000000000000..1cd6cd51a582
> --- /dev/null
> +++ b/Documentation/iio/iio_dmabuf_api.rst
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

I would say/write:                                to an IIO buffer,

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
> +
> +  ``IIO_BUFFER_DMABUF_ATTACH_IOCTL(int)``

                                     (int fd)
?

> +    Attach the DMABUF object, identified by its file descriptor, to the
> +    IIO buffer. Returns zero on success, and a negative errno value on
> +    error.
> +
> +  ``IIO_BUFFER_DMABUF_DETACH_IOCTL(int)``

ditto.

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

thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

