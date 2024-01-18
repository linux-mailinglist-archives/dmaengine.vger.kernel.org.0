Return-Path: <dmaengine+bounces-746-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5504831609
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 10:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E09B22001
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0591E4AC;
	Thu, 18 Jan 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="Es19nIjp"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A3200A5;
	Thu, 18 Jan 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571006; cv=none; b=rGcRiq/Ap6reDlw7caMUYhWonz2NBb2gbhaljS6rhMYfLBhpodrFU/oxhKIyZoT2nxohbUa66oEnMQq67gIa7HclbXHnSH61xIFCV6OQM3NR8VVpQ4Zv6P92hDnEq2k/UITHjMDqt8GdZILVu1Fqma0/LaRT2QQ0cpHVF0FlLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571006; c=relaxed/simple;
	bh=eOYgq6vBGLmYMc8CNKKKb0RzNhlbCa5ML+43wchdMZA=;
	h=Received:Received:X-Yandex-Fwd:DKIM-Signature:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=QTL9JxgW6z3tx/MK7L57XfubYZLIybjamZv0+FNyYOEFr4Y6VquFc8P1bUvrjgGFdFFCo2hNWCIFOlXqpO8pl/kdJfM0oJ9Dj798DGFihLdOE5UPLmSymiIKxG2wlIBNS63NwcrALRoG/SCVKVINK5AISCUKBldBp9Yp9deKVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=Es19nIjp; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:5fd0:0:640:c018:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTP id A8B01616FD;
	Thu, 18 Jan 2024 12:36:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id baJWEC7aoCg0-7skv82tT;
	Thu, 18 Jan 2024 12:36:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1705570602; bh=eOYgq6vBGLmYMc8CNKKKb0RzNhlbCa5ML+43wchdMZA=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=Es19nIjpoisIBb6MjPgosN8BBLwA3g37Sg+8/RzikHK2iJGA8I33MTMMnsCeSd95a
	 FcvuQE7PCMCd9C0Lf3UXj5lju7/29hXhNB61xQrIV3xj6jS+j2ttUffxBAet9gIIDQ
	 eap9ausw2GyVdWnpZfdMCuPomyP6WRpJQi/KCiZk=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <3659cd8be443f632f44f9ad31a214a82f995ed75.camel@maquefel.me>
Subject: Re: [PATCH v7 00/39] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
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
 <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>,  Sergey
 Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>, "Wu,
 Aaron" <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, Olof Johansson
 <olof@lixom.net>,  Niklas Cassel <cassel@kernel.org>,
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
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, Andy
 Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jan 2024 12:36:38 +0300
In-Reply-To: <a54csycouodnmj6qarfel7cvgupaerl7uhrruixuy7uaekqgzw@2whufrjqunme>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
	 <a54csycouodnmj6qarfel7cvgupaerl7uhrruixuy7uaekqgzw@2whufrjqunme>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Thu, 2024-01-18 at 10:30 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Jan 18, 2024 at 11:20:43AM +0300, Nikita Shubin via B4 Relay
> wrote:
> > No major changes since last version (v6) all changes are cometic.
>=20
> Never saw changes described as "cometic". I guess that means "fast"
> and
> "high impact"?

"Cosmetic" of course.

Well i guess it's nice that i hadn't misspelled it like "comedic"...

>=20
> SCNR
> Uwe
>=20


