Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB8489D14
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiAJQGA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 11:06:00 -0500
Received: from mail-bn7nam10on2083.outbound.protection.outlook.com ([40.107.92.83]:15860
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236654AbiAJQF6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jan 2022 11:05:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dg6YPuKbMB6WDnqwDvGqGrrKhQn0xJZhuWYSrJnn3DqmNF0ECmtTx9R168bjRZrnEJ56ZZzt76Wy7LsjdJuVITHTgzgKfkkKjVuCsA7iyoSOaswmtOXn7XGet+u+JGaZEpjDcp+z9Z7xyvYlPblBiHWPxKadgx2C51dgtsiMQ0kuSqvD07npA79JHJKho2mHY3fhciqtbBxqSe7WfPNv7IxZAF5DXS4lsUl+Hd9eRkKUzjujTNIjR5a3D2024mDVA92hqAcnsdNqOxoe6yL/NDvp+HTHx+QMeTKnkSiuB1GgWZTTgTLA6j3P811Xfbsu0hOTAilUCfNG9U6BArYhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=ezDghtqHrqJRDtdY4dn/uo3iMVuOW/OD4cq8euGUqSv69nB3aJPaQAes6vR5xki6eKAnn0Essle67VFCp0pPvm0PnMIGMZGzLOb2GT4X4rHDj6FCfwWxhkSYmDV0yZ/U1iK0D4Nw+R+hk2OluAmuRv/m6yMr1OVmZ8x7776jf0cCko5XIV38+r5GasXbhvSAds29hcopkLbLG8FzF5+rrze0pLCBm+WlcaMGeZbpgKgEGIrHXNTIvansZUszsltbqqikKz7f+5US/GYR05GVsiybAB0+avTFDK2N8q0CHgJQQo0xZQF1TF2oXniDPcKeADPcCS5pKD9w9SAFOBd4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=VWJPFtr/U0U+y5/lzDFNAfb6Q1g8TyeJzL5Kam0GncxPW+DZyar1m+b6nN2Ktkogieq200QSHBIIMhJWqqXjIoIqt/7hKjDyoCx+IswmGRXXI6QkE2dIhXo0N+4mi2asuJIog1WgbRz40Blr3c6V3yN5lbfC89p1TmPd0chQQwqrUc8qJ5CNlp8rIKnhWNwMOPb2MUWOY6v4XsKUpV7xjTqZqydtpavFPCp/OLbrp6iEDiSL01ORSDm00OvIA4VxySSxSc9L4jHr7p0akjDY6+vDVWYBzoZVtXv3j/hYlEfE89V2LFk4B9H5J/CUNd6I2vFMy3cFaBqfSnApnr88dw==
Received: from BN6PR2001CA0048.namprd20.prod.outlook.com
 (2603:10b6:405:16::34) by DM5PR12MB1673.namprd12.prod.outlook.com
 (2603:10b6:4:e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 16:05:56 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::a) by BN6PR2001CA0048.outlook.office365.com
 (2603:10b6:405:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Mon, 10 Jan 2022 16:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 16:05:55 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 16:05:54 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 16:05:54 +0000
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 10 Jan 2022 16:05:51 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v16 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Mon, 10 Jan 2022 21:35:15 +0530
Message-ID: <1641830718-23650-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7994c0e1-0f02-4af7-b7c1-08d9d453159e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1673:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB167376A39BB99F069F7F241CC0509@DM5PR12MB1673.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WMW91CZx5JfeNK7MSv8n1X3ZqX7aEUi+gr6gRY0bw3emFyD/k197u58Cw5tR?=
 =?us-ascii?Q?+pFTUSgkFiK8Xt3LL9GSe2Z8VYcoD+Z/hmPDZ7efYXIetgaXcgIUD9xV0Zz4?=
 =?us-ascii?Q?P0yNoKuWKu4lBVe/oCV5/obMc8cJHDE3OBl3Cc0ivxqYAx/PV3gekUSavd5n?=
 =?us-ascii?Q?npqxZNMFiIo9LSZJBMQUq0NJt5/2uqY5s9A/jymTD8j7erSeozldpvdgxLRw?=
 =?us-ascii?Q?K+hT8ik38oo6qM2K6ba+fcRRuNeCoKcdXljT/hEJRqlfsCZarwyEm4Neufe8?=
 =?us-ascii?Q?4ZJNSnqDroMwdooBt2OiGYUjopzdjqmmsGljjKV96lfEi+pZDE9az3QsOG7X?=
 =?us-ascii?Q?YnKumNK4QCdCfbq5WOLu72Xi0QVjn7QOdfVB9Yjyj6K76pSW29Cs1bYq9utn?=
 =?us-ascii?Q?lbx2VbqURAaWI1+nJBqi6b9Ioqy0r3yRWi1de2/9Uc6z2ftAwmryZrQwBQ4a?=
 =?us-ascii?Q?u+dZmGO+cqx2oeluPYxinlf/pORlWP7/kJo0AAWiyWBNAyzljByKNvJG7YR/?=
 =?us-ascii?Q?gte4n/gY3NW94rE8IPXJpd4Qnjf37OQKYXZekDmKhIkJWZNVDjrX8rTnLT5U?=
 =?us-ascii?Q?LHts/D1r6YTRLai8fY0qICKJIvmHuhkNJ55x6ILcgGMzP4JzVkxeXWfma+zb?=
 =?us-ascii?Q?lh0nyMO4l+ZulHiwSMV5dL1NYxRJ51GVVsgiNNka402EJ/TweSRGzXzpFzxb?=
 =?us-ascii?Q?q979XC/xkxVMnYnLu9KZQhsLGpfu7j5dM46I2EdFh1tyw0XtjXzW+OG7Y6RB?=
 =?us-ascii?Q?au4IlT6gme7bj4JysQAO3gd+0Lm4NK+faUSWlqEl92S9cI+dTYLrQQ6Sf/Nm?=
 =?us-ascii?Q?5YAB9vc+7jup62vdn57A/ZRkiUh7EvT4Xj4Dp06KtXWrr7IgBJrfoE3qOHvs?=
 =?us-ascii?Q?8boCkjO+bcSIyi/uuXTsv2wdEltDxuwbyec9oHzSMjpkQef7qOcDR2+mHxRl?=
 =?us-ascii?Q?mn1C1dy0UN6N1wSp2kwUksiwJx8nfpS3TNW9Vvphqzw=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(356005)(8936002)(2906002)(336012)(86362001)(83380400001)(5660300002)(966005)(47076005)(508600001)(186003)(70586007)(70206006)(921005)(36756003)(4326008)(8676002)(107886003)(6666004)(316002)(40460700001)(426003)(2616005)(7696005)(110136005)(81166007)(36860700001)(82310400004)(26005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 16:05:55.7233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7994c0e1-0f02-4af7-b7c1-08d9d453159e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1673
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..9dd1476
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
+
+description: |
+  The Tegra General Purpose Central (GPC) DMA controller is used for faster
+  data transfers between memory to memory, memory to device and device to
+  memory.
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Rajesh Gumasta <rgumasta@nvidia.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra186-gpcdma
+      - items:
+          - const: nvidia,tegra194-gpcdma
+          - const: nvidia,tegra186-gpcdma
+
+  "#dma-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Should contain all of the per-channel DMA interrupts in
+      ascending order with respect to the DMA channel index.
+    minItems: 1
+    maxItems: 31
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
+  dma-coherent: true
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/tegra186-mc.h>
+    #include <dt-bindings/reset/tegra186-reset.h>
+
+    dma-controller@2600000 {
+        compatible = "nvidia,tegra186-gpcdma";
+        reg = <0x2600000 0x210000>;
+        resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+        reset-names = "gpcdma";
+        interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+        iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+        dma-coherent;
+    };
+...
-- 
2.7.4

