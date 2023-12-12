Return-Path: <dmaengine+bounces-487-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55A80EAF4
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 12:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208E01F21C8E
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32895DF1F;
	Tue, 12 Dec 2023 11:55:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A06EB
	for <dmaengine@vger.kernel.org>; Tue, 12 Dec 2023 03:55:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD1KL-0007kg-9r; Tue, 12 Dec 2023 12:53:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD1KH-00FKLk-Ov; Tue, 12 Dec 2023 12:53:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD1KH-001bPz-E7; Tue, 12 Dec 2023 12:53:25 +0100
Date: Tue, 12 Dec 2023 12:53:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Lukasz Majewski <lukma@denx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 00/40] ep93xx device tree conversion
Message-ID: <20231212115325.m4w6cg4ttdispkvm@pengutronix.de>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aamqyrxtxz2kjjms"
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org


--aamqyrxtxz2kjjms
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 12, 2023 at 11:20:17AM +0300, Nikita Shubin via B4 Relay wrote:
> No major changes since last version all changes are cometic.
>=20
> Following patches require attention from Stephen Boyd, as they were conve=
rted to aux_dev as suggested:
>=20
> - ARM: ep93xx: add regmap aux_dev
> - clk: ep93xx: add DT support for Cirrus EP93xx
>=20
> DMA related patches still require Acked or Reviewed tags.
>=20
> got approval LGTM from Miquel:
> - mtd: rawnand: add support for ts72xx
> Link: https://lore.kernel.org/lkml/20231004103911.2aa65354@xps-13/
>=20
> new patches:
>=20
> ARM: ep93xx:  Add terminator to gpiod_lookup_table
>   - fixed terminator in gpiod_lockup_table
>=20
> So mostly all patches got approval.
>=20
> Patches should be now formated with '--histogram'

You didn't mention how this should be merged. IIRC for the earlier
rounds the idea was to merge it all together via arm-soc when all
necessary agreement is reached. I assume that's still the case here?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aamqyrxtxz2kjjms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4SbQACgkQj4D7WH0S
/k4PhAf9FUkX+fzsz5zB6lrl7lgCvYm5ZVb3B7jDw5VKDO3L/jcpIQBnKW28hqdN
fjyiqoG4kcqJrqfSN7RxYVHnxPmPMREuU5dkbLnXs4nakNuG6kYOLoWYRW6g7LHA
2aJAqNPA3r1vRHwgyLaSlwVy4TxsWEJoU/Wa7pnN5VGjjyA22i9iruZRGzbsfSbG
b4TPtncg2+HG5Z2NtBTY2w2wy/0XOTgO40vcUbW+gfh+ktRpJl5quupeZdYByknj
l9QU3yt6tCJoKvAXYc2/jykymWajShXD0UJhcLTTYcWnQYEgfLWypFNR4YXJmJGC
SbVz5vPzsa56pT4BPvsUI7alw9v79g==
=T2K5
-----END PGP SIGNATURE-----

--aamqyrxtxz2kjjms--

