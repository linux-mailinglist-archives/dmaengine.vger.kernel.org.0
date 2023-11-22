Return-Path: <dmaengine+bounces-170-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2877F43C3
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 11:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AFA281507
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5D250E7;
	Wed, 22 Nov 2023 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA231715;
	Wed, 22 Nov 2023 02:27:01 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="458522644"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="458522644"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1098347171"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="1098347171"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:26:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1r5kRC-0000000G3tK-3znq;
	Wed, 22 Nov 2023 12:26:30 +0200
Date: Wed, 22 Nov 2023 12:26:30 +0200
From: Andy Shevchenko <andy@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 00/39] ep93xx device tree conversion
Message-ID: <ZV3XVirIOouLqv0a@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 22, 2023 at 11:59:38AM +0300, Nikita Shubin via B4 Relay wrote:
> This series aims to convert ep93xx from platform to full device tree support.
> 
> The main goal is to receive ACK's to take it via Arnd's arm-soc branch.
> 
> Bit thanks to Krzysztof Kozlowski for his zero-day review.
> 
> Krzysztof, Sergey, i've changed some files that you have already provided tag:
> - dt-bindings: spi: Add Cirrus EP93xx
> - ata: pata_ep93xx: add device tree support
> 
> Added DMA and renamed clock header file.
> 
> Sergey, Damien, i've changed some files that you have already provided tag:
> - ata: pata_ep93xx: add device tree support
> 
> Added OF DMA setup and dropped platform file.
> 
> Mark, i've changed some files that you have already provided tag:
> - spi: ep93xx: add DT support for Cirrus EP93xx
> 
> Added OF DMA setup and dropped platform file.
> 
> Major updates:
> 
> - reboot, pinctrl, clk are now auxiliary and instantiated from SoC driver as
>   Stephen Boyd suggested
> - i moved all clock code to clk-ep93xx.c, as it no longer has a separate dt node, 
>   so XTALI is externalk for this driver and passed as index 0, and pll1, pll2 are
>   internal and passed via pointer for parent_data
> - reboot bindings dropped
> - pinctrl and clk bindings moved to syscon YAML
> - xlate added for DMA, so now all DMA users use it via device tree, otherwise probe 
>   order messed up and we might end up probing before DMA with no possibility to defer probing
> - DMA port bindings dropped, they are described in YAML file
> - DMA platform code dropped
> - i2s, spi, pata now use OF DMA
> - YAML and dtsi/dts changed to reflect auxiliary conversion and DMA changes

> Patches should be now formated with '--patience'

It seems we are a step behind on Torvalds' mind :-)
A few weeks ago he suggested to use --histogram is the best option.
But hey, --patience probably is good enough for this version, so
thank you for using it!

-- 
With Best Regards,
Andy Shevchenko



