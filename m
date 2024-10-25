Return-Path: <dmaengine+bounces-3564-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 760FE9AFA4C
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 08:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A7FB2173F
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB518F2C3;
	Fri, 25 Oct 2024 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFreg6s8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCEC175D5D;
	Fri, 25 Oct 2024 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838929; cv=none; b=OR8MHSAOcMTgEJ5zksC2oLSNOJLsG7FmkM4vImCyd8ji0ha44bgCVfe7RMeNzKva72vZ3WFTLJa0fMFfi/c/3XmApF2gwA3XKglkd4MDXQqLkImmp/95TdgIJengXiLXfVMkaSBqzCw8rbABdMHV0LRQpdoRRUjbKJOu12EWyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838929; c=relaxed/simple;
	bh=rT5dHMGisDACs8x9W+qUF5G6QkagBlu7lRPcVPpr/pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0wPg10NUsRY9MBKPLeZAlbYaAw8SVrpmHwPwTFXtj0X42Cn242H1cO+FPLl+QbAeV6RRx1Kc6VNaHIUvjCW3Oay9YlfhPHdMZ8hOT/0aOMGKh787fpDRCXLpba9IJhoIivste0abnCYdSM8MArVnK8bYqYnTrIM+/Mngr3Pkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFreg6s8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46098928354so10062961cf.1;
        Thu, 24 Oct 2024 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729838925; x=1730443725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfEm4Orygq8P16EaWOu5ZmrjwuM/R7saAJNrpndbXkk=;
        b=CFreg6s8vdyHqBn4NOztbFLOMkRobdxSndAuoM08tkT+qEujivTj1/wy4S/48fEYQm
         s17ICl9dR3o+1H6c3+xP3UQWkadcZtKijdfxQBMTI3CRZOxTTYRg4m7TJdj8jlr9Ml/u
         7gjv+aWMLyJ9QmZdYHUQ/F0YRyFjlSafh4xbplY0UqF4UeKZF4WCSq2abLR99yd98cAd
         n6tOLLAJ4VLpG6VBcrbhVCwHBH45749BGXnCrT5/6gVXnbSriUCm8e01CyziPg2ewity
         6L/S3TjVky6MTOjzciCfXiSYxMsupJLr3TvvJvg664xjHXWXXPTIQ3Hgnr2tLMjMm+NV
         xQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729838925; x=1730443725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfEm4Orygq8P16EaWOu5ZmrjwuM/R7saAJNrpndbXkk=;
        b=HWJr+7n3cq6Z8oQp5zLg1fvbtVaagzsfiHT+DS7MhY/1a+UwiZVJ1+Kt/K2sHavFeG
         bU433cENdGgJHoN6oZHnYTZSySzgHwVGxtWAd9LeYkGhzj75ViP1jsyV/cerT8QlyAyh
         1+NMVAhvzxZ1PB2jWA3OtPvQDlCM+SpA6E2emLHV6awWU7/P0qRSKlzjjTupJEOaOZoT
         nkttQiykQ7zSBjAii5fqxi/XZfpIzPWJpIo4PyOuiUSn6Ezk9dhTHn8lHmVwbA7urnfO
         CnQa1hE9uy0KTLHPj1FmHtSId8wPL5Fk2DDbIJrHOWbx1/1eS0xvsdos1kSOQRX5UifK
         VkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfI4XfGgRsNwisuzW8uO7vOoIfZnmDeD0IlpivJWUqC1e0WrfOGxU0cgo2HOSXapgVH1kAjLkmIxly@vger.kernel.org, AJvYcCUfegjej0B3L4W5TzWRoNRm6CHYF4eWcm0MFBdKZtJG6lXQIGt2JdPvVRlBtK6u4thVziiY95AQ177iI70=@vger.kernel.org, AJvYcCUnd/Tr6v6AtP9iJ46UP+QqxHz/4GW+pvneEOu7vp0u5/o2DDspL6q//QPaoxO2hC0cxcUo3LW+rhY=@vger.kernel.org, AJvYcCV52lksJS7X0hUS5LUJqoYG8caHE51w5w8QYbRQF7MR50MqVi0MyPkjnCWxdUcGfD4UiilZyPsGK+HBYBVn@vger.kernel.org, AJvYcCVYO/n5Hn6J8zZpQm5Hfn5bNY4B+LzCXML9skVacYi4RISBSX30y/JyDb4yeAlGgPasdJtdKndokhpahA==@vger.kernel.org, AJvYcCVe/bKyxhkgtNdItUdQ/l8wVOvOeZ3o4v78Efhd+wIPB157ph5FX7z+Pei3h4PyENwGFbGwVIRdCL9fREH+twr/QeQ=@vger.kernel.org, AJvYcCW6akd+rfAmhk6+UwP24CxdNkUxOttW2iOqIxflPK7AWVlIrP4oCNxNVNDBDbYW7w1SJozrc23YpLqv@vger.kernel.org, AJvYcCWFWEdj99Gia8C3nW5TVO8v5+RGN/oLZq398r3kTde9a+U2Qk7JfZ6yJhlKbe+I6Uu+w04MqP1Y@vger.kernel.org, AJvYcCWVpoWrA4924e8YSkwxLbt6ONOUISQrVCn/3NkmaodkUx3W/LDTPoW5ox0d6yUvoiH6cmTix0YFD5vTsw==@vger.kernel.org, AJvYcCWgAMJMK06RHgd2lArQ1PTL
 BkBn4Mzrflvj5LpG44CrzoeId41sdooZNzWdGh7XhU9bB931mZ119Ez8@vger.kernel.org, AJvYcCWpy+9N1PSL7Eey9IF4rlWozB33UZTVljbTvsJDexkcaj2HmoGjD0OHPTDl2bSIpJ0X7+/UYnVCAJmFzNES@vger.kernel.org
