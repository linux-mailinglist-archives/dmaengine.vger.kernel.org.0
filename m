Return-Path: <dmaengine+bounces-3454-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC59ADADD
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 06:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01911F22624
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 04:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C6916D9B8;
	Thu, 24 Oct 2024 04:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KELBS9vy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6032C8E;
	Thu, 24 Oct 2024 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744073; cv=none; b=uGxiur0Mzj8ZVHgGh5VTDdl+wXEYBUQLM748F9bnsLR7OI9BDPdPakFs76jPjgbz/WOAwkeAf3nHoyoAgHB1oOtShXiEMQRhtd7mzsn/yvXXxP5XfUck8GrMY0XpxOG0EEfKU7KocJ783o2lsZVBSQ2tw4OGZYDgf7iCjTbfcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744073; c=relaxed/simple;
	bh=udiji3e41S/dEoTtioHNHBTyRBA79emtkJvqRGsL3OU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m5z3THrshSel4bVqVUa1NvcqTnlwKg5YbZbtN/eV/6itBbVA85YNg3IYYxyxPiNzAn7Tagu9mH1wgdgCRYCHBbh8RY2clnJmvCPsw0guKwA5JUEz8URxgKPUljT47AT81u8PCGw2Rj+bBjwCeHnpZOTLfTuWf6+EbtK0Zp7SvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KELBS9vy; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so6112501fa.0;
        Wed, 23 Oct 2024 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729744068; x=1730348868; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ryd5TahOZqM0bMgqhyVoGsVt3QmLd20VHwwITcjUN10=;
        b=KELBS9vy2/ffctdRIjygycThxNzugvm8XkII4xcsGAOBK+01LbKULS+DhB91OAqzCH
         JO0m+QX1PaFh9OvfJpMILn3bW5R4ooCJX66WLDRy7jOrZZVUgYK5WEc93ZwSWzNgS9kQ
         JuvcP+36itfvjASxk3qN8jGyAdHNb/HlBg+/zIDb/GzWnMjqGgLRjyblemi8RJkGEgTA
         JvFJMpgoN6U46OL57jEMYOdLcJjR/cMCj0a1epEeH7Yt+1M72dmXXWCAikiTN9b/SWQl
         Dy/dJ6sH24zcO1/RyiFVcBRfm8CMpu3W8LE4ZZDWzYsuRR0Lk5eAM9xQJfva12bFYDre
         xhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729744068; x=1730348868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ryd5TahOZqM0bMgqhyVoGsVt3QmLd20VHwwITcjUN10=;
        b=VLUDGR+lKlV3upQpRWAHJj9EKEeTZ2c9TYDcZXiXUn0iXIb/l1bprNv3lTzAHErvWg
         hka+Qz5HBbhBunzKqxjbDoNQfKPEXYIm6SDJib2PmUeaUevMr1HVS8ox08IgsDdByJFH
         kmfNXGnemfEKSLfUHcC3nIbDAyVtv9Kl+0DIpHbOMIiDJktzBhffz3as8+vuWTaMfjKV
         zJHMz6/ILP5qpJlxXLiEoqBAkckg0HB9gldMEaNVQm9MrVN6SsvMTTLgWp8fxmSRVveY
         kRotdZkfkzO5gjj26CfZqavZVYYC83eouXzsPzhtLzl6tZxKdUkFsUAIZAWJSdm2b/w7
         B5gg==
X-Forwarded-Encrypted: i=1; AJvYcCUCo6kw4pS341+sVhv1SSELYZp6tx9CncWkjmFRefjxXM7fpeJnbMUWcWR7DbZjJDFq0xNTYy5FU11U@vger.kernel.org, AJvYcCUmVyJqbVAA73pkqK6rr3Bm6vnHxMjc65dqYmc7/WEa1br7Rbr6mzwd9uMUFEVXlpuAR2HKs3LCkVEhgQ==@vger.kernel.org, AJvYcCV2hlAWBqJured7JRRK+vINRwZ9/g4DpXhP8Vdpr5S2jXmdhYauBFTcIdbeqkg0w7T0oq7Q4eFlrIAQ4WOa@vger.kernel.org, AJvYcCV46L9/yz/tNTywQOhZwjc920TPgDK58ny3z73Kr2vXO6aQtyOChwhVCEbgzrBsPwEn4FcqZHK09tm0@vger.kernel.org, AJvYcCVGqbNqqg+gZQu8Ry2pINh0eqFibBW2XkO75M55sZDak8AGcNy1m7k6JEVUPvSeUmKV8K7/9tEq@vger.kernel.org, AJvYcCVeMv2uPLu+AfQtzgA+RrWq2oPUueMkgefC0rWdGoOwPHVRKUFAROf8bo2Pfh+V6gdonsBLDJU3Wy7r@vger.kernel.org, AJvYcCVoPQ305ABeSYI6Fdd0xxsdzuAhVdLSFkOjEuSjsRyBgbwn0hUnZCpdMXbv7Id7rRCgX0AfO/AD0RV5cw==@vger.kernel.org, AJvYcCVv2iqEpq4o96MIbFoNfHYAW7LdjwbC0vHWFj1SIvAbAejJN15ZSFI/+Ru1arKt/p0Z2n26jlV0nAmwKfuX@vger.kernel.org, AJvYcCVy+H8LHl0C47RuidJRyGZWXESL74qlpweGK3CTJ0ZqB1YwEPRZUw+SwLB9WMOyZKU5pd+HutZGpJML00JPVxfzI7o=@vger.kernel.org, AJvYcCX9UcGhhjoX6OiG1giEXt3B
 pYYvP8HGUXl4hRzIlwZhaJGiAp0Qxe3/TGqjydClSG/Be2TL3pSVMJh+iT4=@vger.kernel.org, AJvYcCXYrNXX5ZuhBm7TBZlrGxKqVB+ZKNWihq32JLAWOOiru/2TJjmhHVvVRSX+nrqga/U0HHVT/Z+fXxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uu8uFaAJhTHJTpyAU5LQj5qlrruIv4W1Y8wGiQ6tbatbF7AK
	qUP6pFiUVAUvee7ZSVQbjrc4UtB1pVPkGt9pyC96xfeV5zHj6hQE
