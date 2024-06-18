Return-Path: <dmaengine+bounces-2410-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDF90D901
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 18:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE33D1C2379B
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7C45C16;
	Tue, 18 Jun 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="puzpn+qw"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879274070;
	Tue, 18 Jun 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727685; cv=none; b=VoGA4FuZOzDWgQ0l0bZg3fYHuUviVdZ6jndsygfUqeWYuyVVdrKyldDgMLGhAGkGpHZlpnicjgZKj9IhEDFkpIKs7sNbiBwHEHm4xT5UVAXiiC3RGcFgYYGKek6VPLyAdilFZfrc5OKL1P50aDG2HTBfuHwX5TqqjlfzxHmNB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727685; c=relaxed/simple;
	bh=3ZVPPTGo8cq6QNmgKbHqK8ZqZExCe+h2ikFe65E6vfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+cVVwJFl2dTdkeSdzCDsYdoI8HTsIbtSgyYGAJEqrCvaEN9r5tm+eg5U9YMwM6GJTELLp0sCA01+xYm8kR6RgG72gmwNN62OQ9peIxi5CpghJ2w16BAGcWHz1O1l5YIMJGRJbefCcDphWQkkE1allMdRIvnN5F6njlRybDzvvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=puzpn+qw; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:2014:0:640:2712:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id CAAFA5F059;
	Tue, 18 Jun 2024 19:21:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xKLHl69CYiE0-BWlTE6hu;
	Tue, 18 Jun 2024 19:21:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1718727666; bh=3ZVPPTGo8cq6QNmgKbHqK8ZqZExCe+h2ikFe65E6vfw=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=puzpn+qwZpDWr34Mz2VDbCLKw+CF3X4x7FJmlcrAAYOz4Dezeyqid/LQR6ZMsxokZ
	 7Lly2NZd33KM9/c+ruY7aecmDl3Muygsbv231bG9Mdy1tKuDl4h48bTcb1nYvZrRgL
	 GDbEpeWFZbA42dWJbNJtICRIsfhgB5fX4MxOwzTY=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>,  Stephen Boyd <sboyd@kernel.org>, Vinod Koul
 <vkoul@kernel.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
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
Date: Tue, 18 Jun 2024 19:20:58 +0300
In-Reply-To: <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
	 <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
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
On Mon, 2024-06-17 at 12:58 +0200, Andy Shevchenko wrote:
> On Mon, Jun 17, 2024 at 11:38=E2=80=AFAM Nikita Shubin via B4 Relay
> <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
> >=20
> > The goal is to recieve ACKs for all patches in series to merge it
> > via Arnd branch.
>=20
> 'receive'
>=20
> > Unfortunately, CLK subsystem suddenly went silent on clk portion of
> > series V2 reroll,
> > tried to ping them for about a month but no luck.
> >=20
> > Link:
> > https://lore.kernel.org/r/20240408-ep93xx-clk-v2-1-adcd68c13753@maquefe=
l.me
> >=20
> > Some changes since last version (v9) - see "Changes in v10", mostly
> > cosmetic.
>=20
> ...
>=20
> > Patches should be formated with '--histogram'
>=20
> 'formatted'
>=20
> ...
>=20
> > Changes in v10:
> >=20
> > Reordered SoB tags to make sure they appear before Rb and Acked
> > tags.
>=20
> This is not required. The importance is only the order of SoBs
> themselves. If they are interleaved with other tags, it's fine.

Ah - ok. Just saw someone was complaining about b4 reordering them.=20

>=20
> ...
>=20
>=20
> Hopefully to see this series being eventually applied soon.
> Arnd? (Do we have all necessary subsystem maintainers' tags, btw?)
>=20
>=20

As i see from my perspective only three left:

Clk subsystem:

- clk: ep93xx: add DT support for Cirrus EP93xx

DMA subsystem (but the only request from Vinod, as far as i remember,
was fixing commits titles):

- dmaengine: cirrus: Convert to DT for Cirrus EP93xx
- dmaengine: cirrus: remove platform code

Beside that tags missing on platform code removal (which can be Acked
by Arnd himself i believe) and dtsi/dts files (same ?).





