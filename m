Return-Path: <dmaengine+bounces-3901-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFF9E5202
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 11:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C6E28402B
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6ED2066D3;
	Thu,  5 Dec 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NWNqnhFF"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187E2066CD;
	Thu,  5 Dec 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392637; cv=none; b=tAdZgUH/E0oLilmitDgWTvgrqelX2Qd2LERRPYcZD6yJ8KwrlvlRpEnwp89WN6EvclaRVXyV/HFNDSX7DyYXxNm0/u8ElRqoGHnZ7s+oTsyWLxcfOol0sTVJezmho5Z0AOs4R73bzG4ZQC5FYXtHa3xLGtNKOBDZq8p261SUCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392637; c=relaxed/simple;
	bh=miV+lFMFVzAaAvt8JNrBIkbBUgixoMAJpy4otndSQqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=UrrNpYb3HsrddqVLIvxcV4YTV1yBg80XrqLYEpF5gufcjrT/mF83wB34yURPklwa+ZLf7r2CcO8GEowRTI6rrU1p/lWL68sOUgZfJfUFoyJIuvjy5E/pNYxvQi5lCFVzNbRca9OJGX3NCATiai6+Gz+KJFz0QVfxVF0VXLbnEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NWNqnhFF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733392636; x=1764928636;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=miV+lFMFVzAaAvt8JNrBIkbBUgixoMAJpy4otndSQqI=;
  b=NWNqnhFFgAYe+sGR8L3TnlvIeu4ExwPAZEP344wblbWjsPHq7jXRGiCY
   h31tpspC1W07QWvATfMpCl+t3vqQ+1m7qWV2rXRhpeIZvHAOQHd3JfOFE
   NoWTEDvEY87ugRf81rPrZxeueZveQ+PCgxdVcm8MZLfosz6LpVeqKVzGs
   1A+l8Di3VURhUOHgXEFkabkxqrkwSolwateHZ0twyZH7WKjLcBYyWw3Kb
   ij/rOITE+9IFBzToTYIWculddjNAqFQDXc93hC8I+qU3/AfALeOdv1b9A
   eg5xPKX7QSsl2RqCwwmbg33tohUIRn4xZ0HAKQrIcLByOajINU3KZxXjR
   w==;
X-CSE-ConnectionGUID: TKbBYKFISlCTYliYBZMdug==
X-CSE-MsgGUID: B/i8g4eKSlyJ517PbZMMSg==
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="266366333"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2024 02:57:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Dec 2024 02:56:23 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 5 Dec 2024 02:56:19 -0700
From: Charan Pedumuru <charan.pedumuru@microchip.com>
Date: Thu, 5 Dec 2024 15:26:18 +0530
Subject: [PATCH] dt-bindings: dma: atmel: Convert to json schema
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-xdma-v1-1-76a4a44670b5@microchip.com>
X-B4-Tracking: v=1; b=H4sIAMF4UWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNT3YqU3ERdSwvTZLNkE4vUpBRTJaDSgqLUtMwKsDHRsbW1ACEYSFR
 WAAAA
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Charan Pedumuru <charan.pedumuru@microchip.com>
X-Mailer: b4 0.14.1

Convert old text based binding to json schema.
Changes during conversion:
- Add the required properties `clock` and `clock-names`, which were
  missing in the original binding.
- Add a fallback for `microchip,sam9x7-dma` and `microchip,sam9x60-dma`
  as they are compatible with the dma IP core on `atmel,sama5d4-dma`.
- Update examples and include appropriate file directives to resolve
  errors identified by `dt_binding_check` and `dtbs_check`.

Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
---
 .../devicetree/bindings/dma/atmel,sama5d4-dma.yaml | 79 ++++++++++++++++++++++
 .../devicetree/bindings/dma/atmel-xdma.txt         | 54 ---------------
 2 files changed, 79 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
new file mode 100644
index 000000000000..9ca1c5d1f00f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/atmel,sama5d4-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip AT91 Extensible Direct Memory Access Controller
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Charan Pedumuru <charan.pedumuru@microchip.com>
+
+description:
+  The DMA Controller (XDMAC) is a AHB-protocol central direct memory access
+  controller. It performs peripheral data transfer and memory move operations
+  over one or two bus ports through the unidirectional communication
+  channel. Each channel is fully programmable and provides both peripheral
+  or memory-to-memory transfers. The channel features are configurable at
+  implementation.
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,sama5d4-dma
+          - microchip,sama7g5-dma
+      - items:
+          - enum:
+              - microchip,sam9x60-dma
+              - microchip,sam9x7-dma
+          - const: atmel,sama5d4-dma
+
+  "#dma-cells":
+    description: |
+      Represents the number of integer cells in the `dmas` property of client
+      devices. The single cell specifies the channel configuration register:
+        - bit 13: SIF (Source Interface Identifier) for memory interface.
+        - bit 14: DIF (Destination Interface Identifier) for peripheral interface.
+        - bit 30-24: PERID (Peripheral Identifier).
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: dma_clk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    dma-controller@f0008000 {
+        compatible = "atmel,sama5d4-dma";
+        reg = <0xf0008000 0x1000>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
+        #dma-cells = <1>;
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
+        clock-names = "dma_clk";
+    };
diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
deleted file mode 100644
index 76d649b3a25d..000000000000
--- a/Documentation/devicetree/bindings/dma/atmel-xdma.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-* Atmel Extensible Direct Memory Access Controller (XDMAC)
-
-* XDMA Controller
-Required properties:
-- compatible: Should be "atmel,sama5d4-dma", "microchip,sam9x60-dma" or
-  "microchip,sama7g5-dma" or
-  "microchip,sam9x7-dma", "atmel,sama5d4-dma".
-- reg: Should contain DMA registers location and length.
-- interrupts: Should contain DMA interrupt.
-- #dma-cells: Must be <1>, used to represent the number of integer cells in
-the dmas property of client devices.
-  - The 1st cell specifies the channel configuration register:
-    - bit 13: SIF, source interface identifier, used to get the memory
-    interface identifier,
-    - bit 14: DIF, destination interface identifier, used to get the peripheral
-    interface identifier,
-    - bit 30-24: PERID, peripheral identifier.
-
-Example:
-
-dma1: dma-controller@f0004000 {
-	compatible = "atmel,sama5d4-dma";
-	reg = <0xf0004000 0x200>;
-	interrupts = <50 4 0>;
-	#dma-cells = <1>;
-};
-
-
-* DMA clients
-DMA clients connected to the Atmel XDMA controller must use the format
-described in the dma.txt file, using a one-cell specifier for each channel.
-The two cells in order are:
-1. A phandle pointing to the DMA controller.
-2. Channel configuration register. Configurable fields are:
-    - bit 13: SIF, source interface identifier, used to get the memory
-    interface identifier,
-    - bit 14: DIF, destination interface identifier, used to get the peripheral
-    interface identifier,
-  - bit 30-24: PERID, peripheral identifier.
-
-Example:
-
-i2c2: i2c@f8024000 {
-	compatible = "atmel,at91sam9x5-i2c";
-	reg = <0xf8024000 0x4000>;
-	interrupts = <34 4 6>;
-	dmas = <&dma1
-		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-		 | AT91_XDMAC_DT_PERID(6))>,
-	       <&dma1
-		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-		| AT91_XDMAC_DT_PERID(7))>;
-	dma-names = "tx", "rx";
-};

---
base-commit: 85a2dd7d7c8152cb125712a1ecae1d0a6ccac250
change-id: 20241125-xdma-985c6c48ebd5

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@microchip.com>


