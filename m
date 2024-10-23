Return-Path: <dmaengine+bounces-3449-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2449AD4AB
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 21:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB511C22624
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5801D1F4D;
	Wed, 23 Oct 2024 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=typeblog.net header.i=@typeblog.net header.b="kCijJnm0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.typeblog.net (mail.typeblog.net [88.151.33.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EBE1D0E18;
	Wed, 23 Oct 2024 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.151.33.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711544; cv=none; b=RJbcZXlHzcb3PT3CgNE0PIK2az2ryP3YOAjXjwA5/AaICN1OevQcpxyxUkh1lr6hpse89tFQHi80+1k5yK9ZKyZkEQ18XfU3XiHs/1POmnbDje1P7+p8asVUKDl75LI21vWTuZciMv4V1ETlFvAji9Z3cLuUHyx0s+tSOILekxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711544; c=relaxed/simple;
	bh=xiF1qogbUg+X2NJMpfllNRC+/jZmqlzJGUZxsFsceP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5zlxA+RWiY5VCy5xpln5/cOstBjMbAZeNkOmGtGe1NB7WsHGPwFo/W6CfHoULQArOR+3luYu9p4w73OSNiDirHcocdorSAN+9Wx2Na10nrA0vlS1cG2psS+XJzOkzrldksh4P4Q2odShfyvBK+8gD+RcmXVeO5heG1fGzDglgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=typeblog.net; spf=pass smtp.mailfrom=typeblog.net; dkim=pass (2048-bit key) header.d=typeblog.net header.i=@typeblog.net header.b=kCijJnm0; arc=none smtp.client-ip=88.151.33.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=typeblog.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=typeblog.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B5D5CFB3CF;
	Wed, 23 Oct 2024 21:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=typeblog.net;
	s=mailcow; t=1729710935;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AZ3gyldhS8joMJJp8RQYoZtzaPSJsdJPE2HaJSDoW4E=;
	b=kCijJnm08z9C55C1OhSt2FDysBPg1YmlgNXc/2YZ0FlY+o4LpPhyVh+A6Z4xKATicIabnV
	bjOmKV8EeUqsvTwommg0zwOPI8h5oL8stKnjWpYa/Y9vjZOkLBSbC75ZnmuJzab3LLFkV+
	NxQZ542GYTjTixcGInRplXXhTedUBKUxFHnyaDNzyh3n7srV9ueRkUbJaBjvi/3+wS3xtd
	yTtWzqgjv/IHq+jH9l/j/ot3YZfV6f8qVVFRrAgA7eKa0iaxH2UOklM9omy/KNe4d9se4T
	ZrHtzu6J58ko+Ki3zKtJMRnMpiLty2UMLVoEv10mo7x74bsRMHlpc8UyW85UzQ==
Message-ID: <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
Date: Wed, 23 Oct 2024 15:15:17 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Tor Vic <torvic9@mailbox.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru,
 conor.dooley@microchip.com, ddrokosov@sberdevices.ru,
 dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com,
 geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org,
 mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru,
 ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org,
 s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru,
 tsbogend@alpha.franken.de, v.georgiev@metrotek.ru,
 wsa+renesas@sang-engineering.com, xeb@mail.ru
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
 <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Content-Language: en-US
From: Peter Cai <peter@typeblog.net>
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi there,

Not a maintainer, but I have made several bug reports using this email 
address. At least 1 reasonably-sized patch is also currently under 
review in the networking mailing list, along with people from several 
American corporations, so hopefully you won't automatically assume this 
email came from a "Russian troll" account.

Ok. With that out of the way, if you still want to bother reading, 
here's why, in the most un-provocative tone possible, why your comments 
_completely_ miss the point why people are upset:

On 10/23/24 1:45 PM, Linus Torvalds wrote:
> Ok, lots of Russian trolls out and about. >
> It's entirely clear why the change was done, it's not getting
> reverted, and using multiple random anonymous accounts to try to
> "grass root" it by Russian troll factories isn't going to change
> anything.

Yes. Everybody who has more than 1 brain cell knows, in general, "why". 
The point was never to ask for the obvious response.

People are upset because no reference to _exactly which compliance 
requirement_ resulted in the removal of these maintainers. No 
open-source project can live outside of a political entity, but that is 
not the reason why "obviously" can be used to write off such a change.

Even just stating "we were contacted by <...> but details are under NDA" 
is a **much** better response than "due to various compliance 
requirements". No one is saying the LF or the Linux kernel should be 
outside of politics. That's impossible. But it _is_ possible to run the 
project based on _transparency_ and _honesty_ instead of "why can't you 
see the obvious".

> And FYI for the actual innocent bystanders who aren't troll farm
> accounts - the "various compliance requirements" are not just a US
> thing.

Again -- are you under any sort of NDA not to even refer to a list of 
these countries?

> If you haven't heard of Russian sanctions yet, you should try to read
> the news some day.  And by "news", I don't mean Russian
> state-sponsored spam.

Before calling out community members who raised legit concerns about 
procedural transparency, maybe it is worth doing a quick fact-check. 
There are a lot of suspicious looking `.ru` emails in this thread, but 
they are not who first raised the concern. The revert patch was sent out 
by someone at aosc.io. Look up who they actually are -- and before you 
assume "state-sponsored spam" just because of the language of the 
website, maybe you can also spend more than 1 second to check where the 
website is even actually located.

> As to sending me a revert patch - please use whatever mush you call
> brains. I'm Finnish. Did you think I'd be *supporting* Russian
> aggression? Apparently it's not just lack of real news, it's lack of
> history knowledge too.

I hope that either this comment wasn't written by the real Linus 
Torvalds, or that Linus was not under his best judgement when this email 
was sent. Because just like anyone who reads the news would know about 
Russian aggression, anyone who knows anything about politics should also 
be able to understand that individuals and their states are different 
concepts.

If these maintainers are associated with the Russian state, this should 
be cited as the reason for their removal. And you know what? Most people 
wouldn't have any problem with it. And then you can say "we are not 
supporting Russian aggression" with confidence. But this is **not** what 
was done.

I seriously hope that Linus Torvalds would have known better.

Thanks,
Peter.

