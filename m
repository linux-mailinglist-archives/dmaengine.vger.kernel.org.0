Return-Path: <dmaengine+bounces-2660-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8134992BC53
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2024 16:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FE2B27F8A
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3B18EFCB;
	Tue,  9 Jul 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMBqYN+u"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03449156238;
	Tue,  9 Jul 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533558; cv=none; b=RKUbZauoGGW8FSckwhRb83B3UWNbeBEbVdQF2HVxIl9UnJU23ZCc/WeUekGQV+3YIDFO5dSfJZXJvkuu3ENw5jog+tOR0Ago34V1t/5aGrFwF5hAxcOBtU+cNmfKXrT16K7fieGiTU9sPm1dL4g2OZzV6NgSmkUdutAsb4u7bvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533558; c=relaxed/simple;
	bh=lOu/lBsHlc0T260klipFJ3eC1pkfxWiSQhwcmOXWsVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DefYaAggZ2odaY+zuIYmsTmGcqk91GNdgl4+Hm6F3f7VL66noiUxRE3riGtI2yXyeT2nf1/dNdVjNu5LYr1IbOTeIU1zkoVR+OOKih00Lim10iYLke92g7EGhmwv9cPZdwxLdcXWxVcWvz9N1D3xEvo0tknOMDaUj5f8zDpo/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMBqYN+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EADAC3277B;
	Tue,  9 Jul 2024 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720533557;
	bh=lOu/lBsHlc0T260klipFJ3eC1pkfxWiSQhwcmOXWsVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OMBqYN+uslxW2al/s9+gRrrahqmKqVwbxAMJYDtN8CWX81snbPwX15dfdtn8Pz0Bb
	 +IovT5mqe8Psr+vz6GaBBc8o9RtQfYU6M4S+2Gx+NUUbpGA/HK3Z8knXugNYi3p6+U
	 78qpneNgjjFgQAu76HOpnjtMqWno1vSL98EX4VAp2LPz4j5pT0E+/44KPIi32WwZPu
	 tjNTXmY9EyO8A+MLcG62SSxJozhu8leZy8nJpLXGcyGV7LP2vcOGKrl4bJWU0XsFYT
	 kF6bpZbhgYDo9J/AqwU/6ppB7azQQTD2wdfdk7DA15FIUWikczGZ3sHsmu1spFGXbn
	 HqYrIHjyJ7isQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so44988711fa.0;
        Tue, 09 Jul 2024 06:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAyEeb3sQHe3oJ3e/h9Hpw32fiOTPSOrfTy1gBySlhPuLQIrxAcKGou+f3N8RhC6dSlW1TbZr/WaSTtYwVSW0yA0Bd95WCcCL4CK9vUiPNHs79Alv1aSqynoCAnJuim8sZ79biPjHwtrMf/xYLXbDL7XaGaK/k+QjkJJF3dosurXNjoxqf1jlqOcTKtAzowJIqVFsTfSloEk1YQ/5sfayaci55XynoHRgJZLSdvk/6uEMFJoRkIO9kOFXzn0YMwokp/gE/SPwe68xfZ1Knvuu1tEWOvjNTSBRlA6hmQPA1CHNbYrHsmJ5tKYTokTVps0yyPgtV3FsdzbxtuvFQheeB22Aucckz3nVmK4Jj1vyxzSNdd7l1c6C9arHDmaa2v9RjyzopJkkJ9A31zBLazXbRXmEInLmRjSJQOAHjQ7WkUeheBxoZJXjVGdKJhWArkIoT57bF2cE+IfXtl6grsDhd52hqL6MLcSPnQGvEIONu256ION0jlth4VqCRMPJ3tnXgNoQnj3gBe6LV9M/wmppRCHK+3MVmrg==
X-Gm-Message-State: AOJu0YytM8xAoMl+LSShIku3CScUPdwzUdVwjr7hpEkoc7pu7XvpMzYY
	acQDuA8rlt2xadE9VxfjhCjQzB1gIrvVYn4SW6ig3Eo35qjs9bPA/uXCXY3BL+r5Z3DtejIW//0
	8Oi9f1cvz5Z7ZCUn3Yv0ICrjbHg==
