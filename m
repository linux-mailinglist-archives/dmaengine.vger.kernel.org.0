Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F99458B66
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 10:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhKVJba (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 04:31:30 -0500
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:38862
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229806AbhKVJba (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 04:31:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rydcfnkmx98XaLiWRkpHTSC3cvILwceNW6ya/KHGrQnPQOfeWOeJP0U836nqKRAy9H2LGC59n0/fCjzQ5Ksk7upzPEWdkFE6VuFWydCuUGaSU4/1mWphQWWSk5KA6GlNYbJfVfSo3pd19+yRfxI781jJAq/ui8JbeRNafXagY7puDah95/4+A1PNZScqIErT6Puui5Yk8EcYSZCsOiAkNhuuEFRivPniD84mk/LZyaSBsGWnYeuHvBW1UQG3F8yOhEtN+VYEH2ayyTZ6SHOoW/mnxoO2S/FUbd74vOKgTrGfU6iIhczZNLcic5VfSjWOV7JXVU4pe5tI4NduWfMXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lj8V2xEI1eDwR5GNe8qJQMYg9V7WeZ5oJ4V/joQw6Q=;
 b=cpFlzsOJs5cpTWtF7zqjUQPXo2b0rn5VXlAAIek8Sw6NVUNGbTY2YX5COXFhd6ENXP/fIaecjJ9pDizhjxYmM3u1CWC5wAeygTWN/eGMWJ6Fm9VY8xc+S2r+CF3AXEWtB4BxaYPnUE1Qs2sScurAc1h7UBxeuZPcj5ZG6OPwrs/prL8CxmgslKBggCCKYVznfsGusDBK6Be2Tymssn/yGYNPzoNVgf30AJQHAB7SA7q1k8fQpo2gZnMngWMQe8v7UJSAg+2KAWYi62hvuQMmdpPpLm3DwhRSGw0wn6oyAKR9oTJgy/2LAP3J2m03m+hS7LNEHan+UdFJaZKLvoJcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lj8V2xEI1eDwR5GNe8qJQMYg9V7WeZ5oJ4V/joQw6Q=;
 b=qX47lAqxizroLWWGK2POwSc1TleL9OvswddlhIWaCsZWj2Hahj2lQL1+n7zpNbD0TZik8X9nySi7bA76JFNnLz29w4Ey3ZWUGq2sxL72X6JqLjrqJeE+f4NYsVA+h0oWTvbMBHOu7tSHp9wu2vg4jM82GMz8pUi/cPaUqqHoXMST9ZDPFkjuSBvOqAco5y7ZebaOq9QZgWFJWuSuT0OXbSA1AzsoKb7YFFZvDAJ/FOgxOFun1FZQ3u63SognD38A9NdxumiOfVdNKLEvruAWWq2OqQ5e3vdENQXkNcB+mj34pidrNzCqz1x8ykdncLKDbk3ni68FJLE+q70n1lflYg==
Received: from MW4PR04CA0197.namprd04.prod.outlook.com (2603:10b6:303:86::22)
 by DM6PR12MB3323.namprd12.prod.outlook.com (2603:10b6:5:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 09:28:22 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::80) by MW4PR04CA0197.outlook.office365.com
 (2603:10b6:303:86::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 09:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 09:28:21 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 22 Nov
 2021 09:28:20 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 22 Nov
 2021 09:28:20 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 22 Nov 2021 01:28:16 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v13 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Mon, 22 Nov 2021 14:58:09 +0530
Message-ID: <1637573292-13214-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com>
References: <1637573292-13214-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76d8724c-d2aa-404a-b5dc-08d9ad9a6d09
X-MS-TrafficTypeDiagnostic: DM6PR12MB3323:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33230302CAF3BD7D3B92215CC09F9@DM6PR12MB3323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLVZqal3EbRhknqZsd5bDSv3DGbn8K44oMYWMBR8VvE0Ee5oYq2sU9MnPPlf996gDvsXS8Ib6OKNoVthgH8PCvmWIMUwyyIZ8kMKAhWiAdODqsFmWDS/4HJ5tDsYi/UkRRm9cV/PS4hSNCdgngwyhloth4SVzpXxGwbGE0I6gbwED9dPceMG925kAOCZ6vmcNgZDM+98tb6OuRJqbojoLP78g4mB2Fk9AR5j0a7eto4a1eeKmY3fCif2Hwopc1F2YrODGx6h5nSEEk1QjqaHZySaXoVvhClE2yudMnQAiF7MPEB+P3bCC1hGXhJjb4CZn8JL6Xb0565TdLtpreq2Dtx5BQHFu5zek02wif4qDWxFM3rWi0Pq3rvgVAqBOteEHpaY0sYrbg3naO1e2W6R+0D+R2h9gjs139vnOdOL2ayAXmAmz1S11yC8wt2nb9+6xJd4xQf/MxM0evsgcsYRyiIBcxEerHnoH1EIHuum48NYIDfgRf17CxQk451XKbQZbA/sqrtlij7NLgYfYsL5PR/q98APU/H3pH9SMkpkCtL6QS4FAjiH7qnOSdw41MX/+IHnoRP8sx4NEH3idDRNOUUnC4oZeYGZaRSLyV605Hok7YJRs2tYgmAkjlRdRawMU0NDzZ8xRkQSEUxFItovN3MEOe0yExIUPo/NTIdRyuFNdhESFfJMjRiW8Dt9ayg/iu+MlPgtOqE2MyeeGimkl1X0auQK+EUNtsGnzCGBSOESWyeai4m0Ec5nqjy6/RLSr1nUPQM7IZ7lk+me0Yf3xqExyw3KF45Hnhgov8MS5SHEJvn0+53lQM0896LTDxBps9kpF3jUNpVfzm/72XZsNc2Ys5SCyfvol7TsowJO2oYXUBb0DT7tZdduFw0/HkycXBwcOy4EIZy0cyVCDxFuAA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(36906005)(36860700001)(5660300002)(36756003)(336012)(26005)(110136005)(4326008)(8936002)(8676002)(186003)(6666004)(2616005)(966005)(70206006)(356005)(426003)(7636003)(47076005)(82310400003)(921005)(70586007)(107886003)(7696005)(508600001)(86362001)(2906002)(83380400001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 09:28:21.4568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d8724c-d2aa-404a-b5dc-08d9ad9a6d09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..3a5a70d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,111 @@
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
+         - const: nvidia,tegra186-gpcdma
+         - const: nvidia,tegra194-gpcdma
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

