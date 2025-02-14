Return-Path: <dmaengine+bounces-4480-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B3AA36554
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD083B372D
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E4269AE1;
	Fri, 14 Feb 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L/dedf1j"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368D269806;
	Fri, 14 Feb 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556529; cv=none; b=UFL+KR0ZCmsTVW6kLsvF3HarSTF2V5AAUmbFVpxIaXZKe91Yxf+P0Je9TtD/SBW1uIy7zijsplKsHWH1ThJzvuH6StMZR+NOEUngI2PdB5FP+BuiYITmFwM7axdl6p7BeU57wJybHvGbwZehw9ZBXZW0k1fkqcl82EQcDMIeL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556529; c=relaxed/simple;
	bh=yO1T4LqfZi3vJny22a1HZxYVACCF1g0E5YEV0A24JH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Npjlh3IHOINEgVd+tguy6Lo5DDiz2vOXH9wVF9FtE1yjh5zlmMfFYeY3yM7AqIhuHu1yTENjv1SP92DBneGByj50iqL8ICQ18P1R1Hqdna/rsWjU2ox9nenEi50ovHrKGPev7i+OyjGrD5DPgV0iSpknVSLFNIJuzXE/uyEmqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=L/dedf1j; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739556528; x=1771092528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yO1T4LqfZi3vJny22a1HZxYVACCF1g0E5YEV0A24JH4=;
  b=L/dedf1jUH3tAVf7OV9pAxjaIn648FZ4y9IpP8w5PB4A7Pk/rxYPamxA
   FGrZ60E6fwqQiZVlJuwXL6WIQCU4DlnpigpGGAuaPTrTaOTTlfga8BK5n
   4M5PrBKKIaMTexbtK+VsoMBTLuYCZRnEpORIuEMKxP/zyMm2U7hKkf2A8
   11mYkrg2WXvxKeUCHXGYov9XYJAsIDv0FqTnPQE2GMZyWJtVe81pEEQcs
   Kgid4cI33m6lnEOvL5ElQe766FAzNs+QzQ+GI33CDrjQ7eQSlmkfL1c8X
   DK8wV0oUOvWzFAL4oBzVXgrCygWX66rQQQOqsQ7y2SJL/XBhg6MVC31fj
   Q==;
X-CSE-ConnectionGUID: afEECSQvQkGMMmDvtHvTFg==
X-CSE-MsgGUID: AB1UyuEZQfyQS6dgQjsgaA==
X-IronPort-AV: E=Sophos;i="6.13,286,1732604400"; 
   d="scan'208";a="37700930"
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
Subject: [PATCH 5/8] ARM: dts: microchip: sama7d65: Add chipID for sama7d65
Date: Fri, 14 Feb 2025 11:08:18 -0700
Message-ID: <14e6cafb64df345e6bd79ac96961248cc266770c.1739555984.git.Ryan.Wanner@microchip.com>
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

Add chipID for the sama7d65 SoC to the device tree.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 854b30d15dcd4..b1b236e1f6e38 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -83,6 +83,11 @@ clk32k: clock-controller@e001d500 {
 			#clock-cells = <1>;
 		};
 
+		chipid@e0020000 {
+			compatible = "microchip,sama7d65-chipid";
+			reg = <0xe0020000 0x8>;
+		};
+
 		sdmmc1: mmc@e1208000 {
 			compatible = "microchip,sama7d65-sdhci", "microchip,sam9x60-sdhci";
 			reg = <0xe1208000 0x400>;
-- 
2.43.0


