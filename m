Return-Path: <dmaengine+bounces-80-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859417E8C0F
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 19:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869D7B20AAC
	for <lists+dmaengine@lfdr.de>; Sat, 11 Nov 2023 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2951C291;
	Sat, 11 Nov 2023 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldh8Gy7H"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E041C281;
	Sat, 11 Nov 2023 18:18:36 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75032D77;
	Sat, 11 Nov 2023 10:18:33 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a0907896so4148744e87.2;
        Sat, 11 Nov 2023 10:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699726712; x=1700331512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Os4KBIFKBrhxCNe2iV6sYOSUCifSAC9wTubOo6x2YGA=;
        b=ldh8Gy7H+fB07WnLwLs4whDNnMWJ9t73ETCn0BOh3NQjk1P1KoAlxgUQzAeWW8GcEn
         jzLSifyLLc751Uhmr6jpH6gTwvteDNMBluLUa3smHHCpHWKKDWUN4dw3Q8Dn3lJzrVtn
         xEw0kEw4h4uaZge4XWlBny6oXs5UkBAyI0NcnaLEEDIU37btmMlQnuiTj9RID6/QzKY6
         FZaIhrW49f6tl7kkn+onwyBlDyVwEeuEvAi6yBSPDyy237djg6kfIAWH8TPD4WgoasJj
         CHY9BOytR4oy1nGYgsmRCW/GSxsy158ud7ywWmUzL6pxcwW84MUFaekqH3WgVGMuX8C6
         K+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699726712; x=1700331512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Os4KBIFKBrhxCNe2iV6sYOSUCifSAC9wTubOo6x2YGA=;
        b=rDwZOUddggUx0kGP8x3bgps8bw0XOL69m5Xdbnci9ss2kVsz6ANLdI5s3Y+KSbIpPU
         /HpwQGGBlLio72Nn5u/WDECuImnOIB6YKWuMhabbUITXyMJG13KLar2QK+3G7o/CgRUT
         QDenmyAWgDClNK0uASFgveKvnoL+GkLAgxHM1HjN745fXoG7i1VpTcLxfWAXtz+MK5+g
         ef3JDJx6RGIx2T7iikvmKKj/zWh6yB16+TgS550TnACKWhOabFmOWS3D91CzJIADLAd1
         kh59cCpsAAbCPeGCCb/I5Z7RaoBaGJ24W7RUikiBPsP4T8tMzfEVYy5RAZa3QV+JpJzD
         YzxQ==
X-Gm-Message-State: AOJu0YyoYna2ZbQlghrWUrG/L99ZoFMxRCgiVHqKkmxFbL32PCkBRsKB
	DLkDLgT5gynjqGHCQXhjo4Q=
X-Google-Smtp-Source: AGHT+IGWSLvEEWKMjKSkylq9sGZ0KV/8c86kVFIgYc1m0RkjmWY37s2qpjH05vtA3bG5UrjESvvwcA==
X-Received: by 2002:a05:6512:2399:b0:500:be57:ce53 with SMTP id c25-20020a056512239900b00500be57ce53mr2275395lfv.42.1699726711568;
        Sat, 11 Nov 2023 10:18:31 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906b31400b009e656ce2930sm1403421ejz.60.2023.11.11.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 10:18:30 -0800 (PST)
Message-ID: <80ed91bb971516638fa1793d648939815eba7630.camel@gmail.com>
Subject: Re: [PATCH v3 14/42] power: reset: Add a driver for the ep93xx reset
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Andy Shevchenko <andy@kernel.org>, nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Lennert Buytenhek
 <kernel@wantstofly.org>, Russell King <linux@armlinux.org.uk>, Lukasz
 Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>,  Thomas Gleixner <tglx@linutronix.de>,
 Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
  Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mark
 Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,  Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Michael Peters
 <mpeters@embeddedts.com>, Kris Bahnsen <kris@embeddedts.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org,  dmaengine@vger.kernel.org,
 linux-mtd@lists.infradead.org,  linux-ide@vger.kernel.org,
 linux-input@vger.kernel.org,  alsa-devel@alsa-project.org
Date: Sat, 11 Nov 2023 19:18:28 +0100
In-Reply-To: <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
	 <20230605-ep93xx-v3-14-3d63a5f1103e@maquefel.me>
	 <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andy,

On Fri, 2023-07-21 at 19:37 +0300, Andy Shevchenko wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Issue the reboot */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep93xx_devcfg_set_clear(priv=
->map, EP93XX_SYSCON_DEVCFG_SWRST, 0x00);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep93xx_devcfg_set_clear(priv=
->map, 0x00, EP93XX_SYSCON_DEVCFG_SWRST);
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mdelay(1000);
>=20
> Atomic?! Such a huge delay must be explained, esp. why it's atomic.

atomic or not, SoC is supposed to reset itself here.
However there is an errata [1] and the SoC can lockup instead.
So even pr_emerg() makes sense to me.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_emerg("Unable to restart =
system\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NOTIFY_DONE;

[1] http://web.archive.org/web/20161130230727/http://www.cirrus.com/en/pubs=
/appNote/AN258REV2.pdf

--=20
Alexander Sverdlin.


