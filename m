Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE2D6D50BA
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjDCShc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 14:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjDCShc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 14:37:32 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308899;
        Mon,  3 Apr 2023 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680547048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnQrvEz/F0HtMo61MRMevGwpunBFI0o/+wdfXFhszQw=;
        b=wmGIpaAeX3wlUIVZdWVbWY5RMVdmTF8B40N5sXTdehP85NEPptugaqHw+XJX2cPDclj4WM
        atYeygViHa62jb9sd3JFz3XJkkiptTMr2M6qClT8yr7YS7UCHzJiq2HgKhRuPR2z7rVKai
        SbXDqG7PskUUFgyASdtczeEkdEVJmqg=
Message-ID: <6a75a551b3ef3fc7cf9281db0b69167a570130c2.camel@crapouillou.net>
Subject: Re: [PATCH v3 11/11] Documentation: iio: Document high-speed DMABUF
 based API
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org
Date:   Mon, 03 Apr 2023 20:37:26 +0200
In-Reply-To: <87zg7p7xz4.fsf@meer.lwn.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
         <20230403154955.216148-1-paul@crapouillou.net>
         <20230403154955.216148-2-paul@crapouillou.net>
         <87zg7p7xz4.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jonathan,

Le lundi 03 avril 2023 =C3=A0 10:05 -0600, Jonathan Corbet a =C3=A9crit=C2=
=A0:
> Paul Cercueil <paul@crapouillou.net> writes:
>=20
> One nit:
>=20
> > Document the new DMABUF based API.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> >=20
> > ---
> > v2: - Explicitly state that the new interface is optional and is
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not implemented by all drivers.
> > =C2=A0=C2=A0=C2=A0 - The IOCTLs can now only be called on the buffer FD=
 returned
> > by
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BUFFER_GET_FD_IOCTL.
> > =C2=A0=C2=A0=C2=A0 - Move the page up a bit in the index since it is co=
re stuff
> > and not
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver-specific.
> > v3: Update the documentation to reflect the new API.
> > ---
> > =C2=A0Documentation/iio/dmabuf_api.rst | 59
> > ++++++++++++++++++++++++++++++++
> > =C2=A0Documentation/iio/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
> > =C2=A02 files changed, 61 insertions(+)
> > =C2=A0create mode 100644 Documentation/iio/dmabuf_api.rst
> >=20
> > diff --git a/Documentation/iio/dmabuf_api.rst
> > b/Documentation/iio/dmabuf_api.rst
> > new file mode 100644
> > index 000000000000..4d70372c7ebd
> > --- /dev/null
> > +++ b/Documentation/iio/dmabuf_api.rst
> > @@ -0,0 +1,59 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +High-speed DMABUF interface for IIO
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1. Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The Industrial I/O subsystem supports access to buffers through a
> > +file-based interface, with read() and write() access calls through
> > the
> > +IIO device's dev node.
> > +
> > +It additionally supports a DMABUF based interface, where the
> > userspace
> > +can attach DMABUF objects (externally created) to a IIO buffer,
> > and
> > +subsequently use them for data transfers.
> > +
> > +A userspace application can then use this interface to share
> > DMABUF
> > +objects between several interfaces, allowing it to transfer data
> > in a
> > +zero-copy fashion, for instance between IIO and the USB stack.
> > +
> > +The userspace application can also memory-map the DMABUF objects,
> > and
> > +access the sample data directly. The advantage of doing this vs.
> > the
> > +read() interface is that it avoids an extra copy of the data
> > between the
> > +kernel and userspace. This is particularly useful for high-speed
> > devices
> > +which produce several megabytes or even gigabytes of data per
> > second.
> > +It does however increase the userspace-kernelspace synchronization
> > +overhead, as the DMA_BUF_SYNC_START and DMA_BUF_SYNC_END IOCTLs
> > have to
> > +be used for data integrity.
> > +
> > +2. User API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +As part of this interface, three new IOCTLs have been added. These
> > three
> > +IOCTLs have to be performed on the IIO buffer's file descriptor,
> > +obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
> > +
> > +``IIO_BUFFER_DMABUF_ATTACH_IOCTL(int)``
> > +----------------------------------------------------------------
> > +
> > +Attach the DMABUF object, identified by its file descriptor, to
> > the IIO
> > +buffer. Returns zero on success, and a negative errno value on
> > error.
>=20
> Rather than abusing subsections, this would be better done as a
> description list:
>=20
> =C2=A0 IIO_BUFFER_DMABUF_ATTACH_IOCTL(int)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Attach the DMABUF object, identified by it=
s file descriptor, to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the IIO buffer. Returns zero on success, a=
nd a negative errno
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value on error.

Noted, thanks.

Cheers,
-Paul
