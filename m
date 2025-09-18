Return-Path: <dmaengine+bounces-6613-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A239B82EFB
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 07:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4F1161981
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 05:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59753241664;
	Thu, 18 Sep 2025 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="pE5jBfSv";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="g46MYSrN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9A1F3FEC;
	Thu, 18 Sep 2025 05:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171975; cv=none; b=YOTIBMKfwLpcSvT/T95r672wl6a9O0lEMeNBTIzNmp/Ytxd2occM8UtuWMslvujpSAMYVnsDPyJMCn1JOeBnbcghlB7hpJ9ngQhrV6n6efKUD6a8ZPvQ0xMmpzXHlchBMFrmCwDipbw2GTORpu26FYwxivJdOqOU6EQP3XEhFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171975; c=relaxed/simple;
	bh=f+/zAaJ0teiDY3KPMj73HZGvo94OMDlTnUVHWKEzMZY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O9h1osaDTa53SzZ0nCJcSoYkuEmLrv3DNrVJEjuqNzBEX6w3v2W8vhJ6ndvmbX4/0l+AvVcLg8Mzad+9XfxWq7+MkfMgFEE0mQe3wNXEH39IhAUWg8EdnbDkqcpPRLrX8qBsuEDx9UDL5FhwD4dNN8p+y9AIaFX5UYmLmwD3wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=pE5jBfSv; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=g46MYSrN; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758171735; bh=ILJJ/4RQIN/3m+STfmaTRfX
	8whGDO74Pn1jtvUnbn8s=; b=pE5jBfSvsZUrjCB9VH6XNAMZoNEICEMvUDFtf4Z5OJj9cKIyXD
	7qdg9SdfyvHtVx8KHdFdvp/lp/7vz3QsASIZiUEdJHe+RNdDlyCxi3xC8skGngfqxPUI28SVA3U
	JAEh1wL/k4xi61M7u1hZb/UW6rR/pROpxF24/K1q7CJ5S0g79l6tpY13aNJFxntzea2f7ZLhzBb
	hL8ilZX8Z0jkT02I77hRQrzWidUfEY3jZtWxfU8KExf5nZ6xCYU7/iB2zm1I+lmcvW6i6hM38Tc
	e4N6D5ulDIft3V4zm999O4KQ4mUhtmYCuO6NngPSmiA0xXnlS9Jl8vNvNvX+3CBAwgA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1758171735; bh=ILJJ/4RQIN/3m+STfmaTRfX
	8whGDO74Pn1jtvUnbn8s=; b=g46MYSrNOlMn39zgBFesxBeZplRiG9bUuue5Tshga8eHr6e40B
	CeEgiAoFZ+JDUeIGMWGo3oFQR5qxRlcizNBg==;
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Sep 2025 12:02:14 +0700
From: Dang Huynh <dang.huynh@mainlining.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-mmc@vger.kernel.org
Subject: Re: [PATCH 00/25] RDA8810PL Clock, RTC and MMC driver
In-Reply-To: <lnfervvwctvemjdmyue2aohlsqpfd5gsuzjho3u6mtdtewl4vr@saqnionh72am>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
 <lnfervvwctvemjdmyue2aohlsqpfd5gsuzjho3u6mtdtewl4vr@saqnionh72am>
Message-ID: <bf5b90c8a03765a7145b6e985c3e23f9@mainlining.org>
X-Sender: dang.huynh@mainlining.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-17 17:03, Manivannan Sadhasivam wrote:
> On Wed, Sep 17, 2025 at 03:24:57AM GMT, Dang Huynh via B4 Relay wrote:
>> This patch series aims to add support for Clock/Reset, Real-Time Clock 
>> and
>> SDMMC on the RDA Micro RDA8810PL platform.
>> 
>> It also adds Intelligent Flow Controller (IOW, a DMA controller) which 
>> is
>> important for working with this MMC IP.
>> 
>> Tested on the Orange Pi 2G-IOT.
>> 
> 
> Thanks for work! Is it possible to split this patchset logically to 
> ease
> reviewing and also merging? It currently touches different subsystems 
> and has 25
> patches.
> 
> You could easily split this into different series adding Clock/Reset, 
> RTC, IFC,
> SDMMC and other misc patches in one series.
Will do. Is it possible for you to test it on your i96 board?

