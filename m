Return-Path: <dmaengine+bounces-4175-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04D0A1A0D3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 10:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BF93A7BFB
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8520C489;
	Thu, 23 Jan 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N57L5Ruw"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFF20C01B;
	Thu, 23 Jan 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624584; cv=none; b=gFb+nsX3wzE40aUs7OKymk3HJuP1/H3cqMyWNZMDIEYoAuXyfqj79BqQPR/LWpUNe+vauCNtVWQZoN70N/YTetwxpUcTL0PTvRrvKLSWthaElDDvkMUtCuIf1zXZ0/xxfKroTGLY8xGkCT2HAfGhbEri5QBFlOHSQ6dHz7ByaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624584; c=relaxed/simple;
	bh=TYa7l27dIFY5vdokhKSivIRGltNHtWDjnscfZtfaVSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IxuVQuxgAfdigvNkQO6leJyXHxHobu65jdw0g+4Jz3FYGBQZxbfCy5XlVsPi8mLAHzUJ9Oy8o1599XzvKmy3VVxBreeyNjJr8zFElSe9oDy+tPoLTF0YUSd6U6Q+BW4P4vHUTNWGOB9+rSyTLf1/vi2VG0Wqsp80+ueqGolihMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N57L5Ruw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1737624582; x=1769160582;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=TYa7l27dIFY5vdokhKSivIRGltNHtWDjnscfZtfaVSk=;
  b=N57L5Ruwm7G9TbRvOq9rkAugeWzxdSak85TeDlKbUUjb7QFc388519h0
   jw+7Srtcw+mA3wij+EuJDxYXI62K4hKwYl5lk2SGAzJBaypDzeIcERjmv
   6y0v05qpMjQmEqlJXV9EzD/KwYJDqk39B0/AMIExid7BC2d1XEgHtE+QV
   SrS+H1gA3JUhZef5HLChaycqNKCZ2hGOpvNjxjthg/JJ4IlEPV66Tsh0S
   S4gVfN+uZ1nj4W/hwmhIEa5qrDjPVOsQPBS2yRixNiB+/JgdEpTuzNVnu
   J7GOeIj/06sT9vD+aH5WUOJYlkRJogp3bC+tCEwZiP0VBHSgS1J2cuSGg
   w==;
X-CSE-ConnectionGUID: Ia08KEWmSUiv0dAQl/Kc4w==
X-CSE-MsgGUID: TKpjDec6StS1rxk9+d61Ug==
X-IronPort-AV: E=Sophos;i="6.13,228,1732604400"; 
   d="scan'208";a="204352971"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2025 02:28:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 Jan 2025 02:28:10 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 Jan 2025 02:28:04 -0700
From: Charan Pedumuru <charan.pedumuru@microchip.com>
Date: Thu, 23 Jan 2025 14:58:01 +0530
Subject: [PATCH v2] dt-bindings: dma: convert atmel-dma.txt to YAML
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250123-dma-v1-1-054f1a77e733@microchip.com>
X-B4-Tracking: v=1; b=H4sIAKALkmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMj3ZTcRN1kI3Nzi5S0RBMjEzMloMqCotS0zAqwKdFKZUZKsbW1AFi
 hxxZZAAAA
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ludovic Desroches <ludovic.desroches@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Durai Manickam KR" <durai.manickamkr@microchip.com>, Charan Pedumuru
	<charan.pedumuru@microchip.com>
X-Mailer: b4 0.14.1

From: Durai Manickam KR <durai.manickamkr@microchip.com>

Add a description, required properties, appropriate compatibles and
missing properties like clocks and clock-names which are not defined in
the text binding for all the SoCs that are supported by microchip.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
---
Changes in v2:
- Renamed the yaml file to a compatible.
- Removed `|` and description for common properties.
- Modified the commit message.
- Dropped the label for the node in examples.
- Link to v1: https://lore.kernel.org/all/20240215-dmac-v1-1-8f1c6f031c98@microchip.com
---
 .../bindings/dma/atmel,at91sam9g45-dma.yaml        | 67 ++++++++++++++++++++++
 .../devicetree/bindings/dma/atmel-dma.txt          | 42 --------------
 2 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
new file mode 100644
index 000000000000..8d0d68786cbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
@@ -0,0 +1,67 @@
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
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
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
+    oneOf:
+      - enum:
+          - atmel,at91sam9g45-dma
+          - atmel,at91sam9rl-dma
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

---
base-commit: 232f121837ad8b1c21cc80f2c8842a4090c5a2a0
change-id: 20250122-dma-c2778dfa4246

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@microchip.com>


