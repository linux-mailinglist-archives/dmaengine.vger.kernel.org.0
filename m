Return-Path: <dmaengine+bounces-2322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A439013FB
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 01:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F211F21FEE
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2024 23:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA43DB89;
	Sat,  8 Jun 2024 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5SLxSs0"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27324B28;
	Sat,  8 Jun 2024 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717890279; cv=none; b=A4F0yiBaFk3VuA/8tsSCX9PmXupoO5mLhbeS57dr8Dle9BPgCGhNA1fZZNHoofk0PSrrV0mVYhRm2fSp/lVH9DQv0zm45aQ3Xla0OLhYV0wpVkyYWO0UkQqfm5aA3rZSKnddV3nXly5pYNqWD67wCvskmpi8Omj1Pe9W5HolI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717890279; c=relaxed/simple;
	bh=TfZnoATFHHsKtckujopS8nC7+AmIssqSCa1UW2djo80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqeAFZeJq9w6CRKhMpz65MnRyylOrZFa4/e9LN5xnspN2jfOB52uJXhx/JVeNfwJuAt285ymsAABuPpU9pjyz1Y7gJ5eb7QAVoEVtNgUD6l6KLWqQM2vtkmbiYiU905K0o/GZ3bGbR1T4eX2sBMj/PVnhMSLPJM+zcvY1HpwC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r5SLxSs0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=V9bl0X2EUcg+/xnMVivcRgLaDT642pZxVyxB/8arGRo=; b=r5SLxSs0teVt0heVXrFiXPTwyh
	tCLqTim0yTaGhz3n/W/2p7hFcf8NukTwA46KXmiIP0XpsC6luaUevq140h1890113yB57+n+KfNmO
	uN+xa0Yg1MYqwi1EE/ceYNRdisVm9L3N0TJqI1n7GevQ1kmHjiPoEVZvm9wdyw1jekPEAUh0EzZgg
	2JR88baihne8VB2a/uqyTXjLRapVYx1feB46Is8C9rdo2fEoqnTt0v3LgCZZg4K9j245kznxHtjwH
	6glUe7oqvDFGJvTAE1RevWQtoE+rHuvfYslN2Bn6XioLEIA2LuQdU5IWXPAFzbyVXHAAvdE9ENGIw
	gJ6u7X3Q==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sG5jW-00000001Dol-2nQv;
	Sat, 08 Jun 2024 23:44:26 +0000
Message-ID: <efbd5520-5eaa-49ab-817f-ae27172f8ceb@infradead.org>
Date: Sat, 8 Jun 2024 16:44:24 -0700
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
 <5052adab-5b5e-4ac2-902c-bb373c00bbbb@infradead.org>
 <14d802e84cbb8d3c9610386908706f264af34726.camel@crapouillou.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <14d802e84cbb8d3c9610386908706f264af34726.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paul.

On 6/7/24 12:44 AM, Paul Cercueil wrote:
> Hi Randy,
> 
> Le jeudi 06 juin 2024 à 10:32 -0700, Randy Dunlap a écrit :
>> Hi,
>>
>> On 6/5/24 4:08 AM, Paul Cercueil wrote:
>>> Document the new DMABUF based API.
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>>>
>>> ---
>>> v2: - Explicitly state that the new interface is optional and is
>>>       not implemented by all drivers.
>>>     - The IOCTLs can now only be called on the buffer FD returned
>>> by
>>>       IIO_BUFFER_GET_FD_IOCTL.
>>>     - Move the page up a bit in the index since it is core stuff
>>> and not
>>>       driver-specific.
>>>
>>> v3: Update the documentation to reflect the new API.
>>>
>>> v5: Use description lists for the documentation of the three new
>>> IOCTLs
>>>     instead of abusing subsections.
>>>
>>> v8: Renamed dmabuf_api.rst -> iio_dmabuf_api.rst, and updated
>>> index.rst
>>>     whose format changed in iio/togreg.
>>> ---
>>>  Documentation/iio/iio_dmabuf_api.rst | 54
>>> ++++++++++++++++++++++++++++
>>>  Documentation/iio/index.rst          |  1 +
>>>  2 files changed, 55 insertions(+)
>>>  create mode 100644 Documentation/iio/iio_dmabuf_api.rst
>>>
>>> diff --git a/Documentation/iio/iio_dmabuf_api.rst
>>> b/Documentation/iio/iio_dmabuf_api.rst
>>> new file mode 100644
>>> index 000000000000..1cd6cd51a582
>>> --- /dev/null
>>> +++ b/Documentation/iio/iio_dmabuf_api.rst
>>> @@ -0,0 +1,54 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +===================================
>>> +High-speed DMABUF interface for IIO
>>> +===================================
>>> +
>>> +1. Overview
>>> +===========
>>> +
>>> +The Industrial I/O subsystem supports access to buffers through a
>>> +file-based interface, with read() and write() access calls through
>>> the
>>> +IIO device's dev node.
>>> +
>>> +It additionally supports a DMABUF based interface, where the
>>> userspace
>>> +can attach DMABUF objects (externally created) to a IIO buffer,
>>> and
>>
>> I would say/write:                                to an IIO buffer,
> 
> Right.
> 
>>> +subsequently use them for data transfers.
>>> +
>>> +A userspace application can then use this interface to share
>>> DMABUF
>>> +objects between several interfaces, allowing it to transfer data
>>> in a
>>> +zero-copy fashion, for instance between IIO and the USB stack.
>>> +
>>> +The userspace application can also memory-map the DMABUF objects,
>>> and
>>> +access the sample data directly. The advantage of doing this vs.
>>> the
>>> +read() interface is that it avoids an extra copy of the data
>>> between the
>>> +kernel and userspace. This is particularly useful for high-speed
>>> devices
>>> +which produce several megabytes or even gigabytes of data per
>>> second.
>>> +It does however increase the userspace-kernelspace synchronization
>>> +overhead, as the DMA_BUF_SYNC_START and DMA_BUF_SYNC_END IOCTLs
>>> have to
>>> +be used for data integrity.
>>> +
>>> +2. User API
>>> +===========
>>> +
>>> +As part of this interface, three new IOCTLs have been added. These
>>> three
>>> +IOCTLs have to be performed on the IIO buffer's file descriptor,
>>> +obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
>>> +
>>> +  ``IIO_BUFFER_DMABUF_ATTACH_IOCTL(int)``
>>
>>                                      (int fd)
>> ?
> 
> Yes, I can change that. Although it's very obvious what the "int" is
> for, given the text above.
> 

Yes. This is just to be consistent with the text below:

+  ``IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *iio_dmabuf)``

>>
>>> +    Attach the DMABUF object, identified by its file descriptor,
>>> to the
>>> +    IIO buffer. Returns zero on success, and a negative errno
>>> value on
>>> +    error.
>>> +
>>> +  ``IIO_BUFFER_DMABUF_DETACH_IOCTL(int)``
>>
>> ditto.
>>
>>> +    Detach the given DMABUF object, identified by its file
>>> descriptor,
>>> +    from the IIO buffer. Returns zero on success, and a negative
>>> errno
>>> +    value on error.
>>> +
>>> +    Note that closing the IIO buffer's file descriptor will
>>> +    automatically detach all previously attached DMABUF objects.
>>> +
>>> +  ``IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf
>>> *iio_dmabuf)``
>>> +    Enqueue a previously attached DMABUF object to the buffer
>>> queue.
>>> +    Enqueued DMABUFs will be read from (if output buffer) or
>>> written to
>>> +    (if input buffer) as long as the buffer is enabled.
>>
>> thanks.
> 
> Cheers,
> -Paul

thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

