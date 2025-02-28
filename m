Return-Path: <dmaengine+bounces-4602-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEB7A49D60
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82EFE7A4C19
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C81EF38A;
	Fri, 28 Feb 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BHu5xBdm"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F291EF38F;
	Fri, 28 Feb 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756320; cv=none; b=K2aFtMbjnJRWKjukkxcSeN2IuCpTbOJ2I2wtxP780YDgqubq/ZO0wHI9t2ol3+bLr16B4efujmdm8ZgCcbZXwqt417CIDN56bQyYXSW2SYZhuUpuOTe+Vw7ZtD9aFTRRUPpSHb1uFKeKaJilHr8Z/j+hDe5xqECAIKWTVuAWK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756320; c=relaxed/simple;
	bh=mUhcBeFz2G0AqMEg/aSARHZz8N8xLvWlhvTeO9kMMBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EwsX0EdLBZkhsyjj9V4U9vsxf8yrH4XvlIGaylIgkx45CHkvVpeY80s+9ujq9ZdEHgNH7yRYciyjRX4BHd64gkclDGkf++Xl/mVZVdsOYbMs36itqD14dc9NiZYB71YcA6z6E3yEFuEWFGq5xutwYIhA1AthJF+IpDM4ORTdgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BHu5xBdm; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740756319; x=1772292319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mUhcBeFz2G0AqMEg/aSARHZz8N8xLvWlhvTeO9kMMBk=;
  b=BHu5xBdmVAR4/9FJWH5i7F1dhgFSxPt6aA+8IU5RZNZxVbCmmfuMecr8
   Q1HoWIO9WtnT5CkRuzmaJIPZr3VIaLf9Qw702+QHRXdqf+kLw1K6jymlk
   zCtRvUU6vh48Td6KOZ1oRj5ng2uWo/1Xpobd9C18G4W2QMfg03L4s+g9j
   ZhkMtG8nAgXvaKn5HnJnotJqw9iiLsqQgMB0sIcbv2zOdYRl3EWTNXjcf
   3UjUvyny6J2A2wPVdPGKM4Acrdi0CmQ25mThRKa1m3zVASUCjX0BRBHI+
   xO3s1bhs6byNekdGCMHfrCwuM4hkjLFcvTKEaw+41L24yaxSYDoNVB1dt
   A==;
X-CSE-ConnectionGUID: YRQSNli+QiSyLIXFC1GTlQ==
X-CSE-MsgGUID: 7UExDHXCTZuMclqioX3IKw==
X-IronPort-AV: E=Sophos;i="6.13,322,1732604400"; 
   d="scan'208";a="42415299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2025 08:24:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 28 Feb 2025 08:23:54 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 28 Feb 2025 08:23:54 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC: <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-watchdog@vger.kernel.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH v2 0/2] Add System Components for Microchip SAMA7D65 SoC
Date: Fri, 28 Feb 2025 08:24:09 -0700
Message-ID: <cover.1740675317.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch set adds support for the following systems in the SAMA7D65
SoC:
- DMAs
- Chip ID
- Dual watchdog timer.

Changes v1 -> v2:
- Removed pathes that have been accepted and applied from v1 [1].
- Corrected missing newline in dt-binding.
- Corrected mismatch in watchdog dt node.

1) https://lore.kernel.org/linux-arm-kernel/09eafe54-c262-4db4-b11d-0644a1f90a14@tuxon.dev/

Ryan Wanner (2):
  dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
  ARM: dts: microchip: sama7d65: Add watchdog for sama7d65

 .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml    | 4 ++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi                  | 7 +++++++
 2 files changed, 11 insertions(+)

-- 
2.43.0


