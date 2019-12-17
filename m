Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6999A122792
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 10:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLQJWn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 04:22:43 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39944 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfLQJWn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 04:22:43 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBH9I2xj021244;
        Tue, 17 Dec 2019 10:22:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=iAQm1v7Ed031TkCulLqWjg+eAjLpFrX+Xy8b3lWao54=;
 b=zkXviryVypImlyWgMlsUCm0dxR2NA/ZrmpX31OMTXeS8+tbr0X/f5QosrSr5atOFs2Ne
 +917ZeeiXeFOqpWXq3BqyAg0gLXYT97TvkyqX+gq/xq7H6ccAiPk6DT892gbHoYgZt2R
 mWSCvdbKf9XKTIFki8wOTyeAepjbvQCrW+ktzYSvvkyBZIhc2zQaVPSN1viKkbw5OSzf
 s2ueMNUGko3aw5NVxweBb8lfmXvgtbtsYIK+t5VNOKntOapBnbVmC79Xogi+MGUSEaca
 D+HlDcySLWxGRrJ912NwZrBMk0lvCOANF6tpTDuP4tbH0Iu6yOrAKjcWujxXqgc/6mUP bQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp36x07h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 10:22:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 925D210002A;
        Tue, 17 Dec 2019 10:22:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 857BD2A64E4;
        Tue, 17 Dec 2019 10:22:31 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 17 Dec 2019 10:22:30
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/6] dt-bindings: dma: Convert stm32 MDMA bindings to json-schema
Date:   Tue, 17 Dec 2019 10:21:57 +0100
Message-ID: <20191217092201.20022-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191217092201.20022-1-benjamin.gaignard@st.com>
References: <20191217092201.20022-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert the STM32 MDMA binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/dma/st,stm32-mdma.yaml     | 105 +++++++++++++++++++++
 .../devicetree/bindings/dma/stm32-mdma.txt         |  94 ------------------
 2 files changed, 105 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt

