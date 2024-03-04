Return-Path: <dmaengine+bounces-1244-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAC870296
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 14:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2573289D3B
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37ED3D577;
	Mon,  4 Mar 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br8K210c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68C3D548;
	Mon,  4 Mar 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558688; cv=none; b=uHLKC7kh3NwLU+BQAGpoACtl+kd0601Iq7s/6hR+GwJsYw7xGJ3VxPo6mnM5rzQo9HJa5YjDgwuT4iVyR1oiuEmH2LgfHPbSXb1hsb7LczrkszYe2vQtKUMEINvjy9f5NGS+hBgCOSreTQLXFq4D2Az9bAh0u7DgwHPV+98P2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558688; c=relaxed/simple;
	bh=91KsF95Pc44z+N1UYMz9AwgEqlkAo/OgSNfJQbYvl+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CU6ueNz+keqsS1VLTEcfBhR2c6UcldzXhoDu7ft0lIm3OjkCjmkERYHEK1PrzPYFx8+3xy6LGXh0FRLdk5BddDz6G4FMBhGPIzPoyxHfgdtZ7Ri09XKshngrrd94xU90LIfyrPawDjLaxrfPTBYEeuJOdx+v60uDH1xA5+1aLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br8K210c; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso6359110a12.2;
        Mon, 04 Mar 2024 05:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709558684; x=1710163484; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDGolps/rBe+Ix3AUVTQ7Pu/h2VP38OieQuvyzp7lYE=;
        b=br8K210c84wvEhbJ2voU6qdAuysnMaQnwVYYa6tlqeFWV9ATS6q32q5K5p9JWX6Mx1
         AyQ8YPRCPW5EAy46wXhZFecjY9smE7iZpHJMH5z+G69IyYzO8CGi0kKWkPe/4DPZnpWH
         l9s2A3Wn3uki35ICwYKPMpf+1fbDBbablpA04pDTfOtuX8sn6tGTkWKkOenHk+CA2qjx
         KLs31I8Cn9q3Als89Qd/M7n61/kgMBdsioHS8JmYiJiWbNW2//NQvNKUfy4dWq0izgri
         v5vRS2YaMLlU1ZQIZZ1oB4r7NLfV656OxG0G7EZ0fjWZMHDQhV2u6xUepl3l9U1jOV1g
         bp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558684; x=1710163484;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDGolps/rBe+Ix3AUVTQ7Pu/h2VP38OieQuvyzp7lYE=;
        b=sapY2rpbx/0aihtQrWl84x5+LOtmaLi4wP0QPXSpg4eGi00wUGWlZv4UckXHbqOPN1
         PLPu6t/noGwOrHyOkyRgOkTnN9uEzAhqTXUSaPvMFZZTN5rDfXx2RO4i6So2jcZebwTM
         XI79ELuwqIA87c4NjfF9qGu5Jx4VeW5IRRxkvrZ6bIRNA0n1DSF18qte3OilwFNdQuix
         6umcE1LtNBk2u9lexLHzz+tHwTRljh3BGX2ePRlhRmAvWCV/oMoTohy6iFLjkPA+TP1p
         1eJYSp7fIJTQfC3UGph8DUvYvY3qFn9IPsn2g7LgPCmdDTL1X5g/rhVi/xAPNs8H8CW4
         rUEw==
X-Forwarded-Encrypted: i=1; AJvYcCVtM/uQTkaFDB6728N4iaBw6Ww2/H9w5QGDYVisQ1A5cMx/TSGO37pfjdhSytmwTLFDbiingNRG8U98XSAtpJ8JfBRb6Rq3Fo/nPLhLreqGkoHxuSJEVo4SfAcHtDMFd2sumbcZejgiwAm1iSXpF6WBGLqpHI6F2Gy2xAOaD6OIxO4KwUkr2SkzTjqMDO6CGdaEVtYf23NKwtTbV9c=
X-Gm-Message-State: AOJu0YzKRZOq91E8d3b0wZJ8rJCLTC9DXuuYGx47lhBfs3A8YUB1YS3n
	2L7teo7aeJzQ9BMlDKC+j0h5eaxPbBjjChmmk4oDE4EjIXH1Vypm
X-Google-Smtp-Source: AGHT+IGTFzZaAOkx49PczP3s79h93y2M46UqRDVgG21ZtKP9eanzSUVE1H/HeBSVThdLJlEEEq872A==
X-Received: by 2002:aa7:d597:0:b0:565:6df0:8712 with SMTP id r23-20020aa7d597000000b005656df08712mr6708179edq.22.1709558684113;
        Mon, 04 Mar 2024 05:24:44 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7d34d000000b0056486eaa669sm4630020edr.50.2024.03.04.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:24:43 -0800 (PST)