X-Google-Smtp-Source: AGHT+IHZKxth9EOfqbWIOdrXsG+AxCKWQsu8nuoHzE9Doq8P4mdvScM2YJyFjW8FpHm5SXynKLpdUw==
X-Received: by 2002:a05:6512:350e:b0:53b:1e70:6ab4 with SMTP id 2adb3069b0e04-53b1e706b9fmr2494138e87.14.1729744067950;
        Wed, 23 Oct 2024 21:27:47 -0700 (PDT)
Received: from mobilestation ([85.249.18.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224319a7sm1242740e87.230.2024.10.23.21.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:27:47 -0700 (PDT)
Date: Thu, 24 Oct 2024 07:27:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, Andy Shevchenko <andy@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	Paul Burton <paulburton@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Russell King <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Yanteng Si <siyanteng@loongson.cn>, netdev@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	linux-edac@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-serial@vger.kernel.org
Cc: Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
	Nikita Shubin <nikita.shubin@maquefel.me>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: linux: Goodbye from a Linux community volunteer
Message-ID: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linux-kernel community,

I am sure you have already heard the news caused by the recent Greg' commit
6e90b675cf942e ("MAINTAINERS: Remove some entries due to various compliance
requirements."). As you may have noticed the change concerned some of the
Ru-related developers removal from the list of the official kernel maintainers,
including me.

The community members rightly noted that the _quite_ short commit log contained
very vague terms with no explicit change justification. No matter how hard I
tried to get more details about the reason, alas the senior maintainer I was
discussing the matter with haven't given an explanation to what compliance
requirements that was. I won't cite the exact emails text since it was a private
messaging, but the key words are "sanctions", "sorry", "nothing I can do", "talk
to your (company) lawyer"... I can't say for all the guys affected by the
change, but my work for the community has been purely _volunteer_ for more than
a year now (and less than half of it had been payable before that). For that
reason I have no any (company) lawyer to talk to, and honestly after the way the
patch has been merged in I don't really want to now. Silently, behind everyone's
back, _bypassing_ the standard patch-review process, with no affected
developers/subsystem notified - it's indeed the worse way to do what has been
done. No gratitude, no credits to the developers for all these years of the
devoted work for the community. No matter the reason of the situation but
haven't we deserved more than that? Adding to the GREDITS file at least, no?..

I can't believe the kernel senior maintainers didn't consider that the patch
wouldn't go unnoticed, and the situation might get out of control with
unpredictable results for the community, if not straight away then in the middle
or long term perspective. I am sure there have been plenty ways to solve the
problem less harmfully, but they decided to take the easiest path. Alas what's
done is done. A bifurcation point slightly initiated a year ago has just been
fully implemented. The reason of the situation is obviously in the political
ground which in this case surely shatters a basement the community has been built
on in the first place. If so then God knows what might be next (who else might
be sanctioned...), but the implemented move clearly sends a bad signal to the
Linux community new comers, to the already working volunteers and hobbyists like
me.

Thus even if it was still possible for me to send patches or perform some
reviews, after what has been done my motivation to do that as a volunteer has
simply vanished. (I might be doing a commercial upstreaming in future though).
But before saying goodbye I'd like to express my gratitude to all the community
members I have been lucky to work with during all these years. Specifically:

NTB-folks, Jon, Dave, Allen. NTB was my starting point in the kernel upstream
work. Thanks for the initial advices and despite of very-very-very tough reviews
with several complete patchset refactorings, I learned a lot back then. That
experience helped me afterwards. Thanks a lot for that. BTW since then I've got
several thank-you letters for the IDT NTB and IDT EEPROM drivers. If not for you
it wouldn't have been possible.

Andy, it's hard to remember who else would have given me more on my Linux kernel
journey as you have. We first met in the I2C subsystem review of my DW I2C
driver patches. Afterwards we've got to be frequently meeting here and there -
GPIO, SPI, TTY, DMA, NET, etc, clean/fixes/features patch(set)s. Quite heat
discussions in your first reviews drove me crazy really. But all the time we
managed to come up with some consensus somehow. And you never quit the
discussions calmly explaining your point over and over. You never refused to
provide more detailed justification to your requests/comments even though you
didn't have to. Thanks to that I learned how to be patient to reviewers
and reviewees. And of course thank you for the Linux-kernel knowledges and all
the tips and tricks you shared.

* Andy, please note due to the situation I am not going to work on my DW DMAC
fixes patchset anymore. So if you ever wish to have DW UART stably working with the
DW DMA-engine driver, then feel free to pick the series up:
Link: https://lore.kernel.org/dmaengine/20240911184710.4207-1-fancer.lancer@gmail.com/

Linus (Walleij), after you merged one of my pretty much heavy patchset in you
suggested to me to continue the DW APB GPIO driver maintaining. It was a first
time I was asked to maintain a not-my driver. Thank you for the trust. I'll
never forget that.

Mark, thank you very much for entrusting the DW APB SSI driver maintenance to
me. I've put a lot of efforts into making it more generic and less errors-prune,
especially when it comes working under a DMA-engine control or working in the
mem-ops mode. I am sure the results have been beneficial to a lot of DW
SPI-controller users since then.

Damien, our first and last meeting was at my generic AHCI-platform and DW AHCI
SATA driver patches review. You didn't make it a quick and easy path. But still
all the reviews comments were purely on the technical basis, and the patches
were eventually merged in. Thank you for your time and experience I've got from
the reviews.

Paul, Thomas, Arnd, Jiaxun, we met several times in the mailing list during my
MIPS P5600 patches and just generic MIPS patches review. It was always a
pleasure to discuss the matters with such brilliant experts in the field. Alas
I've spent too much time working on the patches for another subsystems and
failed to submit all the MIPS-related bits. Sorry I didn't keep my promise, but
as you can see the circumstances have suddenly drawn its own deadline.

Bjorn, Mani, we were working quite a lot with you in the framework of the DW
PCIe RC drivers. You reviewed my patches. I helped you to review another patches
for some time. Despite of some arguing it was always a pleasure to work with
you.  Mani, special thanks for the cooperative DW eDMA driver maintenance. I
think we were doing a great work together.

Paolo, Jakub, David, Andrew, Vladimir, Russell. The network subsystem and
particularly the STMMAC driver (no doubt the driver sucks) have turned to be a
kind of obstacle on which my current Linux-kernel activity has stopped. I really
hope that at least in some way my help with the incoming STMMAC and DW XPCS
patches reviews lightened up your maintainance duty. I know Russell might
disagree, but I honestly think that all our discussions were useful after all,
at least for me. I also think we did a great work working together with Russell
on the DW GMAC/QoS ETH PCS patches. Hopefully you'll find a time to finish it up
after all. 

Rob, Krzysztof, from your reviews I've learned a lot about the most hardwary part
of the kernel - DT sources and DT-bindings. All your comments have been laconic
and straight to the point. That made reviews quick and easy. Thank you very
much for that.

Guenter, special thanks for reviewing and accepting my patches to the hwmon and
watchdog subsystems. It was pleasure to be working with you.

Borislav, we disagreed and argued a lot. So my DW uMCTL2 DDRC EDAC patches even
got stuck in limbo for quite a long time. Anyway thank you for the time
you spent reviewing my patches and trying to explain your point.

* Borislav, it looks like I won't be able to work on my Synopsys EDAC patchsets
anymore. If you or somebody else could pick them up and finish up the work it
would be great (you can find it in the lore archive). The patches convert the
mainly Zynq(MP)-specific Synopsys EDAC driver to supporting the generic DW
uMCTL2 DDRC. It would be very beneficial for each platform based on that
controller.

Greg, we met several times in the mailing lists. You reviewed my patches sent
for the USB and TTY subsystems, and all the time the process was straight,
highly professional, and simpler than in the most of my other case.
Thank you very much for that.

Yoshihiro, Keguang, Yanteng, Kory, Cai and everybody I was lucky to meet in the
kernel mailing lists, but forgot to mention here. Thank you for the time spent
for our cooperative work on making the Linux kernel better. It was a pleasure to
meet you here.

I also wish to say huge thanks to the community members trying to
defend the kicked off maintainers and for support you expressed in
these days. It means a lot.

A little bit statics of my kernel-work at the end:

Signed-off patches:		518
Reviewed and Acked patches:	253
Tested patches:			80

You might say not the greatest achievement for seven years comparing to some
other developers. Perhaps. But I meant each of these tags, be sure.

I guess that's it. If you ever need some info or consultation regarding the
drivers I used to maintain or the respective hardware or the Synopsys IP-cores
(about which I've got quite comprehensive knowledge by this time), feel free to
reach me out via this email. I am always willing to help to the community
members.

Hope we'll meet someday in more pleasant circumstances and drink a
couple or more beers together. But now it's time to say good bye.
Sorry for a long-read text. I wish good luck on your Linux-way.

Best Regards,
-Serge(y)

