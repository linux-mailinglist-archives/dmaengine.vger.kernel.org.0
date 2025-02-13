Return-Path: <dmaengine+bounces-4460-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE0A341DB
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2025 15:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424613A4F52
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2025 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD2281358;
	Thu, 13 Feb 2025 14:23:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7081448E3;
	Thu, 13 Feb 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456627; cv=none; b=rkzTizfQHDyLMR+stf35LWqRDLkod7vm6EnA+Z1HxjHWw81iF8YvNrsOvZMyc25Me/YuS45ydXvf+/MF/dCHsFIxdIO97YQIVVxYF1hl5Fa2gdvATWSjKMkQ9PtIQTsfGZicpPJ2vLDCil98pqmFLq8TY28uEMSHL+HQZySp7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456627; c=relaxed/simple;
	bh=F6BRopu2Me//63E7XZUkAT+jprfQeLRcaKQajamFl3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/ADACVgK/QR8Es54SljxbcGqy4RnhGhvFEYMH0cy07kI7PkjEwVLYUKiwHgh670s+9IHNenDibleTG82jzszACJtcI417oCOZigkXW7xlGJ7pX3ebsbJlwb2uQjvMb5umsa5ZpAiMyMA/0tJ5grLTtNe3NasxY9r/Sot9t//c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso155167666b.1;
        Thu, 13 Feb 2025 06:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456620; x=1740061420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHSgJszfLDZeHaQS5NV0NOPYQsN3xJT9cATzZ4X1fNQ=;
        b=SKFEoaUB/DHGlbUjqFYbLix5gE/g/7SI+3NnywtMXI8mQWN6kv+jhTXOOKkSguVbgh
         obKBqYtE1kOKDgcwBeZxo5z37FQsMu16yVlZVnMENSIxr6nD76dYO2xF2U19o9i4u3It
         rBQ79uZd7mrdxv0OhXH0z0Q/dlVgc0uVrDZhD+U7lHjQGWQ6dgXzNjQc7iD+mX3O/Hfo
         vkzB08hPvgwDQlGuEOJExblWNrxmPyrC5cBHQgbfju41ns8YyxsoeyBMsOR0Dq0Hc2xk
         b9h00kWnk1lY29m66qfaf2ZAyUJm2fZkeGdF02M2u05xxSHaU694d9zKvbXBD0xuNrgs
         j1/w==
X-Forwarded-Encrypted: i=1; AJvYcCUGQscAX9qggAkQ28SCCWSOD1vAfbeuHmD9bG8aimoQ0rOYHM/4rtVFiMI0DmGWeHnOgs7oj9rRKfM=@vger.kernel.org, AJvYcCUtgT0DMKKh3IMS31xSfm2oZx66fFYeM/Rdp806fbPQAseHY0HcAFAZmguIbnYfmNGxRn2avEbICmanHxBW@vger.kernel.org, AJvYcCXchF0N3l+LAEciShD5nhMqDhKkH8QDPYyH2SbjvmKn3sYK15hDghlLP3BU70/VvOHG1ejQiA21Opa5AlHGX+Kh+hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSlinQt1/7ar0umZ4GVrbZqCGjySrAZ78dknTQf0lHHYAaZCI
	nsJ5UuYTu8k39YCiIM9WcwWvg3OvVIur3XeUq+PkgnE7mOaIrjENQtFltf97Kkw=
X-Gm-Gg: ASbGncs5bAIn97v+RCo6v+O48aHGeVebCjleEKxrMA5WzrWYf9OnxOBcgvWgdQJ2PyQ
	F2IfZuUgrED6FG0X3gCgVLyTFPAu318TzjvB9ejxk2SrVAaZkQd20S9J7mYS250M5Zk9tCRkkU1
	BANZlYoCCkWc6nPAIju4J/v62BjtijXWMvacrDhJGRLxpU7/tCB7UgqC5PUzpWjJh/obLacGgzU
	fhjLw717sSySD8ZsHbdhIXw6z0xpsc6KNCpbvqBDuLYhBNrTjt0h6Js2h6Vc0LOnrwxrnyqJLeq
	+oUMI8wnFVZhfX4z8tM1LhbbVNxV+XXHh4iR90CicrRoZlbYXSpkVQ==
