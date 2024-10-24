Return-Path: <dmaengine+bounces-3484-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914E9AECDB
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD94A1C22FF0
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371081F9EAB;
	Thu, 24 Oct 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdRrAud4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95A1F8920;
	Thu, 24 Oct 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789125; cv=none; b=uwRDB8gQIlo3x5D8qDL1jFQWoRbNGG60NJsft5H0823WzbcKZdB6wNN5vxVeww6Hxkl/1Pg+CdAdh3yyCyGoairGo7wHyhu5EAer7fDvOt3J+/m/INkY1lXGQaNG3J6dFhDgDqVD5MkmAHsAfQIZW32z67FMq/ZfCF329mEZsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789125; c=relaxed/simple;
	bh=LQUqq41rKKi2DZ6ziCnRzGqwgHnRtqlW6CGDMmHRRV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGQrBwInP+7O6ZC04BeGBenD9agI/00MRmAD/858NYwn1Hw6qefFKkwusvioK745UQTx0fmpW5jjHJd4PIkx1W8WXFfilymkgzcZNXohV+SnXQ25Kmp1brADGXlsRCBZ3DT4Tim+iieHtM4u2qyZ8zG5vfb9vzWgqEYuhVr6bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdRrAud4; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so789336a12.0;
        Thu, 24 Oct 2024 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729789122; x=1730393922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfJ8p+8q2+xxwuBNnMevVX62Z8jej5Rz7JLXYkmoeTk=;
        b=GdRrAud4sBuMip099zZ1gjZUCAcpFpVaf6tUQmzZiB+fqLRR9sWZcb3ta3oMj2CiwY
         TV4qbu6vYPrZsCnoSTsTV2RmTrBAG1uZ0TP4ioCKkF+Z6KYlIsGQH5UuZCQ1L/TASDEh
         eUKVB927Xn5mzBkRVawsCap+F2hQ5UhaVPOYhdt0mulXUclspSdwlLLNP3LHQxmHiLQe
         YFG7mc54BLSYfJtcWt1HrhKUHyn+Krz7HOXtSXiACkumDZ0EXQ/lo601sIOIj9EzNWv8
         3d2e6LoC/BiHj1Vi0J3FyTJ7+8m++t2/++JKtONXHcmN0LgiRKOGHikuV30EjZyOePvy
         0r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789122; x=1730393922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfJ8p+8q2+xxwuBNnMevVX62Z8jej5Rz7JLXYkmoeTk=;
        b=hOQ2ukPUNmh8YIr7LBkmwc3CYEdxpSn7WAO2Nc8riIteEgG3KbGVNWoyR3AduwjvGk
         8S4YusAzwX4Lp7kvLgF0E8l04Xg50flTChmwoSe5CxeHVh8qCg6RtFHMZiEmhyKrefeN
         aIuodW9ON2FIrIa5gCdk4vk3Gk8A6ZCw1TEWSlQ5XfqaFcxd4x1iz7ps7tnaHDTaZkUi
         s3SwQF3Vbk4F3fSsfhPwZR6/ZLOfAtXe0vq/wuLCZZMatBAQib0+nwBGyvMGANLZxhky
         H1fUPG7KhSP/7SQAhLp4J3hIK7on2ly0cE4d5jACehwEt95Bn++DtJ92l9XeGPOwsWOC
         giCA==
