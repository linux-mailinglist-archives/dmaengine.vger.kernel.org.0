Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED5D275190
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIWGeZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 02:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIWGeZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Sep 2020 02:34:25 -0400
Received: from localhost.localdomain (unknown [122.171.175.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B893D2223E;
        Wed, 23 Sep 2020 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600842864;
        bh=IQhmDb9Gvirr9W7TU/bGaxVy/Wzg/SI9mkPG47dyJY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lice9a+UyI7fxdQ3sqb7GarHYcxzIynYIH0/2JlZ6oHsMmSqFtADMbEKVQTgBSoPG
         DaoJkIC9NOBAkXgA6qf16++qT+mNPbgAsw371lW86zNqUSCkf6UGb8ABe8j1WoD8Dh
         I3pRD6nX/QlPK1yjfiGS7Nyx37jE5VBio4DMTGOU=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 1/3] dt-bindings: dmaengine: Document qcom,gpi dma binding
Date:   Wed, 23 Sep 2020 12:04:08 +0530
Message-Id: <20200923063410.3431917-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923063410.3431917-1-vkoul@kernel.org>
References: <20200923063410.3431917-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add devicetree binding documentation for GPI DMA controller
implemented on Qualcomm SoCs

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/dma/qcom,gpi.yaml     | 86 +++++++++++++++++++
 include/dt-bindings/dma/qcom-gpi.h            | 11 +++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,gpi.yaml
 create mode 100644 include/dt-bindings/dma/qcom-gpi.h

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
new file mode 100644
index 000000000000..82f404bc8745
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/qcom,gpi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc GPI DMA controller
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description: |
+  QCOM GPI DMA controller provides DMA capabilities for
+  peripheral buses such as I2C, UART, and SPI.
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,gpi-dma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt lines for each GPII instance
+    maxItems: 13
+
+  "#dma-cells":
+    const: 3
+    description: >
+      DMA clients must use the format described in dma.txt, giving a phandle
+      to the DMA controller plus the following 3 integer cells:
+      - channel: if set to 0xffffffff, any available channel will be allocated
+        for the client. Otherwise, the exact channel specified will be used.
+      - seid: serial id of the client as defined in the SoC documentation.
+      - client: type of the client as defined in dt-bindings/dma/qcom-gpi.h
+
+  iommus:
+    maxItems: 1
+
+  dma-channels:
+    maxItems: 1
+
+  dma-channel-mask:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - iommus
+  - dma-channels
+  - dma-channel-mask
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/dma/qcom-gpi.h>
+    gpi_dma0: dma-controller@800000 {
+        compatible = "qcom,gpi-dma";
+        #dma-cells = <3>;
+        reg = <0x00800000 0x60000>;
+        iommus = <&apps_smmu 0x0016 0x0>;
+        dma-channels = <13>;
+        dma-channel-mask = <0xfa>;
+        interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
diff --git a/include/dt-bindings/dma/qcom-gpi.h b/include/dt-bindings/dma/qcom-gpi.h
new file mode 100644
index 000000000000..71f79eb7614c
--- /dev/null
+++ b/include/dt-bindings/dma/qcom-gpi.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2020, Linaro Ltd.  */
+
+#ifndef __DT_BINDINGS_DMA_QCOM_GPI_H__
+#define __DT_BINDINGS_DMA_QCOM_GPI_H__
+
+#define QCOM_GPI_SPI		1
+#define QCOM_GPI_UART		2
+#define QCOM_GPI_I2C		3
+
+#endif /* __DT_BINDINGS_DMA_QCOM_GPI_H__ */
-- 
2.26.2

