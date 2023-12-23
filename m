Return-Path: <dmaengine+bounces-651-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B681D341
	for <lists+dmaengine@lfdr.de>; Sat, 23 Dec 2023 10:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0B0285466
	for <lists+dmaengine@lfdr.de>; Sat, 23 Dec 2023 09:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938818C13;
	Sat, 23 Dec 2023 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="I+mEfOTd"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25728F4E;
	Sat, 23 Dec 2023 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:73a3:0:640:6804:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTP id 488EE60FFE;
	Sat, 23 Dec 2023 12:13:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tCMesXBc0Os0-V3hE6yzp;
	Sat, 23 Dec 2023 12:13:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1703322780; bh=wRrzZn5duH4w8JvE1tgyoLXGclY5mY0J/Xp8ep3wT7g=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=I+mEfOTd/HhVtsgLl8P4bJlmK+xe/BHC5G4qGEcK5yI9fE4yNAbvURJYd9ebsbNPL
	 ELVCWnXzpctwGO9/5E6Lh3j51mRZlNunB6U0Mz9Ob7UmkE2sFrGQRvIiTXfqFCBTJB
	 6hHC1txfBTVi+nHDb1JfUThgM9rSEbD1FlaR3i6c=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <d6e898200b96e816ea8c8c9a847307088ec5821c.camel@maquefel.me>
Subject: Re: [PATCH v6 00/40] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andy@kernel.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sebastian
 Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>,  Guenter Roeck <linux@roeck-us.net>, Thierry
 Reding <thierry.reding@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org,  dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org,  linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-sound@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>
Date: Sat, 23 Dec 2023 12:12:56 +0300
In-Reply-To: <ZXnxBtqbneUMbvwq@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
	 <ZXnxBtqbneUMbvwq@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Andy!

On Wed, 2023-12-13 at 19:59 +0200, Andy Shevchenko wrote:
> On Tue, Dec 12, 2023 at 11:20:17AM +0300, Nikita Shubin wrote:
> > No major changes since last version all changes are cometic.
> >=20
> > Following patches require attention from Stephen Boyd, as they were
> > converted to aux_dev as suggested:
> >=20
> > - ARM: ep93xx: add regmap aux_dev
> > - clk: ep93xx: add DT support for Cirrus EP93xx
> >=20
> > DMA related patches still require Acked or Reviewed tags.
> >=20
> > got approval LGTM from Miquel:
> > - mtd: rawnand: add support for ts72xx
> > Link: https://lore.kernel.org/lkml/20231004103911.2aa65354@xps-13/
> >=20
> > new patches:
> >=20
> > ARM: ep93xx:=C2=A0 Add terminator to gpiod_lookup_table
> > =C2=A0 - fixed terminator in gpiod_lockup_table
> >=20
> > So mostly all patches got approval.
> >=20
> > Patches should be now formated with '--histogram'
>=20
> It _feels_ like some tags might be missing.
> In any case I suggest to use `b4` tool to retrieve tags when
> preparing
> the next version:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git checkout -b vXX v6.7-=
rcX
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0b4 am -slt $MSG_ID_OF_v(X=
X-1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git am ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git rebase --interactive =
... # to address comments
>=20

I moved to b4 a few iterations ago:

```
Calculating patch-ids from commits, this may take a moment...
Checking change-id "20230605-ep93xx-01c76317e2d2"
Grabbing search results from lore.kernel.org
Grabbing thread from lore.kernel.org/all/20230424123522.18302-1-
nikita.shubin%40maquefel.me/t.mbox.gz
---
NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Tested-by: Michael Peters <mpeters@embeddedTS.com>
     Msg From: Kris Bahnsen <kris@embeddedTS.com>
NOTE: Rerun with -S to apply them anyway
No trailer updates found.
```

I haven't found any missing tags, that b4 didn't apply, the ones above
refer to a very old iteration and were given to cover letter and i
don't feel like they need to be included.

