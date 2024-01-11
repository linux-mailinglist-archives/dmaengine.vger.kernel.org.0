Return-Path: <dmaengine+bounces-721-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A3282AA8B
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 10:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AEBB23CE3
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572AC1078D;
	Thu, 11 Jan 2024 09:09:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525D101FB;
	Thu, 11 Jan 2024 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dc36e501e1so3434378a34.1;
        Thu, 11 Jan 2024 01:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704964138; x=1705568938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s8mOe6yBrTL8Dc+4RBtqbm0YylyeY2R2uNKT3a55V8=;
        b=Lyd+IrHoz6Nk7QLTjKdRssSu1eWUG5FOwduoh/dDzxVjxAdrQne23pmfdHmFXnSEEB
         LZYNwAtfLOeKpYCLy4zf57XGb+YgIKT3jtTCe47IYVeMWx4AY4A7m7BAJ1LbCf75bIJl
         EmTGDPE5tao+wpyt7Nn4y0nFnpouitemvEfqC0wo3B3WeDcdXYUv35KkFsmjFsMD2VSD
         MMdZh634CWICqQK4IBDyVTNzFTB1hNQZwwQutOW00aECBOthrx0DCTjFNhCMG+f21eti
         9LhfFLkXRLHEWSdJHZaB+ih622fExGvGkPZKbji0p93FAnhUl2tsUomu7s9+VfFXU6rD
         qkPQ==
X-Gm-Message-State: AOJu0Yxhgkwy7QqED6vEknsfy1mW31Ns3CWLrqN4MBQpEboMSZzgtnkN
	9Y2Lc4BaTdqvcilssQL1GuHLc7GYcvkXYA==
X-Google-Smtp-Source: AGHT+IE6wcozzThLKTxEe+RwwmuuBKAGvcbNTPskMBgyKIQ2pNnoMJBMr4L4SOPTDBtUsp2PKYGnqg==
X-Received: by 2002:a81:a747:0:b0:5f6:e673:3f1c with SMTP id e68-20020a81a747000000b005f6e6733f1cmr301977ywh.98.1704963669071;
        Thu, 11 Jan 2024 01:01:09 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id g189-20020a0df6c6000000b005a4da74b869sm246045ywf.139.2024.01.11.01.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 01:01:08 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e7f0bf46a2so48228847b3.1;
        Thu, 11 Jan 2024 01:01:08 -0800 (PST)
X-Received: by 2002:a81:bc50:0:b0:5f3:6024:53c with SMTP id
 b16-20020a81bc50000000b005f36024053cmr322891ywl.32.1704963668540; Thu, 11 Jan
 2024 01:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110222717.193719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240110222717.193719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jan 2024 10:00:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4bv0dtJ-G1o9by91RmP3DH1HQKvDL51g_25Yq=Yd2LQ@mail.gmail.com>
Message-ID: <CAMuHMdX4bv0dtJ-G1o9by91RmP3DH1HQKvDL51g_25Yq=Yd2LQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Avoid format-overflow warning
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, Jan 10, 2024 at 11:27=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The max channel count for RZ DMAC is 16, hence use u8 instead of unsigned
> int and make the pdev_irqname string long enough to avoid the warning.

Note that the danger lies into someone changing
RZ_DMAC_MAX_CHANNELS later...

> This fixes the below issue:
> drivers/dma/sh/rz-dmac.c: In function =E2=80=98rz_dmac_probe=E2=80=99:
> drivers/dma/sh/rz-dmac.c:770:34: warning: =E2=80=98%u=E2=80=99 directive =
writing between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=
=3D]
>   770 |         sprintf(pdev_irqname, "ch%u", index);
>       |                                  ^~
> In function =E2=80=98rz_dmac_chan_probe=E2=80=99,
>     inlined from =E2=80=98rz_dmac_probe=E2=80=99 at drivers/dma/sh/rz-dma=
c.c:910:9:
> drivers/dma/sh/rz-dmac.c:770:31: note: directive argument in the range [0=
, 4294967294]
>   770 |         sprintf(pdev_irqname, "ch%u", index);
>       |                               ^~~~~~
> drivers/dma/sh/rz-dmac.c:770:9: note: =E2=80=98sprintf=E2=80=99 output be=
tween 4 and 13 bytes into a destination of size 5
>   770 |         sprintf(pdev_irqname, "ch%u", index);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> While at it use scnprintf() instead of sprintf() to make the code
> more robust.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Some nits below...

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -845,9 +845,9 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
>         struct dma_device *engine;
>         struct rz_dmac *dmac;
>         int channel_num;
> -       unsigned int i;
>         int ret;
>         int irq;
> +       u8 i;

Personally, I'm not much a fan of making loop counters smaller than
(unsigned) int.  If you do go this way, you should change channel_num
to u8, too, just like i in rz_dmac_remove().

>
>         dmac =3D devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
>         if (!dmac)

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

