Return-Path: <dmaengine+bounces-4476-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222CBA3654D
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 19:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC0C3B29A1
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131E268C7E;
	Fri, 14 Feb 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TZlM8OGX"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AB2641FC;
	Fri, 14 Feb 2025 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556525; cv=none; b=L/MZMnVJAxJcmvwaVipkach3F0uA1r/Er/LUVTaOX46rQ9SzQlrsW1taDqK850G25LFCd3I6yJq94v53wQz99Z/VWR8MP9bXf6Pi5yK1KssRektcIN9I12JE5a2IJ5YKSwjRNLSzeuDHRWWm5elUrJTc8cNeFPDl7t/agwV1+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556525; c=relaxed/simple;
	bh=H8tXLa2p1VhUWkXliwBLSLkbzNFdosczokdQ/wtBBm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OG43vFjvoWzaYo4dTv55CmBRxEiwbG7xe6X0XGBWW543eiAYdhJcLgYZCAcDaUkhhb8czlP6rXeKdglxAuNY8daEmVm3C5aBJGdOnV0/xYJ2ihsLraMfY9VQnm3jrFvGiKRFDd4GVIwzWAVxhc1akR2sH8lZ1XBYj0TiaMVcCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TZlM8OGX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739556524; x=1771092524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H8tXLa2p1VhUWkXliwBLSLkbzNFdosczokdQ/wtBBm8=;
  b=TZlM8OGX8O2NLfT377R5G+6EvKf1ZXIr1R+y9Oyb49l0I15icXFIm7Te
   28L5DSvBvBgml1YkmtZlXwcsB/sr4Ll9fM4CBOLxtY6Vv/IohnvjAYe17
   Quu7ZVZS2mdiIGXH6G6nV9Lk3WBwFU88AASPwHTW94k3eI+EMiIoJo+uV
   Q7u9Jrfser1SCId/JouVIIWa0SS90kpcbOvJJSRpkb0KQMnLFNCpl+VM0
   vrDSiqG+iFfEuabk2aTx+rFjOwYVRceAFcdjDfXHw3QWNwdqnT5TOXtXy
   gQ/KRcLYDYIDYnNgjpVjfsaA0xjNd13rYYaB3ZpaoVQ+YfUUIhV1YuYyH
   g==;
X-CSE-ConnectionGUID: afEECSQvQkGMMmDvtHvTFg==
X-CSE-MsgGUID: 2lHh1jY2S7Kw2hWZ/xXjEA==
X-IronPort-AV: E=Sophos;i="6.13,286,1732604400"; 
   d="scan'208";a="37700922"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2025 11:08:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Feb 2025 11:08:25 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 14 Feb 2025 11:08:25 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <vkoul@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 0/8]  Add System Components for Microchip SAMA7D65 SoC
Date: Fri, 14 Feb 2025 11:08:13 -0700
Message-ID: <cover.1739555984.git.Ryan.Wanner@microchip.com>
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

Ryan Wanner (8):
  dt-bindings: atmel-sysreg: Add SAMA7D65 Chip ID
  dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
  dt-bindings: dma: atmel: add microchip,sama7d65-dma
  ARM: at91: Add Support in SoC driver for SAMA7D65
  ARM: dts: microchip: sama7d65: Add chipID for sama7d65
  ARM: dts: microchip: sama7d65: Add watchdog for sama7d65
  ARM: dts: microchip: sama7d65: Add DMAs to sama7d65 SoC
  ARM: dts: microchip: sama7d65: Enable DMAs

 .../devicetree/bindings/arm/atmel-sysregs.txt |  1 +
 .../bindings/dma/atmel,sama5d4-dma.yaml       |  3 ++
 .../bindings/watchdog/atmel,sama5d4-wdt.yaml  |  3 ++
 .../dts/microchip/at91-sama7d65_curiosity.dts | 12 +++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 44 +++++++++++++++++++
 drivers/soc/atmel/soc.c                       |  5 +++
 drivers/soc/atmel/soc.h                       |  3 ++
 7 files changed, 71 insertions(+)

-- 
2.43.0


