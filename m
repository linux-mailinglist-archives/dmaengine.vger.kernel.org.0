Return-Path: <dmaengine+bounces-3462-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762439ADDB4
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 09:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972AD1C217EA
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134019F104;
	Thu, 24 Oct 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oi1uo4NJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6C1AA7B6
	for <dmaengine@vger.kernel.org>; Thu, 24 Oct 2024 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755181; cv=none; b=OrMeWWLb5wVM/ZENffYQSXlDqf3mQBlo4HM2RjjnFUS+JyYBQERs/GKj2LRU44AiKnYKwVk5NIjnyz/v8S1TpcjE8LtHrOFFFVh2zHp+BEtXSFmUXHzj7sX8InEKJ+3hmGoqdJqPZWbKQxwBqOOdnPkQTCPQikgx+9IPaQ9CWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755181; c=relaxed/simple;
	bh=xJk9DEO+3X/GcCNVC4idOyP3Q8DzjJsvWHkQBNNuUiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxyATZYeyeaEBn5pJ8Axo2MVElU8R108xut13Y6cx1dZkSnv3czi8uCxVfRgF/czd4dRQuk3f4fNVLj3/YuDxWz63GvDYP/RdBtqAMIINpj8Fnmi8q2dyQGulv/eDTgCCAdxBOSsRrSBsxZ0Y0hgQKC9n/ldJw8xmbeuw1agI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oi1uo4NJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729755176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QtnlkYe/1PnWLS5Ii6raZ83O0JHoz7C7QG5MqJpjr0=;
	b=Oi1uo4NJVgPAke74xYV5ZNcgZS1nM0t8s8O3wVpe/7axFgijsHzM44r1ExfYuGKTmZf3mq
	TalJIZbhNNczQWJ46aIcTN+VwIEL0KN39hml5FHFCaPIN3xu8wGxsn60g//4ky6LvUYl5B
	fQlb6CoA4r9pI/dYb2ZPHYx3tMgIhBo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-eEUbEQfRPWmSrgpwO8OQ2Q-1; Thu, 24 Oct 2024 03:32:55 -0400
X-MC-Unique: eEUbEQfRPWmSrgpwO8OQ2Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6e3529d80e5so11268487b3.0
        for <dmaengine@vger.kernel.org>; Thu, 24 Oct 2024 00:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755174; x=1730359974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QtnlkYe/1PnWLS5Ii6raZ83O0JHoz7C7QG5MqJpjr0=;
        b=GkKLK71795B/bHSU4H+f/A9sMdgeBEjOdl9inK/J4ZWcftb+3h7G/o0+o96XCagzuO
         fhpKwvWAokAvTi1QUSl1Pf8E+Ad8J70IRZMUWYNx9L2PqdYAGP+tuV5mT0UgRIr4kSwt
         t1KCtDxVaj463FWP2pS07C/Yu2xpJoWt4vZH8vRqrTRIPEiic2MJhC25LImuMKMGeGyx
         72q+JEOIkHB0KgAW445uHcB2cIViQzYwdflc4+zLEEU6VcG3irAG8KQHMV12MEBL9apO
         I0JpxG+0TZI9XbRlhWYhN/d7qoXf04iyIXk+kduajuI3x+SUcUmFSKztr4r080nk+iGQ
         dBYw==
X-Forwarded-Encrypted: i=1; AJvYcCWT3T5bGVA7BOefL+RI8F/EdkUvUG4/I1LG1NoIF7fCPk9UoiwAoJzooDYbk7G0rNudZLlqEsnq438=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRpewTYs9mIlZONxPlm9k4k6FeiHAFQIhBqsPkIL1WptJeUl8
	vCNkmJ/0CDyc7ew5pUOT0zOHrr2PEvgLOw3xGW45tSU+nHnvfrwjdi3FWgyAo3nKX0jtuQuHlkd
	g+Cw84UptoFLiFBSzIGyEVTUVsyDs+Nw60mHsk0Tum7RKfRc7EeURgjcF9Q==
X-Received: by 2002:a05:690c:6e03:b0:6db:cf6c:a7c4 with SMTP id 00721157ae682-6e866331c20mr10690537b3.45.1729755174541;
        Thu, 24 Oct 2024 00:32:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwjzENxysw+j7YRfDKeQxYY43g6inqzMz9Yd8c7a5bPrsRFqYGaOrxa6Un2MKjvPM7S1dLyw==
X-Received: by 2002:a05:690c:6e03:b0:6db:cf6c:a7c4 with SMTP id 00721157ae682-6e866331c20mr10690047b3.45.1729755174061;
        Thu, 24 Oct 2024 00:32:54 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008ac8f1sm47141046d6.26.2024.10.24.00.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 00:32:53 -0700 (PDT)
Message-ID: <7be870fc2b2fa01b89708208c78cc041029252aa.camel@redhat.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
From: Philipp Stanner <pstanner@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
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
 linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
 linux-edac@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-serial@vger.kernel.org
