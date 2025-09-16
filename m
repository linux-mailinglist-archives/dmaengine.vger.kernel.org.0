Return-Path: <dmaengine+bounces-6555-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3CCB5A232
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 22:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A7632776C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F67323F49;
	Tue, 16 Sep 2025 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="N9avug74";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="+UEbWfgl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B231E882;
	Tue, 16 Sep 2025 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053713; cv=none; b=FOZqRMJ8QfQSiUpyryE6uSTpv01NRc3xGtK6Rj1S53UdhtZXLMy/rlVLOqs36F7bpq+y8VWJKCA0aCoBngpwf4uxNZHNv75f9001QhXI/64UR8tVFWVkpkL0JWSv8jFLX0N4DmLBs6FQ7EChvsg9iqZDDDju2AlohkdKGW53Anc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053713; c=relaxed/simple;
	bh=CMytnUCPsfWK+Zir9iDw5CkhUnTaS4MnLkyTK6BwbAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwbWF7Ny4RVwM4fCWSW3M4tlDXJay/MfiYBZPCFRXsRujADXSs+b0bgHLHpkXbmgvTEQLaQyd2ZDD18KZdgWV64bvEbLGgDpTe92uLiJ+T5aE3bRukoW6YZUtDCWF9J7OurPJp7Utj+g1qEYSUQZB3ojkls6GPvmlpxsw3BxlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=N9avug74; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=+UEbWfgl; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053322; bh=m2MYMZ5GH2aKaBSXKUqmZnI
	p2X6lhxbwqG/MojCQ8J0=; b=N9avug74FsHmuT0w65ICc5KFEzuRYgwfWgK0aZaQwGjCm37Ca9
	Atc7UgHQmB5KL86/zV2wSlSOBGf1x5V8CCmqGyuq4FA7I5fryooCeWijBjsUJxxKMvkIbPB2JKd
	UZHIoxbdpKtp2eyY18WMDtvZ7uUBkiO+oBtSwTpMqZpgjAgKxFG+PI17ssuwvb++wnqfzpC88Wn
	uV2WWfDZWo+ZvSZgx6d5nD5RzLy4HmVrDO9KeSqaHTWjy9x5ftoIfDaI5o/7axwkl5CZ7CMn4IL
	4kllWiDcslB9ImPM0HzsEWLi0Q4hTVJVxz065jR92DjmgB8Dlj984ONiTJMBVLHAc8A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1758053322; bh=m2MYMZ5GH2aKaBSXKUqmZnI
	p2X6lhxbwqG/MojCQ8J0=; b=+UEbWfglRYL7StMUczR+FHfgFwsYeVsy51nLf+5LpO5BnKhFzp
	xpKbfFEhFi4KXFCqCO18t70nbIKRYNl3FeDg==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Wed, 17 Sep 2025 03:07:24 +0700
Subject: [PATCH 07/25] ARM: dts: unisoc: rda8810pl: Enable Real-Time Clock
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-rda8810pl-drivers-v1-7-74866def1fe3@mainlining.org>
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

The RDA8810PL has built-in RTC.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/boot/dts/unisoc/rda8810pl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
index 6553fc102c6751696e75e4de614fc3428d182061..609359aa91537168435934077e736b216adf50f4 100644
--- a/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/unisoc/rda8810pl.dtsi
@@ -39,6 +39,11 @@ modem@10000000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x10000000 0xfffffff>;
 
+		rtc@1a06000 {
+			compatible = "rda,8810pl-rtc";
+			reg = <0x1a06000 0x1000>;
+		};
+
 		gpioc: gpioc@1a08000 {
 			compatible = "rda,8810pl-gpio";
 			reg = <0x1a08000 0x1000>;

-- 
2.51.0


