Return-Path: <dmaengine+bounces-1460-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70458885545
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 09:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D5C282AE3
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965C58212;
	Thu, 21 Mar 2024 08:10:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.ingenic.com (mail.ingenic.cn [106.37.171.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7641E4E;
	Thu, 21 Mar 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.37.171.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008656; cv=none; b=i0ZfP2yeakI9yw29oBkm6sMXrDpEsPjdF7Zms15tRlutniNGMexL8uR6Na50wNNt78Ygh2h8GbbLlldPWBahDTq9nnC8OtTEbeO2WoKtopz3fhEiauhb/lHG0AYZ6VnDV+jnhJMogNZC4pj63OEVM/Ar857rmijI4nftMmFuD8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008656; c=relaxed/simple;
	bh=KpwFZqu5awjIO4YqETsSzhxRfJ41ejACAQHkqj10cQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SAFjOGipLvfxdbYxGQrgElfGEZS5fhje/jEX60AR4Abi0LxFRq/rTvjnICoORBPigawEGPqw1uUsUsu33D5cYbHYD3ErePPttli3+dx5G2xiSyEOP6Or/A218MRSnVX6eD3rSrQE/k0CN+TrFHV4LKC7w0JFK4VcmZOJvS5gTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ingenic.com; spf=pass smtp.mailfrom=ingenic.com; arc=none smtp.client-ip=106.37.171.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ingenic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ingenic.com
Received: from localhost (unknown [60.173.195.77])
	by mail.ingenic.com (Postfix) with ESMTPA id EA4DE2700131;
	Thu, 21 Mar 2024 16:02:36 +0800 (CST)
From: bin.yao@ingenic.com
To: vkoul@kernel.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	1587636487@qq.com,
	"bin.yao" <bin.yao@ingenic.com>
Subject: [PATCH 2/2] dt-bindings: dma: Convert ingenic-pdma doc to YAML
Date: Thu, 21 Mar 2024 16:02:28 +0800
Message-Id: <20240321080228.24147-2-bin.yao@ingenic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240321080228.24147-1-bin.yao@ingenic.com>
References: <20240321080228.24147-1-bin.yao@ingenic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

From: "bin.yao" <bin.yao@ingenic.com>

Convert the textual documentation for the Ingenic SoCs PDMA Controller
devicetree binding to YAML.

Signed-off-by: bin.yao <bin.yao@ingenic.com>
---
 .../devicetree/bindings/dma/ingenic,pdma.yaml | 67 +++++++++++++++++++
 include/dt-bindings/dma/ingenic-pdma.h        | 45 +++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
 create mode 100644 include/dt-bindings/dma/ingenic-pdma.h

diff --git a/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml b/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
new file mode 100644
index 000000000000..290dbf182a01
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ingenic,pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic SoCs PDMA Controller
+
+maintainers:
+  - bin.yao <bin.yao@ingenic.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ingenic,t33-pdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupts-names:
+    const: pdma
+
+  "#dma-cells":
+    const: 1
+
+  dma-channels:
+    const: 32
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: gate_pdma
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupts-names
+  - "#dma-cells"
+  - dma-channels
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
+    pdma:dma@13420000 {
+      compatible = "ingenic,t33-pdma";
+      reg = <0x13420000 0x10000>;
+      interrupt-parent = <&intc>;
+      interrupt-names = "pdma";
+      interrupts = <10>;
+      #dma-cells = <0x1>;
+      dma-channels = <0x20>;
+      clocks = <&cgu JZ4780_CLK_PDMA>;
+      clock-names = "gate_pdma";
+    };
+
diff --git a/include/dt-bindings/dma/ingenic-pdma.h b/include/dt-bindings/dma/ingenic-pdma.h
new file mode 100644
index 000000000000..66188d588232
--- /dev/null
+++ b/include/dt-bindings/dma/ingenic-pdma.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2024 Ingenic Semiconductor Co., Ltd.
+ * Author: bin.yao <bin.yao@ingenic.com>
+ */
+
+#ifndef __DT_BINDINGS_INGENIC_PDMA_H__
+#define __DT_BINDINGS_INGENIC_PDMA_H__
+
+/*
+ * Request type numbers for the INGENIC DMA controller.
+ */
+#define INGENIC_DMA_REQ_AIC_LOOP_RX	0x5
+#define INGENIC_DMA_REQ_AIC_TX		0x6
+#define INGENIC_DMA_REQ_AIC_F_RX	0x7
+#define INGENIC_DMA_REQ_AUTO_TX		0x8
+#define INGENIC_DMA_REQ_SADC_RX		0x9
+#define INGENIC_DMA_REQ_UART5_TX	0xa
+#define INGENIC_DMA_REQ_UART5_RX	0xb
+#define INGENIC_DMA_REQ_UART4_TX	0xc
+#define INGENIC_DMA_REQ_UART4_RX	0xd
+#define INGENIC_DMA_REQ_UART3_TX	0xe
+#define INGENIC_DMA_REQ_UART3_RX	0xf
+#define INGENIC_DMA_REQ_UART2_TX	0x10
+#define INGENIC_DMA_REQ_UART2_RX	0x11
+#define INGENIC_DMA_REQ_UART1_TX	0x12
+#define INGENIC_DMA_REQ_UART1_RX	0x13
+#define INGENIC_DMA_REQ_UART0_TX	0x14
+#define INGENIC_DMA_REQ_UART0_RX	0x15
+#define INGENIC_DMA_REQ_SSI0_TX		0x16
+#define INGENIC_DMA_REQ_SSI0_RX		0x17
+#define INGENIC_DMA_REQ_SSI1_TX		0x18
+#define INGENIC_DMA_REQ_SSI1_RX		0x19
+#define INGENIC_DMA_REQ_SLV_TX		0x1a
+#define INGENIC_DMA_REQ_SLV_RX		0x1b
+#define INGENIC_DMA_REQ_I2C0_TX		0x24
+#define INGENIC_DMA_REQ_I2C0_RX		0x25
+#define INGENIC_DMA_REQ_I2C1_TX		0x26
+#define INGENIC_DMA_REQ_I2C1_RX		0x27
+#define INGENIC_DMA_REQ_I2C2_TX		0x28
+#define INGENIC_DMA_REQ_I2C2_RX		0x29
+#define INGENIC_DMA_REQ_DES_TX		0x2e
+#define INGENIC_DMA_REQ_DES_RX		0x2f
+
+#endif /* __DT_BINDINGS_INGENIC_PDMA_H__ */
-- 
2.17.1


