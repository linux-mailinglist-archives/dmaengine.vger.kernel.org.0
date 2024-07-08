Return-Path: <dmaengine+bounces-2648-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1183929D54
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48051C21951
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511B23774;
	Mon,  8 Jul 2024 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="VhLZU4xm"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F5381B9;
	Mon,  8 Jul 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424534; cv=none; b=aCBRDhC+fQSIyKfGLvD9JovgMnyrTTrcT41pG4eHKAsC+PtnC9yiEwGk1TJGLyOHu9SPG8OE+8yUp0qBunhRnZeaJZabqH+nHO7A2lnyMB9+8ckJHPzSQbggwQD+A3SP+mVWLgZnR46JIl0sBGIf44o9j+s/n+JWVn/0V7Efhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424534; c=relaxed/simple;
	bh=O9RoOO9HvF5SuUCeDg6vUA4wVmtzSSul9Xm5/s61R6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GZvza9XF6nJILN6gLmoEHqQ9x8nje2HC//JgXX1onsz18q0bmZF87ZXtK401h6yLmsqZlTjYumbt54CpIWxqOvPMdhOIdd+9tu5rPaAtPegM8g7CQ2Z4dejZltQLbRzPUlvLaRHsYodxcKvQYCvqnD1gCliZs5P7kLaOUFGUk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=VhLZU4xm; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:7dca:0:640:d4d9:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id C5DDC60A3F;
	Mon,  8 Jul 2024 10:34:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6YW3mBQe3W20-qUQtuv72;
	Mon, 08 Jul 2024 10:34:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1720424070; bh=O9RoOO9HvF5SuUCeDg6vUA4wVmtzSSul9Xm5/s61R6Y=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=VhLZU4xmXX2w4OBfMMBdLTuYfNHiVS81wr+5BeazZfJVOu+yyXSQdoaO60cjQziKc
	 M0uTvIyCbbrFj9TBj/klf6qeczg17/a4YJiSE0dCEH6yKJCldgKqcd4qvfnukuaDOU
	 WcbQbDv7ImiZUeCsbYrO017QDF3uXjKDnJWXQ9oc=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <663b1749afeb5cec281149fdb445ed36fdcbc68e.camel@maquefel.me>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
	Arnd Bergmann
	 <arnd@arndb.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Stephen Boyd
 <sboyd@kernel.org>,  Hartley Sweeten <hsweeten@visionengravers.com>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy
 Shevchenko <andy@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter
 Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Mark
 Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai
 <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>, "Wu, Aaron"
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
Date: Mon, 08 Jul 2024 10:34:05 +0300
In-Reply-To: <jyvlqfvqn5bp3jmvxvwyrcqmihjohuq3o757mfph7x37kbwvtq@gtgyh4fca4fq>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
	 <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
	 <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
	 <241a4cf9830b0118f01e8fcf2853c62527636049.camel@maquefel.me>
	 <jyvlqfvqn5bp3jmvxvwyrcqmihjohuq3o757mfph7x37kbwvtq@gtgyh4fca4fq>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Arnd,=20

Are we continuing this patch series ?

You are silent since last version submit, which makes me a bit worried.

If you suddenly changed your mind please let us know, cause anyway we
have no possibility to merge these series without you.


On Fri, 2024-07-05 at 11:21 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Jun 27, 2024 at 11:29:44AM +0300, Nikita Shubin wrote:
> > On Tue, 2024-06-18 at 19:20 +0300, Nikita Shubin wrote:
> > > Hello Andy!
> > > On Mon, 2024-06-17 at 12:58 +0200, Andy Shevchenko wrote:
> > > > On Mon, Jun 17, 2024 at 11:38=E2=80=AFAM Nikita Shubin via B4 Relay
> > > > <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
> > > > >=20
> > > > > The goal is to recieve ACKs for all patches in series to
> > > > > merge it
> > > > > via Arnd branch.
> > > >=20
> > > > 'receive'
> > > >=20
> > > > > Unfortunately, CLK subsystem suddenly went silent on clk
> > > > > portion
> > > > > of
> > > > > series V2 reroll,
> > > > > tried to ping them for about a month but no luck.
> > > > >=20
> > > > > Link:
> > > > > https://lore.kernel.org/r/20240408-ep93xx-clk-v2-1-adcd68c13753@m=
aquefel.me
> > > > >=20
> > > > > Some changes since last version (v9) - see "Changes in v10",
> > > > > mostly
> > > > > cosmetic.
> > > >=20
> > > > ...
> > > >=20
> > > > > Patches should be formated with '--histogram'
> > > >=20
> > > > 'formatted'
> > > >=20
> > > > ...
> > > >=20
> > > > > Changes in v10:
> > > > >=20
> > > > > Reordered SoB tags to make sure they appear before Rb and
> > > > > Acked
> > > > > tags.
> > > >=20
> > > > This is not required. The importance is only the order of SoBs
> > > > themselves. If they are interleaved with other tags, it's fine.
> > >=20
> > > Ah - ok. Just saw someone was complaining about b4 reordering
> > > them.=20
> > >=20
> > > >=20
> > > > ...
> > > >=20
> > > >=20
> > > > Hopefully to see this series being eventually applied soon.
> > > > Arnd? (Do we have all necessary subsystem maintainers' tags,
> > > > btw?)
> > > >=20
> > > >=20
> > >=20
> > > As i see from my perspective only three left:
> > >=20
> > > Clk subsystem:
> > >=20
> > > - clk: ep93xx: add DT support for Cirrus EP93xx
> > >=20
> > > DMA subsystem (but the only request from Vinod, as far as i
> > > remember,
> > > was fixing commits titles):
> > >=20
> > > - dmaengine: cirrus: Convert to DT for Cirrus EP93xx
> > > - dmaengine: cirrus: remove platform code
> > >=20
> > > Beside that tags missing on platform code removal (which can be
> > > Acked
> > > by Arnd himself i believe) and dtsi/dts files (same ?).
> >=20
> > Vinod acked the above two patches:
> >=20
> > https://lore.kernel.org/all/ZnkIp8bOcZK3yVKP@matsya/
> > https://lore.kernel.org/all/ZnkImp8BtTdxl7O3@matsya/
> >=20
> > so only:
> >=20
> > - clk: ep93xx: add DT support for Cirrus EP93xx
> >=20
> > https://lore.kernel.org/all/20240617-ep93xx-v10-3-662e640ed811@maquefel=
.me/
> >=20
> > left.
> >=20
> > Hope Stephen will find some time for this one.
>=20
> As we're approaching the merge window and this is still unclear, I
> applied the pwm bits (i.e. patches 12, 13). If I understand
> correctly,
> patch 33 isn't suitable for application yet as it has a dependency on
> pinctrl changes in that series.
>=20
> (side note: Your patches are signed, but that doesn't bring any
> benefit
> if the receivers don't have your key. I didn't find it neither on
> keys.openpgp.org nor in the kernel pgp key collection.)
>=20
> Best regards
> Uwe


