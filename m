Return-Path: <dmaengine+bounces-6551-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB2B5A213
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA611189F6DC
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDF52E92D0;
	Tue, 16 Sep 2025 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="F1QIsViW";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="zj2OQhKM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704612D1F44;
	Tue, 16 Sep 2025 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053528; cv=none; b=A+k6OBYfGXItD+B9ZG9tUaOYOLL+mY2LEnzECq9yOWN8u07Jk7oNosBHaMr45sxKbfT77Q+dRBKsmQt+T8YNvM2d5MtrpB92OwITZAihM+wYSvOA7gWR77xSUTVcOpgx2murwquVMUKlyXTNH3mZSxCu2Xj2kMVYqNKSRrTiYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053528; c=relaxed/simple;
	bh=QGD8kRGBo4syZf/wQP0MSt3nT94Hk5NSzVk+3pfI8QQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wx8DQ+s7ZH/1du2k/iP1prjS/7U2LaBXfzXW5D1LzsH+VhBTskwYXmgGyxhD/C0zx9TNTIChKVEJotGLJZvwlxS+YHc67Bg5QN/E8NrkAUkDE6HNsfMpikS8MqYoezrzo2TspL8WILAeZQ6Ix8fA08oOPEYAcI20mzIdAYuPXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=F1QIsViW; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=zj2OQhKM; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Date:Subject:From; t=1758053274; bh=C2ElPcuDb7GDFL0BugWYkt/
	VrkTvpyOiSK2rgTU3LY4=; b=F1QIsViWv9H3CNrLHTcx/s1Ozszeb+qquwpUtz++nUQnnY6bKj
	ezdrbyXwPCKt+xtaMuGTe5+K0ey5SqiF5BlYXt7t1B8Iyn/vODdS2aiQmj9kcDw0RkVdG+7r9yk
	ka6cAn9xuFU5FRdBq1RmJRGlNEZYDkX1G4QBjBsYnbv10X4QvoiCF1SWspzqtK6e7f+E3Ti2YEK
	jduCIW5omXXNcBa9eYSlk54eX3tsgOpoceX+dPIMwr6u4GeSsGRsY1kdJUJd8t4QCJw2JVulNZH
	rMBC+jjvhZFDB9ZOo3fl3ZRqrq+u0eIbvAfwVgtJhxlYZ7PWkmvXU5wW04RWYutBiRQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Date:Subject:From; t=1758053274; bh=C2ElPcuDb7GDFL0BugWYkt/
	VrkTvpyOiSK2rgTU3LY4=; b=zj2OQhKMLYaBsfr6zNxJpu0ngi64yyfXN8RIj98ciWChz/axPh
	lXebYFA6fUg6+OUOvjJquJpVfpIWTYIY4aCA==;
From: Dang Huynh <dang.huynh@mainlining.org>
Subject: [PATCH 00/25] RDA8810PL Clock, RTC and MMC driver
Date: Wed, 17 Sep 2025 03:07:17 +0700
Message-Id: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXDyWgC/x3MQQqAIBBA0avErBPUsrKrRAvJqQbCYgQJxLsnL
 d/i/wwRmTDC3GRgTBTpDhWqbWA7XThQkK8GLbWRVg2CvZsmJZ9LeKaEHIV1Ro+qN3roDNTuYdz
 p/Z/LWsoHMTLSk2MAAAA=
X-Change-ID: 20250916-rda8810pl-drivers-9a5271452635
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.2

This patch series aims to add support for Clock/Reset, Real-Time Clock and
SDMMC on the RDA Micro RDA8810PL platform.

It also adds Intelligent Flow Controller (IOW, a DMA controller) which is
important for working with this MMC IP.

Tested on the Orange Pi 2G-IOT.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
Dang Huynh (25):
      ARM: dts: unisoc: rda8810pl: Add label to GPIO nodes
      drivers: gpio: rda: Make IRQ optional
      dt-bindings: gpio: rda: Make interrupts optional
      rtc: Add timestamp for the end of 2127
      dt-bindings: rtc: Add RDA Micro RDA8810PL RTC
      rtc: Add driver for RDA Micro SoC
      ARM: dts: unisoc: rda8810pl: Enable Real-Time Clock
      ARM: dts: unisoc: rda8810pl: Enable ARM PMU
      dt-bindings: clock: Add RDA Micro RDA8810PL clock/reset controller
      drivers: clk: Add Clock and Reset Driver for RDA Micro RDA8810PL SoC
      dts: unisoc: rda8810pl: Enable clock/reset driver
      dts: unisoc: rda8810pl: Add OPP for CPU and define L2 cache
      dts: unisoc: orangepi: Disable UART with no users
      dt-bindings: power: reset: Add RDA Micro Modem Reset
      power: reset: Add basic power reset driver for RDA8810PL
      dts: unisoc: rda8810pl: Enable modem reset
      drivers: gpio: rda: Make direction register unreadable
      dt-bindings: dma: Add RDA IFC DMA
      dmaengine: Add RDA IFC driver
      dts: unisoc: rda8810pl: Enable IFC
      dt-bindings: mmc: Add RDA SDMMC controller
      mmc: host: Add RDA Micro SD/MMC driver
      dts: unisoc: rda8810pl: Add SDMMC controllers
      dts: unisoc: orangepi-2g: Enable SD Card
      dts: unisoc: orangepi-i96: Enable SD Card

 .../bindings/clock/rda,8810pl-apsyscon.yaml        |  44 ++
 Documentation/devicetree/bindings/dma/rda,ifc.yaml |  42 +
 .../devicetree/bindings/gpio/gpio-rda.yaml         |   3 -
 Documentation/devicetree/bindings/mmc/rda,mmc.yaml |  91 +++
 .../bindings/power/reset/rda,md-reset.yaml         |  36 +
 .../devicetree/bindings/rtc/rda,8810pl-rtc.yaml    |  30 +
 MAINTAINERS                                        |  30 +
 .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts  |  24 +-
 .../arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts |  24 +-
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi            | 115 ++-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/rda/Kconfig                            |  14 +
 drivers/clk/rda/Makefile                           |   2 +
 drivers/clk/rda/clk-rda8810.c                      | 770 +++++++++++++++++++
 drivers/dma/Kconfig                                |  10 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/rda-ifc.c                              | 450 +++++++++++
 drivers/gpio/gpio-rda.c                            |   4 +-
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/rda-mmc.c                         | 853 +++++++++++++++++++++
 drivers/power/reset/Kconfig                        |   9 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/rda-reboot.c                   |  58 ++
 drivers/rtc/Kconfig                                |  11 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-rda.c                              | 356 +++++++++
 include/dt-bindings/clock/rda,8810pl-apclk.h       |  79 ++
 include/dt-bindings/dma/rda-ifc.h                  |  28 +
 include/linux/rtc.h                                |   1 +
 31 files changed, 3079 insertions(+), 23 deletions(-)
---
base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
change-id: 20250916-rda8810pl-drivers-9a5271452635

Best regards,
-- 
Dang Huynh <dang.huynh@mainlining.org>


