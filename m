Return-Path: <dmaengine+bounces-6646-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2BEB86872
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627271C83F0B
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823EA2D73B2;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATGpncwy"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B85E28CF56;
	Thu, 18 Sep 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221398; cv=none; b=geCw6kZMzewxtfdC5OtVk4hjpANT0DnwUOLvkzWm6XheuFLIwC4ULPBMqZHh9WcCYYi1GwGllL8Q/hz4NS6wsbeqglyk8MFm+soGel6b2C4x3aLGRAR2p1YGdqRIkG758Xdfc37mbW6dpWbAYcUx0Uq67TVIKH2EXJUaxVgIAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221398; c=relaxed/simple;
	bh=kZ31Cj+9SlIwCue4nf87udZAy0O4rgTArK6cH8v5gE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YTcRaeCxWhiiCNRmuIGDslsIMAM1lVEsgdsKNHtQXXJM2h+ELthpaAI+RJ3LucvsLydyjqkb0mBoRX4oQK32YAwhX5QuslE/c4lX1FZPSfthehQ8/7J0et5S90zfHOhaG66HPqckp7rV80u0ggbo5875zSmH5VkAWKATHeZ7OqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATGpncwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9BD4C4CEF0;
	Thu, 18 Sep 2025 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758221397;
	bh=kZ31Cj+9SlIwCue4nf87udZAy0O4rgTArK6cH8v5gE0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ATGpncwy2bS+wQApNWWCLiBfVItH2WsyhrR5OU2hxOuEYThCgq5qokSue4tke0Sma
	 9UhVm+nW7/SCeJJQS2Ti2LGwPiungb6RyUjKuG9hHRzrzxfHSlAOJb4NFJfHwZp9QZ
	 lQWJYNZk7Kfvh5+lIa/IFCuzcVsRlrY7jwzun+mrxv7eAU3JrN3E1go77oeYZp954E
	 tILkcGL9x9F3KSKp343DZ5TcIPDYxyvRKxa3CmR1JXU/tBLTtSamZtNqc0KlSReeuJ
	 Blz7hd1ilSLhGOSVGxt2Q+5XH7gl56r746zq7MuwLVqarjjwJy86bblAx71C3ueyE6
	 tfP97FdQaWD0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB476CAC597;
	Thu, 18 Sep 2025 18:49:57 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Subject: [PATCH 00/10] RDA8810PL SD/MMC support
Date: Fri, 19 Sep 2025 01:48:40 +0700
Message-Id: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhUzGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0ML3aKURAsLQ4OCHN3c3GRd4zRj4yQL42RjQ+MUJaCegqLUtMwKsHn
 RsbW1ANyU/p1fAAAA
X-Change-ID: 20250918-rda8810pl-mmc-3f33b83c313d
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758221395; l=2690;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=kZ31Cj+9SlIwCue4nf87udZAy0O4rgTArK6cH8v5gE0=;
 b=qOqMjxWy0QtL3Ogxpb8gkzjO7d5vmQGyKe+kb/6NkDaSg1BsYLRsnjbZgBDstvASeAx0n2d2c
 3shNDl4Z4C4Bf3HZJfK9hqW3+uGf3bq50x8EsDU0gvAu95HssYcfjYM
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

This patch series aims to add SDMMC driver and various drivers required
for SDMMC controller to function.

This also fixed a bug where all the GPIO switched from INPUT to OUTPUT
after the GPIO driver probed or by reading the GPIO debugfs.

This patch series is a split from [1] to ease the maintainers.

Tested on Orange Pi 2G-IOT using a Buildroot environment.

[1]: https://lore.kernel.org/all/20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org/

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
Dang Huynh (10):
      dt-bindings: gpio: rda: Make interrupts optional
      dt-bindings: clock: Add RDA Micro RDA8810PL clock/reset controller
      dt-bindings: dma: Add RDA IFC DMA
      dt-bindings: mmc: Add RDA SDMMC controller
      gpio: rda: Make IRQ optional
      gpio: rda: Make direction register unreadable
      clk: Add Clock and Reset Driver for RDA Micro RDA8810PL SoC
      dmaengine: Add RDA IFC driver
      mmc: host: Add RDA Micro SD/MMC driver
      ARM: dts: unisoc: rda8810pl: Add SDMMC controllers

 .../bindings/clock/rda,8810pl-apsyscon.yaml        |  43 ++
 Documentation/devicetree/bindings/dma/rda,ifc.yaml |  45 ++
 .../devicetree/bindings/gpio/gpio-rda.yaml         |   3 -
 Documentation/devicetree/bindings/mmc/rda,mmc.yaml |  92 +++
 MAINTAINERS                                        |  18 +
 .../boot/dts/unisoc/rda8810pl-orangepi-2g-iot.dts  |  20 +
 .../arm/boot/dts/unisoc/rda8810pl-orangepi-i96.dts |  20 +
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi            |  47 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/rda/Kconfig                            |  14 +
 drivers/clk/rda/Makefile                           |   2 +
 drivers/clk/rda/clk-rda8810.c                      | 769 +++++++++++++++++++
 drivers/dma/Kconfig                                |  10 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/rda-ifc.c                              | 450 +++++++++++
 drivers/gpio/gpio-rda.c                            |   4 +-
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/rda-mmc.c                         | 853 +++++++++++++++++++++
 include/dt-bindings/clock/rda,8810pl-apclk.h       |  70 ++
 include/dt-bindings/dma/rda-ifc.h                  |  28 +
 22 files changed, 2495 insertions(+), 9 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-rda8810pl-mmc-3f33b83c313d

Best regards,
-- 
Dang Huynh <dang.huynh@mainlining.org>



