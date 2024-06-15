Return-Path: <dmaengine+bounces-2374-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F39097E9
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 13:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6988EB21139
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C912C853;
	Sat, 15 Jun 2024 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xOkvf8bk"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD583D96A;
	Sat, 15 Jun 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718450189; cv=none; b=NpvYvRRbBfc5jjlGnBtDcCdzXMdicqb+jYWGA2412M4+VoEzrRl9VoM2G728FaRn2k04QB/39SD+Y1dPlv/P5DZG41gca3y4xOXgmvsBFcHWKTbkJIs1ik1qinRuQ336CUNJLueg6PAOMUyAXHiF8oxwVkVC5lx+3FrhpxRKsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718450189; c=relaxed/simple;
	bh=+qHT3f+/AOb9YgCvAG8VMXIyyDSdraW1NCKmyVQT+/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kv9BU5zVAMkiPSKNyiiNeCSo7LR7n6OH2L4eTHc79FEpizlviRB++yACeVbLEjw+ZAX1wxMo61oCx+EpDDtHhScVbAgtZlJLdqhoIzPa/1xHrEA5A5ilg8P0XFLhNO5EdZ+S9nh2NlzvYNGVDpLBNS+9Iz6oxWeeOTE1ULarSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=xOkvf8bk; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718449679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eE9dplccZ2IeUfRMWTD1T9OavWFDEd5FuUtuIlbIm48=;
	b=xOkvf8bkCrpq2IaS1Ixz5oCY3xoo4+sPUB3J1Vgi3F5n8lrhY0e2cJezGW4bYSxzgzo5YH
	zWxDPcXHUGpw34CyuKIBuN0g2hdVCkA9sP4V2AokcJD10YLd1epRDiNLCC8OTzsJaM7hgC
	3GoD4JmHyWcDyfyqBw2Z4I/eJZV/Lzc=
Message-ID: <0cdcf83a1ab7c199244d4a00157f6fa8979ef819.camel@crapouillou.net>
Subject: Re: [PATCH v10 3/6] iio: core: Add new DMABUF interface
 infrastructure
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Jonathan Corbet <corbet@lwn.net>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Sat, 15 Jun 2024 13:07:58 +0200
In-Reply-To: <20240609105302.07de907a@jic23-huawei>
References: <20240605110845.86740-1-paul@crapouillou.net>
	 <20240605110845.86740-4-paul@crapouillou.net>
	 <20240609105302.07de907a@jic23-huawei>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFC
 qaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IWYXnd
 JO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN70
 62DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOt
 X0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEA
 AYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/
 Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmc
 Gu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2z
 McLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/
 7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2c
 LUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le dimanche 09 juin 2024 =C3=A0 10:53 +0100, Jonathan Cameron a =C3=A9crit=
=C2=A0:
> On Wed,=C2=A0 5 Jun 2024 13:08:42 +0200
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
> > Add the necessary infrastructure to the IIO core to support a new
> > optional DMABUF based interface.
> >=20
> > With this new interface, DMABUF objects (externally created) can be
> > attached to a IIO buffer, and subsequently used for data transfer.
> >=20
> > A userspace application can then use this interface to share DMABUF
> > objects between several interfaces, allowing it to transfer data in
> > a
> > zero-copy fashion, for instance between IIO and the USB stack.
> >=20
> > The userspace application can also memory-map the DMABUF objects,
> > and
> > access the sample data directly. The advantage of doing this vs.
> > the
> > read() interface is that it avoids an extra copy of the data
> > between the
> > kernel and userspace. This is particularly userful for high-speed
> > devices which produce several megabytes or even gigabytes of data
> > per
> > second.
> >=20
> > As part of the interface, 3 new IOCTLs have been added:
> >=20
> > IIO_BUFFER_DMABUF_ATTACH_IOCTL(int fd):
> > =C2=A0Attach the DMABUF object identified by the given file descriptor
> > to the
> > =C2=A0buffer.
> >=20
> > IIO_BUFFER_DMABUF_DETACH_IOCTL(int fd):
> > =C2=A0Detach the DMABUF object identified by the given file descriptor
> > from
> > =C2=A0the buffer. Note that closing the IIO buffer's file descriptor
> > will
> > =C2=A0automatically detach all previously attached DMABUF objects.
> >=20
> > IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
> > =C2=A0Request a data transfer to/from the given DMABUF object. Its file
> > =C2=A0descriptor, as well as the transfer size and flags are provided i=
n
> > the
> > =C2=A0"iio_dmabuf" structure.
> >=20
> > These three IOCTLs have to be performed on the IIO buffer's file
> > descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Need a brief note on the sign off chain.
> What is Nuno's role in this series as he's not sending the emails and
> not
> marked with Co-developed-by=20