Cc: Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Alexander Shiyan
 <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,  Sergey Shtylyov
 <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Sergio Paracuellos
 <sergio.paracuellos@gmail.com>,  Nikita Shubin <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Oct 2024 09:32:46 +0200
In-Reply-To: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
References: 
	<2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 07:27 +0300, Serge Semin wrote:
> Hello Linux-kernel community,
>=20
> I am sure you have already heard the news caused by the recent Greg'
> commit
> 6e90b675cf942e ("MAINTAINERS: Remove some entries due to various
> compliance
> requirements."). As you may have noticed the change concerned some of
> the
> Ru-related developers removal from the list of the official kernel
> maintainers,
> including me.
>=20
> The community members rightly noted that the _quite_ short commit log
> contained
> very vague terms with no explicit change justification. No matter how
> hard I
> tried to get more details about the reason, alas the senior
> maintainer I was
> discussing the matter with haven't given an explanation to what
> compliance
> requirements that was. I won't cite the exact emails text since it
> was a private
> messaging, but the key words are "sanctions", "sorry", "nothing I can
> do", "talk
> to your (company) lawyer"... I can't say for all the guys affected by
> the
> change, but my work for the community has been purely _volunteer_ for
> more than
> a year now (and less than half of it had been payable before that).
> For that
> reason I have no any (company) lawyer to talk to, and honestly after
> the way the
> patch has been merged in I don't really want to now. Silently, behind
> everyone's
> back, _bypassing_ the standard patch-review process, with no affected
> developers/subsystem notified - it's indeed the worse way to do what
> has been
> done. No gratitude, no credits to the developers for all these years
> of the
> devoted work for the community. No matter the reason of the situation
> but
> haven't we deserved more than that? Adding to the GREDITS file at
> least, no?..
>=20
> I can't believe the kernel senior maintainers didn't consider that
> the patch
> wouldn't go unnoticed, and the situation might get out of control
> with
> unpredictable results for the community, if not straight away then in
> the middle
> or long term perspective. I am sure there have been plenty ways to
> solve the
> problem less harmfully, but they decided to take the easiest path.
> Alas what's
> done is done. A bifurcation point slightly initiated a year ago has
> just been
> fully implemented. The reason of the situation is obviously in the
> political
> ground which in this case surely shatters a basement the community
> has been built
> on in the first place. If so then God knows what might be next (who
> else might
> be sanctioned...), but the implemented move clearly sends a bad
> signal to the
> Linux community new comers, to the already working volunteers and
> hobbyists like
> me.

I'm also quite shocked and even baffled about how this has been
handled. This is not how leaders should communicate difficult or big
decisions. It's the most disappointing event I have witnessed in the
project.

There is the form and there is the content =E2=80=93 about the content one
cannot do much, when the state he or his organization resides in gives
an order.

But about the form one can indeed do much. No "Thank you!", no "I hope
we can work together again once the world has become sane(r)"... srsly,
what the hell.

No idea why they felt the need to do it that way, but it certainly is
not the open source way, neither is it decent or honorable.


That said, thank you for all your work, Serge!

I believe that nothing that has been accomplished with a candid mindset
and decent intentions is ever done for nothing, although it often pays
off way differently than expected.
So I hope this will be the case for you, too.

Take care,
Philipp


>=20
> Thus even if it was still possible for me to send patches or perform
> some
> reviews, after what has been done my motivation to do that as a
> volunteer has
> simply vanished. (I might be doing a commercial upstreaming in future
> though).
> But before saying goodbye I'd like to express my gratitude to all the
> community
> members I have been lucky to work with during all these years.
> Specifically:
>=20
> NTB-folks, Jon, Dave, Allen. NTB was my starting point in the kernel
> upstream
> work. Thanks for the initial advices and despite of very-very-very
> tough reviews
> with several complete patchset refactorings, I learned a lot back
> then. That
> experience helped me afterwards. Thanks a lot for that. BTW since
> then I've got
> several thank-you letters for the IDT NTB and IDT EEPROM drivers. If
> not for you
> it wouldn't have been possible.
>=20
> Andy, it's hard to remember who else would have given me more on my
> Linux kernel
> journey as you have. We first met in the I2C subsystem review of my
> DW I2C
> driver patches. Afterwards we've got to be frequently meeting here
> and there -
> GPIO, SPI, TTY, DMA, NET, etc, clean/fixes/features patch(set)s.
> Quite heat
> discussions in your first reviews drove me crazy really. But all the
> time we
> managed to come up with some consensus somehow. And you never quit
> the
> discussions calmly explaining your point over and over. You never
> refused to
> provide more detailed justification to your requests/comments even
> though you
> didn't have to. Thanks to that I learned how to be patient to
> reviewers
> and reviewees. And of course thank you for the Linux-kernel
> knowledges and all
> the tips and tricks you shared.
>=20
> * Andy, please note due to the situation I am not going to work on my
> DW DMAC
> fixes patchset anymore. So if you ever wish to have DW UART stably
> working with the
> DW DMA-engine driver, then feel free to pick the series up:
> Link:
> https://lore.kernel.org/dmaengine/20240911184710.4207-1-fancer.lancer@gma=
il.com/
>=20
> Linus (Walleij), after you merged one of my pretty much heavy
> patchset in you
> suggested to me to continue the DW APB GPIO driver maintaining. It
> was a first
> time I was asked to maintain a not-my driver. Thank you for the
> trust. I'll
> never forget that.
>=20
> Mark, thank you very much for entrusting the DW APB SSI driver
> maintenance to
> me. I've put a lot of efforts into making it more generic and less
> errors-prune,
> especially when it comes working under a DMA-engine control or
> working in the
> mem-ops mode. I am sure the results have been beneficial to a lot of
> DW
> SPI-controller users since then.
>=20
> Damien, our first and last meeting was at my generic AHCI-platform
> and DW AHCI
> SATA driver patches review. You didn't make it a quick and easy path.
> But still
> all the reviews comments were purely on the technical basis, and the
> patches
> were eventually merged in. Thank you for your time and experience
> I've got from
> the reviews.
>=20
> Paul, Thomas, Arnd, Jiaxun, we met several times in the mailing list
> during my
> MIPS P5600 patches and just generic MIPS patches review. It was
> always a
> pleasure to discuss the matters with such brilliant experts in the
> field. Alas
> I've spent too much time working on the patches for another
> subsystems and
> failed to submit all the MIPS-related bits. Sorry I didn't keep my
> promise, but
> as you can see the circumstances have suddenly drawn its own
> deadline.
>=20
> Bjorn, Mani, we were working quite a lot with you in the framework of
> the DW
> PCIe RC drivers. You reviewed my patches. I helped you to review
> another patches
> for some time. Despite of some arguing it was always a pleasure to
> work with
> you.=C2=A0 Mani, special thanks for the cooperative DW eDMA driver
> maintenance. I
> think we were doing a great work together.
>=20
> Paolo, Jakub, David, Andrew, Vladimir, Russell. The network subsystem
> and
> particularly the STMMAC driver (no doubt the driver sucks) have
> turned to be a
> kind of obstacle on which my current Linux-kernel activity has
> stopped. I really
> hope that at least in some way my help with the incoming STMMAC and
> DW XPCS
> patches reviews lightened up your maintainance duty. I know Russell
> might
> disagree, but I honestly think that all our discussions were useful
> after all,
> at least for me. I also think we did a great work working together
> with Russell
> on the DW GMAC/QoS ETH PCS patches. Hopefully you'll find a time to
> finish it up
> after all.=20
>=20
> Rob, Krzysztof, from your reviews I've learned a lot about the most
> hardwary part
> of the kernel - DT sources and DT-bindings. All your comments have
> been laconic
> and straight to the point. That made reviews quick and easy. Thank
> you very
> much for that.
>=20
> Guenter, special thanks for reviewing and accepting my patches to the
> hwmon and
> watchdog subsystems. It was pleasure to be working with you.
>=20
> Borislav, we disagreed and argued a lot. So my DW uMCTL2 DDRC EDAC
> patches even
> got stuck in limbo for quite a long time. Anyway thank you for the
> time
> you spent reviewing my patches and trying to explain your point.
>=20
> * Borislav, it looks like I won't be able to work on my Synopsys EDAC
> patchsets
> anymore. If you or somebody else could pick them up and finish up the
> work it
> would be great (you can find it in the lore archive). The patches
> convert the
> mainly Zynq(MP)-specific Synopsys EDAC driver to supporting the
> generic DW
> uMCTL2 DDRC. It would be very beneficial for each platform based on
> that
> controller.
>=20
> Greg, we met several times in the mailing lists. You reviewed my
> patches sent
> for the USB and TTY subsystems, and all the time the process was
> straight,
> highly professional, and simpler than in the most of my other case.
> Thank you very much for that.
>=20
> Yoshihiro, Keguang, Yanteng, Kory, Cai and everybody I was lucky to
> meet in the
> kernel mailing lists, but forgot to mention here. Thank you for the
> time spent
> for our cooperative work on making the Linux kernel better. It was a
> pleasure to
> meet you here.
>=20
> I also wish to say huge thanks to the community members trying to
> defend the kicked off maintainers and for support you expressed in
> these days. It means a lot.
>=20
> A little bit statics of my kernel-work at the end:
>=20
> Signed-off patches:		518
> Reviewed and Acked patches:	253
> Tested patches:			80
>=20
> You might say not the greatest achievement for seven years comparing
> to some
> other developers. Perhaps. But I meant each of these tags, be sure.
>=20
> I guess that's it. If you ever need some info or consultation
> regarding the
> drivers I used to maintain or the respective hardware or the Synopsys
> IP-cores
> (about which I've got quite comprehensive knowledge by this time),
> feel free to
> reach me out via this email. I am always willing to help to the
> community
> members.
>=20
> Hope we'll meet someday in more pleasant circumstances and drink a
> couple or more beers together. But now it's time to say good bye.
> Sorry for a long-read text. I wish good luck on your Linux-way.
>=20
> Best Regards,
> -Serge(y)
>=20


