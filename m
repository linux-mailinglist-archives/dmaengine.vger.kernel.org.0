Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8E4A30B4
	for <lists+dmaengine@lfdr.de>; Sat, 29 Jan 2022 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352745AbiA2QmF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Jan 2022 11:42:05 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:5472
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243121AbiA2QmF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 29 Jan 2022 11:42:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrTDnp7nVC/lrAkNyIGi84xx6WSSdUf901Z5gCMiv0ePQRTbahL3rAmeQixdHwk6OLWxHn1PCa07XoADnYueG9fevZa3PkUmIaWnYV03pYykvPOwjrF3znOh0UAtBhgi+QxsU3lEIiXF4mQEu/ahD8TK+IwCR07d4UAvx2qCobMOe+dj0+GECM++oZydH2l4cWZML3A06u4TSz/+gOm/w6FCZ1VrxU/dtCYPpMO6cGVRBJJ71ji2yeGHeTM5THye4sy50+D7ma3Lk7yyYj/CMZj/lf0U5wWf0E29FlaPR4LMHgZ5sYcjFRifYZD86rsB45OhqXHqbHQjrxX2VGWYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=Qa1FCBA9kTj8+MAfEMC6U+bclKYdsxHxtGXy0VQj/eUPBsMm4cS9VlP2enRbTOtx3qTAAl9YO+AUcrgkNOmR7NdN6a05N/Rl5rHmpSEEj9VZgnvay4SLQrdbUGX4nizMXHZmHTOZNRXLe6E8pGfVZnBzcGxuMpxeHZ2AUkdeO6iCq8yYmWsPyx2YkENqdIEokeuIUtt4fI/3izgBQ8Tjb1q5BSyMxlC/1fqK8DRH2/VbE2AdSQ0xChqVt0ifWdmoMXsXfSstPK4+xou49fTEulj0noQ3hjJh+uoYku+CaGJ6q31REgVJa0b5iPK4MRHeaHo4zzS7q1mw+RtGGDIaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=nbpcw71AT8W4LcH7dsxPos+bBKrVGlUp2qK/MlqrObk9bvg8l2JmT/LJztTRysqIgC9k61g8rPQ/VCm12fXYr0gTiQ/VVGYA+NGSJl4iIvlmiEI8MS8dlZYn021c6tdIp3ldzkmO5QuVrX0FIg59DcCd7VLMlCh2N4VBEcrc1p2G4+OTuYADSMedPmAzjI5eajKNGYQ3BBoh5eyuAi42uZIgnfJ7Kcgs08AGUKP6qvFnv973hZD+YDszqcwJQ/F8omAS5ExckHwqNtn0w5onN0ZcI3DAUlM1cjXk4FS+q273BF6pSass4y60c0ssAOLYNyBflK8WAvlhh2uVQzQYjw==
Received: from DM5PR08CA0050.namprd08.prod.outlook.com (2603:10b6:4:60::39) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Sat, 29 Jan 2022 16:42:03 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::67) by DM5PR08CA0050.outlook.office365.com
 (2603:10b6:4:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Sat, 29 Jan 2022 16:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Sat, 29 Jan 2022 16:42:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sat, 29 Jan 2022 16:42:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sat, 29 Jan 2022 08:42:01 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 29 Jan 2022 08:41:57 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v17 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Sat, 29 Jan 2022 22:10:50 +0530
Message-ID: <1643474453-32619-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f631388c-8528-4822-64d2-08d9e346473c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB23606AE714A82180035FBCE2C0239@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGJ/hfNf3NdKe2qbRfhWPrJMWYfpA304iGn00KNd2sKgG+tqAv+sgraREK03f0rlCVVN4x+OK2JVUPrGRPQLrrdnby79Fn8nvZeii18XGGY26oLMb9OkoCkMaqYv1zjtnis/oNZzN+jMqYZ0hNgFGjsUkRJh4PkKveeEdP45a5l2WB4NGcKAfpkCpdQ45pDtV4p9By1i/1g8UY3aTHUwduT2bnO5Kx9bV+Lc6uxlkbt7gxNN8z+X2Pc0lPruMFRSAxtiSNnRJlKNKH3wtgSCUK2H9sI95xJMZduSSvCVfSB0w+9g4/yuTiClKzl53mA87Bic/WSRttewBUuhzZ/qbW9wmKynLhKLdMJkzaGcseAXKaZDMZMXO8QrhfBbs1bJw3Wd8Q8BpYwLUH3sqGrHXcTgL8MCEuSZkIVJ8O59zJ/Lryz8YBEfJB2NON3Vb+0XPou6Il5Jq0vBXgSFWfwcMNNNZlxUOg/NQXP6Vi7VwJwYZgExn/FrngM6Mjd6bCpIR59rRjORbon9RGkst03r9Vliv7effHtE1+lAa/TN0PddaS4BjX9RzLMecMkaKcnDsWI5m9BktPpHKPP72D5jd9Esc3FPDTCuaMuGp54+c4eCxcINjhq1GNJbZjSSt0e6BLY5rnbyThz0wUq4rvNBukaaLzAwihUw772kNW6WBIQhblmvVFsehM1JW8Vmwt77lWBMGFxFa5FYGDDQpoNfFxXfMmmqWqd9psBkmmeWo0JP8ms+UjIS9Xg+0xnnfGmB412gn0mhcCinYCttJ57WUODiUDFSRJuj33CxK5YYa9wsivJKmnmC9wQR2289HzKp1P9eC7vrd9Qvufaz5tV62xaowO1AM7mc+BrqC7OeOWzL0i/iwHth0OWJoWlF1c1ohb4B08T7kM2m7e+Cjw/upg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(81166007)(2616005)(36756003)(26005)(7696005)(2906002)(40460700003)(107886003)(921005)(36860700001)(356005)(5660300002)(4326008)(6666004)(47076005)(336012)(8936002)(426003)(508600001)(70206006)(82310400004)(110136005)(316002)(70586007)(8676002)(966005)(83380400001)(86362001)(2101003)(83996005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 16:42:03.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f631388c-8528-4822-64d2-08d9e346473c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

