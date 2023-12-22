Return-Path: <dmaengine+bounces-636-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B381C6FD
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 09:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D827F1C22187
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6DD2F4;
	Fri, 22 Dec 2023 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFMgGrcA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36931CA65;
	Fri, 22 Dec 2023 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so19932025e9.2;
        Fri, 22 Dec 2023 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703235509; x=1703840309; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cI35bX0Nhe6pNuZytaRMQzlreBpUdOzZVZdkSiKR318=;
        b=XFMgGrcAWhzJDMD0P2kapwOyfxCAHG5hbloyRcTb+gB9xpPdt7yYsESLWuIHCoYvhP
         uAlIbA8NV1T/UkyJM41M3pcpsB7QSPBwDK7A1kuVXN23ZbpvcHOqureVPhBsOu6+8LwU
         cGkAC/wHTxoEt4dYhsoNhDIynjKgvz7Fd7/krTLEJHfWEBqaFBC2QE4OQw4DOR3pcluV
         PWGzDIbRkMviuVh96GCLW5dWBND2fMFmDL+cH+DRa0Ihtnjau1PkvnObDgkFBlK2EKz3
         qBHVgZE+StZ97BnukzK0vaj4pCZH4mN0sD2+dQkqeJeMk7/U3xWJMoq7nsbtz0crXaYX
         kZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703235509; x=1703840309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cI35bX0Nhe6pNuZytaRMQzlreBpUdOzZVZdkSiKR318=;
        b=RvtEsGW52bknRPLqK3pefibZVWPxKcGpJiGp/2vB/qspBz4XxA4wNSw3d14FFjwWZL
         EtI0vFipAMw8WTT8oSkAlZbDUulS7BM3TptlR2N3OcO40zgqY45l6GniWckBa1I3UuJw
         236gbVtnsE7InBF0RY7RHC7qSTnWQjf5R9gBv/rrEquh1TeeYBL1kcWHWD7RJus+0qkL
         zW4xPR6+KRyJqFU4JBxweqC0kZn5fPn0l1wDyMVAngUTvDX342eODxlmjx4uvzkKp7C7
         JivQ7p95zzalg31cvzXKlh5smzj2WXPkZZvkIhrKrLT397jLzUnssjg/VEMI9KuG0vTC
         rRjw==
X-Gm-Message-State: AOJu0Yx6iIFQdxGdiHsVokjNCkXsdu93rZBLPJ5w8IfmFGUtVeGQTaPA
	4YimbV6aN6ZKrvQWm0dmD9IbhKl7fvTSm7YUNMY=
X-Google-Smtp-Source: AGHT+IHxUXolvNOrzYP2sehmaGu4dpOV/paRm80lFYTwBFEv14pGkL6zMlGQe6zd/u5nBBYzi0u5pA==
X-Received: by 2002:a05:600c:3d0f:b0:40d:43cf:275d with SMTP id bh15-20020a05600c3d0f00b0040d43cf275dmr535638wmb.95.1703235508788;
        Fri, 22 Dec 2023 00:58:28 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:5877:261e:1d6d:8696? ([2001:818:ea8e:7f00:5877:261e:1d6d:8696])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c350700b0040d2e37c06dsm6120316wmq.20.2023.12.22.00.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:58:28 -0800 (PST)
Message-ID: <277071605eb355912972a30b07ecead7d70efe25.camel@gmail.com>
Subject: Re: [PATCH v5 7/8] iio: buffer-dmaengine: Support new DMABUF based
 userspace API
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Corbet
	 <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Christian
	=?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, linaro-mm-sig@lists.linaro.org, Vinod Koul
	 <vkoul@kernel.org>, dmaengine@vger.kernel.org, Sumit Semwal
	 <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Date: Fri, 22 Dec 2023 09:58:29 +0100
In-Reply-To: <2da3fb55384a222868f90562be9e1e2ca55ec1c3.camel@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
	 <20231219175009.65482-8-paul@crapouillou.net>
	 <20231221161258.056f5ce4@jic23-huawei>
	 <2da3fb55384a222868f90562be9e1e2ca55ec1c3.camel@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-21 at 18:30 +0100, Paul Cercueil wrote:
> Hi Jonathan,
>=20
> Le jeudi 21 d=C3=A9cembre 2023 =C3=A0 16:12 +0000, Jonathan Cameron a =C3=
=A9crit=C2=A0:
> > On Tue, 19 Dec 2023 18:50:08 +0100
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >=20
> > > Use the functions provided by the buffer-dma core to implement the
> > > DMABUF userspace API in the buffer-dmaengine IIO buffer
> > > implementation.
> > >=20
> > > Since we want to be able to transfer an arbitrary number of bytes
> > > and
> > > not necesarily the full DMABUF, the associated scatterlist is
> > > converted
> > > to an array of DMA addresses + lengths, which is then passed to
> > > dmaengine_prep_slave_dma_array().
> > >=20
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > One question inline. Otherwise looks fine to me.
> >=20
> > J
> > >=20
> > > ---
> > > v3: Use the new dmaengine_prep_slave_dma_array(), and adapt the
> > > code to
> > > =C2=A0=C2=A0=C2=A0 work with the new functions introduced in industri=
alio-buffer-
> > > dma.c.
> > >=20
> > > v5: - Use the new dmaengine_prep_slave_dma_vec().
> > > =C2=A0=C2=A0=C2=A0 - Restrict to input buffers, since output buffers =
are not yet
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported by IIO buffers.
> > > ---
> > > =C2=A0.../buffer/industrialio-buffer-dmaengine.c=C2=A0=C2=A0=C2=A0 | =
52
> > > ++++++++++++++++---
> > > =C2=A01 file changed, 46 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > index 5f85ba38e6f6..825d76a24a67 100644
> > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > @@ -64,15 +64,51 @@ static int
> > > iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue
> > > *queue,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dmaengine_buff=
er *dmaengine_buffer =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_buffer_to_dmaengine_buffer(&queue->buffer);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dma_async_tx_d=
escriptor *desc;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i, nents;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct scatterlist *sgl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dma_vec *vecs;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t max_size;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_cookie_t cookie;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t len_total;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->bytes_used =3D min(=
block->size, dmaengine_buffer-
> > > > max_size);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->bytes_used =3D roun=
d_down(block->bytes_used,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma=
engine_buffer->align);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (queue->buffer.directio=
n !=3D IIO_BUFFER_DIRECTION_IN) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* We do not yet support output buffers. */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0desc =3D dmaengine_prep_sl=
ave_single(dmaengine_buffer->chan,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0block->phys_addr, block->bytes_used,
> > > DMA_DEV_TO_MEM,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0DMA_PREP_INTERRUPT);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (block->sg_table) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sgl =3D block->sg_table->sgl;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0nents =3D sg_nents_for_len(sgl, block->bytes_used);
> >=20
> > Are we guaranteed the length in the sglist is enough?=C2=A0 If not this
> > can return an error code.
>=20
> The length of the sglist will always be enough, the
> iio_buffer_enqueue_dmabuf() function already checks that block-
> > bytes_used is equal or smaller than the size of the DMABUF.
>=20
> It is quite a few functions above in the call stack though, so I can
> handle the errors of sg_nents_for_len() here if you think makes sense.

Maybe putting something like the above in a comment?

- Nuno S=C3=A1



