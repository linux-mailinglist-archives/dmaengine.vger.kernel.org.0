Return-Path: <dmaengine+bounces-3489-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB859AEDA1
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 19:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D352820EA
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D424D1FC7D9;
	Thu, 24 Oct 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Prfqp2Zu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E841F9EB5;
	Thu, 24 Oct 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790338; cv=none; b=EpPHZwZ9onOzcKGNhp3gTx3Q5xdAwdbeeY6gBpNdH9eFTSomL6CfO8bfn/6Bi4XWN61dRBBTu7CEn4/u7UABIJZ9rd7YHilP0+CFZ70LsKZ3BH5CX0dYnpLaMB0wXXRHgRtYOndQ9a8QkBOKto0g2Sh6z6q4+1hyYtMpKniyY7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790338; c=relaxed/simple;
	bh=nTVRYLsAvfk/lLXdgAe/3h3LsHu4QnTJysO1smFIuPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI+5xd8lyVenAIe0yasEvq6UVvEcrfLKfyCmygcbXZruvMmeURc8NfvZKcfB+euCyK3hwGcKyPEZRe1Lc8nGG8NKRetdnRJhPT7Elh+Zxhyn/fX+pJXaJd7ku6mEtn4FvDZDBOPNnONSRbERffEP1K4zSuYKYaq/q3GlEfBN1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Prfqp2Zu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso220803a91.2;
        Thu, 24 Oct 2024 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790336; x=1730395136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nTVRYLsAvfk/lLXdgAe/3h3LsHu4QnTJysO1smFIuPY=;
        b=Prfqp2ZuNz9ZfxOiZ0LAYZZSuBTYGgX2obrfvhcd++kQxyNMdvVhJ6L6aWjQUSi5Va
         N/+y4AWdfKZ3hRICJIKnKF6z6fQZFaktgOVdXoPYoYZV5vSTSWv2FUZk5PBOkER/LiGr
         yf66R8rKpcxixfl415YR1ufwpvg2kb/q90QXALebQ1yrQIlL/+1G5dAZUFSGlMxTtc6v
         pNHzkAA4KTWdsQ5Z8LWE2zbJmnEFUA6s7tsqyFwFzM09+NBVjjHNy4MGHQIPgDmpJA//
         eJz6gebb9VYZbO6u3KIuczbdSCpcHiTjy3No78qQYaxF7aQEfJ69VYUZtUXDsC0lzEWM
         1Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790336; x=1730395136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTVRYLsAvfk/lLXdgAe/3h3LsHu4QnTJysO1smFIuPY=;
        b=MWlR+ZZXa2yR/uzqiNeDXCDVdlWJDLfWToQVGHxUr10uVnnw5bV4ijwGe77zhSpf12
         kG7ucskQFDGVLjEe8MDCE60hdv5M3sNVcRtwfV1FR8nZWjmsNfGwDWYZ3OeyzhojgS3u
         LE6tlKY0zCpz+vWWd5aQYPyzYOc8uLnJ9Ixs8ytdyNALVb4P9ECthmhsnyr8u//mnwWt
         VHilVBcxab3uPsGTGpgb7WT3ic/JOiGMORbu0/SJHgn1v70fOsvPnQyLURCYB3n0y/cQ
         U1k23teUqTJrePeAQE7UFooL782ec//UlZAtAC37Da2A+vv2NIbo1SqUUnsc5UmxLeoe
         hegg==
X-Forwarded-Encrypted: i=1; AJvYcCU1id6rlDS6nXfXMazWIPJw2Kpb3A9IEf7CtagWZSBCy2wcTPRxUYhgfkahjsAWEymcPGvP2g84jVdn@vger.kernel.org, AJvYcCUJHazVYzVVWfKRZ+WQOICghycN1vm92CVaM310iZmWlbn6oDE/9S+PEDSOQbs3y+/y/w2tcRc8PQcGZQ==@vger.kernel.org, AJvYcCUpAivP5UxCSQD57V7HmkLr5htzOlmNccTpvpHgGgQrjr5zeQwJKLKKEs+6ov488or76btO0WBZ744=@vger.kernel.org, AJvYcCVT4G6qjo/qrDGYnxE/l0rgMip9g86sNglLoViabHVx3z/LaeZ3YYcZK0m/9LBbpt/EJAArN9T8@vger.kernel.org, AJvYcCVjzsyxY8Miym2PQjRLu1xW64MIdkql0pShNk/SGl4zhC1ivOVmXsVWBPHzN4CMPFxzEd04sJjfouI3fnBm@vger.kernel.org, AJvYcCVsyHGc9kGTfnh85XPvTQZ/zGC68SzN6xaxR7GyKs2rqnGBHIE0gtd8bv5wwQOXY+e/Lv7Nq7auFubU@vger.kernel.org, AJvYcCW5bzktZOOn0pWRbmgtk25siL8HNeP/867N3QWRfpVWP1atz9/EcQ+vID1JO1hqkeHTkCO2Imv2+Q5v5O8=@vger.kernel.org, AJvYcCWKZd3bJg/YGczz+UEYfywxONMds2YC3MH/GwQf2IJkMt0s0Y4m1WQ4E08ZsK/Ol9r125ga3W39GuD0lg==@vger.kernel.org, AJvYcCX1pmbRSujgipvjWcOnGD5KoXBuxh2ZX6zWe3i7SGxei0KoeAvXRvF4NGKpmBpo56U1fnrKsEHuyp4z@vger.kernel.org, AJvYcCXFo67RuPI6lgCl0xPU9qelivMaZyCQvNZ4
 JlY5kLa3sQdeN9rW8nbb2YKqYud//KXZZXhXKdEjphfVZdRTKMp8wR4=@vger.kernel.org, AJvYcCXQeFHUqGpIrwJGJCkDsL+PHTGZIej5rMgTt3TYpDgVWP3QDJmPqTbQXICSbwplpZpyLo0Oot8j8B6w7pqB@vger.kernel.org
