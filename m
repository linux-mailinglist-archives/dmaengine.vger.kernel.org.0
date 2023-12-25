Return-Path: <dmaengine+bounces-659-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B199481E22B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 20:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005F71F21599
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12DF537F8;
	Mon, 25 Dec 2023 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxYtli9Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9D537F1;
	Mon, 25 Dec 2023 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f9fac086bso25831486d6.3;
        Mon, 25 Dec 2023 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703534157; x=1704138957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+5mdzcIi0J0U/jyti3PngFAcX/L3/DjChGGJD4WjO0=;
        b=NxYtli9ZFO+nMhFI9jJM7AmM0UEQP1AYBBIsOQxfutncfFzrXXCl15MO/db7qTycZK
         E+BH/bT9aSglTtOFm3KR2+eZigo1JECteRjB+Lf6D4H+VUekocZzQOW9kNtiT6vNAEdu
         eyULYF4OpMBf9aO1e3D6n6vle9kAczFQsb+PP3Gpcj0oNr7p6TzgdohHThbsm/UKZGkI
         b7vElq1p6YB//aONShEDs/fdGYpRWY/CXq75zdr+SSC1pzI1Yeu71uwlTIlo01Fasmfd
         zmN59m49OnC7ZyKAwFOtXPoIG+DlBtpEIU1qiuOKJ3GnObSqiIA8sdeJ/CFmjuNqHnfP
         vTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703534157; x=1704138957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+5mdzcIi0J0U/jyti3PngFAcX/L3/DjChGGJD4WjO0=;
        b=MfRAV5ecmWVJGgpiky0hi3GmiB0RSj+818pzkavsUq3u4xlw+Whbpcbc4NR5ck1qNu
         mzcma0jmC70uzLWUrPKdfEreDwKq/4KUHcuv50N6x93Ea0w6D5niLKf+VqYbmmktx+dR
         p/wzOi9BfKKdLdt4VCrQiHo7gACGfG9umiT0lEHhZ5QJd1G1H52wPrcp25SfIZSe3LJu
         qsrKc7seUPyYM3N5xNz4c1jHqGLQbBsDPt3yFtFm9t9Evr+B6lr0lA9cg6lXJbFBJxGZ
         N7io5fHfSC5x1GBHnVGrxyrUjEKl7ebN4OVw9EPlUrU//1Fuw8ySkFOPhyunRP3aN9l5
         Q0KQ==
X-Gm-Message-State: AOJu0YzROFql4ZIsbY1+HX9/cPP1tbA3e8CECrK5NuBBHPpoHCInyVBG
	ikQqfEgCpEjx2AuIkPwvZPFRqML9CAnc1JlNO8I=
X-Google-Smtp-Source: AGHT+IGXQ1DzDW/z7mbnW1aKOma9kP1mZ08AqBa7wFFHcRRfcWmagU8jQFFGhrorFhUOmpGd2hGTlBhrmy9h8xA7nx4=
X-Received: by 2002:ad4:5c49:0:b0:67f:6982:edb4 with SMTP id
 a9-20020ad45c49000000b0067f6982edb4mr13149244qva.14.1703534157222; Mon, 25
 Dec 2023 11:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <ZXnxBtqbneUMbvwq@smile.fi.intel.com> <d6e898200b96e816ea8c8c9a847307088ec5821c.camel@maquefel.me>
In-Reply-To: <d6e898200b96e816ea8c8c9a847307088ec5821c.camel@maquefel.me>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 25 Dec 2023 21:55:20 +0200
Message-ID: <CAHp75Vcx8oviLiCu=cnzKcdXjEq9wG=PCiBuPTBYe6FFfUcz7Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/40] ep93xx device tree conversion
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Andy Shevchenko <andy@kernel.org>, Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 11:13=E2=80=AFAM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:
> On Wed, 2023-12-13 at 19:59 +0200, Andy Shevchenko wrote:

...

> I haven't found any missing tags, that b4 didn't apply, the ones above
> refer to a very old iteration and were given to cover letter and i
> don't feel like they need to be included.

When somebody gives you a tag against a cover letter, it means the
entire series (if not spelled differently). `b4` even has a parameter
-t for that IIRC.


--=20
With Best Regards,
Andy Shevchenko

