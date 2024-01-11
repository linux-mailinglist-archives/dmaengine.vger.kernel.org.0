Return-Path: <dmaengine+bounces-720-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4277382AA80
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 10:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A961C26313
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73632FC0B;
	Thu, 11 Jan 2024 09:05:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF2DF6E;
	Thu, 11 Jan 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5edfcba97e3so53639907b3.2;
        Thu, 11 Jan 2024 01:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963921; x=1705568721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR6KU/zGe5ub/62SWQbwkfMRKXXvW7W7wYmrGRm2qBE=;
        b=gYXHOGG3tkCqkbtLdpX4dcQklepvn6Bepm9GYZTcJTxNvEeQ8Dms0wlGMgwlboBswh
         +GroZYRA2OOcyGJ/ERvOqr98ZXKTcTIG7vhCEDuOia7AVFDQPkaWJFimADwr4TvwMO2C
         pdEufVdFJkm88EEDfREcX7cn1zDdSDrqLWBY3crbirO2LDbwDfO3d5fKv1k15DYhL0ft
         LvWFj2vxLyeHNwj5kK6sZbnW//FjQ7uideRCaKgURGDqEFFiqHj5oqBgdPAEV3e2ioGg
         aVknLTI76MlZI7iwP5haxNJOZajuPO3TFQ9NBQZQztNUni+grig9V3HPd++tDsjWWZSC
         fI/g==
X-Gm-Message-State: AOJu0Yx2JFAzmn393PWiluols84mZEF/VuNNR3jGYyq/IdByCoIvfkeq
	XWPCsuv05VeebxarblzuplOAwmH9sGcFHw==
X-Google-Smtp-Source: AGHT+IEPl3K98FtUDTMOoP6Sn8AxfrFnU3KMpA7rl3Oft8tdXtvZ9KYKqRRtsyYpCS7ljRmkPaSysA==
X-Received: by 2002:a05:690c:fd1:b0:5d7:1940:f3d2 with SMTP id dg17-20020a05690c0fd100b005d71940f3d2mr296288ywb.58.1704963920831;
        Thu, 11 Jan 2024 01:05:20 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id u80-20020a818453000000b005e7467eaa43sm254600ywf.32.2024.01.11.01.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 01:05:20 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbf2b5556f9so1367952276.2;
        Thu, 11 Jan 2024 01:05:20 -0800 (PST)
X-Received: by 2002:a5b:5d2:0:b0:dbf:196c:b615 with SMTP id
 w18-20020a5b05d2000000b00dbf196cb615mr950823ybp.0.1704963919994; Thu, 11 Jan
 2024 01:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jan 2024 10:05:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSLBARbtc91F=cWqTdL+UcT4wJbr0_m5+iz_6BXA4Acw@mail.gmail.com>
Message-ID: <CAMuHMdXSLBARbtc91F=cWqTdL+UcT4wJbr0_m5+iz_6BXA4Acw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: usb-dmac: Avoid format-overflow warning
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Kees Cook <keescook@chromium.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, Jan 10, 2024 at 11:23=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> gcc points out that the fix-byte buffer might be too small:
> drivers/dma/sh/usb-dmac.c: In function 'usb_dmac_probe':
> drivers/dma/sh/usb-dmac.c:720:34: warning: '%u' directive writing between=
 1 and 10 bytes into a region of size 3 [-Wformat-overflow=3D]
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |                                  ^~
> In function 'usb_dmac_chan_probe',
>     inlined from 'usb_dmac_probe' at drivers/dma/sh/usb-dmac.c:814:9:
> drivers/dma/sh/usb-dmac.c:720:31: note: directive argument in the range [=
0, 4294967294]
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |                               ^~~~~~
> drivers/dma/sh/usb-dmac.c:720:9: note: 'sprintf' output between 4 and 13 =
bytes into a destination of size 5
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Maximum number of channels for USB-DMAC as per the driver is 1-99 so use
> u8 instead of unsigned int/int for DMAC channel indexing and make the
> pdev_irqname string long enough to avoid the warning.
>
> While at it use scnprintf() instead of sprintf() to make the code more
> robust.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One nit below.

> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c

> @@ -768,8 +768,8 @@ static int usb_dmac_probe(struct platform_device *pde=
v)
>         const enum dma_slave_buswidth widths =3D USB_DMAC_SLAVE_BUSWIDTH;
>         struct dma_device *engine;
>         struct usb_dmac *dmac;
> -       unsigned int i;
>         int ret;
> +       u8 i;

Personally, I'm not much a fan of making loop counters smaller than
(unsigned) int.  If you do go this way, there are more loops over all
channels still using int.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

