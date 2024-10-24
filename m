Return-Path: <dmaengine+bounces-3491-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB12F9AEE2F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD05B23CF3
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D01FE0E1;
	Thu, 24 Oct 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="A653jBtp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfphsDF2"
X-Original-To: dmaengine@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3B1FE0E4;
	Thu, 24 Oct 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791239; cv=none; b=S/K8q7noEjWYw0Rr9B+GyZOHHGL7+I/dWhmzkZ45yvv+75/f0ehmTWpK4ydFectH1fVzjBp14Dxz6Mcp2gNPBvNLLfBSO2HFyDM9NeBQQoJ/bICFfv7qWInD102P1gZYMQnj1e5JBkjpX/E+4fC9m9HCc1Ep4o44yKs+uQdyRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791239; c=relaxed/simple;
	bh=wdsXoO9P+4ECG9k3lEz3ZPdv+OvACR6i5MKXmbG89RU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qKiVEoLTprVrZukD5wmJBv3NmCzSKC/Rd1XplPeURqYTqhcLtTZauZuPeux2FtHQAR6xL0i4juKQfFreqDLNd7asZBK9QVmXE/FO5nILd3CBc2zkpE//mbkMOelJbwOCh0qCDyQkaLiseHoRSl/d/LXVfzXBQnahfB3+BZGi8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=A653jBtp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfphsDF2; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 68323200757;
	Thu, 24 Oct 2024 13:33:56 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Thu, 24 Oct 2024 13:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729791236;
	 x=1729798436; bh=wdsXoO9P+4ECG9k3lEz3ZPdv+OvACR6i5MKXmbG89RU=; b=
	A653jBtpYs4OYjapx+bzgWYnT6uOu/7nZTm0Mt8fK4PwW0YrR2Y99Ce4VIniJjXb
	nULP39sqpiOa1y9pYbz7Z9giVKFEJulzwNb8z+kpcTZt8hmlM7qtttkis4187DxN
	l8OAD0OhCWYRZBj3GpkGFBSAwh+LWwb0F1M8mHbNnq7sDpe9ZOPOQ4egagzGyrPH
	Rs5m+gD9WS9vU/brG6Abr0O6xgDsYqic9zfcsmzyD3/sNHaGQypsZyVpsLNfEVFX
	J4HQBFzghG+1AnJj6sgVTtcKUGC7sz/fMeGSo4FXkn40AlJYwHXX+u+ae9CstghG
	gW1stHjFeixKD98DCWTV3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729791236; x=
	1729798436; bh=wdsXoO9P+4ECG9k3lEz3ZPdv+OvACR6i5MKXmbG89RU=; b=m
	fphsDF2MwtjWRloIZIP3ohejJ7qBok4lndfX3KcFv58SdsrNfBiIhN3BV5ZD9JTT
	QE9JHFdyLBsM75oIGx03MnQ4LCFxwDb4yESYsbLK/o2djPIItBqm5wlkL+bCFRuE
	wBQ4yjXqXvNhZAjJgyCHoeGmMZh/XM0kTkICe3YFnPfENeEe2gKDKa/gcgNC8evW
	+HLGZV0LGDHKFDAstO/wjBBKB1WJGuomIMvEly8GZc8CW5fEN08mX3kHjXQQymcL
	yG7/BioaGFBEL9b4MRkN6QcCb3RcXTUtTFQv7utW6BZivHhAN7N8SnGLQGGcRE4R
	5kS33iYrfhMhiSfdymjUQ==
