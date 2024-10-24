Return-Path: <dmaengine+bounces-3460-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE05C9ADCD4
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 08:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A9F1F2168E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 06:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18180189BA0;
	Thu, 24 Oct 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=reimar.doeffinger@gmx.de header.b="tzP19X4m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9201662F4;
	Thu, 24 Oct 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753021; cv=none; b=TQFaOSPYz3vpjaHp/DeX6agbi9/vPWdhOkVefIkZ0K5hQnPrToGvpKFxZWix0e8e/pfIiHikePcmb94BmQZFzy6nOrGTB8OF/Vo1aD/gRYeuKQVTgsHW7x+ZcUla3k1Das9nftzvB6nSSbjOZvlpZs4mr4fESJj1Y4Q/6vXw9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753021; c=relaxed/simple;
	bh=wdgD6qvXSVO8H0q9V3v24HaTgfvhkQIOWPYzBuOxHw8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=crP+5+ds7LXYvoYhk4hoCXwqffJ3lF3lB8egIakW5VhVEMeoo0JEAjzokwjSIIT7gJn/TVAbwEwpuOIm7ZdbwtuclwUYxFQQA6LLUVZw7MJqTW6guMPrGrhiqfwrXbYI0nUOIcu7gp1tbr9rwMRwHvv3fgzYvUQjSH9LzNehaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=reimar.doeffinger@gmx.de header.b=tzP19X4m; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729752930; x=1730357730;
	i=reimar.doeffinger@gmx.de;
	bh=dbq90nrq8LfkX1Ug149kdQ8PEHRPGRI4rzHx8hOaEss=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=tzP19X4mYfx99tlCYHElzIncUINmjJmY64Tvzhy+puX0CUzTnpXtaEFP3En+UVSW
	 Im89H+yOxexeu/ER0tskm6M+g5FXhTgNuy9PgEyxPszxM+XXsU3rtubJEuo66VR6b
	 Gt4vbmF3OnPk7HedzlokO8v5wr69CC/kRspI+/8vQr+6rNTyJehsV+FR6Waz3wJfb
	 4HHDb1/43DKfrPaTFpvT8ez05Uu0bsh0FpWWvXVHGwdwjM5hvy8j3cxJ3lQ8RSTD6
	 3VwCl3sjRXSsS6HJvJrZQyrf2Cuy40/MMgo8V5chzJFcsc3D7lqXjDxiKIlSTby1c
	 FGzmM/YA+oOsOGL0bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from smtpclient.apple ([155.4.74.59]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1tbXPo3PDR-00m2mo; Thu, 24
 Oct 2024 08:55:29 +0200
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: linux: Goodbye from a Linux community volunteer
From: =?utf-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
In-Reply-To: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Date: Thu, 24 Oct 2024 08:55:05 +0200
Cc: Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Andy Shevchenko <andy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Cai Huoqing <cai.huoqing@linux.dev>,
 dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>,
 linux-ide@vger.kernel.org,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <olteanv@gmail.com>,
 Keguang Zhang <keguang.zhang@gmail.com>,
 Yanteng Si <siyanteng@loongson.cn>,
 netdev@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 linux-hwmon@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>,
 linux-edac@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org,
 Andrew Halaney <ajhalaney@gmail.com>,
 Nikita Travkin <nikita@trvn.ru>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Alexander Shiyan <shc_work@mail.ru>,
 Dmitry Kozlov <xeb@mail.ru>,
 Sergey Shtylyov <s.shtylyov@omp.ru>,
 Evgeniy Dushistov <dushistov@mail.ru>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D454EE83-DFB9-4A2D-821E-EF709350D5BB@gmx.de>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
To: Serge Semin <fancer.lancer@gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-Provags-ID: V03:K1:k3CVh5UwL8Pr/QS58KpuV8k33BndHnbC3H+BIpo/1DJWFypIkuS
 N/hzcr7X8i2LvFoAEfWjMCcex7w3EYtjq2rYvFLATE7ycsPjRqZZ4VMdu0mv4o6o2XPEV6f
 qG5/X5qwYvrM0UlAeg26MiHfER5UCJzK7uI5qY+nWXMqmQL1YyNU4yLTagqVf9pDO4vDvxt
 98ZLb+QsQUf5paugVVstQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:92UNTiVAadM=;4dqRgDg6n4gLXT6FjhukD/0b6+W
 cAxvAWlthP+w/cgMg25Gt0gR4wH+rWwx+h1AiMjjme5RKv++iqKL0xjNBp5BM/7/Hwnpe3UYm
 o8Vkwq66DyBaEqk3xacLhdkpkdGKTXtG++OgKShHJt3uhBdBq41d9crk8vRrBbPwKPTMbswSm
 J6OzXOOOmi+01thCwy4mlqNnVeoifHAPabt8eX7s/0hNffoJNhFjHa1NUsWFkSrQAoNOU0E8+
 NEtxofXAieUtzVvocrNDFaWTgCbEGhbXjHYQ3AcMPHDkJfTEC4wfl7lJIUa2xbOtqifTqzeTj
 aF7XzVjxoVihSzQeGztEynTuma4d8SK3cNYpQ12c6/EH0NtEdhH0qYuPfDYq0JPvY9eoosSPj
 ASljvkH7D/Xfxdu+kJ88aWu7TBbUF2oVE11gSTi6u0ZrDSYQFf2lvinhldkIIOLKw1tuDui3X
 5XB0CjikMWKr8iOtmdUjBbD9wAc64IQw2BPOny3Meon+nVUTZXQGvwHGvY83O0tDNepZgceyQ
 /Nw6RoeWqH26gkVfxV28vRjfpvCfgOL+2T5gj8nuMHdEqL8yvjUA0x133sFmvA90DfsE8tij5
 wMUerleYmMgeDpxf2+C3zNNYAXEfCtrTuTQ3hOW4fkaRq3+qsRj7twmFyNzyRugmvBmDB02Il
 cYnFmPdNFN8VYURjGdOce1sIKREajABwRlfLyt0wBKTxhKvHTEjo25YHlURfWakMUMsPBDNw2
 p0sdYF3h6d8d2Rq7tFGONj5aO+BbeVqqnW/hM9zNatKsA6yIpDC8E6t1oVfp/Thkl7XbYEpBs
 9bvjbNbLISJBRd0RxLlRiGog==

Hello Serge!
I do not have many contributions to show to give it extra weight nor do
I actually know you.
Nevertheless I still wanted to say thank you for your nice message even =
if
it is for a sad occasion, and share your sentiment of hoping
for more pleasant circumstances.

Best regards,
Reimar

(and apologies if anyone is annoyed by the wide CC list, but I think =
it's
important for at least some thank yous to be public and nobody else =
seems
to have written one yet)

> On 24 Oct 2024, at 06:27, Serge Semin <fancer.lancer@gmail.com> wrote:
>=20
> Hello Linux-kernel community,
>=20
> I am sure you have already heard the news caused by the recent Greg' =
commit
> 6e90b675cf942e ("MAINTAINERS: Remove some entries due to various =
compliance
> requirements."). As you may have noticed the change concerned some of =
the
> Ru-related developers removal from the list of the official kernel =
maintainers,
> including me.
>=20
> The community members rightly noted that the _quite_ short commit log =
contained
> very vague terms with no explicit change justification. No matter how =
hard I
> tried to get more details about the reason, alas the senior maintainer =
I was
> discussing the matter with haven't given an explanation to what =
compliance
> requirements that was. I won't cite the exact emails text since it was =
a private
> messaging, but the key words are "sanctions", "sorry", "nothing I can =
do", "talk
> to your (company) lawyer"... I can't say for all the guys affected by =
the
> change, but my work for the community has been purely _volunteer_ for =
more than
> a year now (and less than half of it had been payable before that). =
For that
> reason I have no any (company) lawyer to talk to, and honestly after =
the way the
> patch has been merged in I don't really want to now. Silently, behind =
everyone's
> back, _bypassing_ the standard patch-review process, with no affected
> developers/subsystem notified - it's indeed the worse way to do what =
has been
> done. No gratitude, no credits to the developers for all these years =
of the
> devoted work for the community. No matter the reason of the situation =
but
> haven't we deserved more than that? Adding to the GREDITS file at =
least, no?..
>=20
> I can't believe the kernel senior maintainers didn't consider that the =
patch
> wouldn't go unnoticed, and the situation might get out of control with
> unpredictable results for the community, if not straight away then in =
the middle
> or long term perspective. I am sure there have been plenty ways to =
solve the
> problem less harmfully, but they decided to take the easiest path. =
Alas what's
> done is done. A bifurcation point slightly initiated a year ago has =
just been
> fully implemented. The reason of the situation is obviously in the =
political
> ground which in this case surely shatters a basement the community has =
been built
> on in the first place. If so then God knows what might be next (who =
else might
> be sanctioned...), but the implemented move clearly sends a bad signal =
to the
> Linux community new comers, to the already working volunteers and =
hobbyists like
> me.
>=20
> Thus even if it was still possible for me to send patches or perform =
some
> reviews, after what has been done my motivation to do that as a =
volunteer has
> simply vanished. (I might be doing a commercial upstreaming in future =
though).
> But before saying goodbye I'd like to express my gratitude to all the =
community
> members I have been lucky to work with during all these years. =
Specifically:
>=20
> NTB-folks, Jon, Dave, Allen. NTB was my starting point in the kernel =
upstream
> work. Thanks for the initial advices and despite of very-very-very =
tough reviews
> with several complete patchset refactorings, I learned a lot back =
then. That
> experience helped me afterwards. Thanks a lot for that. BTW since then =
I've got
> several thank-you letters for the IDT NTB and IDT EEPROM drivers. If =
not for you
> it wouldn't have been possible.
>=20
> Andy, it's hard to remember who else would have given me more on my =
Linux kernel
> journey as you have. We first met in the I2C subsystem review of my DW =
I2C
> driver patches. Afterwards we've got to be frequently meeting here and =
there -
> GPIO, SPI, TTY, DMA, NET, etc, clean/fixes/features patch(set)s. Quite =
heat
> discussions in your first reviews drove me crazy really. But all the =
time we
> managed to come up with some consensus somehow. And you never quit the
> discussions calmly explaining your point over and over. You never =
refused to
> provide more detailed justification to your requests/comments even =
though you
> didn't have to. Thanks to that I learned how to be patient to =
reviewers
> and reviewees. And of course thank you for the Linux-kernel knowledges =
and all
> the tips and tricks you shared.
>=20
> * Andy, please note due to the situation I am not going to work on my =
DW DMAC
> fixes patchset anymore. So if you ever wish to have DW UART stably =
working with the
> DW DMA-engine driver, then feel free to pick the series up:
> Link: =
https://lore.kernel.org/dmaengine/20240911184710.4207-1-fancer.lancer@gmai=
l.com/
>=20
> Linus (Walleij), after you merged one of my pretty much heavy patchset =
in you
> suggested to me to continue the DW APB GPIO driver maintaining. It was =
a first
> time I was asked to maintain a not-my driver. Thank you for the trust. =
I'll
> never forget that.
>=20
> Mark, thank you very much for entrusting the DW APB SSI driver =
maintenance to
> me. I've put a lot of efforts into making it more generic and less =
errors-prune,
> especially when it comes working under a DMA-engine control or working =
in the
> mem-ops mode. I am sure the results have been beneficial to a lot of =
DW
> SPI-controller users since then.
>=20
> Damien, our first and last meeting was at my generic AHCI-platform and =
DW AHCI
> SATA driver patches review. You didn't make it a quick and easy path. =
But still
> all the reviews comments were purely on the technical basis, and the =
patches
> were eventually merged in. Thank you for your time and experience I've =
got from
> the reviews.
>=20
> Paul, Thomas, Arnd, Jiaxun, we met several times in the mailing list =
during my
> MIPS P5600 patches and just generic MIPS patches review. It was always =
a
> pleasure to discuss the matters with such brilliant experts in the =
field. Alas
> I've spent too much time working on the patches for another subsystems =
and
> failed to submit all the MIPS-related bits. Sorry I didn't keep my =
promise, but
> as you can see the circumstances have suddenly drawn its own deadline.
>=20
> Bjorn, Mani, we were working quite a lot with you in the framework of =
the DW
> PCIe RC drivers. You reviewed my patches. I helped you to review =
another patches
> for some time. Despite of some arguing it was always a pleasure to =
work with
> you.  Mani, special thanks for the cooperative DW eDMA driver =
maintenance. I
> think we were doing a great work together.
>=20
> Paolo, Jakub, David, Andrew, Vladimir, Russell. The network subsystem =
and
> particularly the STMMAC driver (no doubt the driver sucks) have turned =
to be a
> kind of obstacle on which my current Linux-kernel activity has =
stopped. I really
> hope that at least in some way my help with the incoming STMMAC and DW =
XPCS
> patches reviews lightened up your maintainance duty. I know Russell =
might
> disagree, but I honestly think that all our discussions were useful =
after all,
> at least for me. I also think we did a great work working together =
with Russell
> on the DW GMAC/QoS ETH PCS patches. Hopefully you'll find a time to =
finish it up
> after all.=20
>=20
> Rob, Krzysztof, from your reviews I've learned a lot about the most =
hardwary part
> of the kernel - DT sources and DT-bindings. All your comments have =
been laconic
> and straight to the point. That made reviews quick and easy. Thank you =
very
> much for that.
>=20
> Guenter, special thanks for reviewing and accepting my patches to the =
hwmon and
> watchdog subsystems. It was pleasure to be working with you.
>=20
> Borislav, we disagreed and argued a lot. So my DW uMCTL2 DDRC EDAC =
patches even
> got stuck in limbo for quite a long time. Anyway thank you for the =
time
> you spent reviewing my patches and trying to explain your point.
>=20
> * Borislav, it looks like I won't be able to work on my Synopsys EDAC =
patchsets
> anymore. If you or somebody else could pick them up and finish up the =
work it
> would be great (you can find it in the lore archive). The patches =
convert the
> mainly Zynq(MP)-specific Synopsys EDAC driver to supporting the =
generic DW
> uMCTL2 DDRC. It would be very beneficial for each platform based on =
that
> controller.
>=20
> Greg, we met several times in the mailing lists. You reviewed my =
patches sent
> for the USB and TTY subsystems, and all the time the process was =
straight,
> highly professional, and simpler than in the most of my other case.
> Thank you very much for that.
>=20
> Yoshihiro, Keguang, Yanteng, Kory, Cai and everybody I was lucky to =
meet in the
> kernel mailing lists, but forgot to mention here. Thank you for the =
time spent
> for our cooperative work on making the Linux kernel better. It was a =
pleasure to
> meet you here.
>=20
> I also wish to say huge thanks to the community members trying to
> defend the kicked off maintainers and for support you expressed in
> these days. It means a lot.
>=20
> A little bit statics of my kernel-work at the end:
>=20
> Signed-off patches: 518
> Reviewed and Acked patches: 253
> Tested patches: 80
>=20
> You might say not the greatest achievement for seven years comparing =
to some
> other developers. Perhaps. But I meant each of these tags, be sure.
>=20
> I guess that's it. If you ever need some info or consultation =
regarding the
> drivers I used to maintain or the respective hardware or the Synopsys =
IP-cores
> (about which I've got quite comprehensive knowledge by this time), =
feel free to
> reach me out via this email. I am always willing to help to the =
community
> members.
>=20
> Hope we'll meet someday in more pleasant circumstances and drink a
> couple or more beers together. But now it's time to say good bye.
> Sorry for a long-read text. I wish good luck on your Linux-way.
>=20
> Best Regards,
> -Serge(y)
>=20


