Return-Path: <dmaengine+bounces-1503-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AC88BED4
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF351C3CBF8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23926BFA8;
	Tue, 26 Mar 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PJFRJLsk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DvF0P3cz"
X-Original-To: dmaengine@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD56EAF6;
	Tue, 26 Mar 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447651; cv=none; b=bIUhYWSBSWyGgcqaBiP8vSCJC+Rwa0mryYroh5MLEfsdPrEzimjDU1UjKzfGk6UYAvHQ4QEBTIjD4xf8Zk9x+IBh42REGctJ+m86IlFb8YQWVZbLwyunjlKGFpVK7X/7z9+/9U52HtArloT3cV3F/FjbeyR929ix/TmNzicdvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447651; c=relaxed/simple;
	bh=MtysH8+9HAmIANTQD0du5b+w4USbcY1NMUiynk3OwAk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=eoAnWnQ6EJEZ3+Fb1c+KZQASXqT4SjtOJZeivjuJQNLZdfBV05WwslcZ+epizG9lUW/k2UbNZigrPkciAZyOjEQQ3cIfFCt3bEmbJC4EGsrR1RWW0uE4dHz+IIt+Kg5s5s0PomSmTJe079f3E4KY1iOIqWjMq415KP/9Dj2wxkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PJFRJLsk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DvF0P3cz; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 19AEF20063A;
	Tue, 26 Mar 2024 06:07:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 06:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711447649; x=1711454849; bh=LwutBSd20d
	Y9F2mV05mJEYeO4BD3EduCXGrjUsQ79Ro=; b=PJFRJLskOPk2rK+iB7VvkPPP1e
	SLERW5kzTADhItQdrbiFv7tHcH459/NpFcy9PVmm2d3OMZxaeh4ysJYYP5cZf3qj
	6kjIVklsQy+lvoygejE+/OdIqRnqn7vhNuUyKcCouDezDB2zrzbQAcrOcG5wRx1Q
	/hyrVAIthJ3IcKcUv70qLinqbc0/cuSq+lRcpEVPspAtrLBo049R/SlUmMrbdiGs
	TArsa7RG1X/FxCSiLg57bN6iu/mWAPJTP7y/4UxfORaC+BlRTRVj1SlffpoHl5qi
	pgcEbeW0r+BWpFJHnJbm98mW6OQYQt+6RUbF3F8dlyhbgvQAD4/6+EMJOgig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711447649; x=1711454849; bh=LwutBSd20dY9F2mV05mJEYeO4BD3
	EduCXGrjUsQ79Ro=; b=DvF0P3czs1dT3R3uZ4D9WNdJ2Jvy5Q/+5INgRPqZyxK+
	hkqBV3aCiIN+QgTQEUKV5qtqUGvod8DLhb4bQ4i/xDPexgDy/LVf/8n/SJG7rush
	XEBrOGiQWpazHs9g1aNsGBmL9W7WKcnYtFoJnaylqiK3kyAaruyJHAEbhDFJEixz
	5C4r3h9JlVJuv4pfz8arK6cd1bEtQT3q/wE5BJms9/xT6Cqp7CF1eewQzWbLj6CQ
	kT+x1WrKGo7OqATRWp5uF+DNlqL9lnGL1Sxa/z3LB3DLbhM/+QCE+v7JbE1GfhI2
	32FgJGmKdK/NrXqToufcvz/D0yB1o1nZjODsft/Oig==
X-ME-Sender: <xms:X54CZuxNGYqpCrTpdkoMeYu7QHep-DtABIoilrdxkHD3sWQYbCebew>
    <xme:X54CZqRRTk4BO6C0XUl_JYlUMa3bpBBaMeXDG4sLQi4OS4DrIkLZzvu8UfG_OQaS1
    B-Yn9ExIQl6NTvvdyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:X54CZgVzQidMIFZ5N9JpoYFGxrVx7337JziEMcVKsZMuJH165E0AZA>
    <xmx:X54CZkjjIA4yhyjXlr5VojHurih3Ujo9_CVAICaJW8Ost8Vl5nVLqA>
    <xmx:X54CZgA618J6_VWBxFs5t0RmjT9d4r6JLbi7Tkm1KxTbcEZMnccM0Q>
    <xmx:X54CZlJOpkzdS_UtGHyqZuzem8YjLstkDNB3SMS9OX5-aGoBVoQ36w>
    <xmx:YZ4CZvfWf4jPj0Z4AOpwXEiirjZXkASxh6SPn7mRGqleIMTKC6GJcUpzF9w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 717EEB6008D; Tue, 26 Mar 2024 06:07:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <66e1da99-5cf4-4506-b0bf-4bdf04959f41@app.fastmail.com>
In-Reply-To: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
Date: Tue, 26 Mar 2024 11:07:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Lukasz Majewski" <lukma@denx.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Thierry Reding" <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Mark Brown" <broonie@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Damien Le Moal" <dlemoal@kernel.org>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Ralf Baechle" <ralf@linux-mips.org>, "Aaron Wu" <Aaron.Wu@analog.com>,
 "Lee Jones" <lee@kernel.org>, "Olof Johansson" <olof@lixom.net>,
 "Niklas Cassel" <cassel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-spi@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 00/38] ep93xx device tree conversion
Content-Type: text/plain

On Tue, Mar 26, 2024, at 10:18, Nikita Shubin via B4 Relay wrote:
> The goal is to recieve ACKs for all patches in series to merge it via 
> Arnd branch.

Thank you for the continued updates, I really hope we can merge
it all for 6.10. I've looked through it again and I'm pretty much
ready to just merge it, though I admit that the process is not
working out that great, and it would probably have been quicker
to add DT support to drivers individually through the subsystem
trees.

> Stephen Boyd, Vinod Koul PLEASE! give some comments on following, couse 
> i hadn't one for a couple of iterations already:
>
> Following patches require attention from Stephen Boyd, as they were 
> converted to aux_dev as suggested:
>
> - ARM: ep93xx: add regmap aux_dev
> - clk: ep93xx: add DT support for Cirrus EP93xx
>
> Following patches require attention from Vinod Koul:
>
> - dma: cirrus: Convert to DT for Cirrus EP93xx
> - dma: cirrus: remove platform code

I suspect that Stephen and Vinod may be missing this, as reviewing
a 38 patch series tends to be a lot of work, and they may have
missed that they are on the critical path here. I certainly
tend to just ignore an entire thread when it looks like I'm not
immediately going to be reviewing it all and other people are
likely to have more comments first, so I'm not blaming them.

To better catch their attention, I would suggest you repost the
two smaller sets of patches as a separate series, with only the
relevant people on Cc. Please also include the respective
bindings when you send send these patches to Stephen and
Vinod.

      Arnd

