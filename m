Return-Path: <dmaengine+bounces-3478-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376329AEB3F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585BD1C22C1D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C991F7086;
	Thu, 24 Oct 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="NSQbMpS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvGufEsr"
X-Original-To: dmaengine@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206631F6697;
	Thu, 24 Oct 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785679; cv=none; b=QBvSGWX7cUUZGaGq5NRiuo6+XnXwRZiqfnDga0w9Qkz/PcNi5IXu3asiHgnWlOyq20QxcIWrmj+Xb/98k651buXIhQV99RO0hZa47tC9X6BEKpsdC1w3PREGCtFRP7vLygZjofaUVk24XQRtz0ZmCQx234r/isUuuXRmWEzqILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785679; c=relaxed/simple;
	bh=ZnN092/uqHw1eYzx7adrt8EsAcrScv3pParyGaS6g9o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n4nccAY4RBeFCBvy+8Cjhpvko4GeLK4K4Kf5VqtHffrjoZ/DL4213XUdwyprbJap6lEGv2pcz9DtCjq0iUonu8rsAIrGsYVEjEMYgL94q8KoExkG+Wcd8UhrvpQ/ZNG20kUhnCQXONIz1+XYtjDkJlbVk8ikaAWHMJwPCKEzChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=NSQbMpS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvGufEsr; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id C163420071F;
	Thu, 24 Oct 2024 12:01:15 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Thu, 24 Oct 2024 12:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729785675;
	 x=1729792875; bh=TMl54/iBi871VKim9IIS4u83CKXUQJ/FyOD1Xg77P7w=; b=
	NSQbMpS3R3E4dlEqGdM1jhW7ZfXrAWVJ6Os5xAEWgcpLc/GZoWa+YF2nfjV6cQsl
	H4JicpXmhhqiZU7xrhtPbFYRlGqbN+8dk7bZ13v37z3cGKpaWopRck/wkwy38Xf2
	ci9wfYBFrIn1iJrl/ZPGnFBuXUfNLOgI7u1BN8QPYIdbuagx+h+PNfbrp9TdH0vQ
	YnPn+LXhndnImJzamTwTTHs5+yCRsd06+7wr0B0f/spJ6zmPBU5jQKihR1Raf3+/
	ps9K+q8x/EfLhxWEYTX/2dy0k4H/lSfQWmHZZouE2/FARpJI7u+wU1AJVndr3bIZ
	hu1SUcObOJVPJKAcwyPfgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729785675; x=
	1729792875; bh=TMl54/iBi871VKim9IIS4u83CKXUQJ/FyOD1Xg77P7w=; b=m
	vGufEsroy45Q+Wv1N4jZczFEtycPRUA72zQWnYm47XQxy4HGYgg96mYZ1kKj32zT
	nbZ3sUi2uN16uqvDj+ULbz6Ce1uNhKhJEFsl5V3B2BNvo7gVqD0aRi5AU5+U8eXv
	Ar7+vMoq+CFTjZBC+o4Wv7XgGEYHf3AVRVYMJu6xZsyrt0X8pRHGBZzkImFRBbUl
	kej18tjHQXv20f2K8urX6DqfcKZWBkQKFdLF7Mwb+0iZUYfu89j7wbWl1SEAq+ME
	YtSvV/z/ZmwKwD1X36aWF5w43xLzHJMOKoKob3RZrMcO1pDRtMPcrwpg+rMrTn71
	92QY+6mox409SUhACTfow==
X-ME-Sender: <xms:R28aZ87xeuZz9ijvSAEFcpU6jsgD81FufMVxu1TFElQ_dmR4JNhnMA>
    <xme:R28aZ94kdm1c-YnrOrgqN5552RdCdcj3MWik2MpQK0r75wOR3oRdwcPeJaUloKYQx
    bvTV5Wq-WVRIThoUWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlqddutddmnecujfgurhepofggfffhvfev
    kfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuc
    eojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghr
    nhepheelkeetgfeftdekgfevieegfeehleeihedvffefgfefgfeihfdtkeekjeefkeehne
    cuffhomhgrihhnpehtrhgvrghsrdhgohhvnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homhdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrg
    drfhhrrghnkhgvnhdruggvpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepkh
    horhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghv
    vghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghjhhgrlhgrnhgvhiesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrlhhlvghnsghhsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepfhgrnhgtvghrrdhlrghntggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:R28aZ7d-dTib9xX1eQe06cOfVXstoa8Q3ZMSX1EEBPIoT_xOiQzmww>
    <xmx:R28aZxLKdmFaqdoIV6cB_vOFEm5guIBDYEUSvboVJvBqpZvTBoWfdg>
    <xmx:R28aZwL6-1nzZN7U0rbUoyatJlZcyriokJaCDqEza1aRZ0RZMMSr0A>
    <xmx:R28aZyzbpWnXaNOGS9vja1_4cbH3MFvYXMZgqfVKBfWrucklTnClDQ>
    <xmx:S28aZ2bGpg4jByy-8VE2uAQpPJmUJEsF02dYpz4D_n5AlZiw8JbEP-bP>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F2561C20067; Thu, 24 Oct 2024 12:01:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 16:59:36 +0100
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
Message-Id: <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
In-Reply-To: 
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8824=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=883:50=EF=BC=8CJames Bottomley=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, 2024-10-24 at 07:27 +0300, Serge Semin wrote:
>> Hello Linux-kernel community,
[...]

Hi James,

Sorry to chime in here, and thanks for making things clear.

However, I have some questions regarding this statement, please see belo=
w:

> Please accept all of our apologies for the way this was handled.  A
> summary of the legal advice the kernel is operating under is

In what capacity this statement was made, i.e, who is "our" here and "we"
below? Are you representing any formal group in this case?

>
>    If your company is on the U.S. OFAC SDN lists, subject to an OFAC
>    sanctions program, or owned/controlled by a company on the list, our
>    ability to collaborate with you will be subject to restrictions, and
>    you cannot be in the MAINTAINERS file.
>
> Anyone who wishes to can query the list here:
>
> https://sanctionssearch.ofac.treas.gov/

I did a quick search and found the following entry:

HUAWEI TECHNOLOGIES CO., LTD. Under CMIC-EO13959 sanction program.

Although it's a Non-SDN sanction, it can still be interpreted as
"subject to an OFAC sanctions program".

How should we handle it?

>
[...]
>
> Again, we're really sorry it's come to this, but all of the Linux
> infrastructure and a lot of its maintainers are in the US and we can't
> ignore the requirements of US law.  We are hoping that this action
> alone will be sufficient to satisfy the US Treasury department in
> charge of sanctions and we won't also have to remove any existing
> patches.

I truly appreciate that someone has finally addressed the underlying iss=
ue.
I understand the importance of protecting infrastructure and maintainers=
 from
potential legal threats by ensuring compliance. My intent in asking these
questions is not to place anyone in a difficult position, but simply to =
gain a
better understanding of the situation, so I can take appropriate action =
to
keep everyone safe.

Disclaimer: I have no connection to any sanctioned body, and I'm a resid=
ent
of UK.

Thanks

>
> Regards,
>
> James Bottomley

--=20
- Jiaxun

