Return-Path: <dmaengine+bounces-3586-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889C09B0387
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 15:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF2728677D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558451F754B;
	Fri, 25 Oct 2024 13:12:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473291E7660;
	Fri, 25 Oct 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861949; cv=none; b=Ffk2EfF+aBWfD1t8jNRigw6xRLySGBFZobA4pB5fW9y3jtQmETZT94jzOKHmXDdFjMr/7J2K8+gfRtlZDJZhQGRs3dBdv5sqV2rbUFlsbGkaT/pR7qrO1RDi91goSPZgRF0ktJIaSjQrfwRUSP7kRtBROeeLrl1ugLZNoAeSSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861949; c=relaxed/simple;
	bh=DyZekcekX3RtD9pX7NDF9lTJOHreJBPcOIWwl++T12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvf/bJ3wygRBqbWdvTMehUBMFoREG4pRNgX762FD/uylbyWIGk1XIVlOxuKXi0NOl8UkV1j5qj3H3YqF7ZhSWGcKhP7dSF531Dg9T3aVT2o99XIOPnQX3G4w8Y+Bqe1eyN1eqfIpNaUC0vWf/B4Wd89+hwegrUMUAbi5/S+Bvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: +MippmjcS7GiCHxfKD/FPQ==
X-CSE-MsgGUID: YqiQFwgNQ2urN4bdSLfTEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29474401"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29474401"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:12:27 -0700
X-CSE-ConnectionGUID: YBODLHiKRmKI4N2x3UePrA==
X-CSE-MsgGUID: ORNpoHttQRiMH14+J3yUxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81073104"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:12:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1t4K6r-00000006v8Q-1Pfa;
	Fri, 25 Oct 2024 16:12:09 +0300
Date: Fri, 25 Oct 2024 16:12:09 +0300
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
Message-ID: <ZxuZKcTafSVXLcIe@smile.fi.intel.com>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
 <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
 <ZxqK75WdFBod0rZ9@smile.fi.intel.com>
 <CALtW_ajKAYYwYVGnEArPWz_XaCkEiMFwpoCtzeiO1OLbAk77Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALtW_ajKAYYwYVGnEArPWz_XaCkEiMFwpoCtzeiO1OLbAk77Sw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 09:46:58PM +0200, Dragan Milivojević wrote:
> > Yeah, with my hat of the person whose home town is under (Russian) attack for
> > the 10+ years (don't be surprised, please, the war lasts more than a decade
> > already) on I am fully understand Linus' arguments about history and being not
> > very friendly about Russians.
> 
> How about your hat off to the people in the Donbas,
> ~12K of them that had died from Ukrainian artillery fire,
> that were under imminent threat of being overrun by
> the Ukrainian forces in February 2022? Are you going
> to scream about Russian propaganda when I link
> the OSCE reports about a 10 fold increase in attacks
> at that same time?

Yeah, yeah, no point to discuss with you "Russian state-sponsored spam".
Btw, are you from Serbia?

> BTW can I be racist towards Germans and Croats since
> their ancestors exterminated my kin in their death camps?

You should answer your question yourself.

-- 
With Best Regards,
Andy Shevchenko



