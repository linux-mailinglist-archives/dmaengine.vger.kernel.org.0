Return-Path: <dmaengine+bounces-1248-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634C6870423
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E697D28A54F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958DC3FB8B;
	Mon,  4 Mar 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TZ6z4M1T"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0514086B;
	Mon,  4 Mar 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562584; cv=none; b=sJEtbdVzFd0y8AilgnhTBYvVSM9Ax0Je6puRNqJeg1PJRatobW8kdRA48euVJzHsNdVvAIhWe+rUNSoHW8e2DQHSxLVqxPnm6NaXDCY89r6+SZvlYcqhVmw3DSeMmAfWyk1me5DnNUlN/8UXAW/m9Bgy8J1fJp7o/DcdC2WJlH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562584; c=relaxed/simple;
	bh=PsgXuhp8gvxqMJ8KYYR1T1V7KndjQ/+D5kA5wbpyG3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjp6uQNRi+mgl1Wmusp07JYtErSg+OzwdCiWhBnj7Lc17hAKQJ4dC8og2ac/nWE8/+Su15N4/AX5/mWM9Z2sSpAxm+YsRb8tIkN82NlCFHu4EYYvxJlxpFOvjDIGPF72iZjYkVNriNezhQIQU+GnN+WAySr4KO8AG2nEoYj0Ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=TZ6z4M1T; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1709562579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8gifaf3b3BlwROr3n7RVa5Xb7TpNezBfTiKGHCKtLVs=;
	b=TZ6z4M1TItswnh5crJaLe3LLMZS/rqXvAQ0hH+WgQm88q9xNZnOZIpBDpdVkSIoOyVuRy+
	J9iU8F1Tya8e+sjtArbKd0fKF2rVABWNUmYGwjq3Hfs70yhwi1Qz6V3NylqBcofLDZcJP7
	6fKxTaVRmV2YObSXRh6vt8CcS6N2QK8=
Message-ID: <b00a1fc2ea51816317bf7475f32f85696bd29b4e.camel@crapouillou.net>
Subject: Re: [PATCH v7 3/6] iio: core: Add new DMABUF interface
 infrastructure
From: Paul Cercueil <paul@crapouillou.net>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>, Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, linux-doc@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Date: Mon, 04 Mar 2024 15:29:37 +0100
In-Reply-To: <8962f6cf-7e5e-4bfe-a86b-cbb66a815187@amd.com>
References: <20240223-iio-dmabuf-v7-0-78cfaad117b9@analog.com>
	 <20240223-iio-dmabuf-v7-3-78cfaad117b9@analog.com>
	 <85782edb-4876-4cbd-ac14-abcbcfb58770@amd.com>
	 <f40f018359d25c78abbeeb3ce02c5b761aabe900.camel@gmail.com>
	 <796e8189-0e1a-46d4-8251-7963e56704ac@amd.com>
	 <8962f6cf-7e5e-4bfe-a86b-cbb66a815187@amd.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 04 mars 2024 =C3=A0 14:41 +0100, Christian K=C3=B6nig a =C3=A9crit=