X-Google-Smtp-Source: AGHT+IGMENhIgXoK8usdNd4oA5p2Oya5uy5180V2zPL6MX5LWDNpdwwwQ6+gVbUVi74o5Dj052FJFnlAxOODOirsQJA=
X-Received: by 2002:a05:6512:3c8c:b0:52e:9951:7881 with SMTP id
 2adb3069b0e04-52eb99d20b8mr2282487e87.52.1720533535249; Tue, 09 Jul 2024
 06:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
 <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
 <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
 <241a4cf9830b0118f01e8fcf2853c62527636049.camel@maquefel.me> <jyvlqfvqn5bp3jmvxvwyrcqmihjohuq3o757mfph7x37kbwvtq@gtgyh4fca4fq>
In-Reply-To: <jyvlqfvqn5bp3jmvxvwyrcqmihjohuq3o757mfph7x37kbwvtq@gtgyh4fca4fq>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 9 Jul 2024 07:58:42 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9Jk90HovH8bwzgCHwwh9j4mBm_Aaiq+EOj1HT3R17_Q@mail.gmail.com>
Message-ID: <CAL_Jsq+9Jk90HovH8bwzgCHwwh9j4mBm_Aaiq+EOj1HT3R17_Q@mail.gmail.com>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, 
	Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Sebastian Reichel <sre@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 3:21=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Thu, Jun 27, 2024 at 11:29:44AM +0300, Nikita Shubin wrote:
> > On Tue, 2024-06-18 at 19:20 +0300, Nikita Shubin wrote:
> > > Hello Andy!
> > > On Mon, 2024-06-17 at 12:58 +0200, Andy Shevchenko wrote:
> > > > On Mon, Jun 17, 2024 at 11:38=E2=80=AFAM Nikita Shubin via B4 Relay
> > > > <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
> > > > >
> > > > > The goal is to recieve ACKs for all patches in series to merge it
> > > > > via Arnd branch.
> > > >
> > > > 'receive'
> > > >
> > > > > Unfortunately, CLK subsystem suddenly went silent on clk portion
> > > > > of
> > > > > series V2 reroll,
> > > > > tried to ping them for about a month but no luck.
> > > > >
> > > > > Link:
> > > > > https://lore.kernel.org/r/20240408-ep93xx-clk-v2-1-adcd68c13753@m=
aquefel.me
> > > > >
> > > > > Some changes since last version (v9) - see "Changes in v10",
> > > > > mostly
> > > > > cosmetic.
> > > >
> > > > ...
> > > >
> > > > > Patches should be formated with '--histogram'
> > > >
> > > > 'formatted'
> > > >
> > > > ...
> > > >
> > > > > Changes in v10:
> > > > >
> > > > > Reordered SoB tags to make sure they appear before Rb and Acked
> > > > > tags.
> > > >
> > > > This is not required. The importance is only the order of SoBs
> > > > themselves. If they are interleaved with other tags, it's fine.
> > >
> > > Ah - ok. Just saw someone was complaining about b4 reordering them.
> > >
> > > >
> > > > ...
> > > >
> > > >
> > > > Hopefully to see this series being eventually applied soon.
> > > > Arnd? (Do we have all necessary subsystem maintainers' tags, btw?)
> > > >
> > > >
> > >
> > > As i see from my perspective only three left:
> > >
> > > Clk subsystem:
> > >
> > > - clk: ep93xx: add DT support for Cirrus EP93xx
> > >
> > > DMA subsystem (but the only request from Vinod, as far as i remember,
> > > was fixing commits titles):
> > >
> > > - dmaengine: cirrus: Convert to DT for Cirrus EP93xx
> > > - dmaengine: cirrus: remove platform code
> > >
> > > Beside that tags missing on platform code removal (which can be Acked
> > > by Arnd himself i believe) and dtsi/dts files (same ?).
> >
> > Vinod acked the above two patches:
> >
> > https://lore.kernel.org/all/ZnkIp8bOcZK3yVKP@matsya/
> > https://lore.kernel.org/all/ZnkImp8BtTdxl7O3@matsya/
> >
> > so only:
> >
> > - clk: ep93xx: add DT support for Cirrus EP93xx
> >
> > https://lore.kernel.org/all/20240617-ep93xx-v10-3-662e640ed811@maquefel=
.me/
> >
> > left.
> >
> > Hope Stephen will find some time for this one.
>
> As we're approaching the merge window and this is still unclear, I
> applied the pwm bits (i.e. patches 12, 13). If I understand correctly,
> patch 33 isn't suitable for application yet as it has a dependency on
> pinctrl changes in that series.

Now causing an error in linux-next:

Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.example.dts:18:18:
fatal error: dt-bindings/clock/cirrus,ep9301-syscon.h: No such file or
directory
   18 |         #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:442:
Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.example.dtb]
Error 1

