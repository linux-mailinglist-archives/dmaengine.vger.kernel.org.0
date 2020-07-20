Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB0F2257A9
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jul 2020 08:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGTGej (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jul 2020 02:34:39 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1257 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTGei (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jul 2020 02:34:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f153a870000>; Sun, 19 Jul 2020 23:32:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Jul 2020 23:34:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Jul 2020 23:34:38 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 06:34:33 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jul 2020 06:34:33 +0000
Received: from rgumasta-linux.nvidia.com (Not Verified[10.19.66.108]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f153af60003>; Sun, 19 Jul 2020 23:34:33 -0700
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>, <rgumasta@nvidia.com>
Subject: [Patch v1 1/4] dt-bindings: dma: Add DT binding document
Date:   Mon, 20 Jul 2020 12:04:13 +0530
Message-ID: <1595226856-19241-2-git-send-email-rgumasta@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
References: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595226759; bh=emXIxr25bKzLG+Qy905dQFujQsp0hysRsiGPfFktYyw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=M1DGO7B7Xq9aShOmWatzXSCKMB5CV9pxJS/tH/MIOm5UJSJJDgMMGRJWGKU6PRl+7
         df0Inuz8yBfE3jfTsLg1uHJzf+aFpPthEVVjaSW04BF0ZdymdCsMReS4uUL+WMJ8KD
         MsIBZ6ij2RcHgKUdPgQCJlEsoLFuZSRvaSXHHjzcX8EgFl7Lfr9Td3m6v5swzRZwUV
         ryh9Onv3jahFD6KCLhU/lKzt3RJpJzfX6Fq08fGEjId1o4AU5IBROOKhqILDClpDRT
         GmPLTAcTjth3Bqq+U2g7EbjusR8Al+PHaOSLxzsKXiagvhgoM6KsuU8lcsfitgMarj
         IAzvWmCLDXlQA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
---
 .../bindings/dma/nvidia,tegra-gpc-dma.yaml         | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
new file mode 100644
index 0000000..39827ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra-gpc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra GPC DMA Controller Device Tree Bindings
+
+description: |
+  Tegra GPC DMA controller is a general purpose dma used for faster data
+  transfers between memory to memory, memory to device and device to memory.
+  Terms 'dma' and 'gpcdma' can be used interchangeably.
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Rajesh Gumasta <rgumasta@nvidia.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+
+  compatible:
+    - enum:
+      - nvidia,tegra186-gpcdma
+      - nvidia,tegra194-gpcdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: gpcdma
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+  - reset-names
+  - "#dma-cells"
+  - iommus
+
+examples:
+  - |
+    gpcdma: dma@2600000 {
+	  compatible = "nvidia,tegra186-gpcdma";
+	  reg = <0x0 0x2600000 0x0 0x210000>;
+	  resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+	  reset-names = "gpcdma";
+	  interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
+	                GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+       #dma-cells = <1>;
+	   iommus = <&smmu TEGRA_SID_GPCDMA_0>;
+	   dma-coherent;
+	};
+
+...
-- 
2.7.4

