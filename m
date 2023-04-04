Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CADF6D5A98
	for <lists+dmaengine@lfdr.de>; Tue,  4 Apr 2023 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjDDIT1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Apr 2023 04:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjDDIT0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Apr 2023 04:19:26 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368DC1B7;
        Tue,  4 Apr 2023 01:19:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t19so30773230qta.12;
        Tue, 04 Apr 2023 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680596364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RyAgd7k00Jn6xZLlebeLFamYLWizoMoW9K/GRPwc3dg=;
        b=pwVfYyPY1UfiRNk0Hi87uHSSri7v4X0yYMw110CSHHON2xMyGnnJxg7ZNPlvqotfhi
         ljmPif0yEX0Hx6Hr3Qj57uoM8V64/JFkN4tg090Bi48eviUKr3gnV1t63ewxGfi17QvQ
         vxP7KaJZQDgBdedfTUNVj082l6KaYKt3KWMq2GqvHKHqB/8+/YqXqUZP0drruu85IWZQ
         ziiknoasbwGJxjURMhpSQWmogB/Bc7j9X1s/sk4DYlh+1HYpst0LvGRsTeboW04/p/gT
         TveyNEmUIP4WDq/9iS1MZuqTwmtuEwl139LIWPqhE38V4bSJMm9/O7CRW+CRvipydE0I
         uZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyAgd7k00Jn6xZLlebeLFamYLWizoMoW9K/GRPwc3dg=;
        b=mgXOikEFV5DaRGBcf/jIGc3iT+l2KlqoO9hJZaBrg/cdvNPLPYW1lpUYJyn5WORUKN
         sSli1Sec4qKksIFgKMNypmMLSPt3aGDYi5PR/lUQUxW5rlmWbyjjK2A0vV56rmR2BUvN
         UH6ayQDW3DKICCL/KwizjQ4WXNbwJL1pAPu4T/H20+2qFI9c5D02YC4CfZr8HmhiSX3z
         krkWreVCkt7YNWBWAcE3DeRIC9FWcjDfEiTREHorHUOht0k0pY5fSjdImKyqHzoCBKu4
         D1G7KX7JS6fxW8Fl0sQspD4C3sLS8Iao9Ril1wFmoP7yDHoPUulsEmCX8+g4Oe/bZd/y
         HVFw==
X-Gm-Message-State: AAQBX9c4gHyPr88/u5nSiZhsM/efgDp3iaSCatqLGuzM7W9ODnAS0vad
        uCUIqTvQUuZIV9aRDl+vlIXff0+icrQNBuSw5kc=
X-Google-Smtp-Source: AKy350aqztpTVhGayDoqCgfpJ8XiDnAnyrZL24EhQPW+Hr0DWknjkulIkCnsZH6G7zxfeTXJ0ah3Pg==
X-Received: by 2002:a05:622a:5ce:b0:3bd:1081:b939 with SMTP id d14-20020a05622a05ce00b003bd1081b939mr38131941qtb.0.1680596364236;
        Tue, 04 Apr 2023 01:19:24 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a22ab00b00706b09b16fasm3417693qkh.11.2023.04.04.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:19:23 -0700 (PDT)
Message-ID: <9f5cac46e38897f54c5246bf400e8888324abad8.camel@gmail.com>
Subject: Re: [PATCH v3 07/11] iio: core: Add new DMABUF interface
 infrastructure
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org
Date:   Tue, 04 Apr 2023 10:21:27 +0200
In-Reply-To: <2dac030470ffe74b6d21a1e6510afcefaf58cd6a.camel@crapouillou.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
         <20230403154800.215924-8-paul@crapouillou.net>
         <798e1ff0651da8e4b113d30bf8cec2a7a0e6898f.camel@gmail.com>
         <2dac030470ffe74b6d21a1e6510afcefaf58cd6a.camel@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 2023-04-04 at 09:55 +0200, Paul Cercueil wrote:
> Hi Nuno,
>=20
> Le mardi 04 avril 2023 =C3=A0 09:32 +0200, Nuno S=C3=A1 a =C3=A9crit=C2=
=A0:
> > On Mon, 2023-04-03 at 17:47 +0200, Paul Cercueil wrote:
> > > Add the necessary infrastructure to the IIO core to support a new
> > > optional DMABUF based interface.
> > >=20
> > > With this new interface, DMABUF objects (externally created) can be
> > > attached to a IIO buffer, and subsequently used for data transfer.
> > >=20
> > > A userspace application can then use this interface to share DMABUF
> > > objects between several interfaces, allowing it to transfer data in
> > > a
> > > zero-copy fashion, for instance between IIO and the USB stack.
> > >=20
> > > The userspace application can also memory-map the DMABUF objects,
> > > and
> > > access the sample data directly. The advantage of doing this vs.
> > > the
> > > read() interface is that it avoids an extra copy of the data
> > > between
> > > the
> > > kernel and userspace. This is particularly userful for high-speed
> > > devices which produce several megabytes or even gigabytes of data
> > > per
> > > second.
> > >=20
> > > As part of the interface, 3 new IOCTLs have been added:
> > >=20
> > > IIO_BUFFER_DMABUF_ATTACH_IOCTL(int fd):
> > > =C2=A0Attach the DMABUF object identified by the given file descripto=
r
> > > to
> > > the
> > > =C2=A0buffer.
> > >=20
> > > IIO_BUFFER_DMABUF_DETACH_IOCTL(int fd):
> > > =C2=A0Detach the DMABUF object identified by the given file descripto=
r
> > > from
> > > =C2=A0the buffer. Note that closing the IIO buffer's file descriptor
> > > will
> > > =C2=A0automatically detach all previously attached DMABUF objects.
> > >=20
> > > IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
> > > =C2=A0Request a data transfer to/from the given DMABUF object. Its fi=
le
> > > =C2=A0descriptor, as well as the transfer size and flags are provided=
 in
