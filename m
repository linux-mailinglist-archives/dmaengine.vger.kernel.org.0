Return-Path: <dmaengine+bounces-1140-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211486A50E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 02:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6725FB22893
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C674184F;
	Wed, 28 Feb 2024 01:33:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.ingenic.com (mail.ingenic.com [106.37.171.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6BA111E;
	Wed, 28 Feb 2024 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.37.171.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083998; cv=none; b=kViN1bM8a4SyGWOPzhxjlXCNYW7BPhaAFhYgTpA13pf6hQ/hKyLpsoPNXy+YbqqkJTe2PEckkNnGUuU9FWZT1DFMqsaH86hcX9ixzGTp03InfftTPM418UFxGJokdvI3KFguhviVIMjDpChb/Hb8KaDbgGvG7rZruUCpZFmwGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083998; c=relaxed/simple;
	bh=er9AQ7KlYPcKRmbjyoAvCtJCIjB1H+GexaZJDwleMLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R44eP0cXl0Npi69DR4ushMflhhrr7JqeYc3Cja0t0oZCFNoqr8g+zT8LvCbcsRJSX4fXqoxgOjPgPpk+vXp0qraKGHoP8jj1CAAIMJDrDK7VlulcL6kxWKX0dchXQ3/kJ9ZGcD+qkhwGnS8IK1sCrS7A1m4U0zyDLe+DFinqVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ingenic.com; spf=pass smtp.mailfrom=ingenic.com; arc=none smtp.client-ip=106.37.171.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ingenic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ingenic.com
Received: from localhost (unknown [60.173.195.77])
	by mail.ingenic.com (Postfix) with ESMTPA id 1197E2700153;
	Wed, 28 Feb 2024 09:24:24 +0800 (CST)
From: "bin.yao" <bin.yao@ingenic.com>
To: vkoul@kernel.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	quic_bjorande@quicinc.com,
	byao <bin.yao@ingenic.com>,
	rick <rick.tyliu@ingenic.com>
Subject: [PATCH 1/2] dt-bindings: dma: Ingenic: DT bindings for Ingenic PDMA
Date: Wed, 28 Feb 2024 06:24:19 +0500
Message-Id: <20240228012420.4223-1-bin.yao@ingenic.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: byao <bin.yao@ingenic.com>

Convert the textual documentation for the Ingenic SoCs PDMA
Controller devicetree binding to YAML.

Add a dt-bindings header, and convert the device trees to it.

Signed-off-by: byao <bin.yao@ingenic.com>
Signed-off-by: rick <rick.tyliu@ingenic.com>
---
 .../devicetree/bindings/dma/ingenic,pdma.yaml | 77 +++++++++++++++++++
 include/dt-bindings/dma/ingenic-pdma.h        | 51 ++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
 create mode 100644 include/dt-bindings/dma/ingenic-pdma.h

diff --git a/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml b/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
new file mode 100644
index 000000000000..b3f3a8f0b813
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/ingenic,dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic SoCs DMA Controller DT bindings
+
+maintainers:
+  - byao <bin.yao@ingenic.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - ingenic,m200-pdma
+          - ingenic,x1000-pdma
+          - ingenic,t40-pdma
+          - ingenic,t41-pdma
+          - ingenic,t33-pdma
+
+  reg:
+    maxItems: 1
+
+  interrupts-parent:
+    maxItems: 1
+
+  interrupts-names:
+    items:
+      - const: pdam
+      - const: pdmam
+
+  interrupts:
+    maxItems: 1
+
+  dma-channels:
+    const: 32
+
+  "#dma-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: gate_pdma
+
+required:
+  - compatible
+  - reg
+  - interrupt-parent
+  - interrupt-names
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ingenic,t33-cgu.h>
+    pdma:dma@13420000 {
+      compatible = "ingenic,t33-pdma";
+      reg = <0x13420000 0x10000>;
+      interrupt-parent = <&plic>;
+      interrupt-names = "pdma", "pdmam";
+      interrupts = <10 61>;
+      #dma-channels = <0x20>;
+      #dma-cells = <0x1>;
+      clocks = <&cgu T33_CLK_DMA>;
+      clock-names = "gate_pdma";
+    };
+
diff --git a/include/dt-bindings/dma/ingenic-pdma.h b/include/dt-bindings/dma/ingenic-pdma.h
new file mode 100644
index 000000000000..99c871bc0ea8
--- /dev/null
+++ b/include/dt-bindings/dma/ingenic-pdma.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef __INGENIC_PDMA_H__
+#define __INGENIC_PDMA_H__
+
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
+#define INGENIC_DMA_TYPE_REQ_MSK	0xff
+#define INGENIC_DMA_TYPE_CH_SFT		8
+#define INGENIC_DMA_TYPE_CH_MSK		(0xff << INGENIC_DMA_TYPE_CH_SFT)
+#define INGENIC_DMA_TYPE_CH_EN		(1 << 16)
+#define INGENIC_DMA_TYPE_PROG		(1 << 17)
+#define INGENIC_DMA_TYPE_SPEC		(1 << 18)
+
+#define INGENIC_DMA_CH(ch)		\
+	((((ch) << INGENIC_DMA_TYPE_CH_SFT) & INGENIC_DMA_TYPE_CH_MSK) | INGENIC_DMA_TYPE_CH_EN)
+
+#define INGENIC_DMA_TYPE(type)	     ((type) & INGENIC_DMA_TYPE_REQ_MSK)
+#define INGENIC_DMA_TYPE_CH(type, ch) (INGENIC_DMA_TYPE((type)) | INGENIC_DMA_CH((ch)))
+#define INGENIC_DMA_PG_CH(type, ch) (INGENIC_DMA_TYPE_CH((type), (ch)) | INGENIC_DMA_TYPE_PROG_MSK)
+#endif
-- 
2.17.1


