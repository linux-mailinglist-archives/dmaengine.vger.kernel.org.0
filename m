Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DBD2A98B8
	for <lists+dmaengine@lfdr.de>; Fri,  6 Nov 2020 16:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgKFPnt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Nov 2020 10:43:49 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3031 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbgKFPnt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Nov 2020 10:43:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa56f320000>; Fri, 06 Nov 2020 07:43:46 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 15:43:48 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 15:43:45 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <vkoul@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <maz@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/4] dt-bindings: dma: Convert ADMA doc to json-schema
Date:   Fri, 6 Nov 2020 21:13:31 +0530
Message-ID: <1604677413-20411-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
References: <1604677413-20411-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604677426; bh=BmeAHSwzcrNscdXhWYMxiUBkGx2hykWAtx/Wo4UKk7o=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=m98qe2tbqXWkcvcaV3woK987Jw5SoDGx4aRsaxC+R4RLNuqYHRky2U9tl+bTHhX1C
         m6jDmvlhVjl9ZVFfMEUQTMXtq++2gjBqCUEgBlt0a5WyJ+f75GmG5Z8uJzsjEsbosL
         EbSyjDSnlEbZORPEYuhd9evySKcSpXpGeFOPYdHxHQymeYce5OgW7oKovHfam3FyO6
         jSR69T5vSi3hBSUJj2B0hs0pbtBXSvk7/e+x+FOg6n5uEgNhcEqoELYSnu7lWH5Kf4
         EZoW4+jMspA4h1NhtYe3TfEz3/bhsAbBomaqLxvyZJk2BG8zBazY3IoRfNsHr3H/ma
         kKmVeSe6Asm9w==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move ADMA documentation to YAML format.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../bindings/dma/nvidia,tegra210-adma.txt          | 56 ------------
 .../bindings/dma/nvidia,tegra210-adma.yaml         | 99 ++++++++++++++++++++++
 2 files changed, 99 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
deleted file mode 100644
index 245d306..0000000
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* NVIDIA Tegra Audio DMA (ADMA) controller
-
-The Tegra Audio DMA controller that is used for transferring data
-between system memory and the Audio Processing Engine (APE).
-
-Required properties:
-- compatible: Should contain one of the following:
-  - "nvidia,tegra210-adma": for Tegra210
-  - "nvidia,tegra186-adma": for Tegra186 and Tegra194
-- reg: Should contain DMA registers location and length. This should be
-  a single entry that includes all of the per-channel registers in one
-  contiguous bank.
-- interrupts: Should contain all of the per-channel DMA interrupts in
-  ascending order with respect to the DMA channel index.
-- clocks: Must contain one entry for the ADMA module clock
-  (TEGRA210_CLK_D_AUDIO).
-- clock-names: Must contain the name "d_audio" for the corresponding
-  'clocks' entry.
-- #dma-cells : Must be 1. The first cell denotes the receive/transmit
-  request number and should be between 1 and the maximum number of
-  requests supported. This value corresponds to the RX/TX_REQUEST_SELECT
-  fields in the ADMA_CHn_CTRL register.
-
-
-Example:
-
-adma: dma@702e2000 {
-	compatible = "nvidia,tegra210-adma";
-	reg = <0x0 0x702e2000 0x0 0x2000>;
-	interrupt-parent = <&tegra_agic>;
-	interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&tegra_car TEGRA210_CLK_D_AUDIO>;
-	clock-names = "d_audio";
-	#dma-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
new file mode 100644
index 0000000..5c2e2f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra210-adma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Audio DMA (ADMA) controller
+
+description: |
+  The Tegra Audio DMA controller is used for transferring data
+  between system memory and the Audio Processing Engine (APE).
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nvidia,tegra210-adma
+          - nvidia,tegra186-adma
+      - items:
+          - const: nvidia,tegra194-adma
+          - const: nvidia,tegra186-adma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Should contain all of the per-channel DMA interrupts in
+      ascending order with respect to the DMA channel index.
+    minItems: 1
+    maxItems: 32
+
+  clocks:
+    description: Must contain one entry for the ADMA module clock
+    maxItems: 1
+
+  clock-names:
+    const: d_audio
+
+  "#dma-cells":
+    description: |
+      The first cell denotes the receive/transmit request number and
+      should be between 1 and the maximum number of requests supported.
+      This value corresponds to the RX/TX_REQUEST_SELECT fields in the
+      ADMA_CHn_CTRL register.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include<dt-bindings/clock/tegra210-car.h>
+
+    dma-controller@702e2000 {
+        compatible = "nvidia,tegra210-adma";
+        reg = <0x702e2000 0x2000>;
+        interrupt-parent = <&tegra_agic>;
+        interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car TEGRA210_CLK_D_AUDIO>;
+        clock-names = "d_audio";
+        #dma-cells = <1>;
+    };
+
+...
-- 
2.7.4

