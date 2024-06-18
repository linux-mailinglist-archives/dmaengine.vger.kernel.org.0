Return-Path: <dmaengine+bounces-2397-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F290C7E4
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 12:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA531C20A9B
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2B1CD5BA;
	Tue, 18 Jun 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="1zHS64/b"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1D15746C;
	Tue, 18 Jun 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702770; cv=none; b=bKyEYjwd+pRRrysRZrT5t6ZMPcf0jJCYHeXaqDS1Te3Wkz26QpyKytmuVXEfdRNG2RL5yj1Q/rm4h3qcgTdv+adhQ+hkrIADHlU2/6R9PEM81sd8t4PcZqellPh/J7K7YveGN9hi2rJJO72jJ30oeaVyJs7wF1/3AgroqCDE5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702770; c=relaxed/simple;
	bh=GCW7NA4dl5Xd1S18xVblRR4uRlpHDpp4NbT+Np6s3/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiuYas1Lt82WrH1tA8EDn00rCFDVca71+BH1MADE6Bx9GsBs2T+N1rkpMnvcM8X2MLT3jGBRtN3RWaXSnxwyYXuRk3pKzq3tztiFhOIj+TszaVMPCWIzNf0ALb8MTmqWperjgqjnh3GVSvxf4M35fwAe8prDfew2br91F3ZB1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=1zHS64/b; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718702760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vXPLlenIHOVNSxchFiFQi3fw6uzbHuydzsC7VVd5GHk=;
	b=1zHS64/bgpAwap7kyt5U4z7WR4EDDIxoqY22qu0YQI2O3XifRrK4zNIuwTYEFuqIWKzqwm
	ifzecavzaf/TxD8N/PWg+YI6BApCdvIJdQi6EAIC+YwCwJYikgL3muFWH05TOODkNzbNrN
	hSdAQ748taP5Coys1FUqn3WmyiG0X5E=
Message-ID: <31c868f86d47195e0658eeafc4d6a2cbb9c013ce.camel@crapouillou.net>
Subject: Re: [PATCH v10 3/6] iio: core: Add new DMABUF interface
 infrastructure
From: Paul Cercueil <paul@crapouillou.net>
To: Markus Elfring <Markus.Elfring@web.de>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
  linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Sumit Semwal <sumit.semwal@linaro.org>, Vinod
 Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 18 Jun 2024 11:25:52 +0200
In-Reply-To: <6a41fd88-5496-462a-86d2-446c2990fcf7@web.de>
References: <20240605110845.86740-4-paul@crapouillou.net>
	 <6a41fd88-5496-462a-86d2-446c2990fcf7@web.de>
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

Hi Markus,

Le lundi 17 juin 2024 =C3=A0 08:56 +0200, Markus Elfring a =C3=A9crit=C2=A0=
:
> =E2=80=A6
> > +++ b/drivers/iio/industrialio-buffer.c
> =E2=80=A6
> > =C2=A0static int iio_buffer_chrdev_release(struct inode *inode, struct
> > file *filep)
> > =C2=A0{
> =E2=80=A6
> > =C2=A0	wake_up(&buffer->pollq);
> >=20
> > +	mutex_lock(&buffer->dmabufs_mutex);
> > +
> > +	/* Close all attached DMABUFs */
> =E2=80=A6
> > +	mutex_unlock(&buffer->dmabufs_mutex);
> > +
> > =C2=A0	kfree(ib);
> =E2=80=A6
>=20
> Would you become interested to apply a statement like
> =E2=80=9Cguard(mutex)(&buffer->dmabufs_mutex);=E2=80=9D?
> https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/mutex.h#L=
196

I'll update the patch to use it.

Cheers,
-Paul

