Return-Path: <dmaengine+bounces-1838-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045618A3BBA
	for <lists+dmaengine@lfdr.de>; Sat, 13 Apr 2024 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4D02824EB
	for <lists+dmaengine@lfdr.de>; Sat, 13 Apr 2024 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67125208B6;
	Sat, 13 Apr 2024 08:49:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1AE28DCB
	for <dmaengine@vger.kernel.org>; Sat, 13 Apr 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998166; cv=none; b=tuMQM1TVl8BTlzZ6oicCmP81jwWrP0SYCb14mTTWYm2Z/BRmbY4FFr6mjJQxg1erjxXvY3YbWsdxthiL8jlOq0L73tIQilf7WYfWOVD8VnPNQT8XIBxOaFy8e3rbo2MASZNK2+fu8yPElinOn/Gi28lsEW9n2CiimslmDyGiYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998166; c=relaxed/simple;
	bh=6FIPiQ594KFngeqpTnGrN4qG2Klq6DDn5xZjR0G3Pr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beZJ7DZwco9Ps0fGOm85Mn78OjvEb5aDX0g6jCnm0QYyizvJEiBSDCt0fxthi6+WJknF0MyBqUKyR9kiRByXigxb9ayG98OR5wcN3CEv6mv+hvGgc37RJ0+8/axuVJO9Ma7oo0T8nWFu4M4kwMK3Qc90bvOD9yAOE54axsUrte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZ3g-00055f-W5; Sat, 13 Apr 2024 10:48:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZ3a-00C201-5I; Sat, 13 Apr 2024 10:48:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZ3a-000gB5-03;
	Sat, 13 Apr 2024 10:48:18 +0200
Date: Sat, 13 Apr 2024 10:48:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, 
	Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Ralf Baechle <ralf@linux-mips.org>, Aaron Wu <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, 
	Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-sound@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 00/38] ep93xx device tree conversion
Message-ID: <izbjcqcvjjhwwbrrhk7jer536ydi5gr7gqdg5icsbmialrrepn@dp7q6jvjujrj>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <66e1da99-5cf4-4506-b0bf-4bdf04959f41@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjwf7nurmhwqoh67"
Content-Disposition: inline
In-Reply-To: <66e1da99-5cf4-4506-b0bf-4bdf04959f41@app.fastmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org


--pjwf7nurmhwqoh67
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd,

On Tue, Mar 26, 2024 at 11:07:06AM +0100, Arnd Bergmann wrote:
> On Tue, Mar 26, 2024, at 10:18, Nikita Shubin via B4 Relay wrote:
> > The goal is to recieve ACKs for all patches in series to merge it via=
=20
> > Arnd branch.
>=20
> Thank you for the continued updates, I really hope we can merge
> it all for 6.10. I've looked through it again and I'm pretty much
> ready to just merge it, though I admit that the process is not
> working out that great, and it would probably have been quicker
> to add DT support to drivers individually through the subsystem
> trees.
>=20
> > Stephen Boyd, Vinod Koul PLEASE! give some comments on following, couse=
=20
> > i hadn't one for a couple of iterations already:
> >
> > Following patches require attention from Stephen Boyd, as they were=20
> > converted to aux_dev as suggested:
> >
> > - ARM: ep93xx: add regmap aux_dev
> > - clk: ep93xx: add DT support for Cirrus EP93xx
> >
> > Following patches require attention from Vinod Koul:
> >
> > - dma: cirrus: Convert to DT for Cirrus EP93xx
> > - dma: cirrus: remove platform code
>=20
> I suspect that Stephen and Vinod may be missing this, as reviewing
> a 38 patch series tends to be a lot of work, and they may have
> missed that they are on the critical path here. I certainly
> tend to just ignore an entire thread when it looks like I'm not
> immediately going to be reviewing it all and other people are
> likely to have more comments first, so I'm not blaming them.
>=20
> To better catch their attention, I would suggest you repost the
> two smaller sets of patches as a separate series, with only the
> relevant people on Cc. Please also include the respective
> bindings when you send send these patches to Stephen and
> Vinod.

It seems this happend for the clock series; it's at
https://lore.kernel.org/all/20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.=
me/
and received an ack by Stephen.

Vinod gave some feedback in this thread with some remarks that need
addressing.

With the latter I wonder if the plan to get this as a whole into v6.10
is screwed and if I should pick up the PWM bits (patches #12, #13 and
maybe #38) via my tree. Patch #38 touches arch/arm and
include/linux/soc, so I wouldn't pick that one up without an explicit
ack by (I guess) Arnd.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pjwf7nurmhwqoh67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYaRtAACgkQj4D7WH0S
/k4o+wgAuEjfWmNoFVoIX9NkVmNLAztPiy6Nh9yJ/HEcfVvrFbjsMvDotb4qsGsE
zfAz7mfofpUhLaFIGx1Sr9p8Zx4eXf0lmRH68rTiXE/hV39TXWKgmf03FG3yPOzN
1KouxDXOtKIiBxdhSBON/zWyYksJzI9WfjLtzPhcbS0N3CEWi7aTvVS7HmKStyAU
8/YI17F/4ym1Rf8Zm6JqyzQy5lOmmjy+Sq+BHfkB0ZpNIHQSoaOWISL3Y9bsFSJX
ALkkO6L4WJVqkAL718q6pYMtb9SiNVyQjyYgYddxFfM6c6cnhg1AV+QEk+VLTPHy
OgUVpigrpDXH/2JTVvZ7VetbpnSGAg==
=sCOf
-----END PGP SIGNATURE-----

--pjwf7nurmhwqoh67--

