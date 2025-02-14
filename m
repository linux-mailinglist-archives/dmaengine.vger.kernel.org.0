Return-Path: <dmaengine+bounces-4479-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB2A36571
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 19:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A426189822B
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191126989D;
	Fri, 14 Feb 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aJFJ8Nc3"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9E2690E1;
	Fri, 14 Feb 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556528; cv=none; b=MFyMzbf3IGR1+UaxMGtEEAxYuwm9soRPXCdq+aFEZz4MN3sDWiD6HiIiT2wkwvMEfh9QYCO2EDG/mirntyAFlp+Vgo1yRDtx+PVjZMIy70sCgLN0xhMJAF+gyBbE2isOcB9ZpKIBw1jr1wQdZ88uz8c0N9DveiPLXSJVg096MNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556528; c=relaxed/simple;
	bh=sKWqjvEpkcI2HOheld8cEwxYIv45wbwACNAWn1NaBNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLY91LN1no8uRAyEtEeuUDRvowzDEmAiQ/2IpdgeBhzDFTDKSkFpOjX0D2sVPQkZJYFNwyjhpytnZhiGejCOXgtyUMAzK5SjXkSVKxzECCDk8q+ZuljSo7u8u86+TO99proYBiRAFPfErbse0u0z6NIJsaEW/0/zulX6jTDD5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aJFJ8Nc3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739556528; x=1771092528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sKWqjvEpkcI2HOheld8cEwxYIv45wbwACNAWn1NaBNQ=;
  b=aJFJ8Nc3wa9BjA3LRTwXCU9Wp7/deHDBARwVSBe7kczoyd8WbmyPNUQk
   Go2OpdpZRjln1Dho5KBqbHMknQMe9og4OD7F81WdRTDdu0b8igLtL2dRk
   fHaSmiIrYrT29XJ3ZVYPbDl5qUD7iMj49bkZiRUg1aiGk+fcLj6CTYZAb
   yi185Zb4QTEPOlJHbNOpLqRsg7qeoTF6CSoZ7JAtlUacGjhygJ08EUgmW
   WOdNB8avs08OnAHpAg0BhuBeqtQKvQFYfskwAky6gtus3QZoYolGWhGHj
   UY2Ype2C/rUwdjBQmk/VhsfjYcC5gNpyxzezdCfFoq40u/2/x6NsgfGJK
   Q==;
X-CSE-ConnectionGUID: afEECSQvQkGMMmDvtHvTFg==
X-CSE-MsgGUID: Hc1GFQtYTc6wh5HSOspKzQ==
X-IronPort-AV: E=Sophos;i="6.13,286,1732604400"; 
   d="scan'208";a="37700927"
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
Subject: [PATCH 3/8] dt-bindings: dma: atmel: add microchip,sama7d65-dma
Date: Fri, 14 Feb 2025 11:08:16 -0700
Message-ID: <8b69f0c6d8955790edcdbe5d1e205b43dedb99ff.1739555984.git.Ryan.Wanner@microchip.com>
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

Add microchip,sama7d65-dma compatible string to DT bindings
documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
index 9ca1c5d1f00f8..73fc13b902b38 100644
--- a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
@@ -32,6 +32,9 @@ properties:
               - microchip,sam9x60-dma
               - microchip,sam9x7-dma
           - const: atmel,sama5d4-dma
+      - items:
+          - const: microchip,sama7d65-dma
+          - const: microchip,sama7g5-dma
 
   "#dma-cells":
     description: |
-- 
2.43.0