Message-ID: <f40f018359d25c78abbeeb3ce02c5b761aabe900.camel@gmail.com>
Subject: Re: [PATCH v7 3/6] iio: core: Add new DMABUF interface
 infrastructure
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Nuno Sa
	 <nuno.sa@analog.com>, Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen
	 <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Sumit Semwal
	 <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Paul Cercueil
	 <paul@crapouillou.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, linux-doc@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Date: Mon, 04 Mar 2024 14:28:08 +0100
In-Reply-To: <85782edb-4876-4cbd-ac14-abcbcfb58770@amd.com>
References: <20240223-iio-dmabuf-v7-0-78cfaad117b9@analog.com>
	 <20240223-iio-dmabuf-v7-3-78cfaad117b9@analog.com>
	 <85782edb-4876-4cbd-ac14-abcbcfb58770@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 13:44 +0100, Christian K=C3=B6nig wrote:
> Am 23.02.24 um 13:14 schrieb Nuno Sa:
> > From: Paul Cercueil <paul@crapouillou.net>
> >=20
> > Add the necessary infrastructure to the IIO core to support a new
> > optional DMABUF based interface.
> >=20
> > With this new interface, DMABUF objects (externally created) can be
> > attached to a IIO buffer, and subsequently used for data transfer.
> >=20
> > A userspace application can then use this interface to share DMABUF
> > objects between several interfaces, allowing it to transfer data in a
> > zero-copy fashion, for instance between IIO and the USB stack.
> >=20
> > The userspace application can also memory-map the DMABUF objects, and
> > access the sample data directly. The advantage of doing this vs. the
> > read() interface is that it avoids an extra copy of the data between th=
e
> > kernel and userspace. This is particularly userful for high-speed
> > devices which produce several megabytes or even gigabytes of data per
> > second.
> >=20
> > As part of the interface, 3 new IOCTLs have been added:
> >=20
> > IIO_BUFFER_DMABUF_ATTACH_IOCTL(int fd):
> > =C2=A0 Attach the DMABUF object identified by the given file descriptor=
 to the
> > =C2=A0 buffer.
> >=20
> > IIO_BUFFER_DMABUF_DETACH_IOCTL(int fd):
> > =C2=A0 Detach the DMABUF object identified by the given file descriptor=
 from
> > =C2=A0 the buffer. Note that closing the IIO buffer's file descriptor w=
ill
> > =C2=A0 automatically detach all previously attached DMABUF objects.
> >=20
> > IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
> > =C2=A0 Request a data transfer to/from the given DMABUF object. Its fil=
e
> > =C2=A0 descriptor, as well as the transfer size and flags are provided =
in the
> > =C2=A0 "iio_dmabuf" structure.
> >=20
> > These three IOCTLs have to be performed on the IIO buffer's file
> > descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
>=20
> A few nit picks and one bug below, apart from that looks good to me.

Hi Christian,

Thanks for looking at it. I'll just add some comment on the bug below and f=
or
the other stuff I hope Paul is already able to step in and reply to it. My
assumption (which seems to be wrong) is that the dmabuf bits should be alre=
ady
good to go as they should be pretty similar to the USB part of it.

...

>=20
> > +	if (dma_to_ram) {
> > +		/*
> > +		 * If we're writing to the DMABUF, make sure we don't have
> > +		 * readers
> > +		 */
> > +		retl =3D dma_resv_wait_timeout(dmabuf->resv,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 DMA_RESV_USAGE_READ, true,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 timeout);
> > +		if (retl =3D=3D 0)
> > +			retl =3D -EBUSY;
> > +		if (retl < 0) {
> > +			ret =3D (int)retl;
> > +			goto err_resv_unlock;
> > +		}
> > +	}
> > +
> > +	if (buffer->access->lock_queue)
> > +		buffer->access->lock_queue(buffer);
> > +
> > +	ret =3D dma_resv_reserve_fences(dmabuf->resv, 1);
> > +	if (ret)
> > +		goto err_queue_unlock;
> > +
> > +	dma_resv_add_fence(dmabuf->resv, &fence->base,
> > +			=C2=A0=C2=A0 dma_resv_usage_rw(dma_to_ram));
>=20
> That is incorrect use of the function dma_resv_usage_rw(). That function=
=20
> is for retrieving fences and not adding them.
>=20
> See the function implementation and comments, when you use it like this=
=20
> you get exactly what you don't want.
>=20

Does that mean that the USB stuff [1] is also wrong?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/tree/dr=
ivers/usb/gadget/function/f_fs.c?h=3Dusb-next#n1669

- Nuno S=C3=A1



