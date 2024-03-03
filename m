Return-Path: <dmaengine+bounces-1229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E0886F4FA
	for <lists+dmaengine@lfdr.de>; Sun,  3 Mar 2024 14:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9D1B2190F
	for <lists+dmaengine@lfdr.de>; Sun,  3 Mar 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1E9C8DD;
	Sun,  3 Mar 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFS4Wcld"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105EC121;
	Sun,  3 Mar 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471386; cv=none; b=u8B0MbfN3Vkk0L/lSHn7zNlV5JfE/wZOfj+fwvbjeUaG3RhXsSGpLQkp0GTOP2h82UIRCgCnjKcACOIf2pQ1G2XYDp/LEUjY92ycj3a7k+97SnoJU/Dd5J5w/TvoOyO3gXCKoFne+JY3sEju8WeBz5PkJLNOpxDo1h0kJQQMqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471386; c=relaxed/simple;
	bh=vrYalRsEVZ5fLjX42yXSYdIo9++d6kZ4+2yqiD07orw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0oH6VrDhaJSXMKlqcEMWIxmVVK9gqOipHOgH+705Yt1lfvgtd49IpeeWJkXncn7U8qYJNF10wWtir1C8KeXpjh2WnGknwBhja3rhqgwziYbdchdvAlQlGyv0iBR33f4x60+Z9U6MrexS29fJxMWB96fRy8VcF8q7O6xAPTL5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFS4Wcld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDD6C433C7;
	Sun,  3 Mar 2024 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709471386;
	bh=vrYalRsEVZ5fLjX42yXSYdIo9++d6kZ4+2yqiD07orw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TFS4WclduKBieWz1UkcNTKSuCZDyLEdTgFUGthkob7mjSQrWCfm9HvCnDfnyY6qtW
	 MkNYLN/+XpB8K5gsWQPw9jLMIA09LfI+cLBVXF39xCggrkuXWM8et+8sLHBUbBJRqI
	 xDrdrgOWWfgXvxEDr6Gh1WcJHxAOynrX5AmOLrn8EPti9G+E7lNvw6MrWX7xS3wt1a
	 iR5kSIXQa3DC4H0bDcBa/OR87oQv//6vdDCNA27zEcdCrWAQ4BNq4xlKYmmDjJ2gJs
	 prN85/sJhYV3U+JYiPlVPjJGOFuu9uyRmpGARyS0QvQrrLnM99LERQnKwoZHA2+avH
	 8Vgq+BsIhZqhA==
Date: Sun, 3 Mar 2024 13:09:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul
 <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>,
 Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>
Subject: Re: [PATCH v4 5/8] iio: core: Use new helpers from overflow.h in
 iio_device_alloc()
Message-ID: <20240303130928.0c2fea09@jic23-huawei>
In-Reply-To: <9519dda9acd9db009dcb43102cc9b36943b35217.camel@gmail.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
	<20240228204919.3680786-6-andriy.shevchenko@linux.intel.com>
	<9519dda9acd9db009dcb43102cc9b36943b35217.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 16:29:43 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-02-28 at 22:41 +0200, Andy Shevchenko wrote:
> > We have two new helpers struct_size_with_data() and struct_data_pointer=
()
> > that we can utilize in iio_device_alloc(). Do it so.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/industrialio-core.c | 5 ++---
> > =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index 1986b3386307..223013725e32 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1644,7 +1644,7 @@ struct iio_dev *iio_device_alloc(struct device *p=
arent,
> > int sizeof_priv)
> > =C2=A0	size_t alloc_size;
> > =C2=A0
> > =C2=A0	if (sizeof_priv)
> > -		alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN) +
> > sizeof_priv;
> > +		alloc_size =3D struct_size_with_data(iio_dev_opaque,
> > IIO_DMA_MINALIGN, sizeof_priv);
> > =C2=A0	else
> > =C2=A0		alloc_size =3D sizeof(struct iio_dev_opaque);
> > =C2=A0
> > @@ -1655,8 +1655,7 @@ struct iio_dev *iio_device_alloc(struct device *p=
arent,
> > int sizeof_priv)
> > =C2=A0	indio_dev =3D &iio_dev_opaque->indio_dev;
> > =C2=A0
> > =C2=A0	if (sizeof_priv)
> > -		indio_dev->priv =3D (char *)iio_dev_opaque +
> > -			ALIGN(sizeof(struct iio_dev_opaque),
> > IIO_DMA_MINALIGN);
> > +		indio_dev->priv =3D struct_data_pointer(iio_dev_opaque,
> > IIO_DMA_MINALIGN); =20
>=20
> I'd +1 for implementing what Kees suggested in IIO. Only thing is (I thin=
k), we
> need to move struct iio_dev indioo_dev to the end of struct iio_dev_opaqu=
e.

That is going to be messy and without horrible hacks (I think) add more pad=
ding we
don't need.  At the moment the struct iio_dev and the struct iio_dev_opaque
are aligned as at the start of the structure.

The priv data is aligned by padding the larger struct iio_dev_opaque,
so if you want the priv handle to be to data defined in struct iio_dev you =
would
need to add additional padding so that

struct iio_dev_opaque {
	stuff...
	// this next __aligned() is implicit anyway because of the rules for
	// a structure always being aligned to the alignment of it's max aligned
	// element.
	struct iio_dev __aligned (IIO_DMA_ALIGN) { =20
		stuff
		u8 priv[] __aligned(IIO_DMA_ALIGN);
	}
}

How about using what Kees suggests on the iio_dev_opaque (which think is cl=
eaner
anyway as that's what we are allocating) and keeping the magic pointer to p=
riv
in the struct iio_dev; The compiler looses some visibility for iio_priv() a=
ccesses
but can it do much with those anyway? They always get cast to a struct driv=
er_specific *
and getting the original allocation wrong is not easy to do as we pass
that struct size in.  Note, for others not aware of what is going on here, =
the
priv pointer in iio_dev is to allow efficient static inline iio_priv() call=
s without
needing to either make a function call, or expose the internals of the opaq=
ue
structure in which the iio_dev and the priv data are embedded.

Standard pattern is:

struct driver_specific *bob;
struct iio_dev *indio_dev =3D dev_iio_device_alloc(dev, sizeof(*bob));
// which allocates the iio_dev_opaque, but returns the contained iio_dev
bob =3D iio_priv(indio_dev);

So

struct iio_dev_opaque {
	struct iio_dev indio_dev {
		stuff..
		void *priv;=09
	};
	stuff..
	int priv_count;
	u8 priv[] __aligned(IIO_DMA_ALIGN) __counted_by(priv_count);
}
with indio_dev->priv =3D iio_dev_opaque->dev?

This cleanups up a few IIO core bits but no impact outside them.
Nice to have those cleanups.

Is there any way to have that internal iio_dev->priv pointer associated with
a __counted_by even though it's pointing elsewhere than a local variable si=
zed
trailing element? =20

struct iio_dev {
	stuff

	u32 count;
	void *priv __counted_by(count);
}
compiles with gcc but without digging further I have no idea if it does any=
thing useful!

Jonathan

>=20
> - Nuno S=C3=A1
>=20
>=20
>=20