X-Gm-Message-State: AOJu0YyzM84FC9B75MbuB38uQafomnv9t5mpoWcoeocMjaT8gctRgiqU
	QMXk/MiMrEJ3w4uULMjcv//LKigpEtqBooWsPJt+Ls7ikOKMZ4gas5yjksr/JqKEoVnJQrmZC7b
	0ep4+KSrQQy7oUyvFw1pOV2wQm0M=
X-Google-Smtp-Source: AGHT+IHlG1XLwcp7JbpxEPhwJbRhJPhkOVwX1+UQqAPGsdjFxfa26tBKYAcI0RMZCzFwbNjxjrRmsEC+sV+YOtvF3B8=
X-Received: by 2002:a17:90b:4a83:b0:2e2:e929:e8d2 with SMTP id
 98e67ed59e1d1-2e76b6c3194mr3216467a91.4.1729790335973; Thu, 24 Oct 2024
 10:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com> <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
In-Reply-To: <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 19:18:44 +0200
Message-ID: <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Peter Cai <peter@typeblog.net>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
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

On Thu, 24 Oct 2024 at 18:31, Peter Cai <peter@typeblog.net> wrote:
>
> Hi James,
>
> Thanks for your clarification. This sort of non-provocative
> clarifications of the regulations you need to comply to has always been
> what the community wants to see. _This_ should have been the first
> official statement when anyone raised the concern, instead of Greg's
> attempt to "defuse" the situation over private correspondence, or Linus
> Torvald's outright defamation and accusing anyone who dares to disagree
> of being a "Russian troll". This is not even to mention the _complete
> ignorance_ and arrogance shown by his statement on what sending a revert
> patch means.
>
> With sanctions in place, there is no reasonable person who will demand
> the LF or the Linux Kernel maintainers to do otherwise. However, as
> someone who does rely on Linux for daily work, and as someone who has
> contributed to the Linux project and its community, I think seeing the
> following should be the minimum:
>
> 1. Linus Torvalds (+Cc) send an apology letter to **everyone** who he
> accused of being a Russian troll;
> 2. Linus Torvalds need to **unconditionally retract** his personal
> attack on Kexy Biscuit, the person who sent the revert patch in protest
> (+Cc), and acknowledge that people who work with AOSC.io aren't
> "state-sponsored paid actors";
> 3. This type of statement should be included somewhere public as soon as
> practically possible should sanction compliance affect kernel
> development again in the future;
> 4. No personal attacks should be allowed based on tinfoil-hat reasoning.
>
> Thanks,
> Peter.
>

That list is great but it will never happen, Linus is high on his
western supremacy complex.
Most of the anger (including mine) comes from people who have just
realized what kind of a person Linus is.

He has exposed his lack of morals and inability of self reflection
with the trolls comment.
He has exposed his ignorance, coming from his state media
brainwashing, with the media comment.
He has exposed his ignorance, arrogance and blatant Russophobia with
his "I'm Finish" comment, as if
Finland has any high moral ground when it comes to WWII (for the
historically ignorant: Finnish "concentration camps").

And this is not over, there are plenty of other countries and entities
on the official USA enemies list.
The real majority of the world, all of us outside the USA and their
vassal states, their so called "free world" (one maintainer
actually used that blatant display of American supremacy in a commit
removing Huawei maintainers) are looking at this
with sadness and anger.
The Cold War 2.0 has came to the Linux world and as in the first one,
the Iron curtain has been erected
by those that claim moral high ground with their false values of
freedom, openes, merit etc.

