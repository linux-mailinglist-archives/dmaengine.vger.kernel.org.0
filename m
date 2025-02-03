Return-Path: <dmaengine+bounces-4247-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2DAA25249
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 07:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3E63A3F72
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 06:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B4642A9B;
	Mon,  3 Feb 2025 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EvcmNstJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE60AD5A;
	Mon,  3 Feb 2025 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738563617; cv=none; b=iPu35aLtlz37GuUJ5rQQ0GYrRZ0FrHsSttZw8cDICbIJ5C/Mu2XqhNksyK2bVCQtvcwQBQ26XRK4E5SlJx6cC7xUZ23qjR6dGBS9DnTvyGA3j3QM4j9ZwLCiWhzMFR7N+HV3osDdbHYT1mR7TJGOsvoy/ASjLx2/R9yW9cwfFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738563617; c=relaxed/simple;
	bh=huPreexBSUGD+4tZwz+FrnsTGlTYrbETUuXB8TElD30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IjzBEAtB5Z4UgOfzyGlTxkzr2AIdlIi976zc4ZxAZlLw3s5MDpcFH+HCcO5l15xGeJDDaKXN6ZGerCtj5JS7EpO4VtTH6QIjveHDO4EH+LWGev8jUiLwhoK7Orcczkbya2bGd5z9OGsEjAlPy7M0AfaPxA3t1PGUKymDXL5U5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EvcmNstJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738563616; x=1770099616;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=huPreexBSUGD+4tZwz+FrnsTGlTYrbETUuXB8TElD30=;
  b=EvcmNstJ5UNE6KTUFb5A61t5jyZIoCaGrofCvMxe6Dh4+9Q3p00quVsT
   mT/Yn4lam93+/wq1DFKgogAzUAAmFnDFO86sxd/VU+k9YJ7WTlqRyHvnb
   JYePsV8VgU2aPe7rSVfP89hWjt7JkFKNoWi4gI2xcht/NTiqLv2h+EjQb
   bTMos2x3JWCIKDi/VgbQ20Qwf7PNsaR+FEY3at7h1IyhnDOlbS5or7cZA
   w5j1XIC1DPYTzxVDwWuf10hU+cbmJ+MvWaYuBhpPZgv7ysfonYFt9Qgxm
   eXxcmvotmk6ZmI7afy18T2wK50cKf2de+FknIWFFebonCxBVkZQx9XDil
   Q==;
X-CSE-ConnectionGUID: KYWEIIOuTcullLvzTva6Jw==
X-CSE-MsgGUID: ygDK2KZnTECqJan3jb1yLw==
X-IronPort-AV: E=Sophos;i="6.13,255,1732604400"; 
   d="scan'208";a="37194062"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2025 23:20:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 2 Feb 2025 23:20:06 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 2 Feb 2025 23:20:01 -0700
From: Charan Pedumuru <charan.pedumuru@microchip.com>
Date: Mon, 3 Feb 2025 11:48:09 +0530
Subject: [PATCH v4] dt-bindings: dma: convert atmel-dma.txt to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250203-test-v4-1-a9ec3eded1c7@microchip.com>
X-B4-Tracking: v=1; b=H4sIAKBfoGcC/13OwQ7CIAyA4VcxnK2BAbJ48j3MDowV4cBYgBDNs
 neX7WR2/JP2a1eSMXnM5HFZScLqs49zC3G9EOP0/EbwU2vS0U5S1ikomAv0FKURvbFKKNJGl4T
 Wfw7mNbS2KQYoLqH+X+YwBQ2VAQMqhWVaKVScP4M3KRrnl5uJYeeczyWm7/FU5Tt6ul95M9gor
 Ry5vQtrTsawbdsPXjxSWNsAAAA=
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Vinod Koul
	<vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Durai Manickam
 KR" <durai.manickamkr@microchip.com>, Charan Pedumuru
	<charan.pedumuru@microchip.com>
X-Mailer: b4 0.14.1

From: Durai Manickam KR <durai.manickamkr@microchip.com>

Add a description, required properties, appropriate compatibles and
missing properties like clocks and clock-names which are not defined in
the text binding for all the SoCs that are supported by microchip.
Update the text binding name `atmel-dma.txt` to
`atmel,at91sam9g45-dma.yaml` for the files which reference to
`atmel-dma.txt`. Drop Tudor name from maintainers.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
---
Changes in v4:
- Modified the description for #dma-cells property.
- Link to v3: https://lore.kernel.org/r/20250127-test-v3-1-1b5f5b3f64fc@microchip.com

Changes in v3:
- Renamed the text binding name `atmel-dma.txt` to
  `atmel,at91sam9g45-dma.yaml` for the files which reference to
  `atmel-dma.txt`.
- Removed `oneOf` and add a blank line in properties.
- Dropped Tudor name from maintainers.
- Link to v2: https://lore.kernel.org/r/20250123-dma-v1-1-054f1a77e733@microchip.com

Changes in v2:
- Renamed the yaml file to a compatible.
- Removed `|` and description for common properties.
- Modified the commit message.
- Dropped the label for the node in examples.
- Link to v1: https://lore.kernel.org/all/20240215-dmac-v1-1-8f1c6f031c98@microchip.com
---
 .../bindings/dma/atmel,at91sam9g45-dma.yaml        | 68 ++++++++++++++++++++++
 .../devicetree/bindings/dma/atmel-dma.txt          | 42 -------------
 .../devicetree/bindings/misc/atmel-ssc.txt         |  2 +-
 MAINTAINERS                                        |  2 +-
 4 files changed, 70 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
new file mode 100644
index 000000000000..a58dc407311b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/atmel,at91sam9g45-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Direct Memory Access Controller (DMA)
+
+maintainers:
+  - Ludovic Desroches <ludovic.desroches@microchip.com>
+
+description:
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
+    enum:
+      - atmel,at91sam9g45-dma
+      - atmel,at91sam9rl-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    description:
+      Must be <2>, used to represent the number of integer cells in the dma
+      property of client devices. The two cells in order are
+      1. The first cell represents the channel number.
+      2. The second cell is 0 for RX and 1 for TX transfers.
+    const: 2
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
+  - "#dma-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-controller@ffffec00 {
+        compatible = "atmel,at91sam9g45-dma";
+        reg = <0xffffec00 0x200>;
+        interrupts = <21>;
+        #dma-cells = <2>;
+        clocks = <&pmc 2 20>;
+        clock-names = "dma_clk";
+    };
+
+...
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
diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index f9fb412642fe..b159dc2298b6 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -14,7 +14,7 @@ Required properties:
 Required properties for devices compatible with "atmel,at91sam9g45-ssc":
 - dmas: DMA specifier, consisting of a phandle to DMA controller node,
   the memory interface and SSC DMA channel ID (for tx and rx).
-  See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
+  See Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml for details.
 - dma-names: Must be "tx", "rx".
 
 Optional properties:
diff --git a/MAINTAINERS b/MAINTAINERS
index 962eab2ce359..f1f4e3956f45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15348,7 +15348,7 @@ M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	dmaengine@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/dma/atmel-dma.txt
+F:	Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
 F:	drivers/dma/at_hdmac.c
 F:	drivers/dma/at_xdmac.c
 F:	include/dt-bindings/dma/at91.h

---
base-commit: 232f121837ad8b1c21cc80f2c8842a4090c5a2a0
change-id: 20250127-test-80e5c48cf747

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@microchip.com>


