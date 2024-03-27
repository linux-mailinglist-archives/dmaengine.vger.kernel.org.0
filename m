Return-Path: <dmaengine+bounces-1557-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55788DBB6
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8392293E6D
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2738385;
	Wed, 27 Mar 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRRxfm6U"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C200535A0;
	Wed, 27 Mar 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537228; cv=none; b=bfmYehkuRglLB+xTS4i6cACdNrwgE603voAQWRwvrA5N31UzkVgETrEeUvvg1DQnQpxfiTLceQbgibjXp3dtl7asjIcb0h1sEifw7cKW74aSGMmMir7UmLeol8TKbkH6XHSY2ffi1CqfOE7ReBuBSzsrlOsXaN8y7L0bjqzpce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537228; c=relaxed/simple;
	bh=Ju32kgFLniZCS7dOELnk78OlOgWmgFWMWc/+6Cau/QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKIFWkquiivFLKjFyw/v2sL8+K5CyRUue/32R+6ZPI+1aeeZCiYEfGRpa/DoNIAzahdTXBfqY+SI8u3m2GndxSKU6qoYsBcbn3qOMMva7m2APedx0vaMVHYlv1GDAFTSfNwr2ZcyW8QZFih2bWDeM/HXSvZyIgei4t6Kf5+Yr/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRRxfm6U; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4702457ccbso836072666b.3;
        Wed, 27 Mar 2024 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711537225; x=1712142025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju32kgFLniZCS7dOELnk78OlOgWmgFWMWc/+6Cau/QE=;
        b=eRRxfm6ULxXicwNpUD4yD25kTvEweHiT/Q8W5sFaTIwC9pvEKcpccYAsxglQ00rjtU
         4XCUJuGZW+LMrxDdCMAQ+aT8K0znkduayMLOge8pH0kufFVYPNR84nz66sgmoCtKQPvn
         9cw/XQzCL+5wqP2WZEi3p9j+MreeGsFpLIwmjCAvH34jR2AWxARItZ1gibRdCHGITZ+B
         jGypmhoPkNxkK5OEu6B9ajYv5tyjAivlf7FcHxd9YZG0dTHjrjKmuRbzMoA4rlAPJ+Br
         n/AtqK6CDmnTIErZgvx4edG64YieBo2iN0nxvoUxkVw8PnHt1Q4cCeaNJKhpG4NA3ftx
         Z++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537225; x=1712142025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju32kgFLniZCS7dOELnk78OlOgWmgFWMWc/+6Cau/QE=;
        b=MWjPYLsja431Jh9WJk3g3ZH2/NYmx36uuSvZW0xGGqmBiai7KifAKKbXrAe8ospOzQ
         eBLEz9f0VSKrXWGkISWPdQrR0DsE7PCs+H4y+UD7Dc97cyXiwzT6M6j9dLqTngxKaZxq
         0KTHpgLDpOtEY8AKXkmkS/JwnZrfAUs9NV8+Hrez5uFhNR91qvnQxP68LnY5VGXTNdYY
         5RmJppfagpo0c3FwGm7n2WFmhdRhSjB6ER4N1mPl28GHstT2647MeBn7620Vme02oeVG
         AkEfj1NjMcYrBNLqqSdnuk4TqsXCfvQhgD0D4al2wN0DmwIXngn0Mk4dfykXY6+sghwe
         ccPA==
X-Forwarded-Encrypted: i=1; AJvYcCX2vuGUhFcUU31sEHQLwaikBQSe0rLjNsEwFGwBOOwIaZDJZQdPcNbe46TNfq0G528FiFSGoMgU0CimtEHKB+6jCWRPWrCp5sRK9UT5HdsaU1tYdnVH7bsTluw98ntH0RZcqRcPsUohbilSFqPRsFmEMFTNiXCEz/0XDhpiGMX8uLkoCPGv67ez3rqpFM4/j8uJPyIrApTAT2SLSbt5H8JnUVMPDlmyGK+mRyLWF4/iM8cMwwMv9DITnuBqf19zQ3aVv0a/VAQvCLpo1SVRoA168vYG+wQhjERKEEVnsXT7hiWTcRfjEN+aWFbwPGEkT+Tzo7rHVs7nWNW00Qnmx5DvXAv940NyNBHrLL1E9bk/W8/1tEJO6aZbs68v+GlGg1+i4BcLCk0aXIu980hC5Iiw8Y808TAC7rNVHbORsPpgqmESugKDuvKxnghpRaCY9d05kZJrdgrk/6BKPNN4gebsekUAA41isaXqgp9fLd+xUGljSKgBgOvH1Z2cD8a4NQ8zStssHyKx9J/MD5PHsdg7JvRykIUEbg==
X-Gm-Message-State: AOJu0YyHbhkLC5p5YmSwAjMSsLyUSprRWOHKsmNw4LNPzh4vwqYLC9U3
	Yf54EpplH/u/TcDgrzlvaiD8qG1N1iFrAugyWNcF+S3KnNWUGl2WTQnqreY0weC8JNfOab1CP34
	LvSgUGQiALjN0g9xlV9Pzp7gn79M=
X-Google-Smtp-Source: AGHT+IFELlWWydcIPiZzRfNkNJ0aiBtjYHAQu2rRkgw6Ipxw5ipMsk32+2Jcyp9P3eYXGgeptSDoDh0kCNzfCJ8MD0U=
X-Received: by 2002:a17:906:2998:b0:a49:dfe7:834f with SMTP id
 x24-20020a170906299800b00a49dfe7834fmr616671eje.59.1711537225336; Wed, 27 Mar
 2024 04:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <dc3e2cb4-f631-4611-8814-0dc04c5502f0@linaro.org> <ZgLgY11N8dkpTZJB@smile.fi.intel.com>
 <a16f45c9-747c-4a19-98a3-aa5f47ee5c4d@linaro.org>
In-Reply-To: <a16f45c9-747c-4a19-98a3-aa5f47ee5c4d@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 Mar 2024 12:59:49 +0200
Message-ID: <CAHp75VfdsRkGiJCUsiTj0p7SMaSkJqQeojNWT3tGz2W7JhwMmQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/38] ep93xx device tree conversion
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Shevchenko <andy@kernel.org>, nikita.shubin@maquefel.me, 
	Hartley Sweeten <hsweeten@visionengravers.com>, 
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
	Ralf Baechle <ralf@linux-mips.org>, "Wu, Aaron" <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, 
	Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:07=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 26/03/2024 15:49, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2024 at 11:19:54AM +0100, Krzysztof Kozlowski wrote:
> >> On 26/03/2024 10:18, Nikita Shubin via B4 Relay wrote:

...

> >> A lot of this could have been already merged if you split it... Just
> >> saying...
> >
> > But you able to apply DT schema patches if you wish.
> > Just doing? :-)
>
> Me? Why? DT bindings are supposed to go via subsystem maintainers, not
> DT tree.

Okay, I never remembered this rule, thank you for clarifying.

> Plus, I do not apply any bindings patches, except for managed
> subsystems and none of them are touched here.

Good to know!

--=20
With Best Regards,
Andy Shevchenko

