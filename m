Return-Path: <dmaengine+bounces-2391-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4690AC69
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E23B1F23B32
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3261940A2;
	Mon, 17 Jun 2024 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3ddtES0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B75025E;
	Mon, 17 Jun 2024 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621942; cv=none; b=PhyG4e9Chl10awX8ElTvOukSpto5d+MZqRORWtKBIcwnUIuxBPld6lmHRExnhwcwI+frz8ogbbMC2lVQXjtlQIT1BbPBB2rcVnXrTXhRNFpfkvOFbzQqeEZJSCaJPY+wMEGwAz3CjEuMIdtaH4c1fYHi2S0E8QiM22tavY1ilIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621942; c=relaxed/simple;
	bh=8wB8dLUWtRHRl79UEIYwwpGcoRPP7LZqthPrT0xkjS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmSL8pHWP7tXChYqmQ4L9lut8TUNjQJA7qNleqICbF9gXTry/4g98x9EgrAmdRwXRZtVzNyNXgOGXh0UQuT/OLhcjz347ixgqKgfOrvQnmOPwB/Y7m7OMGrDufCbMgqHuk4O0JofMDXafhWZXcNpRtDTRtYgywjH/U1HmAJjI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3ddtES0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6efae34c83so526291566b.0;
        Mon, 17 Jun 2024 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718621939; x=1719226739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wB8dLUWtRHRl79UEIYwwpGcoRPP7LZqthPrT0xkjS0=;
        b=G3ddtES05KBngq6UHWH+bLeDVjHVfJjrer71x1oClPjFqQBWo5q9UMK1VfJW6kJjJq
         F4PZsQestdbLeUKH8unSqie5VDD7EagbCBXSZaSHuKvJxjTFA/00cMjlFbvezuyidolY
         8IJb1AK6waFkrjIHxm7K2jDf6tFJR0iyUq90OZ/4DYyR6qbWKG66yZWTuedKtIqlm8W5
         z4+SG4bxj3pYqXnzunZrkvLOprES3JCkbQ5t/523EXHIeWZN+QHdYZwKrt/L9C8QlQPV
         PqKllIoFKQiOiLgDsIpjcCywPn+fn1M61OU6KA6imYIqeZ1vynt+cI/1YCXgPb1rWNm9
         QYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718621939; x=1719226739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wB8dLUWtRHRl79UEIYwwpGcoRPP7LZqthPrT0xkjS0=;
        b=Cem9PGTanUq25o7phJ/RZGVY6Fpz35uWfNYKsGpdnXX0rElhFVmgGP6Rrbje9nyAtx
         NE54dUSFZtoOAJa5sj9dDnNckeTkqQ8/kk6MQUeNvSPggSXKCRYVClQaZ7hk458B2v2b
         GLOcjRAvV+53S8o1kDhSdBCs3m+FS23qVsf0umL7PczsUqqdK/Agg899XxTdVZr5un84
         AoH5wT4ZNz6tOzfnptMPeISwSWBiphVQohjan6l0x7LDYKpIIZn0VvDYDCkHD6FuyRMe
         YlfXnzfqlGgFUZZNP7aY4G/UvmOpnx4P6z0MqxjjyVcqS71crNSmCMU/7Z5RJTK8EMf9
         cx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAoM7IbF4e2rcIclY5h762jyQSucTNkLrD1Euq0cJADoK/mEztSfuiQ78x0JeizEcchdTzju5NKh3G9SaF+VGrSV/rK7krkENH2e7qRK5DavQ4pVAevFe8x0Mn3jB7Hg2kiq43LmavSpsdjDh07LxqqNde3hqzi1dr3zeXkuBeZeH/2BZ9+0lRqvc3tQOzfU94er3VowrZ75uV8sr9HiYAOHJ4qDqQzyEtvEFaTb7DqC5WzsZv4IUfnuQHOdORpeTNxsKSynsSyEOyMg5Moxi9xMaXkXKDCw1r3C3S/gcbSQyBCU6J02FbV4/bRkDFvCOBPyOpM1xXnRbB03w5+O7BauI+6ZATcO6orxmdmRNVG5Q/7wrcDhuSFxlAdtv3w1Zr23MPqM2kCzjanP/BNourXGHl23JmDSvhdAIh4f208KUpeEosZ3LvPokFg9xO9A23MYBYQMtCvey1Hx/dqcAEiGbId9RB2JWBvaVgwzSkjgwOV8mJcwE8U+NwTETTrg9F7ilwpITU22TB4or+sYQJ17CnWqGdcw==
X-Gm-Message-State: AOJu0YwDIXeuRJwaLI4H401MKf5j+cAUX/r4xUQja9OxSvnLuZ9M+2WY
	dtJO0KPQnet/MhpGT+GXwov5CXnBDWDEF09Fcua+E1aLv53pVi3/mLPFrs35TGOr+BtRwrdybUu
	xjNN4gi2Cdat2K5oceKxYGXHsoi0=
X-Google-Smtp-Source: AGHT+IFLQNwGHlc2x1pJKtfDQbxygWK6Gf7QAcGKtHzYeiun/g/cbs2h4qNhFprWOgm/WKjClpcVLvXhnCvHBWIHCLQ=
X-Received: by 2002:a17:906:f8c6:b0:a6f:d1d:b523 with SMTP id
 a640c23a62f3a-a6f60d430e6mr561654166b.36.1718621938822; Mon, 17 Jun 2024
 03:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 17 Jun 2024 12:58:22 +0200
Message-ID: <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
To: nikita.shubin@maquefel.me
Cc: Arnd Bergmann <arnd@arndb.de>, Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:38=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>
> The goal is to recieve ACKs for all patches in series to merge it via Arn=
d branch.

'receive'

> Unfortunately, CLK subsystem suddenly went silent on clk portion of serie=
s V2 reroll,
> tried to ping them for about a month but no luck.
>
> Link: https://lore.kernel.org/r/20240408-ep93xx-clk-v2-1-adcd68c13753@maq=
uefel.me
>
> Some changes since last version (v9) - see "Changes in v10", mostly
> cosmetic.

...

> Patches should be formated with '--histogram'

'formatted'

...

> Changes in v10:
>
> Reordered SoB tags to make sure they appear before Rb and Acked tags.

This is not required. The importance is only the order of SoBs
themselves. If they are interleaved with other tags, it's fine.

...


Hopefully to see this series being eventually applied soon.
Arnd? (Do we have all necessary subsystem maintainers' tags, btw?)


--=20
With Best Regards,
Andy Shevchenko

