Return-Path: <dmaengine+bounces-3644-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C49B64C5
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 14:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DA81C218C5
	for <lists+dmaengine@lfdr.de>; Wed, 30 Oct 2024 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4B21F12FB;
	Wed, 30 Oct 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="Yh3moyUG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA11F4FB5;
	Wed, 30 Oct 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296246; cv=none; b=qghXuSt6HuEzojwTRh973jzdqy7nNtCYkUqx0GaKHENUeFa6JUwW5ALoCOCzd6idfJhKUnEMAipFjos6EuF467fTb3LIIwVmUBNk01AreMlQgEXW+Vy25l9rr/+MJjIrZBQT9o+E+OlYIOZyKKG6zVBcmn+Xi51rcrcU11vL3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296246; c=relaxed/simple;
	bh=D7AqZoX4gYwteb6RFEF1+ZVpyBKM5MFuI9FZMJjT8pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzjIvZVrBwHJ8xA9b1jflLGbBGbyDeCdBsXczkVTfq6DGWyFDEQUxXMWrLpPYKX8nsF0K4h7egmwlLJOThCGYnehapTRYAOumIsplEJtzqK1R0st3fJI8ksRxhoB7iucIgYOcPoazSrt24PPRFIxx5UqI1jBla8YD0GGDLrrqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=Yh3moyUG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730296100; x=1730900900; i=metux@gmx.de;
	bh=D7AqZoX4gYwteb6RFEF1+ZVpyBKM5MFuI9FZMJjT8pA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Yh3moyUGQiWIS5M+hsYMxsskv2Uv6AVjW1tdiExk6hc2qFHctV/5S+d5s0VDetbM
	 ddXzSOgh4H9xiXZWdQQ9p/bxvJbpfC0cdzm2GjGMdqdGKR57jEv3O/HGnXyhdweD7
	 ccaRv5YiORcBs53mTe9MAMZYMlaZpugACFe7+1ZbAb3e16vRosw+4uqYuCKyFoPSh
	 ebsVFbcCQx46mA6re4AGlNQES/piXbnlltBhxqaooB41ez9ls791F95cmnbKf5nr/
	 8wGbqi5BkhpQ516UfzX6Hh0kPqS8AZWmCVzVbglOwE3a8FbBCeynePOSL575ZcOid
	 Dd1YAX2gyFNCokhe8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([95.114.207.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1t9iMT01nh-006fzu; Wed, 30
 Oct 2024 14:48:20 +0100
Message-ID: <b410a7fb-58c0-4d17-b818-54ec3476833a@gmx.de>
Date: Wed, 30 Oct 2024 14:48:37 +0100
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
 "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Peter Cai <peter@typeblog.net>, phoronix@phoronix.com,
 Goran <g@odyss3us.net>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
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
Content-Language: tl
From: metux <metux@gmx.de>
In-Reply-To: <CALtW_aimN531aZKSSG4hVLeQDk6bUoujopkhCh57xsaxfJrYgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02/JYljBFpt12zmY0Go6Xkn401QYmKavoXnaT8EeSlrAHbRsx8n
 Zdvv/lLJxVdM8nFQizZfTKEW37UKSRmLg/f7sd3o97CFe9/qm8RP0UtwctZ+qxVObR/jFNw
 m13fSOqomvd7q+gMqAZ942T8v05wPOrYZpb9mIQDrg5MXcznAOy7aytPmL3VlgdapjHCO2n
 gp70ijx1LoNifjgVmNeng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XMcg9mQEW00=;8p/Sr9f43i/VMDKIw0uuN4zeFJj
 4TzNACOpE4r2YbLQxZ5xl1PnYM+gpaKmM07XslwcqNngCXLB/XttSLHNSdEvR8s3B47NjhE4Z
 gzCXT1FKQIMCgB4RbRzC6MGKa+z4KYaV7xlHwMBOtWQFO7JG1x6IekOpKNRsdDBnGGQUPlX5Q
 NpiKIH7f7dZZbkUks6KHEL7Cw1yhhM+DDxR9v+J8Y3EbhOl+pqDAa5zkW031TMU6RP1NAEh8L
 w5W3BMaUImgWK3HjJCuWDQJW/uapa9utlZeZFhk75sKmzP+v1VvDNGawPrYnM7ZqwfhA2BDLH
 xCLmFjHW61xtNh01x6lEDKLLctnwXP5AGjDyUp+umcxFONS2fffaPA+V8uvn5YPPgJmqGElw7
 ALecE9QNd4O+9zMnfh5BS1I72wVO3CM0k8ewBwd2TTSh2X2ZZKSjE9eFtU23D8SV6SNHGq3VL
 hAB1H7fXdigm8b9aLmTxZjJ/1RMDu8ef4YggBoz1+WVG2VnrSKtNta/WWzAI3QtcBoZnsWcrO
 It2zyC6kJ8mGD8XBqofmwTlL3LP2+cvIE18rL7d36PTROQgvVSW7DFkJU1AspI6covtd35jCZ
 FXHGPfFDc+r41fAp7tjNc4DHJlUFZ3ga4LaJitNOM1JvBfmrazXfH21sxmaO6nAmN2F7MmKun
 5BG2jzR0E2loJkz+FDYujXL4ittyLdbZ0KAQFKHl+5A+k48zyYBpc/peSRZITevB55Kav7VlS
 TchpkcgA4n3JLFkMgA95jPXj+i2mXrTz9GOVbUHx3l0Nfa7L3hALf6Ni2Zqc97rk3b9xf1z4d
 4miKQK+swI7CsaCsEeJgfj+GwJ6elj8XkjCLKiEWjNXvk=

On 29.10.24 20:33, Dragan Milivojevi=C4=87 wrote:

Hi,

>>> First I've thought it's just when replying specific mails, but now
>>> turned out *all* my mails are blocked, even totally unrelated things.
>>> I can confirm it's not by the message content, but my mail address or
>>> domain. I'm blocked from whole kernel.org
>>
>> Same thing on my end, partial sample: https://imgur.com/a/l4Jcfhk
>
> And it is spreading, previous message to dng@lists.dyne.org was rejected=
 with:
>
> "Message rejected by filter rule match"

Do you have some evidence that Devuan's mail server is really blocking
us ?

If so, I'd be exceptionally surprised.


=2D-mtx

