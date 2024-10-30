Return-Path: <dmaengine+bounces-3645-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B79B6632
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 15:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995DB1F21B14
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0861EB9F2;
	Wed, 30 Oct 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="pVLNb/Zu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B24B672;
	Wed, 30 Oct 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299324; cv=none; b=IdwG8VIBvJX8aZZwjrHaRVVvrLsSLa5Q9XpUCvqGGJgP9d7hr8As5Ir7BGX/BgRdp/TacbAKnvmJgDLQPg6k+Xf7KsMgzTEh9GSVXP9J5R0aecg8AYzuGYWryDBE9sgopYkBSooK0TpGYlLu6OU0ErxuZ1ynxuO9+WdJDTFzZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299324; c=relaxed/simple;
	bh=0xq5+svYIejF1GKfVoLp6LlzglGNcusoL7m0UN9Vuzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgotEVh3s9fTegc8Kh8/1q0Va+NZg8Y8C3jXoH+RSkjyCUW1AlkfJenceyINplV0g21AFO79CM3q7J83CVSj8GKnNTcoD2lL52T0Uc1Df3tNEc+YL4Ii/Gh77IkChdD6wgwREzWLFJ0HnZ7t0roDWZBKbsFG04OTvFppsIqH4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=pVLNb/Zu; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730299241; x=1730904041; i=metux@gmx.de;
	bh=0xq5+svYIejF1GKfVoLp6LlzglGNcusoL7m0UN9Vuzc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pVLNb/ZuHRr1Pn+Pjp2jG3tYW4IlU/Y+hBQ+152btxdt66p35TIqTsTT49ZFaw6Z
	 um5WIqCBjgJTKH3xGelsZoSGOrO0d2uDFPCvDhBYYlsDla33B/7m9n8AWEEajnQDp
	 uShiFqkUN3/VN8NW8b+9imhYqgXCa5Hx0K1cFX0is/AQxGb6go2D72hxjmQ68AknA
	 bsZ2U9jZZrY7XRdmo+vhoFCgZbOS22vdxHB2cn9i8D+F26Q5aAnfoMNqGyVjF1mio
	 3CYSYXdgy+XrjkIdgZ4LFIHz8HinXxQM/HP680zmiVBeOjldun9lmV7PDaPFV7VnR
	 zbEYWzuIummDuFIJDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([95.114.207.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1tLH4l3NLX-00UIow; Wed, 30
 Oct 2024 15:40:41 +0100
Message-ID: <0d385451-6882-4919-8c47-1b360dbfc2d4@gmx.de>
Date: Wed, 30 Oct 2024 15:40:57 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux: Goodbye from a Linux community volunteer
To: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Peter Cai <peter@typeblog.net>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Kory Maincent <kory.maincent@bootlin.com>,
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
 linux-edac@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org, Andrew Halaney <ajhalaney@gmail.com>,
 Nikita Travkin <nikita@trvn.ru>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
 <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
 <ZxqK75WdFBod0rZ9@smile.fi.intel.com>
 <CALtW_ajKAYYwYVGnEArPWz_XaCkEiMFwpoCtzeiO1OLbAk77Sw@mail.gmail.com>
Content-Language: tl
From: metux <metux@gmx.de>
In-Reply-To: <CALtW_ajKAYYwYVGnEArPWz_XaCkEiMFwpoCtzeiO1OLbAk77Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OcaI0MgLZANUz/sgtgPUoWCFpAIiw9s1BR7zIWC9hSVK/3u0w1C
 EmjrTPrNIpJOHRhqUky0yMcGGPRfxY/t3zfIu+ZGJqJX9Zs9s7tKmfRMp0x3/P4eAOQjZsF
 6aXf+MCHd8GC61j8+Shh0zIlaciPo5djqE4HxSmFtvoWodF9CmrwLsA7BZwYK5Pgt7STN/K
 dYRxlcTUlrU3Htf1k5ERg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yH4Fl1yjr84=;qFDqc+qa7t/oEadwViPVtxqohRU
 2Tl44NvyL3GLkYPfcMVu0RDaLiKcPzOYKO1Z5ddYoN7pbF3Ri5FFPTBK3PTkur2LMFJi1DA0k
 o5tesBh/h1NImAty93KlTFaQabP3LGjlyYa2y+PXT458anjXhH7PYevb9R4t8toJ9CIC4kZ+9
 aGMQuH5tHeM6P6qwGFtjMM/5OUWZ188Ap32NZOpQHHQhzpjL1HtY+ApAOCuiZnFKJaFA00Opi
 rjDMiqaDikHYqoxsUIwNq4Cbsm847YsylGC+tiPIDrbv3e/ZfLkWsr4/FafZlQnIArn3mz4cg
 PjY6nvGr1UtkL7yKu2fA2CTgU1jczVG5qfj7KOX1oHauWtmV9gEiBeU+EtuWbmpDX+5g1goh5
 UkFcDi0v6Ar855c6NsWM2Lv4lJrPhENfZN9b06I2qcxmzReDbDpM77v9WPiA+IkP4KgaVs+W4
 gTEBpsacOs7y4K8t6A2ua3XGWUdJr/pfEl3oFW77TfJN/yfUgs0rlm33Rv1ZEAJi2n/rUM00y
 DzcECiDUOBw2AoKGRhPHou0vl8BJxGztD1LdMzPa/QLqyd6v0CNkCj2IuIZPsFE41JC+K223h
 Z4hmnaRpQWT43l0er0VpjTQCzsfuyGR1W6XZ4RZEO/RkOR0YJXr8YY8NvvaCnRiJa5eWzNiD0
 J0sdVqmz8f/RWmmNSckcciimVLb93jbRyOufvrMB5Yp5H/8DjqJijhqU3Eu3kz/IxeFHJwNkb
 kJPNAZ2V0kPJ+X/f3w0a6uB88WLK6R1t8svCm/TJeOCpNTIx6whA2FS9+n/BOY+DV+aGj+sdN
 7yD9Kwomp+XMmp5CC06ahKUOR8R7rvXX6P2ZkfUASEu8E=

On 24.10.24 21:46, Dragan Milivojevi=C4=87 wrote:

> How about your hat off to the people in the Donbas,
> ~12K of them that had died from Ukrainian artillery fire,
> that were under imminent threat of being overrun by
> the Ukrainian forces in February 2022? Are you going
> to scream about Russian propaganda when I link
> the OSCE reports about a 10 fold increase in attacks
> at that same time?

Let's also add the Serbia. The one that had been attacked by the North
Atlantic Terror Organisation under the pretext of allged "ethnical
cleansing". One day before NATO (including Germany, btw) started it's
war of aggression, the German military intelligence said: "there's
*STILL* *NO SIGN* of ethnical cleansing done by the Serbs".

Have been developers / maintainers coming from NATO countries been
banned from the kernel ? And have critics been hard-banned on the
Linux project's mail servers for just criticising the leadership ?
(that happened to me few days agao - let that sink in: a maintianer
being blocked from mailing to any Linux maillist nor individuals !)

The best thing we, the FOSS community, can do is STAY OUT of those
conflicts, no matter what. Otherwise FOSS becomes POSS - politware,
exactly what now happened to Linux.


=2D-mtx

