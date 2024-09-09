Return-Path: <dmaengine+bounces-3100-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725EE9712D6
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE12B20F38
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9631B29C7;
	Mon,  9 Sep 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="UCKyBw0t"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90113635E;
	Mon,  9 Sep 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872578; cv=none; b=fJVTyCkrH6fYJ62XW84FrVUmYMZ6ULZAbuKimWs3DTqrLaAaHN2yigN8C5q98ro35Z6QEhGV/niB+vHBwF2J7ld7noABvguVcmje9ETtydI+bY4929K5AKMhwXwXq8VhmJxKc+CDMvzoWO837qVbQwtDLo9J0IrOhlgUfDeidbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872578; c=relaxed/simple;
	bh=Qut1EyCSXF5XKk8lrf1jldw5ylJErkj1/nQaI3URoaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eoPfp7uIqQ6qTYo/9DP+LVLc75HHL+IXQ1bVe/76iO2k/R+8uI/cht9VYFVEOOtDni+JkNqsKmxi7rTlGKbBSkdI76+q6tSIaaCnuVmqUXlGxuNbJ6mh2A1HR5HRHHkkQtjoMrvWEw2JTZhw9htM2CCyWciwJdVn8x+SqS023Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=UCKyBw0t; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e9c:0:640:b3f4:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 36D27613B6;
	Mon,  9 Sep 2024 12:02:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id a2dHS5JKaSw0-Uuowlycf;
	Mon, 09 Sep 2024 12:02:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1725872562; bh=Qut1EyCSXF5XKk8lrf1jldw5ylJErkj1/nQaI3URoaw=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=UCKyBw0t6OLNpveKLHRyVdH4SZAFS1aM3i5JVQ8KQ5rIHiHlKcQKgkqrfFC6c8Kek
	 R9zZ3ZAROjskp9kB0OrvKFjT8aa1lyzn42GuLR0RT8850GDMyebxN0ZKhcvu8dixES
	 a/SqIJj456K3YYiyyxC8j7ouVj9XUUEG0040u5qg=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <0e3902c9a42b05b0227e767b227624c6fe8fd2bb.camel@maquefel.me>
Subject: Re: [PATCH v12 00/38] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartley Sweeten
 <hsweeten@visionengravers.com>, Alexander Sverdlin
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
 linux-sound@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>
Date: Mon, 09 Sep 2024 12:02:37 +0300
In-Reply-To: <CAHp75Veusv=f6Xf9-gL3ctoO5Njn7wiWMw-aMN45KbZ=YB=mQw@mail.gmail.com>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
	 <CAHp75Veusv=f6Xf9-gL3ctoO5Njn7wiWMw-aMN45KbZ=YB=mQw@mail.gmail.com>
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

On Mon, 2024-09-09 at 11:49 +0300, Andy Shevchenko wrote:
> On Mon, Sep 9, 2024 at 11:12=E2=80=AFAM Nikita Shubin via B4 Relay
> <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
> >=20
> > The goal is to recieve ACKs for all patches in series to merge it
> > via Arnd branch.
> >=20
> > It was decided from the very beginning of these series, mostly
> > because
> > it's a full conversion of platform code to DT and it seemed not
> > convenient to maintain compatibility with both platform and DT.
> >=20
> > Following patches require attention from Stephen Boyd or clk
> > subsystem:
>=20
> Does it mean you still have a few patches without tags?
> What are their respective numbers?

The clk is the last one as i think, all others can be ACKed by
Alexander or by Arnd himself.

>=20
> > - clk: ep93xx: add DT support for Cirrus EP93xx:
> > =C2=A0 - tristate
> > =C2=A0 - drop MFD_SYSCON/REGMAP
> > =C2=A0 - add AUXILIARY_BUS/REGMAP_MMIO
> > =C2=A0 - prefixed all static with ep9xx_
> > =C2=A0 - s/clk_hw_register_ddiv()/ep93xx_clk_register_ddiv()/
> > =C2=A0 - s/clk_register_div()/ep93xx_clk_register_div()/
> > =C2=A0 - dropped devm_ep93xx_clk_hw_register_fixed_rate_parent_data
> > macro
> > =C2=A0 -
> > s/devm_ep93xx_clk_hw_register_fixed_rate_parent_data()/devm_clk_hw_
> > register_fixed_rate_parent_data()/
>=20


