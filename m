Return-Path: <dmaengine+bounces-3205-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B297E8A9
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA3B2810AF
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB54B195F04;
	Mon, 23 Sep 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBAqoSIx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B8194A73
	for <dmaengine@vger.kernel.org>; Mon, 23 Sep 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083690; cv=none; b=eANtN/QjwDzwG80mtJNoztyfys6tjqXenCE7CyjRTI5Ooff96iD+968WTIl66PShthgfMxtGJXcKpTbifZ3XYmBGTzX+G8rNPyHowUim9RAq4NphXChYJIMfLXwySkOVvT59KK2yYcWTft4HBuV8mFW2uGGrpNipL3/Jawjvxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083690; c=relaxed/simple;
	bh=Y2H3lLogo29T09ZIg4O5267APGx1T56CgiRzH2uFGiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqPfbnRyXg8RKRVq2yJx+RjLIGbwjsFsiE7cySTCrvQUt/1/NnOur27b/ftH5RQxoD+9v9Fm6R0g+B/ZhBTRv3qAiXs+bLSbnb7ykW/o7LkoLw5/vmAtIQCjsocjpxEK5IKq70TEwbZsZ4WCO5i38U/VsMgaAdau29Oy60T40Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RBAqoSIx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365a9574b6so5571565e87.1
        for <dmaengine@vger.kernel.org>; Mon, 23 Sep 2024 02:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727083686; x=1727688486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2H3lLogo29T09ZIg4O5267APGx1T56CgiRzH2uFGiY=;
        b=RBAqoSIx+RVn8QLjrhgFcTEvyiTWLGut/hdny5rdecWBShI5CYoOtYoyb+Mu/QLt58
         zKkdIKr2KQrBZXg1+yxkSQ9h42jobYliJrNsBifx6q/H8TeCNLQqWOcOmUL8u2qSKIsN
         8sywRZq/Rkvf+gb3AxVYacBLhjcqeexz5IFs6L1aEU0cwr9fj4k7LmmeBUUnOgxRrp4h
         vh0VTUAbPalneuV1+T8yHKardhv/jzSsKGdJQ9DCn42SPiPZtf1w19oy5JUql3ktBGMp
         P+XBkaQUVmIeWOkiEqcPiLnZdiIHLEQe62A8uau7Pu5z6kEtdn3k0JAJhdLhS2hZHxDf
         8YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083686; x=1727688486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2H3lLogo29T09ZIg4O5267APGx1T56CgiRzH2uFGiY=;
        b=Z3Ro+AvrguYI+GTncByRVnR17KFBdzTJ51MmdVFg+jiCJXyRuIYOtuJbDyLVNV3JzJ
         CDyPz30xj1NfdMGXf0rQwYP+4AYU50l2C9pmTjNOt0A6R+sett7ogtXKM7FFWOKBdGM9
         LXYYa38VBas8DuuKIm7uMXzl1y/IOvDcoIOLyemdB3rcUUnA5VCEehNWB/MkxoQJAG/H
         FvKDGN2RFz4pQD0lLQHCK4pjMhJWozFKyED1JDYwbuve7Dr58U021FKSJHiqZ/tt35lG
         C0D+IcHAVR2ctSRhqYdLqNWwVhhvflDzp0W3I/43PpOYz8bC8kTIVgXj6uL53lk8hPX/
         VZTA==
X-Forwarded-Encrypted: i=1; AJvYcCVmqwu9JUi9o8ticEcOlGFk9uJcp4m5/cDYaIjqNg/VBasJyCgxmXJGulH7JU63GhdIoYbb58NzYjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCpaPwOJZJWmvWiiNLTksSSB3NjDvL1Hk8sqIN+h5nFOJ326+
	9/ebaSrvIr4Kr/b5fBKPo4X7ekAjGk7pkZQ+OCXCD8AEaw3jzUki42YBeQ4M3WgizXu9Gl2R0eR
	Dcovi26SSyRsdS9NS76A/NwfMcqHbflqWL7oJLw==
X-Google-Smtp-Source: AGHT+IFqcb5VcpmKktw95t64Q/tONZlUY5uMG8agXKVRR1VFK+H/O2baR3jHivWHjY41tZ/ZQZoJrQNpCocxjyIuWM4=
X-Received: by 2002:ac2:4c4d:0:b0:533:45c9:67fe with SMTP id
 2adb3069b0e04-536ac32ef59mr6887747e87.48.1727083685755; Mon, 23 Sep 2024
 02:28:05 -0700 (PDT)
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
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2024 11:27:54 +0200
Message-ID: <CACRpkda7Kef-buHQ3ou3q_xq+OD9-cONh1Ynu-KjvQf=Qx5S_Q@mail.gmail.com>
Subject: Re: [PATCH v12 00/38] ep93xx device tree conversion
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Lukasz Majewski <lukma@denx.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
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

On Wed, Sep 11, 2024 at 5:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> I've merged the series into the for-next branch of the arm-soc
> tree now. The timing isn't great as I was still waiting for
> that final Ack, but it seem better to have it done than to keep
> respinning the series.
>
> I won't send it with the initial pull requests this week
> but hope to send this one once I get beck from LPC, provided
> there are no surprises that require a rebase.

Thanks for picking it up! This is a long awaited patch set.

Yours,
Linus Walleij

