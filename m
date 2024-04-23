Return-Path: <dmaengine+bounces-1923-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BDA8AE629
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 14:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA082284DA2
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B4134420;
	Tue, 23 Apr 2024 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QLSpv36K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F7130AEE;
	Tue, 23 Apr 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875692; cv=none; b=LyEBAIDhPRLNSfUkTka5w3ijPWEMLHL/OnK4Py5WE2KzKpGZcQrqhHW6mRwQdyjU0H36PiaLSd1bn+k8kFy8HqeK4UKSujat0hSSwRAuIUjFyuyMIVTmayl34Dxy/FiFRGX0a3fXY+Hifc4tQBjnXCCVu1tNiQgx5MbiaRryiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875692; c=relaxed/simple;
	bh=WBUT4kymMUXeYv3ojLXU/LS7tS3CZLJAlVSln7iITng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILT3IcOR82EWogn1LRjFOFkm6MBU7R9TOl5irzMbY2AKIivtUIr1gt4uyeAnLeSE+6vIqM/mAhZGEHklMLm62gwPAq8Hylf7hSTbQNaz44BRCw4EOBMCTLwW6uYypBeq4KQfeizvPGpwZZg0zUs87mdMTpAhblov9+PtgdE1sE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QLSpv36K; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N8H3qQ011919;
	Tue, 23 Apr 2024 14:34:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=k/vRIqBA6IKXycGb1YYyTUrHBvJxD3/5TcGM0lNmKf4=; b=QL
	Spv36K6VqBFkHUgxzMh9IrIOggTVMdMKxjcmqo7HFikev0GrncL6qeY4BgOuCheb
	7OmcyysmImszOcZ1hDGFhwqazyccplTq+z2i5nRRmPf0KDu3vSC0xS07pI1WeXRV
	UeIoADdLTxu5tUgHbMZ37NP7KtEMjLMnCoXdDraEFNO0R34FeObWaLWCPd3TjUzK
	swi+Ck4JypksouK+g9YYIqSfKbbJlDIP+7c66CQuYpUra6E7K8zYOqfNe8RmoVo7
	RlBShZbMb44hklc3k752DtCbNEWkWa6jppxMsY0YOPGcPJTUu1oNa7vV5JygxFvJ
	UpXvURrhWr/lE+v7uYIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4kb3d7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:34:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5195F40047;
	Tue, 23 Apr 2024 14:34:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E238C21A23B;
	Tue, 23 Apr 2024 14:33:26 +0200 (CEST)
Received: from localhost (10.48.86.143) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 14:33:26 +0200
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
	<amelie.delaunay@foss.st.com>
Subject: [PATCH 04/12] dt-bindings: dma: Document STM32 DMA3 controller bindings
Date: Tue, 23 Apr 2024 14:32:54 +0200
Message-ID: <20240423123302.1550592-5-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02

The STM32 DMA3 is a Direct Memory Access controller with different features
depending on its hardware configuration.
The channels have not the same capabilities, some have a larger FIFO, so
their performance is higher.
This patch describes STM32 DMA3 bindings, used to select a channel that
fits client requirements, and to pre-configure the channel depending on
the client needs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 .../bindings/dma/stm32/st,stm32-dma3.yaml     | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml

diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
new file mode 100644
index 000000000000..ea4f8f6add3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
@@ -0,0 +1,125 @@
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
+  It is either called LPDMA (Low Power), GPDMA (General Purpose) or
+  HPDMA (High Performance).
+  Its hardware configuration registers allow to dynamically expose its features.
+
+  GPDMA and HPDMA support 16 independent DMA channels, while only 4 for LPDMA.
+  GPDMA and HPDMA support 256 DMA requests from peripherals, 8 for LPDMA.
+
+  Bindings are generic for these 3 STM32 DMA3 configurations.
+
+  DMA clients connected to the STM32 DMA3 controller must use the format described
+  in the ../dma.txt file, using a four-cell specifier for each channel.
+  A phandle to the DMA controller plus the following three integer cells:
+    1. The request line number
+    2. A 32-bit mask specifying the DMA channel requirements
+      -bit 0-1: The priority level
+        0x0: low priority, low weight
+        0x1: low priority, mid weight
+        0x2: low priority, high weight
+        0x3: high priority
+      -bit 4-7: The FIFO requirement for queuing source and destination transfers
+        0x0: no FIFO requirement/any channel can fit
+        0x2: FIFO of 8 bytes (2^2+1)
+        0x4: FIFO of 32 bytes (2^4+1)
+        0x6: FIFO of 128 bytes (2^6+1)
+        0x7: FIFO of 256 bytes (2^7+1)
+    3. A 32-bit mask specifying the DMA transfer requirements
+      -bit 0: The source incrementing burst
+        0x0: fixed burst
+        0x1: contiguously incremented burst
+      -bit 1: The source allocated port
+        0x0: port 0 is allocated to the source transfer
+        0x1: port 1 is allocated to the source transfer
+      -bit 4: The destination incrementing burst
+        0x0: fixed burst
+        0x1: contiguously incremented burst
+      -bit 5: The destination allocated port
+        0x0: port 0 is allocated to the destination transfer
+        0x1: port 1 is allocated to the destination transfer
+      -bit 8: The type of hardware request
+        0x0: burst
+        0x1: block
+      -bit 9: The control mode
+        0x0: DMA controller control mode
+        0x1: peripheral control mode
+      -bit 12-13: The transfer complete event mode
+        0x0: at block level, transfer complete event is generated at the end of a block
+        0x2: at LLI level, the transfer complete event is generated at the end of the LLI transfer,
+             including the update of the LLI if any
+        0x3: at channel level, the transfer complete event is generated at the end of the last LLI
+
+maintainers:
+  - Amelie Delaunay <amelie.delaunay@foss.st.com>
+
+allOf:
+  - $ref: /schemas/dma/dma-controller.yaml#
+
+properties:
+  "#dma-cells":
+    const: 3
+
+  compatible:
+    const: st,stm32-dma3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    minItems: 4
+    maxItems: 16
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    dma-controller@40400000 {
+      compatible = "st,stm32-dma3";
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


