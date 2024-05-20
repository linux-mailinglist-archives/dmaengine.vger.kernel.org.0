Return-Path: <dmaengine+bounces-2089-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D48CA025
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 17:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F295C1C2136C
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33A13791D;
	Mon, 20 May 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AnaVMFa+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1F137764;
	Mon, 20 May 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220262; cv=none; b=GGmpTH6dOeH7+O4V6RibZS68P52C5N7oHt8omvpNaiZ6mqDXYhr2bZyxEWPKP90LM4fOU9CXLYdSqUVPwfaGUO8GcfdygFZ3coiqMaGQ+0TEofXTgxtix8UVMcu7z0mecGY8j7ljrE87aEbWCQwerQAlUBLADxvmmbJYpvqrT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220262; c=relaxed/simple;
	bh=I1ZtokjhUY3Hz98ltedYpp/ZaMADHGjRqXtTjFAWZQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZijmRgza9JgIRv0WhcgIRLcqutGY1rvWA9XsDWwBh9U18dPYTMfcVEpgvB60K5QHbfJORI1ApPsMKVkjWwYLZ4bxd9uxKw9KNFN6APrdTQcSgGVqQXX3XvDLO9nckmLqaxOvoMjs9H4Xycl2fcKzTxroxyZrr8SMCLssNLXtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AnaVMFa+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KEFAor004930;
	Mon, 20 May 2024 17:50:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=9ZF3jBpvGxEjMOmWl5kYZUL4xPirVkoV+kbkxrvuiGg=; b=An
	aVMFa++7MmDB2yrBmwYo8IEpAB59CrIq5mBprGX5oPX9WOHdbGwlJ7uJkH9tJ4Te
	hm81M18nEiuHyjmPM72gh4eCrCP1CY5TPPCVYME13z1zeCbsAH2L8Nl2FG866198
	w0xhycI3ftw63azIsW/m0SqY4Kz9Qe86IC+dQbr02c/zqu339IQDMGV0KYNy9KqW
	FErQ+viI/uUR2TRe/WnOixt1e7q6lIehjp1E8b+JWGctcluNmnJChUhdg2dxPYqo
	qx37IhKXHd0vRcWfghgH7iuVFCXzLSEHVLTG7lLvGN0xZh8w7zbbQTQQfgok0Uh7
	UWx73r/CRNEZxwT09F1Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y779hnn06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 17:50:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A26114002D;
	Mon, 20 May 2024 17:50:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA6B4226FC0;
	Mon, 20 May 2024 17:49:55 +0200 (CEST)
Received: from localhost (10.252.8.132) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 17:49:55 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Amelie Delaunay
	<amelie.delaunay@foss.st.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/12] dt-bindings: dma: Document STM32 DMA3 controller bindings
Date: Mon, 20 May 2024 17:49:40 +0200
Message-ID: <20240520154948.690697-5-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
References: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01

The STM32 DMA3 is a Direct Memory Access controller with different features
depending on its hardware configuration.
The channels have not the same capabilities, some have a larger FIFO, so
their performance is higher.
This patch describes STM32 DMA3 bindings, used to select a channel that
fits client requirements, and to pre-configure the channel depending on
the client needs.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
v3:
- add Rob's Reviewed-by after fixing lines length at 80 and useless '|'
v2:
- DMA controller specific information description has been moved and
  added as description of #dma-cells property
- description has been added to interrupts property specifying the
  expected format for channel interrupts
- compatible has been updated to st,stm32mp25-dma3 (SoC specific)
---
 .../bindings/dma/stm32/st,stm32-dma3.yaml     | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
new file mode 100644
index 000000000000..7fdc44b2e646
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/stm32/st,stm32-dma3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 DMA3 Controller
+
+description: |
+  The STM32 DMA3 is a direct memory access controller with different features
+  depending on its hardware configuration.
+  It is either called LPDMA (Low Power), GPDMA (General Purpose) or HPDMA (High
+  Performance).
+  Its hardware configuration registers allow to dynamically expose its features.
+
+  GPDMA and HPDMA support 16 independent DMA channels, while only 4 for LPDMA.
+  GPDMA and HPDMA support 256 DMA requests from peripherals, 8 for LPDMA.
+
+  Bindings are generic for these 3 STM32 DMA3 configurations.
+
+  DMA clients connected to the STM32 DMA3 controller must use the format
+  described in "#dma-cells" property description below, using a three-cell
+  specifier for each channel.
+
+maintainers:
+  - Amelie Delaunay <amelie.delaunay@foss.st.com>
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  compatible:
+    const: st,stm32mp25-dma3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+    maxItems: 16
+    description:
+      Should contain all of the per-channel DMA interrupts in ascending order
+      with respect to the DMA channel index.
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 3
+    description: |
+      Specifies the number of cells needed to provide DMA controller specific
+      information.
+      The first cell is the request line number.
+      The second cell is a 32-bit mask specifying the DMA channel requirements:
+        -bit 0-1: The priority level
+          0x0: low priority, low weight
+          0x1: low priority, mid weight
+          0x2: low priority, high weight
+          0x3: high priority
+        -bit 4-7: The FIFO requirement for queuing source/destination transfers
+          0x0: no FIFO requirement/any channel can fit
+          0x2: FIFO of 8 bytes (2^2+1)
+          0x4: FIFO of 32 bytes (2^4+1)
+          0x6: FIFO of 128 bytes (2^6+1)
+          0x7: FIFO of 256 bytes (2^7+1)
+      The third cell is a 32-bit mask specifying the DMA transfer requirements:
+        -bit 0: The source incrementing burst
+          0x0: fixed burst
+          0x1: contiguously incremented burst
+        -bit 1: The source allocated port
+          0x0: port 0 is allocated to the source transfer
+          0x1: port 1 is allocated to the source transfer
+        -bit 4: The destination incrementing burst
+          0x0: fixed burst
+          0x1: contiguously incremented burst
+        -bit 5: The destination allocated port
+          0x0: port 0 is allocated to the destination transfer
+          0x1: port 1 is allocated to the destination transfer
+        -bit 8: The type of hardware request
+          0x0: burst
+          0x1: block
+        -bit 9: The control mode
+          0x0: DMA controller control mode
+          0x1: peripheral control mode
+        -bit 12-13: The transfer complete event mode
+          0x0: at block level, transfer complete event is generated at the end
+               of a block
+          0x2: at LLI level, the transfer complete event is generated at the end
+               of the LLI transfer
+               including the update of the LLI if any
+          0x3: at channel level, the transfer complete event is generated at the
+               end of the last LLI
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - "#dma-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    dma-controller@40400000 {
+      compatible = "st,stm32mp25-dma3";
+      reg = <0x40400000 0x1000>;
+      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&rcc CK_BUS_HPDMA1>;
+      #dma-cells = <3>;
+    };
+...
-- 
2.25.1


