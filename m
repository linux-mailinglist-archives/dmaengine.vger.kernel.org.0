Return-Path: <dmaengine+bounces-2550-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC30291A1B3
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 10:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3E0281359
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03232132464;
	Thu, 27 Jun 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="fYt77sep"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098567C097;
	Thu, 27 Jun 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477511; cv=none; b=XLNDhkbXr/dR4DMCd2JJCE0Qos3YV1HJSo9TwBxPLpIe8LHWu2abh5dEEi45PfsYzuS7kNyTBW2QHB7iDxizNypSUmTiDIfxGPCdifQT0w0TZjVEorG+8pAxXQLPg9s6cVDlMby6Jo5bz5Wra7zERwQ9HcvGLFo+JiF9kkLrjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477511; c=relaxed/simple;
	bh=sncecviZ4oVzyaqVg6LU/TKkhzMCJcCvnENYdLedhDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCDDAcTYqAJfIwhLmscFk8xCyAW78PCjg/OoxkpdL++WvW/lVLcesjayHlKCKoa4pkxbpud7JcrwQZakAcKhWt4DSKa7DPLev6bpqsSraYWpficcmpSoHluYlKKsPP9D1+0knk07Mb5V2mNqZmeWPZNPVxLS704pF+/1M844NYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=fYt77sep; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:6289:0:640:5fc6:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 62E6D62860;
	Thu, 27 Jun 2024 11:29:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hTMqF50OgeA0-419Dn7dc;
	Thu, 27 Jun 2024 11:29:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1719476991; bh=sncecviZ4oVzyaqVg6LU/TKkhzMCJcCvnENYdLedhDQ=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=fYt77sepJb6Dz5nNn3wvLM2BcROhwWdG7wRisBkqtF3/hXtLy8lIDdb5a9wki+xgj
	 m+gfMLnWml2khZDKWnsANuhxBC4XcH3KBbc8wli7qPcKfOBKMiiokOznOQZASnsShb
	 uhxbpxZgH1kBKx/Vy2qTDCDcjYAISNAwQklonyaU=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <241a4cf9830b0118f01e8fcf2853c62527636049.camel@maquefel.me>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>,  Stephen Boyd <sboyd@kernel.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mark
 Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>,  "Wu, Aaron"
 <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, Olof Johansson
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
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, Vinod
 Koul <vkoul@kernel.org>
Date: Thu, 27 Jun 2024 11:29:44 +0300
In-Reply-To: <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
	 <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
	 <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 19:20 +0300, Nikita Shubin wrote:
> Hello Andy!
> On Mon, 2024-06-17 at 12:58 +0200, Andy Shevchenko wrote:
> > On Mon, Jun 17, 2024 at 11:38=E2=80=AFAM Nikita Shubin via B4 Relay
> > <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
> > >=20
> > > The goal is to recieve ACKs for all patches in series to merge it
> > > via Arnd branch.
> >=20
> > 'receive'
> >=20
> > > Unfortunately, CLK subsystem suddenly went silent on clk portion
> > > of
> > > series V2 reroll,
> > > tried to ping them for about a month but no luck.
> > >=20
> > > Link:
> > > https://lore.kernel.org/r/20240408-ep93xx-clk-v2-1-adcd68c13753@maque=
fel.me
> > >=20
> > > Some changes since last version (v9) - see "Changes in v10",
> > > mostly
> > > cosmetic.
> >=20
> > ...
> >=20
> > > Patches should be formated with '--histogram'
> >=20
> > 'formatted'
> >=20
> > ...
> >=20
> > > Changes in v10:
> > >=20
> > > Reordered SoB tags to make sure they appear before Rb and Acked
> > > tags.
> >=20
> > This is not required. The importance is only the order of SoBs
> > themselves. If they are interleaved with other tags, it's fine.
>=20
> Ah - ok. Just saw someone was complaining about b4 reordering them.=20
>=20
> >=20
> > ...
> >=20
> >=20
> > Hopefully to see this series being eventually applied soon.
> > Arnd? (Do we have all necessary subsystem maintainers' tags, btw?)
> >=20
> >=20
>=20
> As i see from my perspective only three left:
>=20
> Clk subsystem:
>=20
> - clk: ep93xx: add DT support for Cirrus EP93xx
>=20
> DMA subsystem (but the only request from Vinod, as far as i remember,
> was fixing commits titles):
>=20
> - dmaengine: cirrus: Convert to DT for Cirrus EP93xx
> - dmaengine: cirrus: remove platform code
>=20
> Beside that tags missing on platform code removal (which can be Acked
> by Arnd himself i believe) and dtsi/dts files (same ?).

Vinod acked the above two patches:

https://lore.kernel.org/all/ZnkIp8bOcZK3yVKP@matsya/
https://lore.kernel.org/all/ZnkImp8BtTdxl7O3@matsya/

so only:

- clk: ep93xx: add DT support for Cirrus EP93xx

https://lore.kernel.org/all/20240617-ep93xx-v10-3-662e640ed811@maquefel.me/

left.

Hope Stephen will find some time for this one.