=C2=A0:
> Trying to send this once more as text only.
>=20
> Am 04.03.24 um 14:40 schrieb Christian K=C3=B6nig:
> > Am 04.03.24 um 14:28 schrieb Nuno S=C3=A1:
> > > On Mon, 2024-03-04 at 13:44 +0100, Christian K=C3=B6nig wrote:
> > > > Am 23.02.24 um 13:14 schrieb Nuno Sa:
> > > > > From: Paul Cercueil<paul@crapouillou.net>
> > > > >=20
> > > > > Add the necessary infrastructure to the IIO core to support a
> > > > > new
> > > > > optional DMABUF based interface.
> > > > >=20
> > > > > With this new interface, DMABUF objects (externally created)
> > > > > can be
> > > > > attached to a IIO buffer, and subsequently used for data
> > > > > transfer.
> > > > >=20
> > > > > A userspace application can then use this interface to share
> > > > > DMABUF
> > > > > objects between several interfaces, allowing it to transfer
> > > > > data in a
> > > > > zero-copy fashion, for instance between IIO and the USB
> > > > > stack.
> > > > >=20
> > > > > The userspace application can also memory-map the DMABUF
> > > > > objects, and
> > > > > access the sample data directly. The advantage of doing this
> > > > > vs. the
> > > > > read() interface is that it avoids an extra copy of the data
> > > > > between the
> > > > > kernel and userspace. This is particularly userful for high-
> > > > > speed
> > > > > devices which produce several megabytes or even gigabytes of
> > > > > data per
> > > > > second.
> > > > >=20
> > > > > As part of the interface, 3 new IOCTLs have been added:
> > > > >=20
> > > > > IIO_BUFFER_DMABUF_ATTACH_IOCTL(int fd):
> > > > > =C2=A0=C2=A0 Attach the DMABUF object identified by the given fil=
e
> > > > > descriptor to the
> > > > > =C2=A0=C2=A0 buffer.
> > > > >=20
> > > > > IIO_BUFFER_DMABUF_DETACH_IOCTL(int fd):
> > > > > =C2=A0=C2=A0 Detach the DMABUF object identified by the given fil=
e
> > > > > descriptor from
> > > > > =C2=A0=C2=A0 the buffer. Note that closing the IIO buffer's file
> > > > > descriptor will
> > > > > =C2=A0=C2=A0 automatically detach all previously attached DMABUF
> > > > > objects.
> > > > >=20
> > > > > IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
> > > > > =C2=A0=C2=A0 Request a data transfer to/from the given DMABUF obj=
ect.
> > > > > Its file
> > > > > =C2=A0=C2=A0 descriptor, as well as the transfer size and flags a=
re
> > > > > provided in the
> > > > > =C2=A0=C2=A0 "iio_dmabuf" structure.
> > > > >=20
> > > > > These three IOCTLs have to be performed on the IIO buffer's
> > > > > file
> > > > > descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL()
> > > > > ioctl.
> > > > A few nit picks and one bug below, apart from that looks good
> > > > to me.
> > > Hi Christian,
> > >=20
> > > Thanks for looking at it. I'll just add some comment on the bug
> > > below and for
> > > the other stuff I hope Paul is already able to step in and reply
> > > to it. My
> > > assumption (which seems to be wrong) is that the dmabuf bits
> > > should be already
> > > good to go as they should be pretty similar to the USB part of
> > > it.
> > >=20
> > > ...
> > >=20
> > > > > +	if (dma_to_ram) {
> > > > > +		/*
> > > > > +		 * If we're writing to the DMABUF, make sure
> > > > > we don't have
> > > > > +		 * readers
> > > > > +		 */
> > > > > +		retl =3D dma_resv_wait_timeout(dmabuf->resv,
> > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > DMA_RESV_USAGE_READ, true,
> > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0 timeout);
> > > > > +		if (retl =3D=3D 0)
> > > > > +			retl =3D -EBUSY;
> > > > > +		if (retl < 0) {
> > > > > +			ret =3D (int)retl;
> > > > > +			goto err_resv_unlock;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	if (buffer->access->lock_queue)
> > > > > +		buffer->access->lock_queue(buffer);
> > > > > +
> > > > > +	ret =3D dma_resv_reserve_fences(dmabuf->resv, 1);
> > > > > +	if (ret)
> > > > > +		goto err_queue_unlock;
> > > > > +
> > > > > +	dma_resv_add_fence(dmabuf->resv, &fence->base,
> > > > > +			=C2=A0=C2=A0 dma_resv_usage_rw(dma_to_ram));
> > > > That is incorrect use of the function dma_resv_usage_rw(). That
> > > > function
> > > > is for retrieving fences and not adding them.
> > > >=20
> > > > See the function implementation and comments, when you use it
> > > > like this
> > > > you get exactly what you don't want.
> > > >=20
> > > Does that mean that the USB stuff [1] is also wrong?
> > >=20
> > > [1]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/tr
> > > ee/drivers/usb/gadget/function/f_fs.c?h=3Dusb-next#n1669
> >=20
> > Yes, that's broken as well. The dma_resv_usage_rw() function is=20
> > supposed to be used while retrieving fences.

Ok, I'll fix it there too.

> >=20
> > In other words your "if (dma_to_ram) ..." above is incorrect as
> > well.=20
> > That one should look more like this:
> > /*
> > =C2=A0 * Writes needs to wait for other writes and reads, but readers
> > only have to wait for writers.
> > =C2=A0 */
> >=20
> > retl =3D dma_resv_wait_timeout(dmabuf->resv,
> > dma_resv_usage_rw(dma_to_ram), timeout);

When writing the DMABUF, the USB code (and the IIO code above) will
wait for writers/readers, but it does so through two consecutive calls
to dma_resv_wait_timeout (because I did not know the proper usage - I
thought I had to check both manually).

So this code block should technically be correct; but I'll update this
code nonetheless.

> > Regards,
> > Christian.

Cheers,
-Paul

