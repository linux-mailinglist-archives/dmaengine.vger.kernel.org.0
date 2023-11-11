Return-Path: <dmaengine+bounces-81-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5937C7E8CE4
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 22:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AB7280D93
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 21:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB901DA3F;
	Sat, 11 Nov 2023 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoWDJ6Uf"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019D1DA38;
	Sat, 11 Nov 2023 21:33:46 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125430CF;
	Sat, 11 Nov 2023 13:33:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-408382da7f0so25426505e9.0;
        Sat, 11 Nov 2023 13:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699738422; x=1700343222; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BjJpwKGCecxdkQ5LjdaCff64J4ZeBO10oL7F7MwcVn4=;
        b=SoWDJ6UfBqwi53zUN3lqwjEzqeoNaEv5zsc4CMeWzz/pa4MGPZdI9VOIJcxPXDIBXK
         4ROP0Y0M+5dKmB770QtNeBIstJv2T2waq9KvTEA62oWBNLEK3tn6EpFOzyw9GGtWBiLl
         +8vMVriKMxML9XTHzs99pBrGIJ2pgUCzNsC/krpkJ4DW+67LIIV033QhiAk/h407sekN
         7dgneR81A4ZJ6qzpDw/G/X3nhtSAj4wbdrjGmNn7/etm16KaC2w2VT3uteyhr9X8XKNo
         VPPLSZOuhkiIuszK4PUfU7/99L+ack9ienSwmJqXLSvM4HY0Dmhy8QMLdcAI/ce86wQO
         Tkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699738422; x=1700343222;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjJpwKGCecxdkQ5LjdaCff64J4ZeBO10oL7F7MwcVn4=;
        b=Hybfyddn3YmL+/eG1Hy+/BMvI3TvTEEYmHeNCUtg5U2fRYWSBljdO3ZgK1vMAd11wk
         lK04hoaBRwRdCtkCZmUbRh2k307tlfFi5piLK1vfsZRCpSTfXgK31v9T7aJhXh8+a9gy
         MW/KQyohXQqn1yD4S57z5WCrpWaw6jC/kp8b30IPQqrAV6Fs8DcGN6SILyCsaVNX6tEb
         uffx9UByCp04rFBnBtOBL6BLTxgMGkm4j6tbSRWvxffFkBv7QuMZVeGtZBm3VZO9VEpV
         /KnoSMS9k+3kGx8Xwxmr4g7S8Qn76qAItG7IWvjUZv16LtI3qdLTk2QWYWKKdLONWuql
         P/IA==
X-Gm-Message-State: AOJu0YwoZRU81bKYCH1So5JLMZQuMV2nYYu4IAh/NCi/ynapwAdf0Thl
	WteHhhvVGc7pI36hlmTi4/A=
X-Google-Smtp-Source: AGHT+IGcspAIBmQE8uECroiT5zYPxAfvcuIKjKOjZDZOhwNchFn+oYO8zOgLHmFyk1hPD+Lg8347oA==
X-Received: by 2002:a05:600c:5121:b0:408:57bb:ef96 with SMTP id o33-20020a05600c512100b0040857bbef96mr2147252wms.30.1699738422278;
        Sat, 11 Nov 2023 13:33:42 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id be14-20020a05600c1e8e00b00401b242e2e6sm8935242wmb.47.2023.11.11.13.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 13:33:41 -0800 (PST)
Message-ID: <c49f77492cacc5a30079720af58a9f2fca761609.camel@gmail.com>
Subject: Re: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Andy Shevchenko <andy@kernel.org>, nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Lennert Buytenhek
 <kernel@wantstofly.org>, Russell King <linux@armlinux.org.uk>, Lukasz
 Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Thomas Gleixner <tglx@linutronix.de>,
 Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
  Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Uwe
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
Date: Sat, 11 Nov 2023 22:33:38 +0100
In-Reply-To: <ZLqSo6B5cJXVRJS/@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
	 <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
	 <ZLqSo6B5cJXVRJS/@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Andy,

On Fri, 2023-07-21 at 17:13 +0300, Andy Shevchenko wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave(&ep93xx_sw=
lock, flags);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_read(map, EP93XX_SYSC=
ON_DEVCFG, &val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val &=3D ~clear_bits;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val |=3D set_bits;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_write(map, EP93XX_SYS=
CON_SWLOCK, EP93XX_SWLOCK_MAGICK);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_write(map, EP93XX_SYS=
CON_DEVCFG, val);
>=20
> Is this sequence a must?
> I.o.w. can you first supply magic and then update devcfg?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_irqrestore(&ep93=
xx_swlock, flags);
>=20
> ...
>=20
> > +void ep93xx_swlocked_update_bits(struct regmap *map, unsigned int reg,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, unsigned int =
val)
> > +{
>=20
> Same Q as above.

EP93xx User Manual [1] has most verbose description of SWLock for ADC
block:
"Writing 0xAA to this register will unlock all locked registers until the
next block access. The ARM lock instruction prefix should be used for the
two consequtive write cycles when writing to locked chip registers."

One may conclude that RmW (two accesses to the particular block) sequence
is not appropriate.

[1]=C2=A0https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.=
pdf=20

--=20
Alexander Sverdlin.


