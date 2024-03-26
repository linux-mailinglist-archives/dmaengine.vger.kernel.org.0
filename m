Return-Path: <dmaengine+bounces-1515-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E3E88C5AE
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA73E1F61F57
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773813C665;
	Tue, 26 Mar 2024 14:49:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32BED9;
	Tue, 26 Mar 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464567; cv=none; b=W5aRuY4FA+MFSwww+a9KSGBm6rjqxF/qS+LJFKNBU4hSPwhPIFxU2Jq1/l2LG5AczpGnyOXcEwvCrz/Q3NaPNqAwMPJKDzDYJJ1da4uSW1XH+h3VH+mdRZ4O2ERbQ09krA9hqDHEy8zJZYxtmOTIYcpbBICCxe2Qt3z18yuixBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464567; c=relaxed/simple;
	bh=NjGYoZS9MYNf6KYedY89CIBd6GNJTkqJoAov7a2XKRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKa2GUP2mvNfmdnlyNeLbfnsCask9NEB4lp/RWBjl2d0U9X7MSBPz3S8LBcMRCJLBPg2ZLxsqT1391GskXnP9fC6P3xxTX/6E6DPlfevlCTKnIJjxYKl4YICDrwonkiLmXmCzDJBct5JO5U+vELkj+9bAOiu2XeEv2qMEhP4aN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: u4/HncuNQveTDgvADY/MsQ==
X-CSE-MsgGUID: xKfSFc0eQ3Cp9nnBEl04Pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="28999055"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="28999055"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882408"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914882408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:49:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rp86t-0000000GKYj-43J8;
	Tue, 26 Mar 2024 16:49:07 +0200
Date: Tue, 26 Mar 2024 16:49:07 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: nikita.shubin@maquefel.me,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Lukasz Majewski <lukma@denx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Wu, Aaron" <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>,
	Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v9 00/38] ep93xx device tree conversion
Message-ID: <ZgLgY11N8dkpTZJB@smile.fi.intel.com>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <dc3e2cb4-f631-4611-8814-0dc04c5502f0@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3e2cb4-f631-4611-8814-0dc04c5502f0@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 11:19:54AM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 10:18, Nikita Shubin via B4 Relay wrote:
> > The goal is to recieve ACKs for all patches in series to merge it via Arnd branch.
> > 
> > Some changes since last version (v8):
> > 
> > - Most important, fixed bug in Device Tree resulting in CS4271 not working by Alexander Sverdlin.
> > - added #interrupt-cells to gpio nodes with interrupts-controller
> > - fixed some EOF in dtsi files
> > - fixed identation and type in ep93xx-keypad thanks to Andy Shevchenko
> > 
> > Stephen Boyd, Vinod Koul PLEASE! give some comments on following, couse i hadn't one for a couple of iterations already:
> > 
> > Following patches require attention from Stephen Boyd, as they were converted to aux_dev as suggested:
> > 
> > - ARM: ep93xx: add regmap aux_dev
> > - clk: ep93xx: add DT support for Cirrus EP93xx
> > 
> > Following patches require attention from Vinod Koul:
> > 
> > - dma: cirrus: Convert to DT for Cirrus EP93xx
> > - dma: cirrus: remove platform code
> 
> A lot of this could have been already merged if you split it... Just
> saying...

But you able to apply DT schema patches if you wish.
Just doing? :-)

-- 
With Best Regards,
Andy Shevchenko



