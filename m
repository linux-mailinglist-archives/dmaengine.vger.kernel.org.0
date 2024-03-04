Return-Path: <dmaengine+bounces-1247-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F48703E5
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 15:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8509A1F2115D
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CA3FB19;
	Mon,  4 Mar 2024 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="S/5sJpLz"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948A3FB0F;
	Mon,  4 Mar 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562048; cv=none; b=R+Dds2s8BpI7RsLpe37AhgmU9wyKJWVXecrHYf4wvmekRm30Kgc/FtfJF+e4yhnzgQ3iPfYvijPREQZvRXrd+DPZ6EeA07OH14cwJyHpR0mtzwAnzpqaT/youEQrNR2GJy0braC99SETNGAHzfrkX+TylBB+gQBmXRtmIMYN200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562048; c=relaxed/simple;
	bh=pKy5pU+Eo7irYeotj9cWui+l2HeyGOhLSFnZS3avHmo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1hItIYfObQVcWgme6RpOGt7Pm4Xy7l5NldUwnsIjpev4wQmOswF5vVslNykp0Hv7f1yHwGbVEH4icYAniAVkyqlhcZPvxmdr6nhuMpBsNFGRv1+60pi6asOTaLfIdBr7+QflK3Y9XDnwm7VofiM+FFXi+8IYyEKyNV8CEARgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=S/5sJpLz; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1709562044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NF/1gTwR111FGU1RQbqHeXbtTmbO0DDWWwYzwfIsjFs=;
	b=S/5sJpLzsAOufi2PtMIeKIsXCwdv1EfSd1fACtXxpwlKGJgUbTUa6L7F7btXW30BGWIkrt
	uZehPHva50vpgexAn0g1IdUJfQtaC4VX4QkDOGhSsII2DfiZFAW78I+AU4aECPqi29PiHG
	jvq0f6UxYF3VGEepStCbMXQxlNN6HHA=
Message-ID: <b46deb887cd9d181931fd5a9c0914debd0b666fb.camel@crapouillou.net>
Subject: Re: [PATCH v7 3/6] iio: core: Add new DMABUF interface
 infrastructure
From: Paul Cercueil <paul@crapouillou.net>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Nuno Sa
	 <nuno.sa@analog.com>, Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen
	 <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Sumit Semwal
	 <sumit.semwal@linaro.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, linux-doc@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Date: Mon, 04 Mar 2024 15:20:42 +0100
In-Reply-To: <63f8a0f5-55a4-47c9-99d7-bb0b8ad22b3a@amd.com>
References: <20240223-iio-dmabuf-v7-0-78cfaad117b9@analog.com>
	 <20240223-iio-dmabuf-v7-3-78cfaad117b9@analog.com>
	 <85782edb-4876-4cbd-ac14-abcbcfb58770@amd.com>
	 <d17bd8aa17ac82773d0bdd6ce4edfe4a6249f179.camel@crapouillou.net>
	 <63f8a0f5-55a4-47c9-99d7-bb0b8ad22b3a@amd.com>
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

Le lundi 04 mars 2024 =C3=A0 15:07 +0100, Christian K=C3=B6nig a =C3=A9crit=
=C2=A0:
> =C2=A0Am 04.03.24 um 14:59 schrieb Paul Cercueil:
> =C2=A0
> > [SNIP]
> > =C2=A0
> > > =C2=A0
> > > > =C2=A0
> > > > +	dma_to_ram =3D buffer->direction =3D=3D
> > > > IIO_BUFFER_DIRECTION_IN;
> > > > +
> > > > +	if (dma_to_ram) {
> > > > +		/*
> > > > +		 * If we're writing to the DMABUF, make sure
> > > > we
> > > > don't have
> > > > +		 * readers
> > > > +		 */
> > > > +		retl =3D dma_resv_wait_timeout(dmabuf->resv,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0
> > > > DMA_RESV_USAGE_READ,
> > > > true,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0 timeout);
> > > > +		if (retl =3D=3D 0)
> > > > +			retl =3D -EBUSY;
> > > > +		if (retl < 0) {
> > > > +			ret =3D (int)retl;
> > > > +			goto err_resv_unlock;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (buffer->access->lock_queue)
> > > > +		buffer->access->lock_queue(buffer);
> > > > +
> > > > +	ret =3D dma_resv_reserve_fences(dmabuf->resv, 1);
> > > > +	if (ret)
> > > > +		goto err_queue_unlock;
> > > > +
> > > > +	dma_resv_add_fence(dmabuf->resv, &fence->base,
> > > > +			=C2=A0=C2=A0 dma_resv_usage_rw(dma_to_ram));
> > > > =C2=A0
> > > =C2=A0
> > > That is incorrect use of the function dma_resv_usage_rw(). That
> > > function=20
> > > is for retrieving fences and not adding them.
> > >=20
> > > See the function implementation and comments, when you use it
> > > like
> > > this=20
> > > you get exactly what you don't want.
> > >=20
> >=20
> > No, I get exactly what I want. If "dma_to_ram", I get
> > DMA_RESV_USAGE_READ, otherwise I get DMA_RESV_USAGE_WRITE.
> >=20
>=20
> =C2=A0Ah, so basically !dma_to_ram means that you have a write access to
> the buffer?
> =C2=A0

"dma_to_ram" means the data flows from the DMA to the RAM.

... Which means that it writes the buffer, so you are right, this is
wrong.

> >=20
> > If you really don't like the macro, I can inline things here.
>=20
> =C2=A0Yeah, that would still be incorrect use.
> =C2=A0
> =C2=A0The dma__resv_usage_rw() is for retrieving the fences to sync to fo=
r
> read and write operations and should never be used together with
> dma_fence_resv_add().
>=20

Ok, I'll inline it (and fix it) then.

Cheers,
-Paul

