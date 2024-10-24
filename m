Return-Path: <dmaengine+bounces-3482-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095A9AEC20
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE21282F65
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E71F666C;
	Thu, 24 Oct 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=typeblog.net header.i=@typeblog.net header.b="idHoZKpO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.typeblog.net (mail.typeblog.net [88.151.33.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ABB16F910;
	Thu, 24 Oct 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.151.33.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787487; cv=none; b=fe07fEj3Yq1K6J5cyE5J3QPaqPJWFJAjwehuPDWiV8rV1Fz2W0406Z2L2j5cCt/0l4bVw/AKeQ3CCG6WViGw4FwAZuv3ZGjzpveZabN2DOjcHqy4c4/ftdLh8e4T3g1gBo46nAt4NcFKpWdJVmGYYe/6ufb6rENgxi7WvnGeF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787487; c=relaxed/simple;
	bh=krlFgLM5X1BjmsbFwpT05sBfUJhQUHemV0lI+b/qrjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1DZ63Mmrftipj2UaHCfd1SFGJZSxSpHovRrFoaVJbuqRjziNDKNH7PPnzrfpN1vrEeCzUguG6unKt/FlqivVUel8Oy0HAvk6lt6ONKIQOpK+WdMN6kehwWfueP25f3gAYgjwqWXHgHisE9QYvuqs6fTiekUzQbeQFjovV9swLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=typeblog.net; spf=pass smtp.mailfrom=typeblog.net; dkim=pass (2048-bit key) header.d=typeblog.net header.i=@typeblog.net header.b=idHoZKpO; arc=none smtp.client-ip=88.151.33.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=typeblog.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=typeblog.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94CFCD05CE1;
	Thu, 24 Oct 2024 18:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=typeblog.net;
	s=mailcow; t=1729787480;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kMTah/UXmnPbON83Ojlj5WVOo5L4UfCvnmalZ3LtOOs=;
	b=idHoZKpOWIq6BPcZ1jKvD+DCsA+fRuNlkXab1lpqPLW8AY+uSzO9pT9e1otWet0Cb5SXdO
	JPAW91Q4kK/T/DLwbPUYx0r9YaaivsCbfUlNLoOK2AbxLAB1u3HkayLvstcEmmS/uiStEn
	oHNGKBvFNUlPbF/5zkc913SQrZudAqpfcQpXLtAXNdFi0LsUS1CdKgi11yMuXNH2wgoCl6
	c+OfuWSVAlY0xL5cPxoxxgaCiu50Jjof5J2hij9PPSRKL/JIAeRp7XR41H2P8URFa9ivGw
	CKO4NoZ72zhQbsN9ECCPm3tANcCHiVq7uqz8VmxM2gYt21mwOnVGOon/u2jjcg==
Message-ID: <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
Date: Thu, 24 Oct 2024 12:30:59 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux: Goodbye from a Linux community volunteer
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
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
 linux-edac@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org
Cc: Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
Content-Language: en-US
From: Peter Cai <peter@typeblog.net>
In-Reply-To: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James,

Thanks for your clarification. This sort of non-provocative 
clarifications of the regulations you need to comply to has always been 
what the community wants to see. _This_ should have been the first 
official statement when anyone raised the concern, instead of Greg's 
attempt to "defuse" the situation over private correspondence, or Linus 
Torvald's outright defamation and accusing anyone who dares to disagree 
of being a "Russian troll". This is not even to mention the _complete 
ignorance_ and arrogance shown by his statement on what sending a revert 
patch means.

With sanctions in place, there is no reasonable person who will demand 
the LF or the Linux Kernel maintainers to do otherwise. However, as 
someone who does rely on Linux for daily work, and as someone who has 
contributed to the Linux project and its community, I think seeing the 
following should be the minimum:

1. Linus Torvalds (+Cc) send an apology letter to **everyone** who he 
accused of being a Russian troll;
2. Linus Torvalds need to **unconditionally retract** his personal 
attack on Kexy Biscuit, the person who sent the revert patch in protest 
(+Cc), and acknowledge that people who work with AOSC.io aren't 
"state-sponsored paid actors";
3. This type of statement should be included somewhere public as soon as 
practically possible should sanction compliance affect kernel 
development again in the future;
4. No personal attacks should be allowed based on tinfoil-hat reasoning.

Thanks,
Peter.

On 10/24/24 10:50 AM, James Bottomley wrote:
> On Thu, 2024-10-24 at 07:27 +0300, Serge Semin wrote:
>> Hello Linux-kernel community,
>>
>> I am sure you have already heard the news caused by the recent Greg'
>> commit 6e90b675cf942e ("MAINTAINERS: Remove some entries due to
>> various compliance requirements."). As you may have noticed the
>> change concerned some of the Ru-related developers removal from the
>> list of the official kernel maintainers, including me.
>>
>> The community members rightly noted that the _quite_ short commit log
>> contained very vague terms with no explicit change justification. No
>> matter how hard I tried to get more details about the reason, alas
>> the senior maintainer I was discussing the matter with haven't given
>> an explanation to what compliance requirements that was.
> 
> Please accept all of our apologies for the way this was handled.  A
> summary of the legal advice the kernel is operating under is
> 
>     If your company is on the U.S. OFAC SDN lists, subject to an OFAC
>     sanctions program, or owned/controlled by a company on the list, our
>     ability to collaborate with you will be subject to restrictions, and
>     you cannot be in the MAINTAINERS file.
> 
> Anyone who wishes to can query the list here:
> 
> https://sanctionssearch.ofac.treas.gov/
> 
> In your specific case, the problem is your employer is on that list.
> If there's been a mistake and your employer isn't on the list, that's
> the documentation Greg is looking for.
> 
> I would also like to thank you for all your past contributions and if
> you (or anyone else) would like an entry in the credit file, I'm happy
> to shepherd it for you if you send me what you'd like.
> 
> Again, we're really sorry it's come to this, but all of the Linux
> infrastructure and a lot of its maintainers are in the US and we can't
> ignore the requirements of US law.  We are hoping that this action
> alone will be sufficient to satisfy the US Treasury department in
> charge of sanctions and we won't also have to remove any existing
> patches.
> 
> Regards,
> 
> James Bottomley
> 


