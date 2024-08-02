Return-Path: <dmaengine+bounces-2784-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77040945AC1
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 11:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C281C223C7
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D1A1DAC58;
	Fri,  2 Aug 2024 09:17:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD058F47;
	Fri,  2 Aug 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590236; cv=none; b=bUMz+v/wR6s69FAgc56waUeyzG0qvFSZ//jB2i598y/ougW0NZ6kT9kDQUrCJAmVefLTa4ohGF1Jpv/L6d2LhU9mgen0gssETVaVLZ2jdksQCDfkz5CCUb6EBjLjF/vhlTC2Bn/YTGfnP3bCSoasA+7HmHptobhc0jupNHVKioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590236; c=relaxed/simple;
	bh=zKGFAM0OJiII0S+c7pWrTyX7l2cww3Qm/JcmTw00P0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6NLtRcWbGmIgOx2ROEzZRcQPDnJDeUPHvx57FuGVkzUq2CiARnqlKkNel9NxhD9dJ1gQNpG9B+TQMUdi+cHwZgAORMWzZShicuH4gO5DW4KXYJzAKVxfRWdU7QcOLJfNU/8WgYWT1lp0b+8yaSNRrXj9uPs7jiyIxu8KpEIRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6659e81bc68so71687767b3.0;
        Fri, 02 Aug 2024 02:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722590233; x=1723195033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3goJllQ/EeVX2LdedD/trg2xOAuqyXbQhSZVEEStfyw=;
        b=M9pTQM7f7ufyYwUvGSGChn9Gv8aEpctZeFJ8v/WB8O7mZethIf8icsUHUtu8ZRkS5P
         GA20NHI18p844dT06U34zMi3SwUVL5RwcDfv8LM8R/gbsLg7yhQaTHLFY2uP2aLQiNrl
         kvAXrxIZp0uyPIh8F7t98X5lOCnBCYeZuUYCMLIUSQc9uy7IYVoTXmDONm6uPE4cgU2i
         l92rzVOsXIJAJ/Z1IKtwdYRYYQ14wfbqZMAvCXQ5jMWQiKhL5N0HX0AK1m7GOTUMZEUx
         d0lEifnYepFflBBgQIElmccUg7qER2kH+4j/YslYc8YaQyvnPEwrjNMPcLOBcD2fCHsR
         LZHw==
X-Forwarded-Encrypted: i=1; AJvYcCUK1KUHJGwgjMun/SZ2lzS3ItotSl8AXJm6jDpQcghqKdijlr0GS/ePLHTR1gAYLwNw3AXHTSTqlYt5ukhs5d3+7ADjosvTDOmq8tvTBgIWexeelUJ+idRjVDsIJWGZA1eCFf/02G1UeAXgYM5pSPsvWr36NZtkoXGYnTPqxZstTgNGp8X/9ZrW945pfRom1T5q0mL4mcqQZXzpywiVsYWhwBBmCL1VR0mAvdWz4k1bOoqwaHKGV1lJjxWtr9Goo/yA
X-Gm-Message-State: AOJu0YyFGNdEGzrkkLfNezCMUa8He/lvlB1fwlRhvN8O2tBaJbhkwb5T
	rs/6owxgbpxlxBYm3ymQjdrj5zT5qQHCb7dUTKlBRcc8nnDb7T1Gk8yllBAh
X-Google-Smtp-Source: AGHT+IGqmbyLjsBHbdPQLP2sGOPUo++04nPIim2vG5EN/u5aGfSEkOgIjhYSYXyfDBtwhvflEa8kug==
X-Received: by 2002:a0d:f1c4:0:b0:64a:9fc7:3b15 with SMTP id 00721157ae682-68961037a8fmr32426467b3.26.1722590233264;
        Fri, 02 Aug 2024 02:17:13 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a135ca5aasm1836147b3.105.2024.08.02.02.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 02:17:12 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65f9e25fffaso68240887b3.3;
        Fri, 02 Aug 2024 02:17:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxSF4x08+592bjFK0sz30HjNkXc0ZThn0rtXiobj485KFhxXNLr1a8EgiCbdk+pMjZM1vT/Xb+CXee/0miAtEM2n9FpcUbZJi9nEzCOAr9GM4WCwMmnZRyu4tXNK5XBul5IVbDFHoXz0hTjL9jdPU3Iyz5hzdNvgzOjeYcqSibUuI2feHrBOgXt/teysW2h03vvy7izmLHmE8nq5R68NQU5VAq6S8L7Rn0LZLzF3a3R2sVzRDH1ttZ5Mmx5EN/SRhb
X-Received: by 2002:a0d:f1c4:0:b0:64a:9fc7:3b15 with SMTP id
 00721157ae682-68961037a8fmr32426007b3.26.1722590232149; Fri, 02 Aug 2024
 02:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com>
 <20240711123405.2966302-4-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXjTw1NFaZhNiskiA+BQV68B61H=iwZbeV1qpVdKCjTjw@mail.gmail.com> <1145bd6f-fee4-4c3a-bd71-543127f89fc8@tuxon.dev>
In-Reply-To: <1145bd6f-fee4-4c3a-bd71-543127f89fc8@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 Aug 2024 11:17:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWKiL-6YJsn_AbcXur5278va+h0H3JQ_grvuj-UPgyqyw@mail.gmail.com>
Message-ID: <CAMuHMdWKiL-6YJsn_AbcXur5278va+h0H3JQ_grvuj-UPgyqyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r9a08g045: Add DMAC node
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	biju.das.jz@bp.renesas.com, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Aug 1, 2024 at 7:30=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxon=
.dev> wrote:
> On 01.08.2024 19:29, Geert Uytterhoeven wrote:
> > On Thu, Jul 11, 2024 at 2:34=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.d=
ev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Add DMAC node.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.12.
> >
> >> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >> @@ -363,6 +363,44 @@ irqc: interrupt-controller@11050000 {
> >>                         resets =3D <&cpg R9A08G045_IA55_RESETN>;
> >>                 };
> >>
> >> +               dmac: dma-controller@11820000 {
> >
> >> +                       power-domains =3D <&cpg>;
> >
> > Updating to " <&cpg R9A08G045_PD_DMAC>" while applying.
>
> FTR: please don't as the watchdog fixes are still under discussion. Only
> RZ/G3S watchdog support was merged.

Thank you, I had completely missed that important detail.

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