> > > the
> > > =C2=A0"iio_dmabuf" structure.
> > >=20
> > > These three IOCTLs have to be performed on the IIO buffer's file
> > > descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
> > >=20
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >=20
> > > ---
> > > v2: Only allow the new IOCTLs on the buffer FD created with
> > > =C2=A0=C2=A0=C2=A0 IIO_BUFFER_GET_FD_IOCTL().
> > >=20
> > > v3: - Get rid of the old IOCTLs. The IIO subsystem does not create
> > > or
> > > =C2=A0=C2=A0=C2=A0 manage DMABUFs anymore, and only attaches/detaches=
 externally
> > > =C2=A0=C2=A0=C2=A0 created DMABUFs.
> > > =C2=A0=C2=A0=C2=A0 - Add IIO_BUFFER_DMABUF_CYCLIC to the supported fl=
ags.
> > > ---
> > > =C2=A0drivers/iio/industrialio-buffer.c | 402
> > > ++++++++++++++++++++++++++++++
> > > =C2=A0include/linux/iio/buffer_impl.h=C2=A0=C2=A0 |=C2=A0 22 ++
> > > =C2=A0include/uapi/linux/iio/buffer.h=C2=A0=C2=A0 |=C2=A0 22 ++
> > > =C2=A03 files changed, 446 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-buffer.c
> > > b/drivers/iio/industrialio-buffer.c
> > > index 80c78bd6bbef..5d88e098b3e7 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -13,10 +13,14 @@
> > > =C2=A0#include <linux/kernel.h>
> > > =C2=A0#include <linux/export.h>
> > > =C2=A0#include <linux/device.h>
> > > +#include <linux/dma-buf.h>
> > > +#include <linux/dma-fence.h>
> > > +#include <linux/dma-resv.h>
> > > =C2=A0#include <linux/file.h>
> > > =C2=A0#include <linux/fs.h>
> > > =C2=A0#include <linux/cdev.h>
> > > =C2=A0#include <linux/slab.h>
> > > +#include <linux/mm.h>
> > > =C2=A0#include <linux/poll.h>
> > > =C2=A0#include <linux/sched/signal.h>
> > > =C2=A0
> > > @@ -28,11 +32,41 @@
> > > =C2=A0#include <linux/iio/buffer.h>
> > > =C2=A0#include <linux/iio/buffer_impl.h>
> > > =C2=A0
> > > +#define DMABUF_ENQUEUE_TIMEOUT_MS 5000
> > > +
> > > +struct iio_dma_fence;
> > > +
> > > +struct iio_dmabuf_priv {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head entry;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kref ref;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_buffer *buffer;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dma_buffer_bloc=
k *block;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 context;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spinlock_t lock;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dma_buf_attachment =
*attach;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dma_fence *fenc=
e;
> > > +};
> > > +
> > > +struct iio_dma_fence {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dma_fence base;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dmabuf_priv *pr=
iv;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sg_table *sgt;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum dma_data_direction di=
r;
> > > +};
> > > +
> > > =C2=A0static const char * const iio_endian_prefix[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[IIO_BE] =3D "be",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[IIO_LE] =3D "le",
> > > =C2=A0};
> > > =C2=A0
> > > +static inline struct iio_dma_fence *to_iio_dma_fence(struct
> > > dma_fence *fence)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return container_of(fence,=
 struct iio_dma_fence, base);
> > > +}
> > > +
> >=20
> > Kind of a nitpick but I only see this being used once so I would
> > maybe
> > use plain 'container_of()' as you are already doing for:
> >=20
> > ... =3D container_of(ref, struct iio_dmabuf_priv, ref);
> >=20
> > So I would at least advocate for consistency. I would also probably
> > ditch the inline but I guess that is more a matter of
> > style/preference.
>=20
> Yep, at least it should be consistent.
>=20
> >=20
> > > =C2=A0static bool iio_buffer_is_active(struct iio_buffer *buf)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return !list_empty(&b=
uf->buffer_list);
> > > @@ -329,6 +363,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
> > > =C2=A0{
> > >=20
> >=20
> > ...
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv =3D attach->importer_=
priv;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_del_init(&priv->entry=
);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_buffer_dmabuf_put(atta=
ch);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_buffer_dmabuf_put(atta=
ch);
> > > +
> >=20
> > Is this intended? Looks suspicious...
>=20
> It is intended, yes. You want to release the dma_buf_attachment that's
> created in iio_buffer_attach_dmabuf(), and you need to call
> iio_buffer_find_attachment() to get a pointer to it, which also gets a
> second reference - so it needs to unref twice.
>=20

I see..

...


> >=20
> > > +out_dmabuf_put:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_buf_put(dmabuf);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > +}
> > >=20
> >=20
> > Hmmm, what about the legacy buffer? We should also support this
> > interface using it, right? Otherwise, using one of the new IOCTL in
> > iio_device_buffer_ioctl() (or /dev/iio:device0) will error out.
>=20
> According to Jonathan the old chardev route is deprecated, and it's
> fine not to support the IOCTL there.
>=20

Oh, alright then... Better that way indeed!

- Nuno S=C3=A1

