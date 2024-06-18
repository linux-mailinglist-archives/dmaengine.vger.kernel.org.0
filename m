Return-Path: <dmaengine+bounces-2411-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C590B90D954
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D34F1F2330D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB213790B;
	Tue, 18 Jun 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="Oni59Gvd"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE68120A;
	Tue, 18 Jun 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728450; cv=none; b=OVmWgbFhyxXonv+u5KvMkl3hve83CJ71g2Q015o6yl++hBybK5aGVXu8NIGDnGHInEwBUNpFLW1jY25rz12kQzPqK3gG0mWDk8LnNpPcWZpkqQbf3oXzVJQLNkgfHmB36WKSrc1XfWcV73a2LS2liolp1Dg6dYvY2uUc7h3I1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728450; c=relaxed/simple;
	bh=9Ya0AF+I5kZB8f0I6QI7f8yC9CILQ3Sjw0vL1wBTNqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVRYx69THeYwYXpv/APFRoZcrjyxZYrKsk4iXhPmjZUWcRSnTYMUvxkYMrnwRsru+OfCtVZD9U5UWOKuGjK9qIrM60PD4f20+DIk3J2wHBfWYJRfixyzSJ3JgBYD94CEec1OXN5T1HutnsL/ejDUiFbFxVtFJM6KGN2FvWDw8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=Oni59Gvd; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:3483:0:640:1715:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id A79C76123C;
	Tue, 18 Jun 2024 19:33:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nXLBadKCSCg0-WTnPBLbY;
	Tue, 18 Jun 2024 19:33:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1718728435; bh=9Ya0AF+I5kZB8f0I6QI7f8yC9CILQ3Sjw0vL1wBTNqU=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=Oni59GvdWxSFXVUm0FOyYIVzjEV0JRSU9Ip08bwMplFAtgBKjmuy5Yh1eldJeqi17
	 Pa6h6Z/eehgezUl2WVdUScufJqePeWWaxGT7OxfJGM46bfE7df2u7mV+2/KLa+XOrw
	 p+oLGi6VA8aTuPSROzXtOw+f362fnP6+ig6AeZ8c=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <eb3e6c0b883f408fed68e725a23b54854701ce9e.camel@maquefel.me>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Jakub Kicinski <kuba@kernel.org>, Nikita Shubin via B4 Relay
	 <devnull+nikita.shubin.maquefel.me@kernel.org>
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
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
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
 linux-sound@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Date: Tue, 18 Jun 2024 19:33:49 +0300
In-Reply-To: <20240618073339.499a7fd2@kernel.org>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
	 <20240618073339.499a7fd2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 07:33 -0700, Jakub Kicinski wrote:
> On Mon, 17 Jun 2024 12:36:34 +0300 Nikita Shubin via B4 Relay wrote:
> > The goal is to recieve ACKs for all patches in series to merge it
> > via Arnd branch.
>=20
> Why? The usual process is for every subsystem to accept the relevant
> patches, and then they converge during the merge window.

It was decided from the very beginning of these series, mostly because
it's a full conversion of platform code to DT and it seemed not
convenient to maintain compatibility with both platform and DT.

Generally i think it's too late to ask such a question, when just a few
patches left.

