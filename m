Return-Path: <dmaengine+bounces-6584-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F799B5A347
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575197B379F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140D1FBEB6;
	Tue, 16 Sep 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="QYC890Jq";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="5LVDcZRo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA131BC9F;
	Tue, 16 Sep 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054992; cv=none; b=j1qRxH6qwhWAKjdUh3HcQ+KF3SyX1ZzDLJb8n43qsFS8pzVdRfJkKayiiE5SCTvoo8ItXpNku9/Nlyfp9WeEtasQWX7AuKGdd6KFLjPM5wagI4ELGJSAeaIugHqzJTTg2qP9bfrFbfBO1Ajd7AR0vPyrudWp2uh049dTZRFoj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054992; c=relaxed/simple;
	bh=bvBuTVi6aDRmqQt6s8gCawcYt5/NLCH3CkL+959SCAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXk+Negwn1DDUq0LC3PAqSojlmJcx8DSfzVCEvyz5hJYs6bioGPOSi9Yoajyewp7NahB0gcEG1BpRT7YcH6H7b9pGs2MLMRTggsVYU8AYHxd0YbiaqlIGuVfgmSMFpooVC97GW05foSkSCU4t+QA6ec9VyRY2wKe0hdv8UYiNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=QYC890Jq; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=5LVDcZRo; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1758054802; bh=wx0QdjxydDmrBFDNOoQQ5/u
	IBMbJD/oNitoYkWZcuC0=; b=QYC890JqZyfvPL4vqX1iuAz85TSGvZNs5qAS35MYC+22MBvW7W
	iskQ/WenBh0sSTeuVw2g4lZHoYPoiv2GGsiFUWUKFSkU2zjwAoKIfhh6KCfgHkaD/kzS8GS68rS
	5QxPQHc77pqj7NtCJnL98hSHNC/QK6suWUKMCY1iS34BYG6fYsZQ/3dpcvNdRz6I2AV2MVmHjwu
	YuaU6JaX/xZbIKJ6+kGLuBOfuRai4gyokobGwnVBSAZFlMDcIGJhjDWqDCzz5y0qkraPWvzgro4
	KM9+tBTzW+WGrtu1sDguiqrnfvt9vS5JK5S2VnGn8CNEa8jaBdqwZu+SFboo2ClciJw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1758054802; bh=wx0QdjxydDmrBFDNOoQQ5/u
	IBMbJD/oNitoYkWZcuC0=; b=5LVDcZRoMcSN9ktKl9Pg4tEUVZHPmNTbYq67qVDbHUTddPsvdm
	Jrh1Ji00j9vzj2yndXJA43uiUpoeW80faoDg==;
From: Dang Huynh <dang.huynh@mainlining.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org,
 linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 00/25] RDA8810PL Clock, RTC and MMC driver
Date: Tue, 16 Sep 2025 20:33:16 +0000
Message-ID: <14470724.O9o76ZdvQC@melttower>
In-Reply-To: <2025091620264900a32db6@mail.local>
References:
 <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
 <2025091620264900a32db6@mail.local>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

