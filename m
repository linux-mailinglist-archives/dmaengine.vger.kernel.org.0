Return-Path: <dmaengine+bounces-1228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBF486F4E0
	for <lists+dmaengine@lfdr.de>; Sun,  3 Mar 2024 13:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716111F223E7
	for <lists+dmaengine@lfdr.de>; Sun,  3 Mar 2024 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9ABA28;
	Sun,  3 Mar 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyPTK/fQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC18C126;
	Sun,  3 Mar 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470002; cv=none; b=Z67tZzb1TperXPhzT5It8U1wfBk/wSwvyfNcsXo7gBL9X9z7meXyblSGOcyt9HyCBKXCuKzE7LOIG8awG7V2SeiOGnHqcG5+MOC0dweze2MvWzjM39vyJ867sNqM51ZQpL3aThsyudebX6clZsb/4fXJK4uqCmwhjIPKjrAK+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470002; c=relaxed/simple;
	bh=m5F3DC2/abI9jA3wW+kR9QvDGsT+G1mNssyp+xh0lmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzotsNyulXVK56NbEQtaVYs7EBaAIFI9YC0NJqz7vGnnwfb4EyoZ4vKVvNXnlbsMnj0wdQzaCW/cFcmF4F0jIobVbDVMHEC/6xEsYst+43XJw7YZ6J+uFWH3r81v5sDFFl2jzIXnI7E4FySWm2cCvBVv58jEgxTqlQyPTsaW+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyPTK/fQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C5CC433F1;
	Sun,  3 Mar 2024 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709470001;
	bh=m5F3DC2/abI9jA3wW+kR9QvDGsT+G1mNssyp+xh0lmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XyPTK/fQwxL69onm8eIaDU6VACuRpu7F9WG8vDHtYPyXKTynZ5hbgMQ5QG7ZOaBBi
	 kGVuUPZXFQL1h1c+tHlTWvrAdqDqXbCm11ta44wMVNFKlbulg2fkqohdWEf2lkywh7
	 eWTgOEl8ucxxf/ZInRPqalHYwKu73LdfxNlkmDKu4DQfZnmy+74Dk7rOYmZmEU3QWE
	 k329wygF+QIasgaXReW6RkKcud4w0tjOf+RMjEX7fbqPb8dBQ4nYr+SngQJwV7DFXl
	 bzf1/yG2JUIR4BFSwY2cnMoPSqf4EA5GDIwleYrKyiZiFHw+OI23iflbkurFljJKRy
	 6BpyAYP2nWkHg==
Date: Sun, 3 Mar 2024 12:46:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>, Kees Cook
 <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 3/8] iio: core: NULLify private pointer when there is
 no private data
Message-ID: <20240303124624.08740a2d@jic23-huawei>
In-Reply-To: <Zd-na3oVV4Chl4Ft@smile.fi.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
	<20240228204919.3680786-4-andriy.shevchenko@linux.intel.com>
	<CAMknhBFbQ2BmGd18wC0odO-b_bWvJEO3FCYEtpvhB1fF+MEFgg@mail.gmail.com>
	<Zd-na3oVV4Chl4Ft@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 23:36:43 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Feb 28, 2024 at 03:06:42PM -0600, David Lechner wrote:
> > On Wed, Feb 28, 2024 at 2:50=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote: =20
>=20
> ...
>=20
> > > -       indio_dev->priv =3D (char *)iio_dev_opaque +
> > > -               ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN=
);
> > > +
> > > +       if (sizeof_priv)
> > > +               indio_dev->priv =3D (char *)iio_dev_opaque +
> > > +                       ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_=
MINALIGN);
> > > +       else
> > > +               indio_dev->priv =3D NULL; =20
> >=20
> > Do we actually need the else branch here since we use kzalloc() and
> > therefore indio_dev->priv should already be NULL? =20
>=20
> This is more robust, but I'm okay to drop this. Up to Jonathan.
>=20

Given the allocation is just above here fine to drop the else in this
I think.


