Return-Path: <dmaengine+bounces-3141-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41157975818
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0413A28781D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676811AD9CB;
	Wed, 11 Sep 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiSrTmDv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975651AE038;
	Wed, 11 Sep 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071577; cv=none; b=DwareqghLs8ZCLBL2HVXbZlsNyZFD9XcutXMn3RYCUMm8wYzPmqUIVf74btP1agTmlbpAMkiVTUsjjtPtiX9TTxjSIrOOFW1fDdKeRh83eFv/mwenPlXImlfe9aCHvGS0U8oTUK6bUdNpLvw61DgswGQ4eK6v4L6rN5cI1tmdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071577; c=relaxed/simple;
	bh=lwlZJUmP9LcD4uQACLs3u1hgzJYRAuuAtfArazJJYQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UyerrgMSeXDAK+fCv4JTOcQ5E02VdQxUt8nHDJe9qEMLMguonm8uYfzOjsgRWAo2e4YWccMiTwF79Ukwl6kiQCII0qfq7FeYd0i2Czwr99ut+u+11CaKsYOhg+TPgKF1t6LJ6gp4qnif2OnYOAdWnQmOihIEowdre0Y/xMVCQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiSrTmDv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so2546354e87.2;
        Wed, 11 Sep 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726071573; x=1726676373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwlZJUmP9LcD4uQACLs3u1hgzJYRAuuAtfArazJJYQ8=;
        b=iiSrTmDv8zWDM8Ce73mbj+NyaBn86kLAblS5UiNGEoVmNOhBIONY27IztzWeZMxbqr
         Ithukyn0UJu4g/kuETqapeg5ZRLo5Ppc+m070OAqOwarsuvcjCMGgKtmFJgwE9B//Ky7
         iDGp2vTSo+Lcv9NMcitPDyWaW/1vene1DIBSUKeC4srHZhJZHTk/Mebabxi1I75/1qkD
         MhYJ/TufTFnHhHLC2jPseOj+jp0PtzEzp8RbTU82K/TJgSOWQLmyNwGvYMLsRJcHxtQL
         HdJJvOMknQdRTKb4Gt/CBZID3YAPB3Ryv8hru0Y7EvfRgPhr89cmUSZZb0kAiA7HLWb8
         Co+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726071573; x=1726676373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwlZJUmP9LcD4uQACLs3u1hgzJYRAuuAtfArazJJYQ8=;
        b=MCAjyhocAiHCTRtMSPk6GQg+qBG5D83yp6QQesc1GY5F87KPhBlAe4mp+ybmBx5jgv
         qRkIY7JExLPmwkoH1BGBfedL36Xbvs2NXOjGc2BDeZau+4GiscTn9UOOYaCS54ZWX2iL
         mTeneXAII6p5TuB9wEfo+yVweQWZeK4Ur4XDmlvIq2F4HBw12T1vnnhwJv0Az02XY+xT
         y02Bl3jBVLFooSyXGHL0HZxvAEu/zQu++/2i1QLp1TraF5i1TXlu+HolymNENaW18xd6
         XPTR0F+xguSqjaJB4MxHmLWGCQI4tUtF8KQHzycy4h/1Sl9WfbeqjcSFh1sm9dkrqbHp
         6LJA==
