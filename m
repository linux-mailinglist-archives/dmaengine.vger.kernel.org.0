Return-Path: <dmaengine+bounces-87-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6287E9A19
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 11:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8541C20329
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825E61C689;
	Mon, 13 Nov 2023 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkvOUisf"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16118B08;
	Mon, 13 Nov 2023 10:20:34 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE59135;
	Mon, 13 Nov 2023 02:20:33 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778925998cbso294291185a.0;
        Mon, 13 Nov 2023 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699870832; x=1700475632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB3t9eIHw+pKT3CBB8s0t2nQUBpXnYyol/A+bIoemXQ=;
        b=KkvOUisf2C9SZ/nFzlsFWWu8+sxP2uiAb8DoUDyWDa8lE5GOiSUwPnyOqGugu1eMFk
         ZFGSDmLhKM86Oj48wFADNnOuL44xocgd0dhTIpL0xPBECQE6WfngHSD9xyw+TpN024Vr
         9NdeAqE4+W1u4/RSyKVWcb2Xcz0Cthz/NpP9diSHlJLBJB3U9dXsPQEd9E6MCZ9nE58b
         zbC3SIr/CBDk5H8qihN8pnSq2IlQOLs4c6auNNsDVkfd5+cmFiIZNXRwsBZAbTXKgcjd
         j5P+b6My3Xnm9yTv2T+7W2BOaO04kWotE89VWfFsUF523/DGwz3DcoeB2VCpKhMC8H4z
         DCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870832; x=1700475632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FB3t9eIHw+pKT3CBB8s0t2nQUBpXnYyol/A+bIoemXQ=;
        b=c4tEQ9yhcmr3ZXKrA8N3ylQ8QwD+1P7Wrau3s7ia6aOUh0xgUI+RRJ5huIGcE+cJsu
         3OtVYSsoFoIainfO2FfUzq8thQhabMyek06Ffav/eqzwoaLZxs201bN0nALOBMkHonLY
         Q6lrAHwXUzOtwZ4gYRvld4clDFejdEIlf5HHC6wREkvO9ejLoBXZgb4M4lH8PfQjUZKx
         Cnyf/wONq6Nh9PoB0yTYDMFDEecimABNRYdr1kIANep3Nz2kqE79V8SnhYLRTzAR7foY
         L29ayQAQncS9jCUhzDTOFbH+xhz52aV2ZM+Q+KexvWsBvInlDT45DUngRnsie1WPCfA3
         zHAA==
X-Gm-Message-State: AOJu0Yyb/A4j248LGZ5MzMmO+GJ5nMoJ9TsPyjjBTmuKxNnYbeR3RmPQ
	SjHd9v18+mNlrmZtO2t6gp2jj2lM1n3I1UEWXyk=
X-Google-Smtp-Source: AGHT+IHcamihKm+ziuVIZapYWw1ITNZRzLvq04tB/x59umIja9AF0bX8BVytW1nYcQa699XIK195qbQ3GDjcnycnRno=
X-Received: by 2002:a05:6214:a90:b0:671:8630:f590 with SMTP id
 ev16-20020a0562140a9000b006718630f590mr5914012qvb.18.1699870832421; Mon, 13
 Nov 2023 02:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me> <ZLqSo6B5cJXVRJS/@smile.fi.intel.com>
 <c49f77492cacc5a30079720af58a9f2fca761609.camel@gmail.com>
In-Reply-To: <c49f77492cacc5a30079720af58a9f2fca761609.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Nov 2023 12:19:56 +0200
Message-ID: <CAHp75VccVh+M444AAixVzSvM6-FsDm8jDYdakHhNFTAL8WOGMA@mail.gmail.com>
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, nikita.shubin@maquefel.me, 
	Hartley Sweeten <hsweeten@visionengravers.com>, Lennert Buytenhek <kernel@wantstofly.org>, 
	Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Michael Peters <mpeters@embeddedts.com>, Kris Bahnsen <kris@embeddedts.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-ide@vger.kernel.org, linux-input@vger.kernel.org, 
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 11:33=E2=80=AFPM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Fri, 2023-07-21 at 17:13 +0300, Andy Shevchenko wrote:

...

> > > +       spin_lock_irqsave(&ep93xx_swlock, flags);
> > > +
> > > +       regmap_read(map, EP93XX_SYSCON_DEVCFG, &val);
> > > +       val &=3D ~clear_bits;
> > > +       val |=3D set_bits;
> > > +       regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK)=
;
> > > +       regmap_write(map, EP93XX_SYSCON_DEVCFG, val);
> >
> > Is this sequence a must?
> > I.o.w. can you first supply magic and then update devcfg?
> >
> > > +       spin_unlock_irqrestore(&ep93xx_swlock, flags);

...

> > > +void ep93xx_swlocked_update_bits(struct regmap *map, unsigned int re=
g,
> > > +                                unsigned int mask, unsigned int val)

> > Same Q as above.
>
> EP93xx User Manual [1] has most verbose description of SWLock for ADC
> block:
> "Writing 0xAA to this register will unlock all locked registers until the
> next block access. The ARM lock instruction prefix should be used for the
> two consequtive write cycles when writing to locked chip registers."
>
> One may conclude that RmW (two accesses to the particular block) sequence
> is not appropriate.

It's not obvious to me. The terms "block access" and "block cycle"
occur only once in the very same section that describes ADCSWLock. The
meaning of these terms is not fully understandable. So, assuming that
you have tried it differently and it indeed doesn't work, let's go
with this one.

> [1] https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf



--
With Best Regards,
Andy Shevchenko

