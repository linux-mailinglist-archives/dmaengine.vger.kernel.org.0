Return-Path: <dmaengine+bounces-6688-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D10FCB94230
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 05:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AA118A6652
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 03:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B31B040B;
	Tue, 23 Sep 2025 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sRjl/jZp";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="9iEveaNr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247CAD24;
	Tue, 23 Sep 2025 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599150; cv=none; b=DiEgG/QxptoUILQf7LdeYU4iZJH6uREsVjMvxN1URBPav7igCAEyXisRxl/oClv9gxawt+oAgVEj+MYxsaU/b5Q0Bd5+mOB7Pjo5WeAutKA5lVPqqRH2c9DX+7JyqFjg6Fw0zLrhHCPVS6qS84OMQNefcdd708VyPA4xdYglqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599150; c=relaxed/simple;
	bh=4CMWPtu95SpMo8DXVgcYovl8qzxoxMuizAwDQxBKMCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYboDyGOGn7NU8j1A0pDBNpWwcUMVhnXcdti9wOuB/p+TsfaL3zcWskxpaoLyIdzGCYe7uGdWWP4SmEnqMYIIFRVOD34dd2DePi+91QSBbQKE+Fto+eOUPZAhdlU7o9HGDCgGJSTJgDKgb/BbKgIMYANhyXC4czmsXhSN01c7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=sRjl/jZp; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=9iEveaNr; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758598846; bh=RBI2aJbB7n590+KcwgaegrR
	fg5lM30jDW0OwGnQmBL8=; b=sRjl/jZpgu8H2CCD/bvJRFr84ayFxOWFDfefDY/9M3pPOybi5w
	lN8kDaTaV+lvXaJWoXtRLjvYQ72ke1vagpeRzkLmj9xzTdjaUUtLIcp6kNbjDTXNuUvfRjvQBGt
	Woc9cSOZGQZHgEaNee3rLueQ/MPOLBaxqT6muqnh0yj3vVswnT4V4BGRyE4Ws2+y357MwxLDDXc
	5zFTwjV430W2yYKhlLvSxm38QBj54ZvsJjZT1yH1zbZBRM+RcSMjtjl+He7bYMNL0vx57AC8lhu
	0O7vO1yhF2z5AGLZyIb+D6gLV+qf+KpGapgbQ6XnOJl9oKC0A7w8P/AWbWb8IuVnPSw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758598846; bh=RBI2aJbB7n590+KcwgaegrR
	fg5lM30jDW0OwGnQmBL8=; b=9iEveaNrpfx+7EskGD80aKFQggG9+eDi7M/DmfHYjY9si7U0fL
	1IgSpCtPfNEbyOVBCakFKmaRd5+VgsDV4/Ag==;
Date: Tue, 23 Sep 2025 10:40:37 +0700
From: Dang Huynh <dang.huynh@mainlining.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 00/10] RDA8810PL SD/MMC support
Message-ID: <2wwi3ktbcuyp7y7mqplndvawagae5hdhcx3hn375kycoqtows6@xcww2237rxpe>
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
 <CAMRc=Mc4hO1LDumxAfkB1W6miTJXR1NUVAKBVarkwiF2yGvSLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc4hO1LDumxAfkB1W6miTJXR1NUVAKBVarkwiF2yGvSLA@mail.gmail.com>

On Mon, Sep 22, 2025 at 04:17:05PM +0200, Bartosz Golaszewski wrote:
> On Thu, Sep 18, 2025 at 8:49 PM Dang Huynh via B4 Relay
> <devnull+dang.huynh.mainlining.org@kernel.org> wrote:
> >
> > This patch series aims to add SDMMC driver and various drivers required
> > for SDMMC controller to function.
> >
> > This also fixed a bug where all the GPIO switched from INPUT to OUTPUT
> > after the GPIO driver probed or by reading the GPIO debugfs.
> >
> > This patch series is a split from [1] to ease the maintainers.
> >
> 
> This is still targeting at least 4 subsystems and isn't making the
> merging any easier. Are there any build-time dependencies here? If
> not, then split it further into small chunks targeting individual
> subsystems and the relevant ARM SoC tree.
The MMC driver depends on both the clock and the DMA driver.

> 
> Bartosz
> 
> > Tested on Orange Pi 2G-IOT using a Buildroot environment.
> >
> > [1]: https://lore.kernel.org/all/20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org/
> >
> > Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> > ---
> > Dang Huynh (10):
> >       dt-bindings: gpio: rda: Make interrupts optional
> >       dt-bindings: clock: Add RDA Micro RDA8810PL clock/reset controller
> >       dt-bindings: dma: Add RDA IFC DMA
> >       dt-bindings: mmc: Add RDA SDMMC controller
> >       gpio: rda: Make IRQ optional
> >       gpio: rda: Make direction register unreadable
> >       clk: Add Clock and Reset Driver for RDA Micro RDA8810PL SoC
> >       dmaengine: Add RDA IFC driver
> >       mmc: host: Add RDA Micro SD/MMC driver
> >       ARM: dts: unisoc: rda8810pl: Add SDMMC controllers
> >
> >  .../bindings/clock/rda,8810pl-apsyscon.yaml        |  43 ++
> >  Documentation/devicetree/bindings/dma/rda,ifc.yaml |  45 ++
> >  .../devicetree/bindings/gpio/gpio-rda.yaml         |   3 -
> >  Documentation/devicetree/bindings/mmc/rda,mmc.yaml |  92 +++
> >  MAINTAINERS                                        |  18 +
> >  .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts  |  20 +
> >  .../arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts |  20 +
> >  arch/arm/boot/dts/unisoc/rda8810pl.dtsi            |  47 +-
> >  drivers/clk/Kconfig                                |   1 +
> >  drivers/clk/Makefile                               |   1 +
> >  drivers/clk/rda/Kconfig                            |  14 +
> >  drivers/clk/rda/Makefile                           |   2 +
> >  drivers/clk/rda/clk-rda8810.c                      | 769 +++++++++++++++++++
> >  drivers/dma/Kconfig                                |  10 +
> >  drivers/dma/Makefile                               |   1 +
> >  drivers/dma/rda-ifc.c                              | 450 +++++++++++
> >  drivers/gpio/gpio-rda.c                            |   4 +-
> >  drivers/mmc/host/Kconfig                           |  12 +
> >  drivers/mmc/host/Makefile                          |   1 +
> >  drivers/mmc/host/rda-mmc.c                         | 853 +++++++++++++++++++++
> >  include/dt-bindings/clock/rda,8810pl-apclk.h       |  70 ++
> >  include/dt-bindings/dma/rda-ifc.h                  |  28 +
> >  22 files changed, 2495 insertions(+), 9 deletions(-)
> > ---
> > base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> > change-id: 20250918-rda8810pl-mmc-3f33b83c313d
> >
> > Best regards,
> > --
> > Dang Huynh <dang.huynh@mainlining.org>
> >
> >


