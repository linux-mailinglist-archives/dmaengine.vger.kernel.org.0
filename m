Return-Path: <dmaengine+bounces-5729-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2074AF7405
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jul 2025 14:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9C1189825D
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jul 2025 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D52E54D4;
	Thu,  3 Jul 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="0ph2alOI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671102E5400
	for <dmaengine@vger.kernel.org>; Thu,  3 Jul 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545566; cv=none; b=Wz/ASb+YnAAXClKxZ8r33zoq76Cf8kPZ3/t13M8E5j2FxybLewUQxx2l2RylGgT7DhfuYuea6TkX8eFK6UgV3FC3VmRa9DObCCiP94J36i75KbZ7xY4an+Y83d1Rq1mYpOOtjvcYlZacJL9N3YPlYRoKdzMBqEi5SxebBLUZ5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545566; c=relaxed/simple;
	bh=xsHVzhy9sxS1+Yu3Y3Hn/VCKn8LRiyWwMmN5vGs+6YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKv7d6A7t34GWqOXD1Cd3pc4V6NLtrWQbtk2heWyejw/N3wxDhv611lRSNJzbwu7BNE8hYCuOYmVmzDv/okvaOgnCMFf35ZMjXzsnSqaiVER3Ic0heaAeh7i32+oz6ZHzQb8RGRfxeQH1aHFWZZmFc+YUtsGQO0HyobrxOAGJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=0ph2alOI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso8597802a12.0
        for <dmaengine@vger.kernel.org>; Thu, 03 Jul 2025 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751545563; x=1752150363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nObl+SYcIa3QW/piwikKudB5bjd1HimTQxS37KWupiE=;
        b=0ph2alOIDnUdDxyGI0N55UnsDPiWsccgdo657pw4tSifz4aFf2qYzWwNJ66HvjQYPg
         P9hLIcINI3/I13YyzcVxD3LIeRDD5lo6aqKlDATR14yJmmNb1rICuLTZbqG8Jj5rQ8y1
         21weVM+c+DYPtVt1b9FbFA56JgCxm6gemqPc6CVDX1zcpbfuI3BHTXNNEu6TNoca8cgq
         VR8+4jjvAIr0agxWNOfXt5pbkh4aWzCokOXr4qTjswmXjTHZEC3M1cgetNnjbBzc09L4
         FEyf5WFNig2f6N5QBS6c/O1spGl3AMXYIqQ16h4WO+k6z+4RItNT9tLrtxEN1UragL81
         wQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545563; x=1752150363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nObl+SYcIa3QW/piwikKudB5bjd1HimTQxS37KWupiE=;
        b=L5YsuKhwaYaA4LWdAoogtQIj/nO+/ACCdDFiS4vpInCMiXbiBwvJCigSOQDr0kMMuC
         CBHhiuNICWl1AAkuWgOdXK13GBPu8T5pMyClMK7P5CXcgTb3bxtoO7pMeQ602BsIHNAS
         RgxBxfHucuMzn+vDh106GMXPha16ZcCQMoxzx5wyqIEo9fzcq7fGPfa/GpQOy6PwBVY0
         OQQ4t0eNQVVRIUrmQjQXzkhjXOgSLJgSYuG2Su7Qd1kj5xlKCHE5XnnPETuApuvkvAez
         Z7Y83kGaPb9iE6vwTa8G4M1PKAX4OgE3Kqx3ymHJb7bVJCPw0GssSuPoP2nj+mx9UrHR
         Z6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW4lmitavUIy2Sf5+JR3RpXDv443oBsp3YZjTnUS8kbom/LDd/Rke1zIFh1Q9zzq/82CssHAUtsaAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhPRAAy6aKt5CRFnPrifhWkV7pcR5dliyWJxPdROmGJgjJEOA
	MAo5iwOHHWK585rf1ydlWa8KuJFHjjo+YgQyNAAJsAiKW8ESzv342kRyY6v1J2eh/AxfwP0CWT0
	qT7m3INePDZjeNT9zZPcChAh1yoDE3ugsGiWdBzK+Nw==
