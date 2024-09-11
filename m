Return-Path: <dmaengine+bounces-3140-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B84975690
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 17:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2AA2830B7
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E21AB6FD;
	Wed, 11 Sep 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d1FqCsPh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJHEzuoO"
X-Original-To: dmaengine@vger.kernel.org
Received: from flow8-smtp.messagingengine.com (flow8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F351AB6D5;
	Wed, 11 Sep 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067596; cv=none; b=WiSLKqojL9wkNR6+Fh6ppdoJGNGEylBK7vQ31a1wqQKS/Crop9GVDd5frNaccRuYUK6wj+yi9yvEhT2nFiIcDpareutSUqxz0tz682n0zKK8ypo6KtbiGX+3kiMoGk1/DrJm324uted11czFNaKIE/+Mu1I+0liKDXI1q6jn7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067596; c=relaxed/simple;
	bh=WYSo2PbdmOt952RgPLexG7kR5bugRClHNNEt8x7IqTE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OtrXEEp+2Wgye82IQUxHrqg/SE6tQ/vU7SB3WvBPqTquPcV+VbfLiV82rOy5esuj5LEf1Po/OLsbSsZ08Mf2XT2W6qsT+pZA4dykrPKPiVK0x1STzKBG0WMx+pHxb+O7euRhUENBTyFDfSyxkEkrzLb/UxmufhA5WoNWO/pfqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d1FqCsPh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJHEzuoO; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 7C9EA2001A5;
	Wed, 11 Sep 2024 11:13:13 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 11 Sep 2024 11:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726067593;
	 x=1726074793; bh=W3/bFLF5GPmG/oJuoeXrc+CcLB5pp1RgCukpWqx8NY4=; b=
	d1FqCsPhahhr2Dwr0XhrBSK7PBKhdl7kI1nAgf00eCbyFC3vScqgPILeiWLRy9hy
	a4lO0s3Scill0gwpM/UBvLTdJMscXqSM2VFAsYG1+NoCJKaY9wISL6D34pDBkkLQ
	t9r/A/L85Q/EsPnej4osD2co4XsYgrUYP+Rkha0LGyvvRv5L5Siv/SzxkF0RGUjj
	tTslxZAr3dO0T05TmrYsAxurjvThNSfHsg/5VlmWemjcFPSKn6rh32tR0LPcX1Ry
	Jm215fJWfFOvjQbaXBM/rfNP0IqwTiS6iKK9glQn55ItjILGpjpr1d4+5JBu+8pr
	Xbpo3pGRUXteq9y9osONcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726067593; x=
	1726074793; bh=W3/bFLF5GPmG/oJuoeXrc+CcLB5pp1RgCukpWqx8NY4=; b=W
	JHEzuoO4E7PRxiBieiNSNuPJb4Yr2Tuy4vWbEXgdu4gj5HKRFgXN6/EUdTycU5CF
	LT5ga6nz4aVl6f8wSmNowcpZikl5UwHsKgnOITVHnEOZBo9Y1IJcp+dDVIniLPjz
	e1viD/oIGj3nwee812PuibrlGfCu5DeEBTZOp3yo3NjJQeTQWKL2xkpyhsES0BjK
	AEZtCZPryrR9qTzhFoRv14kxWofl0C/yr5K/RMRVg7kbZslIowPSShqlctUDzE+f
	hH29FlukC/fnufte5CTQ+hrLebOEikXOBU95oyfXOnorHMQzy2Up3zSoVLXz2DBd
	p9Bhz9jQqwRNibXrZlPKw==
X-ME-Sender: <xms:hrPhZnfTX_VylO-PNCzmdjPTic9z8BGVcJxI88meJ27e9r2pOSFL5Q>
    <xme:hrPhZtMPdP0AD192qTqmmh8z6yEcM-y6QqpnpZixQ5Mxf_3q1NXlYfZrhn8s3ywTt
    jIcY4d7mCJjNb6xF9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrghrohhnrdifuhesrghnrghloh
    hgrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdp
    rhgtphhtthhopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpth
    htohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihn
    rghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohep
    rghlvgigrghnuggvrhdrshhvvghrughlihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnugihrdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:hrPhZginhrjXLqpwTCFTnXWpiAEfHo6FpQYq-qC18dJws16a01kLeg>
    <xmx:hrPhZo-6qbuPN1Aw9mzuLb4wUz9doIfVj9TzCNgYoAyNBZYVif6F-Q>
    <xmx:hrPhZjut-J77GVyanCLtqtITaVUJE3vOfi2whVrSShNt_nC9ni0KDA>
    <xmx:hrPhZnFgz3iQgcxly9ZYIMYBR37m-rLjANIkLGUC3G67NEHKp35kDw>
    <xmx:ibPhZu-Qtm3ps0O94A68wPefYRL6CBcJRGkpn-4RQLmjUBM57R5KGzrl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C2F2D222006F; Wed, 11 Sep 2024 11:13:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 15:12:49 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc: "Hartley Sweeten" <hsweeten@visionengravers.com>,
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
 "Andrew Lunn" <andrew@lunn.ch>
Message-Id: <cff6b9b6-6ede-435a-9271-829fde82550d@app.fastmail.com>
In-Reply-To: <0e3902c9a42b05b0227e767b227624c6fe8fd2bb.camel@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <CAHp75Veusv=f6Xf9-gL3ctoO5Njn7wiWMw-aMN45KbZ=YB=mQw@mail.gmail.com>
 <0e3902c9a42b05b0227e767b227624c6fe8fd2bb.camel@maquefel.me>
Subject: Re: [PATCH v12 00/38] ep93xx device tree conversion
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024, at 09:02, Nikita Shubin wrote:
> On Mon, 2024-09-09 at 11:49 +0300, Andy Shevchenko wrote:
>> On Mon, Sep 9, 2024 at 11:12=E2=80=AFAM Nikita Shubin via B4 Relay
>> <devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>> >=20
>> > The goal is to recieve ACKs for all patches in series to merge it
>> > via Arnd branch.
>> >=20
>> > It was decided from the very beginning of these series, mostly
>> > because
>> > it's a full conversion of platform code to DT and it seemed not
>> > convenient to maintain compatibility with both platform and DT.
>> >=20
>> > Following patches require attention from Stephen Boyd or clk
>> > subsystem:
>>=20
>> Does it mean you still have a few patches without tags?
>> What are their respective numbers?
>
> The clk is the last one as i think, all others can be ACKed by
> Alexander or by Arnd himself.

I've merged the series into the for-next branch of the arm-soc
tree now. The timing isn't great as I was still waiting for
that final Ack, but it seem better to have it done than to keep
respinning the series.

I won't send it with the initial pull requests this week
but hope to send this one once I get beck from LPC, provided
there are no surprises that require a rebase.

     Arnd