X-ME-Sender: <xms:_4QaZ8ZBCd9PBpW4mRLELE74lcpDhMBzx9KY9kLyHMNql4FUdPfBNQ>
    <xme:_4QaZ3YBh-YhPTO6MIpDNCRO8vg1UsZ3JirXbxlBRjXaEGhIiNTaHzh68ryRGsL5p
    CcyCEiNU7Ife8r081A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffekveettdeuveefhfekhfdu
    gfegteejffejudeuheeujefgleduveekuddtueehnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
    ehtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggv
    pdhrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprh
    gtphhtthhopehjvghffhgsrghisegrohhstgdrihhopdhrtghpthhtohepkhgvgiihsghi
    shgtuhhithesrghoshgtrdhiohdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugi
    drohhrghdruhhkpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthho
    pehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepug
    grvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrjhhhrghlrghnvgih
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_4QaZ2_78xaC45wErcVUnp3_D4c87ZxU8-oasJa6s1RMbbYtMz8ygQ>
    <xmx:_4QaZ2o0_0ptPdsgX0kr_PGecgY39eaUUWX3O3N6d6K5YDPFTcb_tg>
    <xmx:_4QaZ3pRvLGJJ0nBTP8ha_v38X4iuQF_Y7cR9NbPcTu_gCSEE8gBiw>
    <xmx:_4QaZ0TpwEeYRCi8ld1dDQqgBbhkTzzFVOy1VRq6Ob82egrkY5GZZw>
    <xmx:BIUaZ16n4_6Yh1lK-Nzrf1LSszdyaZYjd0RGlT4OktU7Q_my_e2m3Jup>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0DD41C20066; Thu, 24 Oct 2024 13:33:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 18:33:31 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Peter Cai" <peter@typeblog.net>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Serge Semin" <fancer.lancer@gmail.com>, "Jon Mason" <jdmason@kudzu.us>,
 "Dave Jiang" <dave.jiang@intel.com>, "Allen Hubbe" <allenbh@gmail.com>,
 ntb@lists.linux.dev, "Andy Shevchenko" <andy@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Kory Maincent" <kory.maincent@bootlin.com>,
 "Cai Huoqing" <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>, linux-spi@vger.kernel.org,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Russell King" <linux@armlinux.org.uk>,
 "Vladimir Oltean" <olteanv@gmail.com>,
 "Kelvin Cheung" <keguang.zhang@gmail.com>,
 "Yanteng Si" <siyanteng@loongson.cn>, netdev@vger.kernel.org,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Guenter Roeck" <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 "Borislav Petkov" <bp@alien8.de>, linux-edac@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org
Cc: "Andrew Halaney" <ajhalaney@gmail.com>, "Nikita Travkin" <nikita@trvn.ru>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Alexander Shiyan" <shc_work@mail.ru>, "Dmitry Kozlov" <xeb@mail.ru>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Evgeniy Dushistov" <dushistov@mail.ru>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
 "Nikita Shubin" <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Kexy Biscuit" <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <88bd4b6e-d744-4f50-a3ab-34433bbd0ad9@app.fastmail.com>
In-Reply-To: <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
Subject: Re: linux: Goodbye from a Linux community volunteer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8824=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=885:30=EF=BC=8CPeter Cai=E5=86=99=E9=81=93=EF=BC=9A
> Hi James,
>
> Thanks for your clarification. This sort of non-provocative=20
> clarifications of the regulations you need to comply to has always bee=
n=20
> what the community wants to see. _This_ should have been the first=20
> official statement when anyone raised the concern, instead of Greg's=20
> attempt to "defuse" the situation over private correspondence, or Linu=
s=20
> Torvald's outright defamation and accusing anyone who dares to disagre=
e=20
> of being a "Russian troll". This is not even to mention the _complete=20
> ignorance_ and arrogance shown by his statement on what sending a reve=
rt=20
> patch means.
>
> With sanctions in place, there is no reasonable person who will demand=20
> the LF or the Linux Kernel maintainers to do otherwise. However, as=20
> someone who does rely on Linux for daily work, and as someone who has=20
> contributed to the Linux project and its community, I think seeing the=20
> following should be the minimum:
>
> 1. Linus Torvalds (+Cc) send an apology letter to **everyone** who he=20
> accused of being a Russian troll;
> 2. Linus Torvalds need to **unconditionally retract** his personal=20
> attack on Kexy Biscuit, the person who sent the revert patch in protes=
t=20
> (+Cc), and acknowledge that people who work with AOSC.io aren't=20
> "state-sponsored paid actors";
> 3. This type of statement should be included somewhere public as soon =
as=20
> practically possible should sanction compliance affect kernel=20
> development again in the future;
> 4. No personal attacks should be allowed based on tinfoil-hat reasonin=
g.

I agree those actions and IMHO this should be addressed under Linux's
Code of Conduct enforcement [1] framework.

I also look forward to a formal investigation report on the entire event.
It may eventually result in an overhaul of our governance model.

[1]: https://docs.kernel.org/process/code-of-conduct.html

Thanks
>
> Thanks,
> Peter.
[...]
--=20
- Jiaxun

