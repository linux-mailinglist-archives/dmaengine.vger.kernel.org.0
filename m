Return-Path: <dmaengine+bounces-1117-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D7D8676A8
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0764F1C247FB
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7812881A;
	Mon, 26 Feb 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlXB3JID"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302147FBAA;
	Mon, 26 Feb 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954477; cv=none; b=hU6JfemUpjotRXhVwPBjDs83JnXPFtEzkiLgUPELGCpS9BL1NlXJVmRMGPOVosUdtiBRjtLf2p09w8EQQ8YE0CMYZP43XQp0VoeGzoqI/F2H5CJrDN/t7bfEkWv7M5h2umuf5zRDBbakDMlpLBPvJbBpXgHEBtyG+lPt1CSzV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954477; c=relaxed/simple;
	bh=/x/cq3y9mTCgiZ8o1taGp5qapBsu0Js+9yDBIjMHSCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtV5pgDqIhaTTwuW5Bb+BqNZyLW0C90VzrM3FuoTdXSQGU0aZocMdmZ5As3mdhObVtkUOTiCRonRURpfju9RAGGB3pKtN3IcRBca8q5WUdXkfsB1Ifm5z0xNdbpRKrLq9/BFqCceGoU9WXPLZnCIn1ULjU24trs/4ZCqqxapcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlXB3JID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ADBC433F1;
	Mon, 26 Feb 2024 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708954477;
	bh=/x/cq3y9mTCgiZ8o1taGp5qapBsu0Js+9yDBIjMHSCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlXB3JIDgx/sTAcksbq0alUlQoDqCg6Xa3YRQvX+pgHlAoRwWxZK+VdSrlRj2tFh2
	 WgOrqwDvcC936qN+jwQVKZ/yBQozALrLax6Y8j04m5tXRnyj+JkydmSGoAHzI7WgUI
	 KqHTDMC3IriE7ZmWZAWypMlkbGGGXGTUl75UxvB8UQxmPLTH1VniZKEwN8uwFciqms
	 hwp8jKhmWx+NwD6hVHBlXwL+99E5v8sceenvE+1GFPEtOhMZEULqLhe1Vhh6Xoh1H7
	 LbARsrm2bNZ7stG6i92/78t2no6FlD6iljD6IA0lgyMjwaXW3x4+YOsejbn+51ZFV8
	 QZQeWeabe5phA==
Date: Mon, 26 Feb 2024 13:34:23 +0000
From: Mark Brown <broonie@kernel.org>
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
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
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
	Ralf Baechle <ralf@linux-mips.org>,
	"Wu, Aaron" <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>,
	Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8 00/38] ep93xx device tree conversion
Message-ID: <168fd3d7-d1e9-467e-bdd0-36c12aa81b68@sirena.org.uk>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bOKaKvSbzTVE2lWB"
Content-Disposition: inline
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
X-Cookie: Walk softly and carry a BFG-9000.


--bOKaKvSbzTVE2lWB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2024 at 10:29:56AM +0300, Nikita Shubin via B4 Relay wrote:

> The goal is to receive ACKs for all patches in series to merge it via Arnd branch.

What are the actual dependencies here?

--bOKaKvSbzTVE2lWB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXck18ACgkQJNaLcl1U
h9CsAAf+OGvM07gxhxeVoFEY2namqi3/k8QFeVfcgOHP2bvSRWzLj+Za5HJ77pCz
5NPf/dOYtbqSn6Tg6tGG7nkioQECfPyoUc75jpIZHzFp2uPzk5Zx62L2WVoDnbBX
6hzWj6VDqDZtgCB5xzXzHhEDL/OpxrUTqA3S+jeaPIeLLf5xnRDl1M4sESkZQseD
DMzGQouGu00Z+BSB/iAt4O2uN1DAyS/jipqNGmJzmCGD8wt9LbHfpDdzzQ+q6+iw
JDA6z8gDwF3jF1NH6SuoCvsVgNsRQyqLoMP/4ziVTz/XxQa2S91NnuSVz3Vk3y/k
gLUn1koeWlce3T54eUcZau09HwlwFg==
=w2Qd
-----END PGP SIGNATURE-----

--bOKaKvSbzTVE2lWB--

