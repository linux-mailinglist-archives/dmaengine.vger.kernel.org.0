Return-Path: <dmaengine+bounces-6598-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF735B7D8B9
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277C13AAB17
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04F430C341;
	Wed, 17 Sep 2025 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Y0nfAD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CB302770;
	Wed, 17 Sep 2025 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103417; cv=none; b=ITsH/XO89vfX3AkL+3b79qtHV4Uw9Lfl/dtkI/1fctr5x7yOs8hPKeGL40aunsKeZPZ0UT767Ooz/owdNOzEoP3R6qn82j7M/lR3DBS+f1YmN3yXx9jFu6mKQ0WPxCXxgfTLKLhoR/sfARTpjGi2tPy53l32TuZIogsPIC1V53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103417; c=relaxed/simple;
	bh=nNlilHjh09UBY7rPl6XW3+rKwLzxl/XA9okrB109O1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJDcS00zmTTRoXhU0aCTXg8f1UnMpCzcesaPTYA4tJ6s9fq/17MX2YbSjZUK7NC1ZqKYPJaPXK1K7kalAjVGbASJ5/vzqgVOrvAE/ilQRzuGedv0a8X13gqpbGyrvVjadw52lwy1mSd/iOqi6ufDyQWA6L+0jsaUIVcdBaO5kTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Y0nfAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429F6C4CEF0;
	Wed, 17 Sep 2025 10:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758103417;
	bh=nNlilHjh09UBY7rPl6XW3+rKwLzxl/XA9okrB109O1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9Y0nfADZvNHly1cC+7nuDT0d/oTq9ziRK04kv1w1BF/BHhB5Xn0fiBbI0/UEecCV
	 Jgfp0Qr3MqeK4/IlBzjJBUmHnx5pt1iVtl+Of1wkezd6WDc+IA/jvJ55WlzYfsS8nU
	 GlOvOEc5T+rMEM1daFnDSK5IiYY4xJjJYth9BdXysxjB3CLYozkCtQecbSEQIlO86I
	 TlfVla0IwqYaoS6wTPwZxzKj9uyGujA4XWYEuhUot/r6Hdefu7hbiz2HhoSqrPqgNf
	 yf5mgQmqWgUVN5yPotT6+fV64FGqGLfxWPfsp136Spi+UEUH80ZpjCppqgefz6djDH
	 z9q04unFly53w==
Date: Wed, 17 Sep 2025 15:33:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: dang.huynh@mainlining.org
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 00/25] RDA8810PL Clock, RTC and MMC driver
Message-ID: <lnfervvwctvemjdmyue2aohlsqpfd5gsuzjho3u6mtdtewl4vr@saqnionh72am>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>

On Wed, Sep 17, 2025 at 03:24:57AM GMT, Dang Huynh via B4 Relay wrote:
> This patch series aims to add support for Clock/Reset, Real-Time Clock and
> SDMMC on the RDA Micro RDA8810PL platform.
> 
> It also adds Intelligent Flow Controller (IOW, a DMA controller) which is
> important for working with this MMC IP.
> 
> Tested on the Orange Pi 2G-IOT.
> 

Thanks for work! Is it possible to split this patchset logically to ease
reviewing and also merging? It currently touches different subsystems and has 25
patches.

You could easily split this into different series adding Clock/Reset, RTC, IFC,
SDMMC and other misc patches in one series.

- Mani

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
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