X-Gm-Message-State: AOJu0YxypZUJRwfvE5dN5dIt+a6eUSa+tB0mKWY7wPrHGwaVC5HOTA2F
	WcvxJbgSCCg6Mme0GWJ1A/mI4CIfSbsDuy6/URC8k48cEzmlrwAY
X-Google-Smtp-Source: AGHT+IFY7kDEYtIH955Gm/ASIqZqwLSOcs7sDze2JR0lBp/ONGT64BNCEqpbS+natQ53n0mFjctTWQ==
X-Received: by 2002:a05:622a:1a1d:b0:460:aeb4:b616 with SMTP id d75a77b69052e-461145c3028mr95596681cf.18.1729838925034;
        Thu, 24 Oct 2024 23:48:45 -0700 (PDT)
Received: from ?IPV6:2607:fea8:2221:b500::40b7? ([2607:fea8:2221:b500::40b7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613237456esm2843541cf.77.2024.10.24.23.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 23:48:44 -0700 (PDT)
Message-ID: <bc76cf64-6b29-4815-bf4b-20afc43cdf35@gmail.com>
Date: Fri, 25 Oct 2024 02:48:36 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>,
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
 linux-edac@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org
Cc: Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Content-Language: en-US
From: Khalil Fazal <spare.khalil@gmail.com>
In-Reply-To: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Serge,

I'm really angry that it has come to this.
Fuck the fascists for bullying the Russians from the community.
I'm just a regular end user who has been using Linux for 17 years.
I was born in 1991, the same year the kernel was created.
This is so fucking disgusting.

Lots of love, in solidarity,

Khalil from Toronto, Canada

On 2024-10-24 00:27, Serge Semin wrote:
> Hello Linux-kernel community,
>
> I am sure you have already heard the news caused by the recent Greg' commit
> 6e90b675cf942e ("MAINTAINERS: Remove some entries due to various compliance
> requirements."). As you may have noticed the change concerned some of the
> Ru-related developers removal from the list of the official kernel maintainers,
> including me.
>
> The community members rightly noted that the _quite_ short commit log contained
> very vague terms with no explicit change justification. No matter how hard I
> tried to get more details about the reason, alas the senior maintainer I was
> discussing the matter with haven't given an explanation to what compliance
> requirements that was. I won't cite the exact emails text since it was a private
> messaging, but the key words are "sanctions", "sorry", "nothing I can do", "talk
> to your (company) lawyer"... I can't say for all the guys affected by the
> change, but my work for the community has been purely _volunteer_ for more than
> a year now (and less than half of it had been payable before that). For that
> reason I have no any (company) lawyer to talk to, and honestly after the way the
> patch has been merged in I don't really want to now. Silently, behind everyone's
> back, _bypassing_ the standard patch-review process, with no affected
> developers/subsystem notified - it's indeed the worse way to do what has been
> done. No gratitude, no credits to the developers for all these years of the
> devoted work for the community. No matter the reason of the situation but
> haven't we deserved more than that? Adding to the GREDITS file at least, no?..
>
> I can't believe the kernel senior maintainers didn't consider that the patch
> wouldn't go unnoticed, and the situation might get out of control with
> unpredictable results for the community, if not straight away then in the middle
> or long term perspective. I am sure there have been plenty ways to solve the
> problem less harmfully, but they decided to take the easiest path. Alas what's
> done is done. A bifurcation point slightly initiated a year ago has just been
> fully implemented. The reason of the situation is obviously in the political
> ground which in this case surely shatters a basement the community has been built
> on in the first place. If so then God knows what might be next (who else might
> be sanctioned...), but the implemented move clearly sends a bad signal to the
> Linux community new comers, to the already working volunteers and hobbyists like
> me.
>
> Thus even if it was still possible for me to send patches or perform some
> reviews, after what has been done my motivation to do that as a volunteer has
> simply vanished. (I might be doing a commercial upstreaming in future though).
> But before saying goodbye I'd like to express my gratitude to all the community
> members I have been lucky to work with during all these years. Specifically:
>
> NTB-folks, Jon, Dave, Allen. NTB was my starting point in the kernel upstream
> work. Thanks for the initial advices and despite of very-very-very tough reviews
> with several complete patchset refactorings, I learned a lot back then. That
> experience helped me afterwards. Thanks a lot for that. BTW since then I've got
> several thank-you letters for the IDT NTB and IDT EEPROM drivers. If not for you
> it wouldn't have been possible.
>
> Andy, it's hard to remember who else would have given me more on my Linux kernel
> journey as you have. We first met in the I2C subsystem review of my DW I2C
> driver patches. Afterwards we've got to be frequently meeting here and there -
> GPIO, SPI, TTY, DMA, NET, etc, clean/fixes/features patch(set)s. Quite heat
> discussions in your first reviews drove me crazy really. But all the time we
> managed to come up with some consensus somehow. And you never quit the
> discussions calmly explaining your point over and over. You never refused to
> provide more detailed justification to your requests/comments even though you
> didn't have to. Thanks to that I learned how to be patient to reviewers
> and reviewees. And of course thank you for the Linux-kernel knowledges and all
> the tips and tricks you shared.
>
> * Andy, please note due to the situation I am not going to work on my DW DMAC
> fixes patchset anymore. So if you ever wish to have DW UART stably working with the
> DW DMA-engine driver, then feel free to pick the series up:
> Link: https://lore.kernel.org/dmaengine/20240911184710.4207-1-fancer.lancer@gmail.com/
>
> Linus (Walleij), after you merged one of my pretty much heavy patchset in you
> suggested to me to continue the DW APB GPIO driver maintaining. It was a first
> time I was asked to maintain a not-my driver. Thank you for the trust. I'll
> never forget that.
>
> Mark, thank you very much for entrusting the DW APB SSI driver maintenance to
> me. I've put a lot of efforts into making it more generic and less errors-prune,
> especially when it comes working under a DMA-engine control or working in the
> mem-ops mode. I am sure the results have been beneficial to a lot of DW
> SPI-controller users since then.
>
> Damien, our first and last meeting was at my generic AHCI-platform and DW AHCI
> SATA driver patches review. You didn't make it a quick and easy path. But still
> all the reviews comments were purely on the technical basis, and the patches
> were eventually merged in. Thank you for your time and experience I've got from
> the reviews.
>
> Paul, Thomas, Arnd, Jiaxun, we met several times in the mailing list during my
> MIPS P5600 patches and just generic MIPS patches review. It was always a
> pleasure to discuss the matters with such brilliant experts in the field. Alas
> I've spent too much time working on the patches for another subsystems and
> failed to submit all the MIPS-related bits. Sorry I didn't keep my promise, but
> as you can see the circumstances have suddenly drawn its own deadline.
>
> Bjorn, Mani, we were working quite a lot with you in the framework of the DW
> PCIe RC drivers. You reviewed my patches. I helped you to review another patches
> for some time. Despite of some arguing it was always a pleasure to work with
> you.  Mani, special thanks for the cooperative DW eDMA driver maintenance. I
> think we were doing a great work together.
>
> Paolo, Jakub, David, Andrew, Vladimir, Russell. The network subsystem and
> particularly the STMMAC driver (no doubt the driver sucks) have turned to be a
> kind of obstacle on which my current Linux-kernel activity has stopped. I really
> hope that at least in some way my help with the incoming STMMAC and DW XPCS
> patches reviews lightened up your maintainance duty. I know Russell might
> disagree, but I honestly think that all our discussions were useful after all,
> at least for me. I also think we did a great work working together with Russell
> on the DW GMAC/QoS ETH PCS patches. Hopefully you'll find a time to finish it up
> after all.
>
> Rob, Krzysztof, from your reviews I've learned a lot about the most hardwary part
> of the kernel - DT sources and DT-bindings. All your comments have been laconic
> and straight to the point. That made reviews quick and easy. Thank you very
> much for that.
>
> Guenter, special thanks for reviewing and accepting my patches to the hwmon and
> watchdog subsystems. It was pleasure to be working with you.
>
> Borislav, we disagreed and argued a lot. So my DW uMCTL2 DDRC EDAC patches even
> got stuck in limbo for quite a long time. Anyway thank you for the time
> you spent reviewing my patches and trying to explain your point.
>
> * Borislav, it looks like I won't be able to work on my Synopsys EDAC patchsets
> anymore. If you or somebody else could pick them up and finish up the work it
> would be great (you can find it in the lore archive). The patches convert the
> mainly Zynq(MP)-specific Synopsys EDAC driver to supporting the generic DW
> uMCTL2 DDRC. It would be very beneficial for each platform based on that
> controller.
>
> Greg, we met several times in the mailing lists. You reviewed my patches sent
> for the USB and TTY subsystems, and all the time the process was straight,
> highly professional, and simpler than in the most of my other case.
> Thank you very much for that.
>
> Yoshihiro, Keguang, Yanteng, Kory, Cai and everybody I was lucky to meet in the
> kernel mailing lists, but forgot to mention here. Thank you for the time spent
> for our cooperative work on making the Linux kernel better. It was a pleasure to
> meet you here.
>
> I also wish to say huge thanks to the community members trying to
> defend the kicked off maintainers and for support you expressed in
> these days. It means a lot.
>
> A little bit statics of my kernel-work at the end:
>
> Signed-off patches:		518
> Reviewed and Acked patches:	253
> Tested patches:			80
>
> You might say not the greatest achievement for seven years comparing to some
> other developers. Perhaps. But I meant each of these tags, be sure.
>
> I guess that's it. If you ever need some info or consultation regarding the
> drivers I used to maintain or the respective hardware or the Synopsys IP-cores
> (about which I've got quite comprehensive knowledge by this time), feel free to
> reach me out via this email. I am always willing to help to the community
> members.
>
> Hope we'll meet someday in more pleasant circumstances and drink a
> couple or more beers together. But now it's time to say good bye.
> Sorry for a long-read text. I wish good luck on your Linux-way.
>
> Best Regards,
> -Serge(y)
>