That's a good question. I think he sent one revision of the patchset
(v7 or something like that) so he added his SoB.

(Nuno: you confirm?)

I'll add his Co-developed-by then.

Cheers,
-Paul

> I gave this a much more thorough look in earlier versions than I have
> today but
> a few really minor things inline (that I might have fixed up whilst
> applying)
> but looks like you'll be done a v11 for Randy's docs comments anyway
> :(
>=20
> Jonathan
>=20
>=20
> > diff --git a/drivers/iio/industrialio-buffer.c
> > b/drivers/iio/industrialio-buffer.c
> > index 0138b21b244f..c98c8ac83785 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
>=20
> > +struct iio_dmabuf_priv {
> > +	struct list_head entry;
> > +	struct kref ref;
> > +
> > +	struct iio_buffer *buffer;
> > +	struct iio_dma_buffer_block *block;
> > +
> > +	u64 context;
> > +	spinlock_t lock;
>=20
> Given you are going to have a v11, please add a comment to this lock
> to say what data it is protecting.=20
>=20
> > +
> > +	struct dma_buf_attachment *attach;
> > +	struct sg_table *sgt;
> > +	enum dma_data_direction dir;
> > +	atomic_t seqno;
> > +};
>=20
>=20
> > diff --git a/include/linux/iio/buffer_impl.h
> > b/include/linux/iio/buffer_impl.h
> > index 89c3fd7c29ca..1a221c1d7736 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -9,8 +9,12 @@
> > =C2=A0#include <uapi/linux/iio/buffer.h>
> > =C2=A0#include <linux/iio/buffer.h>
> > =C2=A0
> > +struct dma_buf_attachment;
> > +struct dma_fence;
> > =C2=A0struct iio_dev;
> > +struct iio_dma_buffer_block;
> > =C2=A0struct iio_buffer;
> > +struct sg_table;
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * INDIO_BUFFER_FLAG_FIXED_WATERMARK - Watermark level of the
> > buffer can not be
> > @@ -39,6 +43,13 @@ struct iio_buffer;
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device stop=
s sampling. Calles are balanced
> > with @enable.
> > =C2=A0 * @release:		called when the last reference to the
> > buffer is dropped,
> > =C2=A0 *			should free all resources allocated by the
> > buffer.
> > + * @attach_dmabuf:	called from userspace via ioctl to attach
> > one external
> > + *			DMABUF.
> > + * @detach_dmabuf:	called from userspace via ioctl to detach
> > one previously
> > + *			attached DMABUF.
> > + * @enqueue_dmabuf:	called from userspace via ioctl to queue
> > this DMABUF
> > + *			object to this buffer. Requires a valid
> > DMABUF fd, that
> > + *			was previouly attached to this buffer.
>=20
> Missing docs for lock_queue() and unlock_queue()
>=20
> Kernel-doc must be complete or bots are going to moan at us :(
>=20
> > =C2=A0 * @modes:		Supported operating modes by this buffer
> > type
> > =C2=A0 * @flags:		A bitmask combination of
> > INDIO_BUFFER_FLAG_*
> > =C2=A0 *
> > @@ -68,6 +79,17 @@ struct iio_buffer_access_funcs {
> > =C2=A0
> > =C2=A0	void (*release)(struct iio_buffer *buffer);
> > =C2=A0
> > +	struct iio_dma_buffer_block * (*attach_dmabuf)(struct
> > iio_buffer *buffer,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
> > dma_buf_attachment *attach);
> > +	void (*detach_dmabuf)(struct iio_buffer *buffer,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dma_buffer_block *block);
> > +	int (*enqueue_dmabuf)(struct iio_buffer *buffer,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dma_buffer_block *block,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *fence, struct
> > sg_table *sgt,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t size, bool cyclic);
> > +	void (*lock_queue)(struct iio_buffer *buffer);
> > +	void (*unlock_queue)(struct iio_buffer *buffer);
> > +
>=20
>=20