X-Google-Smtp-Source: AGHT+IFYYKS5kSeyZiS3FH2bgkDEpXj8AC7vIzs7bmUkKzrj9dPyfLNRAfn+288ok9ovHPW0EgCR4w==
X-Received: by 2002:a17:907:7208:b0:ab6:36fd:942a with SMTP id a640c23a62f3a-ab7f34d3138mr714516766b.50.1739456620007;
        Thu, 13 Feb 2025 06:23:40 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bf70asm139192466b.180.2025.02.13.06.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 06:23:38 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso1407914a12.0;
        Thu, 13 Feb 2025 06:23:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgPCiL0R/XNOtQTmSMnNYSMX2EXSS4dhb8EJbkGtziRTV8obXo9zCgOv7yEAg+RvGp7wztovlw/eLneQD2@vger.kernel.org, AJvYcCXScF9cfFBWRRqydzIyQ6VIir/uumxb7soxuu7T81v4Xb/cZKWW6QpnYmarFRP35ISHwyencKV1mLw=@vger.kernel.org, AJvYcCXbTv7dbCOiufzMM5Hr0/lj6EcyOE02lPhkwvQT8fJpW09uE3hg1SMDYcQMHY0VfAUhr1057XXAWxK0FcV9k2W/p54=@vger.kernel.org
X-Received: by 2002:a05:6402:1f11:b0:5dc:cc90:a384 with SMTP id
 4fb4d7f45d1cf-5deadde72b0mr6864574a12.22.1739456618709; Thu, 13 Feb 2025
 06:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212221305.431716-1-fabrizio.castro.jz@renesas.com>
 <20250212221305.431716-7-fabrizio.castro.jz@renesas.com> <CAMuHMdVUr6Z1o6MhxOj18d8rwV8O-AJQxWFEpMT8pcvb=DHB3A@mail.gmail.com>
In-Reply-To: <CAMuHMdVUr6Z1o6MhxOj18d8rwV8O-AJQxWFEpMT8pcvb=DHB3A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Feb 2025 15:23:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUV2LvjO=1MhZOp0K-ueVddAvwQeS_W5Bf8ojzzHv1g_w@mail.gmail.com>
X-Gm-Features: AWEUYZnS9mM7jaxvK2a_ueemR04sc4fa_qPjkj5le4OuSMMkxbS1Lm4j_k4gSzQ
Message-ID: <CAMuHMdUV2LvjO=1MhZOp0K-ueVddAvwQeS_W5Bf8ojzzHv1g_w@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Fabrizio,

On Thu, 13 Feb 2025 at 15:19, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 12 Feb 2025 at 23:13, Fabrizio Castro
> <fabrizio.castro.jz@renesas.com> wrote:
> > The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> > similar to the version found on the Renesas RZ/G2L family of
> > SoCs, but there are some differences:
> > * It only uses one register area
> > * It only uses one clock
> > * It only uses one reset
> > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > * It is connected to the Interrupt Control Unit (ICU)
> > * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
> >
> > Add specific support for the Renesas RZ/V2H(P) family of SoC by
> > tackling the aforementioned differences.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> > v1->v2:
> > * Switched to new macros for minimum values.
>
> Thanks for the update!
>
> > --- a/drivers/dma/sh/Kconfig
> > +++ b/drivers/dma/sh/Kconfig
> > @@ -53,6 +53,7 @@ config RZ_DMAC
> >         depends on ARCH_R7S72100 || ARCH_RZG2L || COMPILE_TEST
> >         select RENESAS_DMA
> >         select DMA_VIRTUAL_CHANNELS
> > +       select RENESAS_RZV2H_ICU
>
> This enables RENESAS_RZV2H_ICU unconditionally, while it is only
> really needed on RZ/V2H, and not on other arm64 SoCs, or on arm32
> or riscv SoCs.

As ARCH_R9A09G057 already selects RENESAS_RZV2H_ICU, you could provide
a dummy rzv2h_icu_register_dma_req_ack() for the !RENESAS_RZV2H_ICU
case, or even disable all ICU-related code when it is not needed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

