Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA1439BD2
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhJYQnf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 12:43:35 -0400
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com ([40.107.244.76]:51036
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233983AbhJYQne (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 12:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiwWuU45Em6CwHhzBcjZBW+XKtGFh4C7Q7PLwKu1h3D2NZkem9TK+9h6rX1opBZFH0DTJJVMbTgALOG23t5kbL7gkDx+aH71B32bKSMCzmpfgGtN4qnQsspXYPU9BzeUzMclNl9f3yzGxV1cVZdNl+HgvLCtfTdGf15m8X7RvfebZNJvEMCjL5rGuzuLJFMsXhgBZFK65BA8LOaOFOzoYPbi3mvLjMeWZgRno6JRo6tbhzbpJA+xet2qtWKACKV8Scz0pe8wGptiZthKV3wzTUi/rR0kQVbyEEEz7aAThPrpC4ACc7GJwhp6hcV7OkldiV46HXZ5pslNz+PUaOXBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZh4xdgKBSbhTNehRMnlHp+j9n75FhPdxi/GzBO/gPg=;
 b=QJVq/kjjK+OUPKe7GzihjkFPGyFTKgxinUsmCZmsGaB20MxtxsV2hE4m/jWycsE/oyYOubw82cYAYb8ulEw2E7LxZFVoMk2uMRjKvDpduIc1kOl1t/kEJew1I5P9e1zKrG0seT7Sfw0X6/3UXBJ2ZsQWklOx8jEdUiWcAHpr4E8dHcVaj2glZ8OqdAqGN3ASVvXCaHcJSMSScLJEzF/OHzwpEpCaXmHw2n8dYhh4V7tXpG4PAbfsmdCUvsSvjvj/+0iAXb5TSOtk8JTZ8SDmRa2fUSGxI5LZ4kxevrJkIGykVp2IfxZoHQOE/03LOe9qoKhhCYpLZZE5QvY3NiNh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZh4xdgKBSbhTNehRMnlHp+j9n75FhPdxi/GzBO/gPg=;
 b=pfRaPYn81DgHjknh7Cii4NJR56LG4wpjKvhQpgy0vdAEXhuF5GWp0DPV3DB3585ODJ+QD8y58FwqoEGsVZgg1ECTpF4Baz5wA2Q0RCk9mw/PghPlGVMs0r/T8EG6ILgkyJkZlsNhUz6WtEuXaMqJPQGDTezPqFY6ndhG9MFGFXR4fLO7bJ0omIy6a0vBRqyTqbBKKwl+6lKuPlk4Z+uzlj7n9eWlTZveaFNAsdGzzO/VIcVgOB8xoUrkKpM4PT6owaaYJRxK93J+HuGuUCXwDNj2gDWaR891ulHbeDZu23KwXA2hYgY9qnssTyYkFuaXpnOKu8ARBG6JRJqijEI/iQ==
Received: from MWHPR17CA0075.namprd17.prod.outlook.com (2603:10b6:300:c2::13)
 by BN6PR12MB1857.namprd12.prod.outlook.com (2603:10b6:404:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 16:41:08 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::5d) by MWHPR17CA0075.outlook.office365.com
 (2603:10b6:300:c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 16:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 16:41:07 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct
 2021 16:41:07 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct
 2021 16:41:06 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 25 Oct 2021 09:41:02 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Mon, 25 Oct 2021 22:10:43 +0530
Message-ID: <1635180046-15276-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff301517-0662-4546-a5e6-08d997d63e8c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1857:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1857E836E8045E5608FB123CC0839@BN6PR12MB1857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsCXSPl6EGDhIQcPDEvIOc0V+Zjs7PYWKip8gQ95QfZIbRzDiL95FjVAPT7Um+08vTFdVUwG0PLpqIyeroebT7W6770lVcdofIxOGiaKDnUUYLLhLZIyRNYBGa/LmPcv/+uuLm2AsckEeuaRF3zJ3rE05GdDfKzlfSCiRGa5sa58Mslh/f6KjzarqnXi1D2xHC9vWoSCAwD++4kfts/K+HhB9BOpIz5GtulBnWgLKipr8pT+sQoLDjUiNFTPW5c6dBWrdIAp7mGhcN+rS5F8LAOsPzEctTeM7lcUr2Ejd6JVOzHUGfQmKIubcXiDRj70WJnB85WwsreONZrVlkchzlYp6SkHugjtojSkj6MihstZ9kv8YMn9Qt+WQ4EVrhqyhyJX7NLXnKFCeTuKnx4utI+DtR9QdTqabOqTvBWeH6AkIAnAQdQSF21m6ofS0gOPQs3rP1IyvuQSSNZz+9/1/myMyBjZexfciPTLpPB5kdsEeaSGga+J9sbqxPd+yviDylv/uKdS6CyLlJ7ILGofH/mYpTcgSC6g8ywZk+BnoTqhJ6v69cqFpym7wazW0yVS+vO9vROnpfio3/nC5ECo9kzOM0NParFISQVAJNKt3i2mtsu7UFfjsMptMD/9/swc2SepxTraS5Y8GO0LKhQ1mHAyJZQc6FtVUwc7r7eeBpxbzOAQonXkYSyjfxo5PpTnvb1Hd34IQWjucgS3AH/AbbdB8sZRf4QfnBxmV/ypJeDIEDMwMEkU8MC3lp2QB1PPQnOyx482AtHnBKfrg//n9dwOFS4sy5Lj0TvIz4/QGnOBBbOx9t5162dkgP5DPuRycgMFTUzKopY4D6Ty0eoKag==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(356005)(2616005)(86362001)(36756003)(336012)(7049001)(316002)(8936002)(7696005)(4326008)(26005)(6666004)(36860700001)(37006003)(186003)(82310400003)(54906003)(966005)(70586007)(47076005)(2906002)(6862004)(8676002)(70206006)(5660300002)(6200100001)(7636003)(508600001)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:41:07.6307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff301517-0662-4546-a5e6-08d997d63e8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1857
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..d3f58d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,108 @@
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
+      - enum:
+        - nvidia,tegra186-gpcdma
+        - nvidia,tegra194-gpcdma
+      - items:
+        - const: nvidia,tegra186-gpcdma
+        - const: nvidia,tegra194-gpcdma
+
+  "#dma-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 32
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/tegra186-mc.h>
+    #include <dt-bindings/reset/tegra186-reset.h>
+
+    gpcdma:dma-controller@2600000 {
+        compatible = "nvidia,tegra186-gpcdma";
+        reg = <0x2600000 0x0>;
+        resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+        reset-names = "gpcdma";
+        interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
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
+                     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+        #dma-cells = <1>;
+        iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+        dma-coherent;
+    };
+...
-- 
2.7.4

