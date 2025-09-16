Return-Path: <dmaengine+bounces-6583-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DFAB5A331
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A653462E9A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F80F2F9DA7;
	Tue, 16 Sep 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d31EIRoX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900B2F9D8B;
	Tue, 16 Sep 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054424; cv=none; b=W+c/RhTaoa11XThKMWGMtG6laXkmgccA4ase/Nbxe+PZ1iLvVkV20sND2yM76dx5UtfsNG0VurZCGeejhdfYqyOdS9NLUR4GBS4x7AL0LnIUulH0RzJQ7SbhZijqHFMu/3N9igU16hZwxExywqRLG/nQwxd2jPMKuf2wdVBIF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054424; c=relaxed/simple;
	bh=4FXfxsceIneOkJ466HH8xl4Odh9jpYJaUrjHNT0zuUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5s3sekaofftD3pW3zs8snG3wf4P401f/AMFXOW69hDQf0sUy6jA0mG0NATLpiRRTYXQsrhmiuC2IZe2UWdM7UiTBxiLVj7UsFKzgBmfGPwr96SX9rki/uQFESEWmDj2T2TO4x3mveGUB5MthGOZnCy2BQ+mTUBK8NimZ6hXtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d31EIRoX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 767EE4E40C75;
	Tue, 16 Sep 2025 20:26:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B13E6061E;
	Tue, 16 Sep 2025 20:26:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5A88102F17AC;
	Tue, 16 Sep 2025 22:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758054417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZLtN3cPdZNxLNq3OdBF4FnsM4y1zIM67HF3kle83rV8=;
	b=d31EIRoXxAl9Pl1rTvDkK1blpoHuz0hNFNNj8fJdgyYnRcMDDHz6dXu3nPzw+G3Qo97bvW
	3hWJMNmEs3YMHBYXzj2IEUxugPSKISdiBMtMSK0f5xamHoc1tX+a0IEwd/x2g07OHxJPEn
	lxQMd8I6jpB+2EbvVPHs+G5w/4MPISBjIIExMwjImrcwzgXnBczv6RDJ/Ky1da5wyj2mei
	cmhCU+l5TmXbm/GR4ElBfsJ0/8YNbrtjM1XSo9YbzTqSKxjygZrfKHcbsihuzWigbHO8hJ
	1LkM4pCg+lSraI1LuT89alkSK+DfBR9t2fc/FDg+aeBoxYamhNyvK+y8Jrlsiw==
Date: Tue, 16 Sep 2025 22:26:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 00/25] RDA8810PL Clock, RTC and MMC driver
Message-ID: <2025091620264900a32db6@mail.local>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 17/09/2025 03:07:17+0700, Dang Huynh wrote:
> This patch series aims to add support for Clock/Reset, Real-Time Clock and
> SDMMC on the RDA Micro RDA8810PL platform.
> 

What are the dependencies between the various drivers? Ho< do you expect
the patches to be merged?

If the RTC patches are independent, please send them separately.

> It also adds Intelligent Flow Controller (IOW, a DMA controller) which is
> important for working with this MMC IP.
> 
> Tested on the Orange Pi 2G-IOT.
> 
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---
> Dang Huynh (25):
>       ARM: dts: unisoc: rda8810pl: Add label to GPIO nodes
>       drivers: gpio: rda: Make IRQ optional
>       dt-bindings: gpio: rda: Make interrupts optional
>       rtc: Add timestamp for the end of 2127
>       dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
>       rtc: Add driver for RDA Micro SoC
>       ARM: dts: unisoc: rda8810pl: Enable Real-Time Clock
>       ARM: dts: unisoc: rda8810pl: Enable ARM PMU
>       dt-bindings: clock: Add RDA Micro RDA8810PL clock/reset controller
>       drivers: clk: Add Clock and Reset Driver for RDA Micro RDA8810PL SoC
>       dts: unisoc: rda8810pl: Enable clock/reset driver
>       dts: unisoc: rda8810pl: Add OPP for CPU and define L2 cache
>       dts: unisoc: orangepi: Disable UART with no users
>       dt-bindings: power: reset: Add RDA Micro Modem Reset
>       power: reset: Add basic power reset driver for RDA8810PL
>       dts: unisoc: rda8810pl: Enable modem reset
>       drivers: gpio: rda: Make direction register unreadable
>       dt-bindings: dma: Add RDA IFC DMA
>       dmaengine: Add RDA IFC driver
>       dts: unisoc: rda8810pl: Enable IFC
>       dt-bindings: mmc: Add RDA SDMMC controller
>       mmc: host: Add RDA Micro SD/MMC driver
>       dts: unisoc: rda8810pl: Add SDMMC controllers
>       dts: unisoc: orangepi-2g: Enable SD Card
>       dts: unisoc: orangepi-i96: Enable SD Card
> 
>  .../bindings/clock/rda,8810pl-apsyscon.yaml        |  44 ++
>  Documentation/devicetree/bindings/dma/rda,ifc.yaml |  42 +
>  .../devicetree/bindings/gpio/gpio-rda.yaml         |   3 -
>  Documentation/devicetree/bindings/mmc/rda,mmc.yaml |  91 +++
>  .../bindings/power/reset/rda,md-reset.yaml         |  36 +
>  .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    |  30 +
>  MAINTAINERS                                        |  30 +
>  .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts  |  24 +-
>  .../arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts |  24 +-
>  arch/arm/boot/dts/unisoc/rda8810pl.dtsi            | 115 ++-
>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/rda/Kconfig                            |  14 +
>  drivers/clk/rda/Makefile                           |   2 +
>  drivers/clk/rda/clk-rda8810.c                      | 770 +++++++++++++++++++
>  drivers/dma/Kconfig                                |  10 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/rda-ifc.c                              | 450 +++++++++++
>  drivers/gpio/gpio-rda.c                            |   4 +-
>  drivers/mmc/host/Kconfig                           |  12 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/rda-mmc.c                         | 853 +++++++++++++++++++++
>  drivers/power/reset/Kconfig                        |   9 +
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/rda-reboot.c                   |  58 ++
>  drivers/rtc/Kconfig                                |  11 +
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-rda.c                              | 356 +++++++++
>  include/dt-bindings/clock/rda,8810pl-apclk.h       |  79 ++
>  include/dt-bindings/dma/rda-ifc.h                  |  28 +
>  include/linux/rtc.h                                |   1 +
>  31 files changed, 3079 insertions(+), 23 deletions(-)
> ---
> base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
> change-id: 20250916-rda8810pl-drivers-9a5271452635
> 
> Best regards,
> -- 
> Dang Huynh <dang.huynh@mainlining.org>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

