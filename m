Return-Path: <dmaengine+bounces-4604-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518BBA49D63
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7207A9B53
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36593270EB9;
	Fri, 28 Feb 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fYbxd2H2"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0FE1F9AA6;
	Fri, 28 Feb 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756323; cv=none; b=syMRMWTy5/+kV2zkDa3ASIaOAe3X/V0EYjxVl0//uUCri5eHjFwMkVRk2E4yu9yVT+HtZ+L02QtYPcI9mw40N3Jh1xoFSpPQ9FwsZvcv+PNdYhL4aFodGk9mSeIxbhNe3ysayc33oJ3L9zmyz3q2nmXdQbecgNQYKCzbXHjqLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756323; c=relaxed/simple;
	bh=C+WJBpj9bMXThG9QJfuqTXTLi4bYFGvQeKIFgFhaMJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di7K8XWzcMq97B+wpY///gqi2hOqNdaMACWu/RQ36mW/H6rcJ6xgAj0TKPWv41nVy/aX3W6Q+iFB08lYw1SXYBHk1MbtSbBA+WdgCSyMvFTPc0ZoCA3RqQz7sAfEWnd6dC7c4DXOSgMrf+ZugiVySzj0Vpfi74WF9YGwWcWBFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fYbxd2H2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740756321; x=1772292321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C+WJBpj9bMXThG9QJfuqTXTLi4bYFGvQeKIFgFhaMJQ=;
  b=fYbxd2H2H3bH4CQgHA1hq94rS992yzazfiTiORZNlp9dfA8BmufuIdTX
   co6590+i/05Lg5lZWB1dk5C3HpPqBmcdfNfT5Dyy7Cufpk53xArMNcGdk
   eH1oF+TJBkwW5tM40APUQlJ3nVal20I9ze0ksq6hUM5GueZN1O43gdLwb
   gFoeDRlFCBQd6G0A6keuI6ignrY93r3DPXZUWpjzS6sAHU4L6CVDjtXFZ
   QuFQFR0V253aTU7HCxQ2rCYM3iQtxoMEzsIOhYcj+Ll/6B3SGws/s1d21
   pYcHHO27svU/XFClVvMhLM4ofQVm1GwsMxk/Yi6AFDeOmJyNrjaWngbzG
   w==;
X-CSE-ConnectionGUID: YRQSNli+QiSyLIXFC1GTlQ==
X-CSE-MsgGUID: DEk0ug21RBa+XoE4zvTP+Q==
X-IronPort-AV: E=Sophos;i="6.13,322,1732604400"; 
   d="scan'208";a="42415303"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2025 08:24:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 28 Feb 2025 08:23:55 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 28 Feb 2025 08:23:55 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <wim@linux-watchdog.org>, <linux@roeck-us.net>
CC: <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-watchdog@vger.kernel.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH v2 2/2] ARM: dts: microchip: sama7d65: Add watchdog for sama7d65
Date: Fri, 28 Feb 2025 08:24:11 -0700
Message-ID: <05785a34b9181b7debb57c1896cc733bd3088c56.1740675317.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740675317.git.Ryan.Wanner@microchip.com>
References: <cover.1740675317.git.Ryan.Wanner@microchip.com>
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
index 92a5347e35b5..179d7f54cc7f 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -77,6 +77,13 @@ pmc: clock-controller@e0018000 {
 			clock-names = "td_slck", "md_slck", "main_xtal";
 		};
 
+		ps_wdt: watchdog@e001d000 {
+			compatible = "microchip,sama7d65-wdt", "microchip,sama7g5-wdt";
+			reg = <0xe001d000 0x30>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk32k 0>;
+		};
+
 		clk32k: clock-controller@e001d500 {
 			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
 			reg = <0xe001d500 0x4>;
-- 
2.43.0


