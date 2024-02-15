Return-Path: <dmaengine+bounces-1018-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2E28560A0
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 12:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E331C22656
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3B130E2B;
	Thu, 15 Feb 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OQcHYFeK"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8560130AF5;
	Thu, 15 Feb 2024 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994528; cv=none; b=eeIF9TIPLHWOTzAWSxTZ5vj1uLO/qHQHtE7mjZ4nRdeSsKHGbexukVEQeRrFwy5R1sbt++U3AlQZb03R9S+UvmIUg8gYGXiH/LBQrpYHjT3uE90Nacac1aNbDubyMT72olLheRcJiDpPwDTklsIxDkYCH6XxLJmcklkR05mTEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994528; c=relaxed/simple;
	bh=ix55/jnZ4SkMNe1ZtfE07LjBU7sY6tl3iGBli1lEAcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=NT8QK4QDJS3fbJvP/ao1FNB7pUlDI0GZldRYXIZ5GaSbv/hU8lF0j+Co3UlljmINZnaO49B6amIXaQliWcl3wQ2cMJVUPg19ibKwkDXQRTErL7GC/DQAWc/G+XPisQ3/SuhDcb7CGqguXvm0+Y/gzv6aOaW0TDCNFL+cibEFFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OQcHYFeK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707994527; x=1739530527;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=ix55/jnZ4SkMNe1ZtfE07LjBU7sY6tl3iGBli1lEAcg=;
  b=OQcHYFeKYm9YeEphcLwtgjWu7PtxDgE7JBmYJjXCsXvFf7faNanj3crb
   ysgR/xG1pMoktu1Cs/smmkFV3yrZhHfwo/EksMLihZdogRrOQHhjgpFye
   c2vR9BuyADbsddiqGDUkGHd8MSLZSKaf6CCWkuWZ0XjLr6noMhP9rw6Ww
   zZHxo3XRERfsiAcxGHKYIdpOIYHP6WG5juDjC5/JD97nUWLOnnQnZmsAU
   VGD7GWRl4FoM537nmjHGzkoTLepRApq2IPLZ41cuu7vJV3vA72YzSAoE7
   75QoTIVFC5mswE415EcUA324TWSuH8zyYV+hkDtlcP6Hhb32N706DehL+
   g==;
X-CSE-ConnectionGUID: v+sFuF0CRgGdCT0U0xN+Lg==
X-CSE-MsgGUID: t8z6n7eVQo2rYQB00hVd2A==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="16283972"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 03:55:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 03:55:24 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 03:55:20 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
Date: Thu, 15 Feb 2024 16:25:15 +0530
Subject: [PATCH] dt-bindings: dma: convert atmel-xdma.txt to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240215-xdma-v1-1-1139960cf096@microchip.com>
X-B4-Tracking: v=1; b=H4sIAJLtzWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0NT3YqU3ERdY7NUi6SUpDQLQxNDJaDSgqLUtMwKsDHRsbW1AI7hoNV
 WAAAA
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Durai Manickam KR" <durai.manickamkr@microchip.com>
X-Mailer: b4 0.12.4

Added a description, required properties and appropriate compatibles
for all the SoCs that are supported by microchip for the XDMAC.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 .../devicetree/bindings/dma/atmel-xdma.txt         | 54 ---------------
 .../bindings/dma/microchip,at91-xdma.yaml          | 77 ++++++++++++++++++++++
 2 files changed, 77 insertions(+), 54 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/dma/microchip,at91-xdma.yaml b/Documentation/devicetree/bindings/dma/microchip,at91-xdma.yaml
new file mode 100644
index 000000000000..0bd79c7b5e6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/microchip,at91-xdma.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/microchip,at91-xdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Extensible Direct Memory Access Controller (XDMAC)
+
+maintainers:
+  - Durai Manickam KR <durai.manickamkr@microchip.com>
+
+description: |
+  The Atmel Extensible Direct Memory Access Controller (XDMAC) performs peripheral
+  data transfer and memory move operations over one or two bus ports through the
+  unidirectional communication channel. Each channel is fully programmable and
+  provides both peripheral or memory-to-memory transfers.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,sama5d4-dma
+          - microchip,sama7g5-dma
+          - microchip,sam9x7-dma
+      - items:
+          - const: atmel,sama5d4-dma
+          - const: microchip,sam9x60-dma
+  reg:
+    description: Should contain DMA registers location and length.
+    maxItems: 1
+
+  interrupts:
+    description: Should contain the DMA interrupts associated to the DMA channels.
+    maxItems: 1
+
+  "#dma-cells":
+    description: |
+      Must be <1>, used to represent the number of integer cells in the dmas
+      property of client device.
+      -The 1st cell specifies the channel configuration register:
+      -bit 13: SIF, source interface identifier, used to get the memory
+               interface identifier,
+      -bit 14: DIF, destination interface identifier, used to get the peripheral
+               interface identifier,
+      -bit 30-24: PERID, peripheral identifier.
+    const: 1
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
+    dma0: dma-controller@f0004000 {
+            compatible = "atmel,sama5d4-dma";
+            reg = <0xffffec00 0x200>;
+            interrupts = <50 4 0>;
+            #dma-cells = <1>;
+            clocks = <&pmc 2 20>;
+            clock-names = "dma_clk";
+    };
+
+...

---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240215-xdma-36e8bdbf8141

Best regards,
-- 
Durai Manickam KR <durai.manickamkr@microchip.com>


