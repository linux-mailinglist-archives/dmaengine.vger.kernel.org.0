Return-Path: <dmaengine+bounces-1017-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBB856074
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 12:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B6D1C209AE
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B978132C3B;
	Thu, 15 Feb 2024 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UY6Fx3jO"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9992612E1C4;
	Thu, 15 Feb 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993987; cv=none; b=GEN6WkEfV5SUsRRNtxdBJMi8GDWogOCuc+4tzIQLSs7bCO4+KXalnE+mWvXImigA4whFVijV3Ky/hdoyzCZo8ZYSSF+Oi/b20mIcWC+4vGpAXN5MfP3nbmWH/R0oGCKTlybrnNUn2BK0ZbIZoJr14hrLSrwynqqnGYPYa8A8b0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993987; c=relaxed/simple;
	bh=m1LjF1npWj8tCKHK1NcAZBpF2cD039mfR5VwBO1BovM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=kccfve1LLYruIby3ee7i3f8uAtjKVcHl/PJIX6wLXuxIww1yzZz22c++Ib6sxkXWLcy6nSnd0haZ0f2T+q5iPIfFYMGcGxXZoRXYmSj6KCnN0Vuqz4rfZgjA51jb4/qZcRh53xWavexcDAGnNC0PhDAKP0lkrRMw67H1PJ4dQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UY6Fx3jO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707993986; x=1739529986;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=m1LjF1npWj8tCKHK1NcAZBpF2cD039mfR5VwBO1BovM=;
  b=UY6Fx3jOMxV3CrJQzLMf9i15vr0aa8ezR/NecGHE3kehyXm5VcCE/Nqn
   70B2FUz/F6NhT/E+YqoDloyJ6H5KJOKreM0JqfMvMe8LbSIcaWo4qgRmJ
   X1h49QteXFNcCWk+l6B28N8QzVUX5kNgcsBM7U/nuTszksBXLcJ7Y0i4F
   Z8mE2BbIvJKqobYVfoZnUUzLLZHZuUvlOCMAjQRXKWXW1eSxS3KsMuOIw
   hRZT7zLKMcONeUIY6DoygyTY3pJfs4nyqJQ8SxlLEyPh+JMnC62NxnHL2
   Zx3f6WUMeTf3YfrZoe/GQB4tXM6IvS3WrWQO8Tw8S4BlKLG5iNhPFZM2a
   g==;
X-CSE-ConnectionGUID: sBOc7X1pTDaZ9glc9RjUSQ==
X-CSE-MsgGUID: IeU7h4lfSoWKR0brJFk/NA==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="247024159"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 03:46:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 03:46:01 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 03:45:56 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
Date: Thu, 15 Feb 2024 16:15:44 +0530
Subject: [PATCH] dt-bindings: dma: convert atmel-dma.txt to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240215-dmac-v1-1-8f1c6f031c98@microchip.com>
X-B4-Tracking: v=1; b=H4sIAFfrzWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0MT3ZTcxGRd0zQTi7QU8zTjJMsUJaDSgqLUtMwKsDHRsbW1AFX/e49
 WAAAA
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Durai Manickam KR" <durai.manickamkr@microchip.com>
X-Mailer: b4 0.12.4

Added a description, required properties and appropriate compatibles
for all the SoCs that are supported by microchip.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 .../devicetree/bindings/dma/atmel-dma.txt          | 42 -------------
 .../bindings/dma/microchip,at91-dma.yaml           | 71 ++++++++++++++++++++++
 2 files changed, 71 insertions(+), 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel-dma.txt b/Documentation/devicetree/bindings/dma/atmel-dma.txt
deleted file mode 100644
index f69bcf5a6343..000000000000
--- a/Documentation/devicetree/bindings/dma/atmel-dma.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-* Atmel Direct Memory Access Controller (DMA)
-
-Required properties:
-- compatible: Should be "atmel,<chip>-dma".
-- reg: Should contain DMA registers location and length.
-- interrupts: Should contain DMA interrupt.
-- #dma-cells: Must be <2>, used to represent the number of integer cells in
-the dmas property of client devices.
-
-Example:
-
-dma0: dma@ffffec00 {
-	compatible = "atmel,at91sam9g45-dma";
-	reg = <0xffffec00 0x200>;
-	interrupts = <21>;
-	#dma-cells = <2>;
-};
-
-DMA clients connected to the Atmel DMA controller must use the format
-described in the dma.txt file, using a three-cell specifier for each channel:
-a phandle plus two integer cells.
-The three cells in order are:
-
-1. A phandle pointing to the DMA controller.
-2. The memory interface (16 most significant bits), the peripheral interface
-(16 less significant bits).
-3. Parameters for the at91 DMA configuration register which are device
-dependent:
-  - bit 7-0: peripheral identifier for the hardware handshaking interface. The
-  identifier can be different for tx and rx.
-  - bit 11-8: FIFO configuration. 0 for half FIFO, 1 for ALAP, 2 for ASAP.
-
-Example:
-
-i2c0@i2c@f8010000 {
-	compatible = "atmel,at91sam9x5-i2c";
-	reg = <0xf8010000 0x100>;
-	interrupts = <9 4 6>;
-	dmas = <&dma0 1 7>,
-	       <&dma0 1 8>;
-	dma-names = "tx", "rx";
-};
diff --git a/Documentation/devicetree/bindings/dma/microchip,at91-dma.yaml b/Documentation/devicetree/bindings/dma/microchip,at91-dma.yaml
new file mode 100644
index 000000000000..a0a582902e4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/microchip,at91-dma.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/microchip,at91-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Direct Memory Access Controller (DMA)
+
+maintainers:
+  - Ludovic Desroches <ludovic.desroches@microchip.com>
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description: |
+  The Atmel Direct Memory Access Controller (DMAC) transfers data from a source
+  peripheral to a destination peripheral over one or more AMBA buses. One channel
+  is required for each source/destination pair. In the most basic configuration,
+  the DMAC has one master interface and one channel. The master interface reads
+  the data from a source and writes it to a destination. Two AMBA transfers are
+  required for each DMAC data transfer. This is also known as a dual-access transfer.
+  The DMAC is programmed via the APB interface.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,at91sam9g45-dma
+          - atmel,at91sam9rl-dma
+  reg:
+    description: Should contain DMA registers location and length.
+    maxItems: 1
+
+  interrupts:
+    description: Should contain the DMA interrupts associated to the DMA channels.
+    maxItems: 1
+
+  "#dma-cells":
+    description:
+      Must be <2>, used to represent the number of integer cells in the dmas
+      property of client devices.
+    const: 2
+
+  clocks:
+    description: Should contain a clock specifier for each entry in clock-names.
+    maxItems: 1
+
+  clock-names:
+    description: Should contain the clock of the DMA controller.
+    const: dma_clk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    dma0: dma-controller@ffffec00 {
+            compatible = "atmel,at91sam9g45-dma";
+            reg = <0xffffec00 0x200>;
+            interrupts = <21>;
+            #dma-cells = <2>;
+            clocks = <&pmc 2 20>;
+            clock-names = "dma_clk";
+    };
+
+...

---
base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
change-id: 20240214-dmac-5f48fd7f3b9d

Best regards,
-- 
Durai Manickam KR <durai.manickamkr@microchip.com>