X-Gm-Gg: ASbGnctWKpD4x6fYdrIftzhNjcL7RZSO/buK1NiBrEq1ogrLcO9oz3eXHxDUET2mHo+
	c1OAnesG7SzaeMD8RsTkpV6KTp9iV6GtpsPN3Y2Y2Z85weBospAumpgnWCiNcaryfCNzP9+8pZm
	mBGhyXH1rPeWjuSlq9CmXAOECohK8oryMSoTqlDnJtQxtE98+9zNILDT8=
X-Google-Smtp-Source: AGHT+IEQsYSlWMf3Q9ENbLYf0hzYQ7kNTdCoTK8bDuxoivKIYAt9JBafQ0ZP5WqZFwf5XmjzV9WjVxRtGoE8EwoykYw=
X-Received: by 2002:a17:906:6dc2:b0:ade:2e4b:50d1 with SMTP id
 a640c23a62f3a-ae3c2bb9a30mr525010866b.29.1751545562485; Thu, 03 Jul 2025
 05:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
 <20250702183856.1727275-2-robert.marko@sartura.hr> <ea353170-6e03-4231-afc2-3dc45253931d@app.fastmail.com>
In-Reply-To: <ea353170-6e03-4231-afc2-3dc45253931d@app.fastmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 3 Jul 2025 14:25:51 +0200
X-Gm-Features: Ac12FXyEmDCCZ2eYF1-BFnQ2rb5Xpv9SlBj8TpVb-TJbG9_3w-Q9dIeIUPPsPkE
Message-ID: <CA+HBbNHxiU5+xVJTyPQFuCJLyEs5_MpybSBEgxi25bzaGfiVHA@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] arm64: Add config for Microchip SoC platforms
To: Arnd Bergmann <arnd@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Daniel Machon <daniel.machon@microchip.com>, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 9:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> On Wed, Jul 2, 2025, at 20:35, Robert Marko wrote:
> > Currently, Microchip SparX-5 SoC is supported and it has its own symbol=
.
> >
> > However, this means that new Microchip platforms that share drivers nee=
d
> > to constantly keep updating depends on various drivers.
> >
> > So, to try and reduce this lets add ARCH_MICROCHIP symbol that drivers
> > could instead depend on.
>
> Thanks for updating the series to my suggestion!
>
> > @@ -174,6 +160,27 @@ config ARCH_MESON
> >         This enables support for the arm64 based Amlogic SoCs
> >         such as the s905, S905X/D, S912, A113X/D or S905X/D2
> >
> > +menuconfig ARCH_MICROCHIP
> > +     bool "Microchip SoC support"
> > +
> > +if ARCH_MICROCHIP
> > +
> > +config ARCH_SPARX5
> > +     bool "Microchip Sparx5 SoC family"
>
> This part is the one bit I'm not sure about: The user-visible
> arm64 CONFIG_ARCH_* symbols are usually a little higher-level,
> so I don't think we want both ARCH_MICROCHIP /and/ ARCH_SPARX5
> here, or more generally speaking any of the nested ARCH_*
> symbols.
>
> This version of your patch is going to be slightly annoying
> to existing sparx5 users because updating an old .config
> breaks when ARCH_MICROCHIP is not enabled.
>
> The two options that I would prefer here are
>
> a) make ARCH_SPARX5 a hidden symbol in order to keep the
>    series bisectable, remove it entirely once all references
>    are moved over to ARCH_MICROCHIP
>
> b) Make ARCH_MICROCHIP a hidden symbol that is selected by
>    ARCH_SPARX5 but keep the menu unchanged.

Hi Arnd,
Ok, I see the issue, and I would prefer to go with option b and do
what I did for
AT91 with the hidden ARCH_MICROCHIP symbol to avoid breaking current config=
s.

>
> Let's see what the sparx5 and at91 maintainers think about
> these options.

Sounds good, let's give them some time before I respin this series.

Regards,
Robert
>
> The other patches all look fine to me.
>
>      Arnd



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

