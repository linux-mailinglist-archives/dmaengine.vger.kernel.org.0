Return-Path: <dmaengine+bounces-663-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1D81E80C
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E35282891
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C264F20B;
	Tue, 26 Dec 2023 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCA3HxCE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939D4EB42;
	Tue, 26 Dec 2023 15:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F3C433C9;
	Tue, 26 Dec 2023 15:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703604701;
	bh=66d0Qjm7Fhh6A/wpLZlrliai68w6dI1voOKBjpgmcCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iCA3HxCEwVVQ5PfmpFpStLdMS46DrdKGXIGqoPvvohdYyBqmx3+iynDrnt4+2+ft+
	 sYYp+PdUic04XlyN1+79BNu3yurbq/cSX9Vs+IVoZCHAbMO7RcOKQKA1FqDm7GAM82
	 Y6z7ZTRk/FEYZEkZPcfmbuaZa9j8o4P0rThLK9kueWjPdkZwQmQdSfzD4YwWOlpThM
	 Idtx4W2fmw9M5mqBnS/Yvek3w+MZsfF8L3orwag4SBxrP5Ova7yvXknPyIiouff2or
	 sAWwoAdfcIuA8nypYqb7h9joUg30E1a4ccqUjUjQnkj4YMBCOeRhl6IiKde9JeCYSP
	 TQNVu6BGXfy0g==
Date: Tue, 26 Dec 2023 15:31:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Corbet  <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Christian
 =?UTF-8?B?S8O2bmln?=  <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, Vinod Koul  <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Sumit Semwal  <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org
Subject: Re: [PATCH v5 7/8] iio: buffer-dmaengine: Support new DMABUF based
 userspace API
Message-ID: <20231226153134.3e9b8c24@jic23-huawei>
In-Reply-To: <277071605eb355912972a30b07ecead7d70efe25.camel@gmail.com>
References: <20231219175009.65482-1-paul@crapouillou.net>
	<20231219175009.65482-8-paul@crapouillou.net>
	<20231221161258.056f5ce4@jic23-huawei>
	<2da3fb55384a222868f90562be9e1e2ca55ec1c3.camel@crapouillou.net>
	<277071605eb355912972a30b07ecead7d70efe25.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Dec 2023 09:58:29 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-12-21 at 18:30 +0100, Paul Cercueil wrote:
> > Hi Jonathan,
> >=20
> > Le jeudi 21 d=C3=A9cembre 2023 =C3=A0 16:12 +0000, Jonathan Cameron a =
=C3=A9crit=C2=A0: =20
> > > On Tue, 19 Dec 2023 18:50:08 +0100
> > > Paul Cercueil <paul@crapouillou.net> wrote:
> > >  =20
> > > > Use the functions provided by the buffer-dma core to implement the
> > > > DMABUF userspace API in the buffer-dmaengine IIO buffer
> > > > implementation.
> > > >=20
> > > > Since we want to be able to transfer an arbitrary number of bytes
> > > > and
> > > > not necesarily the full DMABUF, the associated scatterlist is
> > > > converted
> > > > to an array of DMA addresses + lengths, which is then passed to
> > > > dmaengine_prep_slave_dma_array().
> > > >=20
> > > > Signed-off-by: Paul Cercueil <paul@crapouillou.net> =20
> > > One question inline. Otherwise looks fine to me.
> > >=20
> > > J =20
> > > >=20
> > > > ---
> > > > v3: Use the new dmaengine_prep_slave_dma_array(), and adapt the
> > > > code to
> > > > =C2=A0=C2=A0=C2=A0 work with the new functions introduced in indust=
rialio-buffer-
> > > > dma.c.
> > > >=20
> > > > v5: - Use the new dmaengine_prep_slave_dma_vec().
> > > > =C2=A0=C2=A0=C2=A0 - Restrict to input buffers, since output buffer=
s are not yet
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported by IIO buffers.
> > > > ---
> > > > =C2=A0.../buffer/industrialio-buffer-dmaengine.c=C2=A0=C2=A0=C2=A0 =
| 52
> > > > ++++++++++++++++---
> > > > =C2=A01 file changed, 46 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > index 5f85ba38e6f6..825d76a24a67 100644
> > > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > @@ -64,15 +64,51 @@ static int
> > > > iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue
> > > > *queue,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dmaengine_bu=
ffer *dmaengine_buffer =3D
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_buffer_to_dmaengine_buffer(&queue->buffer=
);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dma_async_tx=
_descriptor *desc;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i, nents;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct scatterlist *sgl;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dma_vec *vecs;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t max_size;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_cookie_t cookie;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t len_total;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->bytes_used =3D mi=
n(block->size, dmaengine_buffer- =20
> > > > > max_size); =20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->bytes_used =3D ro=
und_down(block->bytes_used,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma=
engine_buffer->align);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (queue->buffer.direct=
ion !=3D IIO_BUFFER_DIRECTION_IN) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* We do not yet support output buffers. */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0desc =3D dmaengine_prep_=
slave_single(dmaengine_buffer->chan,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0block->phys_addr, block->bytes_used,
> > > > DMA_DEV_TO_MEM,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0DMA_PREP_INTERRUPT);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (block->sg_table) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgl =3D block->sg_table->sgl;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0nents =3D sg_nents_for_len(sgl, block->bytes_used);=
 =20
> > >=20
> > > Are we guaranteed the length in the sglist is enough?=C2=A0 If not th=
is
> > > can return an error code. =20
> >=20
> > The length of the sglist will always be enough, the
> > iio_buffer_enqueue_dmabuf() function already checks that block- =20
> > > bytes_used is equal or smaller than the size of the DMABUF. =20
> >=20
> > It is quite a few functions above in the call stack though, so I can
> > handle the errors of sg_nents_for_len() here if you think makes sense. =
=20
>=20
> Maybe putting something like the above in a comment?
Either comment, or an explicit check so we don't need the comment is
fine as far as I'm concerned.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
>=20


