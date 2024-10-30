Return-Path: <dmaengine+bounces-3648-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A329B66F9
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 16:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BEE281CA2
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B620ADE4;
	Wed, 30 Oct 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="TG9N5ALq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471A1F4737;
	Wed, 30 Oct 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300809; cv=none; b=i482DrGR49i0jjKaHhjGgbF2qQdus04EaH7K8I+RqQ0TmSLabdC5mqCG4Ee2N6R1zwERhHkhpBbPLZA+DFoz09R6h4gUfoyqP7IsO5p0UH8IRzE98W2FKgcnNuTgCGEWykWwXWSQ4qB4ChI0ZLlk0cqfLBuL4LHIwZu7t2arWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300809; c=relaxed/simple;
	bh=0OkC2dqVnOc6YLiGoIpaD17f5ytIvcdKeU4+B50Wqg0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=azZpmXthlqJ3YpHvxlC3gmviEAee3ZerN258N9RgnUDa6BzZt0ipd1D14BB6qKboZB+BE90uL+oHVXKoU060KaE4klR5hr6qCdVl1yUuVuNHVYMtAnLaoYwYig0V1S/mSU9NUKJyrmhhhMy2WlTXYjjx2Rf8XZeQBiunY+pdl9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=TG9N5ALq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730300703; x=1730905503; i=metux@gmx.de;
	bh=r8NEMTNTCDr0Gy+Y5ltqY96l8Fe98i0aW/ZfvTvRN64=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TG9N5ALqSGxwvwpbjBAJiTanYQmRvOL8ty2SucNrRTSbvbghh3MGGrs2yARUHlgY
	 Q6QVx6imOFvHivPdrDnNaVWDLC7DqHns9xHr/kj+MAEXKiFnHbw22y0ocFPAc1I6M
	 pSD2knrJS3PhtPz8aTZl64Htb70C3bnHzSLMHut3qMU/wagdL//cVlES6HvamJA+z
	 IV/2SEtSinXK+FrXdt+n76oS2X+T5Z9Fh2vs6Raxn702x1w0HpBS5t4C6tQ2pvNcn
	 oGcefk1uhkkatyXFSBCwLdO81EQttQPjV542ZF57xfMFzPRMErmS6n0AemQHDXmpv
	 ejWd1C7Jq5AQIthD1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([77.2.112.201]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1tjdfQ0rJb-00b4sz; Wed, 30
 Oct 2024 16:05:03 +0100
Message-ID: <3dd9bf0c-915d-4ef6-b6ba-309ef627e431@gmx.de>
Date: Wed, 30 Oct 2024 16:05:40 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel maintainer *CENSORED* on LKML [WAS: linux: Goodbye from a
 Linux community volunteer]
From: metux <metux@gmx.de>
To: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>,
 Peter Cai <peter@typeblog.net>, phoronix@phoronix.com, Goran <g@odyss3us.net>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
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
Content-Language: tl
In-Reply-To: <2f12ee89-af9f-4af1-8ec8-ede1d5256592@metux.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XIQHZvwV6mgEj8g5tc+iuA/GvWf/P0kkygsyLYq+DvGrrOxfuer
 sKfMhqbrAKrcS6TBA0nV6yxkQAbIg4cHFNC8m22+eV6Tm6ANt0DMxHaiEvORd/1HYzHKMgk
 0VkQ1IWl+7/dkTu206Bz+t8fa5DvIGbo2j6KILH+5jElO/7LAHib2332uA/Vkm3pSIjLcfc
 rD5dh0FGHSSNfDqMV9JFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sMpchn7KEUY=;8/e38SV5rTN/RPg4OmC+sukbTpX
 eEvWu6AFQQYXiwVueoIkWDj4q8T6D25HkBJ4BvlujeEJEMnLxGcVaslg1E2J27gL1zulE1a5C
 EGizaYvlsIws7pj9q/e0zmJJmF5S4DLpWSyvxRJqSRM3NnfIHfl+IWmFeZxaz8YyWYzlCcFed
 ndz38sV2Kah6la3JPLMEDjW5i+keCvZ89U0qCwL1dPBpLVbSJjXgw0rKuYWwEn3LU7BebRZuc
 Qm0+OYYB7JONEEcP7iON0FT3Q08NJuDZGJK9ciNrw9bZ7cYEkpizhb8DL8S2G11XMIY/+KCLq
 DaS6B8UMeROHHR53a+0rGLSzYaS6G8S7uTfp1lOX1L0WA26iAcXwZZHBnv+a4gIRHcJeCvUR/
 UCGvk28KtQVngS29h7uU7uAK7IzLNl1sQF6beW1CJfunjA5m0NoemgiKfXsGPFv0fwv6AwWza
 mlnxZbkXpgyxaImk/n3CJz5ofU1fKBpmB5vhUOAiUZL1+XGwG3QMdIdD4oz9SrlwEQRed+Jbr
 Uq34quzJ15ikB1aTiQIAo+FP9eJ4Mvu+UXt8fqCOH4xFmU3HJ7Wjm2sJ8Dw9SjQ4Pmw7f2eZz
 OWwwTpRHnHmP7tgi568dPeHhQzaYV/VxR4oi/dV2hUQg1lz54KbxtQ46azoN0xPdBGx9yr2HP
 6SgggRzv4siqhZtxJCAc0GyLT6NKSKMoIw9nezb3VjeywHYXZXR/vwemiI7/XR3Udr86o4YwA
 aCse00M4gjLQnnse5VtWlf1yScvKS/ibZJw4EeXp77qtQkJC99CcUpZrc9f2wHGJat0FijrpP
 w6y5xb9/Mdo9VqpgK0hM8Bxw==

Reposing with a different address, since my domain is hard-blocked
by kernel.org mail server.


On 29.10.24 17:51, Enrico Weigelt, metux IT consult wrote:
> On 25.10.24 15:21, Enrico Weigelt, metux IT consult wrote:
>
> Hello folks,
>
>
> <snip>
>
> Now they're really gone wild: I'm blocked by vger's spam filter.
>
> An official Linux maintainer is censored on LKML for critizing his
> holyness Torvalds.
>
> First I've thought it's just when replying specific mails, but now
> turned out *all* my mails are blocked, even totally unrelated things.
> I can confirm it's not by the message content, but my mail address or
> domain. I'm blocked from whole kernel.org
>
>
> Here's some piece of evidece (there's much more, I'm collecting it all)
>
>  >=C2=A0=C2=A0=C2=A0 linux-renesas-soc@vger.kernel.org:
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SMTP error from remote serv=
er for TEXT command, host:
> smtp.subspace.kernel.org (44.238.234.78) reason: 550 5.7.1 Your message
>  > looked spammy to us. Please check https://subspace.
>  > kernel.org/etiquette.html and resend.
>  >
>  >
>  >=C2=A0=C2=A0=C2=A0 netdev@vger.kernel.org:
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SMTP error from remote serv=
er for TEXT command, host:
> smtp.subspace.kernel.org (44.238.234.78) reason: 550 5.7.1 Your message
>  > looked spammy to us. Please check https://subspace.
>  > kernel.org/etiquette.html and resend.
>  >
>  >
>  >=C2=A0=C2=A0=C2=A0 linux-kernel@vger.kernel.org:
>  >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SMTP error from remote serv=
er for TEXT command, host:
> smtp.subspace.kernel.org (44.238.234.78) reason: 550 5.7.1 Your message
>  > looked spammy to us. Please check https://subspace.
>  > kernel.org/etiquette.html and resend.
>
>
> This is unprecented, yet another dam broken. After silently removing
> valuable maintainers from the MAINTAINERS file, now they wen't another
> step further and actively blocking communication.
>
> Seems that critizing his holyness is even worse than being Russian here.
> This behaviour is just triggering even more criticism.
>
>
> Everybody's who's unhappy with this, feel free to bringt that on the
> table @lkml. Let the Streisand effect kick in.
>
>
>
>
> --mtx
>
>
>


