Return-Path: <dmaengine+bounces-4283-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A93A283D1
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 06:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E303A13A3
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 05:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B3C217F32;
	Wed,  5 Feb 2025 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZYBAaDcL"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B515D1;
	Wed,  5 Feb 2025 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734456; cv=none; b=QzDRNHFxal+64cHdl3w8AzTBbHoJLfCRjf/7PD9ZiZAYHR8PBuUcNAIdH2sbVodddKlus7S68xAkaAi6wgf/4eASvwhQBSc5yEEmSKgY9WSX5ZDYbjsjuHKELNDUH25GDgkT/YT704jUdL3dYFpMqofHBM4jko1V8Nou+O01bLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734456; c=relaxed/simple;
	bh=r2mmTyCNz3+P1wCHtQKeE98SelrFptg10dUNqwfPqts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OavxUb6WHrj0BZyIObXv/pikPzY36mKpQSLI9ca1AQ6JsB4/8glbJanjcIp8aWX/sVL6Qveka+Jd3i8FqahkHWdCwIdp/6kTwrmNYyutsVYajWBwAsO1qBIbLcGzb/jUH35g5BIHkp67VAO5vPXXsAr7hGjus113U+JA5uv2LD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZYBAaDcL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738734454; x=1770270454;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r2mmTyCNz3+P1wCHtQKeE98SelrFptg10dUNqwfPqts=;
  b=ZYBAaDcL0Po6hLk9kjd5nDDTDDcbBqo2K8vlft+X24b37aV+mnh8nPju
   5UDMiN8MWqNiWCpoYdRpVjHE4VaZA89PQNE5H4JS5Jyf+NHhIt1rLGrYZ
   95bm4m5XsdHbWH9TLGlVP+mr8tNtEaMgf8mXNWEQy9KpJb6gbrAjFOmLl
   dSRd2YN80lUlxaaJ4qJYvgOEGU4I1oB98LRXX5+ZMgVMvNn13S2tKatjj
   FpBc1hL31H8NtlU4bLsAs+BXxUph+Xt9YF8vryBlPUmKoiP4eOwkCRBvV
   NRIzByuPXN8w/j7iUJ7ygZEYaYg3bKp9cOFeuKcvOu6GzWIKx6qAUdy/S
   A==;
X-CSE-ConnectionGUID: Q6N8fxKkRWuAjntzGu5PRA==
X-CSE-MsgGUID: 8sK76KAKTMK9+hz0uV0F6Q==
X-IronPort-AV: E=Sophos;i="6.13,260,1732604400"; 
   d="scan'208";a="36898072"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Feb 2025 22:47:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Feb 2025 22:47:23 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Feb 2025 22:47:17 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Wed, 5 Feb 2025 11:17:03 +0530
Subject: [PATCH 2/2] dt-bindings: dma: at_xdmac: document dma-channels
 property
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250205-mchp-dma-v1-2-124b639d5afe@microchip.com>
References: <20250205-mchp-dma-v1-0-124b639d5afe@microchip.com>
In-Reply-To: <20250205-mchp-dma-v1-0-124b639d5afe@microchip.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Vinod Koul
	<vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Charan Pedumuru <charan.pedumuru@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>, Tony Han <tony.han@microchip.com>,
	Cristian Birsan <cristian.birsan@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738734425; l=2248;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=r2mmTyCNz3+P1wCHtQKeE98SelrFptg10dUNqwfPqts=;
 b=/Ixn736PYcqjlWrl/ODVpBF7/1gZsuXsfAjG5GQJBTxnvnfleZU+YHVEIdYZIna7OKwzxyOI5
 c9guVdzxrcQAfIZtJIZb15Mv8TkMp07XPE94plLq0k3MrPC93yx85rU
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Add document for the property "dma-channels" for XDMA controller.

Also reorder properties to group related items together.

Signed-off-by: Tony Han <tony.han@microchip.com>
Reviewed-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../devicetree/bindings/dma/atmel,sama5d4-dma.yaml | 26 ++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
index 9ca1c5d1f00f..b9fda35d2138 100644
--- a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
@@ -33,15 +33,6 @@ properties:
               - microchip,sam9x7-dma
           - const: atmel,sama5d4-dma
 
-  "#dma-cells":
-    description: |
-      Represents the number of integer cells in the `dmas` property of client
-      devices. The single cell specifies the channel configuration register:
-        - bit 13: SIF (Source Interface Identifier) for memory interface.
-        - bit 14: DIF (Destination Interface Identifier) for peripheral interface.
-        - bit 30-24: PERID (Peripheral Identifier).
-    const: 1
-
   reg:
     maxItems: 1
 
@@ -54,6 +45,23 @@ properties:
   clock-names:
     const: dma_clk
 
+  "#dma-cells":
+    description: |
+      Represents the number of integer cells in the `dmas` property of client
+      devices. The single cell specifies the channel configuration register:
+        - bit 13: SIF (Source Interface Identifier) for memory interface.
+        - bit 14: DIF (Destination Interface Identifier) for peripheral interface.
+        - bit 30-24: PERID (Peripheral Identifier).
+    const: 1
+
+  dma-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Represents the number of DMA channels available in XDMA controller. This
+      property is required when the channel count cannot be read from the
+      XDMAC_GTYPE register (which occurs when accessing from non-secure world
+      on certain devices).
+
 required:
   - compatible
   - reg

-- 
2.43.0


