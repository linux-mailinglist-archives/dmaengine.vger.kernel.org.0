Return-Path: <dmaengine+bounces-3273-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DAF992623
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521251F23D13
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 07:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F238217C9E8;
	Mon,  7 Oct 2024 07:34:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569E1474D3;
	Mon,  7 Oct 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728286463; cv=none; b=mGcNaRtNZ4QAVaLIeIjNFxPRO40F+C3EW12iw2gI/cAdI1qP9MgzuLk05qS2TIq0VD3Ur/vEsBuFZU2eJ90X76ZGuuoDoURYytTcoWVoX2RkwPoPBJJ2zyEAQfRSw3fiWR2xGLYmLa30WLd7WyUNCl6sPLbe/azb4A1457Bs1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728286463; c=relaxed/simple;
	bh=ings//53iSPok57627iEVA5z/RnFfqIespIGuRGEl74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jzr8J6r/tEFQWlZ6wsEZAtGFE4+2ioRqxWs+BWMdo3u51/NHTzk317QGBXDliKrhGURUWACEMw7MjWzsZRFJiGAwza+/4xbDVTKumGm/h7/0GIx6JgarBQbQgBxSlb+bT6iwg7Swsw3K3w+DhoD9ZrxY+PrLWX6NlNAuqLkibAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2d2447181so16453247b3.1;
        Mon, 07 Oct 2024 00:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728286461; x=1728891261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOF4rJdnfIcVDZg9EVo9p2L3jHN7dhzA7HQIUAeLxSs=;
        b=pmckgXzyAN2lnH+0rzjSGinJ9jgyH1G20V08rXLL7lzm3G+HDLsg5jQXkLfA1N87w1
         bHsl7AOxpuzID34kRhCt1VZ/IYYdINnCWKZ2LDI7oziYWPbtZ5p/oWhkiQ1d5+Twgdwg
         BgWFYuZZjgp3pDItNUM3+No+Cv7t7quN5Hyk1reUzpD7iR8EvSJrQ69EYDM5HT9oe24c
         6BSYXdQvluqPaWpRGDiZkQg1GJ9kE2/CnT/Ja7B2G0T9v0K1GPDpEac+9KYRXodigOw5
         8Gp1bttcLWyWet6a5r6nFh4oC2uYppd1AW1zaun4YAXbss2opFNhLiZLPymj3DXJlGM6
         59Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVkemC/kegPrMZLPDa67Z/pCz55R6oPtvvldHb4zvlueaqCcY6zep0tNg+3Ts5A/bPhJYjoBTN1uwQlvh/rrhvs5UU=@vger.kernel.org, AJvYcCWtFGV1uX80TKF5woQ6r6e2RJ5H595/FynSD6doCXkoDyaMersdAqOrRJHGWD5a4EdJMifMUB0qJjrB@vger.kernel.org, AJvYcCXcYFvaTPUKtMAh1xespQuUkYdJHd/OmGiOVRKZgS4Ewr70UTsC+rJrGK+TPEmb+tsUj5aY9Gy+hEFw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DR8lxu1RulD7v50GY7fjX/8tJ0hq6X9ZKBO8wCiuNrD7jhI9
	NpuaXBJF69TlEFRknA/8XGfr3OFjMaLV+sMT1Em3HjsdfEsx2ohLP1g5dXyA
X-Google-Smtp-Source: AGHT+IFfcMRngHYlBWJZge/qaYPmaABNqjdPxv8UYsSG7/sEfmE78uZkwV/Ny8kbvVFdccSUczAzqA==
X-Received: by 2002:a05:690c:60c7:b0:6de:1e2:d66a with SMTP id 00721157ae682-6e2c6fc803cmr83813817b3.2.1728286460646;
        Mon, 07 Oct 2024 00:34:20 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9280254sm9492147b3.46.2024.10.07.00.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 00:34:20 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2e508bd28so8345887b3.2;
        Mon, 07 Oct 2024 00:34:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuHWGJKj0L5yoXEH7bDJKn34ABhu2QsVvGmIjudPxooIBpxWoT0zgSAnTkU+oH8tssLzXlMSVPGmaa@vger.kernel.org, AJvYcCXY1n6vmn8sJ+PuGXT4cXcnXajwlUyonW8I1gwxjsK21LX5nKlT2il75OcDZsrh6xiEKTTu+86hffau@vger.kernel.org, AJvYcCXqHaqCxN/bODIeEEnYxoMQlI4Awmf4PzRcCbsWnR1UoMB2vGjdKq4IHC+Mo5duKBnlv3oICUb/n99ifFNGqJVFNlo=@vger.kernel.org
X-Received: by 2002:a05:690c:60c7:b0:6de:1e2:d66a with SMTP id
 00721157ae682-6e2c6fc803cmr83813567b3.2.1728286459996; Mon, 07 Oct 2024
 00:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
 <20241001124310.2336-3-wsa+renesas@sang-engineering.com> <qifp4hpndfhe6jlmzjmngr7uolfzvj663donhjg5x7kmeb4ey3@a2a66w5l35zf>
 <ZvzqPkUPmurHf-fu@ninjato> <CAMuHMdXzCYBn+MPz-tdcP7wJRkdQspU0ZmszMv4Uj7VWpTYR4A@mail.gmail.com>
 <ZwBIk0DZ6on8eEIm@shikoro> <CAMuHMdXOtJrnbytGp65+kxB1Wf_rjA=dzGXHXREO3Xfd8igvtw@mail.gmail.com>
In-Reply-To: <CAMuHMdXOtJrnbytGp65+kxB1Wf_rjA=dzGXHXREO3Xfd8igvtw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 09:34:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQpHCpM7fYL6t9vgm4HYd0aaNCJwm5rt1LMft78m223A@mail.gmail.com>
Message-ID: <CAMuHMdUQpHCpM7fYL6t9vgm4HYd0aaNCJwm5rt1LMft78m223A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Mon, Oct 7, 2024 at 9:30=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
> On Fri, Oct 4, 2024 at 9:57=E2=80=AFPM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > > According to the documentation, there is no bit in a Standby Control
> > > Register to control the DMAC clock.  The driver doesn't care about th=
e
> > > clock or its rate, so you can use P0 if you want.
> >
> > Would you prefer using 'p0' or leaving this patch as is?
>
> Leaving the patch as-is is fine for me.

Upon second thought: the clock would only be used by the PM Domain
code.  So without a clocks property, "power-domains =3D <&cpg_clocks>"
would not make any sense, and the power-domains property should be
made optional.  The pinctrl and irqc also don't have it.

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