X-Forwarded-Encrypted: i=1; AJvYcCUKiGZ96egjcbAUQDKpmXa1AYRQMsthzWB9PC/aB01BBG04BlU8t30QkntRKGsZ1TP3vxP3daZD@vger.kernel.org, AJvYcCUhAdcCLRe9ev1/BvD4IfTM3Ul+Od0QLT7yQCPph/VyTxiohVv2d9Mz5pJPr/NAsLP7IzbVDSqOYOc=@vger.kernel.org, AJvYcCUk05f0jIdFIIWoZWALXr9PcPuS4JHc+28ZX2XF2YO8b5hxOhjxsNwT/JRbZ2QwF7COSNkROuVg1+9m@vger.kernel.org, AJvYcCVgHb6MZvwJoATLBipaEwXFZ3URjzSF4uijAPp+uu7grjwgKHHnN1pVLDP5tVAkLTHtQupt2XaNrRkVvA==@vger.kernel.org, AJvYcCVyJ6SpKy0/TJ9UIc59nEKSohkryFOqxKbPMM6mvROBq8etqKm44z/TG4Z+fX2sScpm0cUs1PiaupqBFg==@vger.kernel.org, AJvYcCW2MpX+vmo3YYA+4ROsl/lMtdQhdc1ZQURUTFvZkYiNP64aGN90cMavBIGYrgm4bG0420o6GQ+P+VLE3DM=@vger.kernel.org, AJvYcCW5ZMrGyK3ezS8lW7OVIjCkco+PZONEiuMwmivG68imGzXYuY+bNIg0mg6LCzik51YMjCSgn9W6pf2n@vger.kernel.org, AJvYcCWALFz59CqB35Em6cM1//ZoXwoBEbS1PIVHzCKXCtfZhh9Q0MckZrN2b4DDDIPHeTAYFXCqGQdxknL+@vger.kernel.org, AJvYcCWdZUvCC2B4wYBkPn6VBXFMm/MdT67uw85l3/TUFiJ8Ge2GAB+sPl0I2FIQLtYYtXRrPKDLfqyNSMhuSFo4@vger.kernel.org, AJvYcCX6uhRMM17fI/xEG4SElr8UaGwjyiFExqNa
 vztQvB+4Q9GoIC+FC2f1T/f42V2Mgw9qy0ii9VI5u2xDh/pb@vger.kernel.org, AJvYcCX9t8XQzPxCVjCEtf6Nkj6k2+tpWqLtnUgCnO8GqX0d6mFQevHJomF4dpeP26AJt6LMEQ8HQz7GJj//IPqiTkHVPvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQxMY3x2L2mkXje97qUq2p4abElq9M8zu4r1Y3ViuQWHAMKsb
	mE3Vg/KbinLNlppjmmWm6mTFBiE/gvcY44DozzKCUVktPo1HPBeQ
X-Google-Smtp-Source: AGHT+IHkRrL+646WJX5jMNiRVOq7St1d5iL/wDNXUA9UQNOX6Gcj9xqgJzmbGWgDaCdtnMTv+h1KbQ==
X-Received: by 2002:a05:6a21:4a4c:b0:1d9:175a:c2ba with SMTP id adf61e73a8af0-1d978b0245fmr8971311637.20.1729789122186;
        Thu, 24 Oct 2024 09:58:42 -0700 (PDT)
