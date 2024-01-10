Return-Path: <dmaengine+bounces-715-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256282A42D
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 23:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1991B1C21921
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1184F201;
	Wed, 10 Jan 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiZMvBPT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157474EB4A;
	Wed, 10 Jan 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7cdb24b3ac3so641946241.3;
        Wed, 10 Jan 2024 14:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704926823; x=1705531623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qyeFnhiDNNURDIz+8zP28sEs2jFs16Y/vSKhjup2hM=;
        b=HiZMvBPT+O7h/7xjqCAJmbVAz3rYVxFNu9tS2alTzhHPq/cnrJEpmCAlu9kkIFV7vm
         FXRAIHvUHmW5DSyQY6vOVsZ/ybdacxB2KoC8yd+nb4gnthuVJA+J9PHFCZlh8dZA232u
         sehqtQcCxt3D80PNkucUB5D7b5IDN5fZXAf2pJrEJFWi64de13Pysl92CWn5hxMJ13f1
         XXahca8EyFICF8XYMR5EcvjcyfWjtoABV93ZyfvELrHsQ+IFKux/nOu3R/JEfA5p0aoh
         DRxjfcZEhpHgn/II9t6JG8G0O4CcQb+jqNfUU8CSmlnpRT/jgHIncaLxkzrTkINwML5p
         PNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704926823; x=1705531623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qyeFnhiDNNURDIz+8zP28sEs2jFs16Y/vSKhjup2hM=;
        b=DF9+WPWmtia2yBUDvTRf+saPQIiEWi5g752EGxySfgRUEICMPmzYD/Ayo94qeLfI+s
         o0NymgjYwfDR1oz0ovSPkrtRdafZsIN1ZHmMr4zEgFx9hvWkA1GYyi+1j5VdIJ9Elvbo
         uLVMB2lBIS1OKouripFRpiwgCphe5HWkuSe93DjYdP2OWywa4ML4aSbySnZZLqJ3516K
         hNxWRLhWtCX9vRYuk/0vVyRC0CfuXSLXuGZfVOtdrcY3RiTITmQJhKcQeg0v0NtDfhCn
         SOSg6spkzzQlpvueM5q5/zXKWfEEnOiHcpIsBtz6ldB73NYd0v4h4DqoUq/S4ummyPol
         f5IA==
X-Gm-Message-State: AOJu0YyESO4QtOs0Q5I4N7MlnIzMpYqbVQaIKzONoPm0bZnXFfNWgxeI
	Q8krLO+osDw/o3xTt9RhAsGW0O4p1RhIlG9WaUA=
X-Google-Smtp-Source: AGHT+IErYXdaqVQL0eC34Yw6VgKXqvq53WTEBIuAKR40+eZMmSzOQBupbrlv0NjcJ14ujDZxQWZtxf9+1UAMOuQsKj4=
X-Received: by 2002:a05:6122:c4:b0:4b6:b37c:5a42 with SMTP id
 h4-20020a05612200c400b004b6b37c5a42mr120455vkc.25.1704926822736; Wed, 10 Jan
 2024 14:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <202401101437.48C52CF6@keescook>
In-Reply-To: <202401101437.48C52CF6@keescook>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 10 Jan 2024 22:46:02 +0000
Message-ID: <CA+V-a8tdmD7PB1Rp5K9doXKGzSLwhbSAXD1=UisQebUrug507A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: usb-dmac: Avoid format-overflow warning
To: Kees Cook <keescook@chromium.org>
Cc: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

Thank you for the review.

On Wed, Jan 10, 2024 at 10:41=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Wed, Jan 10, 2024 at 10:22:10PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > gcc points out that the fix-byte buffer might be too small:
> > drivers/dma/sh/usb-dmac.c: In function 'usb_dmac_probe':
> > drivers/dma/sh/usb-dmac.c:720:34: warning: '%u' directive writing betwe=
en 1 and 10 bytes into a region of size 3 [-Wformat-overflow=3D]
> >   720 |         sprintf(pdev_irqname, "ch%u", index);
> >       |                                  ^~
> > In function 'usb_dmac_chan_probe',
> >     inlined from 'usb_dmac_probe' at drivers/dma/sh/usb-dmac.c:814:9:
> > drivers/dma/sh/usb-dmac.c:720:31: note: directive argument in the range=
 [0, 4294967294]
> >   720 |         sprintf(pdev_irqname, "ch%u", index);
> >       |                               ^~~~~~
> > drivers/dma/sh/usb-dmac.c:720:9: note: 'sprintf' output between 4 and 1=
3 bytes into a destination of size 5
> >   720 |         sprintf(pdev_irqname, "ch%u", index);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Maximum number of channels for USB-DMAC as per the driver is 1-99 so us=
e
> > u8 instead of unsigned int/int for DMAC channel indexing and make the
> > pdev_irqname string long enough to avoid the warning.
> >
> > While at it use scnprintf() instead of sprintf() to make the code more
> > robust.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This looks like good fixes; thanks! I see n_channels is sanity checked
> during the probe in usb_dmac_chan_probe(), so this looks good.
>
> (Is there a reason not to also change n_channels to a u8?)
>
Good point, I oversighted it by just looking at the loop indices. I
will send a v2 with that change.

Cheers,
Prabhakar

> -Kees
>
> > ---
> >  drivers/dma/sh/usb-dmac.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> > index a9b4302f6050..f7cd0cad056c 100644
> > --- a/drivers/dma/sh/usb-dmac.c
> > +++ b/drivers/dma/sh/usb-dmac.c
> > @@ -706,10 +706,10 @@ static const struct dev_pm_ops usb_dmac_pm =3D {
> >
> >  static int usb_dmac_chan_probe(struct usb_dmac *dmac,
> >                              struct usb_dmac_chan *uchan,
> > -                            unsigned int index)
> > +                            u8 index)
> >  {
> >       struct platform_device *pdev =3D to_platform_device(dmac->dev);
> > -     char pdev_irqname[5];
> > +     char pdev_irqname[6];
> >       char *irqname;
> >       int ret;
> >
> > @@ -717,7 +717,7 @@ static int usb_dmac_chan_probe(struct usb_dmac *dma=
c,
> >       uchan->iomem =3D dmac->iomem + USB_DMAC_CHAN_OFFSET(index);
> >
> >       /* Request the channel interrupt. */
> > -     sprintf(pdev_irqname, "ch%u", index);
> > +     scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> >       uchan->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> >       if (uchan->irq < 0)
> >               return -ENODEV;
> > @@ -768,8 +768,8 @@ static int usb_dmac_probe(struct platform_device *p=
dev)
> >       const enum dma_slave_buswidth widths =3D USB_DMAC_SLAVE_BUSWIDTH;
> >       struct dma_device *engine;
> >       struct usb_dmac *dmac;
> > -     unsigned int i;
> >       int ret;
> > +     u8 i;
> >
> >       dmac =3D devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> >       if (!dmac)
> > @@ -869,7 +869,7 @@ static void usb_dmac_chan_remove(struct usb_dmac *d=
mac,
> >  static void usb_dmac_remove(struct platform_device *pdev)
> >  {
> >       struct usb_dmac *dmac =3D platform_get_drvdata(pdev);
> > -     int i;
> > +     u8 i;
> >       for (i =3D 0; i < dmac->n_channels; ++i)
> >               usb_dmac_chan_remove(dmac, &dmac->channels[i]);
> > --
> > 2.34.1
> >
>
> --
> Kees Cook

