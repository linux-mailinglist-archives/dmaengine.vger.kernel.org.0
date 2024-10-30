Return-Path: <dmaengine+bounces-3646-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD569B66D4
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 16:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A9C1C21758
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E81F4FCC;
	Wed, 30 Oct 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=odyss3us.net header.i=@odyss3us.net header.b="LGzKhVKJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-relay.contabo.net (mail-relay.contabo.net [207.180.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8212D1FA;
	Wed, 30 Oct 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.180.195.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300563; cv=none; b=RO8EaBEOJB32X2ara0vszYm5sdhIJkV0smNx2SpDLzkyu13FAllpRBZHzSvPmJgtHnWoZSQ+lr80Z8neB+jWJoBrcWHvL/Va53TqnI08Xyidemb53o5927xQcKbzYKA8KaA7Q4O0ge7StmLRjZA5bsFO7Bu8iLCMxdVdNAga4ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300563; c=relaxed/simple;
	bh=tisj9MRLY8sAb+Wz9LAPF3LrcExkszWJ6y5pi5FUEUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WmRDqYp4zOoQ8jXcxiisBIzEj8e4PGgEcDRmvcrxMOT0NoI1g1cBVy227xHaAqkQmz9oZ9g/Kz8N8oaQLO/WC+FlW9nNeWLmzJdBsy4JwV3aZLtSrV9iYEE1ISlNRSM7O0+BuOBdpBFgtSzMuq6BnaC/kGUZxsquBhuF/39i9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odyss3us.net; spf=pass smtp.mailfrom=odyss3us.net; dkim=pass (2048-bit key) header.d=odyss3us.net header.i=@odyss3us.net header.b=LGzKhVKJ; arc=none smtp.client-ip=207.180.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odyss3us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=odyss3us.net
Received: from pxmg2.contabo.net (localhost.localdomain [127.0.0.1])
	by mail-relay.contabo.net (Proxmox) with ESMTP id 2BAE07C26B8;
	Wed, 30 Oct 2024 15:55:02 +0100 (CET)
Received: from m2712.contaboserver.net (m2712.contaboserver.net [91.194.91.201])
	by mail-relay.contabo.net (Proxmox) with ESMTPS id F388F7C26D0;
	Wed, 30 Oct 2024 15:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=odyss3us.net; s=default; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tisj9MRLY8sAb+Wz9LAPF3LrcExkszWJ6y5pi5FUEUg=; b=LGzKhVKJ5E2qTIXPvO+Pt4seOR
	v+FRvs0g0Qs78tpmUIZK5XJUU+aFPDvgMok5z3MHHEkVlym2rq9GGMj8lt3JAPYm4LZs2a7B3A3LU
	pDngWut3rfZqE9TT4h6b820cX46qywqsBAQTe7RmLUD7w9suHpIagp95n99Xxms17hHknJ+i2rXhe
	NVxE6Yv3fqQUcL+sdJrQjmBCi2UG86TI9jFo0pkgYp79YPYUahXhhrmyKs5BgkePtk5GcB+z2rX0M
	248ZHTmFnKH3cf80A+cYxgyHvMQc9M74bVMRM/R76AFcuQ20JKMfFE6sLid7yCieAoOY6G9Z0cFYM
	Gox1s9bA==;
Received: from pd95ebe22.dip0.t-ipconnect.de ([217.94.190.34]:53344 helo=void-3.local)
	by m2712.contaboserver.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <g@odyss3us.net>)
	id 1t6A67-002j6X-1C;
	Wed, 30 Oct 2024 15:55:01 +0100
Message-ID: <47b0f9fe0038baabb3b0c2d489a66a554a021e92.camel@odyss3us.net>
Subject: Re: Kernel maintainer *CENSORED* on LKML [WAS: linux: Goodbye from
 a Linux community volunteer]
From: Goran <g@odyss3us.net>
To: metux <metux@gmx.de>, Dragan =?UTF-8?Q?Milivojevi=C4=87?=
 <d.milivojevic@gmail.com>, "Enrico Weigelt, metux IT consult"
 <info@metux.net>
Cc: Peter Cai <peter@typeblog.net>, phoronix@phoronix.com, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Serge Semin
 <fancer.lancer@gmail.com>,  Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 ntb@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>,  Cai Huoqing <cai.huoqing@linux.dev>,
 dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 linux-spi@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 linux-ide@vger.kernel.org, Paul Burton <paulburton@kernel.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Arnd Bergmann <arnd@arndb.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,  linux-mips@vger.kernel.org, Bjorn
 Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>,  linux-pci@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>, Keguang Zhang
 <keguang.zhang@gmail.com>, Yanteng Si <siyanteng@loongson.cn>, 
 netdev@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
 linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Halaney
 <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Alexander Shiyan <shc_work@mail.ru>, Dmitry
 Kozlov <xeb@mail.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy
 Dushistov <dushistov@mail.ru>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,  Nikita Shubin
 <nikita.shubin@maquefel.me>, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Kexy Biscuit <kexybiscuit@aosc.io>,
 jeffbai@aosc.io, Linus Torvalds <torvalds@linux-foundation.org>, "[DNG]"
 <dng@lists.dyne.org>, redaktion@golem.de, dev mail list <dev@suckless.org>
Date: Wed, 30 Oct 2024 15:54:57 +0100
In-Reply-To: <b410a7fb-58c0-4d17-b818-54ec3476833a@gmx.de>
References: 
	<2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
	 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
	 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
	 <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
	 <6d37175d-1b0b-4b82-80f0-c5b4e61badbf@metux.net>
	 <2f12ee89-af9f-4af1-8ec8-ede1d5256592@metux.net>
	 <CALtW_agiJyX3sTaBKgwPF7X920=+fFrRgXMPt4x_GCDOMfZy_w@mail.gmail.com>
	 <CALtW_aimN531aZKSSG4hVLeQDk6bUoujopkhCh57xsaxfJrYgA@mail.gmail.com>
	 <b410a7fb-58c0-4d17-b818-54ec3476833a@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - m2712.contaboserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - odyss3us.net
X-Get-Message-Sender-Via: m2712.contaboserver.net: authenticated_id: g@odyss3us.net
X-Authenticated-Sender: m2712.contaboserver.net: g@odyss3us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Widely accepted spam lists are few and once on one it will get hard to
get cleared.

Maybe Devuan has no clue that your domain is on one or multiple spam
list. They are just using spam lists to block.

Spam lists can be used for such nasty things.

Am Mittwoch, dem 30.10.2024 um 14:48 +0100 schrieb metux:
> On 29.10.24 20:33, Dragan Milivojevi=C4=87 wrote:
>=20
> Hi,
>=20
> > > > First I've thought it's just when replying specific mails, but
> > > > now
> > > > turned out *all* my mails are blocked, even totally unrelated
> > > > things.
> > > > I can confirm it's not by the message content, but my mail
> > > > address or
> > > > domain. I'm blocked from whole kernel.org
> > >=20
> > > Same thing on my end, partial sample: https://imgur.com/a/l4Jcfhk
> >=20
> > And it is spreading, previous message to dng@lists.dyne.org=C2=A0was
> > rejected with:
> >=20
> > "Message rejected by filter rule match"
>=20
> Do you have some evidence that Devuan's mail server is really
> blocking
> us ?
>=20
> If so, I'd be exceptionally surprised.
>=20
>=20
> --mtx



