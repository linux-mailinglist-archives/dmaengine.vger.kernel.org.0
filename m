Return-Path: <dmaengine+bounces-4481-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43827A36561
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 19:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11A7173390
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBEA269AE9;
	Fri, 14 Feb 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eAZNQbAC"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEA269823;
	Fri, 14 Feb 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556529; cv=none; b=L9ahoBCbsKBTkbK99XsEo7InhU3iW3dcYUkAHWw4O/NnpXkuzHlJJ94UZJcNSoSMapqQatGBcivueaFQsxbuufQxHiqWjlyFWZSmcLfWk8b6u/+9oF5R0f6Pd6n+Z+jU6SdnDRajHvxblzS5ZRFvbRJYK8cv2PA+vCOiDTYXw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556529; c=relaxed/simple;
	bh=qPQso1ZYtWTmJIC7QhndAu/PixzdR+a209Sd11Fb4Ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1kaepOCjm06JV1m+d9LayNO/B65UViEtwv+KGlogdkqsdGANLQNWB1ddkmOgPvlhYGDJTzbLL4rFy+oOvVJCVV5HL88A40Lt92/pR41UzeWZP2DeTYafUrfYAcKL/och6ZVYfi690rQpoE7BMTowwW0IjAcvfFlrSs08ig6sAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eAZNQbAC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739556528; x=1771092528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPQso1ZYtWTmJIC7QhndAu/PixzdR+a209Sd11Fb4Ig=;
  b=eAZNQbACy9cgmUCtRy7N1QBSSUYAKl03AkIoSeGTnczkdAP/ml8ACDbE
   T4pB3r5EVAQd4Ufcj08bJEgryGWJvAnyPDdrKD1WGZGgO7pZdOSM9LJQG
   R/SRgMcZvwcWuMaXH7skFrCBi7NjsuGKtVWH4Q+824WFwBwcghsqJk345
   Pj3N9446kYtBgr2HWZFz+DPNtu3aivBeGSqzEeXBZcptkXkIcMywBbPa9
   LtaxkNa1G/tEm9Tv4xES6Uodr/GcS7BnWZNOnFGVlq5Bz2cRWNb3GVBtr
   j1E4ZfdYIq9sFpnXNpwmxQRRBmce7FBh6pozIlSIFxpO/+Z27E9yeKbyh
   w==;
X-CSE-ConnectionGUID: afEECSQvQkGMMmDvtHvTFg==
X-CSE-MsgGUID: 2IsM7achQlmES/jyjdqu2w==
X-IronPort-AV: E=Sophos;i="6.13,286,1732604400"; 
   d="scan'208";a="37700928"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2025 11:08:39 -0700
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
Subject: [PATCH 4/8] ARM: at91: Add Support in SoC driver for SAMA7D65
Date: Fri, 14 Feb 2025 11:08:17 -0700
Message-ID: <84b4a7ec0025741bc3ab647671fd4e880b2ed1d5.1739555984.git.Ryan.Wanner@microchip.com>
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

Add support for SAMA7D65 SoC in the SoC driver.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/soc/atmel/soc.c | 5 +++++
 drivers/soc/atmel/soc.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 298b542dd1c06..68f20024dcebb 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -246,6 +246,9 @@ static const struct at91_soc socs[] __initconst = {
 		 "samv70q19", "samv7"),
 #endif
 #ifdef CONFIG_SOC_SAMA7
+	AT91_SOC(SAMA7D65_CIDR_MATCH, AT91_CIDR_MASK_SAMA7G5,
+		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7D65_EXID_MATCH,
+		 "sama7d65", "sama7d6"),
 	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G51_EXID_MATCH,
 		 "sama7g51", "sama7g5"),
@@ -305,6 +308,7 @@ static int __init at91_get_cidr_exid_from_chipid(u32 *cidr, u32 *exid)
 	void __iomem *regs;
 	static const struct of_device_id chipids[] = {
 		{ .compatible = "atmel,sama5d2-chipid" },
+		{ .compatible = "microchip,sama7d65-chipid"},
 		{ .compatible = "microchip,sama7g5-chipid" },
 		{ },
 	};
@@ -393,6 +397,7 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 	{ .compatible = "atmel,at91sam9", },
 	{ .compatible = "atmel,sama5", },
 	{ .compatible = "atmel,samv7", },
+	{ .compatible = "microchip,sama7d65",},
 	{ .compatible = "microchip,sama7g5", },
 	{ }
 };
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 2c78e54255f7f..66a74017d9a3e 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -45,6 +45,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
 #define SAM9X7_CIDR_MATCH		0x09750020
+#define SAMA7D65_CIDR_MATCH		0x00262100
 #define SAMA7G5_CIDR_MATCH		0x00162100
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
@@ -75,6 +76,8 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAM9X75_D5M_EXID_MATCH		0x00000010
 #define SAM9X75_EXID_MATCH		0x00000000
 
+#define SAMA7D65_EXID_MATCH		0x00000080
+
 #define SAMA7G51_EXID_MATCH		0x3
 #define SAMA7G52_EXID_MATCH		0x2
 #define SAMA7G53_EXID_MATCH		0x1
-- 
2.43.0


