Return-Path: <dmaengine+bounces-3547-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8D9AF2D7
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 21:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656731C2188C
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942C9189F47;
	Thu, 24 Oct 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQjevexA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E81CF96;
	Thu, 24 Oct 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799232; cv=none; b=FHSB3aP/mpmu/eAdxlv300Q5qXZlHLwv/WDy7q+08gKKqmboH58MrUt7xNvltjWAWDsr1Q2H8PHlBbw3hyDfsllXtflqqTLsKAql9HQAdZJK2sshavXZOh/ZjA9Ya4dy4qSCcIA8XVkulxq8CxKPE+4tq21x0PC0G3NrQ9dBvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799232; c=relaxed/simple;
	bh=lIMOl16Oc+gkmljkhXJFmkCvewir3f7Gjx9L1UYJb1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJVoo2mzBn3T/OKggFGQXk+tMh0g6cuDoFp1PIlSBPoRJ1JCPvmofhyU+HswAxyyONbzQeIUKvwUA6Z0r6mXe4faAjMwtoe04s3BC8f9I14laupZV5t/58oElSVocOvQ4TTwq5NJuYdAyHHeRvyQLUA0RsiTpb8hlQYIHXlrsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQjevexA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e3c0d1ccc6so215582a91.3;
        Thu, 24 Oct 2024 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799230; x=1730404030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lIMOl16Oc+gkmljkhXJFmkCvewir3f7Gjx9L1UYJb1g=;
        b=RQjevexAYGo4XdaqFinIYW7Kwo45vQqwDxBklimIeDDp8zrYeYpy72/LTe0DVBWyWd
         WriqnivJ+RY69cLwJdjy3xklHZ/9B8Va0EEKYlOZZhuzS3ypSFlc22yDZO7IpL2c3EMw
         Ip7jFavnFw0jA43+MnV6NeD+UWnqA9dghwxbYPA2tXPNVGa3/m/CM1h8cifeidAD1EFN
         Z/UYj1aOOKkxHemHAJNM0deN4jjml9ru1z/+a8rQoOFwAbYrk2BL8R4B2rzKFeiwpzX6
         uX6ac85L4lS9zqb9nutLJGAsUBbnAjLBlnR8An+HFNOxLYE3lsRfgZeeGsUFMasyawYc
         Fc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799230; x=1730404030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIMOl16Oc+gkmljkhXJFmkCvewir3f7Gjx9L1UYJb1g=;
        b=VFWp5OUgsmFYJ7gabna6LVM5YKwLS/vTloPu2WI5yHzrn2RaFjcORQZkYxxFJwjJnq
         pHobEa21OyoocHewqYa2eZhAIbdr7k0ygNtkBRJ8l1DC90aP75to27m0yz97n/3Q1WuX
         Cs0rk/QR8tlMj9IUyA+iPFY2aSfM0gXtRITW7xqcLvfp5CSxAsxxpVsloiAqrJyVCEii
         8WO/en5X8kYiafeZiRStBVL9rLXtPexMt/IWfq8P/HAc0y9weZifVHRWjBm3wTIfz3sm
         wa6t164QXfdUZYhgrA70ugLEporM26ttHsCVvnMrbCDxZ3VWL3gWybiutopafS2LSED9
         H6QA==
