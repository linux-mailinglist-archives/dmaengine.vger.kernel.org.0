Return-Path: <dmaengine+bounces-4603-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EF5A49D59
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC0B188B921
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB7E26FA7D;
	Fri, 28 Feb 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kIpESIVn"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52061EF38E;
	Fri, 28 Feb 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756322; cv=none; b=iZt1lULTLV1+QOK/MMFLNBv6qHJDzWYz5tSPT4USo0oI1fLW2mXKrcxkx3/GUZLZMgeU0oEXYGGqEAGVYHYkSssqF/tn5e9JprNK/Q/xhgdGNhfjykw9DLsuYyZcNzFyRwfeHYI2QJf/IEFMdP/OFOdaXoy4XCcuTCHvH6c9Z2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756322; c=relaxed/simple;
	bh=LzIKqDxFHg4172eexZcr4Iikohe0+ynv0N9qzRji844=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2eU6Q+Grv1lbkxEH2lAzUDH99ahZpjRIyM/j+1IEJT26T5rCKhG4LPowzYiix0z4BehGZH9YJJvXsPd4+s2ttmMhTIZRxrUKklU9vtaJrgKApjG7iU+nMUYBaiOs7X5GV6OQ3HH/bYepI+OGmBExRii/Z/nJdBwa2/qXQZoWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kIpESIVn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740756320; x=1772292320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LzIKqDxFHg4172eexZcr4Iikohe0+ynv0N9qzRji844=;
  b=kIpESIVnfAVRl3EwYw4nLHg7W3b3Fj+3zpp/ldzBmnSQnm/rkb4hFKZa
   nryh4SCfPXd4Q8qmrxxdP7GMVCTcPnAvEu4nsutb3eTHz4ajh8p9NSNX7
   22Bn6UbOYue2i+lQpEJP5u9EiGyiY9oW4ZYu4BuRMB5FMghHl80NPOWFz
   ybygcqqcfjOPpFN+gOogePddRBFlEtNTjlqht2PvUzaNpXcSgymP+yC1r
   KMUsFUPhrtAaE6m1SA7CSIsxXFLfHj7dQHaNFi1z24wqsMipZycS6I3Sd
   dd+6inxM9obHK2SsK/ekx65O6UmhXfQI5jt4tUWoFuNu/F1UxbTmVa//h
   A==;
X-CSE-ConnectionGUID: YRQSNli+QiSyLIXFC1GTlQ==
X-CSE-MsgGUID: OEUZY4WtRjiQyJmWabd75Q==
X-IronPort-AV: E=Sophos;i="6.13,322,1732604400"; 
   d="scan'208";a="42415302"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2025 08:24:15 -0700
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
Subject: [PATCH v2 1/2] dt-bindings: watchdog: sama5d4-wdt: Add sama7d65-wdt
Date: Fri, 28 Feb 2025 08:24:10 -0700
Message-ID: <15d6f901e64dd36d25a62e27601252c59708275a.1740675317.git.Ryan.Wanner@microchip.com>
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

Add microchip,sama7d65-wdt compatible string to the dt-binding documentation.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
index cdf87db36183..7668f1efdc6d 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
@@ -23,6 +23,10 @@ properties:
           - const: microchip,sam9x7-wdt
           - const: microchip,sam9x60-wdt
 
+      - items:
+          - const: microchip,sama7d65-wdt
+          - const: microchip,sama7g5-wdt
+
   reg:
     maxItems: 1
 
-- 
2.43.0


