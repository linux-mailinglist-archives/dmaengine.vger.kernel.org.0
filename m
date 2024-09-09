Return-Path: <dmaengine+bounces-3098-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F1D971292
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 10:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347E61C22AEF
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40A1B2536;
	Mon,  9 Sep 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+q5e+Mi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B01B1515;
	Mon,  9 Sep 2024 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871835; cv=none; b=Mlp4mKVjn+pmtHpMd3XjHAwbRhBvSvJT2K6cdtHWnIkZvZnTkoCw0tfkj4WkeZuHxH0uwokE2oWGZARY5QuJkXVr0KxQZ2qoOxtKIipjDXTRpiK9+pei4r+Tjm+8sih7vpN6h5FktLfNVvxa/qaGXdFGPbZmHWQk4sr0wuPRjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871835; c=relaxed/simple;
	bh=UExkI6GiOyg9fq7gq7e9415xYQTdFebhf5cMaTDpOac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=No9uvi03izYkHLV/KxNvTZw0uuY3csSCeRxaEHiy6/O0gQdH1yciw6LarJgMs94mRQyqn7u0QnawnzX/iQzYQ4HchBHyLBXSuzQrAGbFV1zl0miwKyxBojFUGE4NIcKveYbKp9Zs1NMjVeWFSQEsJnYTECW6UpRo/l0ebJKCbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+q5e+Mi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365aa568ceso3341838e87.0;
        Mon, 09 Sep 2024 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725871832; x=1726476632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMJgZ9pgfiljRe+M72ZqUEaho/KQ7dkzOtNSpn7FOBk=;
        b=S+q5e+MipOaJkFm6hsiB6NN0IOHTbPaHgjv4/SN7yeuHg2SPP53T7v3DFVVdvE20xF
         BTxGN3X/ho6TGWYEqEJVJmdIeh1LiiuU5WHYKIwSY7NmtaybwkscOZBhQNUY2HMnrRM5
         ghJxt/nCCZ+9bQJZPmc6YsIx4t6OYE4CXTUbqFTN5CaWWJGClFa2LwnQbzHLNFlB6i0U
         ejdW9JT3rfLnQoJClpWElwQqUksJlZRSaILE980xjGliZY8s2Ql/ftA29nnw6V8bJf5Q
         gRG7CPg8jBsjAcVnhIRQxKn4faVC/MHOdFwD3iLQYL6jaRop5lTLbtYuu00/WKP45Q4E
         +2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871832; x=1726476632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMJgZ9pgfiljRe+M72ZqUEaho/KQ7dkzOtNSpn7FOBk=;
        b=mrKjzx+L+WrZJeIF/k4gE7/1rwHpke3KyEQtKvruYTv5qZxRm29V6LvNcbMw55dw7i
         zyyY9lLLqENoiNQl17mS2F/CclP9h4hQ4GKGWB4j/TblFaNeQf4Au/t2OrvMwswT5EXP
         Ms5cXsZQC1lnE1Nj29bCza26GQB3nV3Wn4U8Ly9h2R+a8zA54wzsHj+VK7AP2ZwbLbJz
         SRsfSJc1O+avKpVYMFVZi9rEufT1eHfZAxgRdrCHaiC2J/XLBUCx2a9dOgddtwieSj+/
         zJB7xiFij/o6diq/RYJXKhVL/k8IvdmmYTZOjzxQyjHDwh5JT+nbfHNIuqNapO9glGkk
         VDCg==
