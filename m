Return-Path: <dmaengine+bounces-2668-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF48092D393
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A406B220E1
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AA19308C;
	Wed, 10 Jul 2024 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="Lz4kK/pL"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DC1E878;
	Wed, 10 Jul 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619860; cv=none; b=sy98DrUBXGepTPdLMsrKoZJEeW/CSOKaGMiGzwCgk4yzfbUiSkMnHp6FDkdTdCpheyPoDEJ94yp53kjtQV1Uci6t21gftV3GCBA0MJa84hMe1K3ZFFliGB7QsYqY2OAjovsoVM20e2bbFbcb64aP3ljsohITNq+TiyAUI/QkclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619860; c=relaxed/simple;
	bh=dvNWlpITxM+kcZ2muxDh7Vnog/B/XqfEmWB2Ko9b+L0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9yABq3xNY3Qyc2Rlq7GMIWh7OHepCHoD51BHjJ0vqugDOZ2PsJJiolF17Uw/IyVqPeD8R7MWbh+A5HNFuNlfK6T5v1y6T3qOo5rZF7U1OV7GWlsWjiaMNEkjoZ74Bhs+dOvTWC+kdlv8kP1GGWvlfwkXMiOphVd+8kG/JpVz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=Lz4kK/pL; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:38a3:0:640:a710:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 7E56061E0D;
	Wed, 10 Jul 2024 16:48:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Xmecr64OiuQ0-yRS0mYRs;
	Wed, 10 Jul 2024 16:48:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1720619320; bh=dvNWlpITxM+kcZ2muxDh7Vnog/B/XqfEmWB2Ko9b+L0=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=Lz4kK/pLIiP7TRsvVcCsyN/ENXOi/cbuOigQPGq6WepeV2OMr/VX7mIKmanRWGhgr
	 BHxt03weitFN0X52cEW+k6DsO/fFgVBLHT5tNa8+AeAum0LY8n5C2G7QIul1NoywuN
	 cqt18iShdPqpcuaqZATlZBHaI3uCXuLlRUg1hK8k=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <6a0b3b3b03706367e7bd2d3ed7132e9cc454af00.camel@maquefel.me>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Arnd Bergmann <arnd@arndb.de>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <u.kleine-koenig@baylibre.com>
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
 Brown <broonie@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai
 <tiwai@suse.com>, Ralf Baechle <ralf@linux-mips.org>, Aaron Wu
 <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, Olof Johansson
 <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org, "open
 list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-clk@vger.kernel.org,  linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-spi@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-sound@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, Vinod
 Koul <vkoul@kernel.org>
Date: Wed, 10 Jul 2024 16:48:34 +0300
In-Reply-To: <8f45a3d9-429c-441e-a17c-33a163eb86c2@app.fastmail.com>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
	 <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
	 <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
	 <241a4cf9830b0118f01e8fcf2853c62527636049.camel@maquefel.me>
	 <jyvlqfvqn5bp3jmvxvwyrcqmihjohuq3o757mfph7x37kbwvtq@gtgyh4fca4fq>
	 <663b1749afeb5cec281149fdb445ed36fdcbc68e.camel@maquefel.me>
	 <8f45a3d9-429c-441e-a17c-33a163eb86c2@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Arnd!

On Wed, 2024-07-10 at 14:31 +0200, Arnd Bergmann wrote:
> On Mon, Jul 8, 2024, at 09:34, Nikita Shubin wrote:
> > Arnd,=20
> >=20
> > Are we continuing this patch series ?
> >=20
> > You are silent since last version submit, which makes me a bit
> > worried.
> >=20
> > If you suddenly changed your mind please let us know, cause anyway
> > we
> > have no possibility to merge these series without you.
>=20
> Hi Nikita,
>=20
> I definitely still want to merge your work, I was just not paying
> attention while there were others commenting on it, and I don't
> know what the current state is. If you are ready to have some
> or all of the patches included in the next merge window, can
> you send either the set of patches that were reviewed to
> soc@kernel.org=C2=A0for me to pick up, or prepare a pull request
> to that address?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd

Thanks for support!

We still have a minor issue but AFAIS only a single patch left, but
hoping to settle this one with Stephen soon.