On Tuesday, September 16, 2025 8:26:49=E2=80=AFPM Coordinated Universal Tim=
e Alexandre=20
Belloni wrote:
> Hello,
>=20
> On 17/09/2025 03:07:17+0700, Dang Huynh wrote:
> > This patch series aims to add support for Clock/Reset, Real-Time Clock =
and
> > SDMMC on the RDA Micro RDA8810PL platform.
>=20
> What are the dependencies between the various drivers? Ho< do you expect
> the patches to be merged?
The MMC driver depends on the clock controller (for getting APB2 rates) and=
=20
IFC for transferring data.
>=20
> If the RTC patches are independent, please send them separately.
They're independent. Noted.
>=20
> > It also adds Intelligent Flow Controller (IOW, a DMA controller) which =
is
> > important for working with this MMC IP.
> >=20
> > Tested on the Orange Pi 2G-IOT.
> >=20
> > Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> > ---
> >=20
> > Dang Huynh (25):
> >       ARM: dts: unisoc: rda8810pl: Add label to GPIO nodes
> >       drivers: gpio: rda: Make IRQ optional
> >       dt-bindings: gpio: rda: Make interrupts optional
> >       rtc: Add timestamp for the end of 2127
> >       dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
> >       rtc: Add driver for RDA Micro SoC
> >       ARM: dts: unisoc: rda8810pl: Enable Real-Time Clock
> >       ARM: dts: unisoc: rda8810pl: Enable ARM PMU
> >       dt-bindings: clock: Add RDA Micro RDA8810PL clock/reset controller
> >       drivers: clk: Add Clock and Reset Driver for RDA Micro RDA8810PL =
SoC
> >       dts: unisoc: rda8810pl: Enable clock/reset driver
> >       dts: unisoc: rda8810pl: Add OPP for CPU and define L2 cache
> >       dts: unisoc: orangepi: Disable UART with no users
> >       dt-bindings: power: reset: Add RDA Micro Modem Reset
> >       power: reset: Add basic power reset driver for RDA8810PL
> >       dts: unisoc: rda8810pl: Enable modem reset
> >       drivers: gpio: rda: Make direction register unreadable
> >       dt-bindings: dma: Add RDA IFC DMA
> >       dmaengine: Add RDA IFC driver
> >       dts: unisoc: rda8810pl: Enable IFC
> >       dt-bindings: mmc: Add RDA SDMMC controller
> >       mmc: host: Add RDA Micro SD/MMC driver
> >       dts: unisoc: rda8810pl: Add SDMMC controllers
> >       dts: unisoc: orangepi-2g: Enable SD Card
> >       dts: unisoc: orangepi-i96: Enable SD Card
> > =20
> >  .../bindings/clock/rda,8810pl-apsyscon.yaml        |  44 ++
> >  Documentation/devicetree/bindings/dma/rda,ifc.yaml |  42 +
> >  .../devicetree/bindings/gpio/gpio-rda.yaml         |   3 -
> >  Documentation/devicetree/bindings/mmc/rda,mmc.yaml |  91 +++
> >  .../bindings/power/reset/rda,md-reset.yaml         |  36 +
> >  .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    |  30 +
> >  MAINTAINERS                                        |  30 +
> >  .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts  |  24 +-
> >  .../arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts |  24 +-
> >  arch/arm/boot/dts/unisoc/rda8810pl.dtsi            | 115 ++-
> >  drivers/clk/Kconfig                                |   1 +
> >  drivers/clk/Makefile                               |   1 +
> >  drivers/clk/rda/Kconfig                            |  14 +
> >  drivers/clk/rda/Makefile                           |   2 +
> >  drivers/clk/rda/clk-rda8810.c                      | 770
> >  +++++++++++++++++++ drivers/dma/Kconfig                               =
 |
> >   10 +
> >  drivers/dma/Makefile                               |   1 +
> >  drivers/dma/rda-ifc.c                              | 450 +++++++++++
> >  drivers/gpio/gpio-rda.c                            |   4 +-
> >  drivers/mmc/host/Kconfig                           |  12 +
> >  drivers/mmc/host/Makefile                          |   1 +
> >  drivers/mmc/host/rda-mmc.c                         | 853
> >  +++++++++++++++++++++ drivers/power/reset/Kconfig                     =
 =20
> >  |   9 +
> >  drivers/power/reset/Makefile                       |   1 +
> >  drivers/power/reset/rda-reboot.c                   |  58 ++
> >  drivers/rtc/Kconfig                                |  11 +
> >  drivers/rtc/Makefile                               |   1 +
> >  drivers/rtc/rtc-rda.c                              | 356 +++++++++
> >  include/dt-bindings/clock/rda,8810pl-apclk.h       |  79 ++
> >  include/dt-bindings/dma/rda-ifc.h                  |  28 +
> >  include/linux/rtc.h                                |   1 +
> >  31 files changed, 3079 insertions(+), 23 deletions(-)
> >=20
> > ---
> > base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
> > change-id: 20250916-rda8810pl-drivers-9a5271452635
> >=20
> > Best regards,

Best regards,
Dang