> 
> - Mani
> 
>> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
>> ---
>> Dang Huynh (25):
>>       ARM: dts: unisoc: rda8810pl: Add label to GPIO nodes
>>       drivers: gpio: rda: Make IRQ optional
>>       dt-bindings: gpio: rda: Make interrupts optional
>>       rtc: Add timestamp for the end of 2127
>>       dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
>>       rtc: Add driver for RDA Micro SoC
>>       ARM: dts: unisoc: rda8810pl: Enable Real-Time Clock
>>       ARM: dts: unisoc: rda8810pl: Enable ARM PMU
>>       dt-bindings: clock: Add RDA Micro RDA8810PL clock/reset 
>> controller
>>       drivers: clk: Add Clock and Reset Driver for RDA Micro RDA8810PL 
>> SoC
>>       dts: unisoc: rda8810pl: Enable clock/reset driver
>>       dts: unisoc: rda8810pl: Add OPP for CPU and define L2 cache
>>       dts: unisoc: orangepi: Disable UART with no users
>>       dt-bindings: power: reset: Add RDA Micro Modem Reset
>>       power: reset: Add basic power reset driver for RDA8810PL
>>       dts: unisoc: rda8810pl: Enable modem reset
>>       drivers: gpio: rda: Make direction register unreadable
>>       dt-bindings: dma: Add RDA IFC DMA
>>       dmaengine: Add RDA IFC driver
>>       dts: unisoc: rda8810pl: Enable IFC
>>       dt-bindings: mmc: Add RDA SDMMC controller
>>       mmc: host: Add RDA Micro SD/MMC driver
>>       dts: unisoc: rda8810pl: Add SDMMC controllers
>>       dts: unisoc: orangepi-2g: Enable SD Card
>>       dts: unisoc: orangepi-i96: Enable SD Card
>> 
>>  .../bindings/clock/rda,8810pl-apsyscon.yaml        |  44 ++
>>  Documentation/devicetree/bindings/dma/rda,ifc.yaml |  42 +
>>  .../devicetree/bindings/gpio/gpio-rda.yaml         |   3 -
>>  Documentation/devicetree/bindings/mmc/rda,mmc.yaml |  91 +++
>>  .../bindings/power/reset/rda,md-reset.yaml         |  36 +
>>  .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    |  30 +
>>  MAINTAINERS                                        |  30 +
>>  .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts  |  24 +-
>>  .../arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts |  24 +-
>>  arch/arm/boot/dts/unisoc/rda8810pl.dtsi            | 115 ++-
>>  drivers/clk/Kconfig                                |   1 +
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/rda/Kconfig                            |  14 +
>>  drivers/clk/rda/Makefile                           |   2 +
>>  drivers/clk/rda/clk-rda8810.c                      | 770 
>> +++++++++++++++++++
>>  drivers/dma/Kconfig                                |  10 +
>>  drivers/dma/Makefile                               |   1 +
>>  drivers/dma/rda-ifc.c                              | 450 +++++++++++
>>  drivers/gpio/gpio-rda.c                            |   4 +-
>>  drivers/mmc/host/Kconfig                           |  12 +
>>  drivers/mmc/host/Makefile                          |   1 +
>>  drivers/mmc/host/rda-mmc.c                         | 853 
>> +++++++++++++++++++++
>>  drivers/power/reset/Kconfig                        |   9 +
>>  drivers/power/reset/Makefile                       |   1 +
>>  drivers/power/reset/rda-reboot.c                   |  58 ++
>>  drivers/rtc/Kconfig                                |  11 +
>>  drivers/rtc/Makefile                               |   1 +
>>  drivers/rtc/rtc-rda.c                              | 356 +++++++++
>>  include/dt-bindings/clock/rda,8810pl-apclk.h       |  79 ++
>>  include/dt-bindings/dma/rda-ifc.h                  |  28 +
>>  include/linux/rtc.h                                |   1 +
>>  31 files changed, 3079 insertions(+), 23 deletions(-)
>> ---
>> base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
>> change-id: 20250916-rda8810pl-drivers-9a5271452635
>> 
>> Best regards,
>> --
>> Dang Huynh <dang.huynh@mainlining.org>
>> 
>> 

