Return-Path: <dmaengine+bounces-3475-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48E9AE952
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A621C21F2B
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A101E7666;
	Thu, 24 Oct 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="E2iK3IST";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="E2iK3IST"
X-Original-To: dmaengine@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787361E5731;
	Thu, 24 Oct 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781428; cv=none; b=TW+tbzyG4FQxow0/DINTgdI2YHMJxdWQDIS/ajlVZqm2M+ciKaykGMVvs1nD/6iv2NfVMWHCuvQXqkEXJxYj0i8a4hn9OEANwyrKBwM1N3w+ikfcXlExYUwtc3Ql6RmGZbgUiIau0I97OpdgG67Bxj7pUSoVGA/oiDU6MwBBxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781428; c=relaxed/simple;
	bh=mbwn8u7Yo3t7bDM95MTrZ4UZzGeDlEInOig7frVVxu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upeQYk2UkLathXsZKBzasC5rfh9SGn0/8LeB+zKtVsY9TRzjnpf/Ff/qpHCxICUH3wMOmbfNOqjjPDB3l3sqJThyVT2D+FGudecDKAxcJTkebxZgWA/+5zp0dPcWokTJHUp6M9lu5xARJGMEdmUglrGil3zEhtIBMg9j1JT20Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=E2iK3IST; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=E2iK3IST; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729781424;
	bh=mbwn8u7Yo3t7bDM95MTrZ4UZzGeDlEInOig7frVVxu4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=E2iK3ISTp30X2+aGDqLS5ovzA+ZxuPF+Qs1/qm/BZZE5Y8Z7cYne9E6BkM/JjFKW5
	 KNcQGDDjwV8ftEehohuSqC2Zfc/yjYs3MfiDr7hQvVDwC2ObzLDyFNHL1Zs2snoNMc
	 9TxtlJXCErz4t/Zjx2NkCSxIy/O4N5ISUZrncBWo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 313D01281D6E;
	Thu, 24 Oct 2024 10:50:24 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hmjYRFYioZ5c; Thu, 24 Oct 2024 10:50:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729781424;
	bh=mbwn8u7Yo3t7bDM95MTrZ4UZzGeDlEInOig7frVVxu4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=E2iK3ISTp30X2+aGDqLS5ovzA+ZxuPF+Qs1/qm/BZZE5Y8Z7cYne9E6BkM/JjFKW5
	 KNcQGDDjwV8ftEehohuSqC2Zfc/yjYs3MfiDr7hQvVDwC2ObzLDyFNHL1Zs2snoNMc
	 9TxtlJXCErz4t/Zjx2NkCSxIy/O4N5ISUZrncBWo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 430D21281CC7;
	Thu, 24 Oct 2024 10:50:20 -0400 (EDT)
Message-ID: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
From: James Bottomley <James.Bottomley@HansenPartnership.com>
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
Date: Thu, 24 Oct 2024 10:50:19 -0400
In-Reply-To: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
References: 
	<2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-10-24 at 07:27 +0300, Serge Semin wrote:
> Hello Linux-kernel community,
> 
> I am sure you have already heard the news caused by the recent Greg'
> commit 6e90b675cf942e ("MAINTAINERS: Remove some entries due to
> various compliance requirements."). As you may have noticed the
> change concerned some of the Ru-related developers removal from the
> list of the official kernel maintainers, including me.
> 
> The community members rightly noted that the _quite_ short commit log
> contained very vague terms with no explicit change justification. No
> matter how hard I tried to get more details about the reason, alas
> the senior maintainer I was discussing the matter with haven't given
> an explanation to what compliance requirements that was.

Please accept all of our apologies for the way this was handled.  A
summary of the legal advice the kernel is operating under is

   If your company is on the U.S. OFAC SDN lists, subject to an OFAC
   sanctions program, or owned/controlled by a company on the list, our
   ability to collaborate with you will be subject to restrictions, and
   you cannot be in the MAINTAINERS file.

Anyone who wishes to can query the list here:

https://sanctionssearch.ofac.treas.gov/

In your specific case, the problem is your employer is on that list. 
If there's been a mistake and your employer isn't on the list, that's
the documentation Greg is looking for.

I would also like to thank you for all your past contributions and if
you (or anyone else) would like an entry in the credit file, I'm happy
to shepherd it for you if you send me what you'd like.

Again, we're really sorry it's come to this, but all of the Linux
infrastructure and a lot of its maintainers are in the US and we can't
ignore the requirements of US law.  We are hoping that this action
alone will be sufficient to satisfy the US Treasury department in
charge of sanctions and we won't also have to remove any existing
patches.

Regards,

James Bottomley


