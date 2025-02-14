Return-Path: <dmaengine+bounces-4477-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C868DA36563
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17991896170
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F722690DC;
	Fri, 14 Feb 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CrGVD99z"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD62268C51;
	Fri, 14 Feb 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556527; cv=none; b=iiTILxaEck75XVHy45eq5SH0IrIWzFH9VVzODEk6tEvNKWBTaL1ZgGg5GoN/OfCKM9rjnvoap0IBLB6p5Fq000uKSI/GNEwHoXCOKorE22iuiPZN1cWJqydfDIJ5ti1/o5Jl9i4YDpt46D3If6cg1CS3nJifNCsp0AXpcQPrA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556527; c=relaxed/simple;
	bh=IiA3Lsk8M2dYMgk/4nS7W+qSoNllaePb+DQMH94UMsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbniT4uUvfdjRA6EYyej+0siJPljrYKqxG7HZnO+lUR5mAQ/Ox87Ba/z5aRWnr35u6OFILbSzDgbj6Qfs7wnOVzFDfe2HnjCE/yp6iw3kt9TQ9mkqF8btzXeg4rqAPWQdj/mM3lVxSxxNPlgrZgIIPLrx3VkzNsII8PaSk1g9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CrGVD99z; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739556526; x=1771092526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IiA3Lsk8M2dYMgk/4nS7W+qSoNllaePb+DQMH94UMsk=;
  b=CrGVD99z0CGJ9iwGUm4ZHEXXZY9dOjc+xISb5Xw1vwGMjvWXpg5HkLac
   /h6drHuwfcaWyzmY7bPXNQy1Yxm7ZHJw/9rqUTPfZSE55XXRH5f7hTSer
   yDY1NR5WZdbCffwNxDgckPbjRyK1m6c70orTRXCiXX5DHj4eMXkROWBx1
   nKT/IxLZETG6BDfgDnAKUw8nLnj6s/y+OF3Vapdirp9HxSQZTAxB/svTY
   rLIh3pMZ7ENEW4x3QhRrPgj4nIVJV3rcnRazlr5yR/gnvaT1SwbjY/0Lg
   7dJq/co/MAijV4zK63muy1iu2f3Kjr7flBA780BIpS+98kQQ6wQYScLPV
   g==;
X-CSE-ConnectionGUID: afEECSQvQkGMMmDvtHvTFg==
X-CSE-MsgGUID: ObyPD2RNTM+y/AWm3wOGew==
X-IronPort-AV: E=Sophos;i="6.13,286,1732604400"; 
   d="scan'208";a="37700925"
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
Subject: [PATCH 1/8] dt-bindings: atmel-sysreg: Add SAMA7D65 Chip ID
Date: Fri, 14 Feb 2025 11:08:14 -0700
Message-ID: <008e4e49c9fd315cc96a185662b31eca1a64a614.1739555984.git.Ryan.Wanner@microchip.com>
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

Add compatible string for SAMA7D65 SoC ChipID dt-bindings.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 1a173e92bb137..d3821f651e728 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -2,6 +2,7 @@ Atmel system registers
 
 Chipid required properties:
 - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chipid"
+			"microchip,sama7d65-chipid"
 - reg : Should contain registers location and length
 
 PIT Timer required properties:
-- 
2.43.0


