Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0162A7BA6
	for <lists+dmaengine@lfdr.de>; Thu,  5 Nov 2020 11:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgKEKY5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Nov 2020 05:24:57 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6865 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgKEKYy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Nov 2020 05:24:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa3d2f90002>; Thu, 05 Nov 2020 02:24:57 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 10:24:53 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 5 Nov 2020 10:24:50 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <vkoul@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <maz@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/4] dt-bindings: dma: Convert ADMA doc to json-schema
Date:   Thu, 5 Nov 2020 15:54:04 +0530
Message-ID: <1604571846-14037-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604571897; bh=ZiE19ShmgN2M88iHqu8BwmdG3lh2LxfHHpvrRd1ZTf0=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=C8j4A4mkuZePquw+wMSAN6W66eUQ/pp5DZwMiW8zHaQu+b8FMC9fLJfyWN+hbRXX7
         rCfFZipm+O0R0fIHONVAVSYWg1b8lnsHVGo1i9OfG5HIX4Fyl04nXbDZNa3IZ0IBed
         1NLV2mYJeoqNZDOdOEMboFwpBYPeEuQZWvO/2lihu62uz1wvM0RP0J1i1xVRSNlTjQ
         AvV97Kj7V1zzjMUMWQPeBxZFgSs8XYrua5iPgVsUmHPsxIkEPOY/0IUxmUjfUG9Eso
         bfO2AsJGM2ZrEHP6wTHaPMLWMjvshSFVXx/tz8Gl9Z6jiuxkdwHnwnNSNZDgimbQ/e
         A/+aGNIteiQLw==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move ADMA documentation to YAML format.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../bindings/dma/nvidia,tegra210-adma.txt          | 56 -------------
 .../bindings/dma/nvidia,tegra210-adma.yaml         | 95 ++++++++++++++++++++++
 2 files changed, 95 insertions(+), 56 deletions(-)
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
index 0000000..b4e657d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
@@ -0,0 +1,95 @@
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
+
+  clocks:
+    description: Must contain one entry for the ADMA module clock
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
+
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
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

