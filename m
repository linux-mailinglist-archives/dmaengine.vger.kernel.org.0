Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B622A7B9A
	for <lists+dmaengine@lfdr.de>; Thu,  5 Nov 2020 11:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgKEKZD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Nov 2020 05:25:03 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6892 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbgKEKZB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Nov 2020 05:25:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa3d3000001>; Thu, 05 Nov 2020 02:25:04 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 10:25:00 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 5 Nov 2020 10:24:57 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <vkoul@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <maz@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 4/4] dt-bindings: bus: Convert ACONNECT doc to json-schema
Date:   Thu, 5 Nov 2020 15:54:06 +0530
Message-ID: <1604571846-14037-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604571904; bh=EJno3VbzOuyzb/wyka2F0PEnWEXtojA2Cq7GOlRFzzA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=rhUmBaIdGpuW7aG0n5KHFPbqvWBkqUL0QdzM7mU+61br1dUi2wDbgDnLjc3Pjkvxd
         ftF/9dYngokngSs9Gbuo4vVx7utmzs1943Xxh51ZRkiYmj4n9Nj3mjsIaPanhZWHNQ
         6zVo976HUbW9Di5TzkblIOwyMaTtKsEtJY3mQ3aaRGXFJ1fz9TrD71qeecSxxAggmT
         izcU7a7XitBQfnhQ0oYrSLz1EAib36xyU59cofFj46M610ITC/DPa7Kw+Bj/nEBPNK
         hA7yqquWP/SpoqxAUaDUigP/LE4rcJA6UvsFVkns6lDLZ85VPbBCbe9sf2RaxZS4Iq
         XmfVM/2eVh1yA==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move ACONNECT documentation to YAML format.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../bindings/bus/nvidia,tegra210-aconnect.txt      | 44 -----------
 .../bindings/bus/nvidia,tegra210-aconnect.yaml     | 86 ++++++++++++++++++++++
 2 files changed, 86 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
 create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml

diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
deleted file mode 100644
index 3108d03..0000000
--- a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-NVIDIA Tegra ACONNECT Bus
-
-The Tegra ACONNECT bus is an AXI switch which is used to connnect various
-components inside the Audio Processing Engine (APE). All CPU accesses to
-the APE subsystem go through the ACONNECT via an APB to AXI wrapper.
-
-Required properties:
-- compatible: Must be "nvidia,tegra210-aconnect".
-- clocks: Must contain the entries for the APE clock (TEGRA210_CLK_APE),
-  and APE interface clock (TEGRA210_CLK_APB2APE).
-- clock-names: Must contain the names "ape" and "apb2ape" for the corresponding
-  'clocks' entries.
-- power-domains: Must contain a phandle that points to the audio powergate
-  (namely 'aud') for Tegra210.
-- #address-cells: The number of cells used to represent physical base addresses
-  in the aconnect address space. Should be 1.
-- #size-cells: The number of cells used to represent the size of an address
-  range in the aconnect address space. Should be 1.
-- ranges: Mapping of the aconnect address space to the CPU address space.
-
-All devices accessed via the ACONNNECT are described by child-nodes.
-
-Example:
-
-	aconnect@702c0000 {
-		compatible = "nvidia,tegra210-aconnect";
-		clocks = <&tegra_car TEGRA210_CLK_APE>,
-			 <&tegra_car TEGRA210_CLK_APB2APE>;
-		clock-names = "ape", "apb2ape";
-		power-domains = <&pd_audio>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x702c0000 0x0 0x702c0000 0x00040000>;
-
-
-		child1 {
-			...
-		};
-
-		child2 {
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
new file mode 100644
index 0000000..f0161bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/nvidia,tegra210-aconnect.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra ACONNECT Bus
+
+description: |
+  The Tegra ACONNECT bus is an AXI switch which is used to connnect various
+  components inside the Audio Processing Engine (APE). All CPU accesses to
+  the APE subsystem go through the ACONNECT via an APB to AXI wrapper. All
+  devices accessed via the ACONNNECT are described by child-nodes.
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra210-aconnect
+      - items:
+          - enum:
+              - nvidia,tegra186-aconnect
+              - nvidia,tegra194-aconnect
+          - const: nvidia,tegra210-aconnect
+
+  clocks:
+    items:
+      - description: Must contain the entry for APE clock
+      - description: Must contain the entry for APE interface clock
+
+  clock-names:
+    items:
+      - const: ape
+      - const: apb2ape
+
+  power-domains:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^dma-controller(@[0-9a-f]+)?$":
+    $ref: /schemas/dma/nvidia,tegra210-adma.yaml#
+  "^interrupt-controller(@[0-9a-f]+)?$":
+    $ref: /schemas/interrupt-controller/arm,gic.yaml#
+  "^ahub(@[0-9a-f]+)?$":
+    $ref: /schemas/sound/nvidia,tegra210-ahub.yaml#
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - power-domains
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include<dt-bindings/clock/tegra210-car.h>
+
+    aconnect@702c0000 {
+        compatible = "nvidia,tegra210-aconnect";
+        clocks = <&tegra_car TEGRA210_CLK_APE>,
+                 <&tegra_car TEGRA210_CLK_APB2APE>;
+        clock-names = "ape", "apb2ape";
+        power-domains = <&pd_audio>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x702c0000 0x702c0000 0x00040000>;
+
+        // Child device nodes follow ...
+    };
+
+...
-- 
2.7.4

