Return-Path: <dmaengine+bounces-3266-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A859906D7
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA36E1C223D5
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5983A1D9A4F;
	Fri,  4 Oct 2024 14:48:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC41D9A52;
	Fri,  4 Oct 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053288; cv=none; b=WQbFrfyijhLeRIVrttU90xRCVfV8VZ7wzGv8RrogzfkZ/rbUgfV7kRIx6lPh/13Kh8FSHtUgTLLIuztOvuy5mMYRGJSVN+2/a96Rut1UUcKfWu8ZeljteBW4MbAyu+BLG0y8md2vLHZVh3NeU0p1fkdQ0zuOcZEbvcYNqNP8CeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053288; c=relaxed/simple;
	bh=aD+AjDLrwnddUY06O9OizjSIA02mAiLItTQj3sHSh6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvknz4A5hL6V0Ds03KU3SB1w61Z9cjfrrZgXsiDmUR2m5vuKJaTHOZyMSo+rFeB/FXsxofz+eRsJ6PPBe9ZxpuE1BL1UE0WNZYE2KGMTnzygpbD/6SoR1Q1IzS8kmS7diztp2VtUPbc/3XAyzrk+iNbJhjWaEZpssdZ2WRdDkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e25f3748e0so24182197b3.0;
        Fri, 04 Oct 2024 07:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728053285; x=1728658085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IOPIR9wx0oq4HHhx4vwOU/HAdzT9m0FY6VWO31oVPs=;
        b=HRuu9XKgd04NPet+pTXWuMDgPv5knsbcy6NksyHATfzZFLiT8Cz9AFrjacfJj3XM/9
         5UK4Ux+O4k6MRg7UFWTqXNP4S1knqNClu+W9CG7w7xyqHJ66i6cir/VQk3QmoLuReUk9
         z1iJMiJ563f7zOx3pccQrGpadyLBwhPEs7zubcRwBTDWQDUUyRXuOcM4dpA4RaR/yHWf
         6cpaylMkqnDYdddfEiYMhCI9UmMTV9txYc5eLu4SgJWzrvOslioGRMVL47NMtAP7OcM3
         vMgtIx369c0vBZrbVl1YFDhBdVrOldcnLOWkRNI8RfK7mn+q66JyRoN/r0Liu7d3tJi4
         tSHg==
X-Forwarded-Encrypted: i=1; AJvYcCUHFSNo7ji1gS9D5kMwzHTcYGlNCVLLvrZkt1/A+7j/Tx5FAodpdAHub12UfnZzCyi/vej6k5xVuiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlraOK5lO9wGettatVxVJXJTCfemfUSW1tlvlLEowQJDR6FuB3
	gY0d7tTT98bHzHl7pj52bSK1gk8p9Kqlg3zbuTLGi9CucBz3+RMLDJAG1GFgtPk=
X-Google-Smtp-Source: AGHT+IFfqf5uA0VI/xve/0Eo+Fmi02DbybWk2xajz6D/hbIELZBNbq6RJ4nQyR1btW941iN/Qd0wmA==
X-Received: by 2002:a05:690c:dc3:b0:6e2:1334:a944 with SMTP id 00721157ae682-6e2c6fc7e3cmr28552077b3.9.1728053285200;
        Fri, 04 Oct 2024 07:48:05 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bcfb3667sm6597627b3.115.2024.10.04.07.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 07:48:05 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6c3f1939d12so17773937b3.2;
        Fri, 04 Oct 2024 07:48:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRjQBllwHG3IogFpk1/cwHbrjRcsCPErXI2Ao/txQ3iWTThQFdYqJlpqWv6g+bniwgmxCcMg7ango=@vger.kernel.org
X-Received: by 2002:a05:690c:6610:b0:69d:e911:88c3 with SMTP id
 00721157ae682-6e2c728a2acmr23558727b3.29.1728053284782; Fri, 04 Oct 2024
 07:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com> <20241001124310.2336-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241001124310.2336-4-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Oct 2024 16:47:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_C6rVWqs85uRB01CK7PL5TzSBsKi00X=Gs9QiR=Fy9g@mail.gmail.com>
Message-ID: <CAMuHMdW_C6rVWqs85uRB01CK7PL5TzSBsKi00X=Gs9QiR=Fy9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dmaengine: sh: rz-dmac: add r7s72100 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:53=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This SoC needs to make getting resets optional. Descriptions are
> reworded to be more generic.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> index c0b2997ab7fd..6ea5a880b433 100644
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -49,10 +49,10 @@ config RENESAS_USB_DMAC
>           SoCs.
>
>  config RZ_DMAC
> -       tristate "Renesas RZ/{G2L,V2L} DMA Controller"
> -       depends on ARCH_RZG2L || COMPILE_TEST
> +       tristate "Renesas RZ DMA Controller"
> +       depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST

And soon this will have to be extended to ARCH_R7S9210...

>         select RENESAS_DMA
>         select DMA_VIRTUAL_CHANNELS
>         help
> -         This driver supports the general purpose DMA controller found i=
n the
> -         Renesas RZ/{G2L,V2L} SoC variants.
> +         This driver supports the general purpose DMA controller typical=
ly
> +         found in the Renesas RZ SoC variants.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