X-Forwarded-Encrypted: i=1; AJvYcCUtpZwjw4AliwUr2Ly4NtdWc1206fUbRSJALbr8fjg9HYXiiOm95tW1++2hiqZrhUMc+omo1eCrZFHf@vger.kernel.org, AJvYcCV2KOpkQW14fNqmzGbFCh/juqxBgqLb/F6njDNsfXTejsDU6SomLSbCJrZKkLfii2WVe+hoara5520Z@vger.kernel.org, AJvYcCVjqvKthfPfBDICcjuCzxVHI+fPaw2cEX1HRUOttRGG8mW7kver96a72S5Bx3Ur4LMDEnW2f3OE2RuWQas=@vger.kernel.org, AJvYcCVpRoHKD8wfsgQKJ74NNYcWsuZU9TeKU5cRD+cYgfdyZZuYo0CJt9jDrbTI81jzsTNHAxO0TxQny6P8ncA=@vger.kernel.org, AJvYcCVzX+utP2+R0gPNtKj4Q8jurtFGBYNqfJOHsAr04Y4V7F1RRHoILB5ySP8ghNAD95hxbXyyj3aZrZqH@vger.kernel.org, AJvYcCW1b3lU+DGSuffo/6kXRxDg8FhIxkcI9rCCqBoB1mowiOM6msqOeiCN2f/4YiIdYK6SxuFDbZLMaHJy@vger.kernel.org, AJvYcCWq1gU/rGWULCcafKjqSkHZzlW+pFp/tfbwYZZNdYXzKC8Un/Rweip4yUbp13euWZMDoTzzJ+0/Txxfq7arxkw=@vger.kernel.org, AJvYcCWzNpg8f2GG8jUBSkHTxa8VF/Lfv/ELcaOPB7LjsEAZOhMEe90qTAPw9ku0mxKfKmu1RgzLZ3Gl/QZd@vger.kernel.org, AJvYcCX8vm0bSWbzrhQfa85++rE3jvYsldvfvDQ1a+jPLGqbLAt58evuuA07e6RrjVYxqj/apsKJmfLu@vger.kernel.org, AJvYcCXMcBBmaCMYZ+0DpZk6ggtL3XRfiqh+SbT8
 gW531k2le02MItrDTLHyIMYiw7UokuNpMdf+hoN+8S8BKA==@vger.kernel.org, AJvYcCXTk9BJBaa3oBZtHvGUdaqGs+4RmKI9fvc2ix6Kvcjew+ZR36CWbTKDbdOZ9HFSeoVEA9IQ0qQXQNDL@vger.kernel.org, AJvYcCXfBYWIJc1lM042B4AalZjxAjbQaNLN0mihj8KnuAeMjLKBinty3YGfGjRBz1xA3K608Q7rmPN+xJM=@vger.kernel.org, AJvYcCXtClLhTwJsUUPPzV2zkTAPfr3Is4MEXT3xBcTT9JM1EabLFCcY9RpVAYGWF73g76lpAaVA+obSVStK/N5o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+u7EhnODfDQLmMij6gUzFEYdIqUF67gmtUhkoxW26B4KLj9S
	e540vUH54PEbaDWHfjYkF1Lpbsc+QrO+mWjhwlAX9dm9Z8xRAWy/piGTwX5hY2DGTURCAYzlP+n
	IOzGJOZl5Mbvhv/2yLlCzkyuqvgw=
X-Google-Smtp-Source: AGHT+IFcTF6tcgjMw6D6S0XG2rYkA0vJft71zEud+Bt80oehc9COujaTfpbyb07ODKbKRYsDsEFhP0R5k4x+NMVw2vM=
X-Received: by 2002:a05:6512:1395:b0:536:555d:11ed with SMTP id
 2adb3069b0e04-536587a67d8mr8746687e87.12.1725871831380; Mon, 09 Sep 2024
 01:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
In-Reply-To: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Sep 2024 11:49:54 +0300
Message-ID: <CAHp75Veusv=f6Xf9-gL3ctoO5Njn7wiWMw-aMN45KbZ=YB=mQw@mail.gmail.com>
Subject: Re: [PATCH v12 00/38] ep93xx device tree conversion
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
	20240904-devm_clk_hw_register_fixed_rate_parent_data-v1-1-7f14d6b456e5@maquefel.me, 
	20240829-cs4271-yaml-v3-1-f1624cc838f6@maquefel.me, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:12=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>
> The goal is to recieve ACKs for all patches in series to merge it via Arn=
d branch.
>
> It was decided from the very beginning of these series, mostly because
> it's a full conversion of platform code to DT and it seemed not
> convenient to maintain compatibility with both platform and DT.
>
> Following patches require attention from Stephen Boyd or clk subsystem:

Does it mean you still have a few patches without tags?
What are their respective numbers?

> - clk: ep93xx: add DT support for Cirrus EP93xx:
>   - tristate
>   - drop MFD_SYSCON/REGMAP
>   - add AUXILIARY_BUS/REGMAP_MMIO
>   - prefixed all static with ep9xx_
>   - s/clk_hw_register_ddiv()/ep93xx_clk_register_ddiv()/
>   - s/clk_register_div()/ep93xx_clk_register_div()/
>   - dropped devm_ep93xx_clk_hw_register_fixed_rate_parent_data macro
>   - s/devm_ep93xx_clk_hw_register_fixed_rate_parent_data()/devm_clk_hw_re=
gister_fixed_rate_parent_data()/

--=20
With Best Regards,
Andy Shevchenko

