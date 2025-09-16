Return-Path: <dmaengine+bounces-6557-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D49B5A253
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92027A4878
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518B2F8BCA;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc/QtC1j"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511418C03F;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054325; cv=none; b=fSHCzpq3KAZ32vpexzAoI5tsvJFN9p0HDZ6oM2uIlG1y4Z1/np8Y3529Flwst4/JYjHfR72IcFsYL3tA9vHorS0UYzOaEoiPUHeZ73AnW5RbYMdnqG8BtfTYvmcaiopQ8SUqwfxCDNZyesHPzm29yDhldQzwBRLPtCxfc9l3jS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054325; c=relaxed/simple;
	bh=QGD8kRGBo4syZf/wQP0MSt3nT94Hk5NSzVk+3pfI8QQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lYVj+CCEjJD7bX7fwSlpy1OHq9KdwZ4S8o89O2V1zBsZSYsRRQsbli6NId2RWKGRK+JS5lryes+9VqQlvFYY47JtU+hZ7sWCr5b17hvwcVLwvESKo6S4ksnbr0bQDoPvkNryp/WbfPUgFz/iaI2tM23VckwxSUlCaqwqZVcIKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc/QtC1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC192C4CEF7;
	Tue, 16 Sep 2025 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=QGD8kRGBo4syZf/wQP0MSt3nT94Hk5NSzVk+3pfI8QQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Bc/QtC1jTVGH93BHR0pPdFgnDWDiNw3YTMnrSYbNo5hzlhrYakGO1MUHm7c9t+0So
	 ztRNowvJb/dEQgN01xDy/8axTbgwBjY4MTcgvysVORMpR4pDfdBQNXAaZz5oO+QfqT
	 QUCysrVApvuz7qQ94K+Wk8t+qg3iynCibdG+TwwGV30GlvczfNFpFObHGfbTr2nDKQ
	 H6tcPcxlgloeSlIOqmQ5xdrKhKoEqnQiPLp+PQrXHwNEWT8MV3f+v0vxVk2kzJ5dyp
	 XPpV8tnYMJr7sKnPvmKh0knnUuzMSmkSjD6bMGB2vBXOpN/UVSa6rU6X++NSHnQ8zP
	 YByqX4+RF81tA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56EBCAC598;
	Tue, 16 Sep 2025 20:25:24 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Subject: [PATCH 00/25] RDA8810PL Clock, RTC and MMC driver
Date: Wed, 17 Sep 2025 03:24:57 +0700
Message-Id: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJnHyWgC/x3MQQqAIBBA0avErBPUsrKrRAvJqQbCYgQJxLsnL
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=3886;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=QGD8kRGBo4syZf/wQP0MSt3nT94Hk5NSzVk+3pfI8QQ=;
 b=9zchpSAFwjr+IQK2dMLrZvsWvEJuMCoEzZv1nMsFWfTxwY7t6r94fNp29tagymUqPmbGLtAjS
 obpQLZLCJPKAv4jwBuj4UgTE75ucWgSclNMjDGj95eHLrisstZxh3Pc
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

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



