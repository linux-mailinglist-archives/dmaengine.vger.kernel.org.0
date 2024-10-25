Return-Path: <dmaengine+bounces-3597-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99B9B0DA4
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 20:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B84D1C228CB
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4918B499;
	Fri, 25 Oct 2024 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gdBTGg9q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A656107A0;
	Fri, 25 Oct 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881950; cv=none; b=qt7qI9WWxkJ7pkgFioFWaH/9wVwv2LDyG0NyFwQvGYaK4vnEup4xiHgmISkGGqXwbNfh1mOGmsToc6kgrCkRoqiEdP1W9B/85qNbvCouB0/uyPdNGPHPB3Jff8u6PFDYyLyNn+J/Votl6GIAICgHnuBYqPX9+DOKJ+H65hPYlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881950; c=relaxed/simple;
	bh=eoe/fP8YHFbJUGJWPDVWR2pm8bdAzVvuYmLMkOvFUCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5Ld4AF2zg5xfBatop7nXqenoaZYeXvlebP509Wab0KC1SkTmqDR7J3bmPgMQm0WoYQlN+eSbt33GZ/YckryYrmL5I29wYpm8jeOaq4NHc4txpvZHwmxxT00yAm2FMVNwsgkIeIhuVHIcOsYXGJXtjQydZqOb1ZY6K24mPhlxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gdBTGg9q; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XZs5L3sP6z9snx;
	Fri, 25 Oct 2024 20:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1729881574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSojNFdw8ftg3T7NakOd4AZhT9UMaiDwBHmwcORfhmk=;
	b=gdBTGg9qaBnIiiH6XUTjeUDIpm/w19h2mJ2NxyWek4JBdbfHEfy1l85WLscQ4teM7X3Y8E
	SzmAWuY6Tiv8TrbprFm973WyyZ+4RlCRZSgfEyQVNqd0vqp4fkqFnrWEBZthKLrpibPdn8
	zOUeUEpcyhLgwtmKEbx1GfoJj+wV9qWVvuN6kVStn1ig/Bghe328CY4APIAqqMM1/M6DTp
	Oi88jdSqZLP4fc+Ctf69KIG1PcmVc9Uqx7eoBdxCRl/yvszGacX3FksxcbsLOSr1RTVZ7U
	RwAHePsvYqanhR6nADNx5z06lDr7cIO+uU+cHTctUfx45NWDJnFzydXg0RISPg==
Message-ID: <872c8823-f62b-42f8-8bf3-86342374aa84@mailbox.org>
Date: Fri, 25 Oct 2024 20:39:19 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
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
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fcapfso3xo4bfkqbzachb4s163eexrjr
X-MBO-RS-ID: 80e4fa8c609ea0e1360



On 10/23/24 19:45, Linus Torvalds wrote:
> Ok, lots of Russian trolls out and about.

I was a little bit sick when I wrote my previous comment, but I wanted 
to elaborate, so here we go:
> 
> It's entirely clear why the change was done, it's not getting
> reverted, and using multiple random anonymous accounts to try to
> "grass root" it by Russian troll factories isn't going to change
> anything.
> 

Of course it's not going to be reverted, and I don't mind.

I do however mind about the fact that you accuse contributors (however 
minimal their contributions were, like in my case) of being "Russian 
trolls" using "multiple accounts".

I would have thought that a man of your stature, knowledge and 
publicity, wrote a more sensible, neutral comment than that childish 
gibberish you produced.
Such comments can be seen in the hundreds on every major news website's 
comment section.
Unfortunately, this is now common discussion standard at least in the 
Western world:

"You don't agree with X? You must be a Y!"

There is no doubt that there are Russian troll factories - but there is 
equally no doubt that there are Western troll factories. Without them, 
this "game" wouldn't work.

You could just have done a simple 'git log --grep="Name"' to find out 
that most of those people who you accused of being trolls are actually 
not trolls. Because trolls do not contribute.

> And FYI for the actual innocent bystanders who aren't troll farm
> accounts - the "various compliance requirements" are not just a US
> thing.

Of course not. It's a USUKEU thing. Or, dare I say, a thing of the 
unipolar anglo-american empire. There is no way around a multipolar 
world order if we as humans want to progress.

Why didn't you (or Greg) elaborate on the "various compliance 
requirements" in the first place?
You could just have said:

"Due to the sanctions against Russia, we as a US-based foundation are 
required to abide and therefore we have to remove some maintainers that 
are thought to be directly collaborating with the current regime" (I 
specifically used a "Western" language).
That, at least, would have been somewhat honest, though still hypocrite.

And I did read through (most of) these EU compliance requirements 
because of my job (not IT), so I'm not *that* clueless.

The sanctions are absurd anyway - I don't remember that the US had been 
sanctioned because of their illegal invasion of [insert country of your 
choice]. US athletes excluded from the Olympics?? How dare you?

I also don't remember that France or UK had been sanctioned because they 
abused their UN mandate to get rid of Gaddafi.

The "country" Kosovo, created by a war, isn't even recognized by all EU 
member states!

And don't even get me started on that Eastern Mediterranian country that 
can commit the worst atrocities without ever getting seriously sanctioned.

Meanwhile, we sanction Iran (hasn't started a war in ages), Cuba (hasn't 
started a war in ages), North Korea (hasn't started a war in ages) etc.

The Western arrogance and decadence is disgusting, and I say that as a 
born and bred Western European.

> 
> If you haven't heard of Russian sanctions yet, you should try to read
> the news some day.  And by "news", I don't mean Russian
> state-sponsored spam.

I'm already more than fed up with the state-sponsored spam on German TV 
- and I even have to pay for that BS!
Now, I don't know how it is in Finland because I don't follow Finnish 
news due to a total lack of language knowledge.

I wish my country would quit NATO, and then I see that Finland *joined*. 
Sorry, but I don't understand. No NATO, no war in Ukraine.
Even as late as 2013, Russia and Ukraine did naval manoevers in the 
Black Sea - together!

This war is sooo totally unnecessary. Maybe you should ask Vicky "F!ck 
the EU" Newland why this all happened.

> 
> As to sending me a revert patch - please use whatever mush you call
> brains. I'm Finnish. Did you think I'd be *supporting* Russian
> aggression? Apparently it's not just lack of real news, it's lack of
> history knowledge too.

Why do you even mention your nationality?
Just a few weeks ago, I read about the role of Finland in (and before) WW2.
I don't think there is a big lack of history knowledge on my side.

My country was occupied by Germany twice, in 1914 and in 1940.
And yet, I have absolutely no bad feelings about either Germany as a 
country nor Germans as a people. OK, their government is the worst since 
1945, but that's a different matter.

Wasn't Mannerheim married to a Russian? Eh?

The former German Minister of Foreign Affairs, Guido Westerwelle, once 
talked about "late Roman decadence", albeit in a different context.

And yet, he was totally right even in other contexts. The Western world 
is actually in the state of "late Roman decadence".
And what follows after that decadence? Right, the downfall. And it might 
be a huge chance to create a better, more equitable world.

> 
>                        Linus

Tor Vic

