Return-Path: <dmaengine+bounces-662-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5CC81E800
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 16:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B57D1C20B9A
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE284F1F5;
	Tue, 26 Dec 2023 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ/WFyxx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8A4EB35;
	Tue, 26 Dec 2023 15:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB4BC433C8;
	Tue, 26 Dec 2023 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703604643;
	bh=+DXbzpdkr8gy1jHBrPxa1rews3taczzI9G1V+1FZGxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oZ/WFyxxLo4THXqtr3qO8etYffapGkwoFzxmZmrJ+HO+EJ6IsSoL0RZexYf1h2Ydq
	 Izm/eezZbv6G83yFPq7Mb5SSG4xHcrjagA/CudV15eu7/hyl+qjFOIvN6+hcFzn8MG
	 pIEdHaQUuX7o0fzThtdPSc1sHsPWLcsMDMtzk242MhN8Xn7Zlwso2ZVYoJz3UjabrW
	 8zkSQXq8O4YiqEoWiXUAvN6FYwHIU7a8k7UULcXZauDwrbbX5XRxmiCyMaMktCC+sd
	 O02Ey1MXSrJo5zpbSJYB843md3ZUdx8XQ3jNW5eUKoAqi/LUTcYqdUTN6dAkV0Ms9Y
	 bmh3AIaVE76mw==
Date: Tue, 26 Dec 2023 15:30:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>, Lars-Peter Clausen
 <lars@metafoo.de>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Vinod Koul
 <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 6/8] iio: buffer-dma: Enable support for DMABUFs
Message-ID: <20231226153037.1a2052f3@jic23-huawei>
In-Reply-To: <219abc43b4fdd4a13b307ed2efaa0e6869e68e3f.camel@gmail.com>
References: <20231219175009.65482-1-paul@crapouillou.net>
	<20231219175009.65482-7-paul@crapouillou.net>
	<20231221160445.0e3e5a8c@jic23-huawei>
	<219abc43b4fdd4a13b307ed2efaa0e6869e68e3f.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > > +struct iio_dma_buffer_block *
> > > +iio_dma_buffer_attach_dmabuf(struct iio_buffer *buffer,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct dma_buf_attachment *attach)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dma_buffer_queu=
e *queue =3D iio_buffer_to_queue(buffer);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dma_buffer_bloc=
k *block;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&queue->lock); =
=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guard(mutex)(&queue->lo=
ck); =20
>=20
> I'm also a big fan of this new stuff but shouldn't we have a prep patch m=
aking the
> transition to that? Otherwise we'll end up with a mix of styles. I'm happ=
y to clean
> up stuff with follow up patches (even some coding style could be improved=
 IIRC) but
> typically that's not how we handle things like this I believe...

Ideally yes, I think a prep patch would make sense - but I'm not that fussed
about it and follow up patches would be fine here.=20

There are cases for using this that are much easier to justify than
others, so I don't really mind if simple

mutex_lock();
do_something
mutex_unlock();

cases are left for ever not using guard(), though I also don't mind if peop=
le want to use
scoped_guard() or guard for these just to be consistent.  Either way is pre=
tty
easy to read.  We'll probably also continue to gain new uses of this logic =
such
as the conditional guard stuff that is queued up for the next merge window =
and
whilst that is going on we are going to have a bit of mixed style.

Jonathan


>=20
> - Nuno S=C3=A1
> >  =20
>=20


