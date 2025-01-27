Return-Path: <dmaengine+bounces-4213-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AFA1D44F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786693A77D9
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C61FCFE5;
	Mon, 27 Jan 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="i3lfpVk2"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFB179BF;
	Mon, 27 Jan 2025 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973368; cv=none; b=KEm9/aIFVhZeIWi85130sz4AbvbaZezVtlkOuQ/2QAPcWxUCbXbQTR/ETTfqXy59oFubGp4F9VUFxfOwP9K50YUgprRtnMDCJQgAbeft2rlou+RityFKOEYii+E7Bw+8+o/zl+r67TuLRJ4/ZtYbvhBjPvogOgG6ndcmsqt5tJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973368; c=relaxed/simple;
	bh=7+Qct7BeymG7lOqPogQ8tjt4CwnzfX9+dQChIt/gR5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=TPp6k4XnWc9ropQWsbNEQ7INjjropoj9gP/KkTzHUHFgao3GaBPrSYVMnEIx5B6ieDouQO93xLEA+tI11uIWg7diJT27IK2LHuGBNtjSfwFduIPk/PpXfKxW3YupBo8X18mkArGuCLGL6Uz9cZfelyNW7q5dIQ90yPVRFRCpOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=i3lfpVk2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1737973367; x=1769509367;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=7+Qct7BeymG7lOqPogQ8tjt4CwnzfX9+dQChIt/gR5o=;
  b=i3lfpVk20l+R+Y0/ti9a1cQN2ZUjyNkdOsuZ+o5AxfSysQ92dMLU/vha
   /KLgkrpHxucAW/Tc43NZvZ/VMvePy+ud1TRcBGXBeUUE7I4e9Zhzxx9I5
   WPYI0OwWJValQN7FNR+yLHyKw9jBi7T+wGJyXOnMn6aP9pNw4B38JhQCx
   9STaq07yYwD5Irc/sm/X0wZJEAyEu56oVvkd42rqJE+B0rCYyzqcMPYH/
   dKEWvY043D/vVuhjXjDFCWCApCtmobjwisXs+ctJ30eTGPoLANL3Ig6h3
   CaXYM177Jz9Y/EZ+md56IgKwqB/SYxwoTpyEzo2D6EZ3NXZDiPJOeSgp6
   g==;
X-CSE-ConnectionGUID: 6/71w3G4TJKoIyAFZm+R7w==
X-CSE-MsgGUID: a9lbd0A9Qua1pNFSFbBmAg==
X-IronPort-AV: E=Sophos;i="6.13,238,1732604400"; 
   d="scan'208";a="37388198"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2025 03:22:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 27 Jan 2025 03:22:09 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 27 Jan 2025 03:22:04 -0700
From: Charan Pedumuru <charan.pedumuru@microchip.com>
Date: Mon, 27 Jan 2025 15:51:58 +0530
Subject: [PATCH v3] dt-bindings: dma: convert atmel-dma.txt to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250127-test-v3-1-1b5f5b3f64fc@microchip.com>
X-B4-Tracking: v=1; b=H4sIAEVel2cC/03MywrDIBCF4VcJs+4Urxi66nuELsSMdRbGoBIKI
 e9e6arLD/5zTmhUmRo8phMqHdy4bAP6NkFIfnsT8joMSigrpHLYqXWcBdlg5hCdcTDSvVLkz+9
 meQ3HWjL2VMn/jzWu2eMhUaKwJkrvHDmtn5lDLSHxfg8lw3V9AUjY1DyVAAAA
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
 .../bindings/dma/atmel,at91sam9g45-dma.yaml        | 66 ++++++++++++++++++++++
 .../devicetree/bindings/dma/atmel-dma.txt          | 42 --------------
 .../devicetree/bindings/misc/atmel-ssc.txt         |  2 +-
 MAINTAINERS                                        |  2 +-
 4 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
new file mode 100644
index 000000000000..d6d16869b7db
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
@@ -0,0 +1,66 @@
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
+      Must be <2>, used to represent the number of integer cells in the dmas
+      property of client devices.
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


