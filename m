Return-Path: <dmaengine+bounces-3787-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB1C9D7DA1
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 09:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8332826DB
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2024 08:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E218CBF2;
	Mon, 25 Nov 2024 08:54:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8518D64B;
	Mon, 25 Nov 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732524853; cv=none; b=Rcy/HfskNxaBdLt6BYEqoEqvEF43+iNVnhkHSHVaudO1DakwuG1hfVLFqeziX8eSWk01qsutQM69q+MjCOPLtodK44nMYLuNaPIKOFdw/EdXi/erz2j25vgDlM/UvLy5t5s2m9b98qCpAC+GbsLW9rDFKKWMEiZdXJGkSxvdAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732524853; c=relaxed/simple;
	bh=FAzHehnj8z0R4xGCvHYxjzAVaPYClp5BTtPVU62/xVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGOLI8AwtnXc6ZHFLoK/7Y5gJ8SESmKszd+7qEQWQJQRyDoMKX2jacSaWpiqpiZC1chcgiHDE6/1V+ALTIVVDTL2/ah3UfMN/MrW/1G7GWSLLbx0A+J8B7oqRRHOIiWz0Hax3u8TkPXRBujRbYqHALpiYl8cys6zqmMXBL7ZtdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee676b4e20so41039257b3.3;
        Mon, 25 Nov 2024 00:54:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732524849; x=1733129649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTvz5S4bSfDhcEqcnkIVdhgujNubXreDmH6cr9kqGes=;
        b=solAI/Nros4tIp6dXAjcKkFplmjj/1LJfcH57fbK2GE6pBOafXa3BZb2EJZ8qqZHf8
         BbzXdPven0HFrc9JNmZA9+ZwbsKTayajoIVpBomKncsYw7hBxqXN85Wot1rK9tV3M3MB
         pZvT0N2trWFzZEqnqJBBBuxDBv1WAlpJ4rXT+Ei1SDxATD83E2Z2mLNJEunU50apb5mO
         /rKZzJP7xIibPVy5Z+xXPfaLToELfkMmMWwUGQvIo23HbaPDhuNbFdzLDV4VYm3r5ivV
         GynQxEkboUseQ11BKx5+qlcbWkjHRqdt2IDBhq1pdyCKdeFuwIfWxYiCuyUkYB6Ayzfd
         RLMg==
X-Forwarded-Encrypted: i=1; AJvYcCWKthxGNztv3t/A24GnpHwoC2+uGRHS8cNK2nN37ptvCyf9tEI1DQ0THGNy6TGxViC82sfkQU1Xek4=@vger.kernel.org, AJvYcCXkRAYulJKFbAcCocDBDRPPXLaWplm+qIPZSiNjx5U+vmc0XWdLOzKsCX5Kq9+DLAYQLYeJDHdHbYTUvTo4mHdZsR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwk5yvAuRNWIlGfCi6u3KCXSwub7ggd7Iqx9Duy/HPz4V2KGq
	/YRIU81SLZ+rfa+u8+HXWOY4T7gAFsdqFLCEUXX2NRZwjejXyT6vNpf4VNf9
X-Gm-Gg: ASbGnctwhGkQb6BbO25R0UqU1mMSvOkJV82SRCG0DcP0HtW8XtGwBkph8S1CzTtS66O
	zxcyjEXitkXNptETN7Sx2qdAvwlt5v2QXMvFFXHrH72yx2xq4/jcf53VXDkBoaOgWFg+RNafcg4
	TMB+PD35fjCiwMVK66TMzzWj29LDQm3BrWSR4ACYZRCwpWidlxB9yXYMGSE6u0/hB8iUpQYnhg2
	3pl/bCytivAz8BfM6weYpKA/aH3WKovK+foAbDEpqZL0jB4q8+wLYTggdekye30tAA/9hzGAlGK
	vwJw10h2xOaFspM1
X-Google-Smtp-Source: AGHT+IH3I9YZYVYQBgy0WQYLdh/v416ZCGgX48qD+RWHndFiV+3yQF7txJM7u000qpN7pcjLCIjOzQ==
X-Received: by 2002:a05:690c:6c13:b0:6e2:aceb:fb34 with SMTP id 00721157ae682-6eee087c02cmr110381767b3.1.1732524849407;
        Mon, 25 Nov 2024 00:54:09 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe15248sm17281377b3.25.2024.11.25.00.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 00:54:09 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee7a400647so42929557b3.1;
        Mon, 25 Nov 2024 00:54:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlcP+EK7aXMiI6OD/TCR5ozk6lZsHmoyL5+Heu4dwa6WPxEL6j7FOe9o70UnvWUhN03yG7WVJI3Es=@vger.kernel.org, AJvYcCXtIdzHjbm63IM/UJu+nPvH4+/Y0FDkOpzviLWH9BR9dzt8/ZpatdQHlazq9JSVDjtOXbv1351ClEComgWAbBZncjk=@vger.kernel.org
X-Received: by 2002:a0d:c2c1:0:b0:6ee:9052:8e18 with SMTP id
 00721157ae682-6eee087b79amr83811147b3.6.1732524848899; Mon, 25 Nov 2024
 00:54:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ttbw3zq7.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ttbw3zq7.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Nov 2024 09:53:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVyCNcdkE=HpRA1mOiE5qAF0+vcWbwJM531G91G-b9aTg@mail.gmail.com>
Message-ID: <CAMuHMdVyCNcdkE=HpRA1mOiE5qAF0+vcWbwJM531G91G-b9aTg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rcar-dmac: remove r8a779a0 settings
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Morimoto-san,

On Mon, Nov 25, 2024 at 1:48=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Historically r8a779a0 SoC specific compatible was added to rcar-dmac,
> but it is same as Gen4 today, and r8a779a0 SoC DT has both SoC and Gen4
> compatible. SoC specific compatible is no longer needed. Let's remove it.
>
>         static const struct of_device_id rcar_dmac_of_ids[] =3D {
>                 ...
>                 }, {
>                         .compatible =3D "renesas,rcar-gen4-dmac",
> =3D>                      .data =3D &rcar_gen4_dmac_data,
>                 }, {
>                         .compatible =3D "renesas,dmac-r8a779a0",
> =3D>                      .data =3D &rcar_gen4_dmac_data,
>                 },
>
>         dmacX: dma-controller@XXXXX {
> =3D>              compatible =3D "renesas,dmac-r8a779a0",
> =3D>                           "renesas,rcar-gen4-dmac";
>                 ...
>         };
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -2022,9 +2022,6 @@ static const struct of_device_id rcar_dmac_of_ids[]=
 =3D {
>         }, {
>                 .compatible =3D "renesas,rcar-gen4-dmac",
>                 .data =3D &rcar_gen4_dmac_data,
> -       }, {
> -               .compatible =3D "renesas,dmac-r8a779a0",
> -               .data =3D &rcar_gen4_dmac_data,
>         },
>         { /* Sentinel */ }
>  };

This compatible value was retained in the driver because of DT
backwards compatibility: DTBs created between v5.12 and v5.19 use only
"renesas,dmac-r8a779a0".

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

