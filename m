Return-Path: <dmaengine+bounces-6563-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B22B5A27D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1ABA327BD5
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9103294FE;
	Tue, 16 Sep 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQK0nw9S"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA58313D52;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054326; cv=none; b=oJmIriuYk/MXi9u+JNUPXybntboZKPaCe2WLEnGlC2OmZrdLu8zrSUYYxpHslT+iuF+kpyo6CaCof93thjT42yL0lLpPeT/sJMG8FXMX4aNRWsx0bJnm7Oo+kUkjdts7i+00m/Ih99/jpoRaJ/dDwUzhaHzhQtrbBNcuNfVieNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054326; c=relaxed/simple;
	bh=e/qC+sVxQ9TrDHhG0wtazM84HxOMKYeszZU0EuODGJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJ2wBpUBrX+60J3INKJoeoLGWpmHyfu5YrTYu9G8HPsryBk+nDEELopTBJiCdJe/BlEiGE/Nhj+vMDsb8wBiSBuo7GKqlQDLA8btWaA73UqaBvMgZJ0aGykr0eq+YeGpoTE81n8uwJLZb7A+Vo1p2kzbRlhPVbzJhCL0nqx6KwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQK0nw9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67AB2C116C6;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054325;
	bh=e/qC+sVxQ9TrDHhG0wtazM84HxOMKYeszZU0EuODGJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JQK0nw9SBa2eVYYGvCy8nmx53sGgdLx/FyORN5DzspfPQt24tLYQaFsC0MlDud1S2
	 gIqO9nWVRE7MYLVeiI6LJTf5FbkB0ApYljJ1zvIGfwRTLJPEaxiPzTgsEHcEA5+i5C
	 hOnnQENAY9wP8qMtTl9iyauSoX280tEPoDukO3TsmW+mw58CCW5/2kHl+QZ47IPoFf
	 18lavy+cYon26CUGzTIpIOuny0U7Q9DCsvLl9N2C8Q5vTLX2Tpkdw2BdV7R7ugEyjC
	 OPScv0AHz21XahXWoff39Uiin5vexBF9oDsNfFcuf7h8e5nCrLxpkS/oQd3oUqmh4A
	 Wz1x4ynN10zRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F238CAC592;
	Tue, 16 Sep 2025 20:25:25 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Wed, 17 Sep 2025 03:25:05 +0700
Subject: [PATCH 08/25] ARM: dts: unisoc: rda8810pl: Enable ARM PMU
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-8-9ca9184ca977@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-9ca9184ca977@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758054322; l=907;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=YAW/bGAZr0vX0B6I3xTMN5lJP76jY17Qpzu5kruaYow=;
 b=Xx4eEf+AW3RfI/PbEY5JiaKmRAPppuTYEIz3HyHrxewzcQWqWGWhkO1ddTilsHUwqfkZstlrk
 2wL45PEan/qADgsP0ddnn6WAkTtuRkV+QW9c5fDgsFPwxfxBZIgttWj
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
Reply-To: dang.huynh@mainlining.org

From: Dang Huynh <dang.huynh@mainlining.org>

The SoC uses a standard ARM PMU, enable it.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index 609359aa91537168435934077e736b216adf50f4..45a2fd3e04cea5aac4fb6b40a6b332ce3eee4f2c 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -6,6 +6,7 @@
  * Copyright (c) 2018 Manivannan Sadhasivam
  */
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -25,6 +26,11 @@ cpu@0 {
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a5-pmu";
+		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	sram@100000 {
 		compatible = "mmio-sram";
 		reg = <0x100000 0x10000>;

-- 
2.51.0



