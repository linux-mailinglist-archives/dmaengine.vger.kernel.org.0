Return-Path: <dmaengine+bounces-1006-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3556852D28
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 10:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318411C22588
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B22231A;
	Tue, 13 Feb 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="tHSpq6lL"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0924B23;
	Tue, 13 Feb 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818186; cv=none; b=QI7nBdzTdNc4W0bA9jmM5hHsnvmhg/HKtoT/6Mk+y/tZUirFBIeCclB//pfVQ611ADmfF7v6xH9FzT8c58o77YDIlvvwYWCrkLXTnt6FAZ74wFdfDMe8h/q/aE3diqXcuKWLcwh26l9aMUT/sBRi8udWRZEXGW67LNluUaYk9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818186; c=relaxed/simple;
	bh=BNSX9WQo4fdZixPgrChnndimSE1LeUip7SbHQG3EiRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lnVHOfnO/tsUVI4Dqx9fzVPhFcYxDlxJLDe7xuZgHe1Ld7yh54uLGNwD6EeINwBugvtkNZw1W36Tt2BL9uErg9apphFAj82+QqqWfQ50RFTi9oTJYxTD/7iT7t31xoNP/L1/fI9zk6scWUsKoD/hRAkc1QDXr2UYPgfZ6FdX6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=tHSpq6lL; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3019:0:640:a0d4:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 9CCD561154;
	Tue, 13 Feb 2024 12:48:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Amja449YvOs0-Ohe7AJJt;
	Tue, 13 Feb 2024 12:48:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1707817694; bh=BNSX9WQo4fdZixPgrChnndimSE1LeUip7SbHQG3EiRk=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=tHSpq6lLbJRzMUl5S+AQdH+yFWqgLs5dAvYesqMe255xcZfmaDSgVPRqcA1r0bzrw
	 TkfIPDSLR62NkdUlPI+s/lCQcEhokM08txNkwukmx6USimZGbDh66EHaLNxEHxEu27
	 3BeQU0snEq2nQPzdmEknsfQ0A1hkYVGjcAylct3Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <84444657b86c7a25ea2e6031ea85978917f33342.camel@maquefel.me>
Subject: Re: [PATCH v7 00/39] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: andy.shevchenko@gmail.com, Vinod Koul <vkoul@kernel.org>, Stephen Boyd
	 <sboyd@kernel.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Thierry Reding
 <thierry.reding@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>,  "Wu,
 Aaron" <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, Olof Johansson
 <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org,  devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,  linux-watchdog@vger.kernel.org,
 linux-pwm@vger.kernel.org,  linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-ide@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-sound@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>
Date: Tue, 13 Feb 2024 12:48:11 +0300
In-Reply-To: <Zb_DfISgoNyTKWMp@surfacebook.localdomain>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
	 <Zb_DfISgoNyTKWMp@surfacebook.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-04 at 19:03 +0200, andy.shevchenko@gmail.com wrote:
> Thu, Jan 18, 2024 at 11:20:43AM +0300, Nikita Shubin kirjoitti:
> > The goal is to recieve ACKs for all patches in series to merge it
> > via Arnd branch.
> >=20
> > No major changes since last version (v6) all changes are cometic.
> >=20
> > Following patches require attention from Stephen Boyd, as they were
> > converted to aux_dev as suggested:
> >=20
> > - ARM: ep93xx: add regmap aux_dev
> > - clk: ep93xx: add DT support for Cirrus EP93xx
> >=20
> > Following patches require attention from Vinod Koul:
> >=20
> > - dma: cirrus: Convert to DT for Cirrus EP93xx
> > - dma: cirrus: remove platform code
> >=20
> > Following patches are dropped:
> > - dt-bindings: wdt: Add ts72xx (pulled requested by Wim Van
> > Sebroeck)
> >=20
> > Big Thanks to Andy Shevchenko once again.
>=20
> You're welcome!
>=20

Thank you Andy!

> I have a few minor comments, I believe if you send a new version it
> will be
> final (at least from my p.o.v.).
>=20

Still waiting for some comment from Stephen Boyd and Vinod Koul on:

- ARM: ep93xx: add regmap aux_dev
- clk: ep93xx: add DT support for Cirrus EP93xx

- dma: cirrus: Convert to DT for Cirrus EP93xx
- dma: cirrus: remove platform code






