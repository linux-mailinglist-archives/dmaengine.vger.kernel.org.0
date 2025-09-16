Return-Path: <dmaengine+bounces-6552-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E696B5A21A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7477117D7F2
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D22E973C;
	Tue, 16 Sep 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="hLpu4gSl";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="WW2JIo0s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8D27AC48;
	Tue, 16 Sep 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053611; cv=none; b=j2bt5TOZD5YmR6hnnVxvuCkkwm8rskOhW39oDS7axv0YXeZPkVCW4h6t2LtlnN76k5Xt3ZP+em//v4ONhVgMevrJzx6Bw21kBuKHaZLREN4oTT7pNf9Im6/XXB4MXvdTsybwSAbP5byXVMQXgKrG9JZLx03nHoTm1bv4wU/jjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053611; c=relaxed/simple;
	bh=YAW/bGAZr0vX0B6I3xTMN5lJP76jY17Qpzu5kruaYow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngO2F6Rlv/ZZ8Tj3+wscsI9AtTl3YBgJ2AnDhG3LnikhrluyB3HRemdf/bhYhakrmg9Y3GCNGtdMXyMF5K9qH2VMkoPujo7mzr0NFHKrEYLQwNVsXg8DEQD8/d2SXvEY0xxElqHhdQQeAz2E593d2SmFN9ErIw0pvmF1Hl7iMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=hLpu4gSl; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=WW2JIo0s; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053329; bh=6lN5YbmxbG/JdV5+gZzIcdJ
	o4H8J9c8mF3XBOEa05S8=; b=hLpu4gSl1jUGXNE9Jtq/BksnXL/x6+ICzqiMfsphzYiXfHyPb9
	FzXgbXb1KMk2HpiDx3H/GxNX+O+zylMx6B1er3bfaQ8poLbnrDUXnJRdyXNrULoKEwIkaCflr06
	eW0PU1YS9x05pJS7Tb/lX5/Pkuua6NSoCfNZvpyGh3Na54OWH2lgrcDgN98BKPcqM1nnoil80Tc
	dfChPmiDEQVQ0ZKR2TYDSuYNN1RsUoc2Znc4EQf40XEwa5tXHL4IZJl42j68daIjtnodTmq5gCR
	GxM8UHMpv6qKv5iKMmESGTPRXAR7Ro7ekduH4NyreNgECjUK/PL4GI1Upc5lI+ugqHQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053329; bh=6lN5YbmxbG/JdV5+gZzIcdJ
	o4H8J9c8mF3XBOEa05S8=; b=WW2JIo0sHtcyCBqdqSLDMcibs+YiyPBXlFihkQKr/CHOHUIjFb
	LMMxuDRvcSYaNmZhccDXN5Cfo6aHj8e+TSCg==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Wed, 17 Sep 2025 03:07:25 +0700
Subject: [PATCH 08/25] ARM: dts: unisoc: rda8810pl: Enable ARM PMU
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-8-74866def1fe3@mainlining.org>
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org>
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


