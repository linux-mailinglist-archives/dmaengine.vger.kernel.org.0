Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF44A5FFC
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 16:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiBAP1T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 10:27:19 -0500
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:28640
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240245AbiBAP1T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 10:27:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMcLkjUkyFKFcb78nr3lOlrce4mpFtZhfGb6Kl95kxxMf0j6Pl0ACaL4UiSmUqsqyFdN+8ZfxVhz9MWasCqMsCgqpmS+zXYCuAt10d3fjBp0R5Y7dqbH2Xivu03W0X6HVJrzj+oS3GUFT+TTJ901mKYbg8P5jvYvZv2sn7+i6fGK1guZRQ74Pn3CM1CSnrn39d4NKytp9WZoHGUpj7lLWAbhV134oWOQtM3sYMnycUzqa6zy/DMS1hOI6fdX+XKvLTlh9XgyeYHBqwlWw76cSo+hYSnrD38f/JQCgRQ1CE/ulfzx2DCfAd3i5zbjc8vYjFb4Ail214RDY4X0eMZk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=dw1gmzxe4euorwq6CANnTGothvWNCbNHWoaJl15OvDgmskQ4X+Arv9NRNYrU+SE63FVuiRaiF/UbpzsL48ShibIyJVybF/D6ni4ayc4i0QQ+oo6yybkaIGLUQyTWCnYoqZImBAAUxceRRfwCM0KDHAte/faRmixUJjOEQJDW3zbYIGpum16zYQvgtquhDpKzF/PwGKT40ctu4W6cqaAxV+PcISp4Nqen9TDMCwPBw2mANDGtbtKwoMxY2DFwv/uxbdUIHTXtXpFq1CkNIrAzzE+AGSZj1QzXFHOgSWE6mvhrRzFwDoz84fT3+4S1yuYL/LpSxMaGcZGwWQQ3Sik5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=lfmO6mzue2+1Fwvhj6/UDeF0BAPfqFs9FmdegMXBLrRFYqLcTYQq7l/35f2e9bcxz4KCKhpA5ms7Ppz1TfkVLvgryisvkJcpAh+YQLEoKLx+r+dOs5nwZOPT9G3hHBeiHiZWMGId+wIDT9GKIc8vZX8RFapi4TUDzz684+mo4q1O7QjE981ruvc6MsIGHS1FyCaOCyxSydSZZf3HTHltQqlTc3CHmCaacCawoMf10k/rfkGJZnuQojo+ZomTCnbtG1bRh62DhtOOkuZ3rtrHsyMgLGjzrmeQMHZhOW2LDs0TGRKxd/VJSzAdaoV/y32g+OTCileWdtFHnLW23wvzZg==
Received: from DM3PR12CA0117.namprd12.prod.outlook.com (2603:10b6:0:51::13) by
 CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.11; Tue, 1 Feb 2022 15:27:17 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::30) by DM3PR12CA0117.outlook.office365.com
 (2603:10b6:0:51::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 15:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 15:27:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 15:27:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 07:27:14 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 07:27:10 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v18 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Tue, 1 Feb 2022 20:56:36 +0530
Message-ID: <1643729199-19161-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
References: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074104c7-cd6f-4429-7423-08d9e597548f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5172:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51721E3495046F75A406446DC0269@CH0PR12MB5172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dg0PLnh7gqcsrmFwyZBy5GN9Hb64C3qodiKVpYANUEP7V0Sk4Xezp2zDALZudgXSzEDdh8R1+LR3DvQNzWsqUts/9B4dyxhINnxlhc+wfwL8tkRSK4TZJfLk4EBocaGOkRLKx2vIcxbBPq6MDiz9Q5QHFvCNoGWoxC/add8/6qW9ACe4j6RuxJV8cMqkezBik3F/kCpiWsLCl73soAWptXx+TnRdsEbHAWyzndSvmexJYBhlKtkoHwLhSqNzp62Tv9OVgr2Bj3XBvTPsY3D2MSFupyMPBYDK+cyNidqiOghuVipcbwvnyDDzyHB8s2nysLC6dpndA0qO+EN/6VN5/yYovtzqoQdegq117Gkm8cnxvDysqpYiM9Iw0YX+GJYTFzGhSKDmaRm7HYEiMt6kKTs85Q7753vUmLx8fFdBKJTYkmlw5ewjq9jgkWjVh7mYo3oDKmpHfRDYQSJcZu4IPtZ9fDP1LH//9Gg9FyJ6/uSeq5Rmxq6ZUTC7RuOVXFsPUZaV5FUgbwpRpc7m3MG7prkFBJopo4MfcEY0UTxRac/ZMgPr3RlISM4bwQ3+iZ0X4sNH52aj+TrOAWgiQZEm46Mu/oUKf/4rJL0FngKlaqFVat3jW5q4wr03r3rLMJDeSGmpt2LjwQxSSksP0nSEgEvqEgOwTrjRYrhphcYZvMlBg7y+YH/HM4OzT4Iv/pW0wDqGPJ3Ym+A/V1cNReAWEO7Xr80yvnYej1KCTp09flHhFTxBYZ277FDx7XqzfaY57NcKoQ3hOqH87OD/YTEATf2uhVeA/x0/wpj48Jt3IUDCrUu1NMipAsD+nEkXsHVZWlWFgkEY5lrqvl4LaR47GL7M7HEb2ZkPHO2pRgm2pttkJgqp/bMcBZKwrtcYRHC656egmOOg0svkKRo4rbwuw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(81166007)(921005)(356005)(36756003)(2616005)(47076005)(426003)(336012)(2906002)(5660300002)(40460700003)(107886003)(70206006)(4326008)(70586007)(8676002)(8936002)(6666004)(7696005)(36860700001)(508600001)(966005)(110136005)(83380400001)(82310400004)(26005)(186003)(316002)(2101003)(83996005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 15:27:16.9739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074104c7-cd6f-4429-7423-08d9e597548f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
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

