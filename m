Return-Path: <dmaengine+bounces-3495-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B664F9AEF07
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609EAB224E3
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A651FF7AB;
	Thu, 24 Oct 2024 17:59:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1B1FE0F0;
	Thu, 24 Oct 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792773; cv=none; b=Mps5RilUfHU/UGcyMYIvC1JlvUtXUEhYOpyyahWCsgM4ELjdvsVVhRzB8uE2AZowwqm3q2dCzXQg87VDewKToh3tTGHWyEi6fvlRwGigM99ytdyt5I7l00PD2iKdCvvVFMw1XqOYVf65yzZoay2gcvNhrFxKHD1aPY3olSLKCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792773; c=relaxed/simple;
	bh=nZK/l2NFALltgIH16YZ6CD039zLJ+VUoW+Nr5OBFtqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGaYmngxjLPzek8gNNe1vJ4xxHCv+wPofrVKsHlxuyyfZIRChiHXWKx+vNyx7+3VnYgjBQ8bZt1xjgcqiVzbXlyDpfnmkkYzgSl1AidcItPBZv24IhZVeHl3rOOgXhdKMQOAjKo+sz1yV0OK8eTbJs4T7qnchpmMQ8CT06A7cd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: VOFkFWyoTwaCYGfdKL7JEw==
X-CSE-MsgGUID: bfXAWgSxQviWxIQyJszGhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51984583"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51984583"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:59:30 -0700
X-CSE-ConnectionGUID: J491kRSNRJGEh7umAvXlxA==
X-CSE-MsgGUID: +tejJ4QXQL6sWl0drDP36w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80578314"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:59:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t4275-00000006evJ-40FC;
	Thu, 24 Oct 2024 20:59:11 +0300
Date: Thu, 24 Oct 2024 20:59:11 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Dragan =?utf-8?Q?Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Cc: Peter Cai <peter@typeblog.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	ntb@lists.linux.dev, Kory Maincent <kory.maincent@bootlin.com>,
	Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>, netdev@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, Andrew Halaney <ajhalaney@gmail.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Evgeniy Dushistov <dushistov@mail.ru>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux: Goodbye from a Linux community volunteer
Message-ID: <ZxqK75WdFBod0rZ9@smile.fi.intel.com>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
 <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 07:18:44PM +0200, Dragan Milivojević wrote:
> On Thu, 24 Oct 2024 at 18:31, Peter Cai <peter@typeblog.net> wrote:

...

> He has exposed his lack of morals and inability of self reflection
> with the trolls comment.
> He has exposed his ignorance, coming from his state media
> brainwashing, with the media comment.
> He has exposed his ignorance, arrogance and blatant Russophobia with
> his "I'm Finish" comment, as if
> Finland has any high moral ground when it comes to WWII (for the
> historically ignorant: Finnish "concentration camps").

Yeah, with my hat of the person whose home town is under (Russian) attack for
the 10+ years (don't be surprised, please, the war lasts more than a decade
already) on I am fully understand Linus' arguments about history and being not
very friendly about Russians.

As you showed above seems like you also will benefit from digging to the
history a bit. The nice questions to be answered (but not limited to) are:
1) What had happened to Finland in 1939?
2) Has Finland territory been changed (occupied by another country) in time?
2a) (bonus Q) How many times and by which countries / empires?
3) (speaking of WW II) How many Jews were killed by Finland?

May be this helps changing a bit your understanding of Linus and other Finns.

-- 
With Best Regards,
Andy Shevchenko



