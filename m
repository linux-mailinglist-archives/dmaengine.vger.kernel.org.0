Return-Path: <dmaengine+bounces-3485-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894619AECF3
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAA71C2301B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637C1FAF01;
	Thu, 24 Oct 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ep0XILZo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OV3ypg6c"
X-Original-To: dmaengine@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645B1F9EA5;
	Thu, 24 Oct 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789153; cv=none; b=J25bFNWYbBNVMUlHKY4OtxP2Jn2jA5M85Yt4V7g3P0mznNv3NToHmBcb7eFVdq0HEsESHEpbrfnBz6TxaAEUUaSZBAOOLk4lPi3Uv8vwJt0OYZ0me9rxdFu/LM5ndxdOMUDQ1jzW5y/Do6RU0ay0gq9wQX66+Z3JFUAzUNlb4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789153; c=relaxed/simple;
	bh=1D9MXsAVWcNpk072yB1qs3fINFV1pE9hhttXGeJgq0w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QP0vYDLhj6BEGbisd2Nm/C3EdyuCfOUGp5dpO0/ZCMdl/aPZWSBRFzXcpuzhShbYxsTfuQVzGgH1rvN+dx8VX1Us29vXnLQ34Lo+FoU3zBr53aNjZHJ9IetbfeW/vLLjISnPTUEgEZSXVhtirWvwIjFfIHIqZAdykBGAvLcNno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=ep0XILZo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OV3ypg6c; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id A59A6200789;
	Thu, 24 Oct 2024 12:59:09 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Thu, 24 Oct 2024 12:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729789149;
	 x=1729796349; bh=SG3wwx+g/r6vJORvVjNOrsa8CYeWjsvioBIcUqvZ0Gc=; b=
	ep0XILZoJhOwPW3tle1lxD1HjrJWpITYzUsHm2zOfmXFqwaUnNZ3h7/jpDzjv8yN
	VG6WWFbIxZ7arovOdONHpLLJkma36z1NnhWQu977IF9HO9KZ68MLf0nCQ2ydlVr5
	ji7PRP2eBFvEUNXHyEX8oVg7BtgcFFKX4yTwjr+KpZzFUfpH/bxTWjWD6z7yvMkA
	UEKRziWV3Q1jLfXSuob7zWc889wUnIICAPeYUzt3ky5APj1OmXIW4G944P/RmEh2
	AhzvftYpTuebLKX1fP9ppQUdFW++SpHC6ff1VDS4iuL/mc+Wmk0OHilBpK7hYEhV
	CHs06OO4opBCp1rG43CJbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729789149; x=
	1729796349; bh=SG3wwx+g/r6vJORvVjNOrsa8CYeWjsvioBIcUqvZ0Gc=; b=O
	V3ypg6cRR80FVCGt3iJbt1d8uUDSVnNfTbcrxh1AvdSoxoKlJqOqwr5zZw5GveJ5
	uy8wn4YSYmLpvIMwJJ7kORHOdpEgJyPTte15PTQgyo91IglxWguDmN4gP3pLAe9m
	wk9hTmuaeaYaXVX5DGCxfRWh+N4YR93oAILAmss1lBaUNPUqkBhud4wsLyBZ17P+
	F0sS/KhUZeod6ydZ5XzTH8C3s1qt2uOLAJEBTq4Fys8P10Wff+h4wl9wwEjEpxNy
	L6w+cNxOXhipxm5Yw6vap72AO8PSLVScLYT8iFGGYKjduZ84lbkW32PnR9OzXFM4
	RU5lClV8FhEgD5s1FikSw==
X-ME-Sender: <xms:2nwaZ5_7YU3V2G5aXQIMJVibPQYjTxulAl0jIA6FWJqHw114OgtLYQ>
    <xme:2nwaZ9sYUxuDQt3s9pQYPXNd0F94BVrwTp-9yhCst1RmWQPQA0XkyT88CUOAbr-S5
    5bC46g4k_XA2AFDzbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehtshgsohhgvghnugesrghl
    phhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuh
    igrdhorhhgrdhukhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthht
    ohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhope
    gurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghjhhgrlhgrnhgv
    hiesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhlvghnsghhsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepfhgrnhgtvghrrdhlrghntggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2nwaZ3Cv-hVEkx1Pr8q_BWJjkhrzEk9-mHQ7C2q7gA7CMMZL0qI7NQ>
    <xmx:2nwaZ9e-frUJhk9ka0CLyX-noOJeTWSuiiRFa1wF7QTiIj17LraGBQ>
    <xmx:2nwaZ-Mv5MLAM_50zIR4-F1_WcNhjiWHJmtj6uYMSwmAZ1_sbnspbw>
    <xmx:2nwaZ_nxWH5oAqdmZQ0izKk8A9nliyXxQCCDRPN1Ld86KUJwXs1sRg>
    <xmx:3XwaZxfkKD_qGLFKaVmN5Q4HWgdetZn2bkIYd8lQizBi7lvGEMzBD8_x>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 37E8F1C20066; Thu, 24 Oct 2024 12:59:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 17:58:45 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <2f203b14-be13-4eef-bcb1-743dd9e9e9bd@app.fastmail.com>
In-Reply-To: 
 <f90bba20e86dac698472d686be7ec565736adca0.camel@HansenPartnership.com>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
 <f90bba20e86dac698472d686be7ec565736adca0.camel@HansenPartnership.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8824=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=885:27=EF=BC=8CJames Bottomley=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 2024-10-24 at 16:59 +0100, Jiaxun Yang wrote:
[...]

Hi James,

>
> It's Linux, so no official capacity at all.  However, I am expressing
> the views of a number of people I talked to but it's not fair of me to
> name them.

Fair enough, I was hoping that it's from Linux Foundation but it's still
good news to me that it do represent some respectful individuals.

>
[...]
>> How should we handle it?
>
> A big chunk of the reason it's taken so long just to get the above is
> that the Lawyers (of which I'm not one) are still discussing the
> specifics and will produce a much longer policy document later, so they
> don't want to be drawn into questions like this.  However, my non-
> legal-advice rule of thumb that I'm applying until I hear otherwise is
> not on the SDN list, not a problem.

Thank you for sharing your insights. I'm looking forward to the document.

While I remain quite upset about how things were handled, your message h=
as
helped restore some of my confidence in the community.

I agree with Peter Cai's earlier comment that steps should be taken to a=
ddress
the harm caused by the initial reckless actions, particularly to those w=
ho were
humiliated.

It is also important to put measures in place to prevent such drama from=
 recurring.
A formal procedure for handling urgent compliance requests may be a sens=
ible step
forward.

I hold our community in high regard and would be heartbreaking to see th=
e reputation
of the Linux Kernel undermined in such an unfortunate manner. I would ap=
preciate it
if you could convey those thoughts to the relevant individuals.

Thanks
>
> James

--=20
- Jiaxun

