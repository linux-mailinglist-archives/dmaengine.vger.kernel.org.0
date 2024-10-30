Return-Path: <dmaengine+bounces-3649-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A229B6C32
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AA02824E2
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54011BD9F4;
	Wed, 30 Oct 2024 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="PxEy5NXZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3301C8FD6;
	Wed, 30 Oct 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313257; cv=none; b=B0KTBEc4E62GdwM7/Up6MXTpJoc1AU4/ArAVkSaWzlR6F2pua3xnNXQSJZVvX4uUnkK0a8IEhs6gCOjX/MJpzrCoipq6OcF2GXl8dfXoi3/MDDz6/xok48hyUBEYRP1xo6o9jLp24oLIZyHZ4z7DxWaiymeHtxc5S2iSEo65xEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313257; c=relaxed/simple;
	bh=qVSlmDSlEDWcfpve3SDrSeg/8UVEvUP9GHMSIPm116o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUgiykXD8ZYfHcNKWjA03W96/5PVfA1CbEW4W/CmMvBKPAQuowXgHTTjKYT620nVQN2XXyxrMmc2667x27n9GX47FU3S7/E+9GzaTIucjPxq9qh9AwFRL0WDBYb9uQEEd0uvHGI2CahOPapHrUAGwor3MY6mXKESB7shde+IHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=PxEy5NXZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730313146; x=1730917946; i=metux@gmx.de;
	bh=qVSlmDSlEDWcfpve3SDrSeg/8UVEvUP9GHMSIPm116o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PxEy5NXZPnL/khf+ZM27BR9NEpxVSB3HZ/B8yIFsHo+4hMZE6ntqAJmMaxw7Xseo
	 gaIIZIwwVO9VT8D2ZAyDVhi2PZiaScE1eknfpKrAKCIAemHMxOAxaoyTqpoE6Jeu7
	 2U5iwP9MNWVVH34yc3A/eCCC2GfvO3KMgzMKRz4LtjlKhERpzpOUHDIyJEVFIhMaJ
	 3r3mGdjZDZfdrTPKDAPGxgg+EXB4TEBE4sp9lE0/MkWyfyC3o93hE/PEShWUOIUZS
	 sq3039eZOOaH0CEL5pPa8D+gdQAgjz3j5h71lTqlNcOunuwf9c5sdbaOcoAZ/KV7z
	 GdU/W9tMEPE+WiJERw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([77.2.112.201]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1tbeU32akI-00j5Eb; Wed, 30
 Oct 2024 19:32:25 +0100
Message-ID: <2cf94b06-fbaf-4c04-941a-4de052a5c484@gmx.de>
Date: Wed, 30 Oct 2024 19:32:59 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel maintainer *CENSORED* on LKML [WAS: linux: Goodbye from a
 Linux community volunteer]
To: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>,
 metux <metux@gmx.de>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Peter Cai <peter@typeblog.net>, phoronix@phoronix.com, Goran
 <g@odyss3us.net>, James Bottomley <James.Bottomley@hansenpartnership.com>,
 Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <olteanv@gmail.com>, Keguang Zhang
 <keguang.zhang@gmail.com>, Yanteng Si <siyanteng@loongson.cn>,
 netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 Linus Torvalds <torvalds@linux-foundation.org>, "[DNG]"
 <dng@lists.dyne.org>, redaktion@golem.de, dev mail list <dev@suckless.org>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
 <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
 <6d37175d-1b0b-4b82-80f0-c5b4e61badbf@metux.net>
 <2f12ee89-af9f-4af1-8ec8-ede1d5256592@metux.net>
 <CALtW_agiJyX3sTaBKgwPF7X920=+fFrRgXMPt4x_GCDOMfZy_w@mail.gmail.com>
 <CALtW_aimN531aZKSSG4hVLeQDk6bUoujopkhCh57xsaxfJrYgA@mail.gmail.com>
 <b410a7fb-58c0-4d17-b818-54ec3476833a@gmx.de>
 <CALtW_ah07h7h6eNHHGNNeKzVkNi7hVOG3q4Pv9DNacpXgve5Sw@mail.gmail.com>
Content-Language: tl
From: metux <metux@gmx.de>
In-Reply-To: <CALtW_ah07h7h6eNHHGNNeKzVkNi7hVOG3q4Pv9DNacpXgve5Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RwtMXzTkBDRWvHmp0Kk6XRNw8KkUfi9Grj7L3bmCj6cM8b4QBRJ
 nNQyNDflw/d6PbexIox9ShCoDZ/pcYmmDaszMMRbbihXY91rMPHcT/ve1uP86sxKdRx1g1E
 LMIpkJ9atodTw+nhg14XzBrSVxLSAAYObFblsohBrRQc7SmScMKCDm1cN4U3B+pQtjnpw4U
 MI13I3wb6wItEr6vDq2pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ui1bpSsuH8A=;dfPECkdyGYjzvQovpk1mLrv2yHW
 Y6UHJ1D/kuELphaY3MXcMXRxjPPUeT4qliBwr9JiO9sSSiMATtjINoXzJwb//1wKiimLswgG4
 KDUFZoy+92BvMG+CVaIbYt4kN50oREhek7P4SWst1Gq32A+C0vNGj1E/0w6PCHq9Io9ZJfO1Q
 bDgdGgHMkRQP4TDh16fgjvk9XLm73lW1IiLywMwb+NAnzND/V6i9u73hcpclC4sKmB42YfOUP
 3TDY4n8NPogsIMw+oAxoN3FAdnXbRgR+hiZfdYQdFrgyZNt69oCItyIphSgp9NNsaLpsDQbcd
 sOt72shhxR7lF3e8Pmsrc0osdQVDieXS1+Tf0Tf6tFeVvczmApP8pGBIXdDZe7KHQ0TaIDrSS
 hIa9kkTXO+J03hOC2vgze0XupDmJLEo6lzAXydh63tJyp4+B4Wvw11KH8YG5b09K/aeEMFNIA
 kbjVNCObPDtDfmcW8DVNFkVRzOGX3NgE2DGCtMdkjDXXTlE7C8gwDxeTiHZpfTyRh/ze0/wSh
 43GBM3VR3f7DfeMf3FYyeUtAIjiLAbpeFjFvY0+0jcuf9YT8kiq6D3OEOkdMZWuirHh11f0Im
 EFP4HsracvNPaXIJAhWnNfwipO+FqRgiOoN5QRpQ/7JREIE5DlZC5k0p5HvwJlNjZpn1En4nH
 rgh9PWpEFZO48or7kZK4TJ4pUAje+KBL4bUX6rqdeVCJI1LGKwf5v9Kcw3fs56EuwMx/T6UBv
 hwxLAiR8QA7f+DL5wb9rPG+vvGcKkAh12qDvjGHGPER7zTudE+IvVxJamN3IX2COy9jQrLqUN
 Z0+GnYzHGDOFp8mvjBuCZmEA==

On 30.10.24 14:57, Dragan Milivojevi=C4=87 wrote:
> On Wed, 30 Oct 2024 at 14:48, metux <metux@gmx.de> wrote:
>
>> Do you have some evidence that Devuan's mail server is really blocking
>> us ?
>>
>> If so, I'd be exceptionally surprised.
>
> Well it's blocking me that's for sure. Reject message attached.

Are you subscribed to this list ?

I recall something like it's subscribers-only (once fell into the trap
and tried to post w/ wrong address).


=2D-mtx

