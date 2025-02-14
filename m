Return-Path: <dmaengine+bounces-4482-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD41A3656C
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 19:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898FB172A13
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE692690F5;
	Fri, 14 Feb 2025 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x0pEMlnI"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD22698A3;
	Fri, 14 Feb 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556530; cv=none; b=ar4PaIWQOXJJrfCaHVeJ8b+4AtdGOWMROCS3XUD48Qw+Gp6hnnkgXlTHufd/mVJVk3r1YwsJPYzcuky7U+PdujkXcSo8jZnWiuHsVds2nOU+wx8D5GTeb8soGSgqwhu1T8sTzwUoWc88xk3i6GNjoN0U5E9MXgmvlxrelouhamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556530; c=relaxed/simple;
	bh=K6+jsMBEPeG5a4vof3OQyYuJjApw91RkV7RMLdW/B2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nA4k5UWypXTh8e9GKOHJeK1L+02bDYC2jc8ZC5Ozcsr8chlV3QwC9ZfpUudPi5BPRPM6miV3ns4irxXV9H7tboOkzAZcfLMRyiKNKyyBecigkiW9MkF0FLZ8KTbbOzvoO7aVQWr/AQEEAhYo7lLybZ1gH6nEbSKoHS22DrmhEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x0pEMlnI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739556529; x=1771092529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6+jsMBEPeG5a4vof3OQyYuJjApw91RkV7RMLdW/B2Q=;
  b=x0pEMlnIE9LQBWoZ5sSDSrlFOh++9AcQX0fpkhcoZBlQDtlrg40keNkJ
   /VrItGDavoQMaeWKBpKcQhnOk8wPKG+A6ewkQCihmED4I9cEjCoRhn8n/
   293whzNlGrFof4wYNkmrZRzXuHYqHSdS/Hko9KHO1xkqqhWFgGnaxa6jm
   m9+jgaQ4uFiP/jA22fzZJqwjXsWxKOFrVKzRsbkW2BhBkuCYocli8iiyH
   bzbaUv72gTy9ru/aJhxmcCFF+cYKpMfXy3ZIn3FF+f5Nd4ntAqTLGL2kZ
   t8oA6WrkfTDsDuToV/TGYAxgBS55RtdKED9/BH/rjjaJS33AT1fK1/p6Y
   g==;
X-CSE-ConnectionGUID: afEECSQvQkGMMmDvtHvTFg==
X-CSE-MsgGUID: Vy7NjoOqR+iWKMmSPvhT5w==
X-IronPort-AV: E=Sophos;i="6.13,286,1732604400"; 
   d="scan'208";a="37700931"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2025 11:08:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Feb 2025 11:08:26 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 14 Feb 2025 11:08:26 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <vkoul@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 6/8] ARM: dts: microchip: sama7d65: Add watchdog for sama7d65
Date: Fri, 14 Feb 2025 11:08:19 -0700
Message-ID: <05431cf86beb742a9a53336c4ec792be8bde14e2.1739555984.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739555984.git.Ryan.Wanner@microchip.com>
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add watchdog timer support for SAMA7D65 SoC.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index b1b236e1f6e38..d06a51972d363 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -83,6 +83,13 @@ clk32k: clock-controller@e001d500 {
 			#clock-cells = <1>;
 		};
 
+		ps_wdt: watchdog@e001d180 {
+			compatible = "microchip,sama7d65-wdt", "microchip,sama7g5-wdt";
+			reg = <0xe001d000 0x30>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk32k 0>;
+		};
+
 		chipid@e0020000 {
 			compatible = "microchip,sama7d65-chipid";
 			reg = <0xe0020000 0x8>;
-- 
2.43.0