Received: from localhost.localdomain ([240b:4001:20c:6000::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm8203615b3a.46.2024.10.24.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:58:41 -0700 (PDT)
From: Hantong Chen <cxwdyx620@gmail.com>
To: james.bottomley@hansenpartnership.com
Cc: ajhalaney@gmail.com,
	allenbh@gmail.com,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	andy@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	broonie@kernel.org,
	cai.huoqing@linux.dev,
	dave.jiang@intel.com,
	davem@davemloft.net,
	dlemoal@kernel.org,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	ink@jurassic.park.msu.ru,
	jdmason@kudzu.us,
	jiaxun.yang@flygoat.com,
	keguang.zhang@gmail.com,
	kory.maincent@bootlin.com,
	krzk@kernel.org,
	kuba@kernel.org,
	linux-edac@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux@armlinux.org.uk,
	linux@roeck-us.net,
	manivannan.sadhasivam@linaro.org,
	netdev@vger.kernel.org,
	nikita.shubin@maquefel.me,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	olteanv@gmail.com,
	pabeni@redhat.com,
	paulburton@kernel.org,
	robh@kernel.org,
	s.shtylyov@omp.ru,
	sergio.paracuellos@gmail.com,
	shc_work@mail.ru,
	siyanteng@loongson.cn,
	tsbogend@alpha.franken.de,
	xeb@mail.ru,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Date: Thu, 24 Oct 2024 16:56:50 +0000
Message-ID: <20241024165650.174-1-cxwdyx620@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
References: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> If you haven't heard of Russian sanctions yet, you should try to read=0D
> the news some day.  And by "news", I don't mean Russian=0D
> state-sponsored spam.=0D
=0D
> As to sending me a revert patch - please use whatever mush you call=0D
> brains. I'm Finnish. Did you think I'd be *supporting* Russian=0D
> aggression? Apparently it's not just lack of real news, it's lack of=0D
> history knowledge too.=0D
=0D
Hi James,=0D
=0D
Here's what Linus has said, and it's more than just "sanction."=0D
=0D
Moreover, we have to remove any maintainers who come from the following cou=
ntries or regions, as they are listed in *Countries of Particular Concern* =
and are subject to impending sanctions:=0D
=0D
- Burma, People=E2=80=99s Republic of China, Cuba, Eritrea, Iran, the Democ=
ratic People=E2=80=99s Republic of Korea, Nicaragua, Pakistan, Russia, Saud=
i Arabia, Tajikistan, and Turkmenistan.=0D
- Algeria, Azerbaijan, the Central African Republic, Comoros, and Vietnam.=
=0D
=0D
For People=E2=80=99s Republic of China, there are about 500 entities that a=
re on the U.S. OFAC SDN / non-SDN lists, especially HUAWEI, which is one of=
 the most active employers from versions 5.16 through 6.1, according to sta=
tistics. This is unacceptable, and we must take immediate action to address=
 it, with the **same** reason.=0D
=0D
On 10/24/24 10:50 AM, James Bottomley wrote:=0D
> On Thu, 2024-10-24 at 07:27 +0300, Serge Semin wrote:=0D
>> Hello Linux-kernel community,=0D
>>=0D
>> I am sure you have already heard the news caused by the recent Greg'=0D
>> commit 6e90b675cf942e ("MAINTAINERS: Remove some entries due to=0D
>> various compliance requirements."). As you may have noticed the=0D
>> change concerned some of the Ru-related developers removal from the=0D
>> list of the official kernel maintainers, including me.=0D
>>=0D
>> The community members rightly noted that the _quite_ short commit log=0D
>> contained very vague terms with no explicit change justification. No=0D
>> matter how hard I tried to get more details about the reason, alas=0D
>> the senior maintainer I was discussing the matter with haven't given=0D
>> an explanation to what compliance requirements that was.=0D
> =0D
> Please accept all of our apologies for the way this was handled.  A=0D
> summary of the legal advice the kernel is operating under is=0D
> =0D
>     If your company is on the U.S. OFAC SDN lists, subject to an OFAC=0D
>     sanctions program, or owned/controlled by a company on the list, our=
=0D
>     ability to collaborate with you will be subject to restrictions, and=
=0D
>     you cannot be in the MAINTAINERS file.=0D
> =0D
> Anyone who wishes to can query the list here:=0D
> =0D
> https://sanctionssearch.ofac.treas.gov/=0D
> =0D
> In your specific case, the problem is your employer is on that list.=0D
> If there's been a mistake and your employer isn't on the list, that's=0D
> the documentation Greg is looking for.=0D
> =0D
> I would also like to thank you for all your past contributions and if=0D
> you (or anyone else) would like an entry in the credit file, I'm happy=0D
> to shepherd it for you if you send me what you'd like.=0D
> =0D
> Again, we're really sorry it's come to this, but all of the Linux=0D
> infrastructure and a lot of its maintainers are in the US and we can't=0D
> ignore the requirements of US law.  We are hoping that this action=0D
> alone will be sufficient to satisfy the US Treasury department in=0D
> charge of sanctions and we won't also have to remove any existing=0D
> patches.=0D
> =0D
> Regards,=0D
> =0D
> James Bottomley=0D
> =0D