X-Forwarded-Encrypted: i=1; AJvYcCU8rkarfVLONkvil1WbvogxEGRPyeEywOdMoVFRF+riawz2LDh2KJX9hSc7OYpW+1EsF52uRGCtVrINRg==@vger.kernel.org, AJvYcCUxwGUFCLklMaxZreI47KDFTf2UTUA5uO4z16LCGlwZGmOydA9loUzwEn71JSUl4hdIzcrBy8I8mF5P53yl@vger.kernel.org, AJvYcCVKGify8M11hK1Ly6U6pnlAXzdx+6BY3W5qQnfRAzJbS911bvVF0YKknu+VJy1R3yU+zCj+ACRZhYDp@vger.kernel.org, AJvYcCVTq/+DINN7eoathAlwqUssl0RGIyHbCNoqTHkV649iCzq1DJq3hxezE1lsukSIflBXZHG2Xm+LxkwZ@vger.kernel.org, AJvYcCViGBGRIwRDtO53gtbBPLf9pnx4oMvOBMsyHSQP1lTLH9EDBlsmwwrDDgNCpbvvKRBEn821IkF/W7BL@vger.kernel.org, AJvYcCVoFGDFijezUCqEDKiYBOkzxr5LY8zg849EO3R1STLNb9WkcfcK23fJ8fm7UhRFvrImKdh0wG7iU44=@vger.kernel.org, AJvYcCW03NDG0TsX6ZLihBupK4TmIrIlPCufHgOxa8bFRTMSrdG1lvRZdSol991EPKDILAfcG1GBTcyqUBvvIsA=@vger.kernel.org, AJvYcCW8ZRFtXIp/aUawUB5qJL78+uCIL2rm742yO4lbso/GsgXS1vZ1bpKfTORD//EZR6hyBRu1SiNrFMC9@vger.kernel.org, AJvYcCWcVDfTCzZ3ELzePXhUVICP9RshYHigXXoICuWPV9Qgy1ghGEoo/1vefe32SVhpoIpTPO5kDkebXEDBbgjWEp8=@vger.kernel.org, AJvYcCX48OZS5U9iF9erUTOdWN2H/MeI
 YafbohTjAEdGwXQ7+2Esg5rjH+yqEy3rl2vVk6nge9IxMLtn@vger.kernel.org, AJvYcCXP551LEphZJwnn28J1Kvr3iaWsS45S9PifNrjd9mFrVBBUGqrHj28i8zXPFOJR6vHtdyEABRIsjHXW2Gs=@vger.kernel.org, AJvYcCXWCc9ImALnuuLTdRm0AxwBJu8S7DCnZJts2b+yLg/v7fD8AaACxAPelx1/skYadEcO93FIAK0dr7Dc@vger.kernel.org, AJvYcCXkrhJNRUyiNCOgpJ4m63v5C32O2ge3tlu76+dpHbI1R+7Ck1om8ODUzRunM9PJIhU+7Qs7zwfIhVs7@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbdQw4f1RmKmDCsAdAeymkqq568iWSS/3rmoQaTU7el3Eugw5
	5teNXOJSy1rqkEoa7yjoI5zhbpyEM06h2y05z4rkWmjjC5yS5YNPibbxGH31IV0SNHiA/COi85u
	bD+I9osT1UPW5wEdWtfNbdXePy4U=
X-Google-Smtp-Source: AGHT+IEfiqu9Tkr72UxQfCKwEwXNERhL9+EEF5iQAUfNY4YtEQqPnVlXr1xTzedLm0smIgh8R+iSdzkbG8ZOJ96JeDI=
X-Received: by 2002:a05:6512:10d6:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-53673c96a84mr2008337e87.40.1726071572960; Wed, 11 Sep 2024
 09:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <CAHp75Veusv=f6Xf9-gL3ctoO5Njn7wiWMw-aMN45KbZ=YB=mQw@mail.gmail.com>
 <0e3902c9a42b05b0227e767b227624c6fe8fd2bb.camel@maquefel.me> <cff6b9b6-6ede-435a-9271-829fde82550d@app.fastmail.com>
In-Reply-To: <cff6b9b6-6ede-435a-9271-829fde82550d@app.fastmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Sep 2024 19:18:56 +0300
Message-ID: <CAHp75Vc2Dbj0GAua4b85L8jgcGzdBfMdRgnuTSWNiGj0zKHU7A@mail.gmail.com>
Subject: Re: [PATCH v12 00/38] ep93xx device tree conversion
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, 
	Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Lukasz Majewski <lukma@denx.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Mark Brown <broonie@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Ralf Baechle <ralf@linux-mips.org>, Aaron Wu <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, 
	Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, linux-mtd@lists.infradead.org, 
	linux-ide@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Sep 9, 2024, at 09:02, Nikita Shubin wrote:
> > On Mon, 2024-09-09 at 11:49 +0300, Andy Shevchenko wrote:
> >> On Mon, Sep 9, 2024 at 11:12=E2=80=AFAM Nikita Shubin via B4 Relay
> >> <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
> >> >
> >> > The goal is to recieve ACKs for all patches in series to merge it
> >> > via Arnd branch.
> >> >
> >> > It was decided from the very beginning of these series, mostly
> >> > because
> >> > it's a full conversion of platform code to DT and it seemed not
> >> > convenient to maintain compatibility with both platform and DT.
> >> >
> >> > Following patches require attention from Stephen Boyd or clk
> >> > subsystem:
> >>
> >> Does it mean you still have a few patches without tags?
> >> What are their respective numbers?
> >
> > The clk is the last one as i think, all others can be ACKed by
> > Alexander or by Arnd himself.
>
> I've merged the series into the for-next branch of the arm-soc
> tree now. The timing isn't great as I was still waiting for
> that final Ack, but it seem better to have it done than to keep
> respinning the series.
>
> I won't send it with the initial pull requests this week
> but hope to send this one once I get beck from LPC, provided
> there are no surprises that require a rebase.

Thank you!

This, in particular, will move forward to the GPIO descriptor and
getting rid of old legacy GPIO APIs.

--=20
With Best Regards,
Andy Shevchenko