diff --git a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml b/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
new file mode 100644
index 000000000000..c66543d0c267
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/st,stm32-mdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 MDMA Controller bindings
+
+description: |
+  The STM32 MDMA is a general-purpose direct memory access controller capable of
+  supporting 64 independent DMA channels with 256 HW requests.
+  DMA clients connected to the STM32 MDMA controller must use the format
+  described in the dma.txt file, using a five-cell specifier for each channel:
+  a phandle to the MDMA controller plus the following five integer cells:
+    1. The request line number
+    2. The priority level
+      0x0: Low
+      0x1: Medium
+      0x2: High
+      0x3: Very high
+    3. A 32bit mask specifying the DMA channel configuration
+      -bit 0-1: Source increment mode
+        0x0: Source address pointer is fixed
+        0x2: Source address pointer is incremented after each data transfer
+        0x3: Source address pointer is decremented after each data transfer
+      -bit 2-3: Destination increment mode
+        0x0: Destination address pointer is fixed
+        0x2: Destination address pointer is incremented after each data transfer
+        0x3: Destination address pointer is decremented after each data transfer
+      -bit 8-9: Source increment offset size
+        0x0: byte (8bit)
+        0x1: half-word (16bit)
+        0x2: word (32bit)
+        0x3: double-word (64bit)
+      -bit 10-11: Destination increment offset size
+        0x0: byte (8bit)
+        0x1: half-word (16bit)
+        0x2: word (32bit)
+        0x3: double-word (64bit)
+      -bit 25-18: The number of bytes to be transferred in a single transfer
+                  (min = 1 byte, max = 128 bytes)
+      -bit 29:28: Trigger Mode
+        0x00: Each MDMA request triggers a buffer transfer (max 128 bytes)
+        0x1: Each MDMA request triggers a block transfer (max 64K bytes)
+        0x2: Each MDMA request triggers a repeated block transfer
+        0x3: Each MDMA request triggers a linked list transfer
+    4. A 32bit value specifying the register to be used to acknowledge the request
+       if no HW ack signal is used by the MDMA client
+    5. A 32bit mask specifying the value to be written to acknowledge the request
+       if no HW ack signal is used by the MDMA client
+
+maintainers:
+  - Amelie Delaunay <amelie.delaunay@st.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 5
+
+  compatible:
+    const: st,stm32h7-mdma
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  st,ahb-addr-masks:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Array of u32 mask to list memory devices addressed via AHB bus.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    dma-controller@52000000 {
+      compatible = "st,stm32h7-mdma";
+      reg = <0x52000000 0x1000>;
+      interrupts = <122>;
+      clocks = <&timer_clk>;
+      resets = <&rcc 992>;
+      #dma-cells = <5>;
+      dma-channels = <16>;
+      dma-requests = <32>;
+      st,ahb-addr-masks = <0x20000000>, <0x00000000>;
+    };
+
+...
+
diff --git a/Documentation/devicetree/bindings/dma/stm32-mdma.txt b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
deleted file mode 100644
index d18772d6bc65..000000000000
--- a/Documentation/devicetree/bindings/dma/stm32-mdma.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-* STMicroelectronics STM32 MDMA controller
-
-The STM32 MDMA is a general-purpose direct memory access controller capable of
-supporting 64 independent DMA channels with 256 HW requests.
-
-Required properties:
-- compatible: Should be "st,stm32h7-mdma"
-- reg: Should contain MDMA registers location and length. This should include
-  all of the per-channel registers.
-- interrupts: Should contain the MDMA interrupt.
-- clocks: Should contain the input clock of the DMA instance.
-- resets: Reference to a reset controller asserting the DMA controller.
-- #dma-cells : Must be <5>. See DMA client paragraph for more details.
-
-Optional properties:
-- dma-channels: Number of DMA channels supported by the controller.
-- dma-requests: Number of DMA request signals supported by the controller.
-- st,ahb-addr-masks: Array of u32 mask to list memory devices addressed via
-  AHB bus.
-
-Example:
-
-	mdma1: dma@52000000 {
-		compatible = "st,stm32h7-mdma";
-		reg = <0x52000000 0x1000>;
-		interrupts = <122>;
-		clocks = <&timer_clk>;
-		resets = <&rcc 992>;
-		#dma-cells = <5>;
-		dma-channels = <16>;
-		dma-requests = <32>;
-		st,ahb-addr-masks = <0x20000000>, <0x00000000>;
-	};
-
-* DMA client
-
-DMA clients connected to the STM32 MDMA controller must use the format
-described in the dma.txt file, using a five-cell specifier for each channel:
-a phandle to the MDMA controller plus the following five integer cells:
-
-1. The request line number
-2. The priority level
-	0x00: Low
-	0x01: Medium
-	0x10: High
-	0x11: Very high
-3. A 32bit mask specifying the DMA channel configuration
- -bit 0-1: Source increment mode
-	0x00: Source address pointer is fixed
-	0x10: Source address pointer is incremented after each data transfer
-	0x11: Source address pointer is decremented after each data transfer
- -bit 2-3: Destination increment mode
-	0x00: Destination address pointer is fixed
-	0x10: Destination address pointer is incremented after each data
-	transfer
-	0x11: Destination address pointer is decremented after each data
-	transfer
- -bit 8-9: Source increment offset size
-	0x00: byte (8bit)
-	0x01: half-word (16bit)
-	0x10: word (32bit)
-	0x11: double-word (64bit)
- -bit 10-11: Destination increment offset size
-	0x00: byte (8bit)
-	0x01: half-word (16bit)
-	0x10: word (32bit)
-	0x11: double-word (64bit)
--bit 25-18: The number of bytes to be transferred in a single transfer
-	(min = 1 byte, max = 128 bytes)
--bit 29:28: Trigger Mode
-	0x00: Each MDMA request triggers a buffer transfer (max 128 bytes)
-	0x01: Each MDMA request triggers a block transfer (max 64K bytes)
-	0x10: Each MDMA request triggers a repeated block transfer
-	0x11: Each MDMA request triggers a linked list transfer
-4. A 32bit value specifying the register to be used to acknowledge the request
-   if no HW ack signal is used by the MDMA client
-5. A 32bit mask specifying the value to be written to acknowledge the request
-   if no HW ack signal is used by the MDMA client
-
-Example:
-
-	i2c4: i2c@5c002000 {
-		compatible = "st,stm32f7-i2c";
-		reg = <0x5c002000 0x400>;
-		interrupts = <95>,
-			     <96>;
-		clocks = <&timer_clk>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		dmas = <&mdma1 36 0x0 0x40008 0x0 0x0>,
-		       <&mdma1 37 0x0 0x40002 0x0 0x0>;
-		dma-names = "rx", "tx";
-		status = "disabled";
-	};
-- 
2.15.0

