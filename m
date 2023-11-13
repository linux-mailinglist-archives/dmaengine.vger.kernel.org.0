Return-Path: <dmaengine+bounces-85-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4457E99BC
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 11:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5361C20329
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F41C2A7;
	Mon, 13 Nov 2023 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z60A1PtV"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E211C28D;
	Mon, 13 Nov 2023 10:04:47 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF7135;
	Mon, 13 Nov 2023 02:04:46 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c6cb4a79deso46807271fa.1;
        Mon, 13 Nov 2023 02:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699869884; x=1700474684; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wYZtbNfscHtuB7ayNjS/FaQpaEtL1M0UhXyvKDUhQKc=;
        b=Z60A1PtV6wctcDkg281eoddUSzcfWo5ujQzheRn36EJCMQZjbRvmuk3kioiYBOco9R
         +A6K5qxjUhLLak7EkIDHlH/x7ka6ZUMMb7ca4J5TGFpaBQDxrk9jTc9x+qTeIe8ON06X
         w/aV6JRsj8Z/FyJzvhuDBJaDelZxkKwJ5Z8pW29T16C+PlKKcUELf9+rN3fVPlOiE2JD
         T0hhyuPq6jpgiZjGYd1B4ULq6Kf/rHfdHjDqpTdHcUBhgsfuHXMQXoA91S14BB9GDwPy
         LaN3Lj9E3nINL3MniXBVDKnzmCCr449S/9dEqaZYaFNozj0KgqjKnXJMHeaK3UQdpjK0
         JSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699869884; x=1700474684;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYZtbNfscHtuB7ayNjS/FaQpaEtL1M0UhXyvKDUhQKc=;
        b=Ioj+dItuf8Zyxyq/sVAKneDoONaaKqbYyLGF2I/HEQaD7oDkh3aoxsy4EOY7cIlxbx
         7MsL2T8YAeS5agtPP96OBC9Da2Ipsu2K+D4aRjljux176zGhYwPkHmDrPcluhTynTYHS
         dVRTUCEXCGGZonXYJgfDPd2BSBdr+Hz78sR9A+RLiyqS0Tc24oTIyEu1ZdmFb3sdy471
         D6MwedbNKJSXAvtw74fKcuBp2Krdem9ls9r7IimpnCHPN29QVjSulSPPHNVi9XZGJwP5
         ZhhfojIrRfttKwlm0bNvztB4uiJfwQCiuRG/zTk2meiKjQaJ3V9Ili4iaoqQFPHyMsVC
         0K6A==
X-Gm-Message-State: AOJu0YydsF0OctARVawTpslY/P75FLPiY0Hl4MzPoV4wlR7rafLH2KTK
	Rddljg4F7fmSeyyAZgYlFNeKkLYk0Sx82w==
X-Google-Smtp-Source: AGHT+IFY0VBv65sXA0Ec0khQRe36/4QIzik1qErLOvxwk7VCfLMt8d6A4Y8Yy/Esbvbw7QCTYBejoA==
X-Received: by 2002:a05:6402:520b:b0:543:5144:1779 with SMTP id s11-20020a056402520b00b0054351441779mr8907514edd.11.1699869864130;
        Mon, 13 Nov 2023 02:04:24 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a67-20020a509ec9000000b0053e43492ef1sm3514675edf.65.2023.11.13.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:04:23 -0800 (PST)
Message-ID: <0cf1d748cb4a672483991f44d638a271218effe6.camel@gmail.com>
Subject: Re: [PATCH v3 14/42] power: reset: Add a driver for the ep93xx reset
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, nikita.shubin@maquefel.me, Hartley
 Sweeten <hsweeten@visionengravers.com>, Lennert Buytenhek
 <kernel@wantstofly.org>, Russell King <linux@armlinux.org.uk>, Lukasz
 Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Sebastian
 Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mark
 Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,  Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Michael Peters
 <mpeters@embeddedts.com>, Kris Bahnsen <kris@embeddedts.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org,  dmaengine@vger.kernel.org,
 linux-mtd@lists.infradead.org,  linux-ide@vger.kernel.org,
 linux-input@vger.kernel.org,  alsa-devel@alsa-project.org
Date: Mon, 13 Nov 2023 11:04:21 +0100
In-Reply-To: <CAHp75VeYHscM-r94kTrpH44W=OGVq+qoNNQZoVrR5_n-_K_Xsw@mail.gmail.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
	 <20230605-ep93xx-v3-14-3d63a5f1103e@maquefel.me>
	 <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
	 <80ed91bb971516638fa1793d648939815eba7630.camel@gmail.com>
	 <CAHp75VeYHscM-r94kTrpH44W=OGVq+qoNNQZoVrR5_n-_K_Xsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andy!

On Mon, 2023-11-13 at 11:59 +0200, Andy Shevchenko wrote:
> On Sat, Nov 11, 2023 at 8:18=E2=80=AFPM Alexander Sverdlin
> <alexander.sverdlin@gmail.com> wrote:
> > On Fri, 2023-07-21 at 19:37 +0300, Andy Shevchenko wrote:
>=20
> ...

[1]

>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mdelay(1000);
> > >=20
> > > Atomic?! Such a huge delay must be explained, esp. why it's atomic.
> >=20
> > atomic or not, SoC is supposed to reset itself here.
> > However there is an errata [1] and the SoC can lockup instead.
>=20
> Good, and what I'm saying is that this piece of code must have a
> comment explaining this.

And it has, but for some reason you've trimmed it in your reply...

--=20
Alexander Sverdlin.


