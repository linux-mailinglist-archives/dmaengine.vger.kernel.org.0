Return-Path: <dmaengine+bounces-2667-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E892D1A9
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F311C22A5C
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jul 2024 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BEB1922ED;
	Wed, 10 Jul 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cOl7Zcvk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpLxRYuW"
X-Original-To: dmaengine@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9A128369;
	Wed, 10 Jul 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614729; cv=none; b=csrJvAVSUEZwOrRm+YLdXwbqvOhtdUAQMz6yiXysgDin4o5d/Tq2F5VJzcoH+bihh/UQA1tNwo/OQRFmQw69cdeSxLcDFr14MW4zcrACaB+4yR8Cm9W0e8G/EOChBcTNuld9WBl1IoBzdMAXo9LeNU9uhloVlYhG8esfyTpulV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614729; c=relaxed/simple;
	bh=XU81jlqPSEHhklnXvmeUHF4K+FfBTeR9jSQAbMBRniM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PSiJXSZwPFZ9lSdvn0SeQa1cXNthHMILVhMvD1Ov+jLoKTKPVaV/HY4gD3AYavWa67MoocDaVNR/COKbSXu6UlRxtJsN5XfJbVE2q6qk3WoEbUWxIhVbVVAFgCVPiN3r/GFKOdJe3hidYzN2Pf6jNI/mR42Jfj9IhtcO042jCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cOl7Zcvk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpLxRYuW; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id A4406200314;
	Wed, 10 Jul 2024 08:32:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 10 Jul 2024 08:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720614726; x=1720621926; bh=C2Se+H9RzY
	HkM+IvsyadLBKj3T9ynrUDq9Xcr2QdKUs=; b=cOl7Zcvkzf0wDdLrzY4XZ4nqyK
	Q0n/RJfmgELZTtTqod2qQXQqjWvo6hLyv8ZupwoPZleV74KB7CrYe8SjUf4ceunh
	CCahWbr44J1SkI4rlgeI03TRPOLSw5VTaOaCk8uarlYDXmbvY5gg6XFdGRnBLRmT
	VFLQKnpwzfM4POIfXCcKIBRg/+pkVOQlBJ0GH3BxqYageTKlELXoNlTt4mw+Q4Aj
	k2Im0F4pgLhehsHgB2bzs6UKs606OMlnCduj2/iYMXP59CpYQjVYC2vfu4cHRoAf
	cyc43gZGXwtKhum8Bm+sgJK4LC6XjiAJWyjbEM9FItPgj+N5bQP6BT/4uDQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720614726; x=1720621926; bh=C2Se+H9RzYHkM+IvsyadLBKj3T9y
	nrUDq9Xcr2QdKUs=; b=LpLxRYuWKtNXiN+vMol//S9HJvuDNvoMySy3IEcvEnBP
	u9nXxRywgLMUEzBCTM0mYX9ux3yyTeKxg3a3Qgn4q/3Io5xtp/Vv1mphh8pcf9E6
	vhNbLB9DALQvdlqA+SoPJLiJF9I1J2l9vi9JhSpyNJ/U2kN1jkcNAhlPjGeBJNuf
	dq24Q8irGyqaVcPnhFTsXs+y9AUvU7g3iwOe2EAup6fP+ru5f+A7TeI4ed07Fl+D
	8S+3VmfI4gOVzGcHNSOk1DfOPIUoqSrnh5pt7UgSz6xINcZRaJfz0qVD/8QFgZDt
	zBwpgYQWHBL/Ev+vGiiYevpXhAYme5o7Y0QxcBEGaw==
X-ME-Sender: <xms:Q3-OZurnKRkHBlEZMjc2PijwVnii3Ft7oAVSuLA0qFmezC5Y5EJm9Q>
    <xme:Q3-OZsoW4lzanijF6DQpYWPbUfD-CFYt0QhuAlF3F1xQAlxGDVndb8vyQkcKdK_mG
    3wR-2RmoSV2vmVg9Xc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedugdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Q3-OZjOIVdJEtnz-150-q7qjX0LUXM6RkvkquzoxolFuI1CETJjJiw>
    <xmx:Q3-OZt47sHQWBMp4Sm_h9D_Itaa2UR7xRR6oz4VfTFgZl4xOrpRMow>
    <xmx:Q3-OZt61vvUylUkBQV7eSWZtpYz_EP3x6iU3PqX4vtnbW2NiXElrdg>
    <xmx:Q3-OZth_J6crv8zLOcicEfQqH5MMDIkvJ1IgWC5x8R0svP4D8xWqkw>
    <xmx:Rn-OZgIBVQ1boHKoWWrW7KFkxPc4r84muU_5CzmiqF-M7CrvG824ufJd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 09148B6008D; Wed, 10 Jul 2024 08:32:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f45a3d9-429c-441e-a17c-33a163eb86c2@app.fastmail.com>
In-Reply-To: <663b1749afeb5cec281149fdb445ed36fdcbc68e.camel@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
 <CAHp75VfSC9gAD9ipeWRPdQOxUp4FXqYYei-cJTs38nbz0cHpkg@mail.gmail.com>
 <48c242838c77034485a9e667dc0e867207c5beed.camel@maquefel.me>
 <241a4cf9830b0118f01e8fcf2853c62527636049.camel@maquefel.me>
 <jyvlqfvqn5bp3jmvxvwyrcqmihjohuq3o757mfph7x37kbwvtq@gtgyh4fca4fq>
 <663b1749afeb5cec281149fdb445ed36fdcbc68e.camel@maquefel.me>
Date: Wed, 10 Jul 2024 14:31:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Lukasz Majewski" <lukma@denx.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Sebastian Reichel" <sre@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Thierry Reding" <thierry.reding@gmail.com>,
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
 "Niklas Cassel" <cassel@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
 "Andrew Lunn" <andrew@lunn.ch>, "Vinod Koul" <vkoul@kernel.org>
Subject: Re: [PATCH v10 00/38] ep93xx device tree conversion
Content-Type: text/plain

On Mon, Jul 8, 2024, at 09:34, Nikita Shubin wrote:
> Arnd, 
>
> Are we continuing this patch series ?
>
> You are silent since last version submit, which makes me a bit worried.
>
> If you suddenly changed your mind please let us know, cause anyway we
> have no possibility to merge these series without you.

Hi Nikita,

I definitely still want to merge your work, I was just not paying
attention while there were others commenting on it, and I don't
know what the current state is. If you are ready to have some
or all of the patches included in the next merge window, can
you send either the set of patches that were reviewed to
soc@kernel.org for me to pick up, or prepare a pull request
to that address?

       Arnd