X-Forwarded-Encrypted: i=1; AJvYcCU8HyLAeflvOVxyBRRvKSGdjp2Z2egKhj2Eb4ft6qbCejiZnGPV7jcdlu5RqeaKatnfjWJGEw6QnIiz@vger.kernel.org, AJvYcCUxDz8rJKxbNMGquuSyae7WQvRmbbbAEJVyduLUukzsDpMzE+bSOe8oLqW98pyBQUa3AWetfe1TTui1qsIA@vger.kernel.org, AJvYcCVE/RdsvZq4OjSeDcp2OGWilmP+uyVAek/GAaHdab4KR1g7YKxk4K3PJdErxQipSWFLH87aQR42JAhzZ0XMQdwnA9U=@vger.kernel.org, AJvYcCVMXKfrpiurityyeLA/o1IpW0vyt6wCrgbJ6SHhe4081ZfT/9yjzN2wYjbLlTjx/hKVKoE+GrBArfgNyw==@vger.kernel.org, AJvYcCW36kTMsp8bbh6XvKQ2Qiz413lNraxrW5KYu/YXOSRNWTEQgvMMHQdW8G4hg072LEz0crqaliaIVgA=@vger.kernel.org, AJvYcCW85/cEXYARmFXTrr6o70T4wpd8nOw0z+V5MjtONRbYXonX6AlQg4k83r/Jpppd4KdfwyFv+9ae@vger.kernel.org, AJvYcCW9fmwZZXnDyUyOroM71M3NxmbygTpKLvTRQRBHLRNS4H3h8DsjOjbQEc3KrNGb855GoM/E7ZN0ul0c2jL4@vger.kernel.org, AJvYcCWKvJ/KG0jW91h6vUDwUgFC+77Ib2fMiH0FuVF6zPBz+lLN4oJcCTQtK9HVEwOu8RNyt1fl5MLVBzNj@vger.kernel.org, AJvYcCWRg/9ggIzDeKreAvZWeTkesSDK6FEAMxsdG+q6lgB0grccmIiubEu+mRlW8pAnHqYkKGHjfmRKqv8NpT4=@vger.kernel.org, AJvYcCWsIVVozFQ5fB27keACV9QU
 MqlFdGRD/0+Nc/OOck4Hy8OWF1OpVQXOZoPC52XKv9fQvOrorYDd8yoj3g==@vger.kernel.org, AJvYcCX3T0psBBSkVHpxQCIzzUSCr55w0wfGPXf676HTDcZ04OkZqL+yWpniAeaDrXFdgpyn6mNQSh/D9yTk@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsm624rjmSOe8Y3b7N3Fg9XMdgvCXb4yh1L8GeV8632CEI1G1
	65h4a9crDs9iXADmzZ9xe+p2VsLpq3ZUYsxlsSlgMWp+LJq/IQHV9iLwoTYx+UBaRiIQs0kVjCV
	1bwiYVp0dMku8x39aklTZ5VUoC8o=
X-Google-Smtp-Source: AGHT+IGNwTEvTbFWLMloYKQZCr/zKAp0DdNKMjGQfdnRQjfPBj0mdcky5TmmQt/Pc5lbMRaat58vPrZb6iSfoQeDocM=
X-Received: by 2002:a17:90a:474f:b0:2e2:9026:8bee with SMTP id
 98e67ed59e1d1-2e76b84f393mr3469899a91.9.1729799229802; Thu, 24 Oct 2024
 12:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net> <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
 <ZxqK75WdFBod0rZ9@smile.fi.intel.com>
In-Reply-To: <ZxqK75WdFBod0rZ9@smile.fi.intel.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 21:46:58 +0200
Message-ID: <CALtW_ajKAYYwYVGnEArPWz_XaCkEiMFwpoCtzeiO1OLbAk77Sw@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Andy Shevchenko <andy@kernel.org>
Cc: Peter Cai <peter@typeblog.net>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, 
	Kory Maincent <kory.maincent@bootlin.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	Paul Burton <paulburton@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	Vladimir Oltean <olteanv@gmail.com>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Yanteng Si <siyanteng@loongson.cn>, netdev@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 
	Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
	Nikita Shubin <nikita.shubin@maquefel.me>, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

> Yeah, with my hat of the person whose home town is under (Russian) attack for
> the 10+ years (don't be surprised, please, the war lasts more than a decade
> already) on I am fully understand Linus' arguments about history and being not
> very friendly about Russians.

How about your hat off to the people in the Donbas,
~12K of them that had died from Ukrainian artillery fire,
that were under imminent threat of being overrun by
the Ukrainian forces in February 2022? Are you going
to scream about Russian propaganda when I link
the OSCE reports about a 10 fold increase in attacks
at that same time?

BTW can I be racist towards Germans and Croats since
their ancestors exterminated my kin in their death camps?

>
> As you showed above seems like you also will benefit from digging to the
> history a bit. The nice questions to be answered (but not limited to) are:
> 1) What had happened to Finland in 1939?
> 2) Has Finland territory been changed (occupied by another country) in time?
> 2a) (bonus Q) How many times and by which countries / empires?
> 3) (speaking of WW II) How many Jews were killed by Finland?

Maybe you should look up the Finnish concentration camps
 (they called them work camps), that had death percentages
similar to some of Nazi death camps, where Russians, Roma,
Serbs and plenty of other E.Europeans perished, including children?

The fact that they fought alongside Nazis and that they were allowed
to remain independent (and neutral) after the war is, I hope, common
knowledge.

How TF in this day and age is it considered acceptable to be openly
racist towards some people
because you hold historical grievances from 70 years ago?

And for those of you doubting my words, here is a test: Replace the
statements from various
prominent figures, including USA officials, about Russians and Russia
with Jews and Israel and post
them on your social media accounts. See how fast you will be denounced
as a racist.

To paraphrase Noam Chomsky: Approved racism.

