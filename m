Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F077A5BA
	for <lists+dmaengine@lfdr.de>; Sun, 13 Aug 2023 11:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjHMJFr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Aug 2023 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHMJFq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Aug 2023 05:05:46 -0400
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Aug 2023 02:05:48 PDT
Received: from out-74.mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6F10FA
        for <dmaengine@vger.kernel.org>; Sun, 13 Aug 2023 02:05:48 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691917191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kH0Tgl//HjNeN/p7nkuMFtG502p+KcTS1aQfN0Rp/3M=;
        b=bvQn4RPVVD+mB8DmdcRQnSw0kAJQwL/wL2FPZThJJYTKLA75N3q0U0l6AlMIDX+wrmVxna
        0kRh/Fgsc8L82h69RksAjXrVcXGZmjuspwrvGWKhnsuyMQERZbfTDnZ4X0SZV+N8/+gHiy
        Ns0vUlEAjv83hLxbO+XDJCbxtlz62Xg=
Date:   Sun, 13 Aug 2023 08:59:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <148ae07079b42d834a19b100e18070f50acbcc78@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] dmaengine: ioat: fixing the wrong chancnt
To:     "Dave Jiang" <dave.jiang@intel.com>, vkoul@kernel.org,
        bhelgaas@google.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <a93a087d-cfae-a135-999e-ae1976694165@intel.com>
References: <a93a087d-cfae-a135-999e-ae1976694165@intel.com>
 <20230811081645.1768047-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

August 11, 2023 at 11:40 PM, "Dave Jiang" <dave.jiang@intel.com> wrote:


>=20
>=20On 8/11/23 01:16, Yajun Deng wrote:
>=20
>=20>=20
>=20> The chancnt would be updated in __dma_async_device_channel_register=
(),
> >  but it was assigned in ioat_enumerate_channels(). Therefore chancnt =
has
> >  the wrong value.
> >  Clear chancnt before calling dma_async_device_register().
> >  Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >=20
>=20
> Thank you for the patch Yajun.
>=20
>=20While this may work, it clobbers the chancnt read from the hardware. =
I think the preferable fix is to move the value read from the hardware in=
 ioat_enumerate_channels() and its current usages to 'struct ioatdma_devi=
ce' and leave dma->chancnt unchanged in that function so that zeroing it =
later is not needed.
>
Yes, it's even better. I noticed that chancnt is hardware related in ioat=
, so I just clear it before calling dma_async_device_register().It would =
be updated after calling dma_async_device_register(). And it would have
the same value with read in ioat_enumerate_channels().
It doesn't seem clobber the chancnt read from the hardware.=20
=20
> Also, have you tested this patch or is this just from visual inspection=
?
>=20
Yes,=20I tested it.

=E2=9E=9C  ~ ls /sys/class/dma
dma0chan0  dma1chan0  dma2chan0  dma3chan0

before:
=E2=9E=9C  ~ cat /sys/kernel/debug/dmaengine/summary
dma0 (0000:00:04.0): number of channels: 2
dma1 (0000:00:04.1): number of channels: 2
dma2 (0000:00:04.2): number of channels: 2
dma3 (0000:00:04.3): number of channels: 2

after:
=E2=9E=9C  ~ cat /sys/kernel/debug/dmaengine/summary
dma0 (0000:00:04.0): number of channels: 1
dma1 (0000:00:04.1): number of channels: 1
dma2 (0000:00:04.2): number of channels: 1
dma3 (0000:00:04.3): number of channels: 1


> And need a fixes tag.
>
I've tried to find the commit introduced, it looks like it was introduced=
 from the source.
The following commits are related to chancnt=EF=BC=9A

0bbd5f4e97ff ("[I/OAT]: Driver for the Intel(R) I/OAT DMA engine")
device->common.chancnt =3D ioatdma_read8(device, IOAT_CHANCNT_OFFSET);

e38288117c50 ("ioatdma: Remove the wrappers around read(bwl)/write(bwl) i=
n ioatdma")
device->common.chancnt =3D readb(device->reg_base + IOAT_CHANCNT_OFFSET);

584ec22759c0 ("ioat: move to drivers/dma/ioat/")
move driver/dma/ioatdma.c to driver/dma/ioat/

f2427e276ffe ("ioat: split ioat_dma_probe into core/version-specific rout=
ines")
dma->chancnt =3D readb(device->reg_base + IOAT_CHANCNT_OFFSET);

55f878ec47e3 ("dmaengine: ioatdma: fixup ioatdma_device namings")
dma->chancnt =3D readb(ioat_dma->reg_base + IOAT_CHANCNT_OFFSET);

It looks very historic. I'm confused about which one to choose.=20
This=20is a bug, but it only affects /sys/kernel/debug/dmaengine/summary.
So I didn't add a fixes tag.

=20
>=20>=20
>=20> ---
> >  drivers/dma/ioat/init.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >  diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> >  index c4602bfc9c74..928fc8a83a36 100644
> >  --- a/drivers/dma/ioat/init.c
> >  +++ b/drivers/dma/ioat/init.c
> >  @@ -536,8 +536,11 @@ static int ioat_probe(struct ioatdma_device *io=
at_dma)
> >  > static int ioat_register(struct ioatdma_device *ioat_dma)
> >  {
> >  - int err =3D dma_async_device_register(&ioat_dma->dma_dev);
> >  + int err;
> >  +
> >  + ioat_dma->dma_dev.chancnt =3D 0;
> >  > + err =3D dma_async_device_register(&ioat_dma->dma_dev);
> >  if (err) {
> >  ioat_disable_interrupts(ioat_dma);
> >  dma_pool_destroy(ioat_dma->completion_pool);
> >
>
