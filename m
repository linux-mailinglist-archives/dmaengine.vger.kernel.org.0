Return-Path: <dmaengine+bounces-1148-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B996086A9DD
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 09:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7535828B578
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02ED2C85D;
	Wed, 28 Feb 2024 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="EalO3ZTM"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAE2C842;
	Wed, 28 Feb 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108928; cv=none; b=p7n6Q4/bj5Epbu/Gpo2xybAjoIH8/m4FBG0lDVDP8R3ci8QPDnQV8kYVYlq+hvSE9F31RcYFKWuypxMykdiK6NEC8eftIT+eAwKEW473AsT7czqZAPARjswycb04RPQOOtAMyNIYqmRpk7NSe81EmQ5bkGmMhTedQBTqRP2fHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108928; c=relaxed/simple;
	bh=5C6vD/fRuXGe615n6PpX9VIOEIZkOgWqNNFadbqmy4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KR25EONeFJRXlMbm6own874XiOPOzSDXw3ZTFIfzn5HUca4cEO9ydIRC/v495/2AfayPp25dI/9h+qaQiZYrLbUlVcikg09RErBJZQy0GNwXPy2o3vk0OJWSZQ4DCPc7uUUaA/Wue8jdItUxE1PVIVKDPGDhHWi1u6fJkbUEvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=EalO3ZTM; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8c9b:0:640:8c33:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 7184B61680;
	Wed, 28 Feb 2024 11:23:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2NUOVYANd8c0-nNSnKwOK;
	Wed, 28 Feb 2024 11:23:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1709108588; bh=5C6vD/fRuXGe615n6PpX9VIOEIZkOgWqNNFadbqmy4M=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=EalO3ZTMGKQby2mNKqzwTBWhRSR2vOdtx+YGi+0dATxHc9Ne404mREzk3ONsmowJQ
	 Sbt6ELQEiXojAyllpQkuQc6yuKN4UbpwNHkcrWbSfpHM6co896dWu7EcWBkPxvOZZi
	 FlkHZDOUFmF5J3w7ul6ZRoH0jf1AGJ+fqIZrkwaY=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <154df7fd17dd05fdb6ba21d5f4d84ecfdb476091.camel@maquefel.me>
Subject: Re: [PATCH v8 00/38] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Mark Brown <broonie@kernel.org>
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
 <u.kleine-koenig@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>, "Wu, Aaron"
 <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, Olof Johansson
 <olof@lixom.net>,  Niklas Cassel <cassel@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org,  devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,  linux-watchdog@vger.kernel.org,
 linux-pwm@vger.kernel.org,  linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-ide@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-sound@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, Andy
 Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 11:23:02 +0300
In-Reply-To: <168fd3d7-d1e9-467e-bdd0-36c12aa81b68@sirena.org.uk>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
	 <168fd3d7-d1e9-467e-bdd0-36c12aa81b68@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Mark!

On Mon, 2024-02-26 at 13:34 +0000, Mark Brown wrote:
> On Mon, Feb 26, 2024 at 10:29:56AM +0300, Nikita Shubin via B4 Relay
> wrote:
>=20
> > The goal is to receive ACKs for all patches in series to merge it
> > via Arnd branch.
>=20
> What are the actual dependencies here?

More than a half of patches makes device drivers incompatible with
"platform" approach, this is intentionally cause we don't want any
leftovers - ep93xx should be fully converted to dt or left as is.

Currently only 4 patches that require review/ack left:

- ARM: ep93xx: add regmap aux_dev
- clk: ep93xx: add DT support for Cirrus EP93xx
- dma: cirrus: Convert to DT for Cirrus EP93xx
- dma: cirrus: remove platform code

