Return-Path: <dmaengine+bounces-723-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E350082ADB5
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 12:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123D91C2322C
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811A01429F;
	Thu, 11 Jan 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/vn3dqn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E198F62;
	Thu, 11 Jan 2024 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b77948f7deso1603258e0c.0;
        Thu, 11 Jan 2024 03:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704973341; x=1705578141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U34z3M5y8NqKnCvOeskNHlh3oGzO6JvIqhzswOkQUmk=;
        b=e/vn3dqn4K7/DqoMHPhU7mTETwTpDUQ3f3huhh4s6IfKR5XGSiXY//NUKYdwSGr5ia
         WVqU2eXqp5FEbsUgHXqfM8QfcHv3pilUOo+kq9r8OhZ8hrs8qdDTe3gJOf8jOjbTzFgJ
         yOrWJBwV7NfulignmnNohG/m5diu09O0ibwMr+9SNUBdTRDiP3rVyfMz63CsviFEOZtY
         XsusipAjrBro4HR7C9ZvbvU6SThANS4bIG6kui2aj+YK2dPzUImLbmLlGSNo1NL0Py9x
         90AduWYKX8Kej3EouEqArhinAu6aBX00jBKCURd84V+Ln5IBNv6/mBPPP2e27GLFJ6N2
         mv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704973341; x=1705578141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U34z3M5y8NqKnCvOeskNHlh3oGzO6JvIqhzswOkQUmk=;
        b=ojbtwqKYvx7tRkpgEr+MdpRgsq484O6krW30OIQy1Tn6c62s7v1XvwsiOd3Y4PecJr
         t6yI4PtIcv+AorK/DVdVscMS5fC+1/QHD/Umm0IdY1puyVpcMinYPZ0M3WryyqW77e5L
         PF4j2ksT2eCyOtEEbg6O+TAyft2odX919MfjpOk3+e1p2GDlT7Y+aZ1sNCHaY3+hfuzd
         TC4eX+WNR+pBpKYpww5XAwEA3SS7PcBhvDKGbGyuulUVnrjK3Sx+vOwIlBXwAGoQyRR0
         iZ5QhpIZnxxFZIilR5TZ/kJHzsIddI6NCBt+IEL2Y2+WU0ZlNIaSMkY8ePjhoNw3jkaA
         zUnw==
X-Gm-Message-State: AOJu0YwXuK33VbEFNchDiM5aprVkUnoBuDOILyZ2P89lNnx1o4BK2tB9
	ogrQtIpPDzEAQbISGrEbjVJSv0x4Aqy4JmiwxW4=
X-Google-Smtp-Source: AGHT+IGiJJoU0Nw3B68wa0YIFKcUk/MwLlprqtndI6rNs4+OFJG3dn9vSfPhJnmB2vK7IC/PxSJ9JG3zd5CxFW2uPK0=
X-Received: by 2002:a05:6122:14af:b0:4b6:d1da:5bd1 with SMTP id
 c15-20020a05612214af00b004b6d1da5bd1mr242032vkq.2.1704973340720; Thu, 11 Jan
 2024 03:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXSLBARbtc91F=cWqTdL+UcT4wJbr0_m5+iz_6BXA4Acw@mail.gmail.com>
In-Reply-To: <CAMuHMdXSLBARbtc91F=cWqTdL+UcT4wJbr0_m5+iz_6BXA4Acw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 11 Jan 2024 11:41:54 +0000
Message-ID: <CA+V-a8vwcyVbxyKkZyepcQsxSooa-gy_-KYDJdTnQkRW9MQ01w@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: usb-dmac: Avoid format-overflow warning
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vkoul@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Kees Cook <keescook@chromium.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Thu, Jan 11, 2024 at 9:05=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Jan 10, 2024 at 11:23=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> One nit below.
>
> > --- a/drivers/dma/sh/usb-dmac.c
> > +++ b/drivers/dma/sh/usb-dmac.c
>
> > @@ -768,8 +768,8 @@ static int usb_dmac_probe(struct platform_device *p=
dev)
> >         const enum dma_slave_buswidth widths =3D USB_DMAC_SLAVE_BUSWIDT=
H;
> >         struct dma_device *engine;
> >         struct usb_dmac *dmac;
> > -       unsigned int i;
> >         int ret;
> > +       u8 i;
>
> Personally, I'm not much a fan of making loop counters smaller than
> (unsigned) int.  If you do go this way, there are more loops over all
> channels still using int.
>
Agreed. So shall I drop Kees suggestion and leave the patch as is?

Cheers,
Prabhakar

