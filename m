Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FBC42272C
	for <lists+dmaengine@lfdr.de>; Tue,  5 Oct 2021 14:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhJEM5p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Oct 2021 08:57:45 -0400
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:47545
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233762AbhJEM5o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 5 Oct 2021 08:57:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+ssmO/31Jk9tvfAmojDkmYHUmTIML2LPNVBJewN4j2JJ01ZxO5Gk3TBqhQYPA+phorlaucnn/jMv4D5VEUtn/Agri+uma0hKmdF8cOL3HTEAeKsObOdZMZdvxOMhqjY/ehiZl3T70NHqh4q5yymYYQeiq7nTpyxcsRrohwFFTrs29A6qpUivkcxM12i3FGKHqvGDWh7jDPWaDIOQApQ21zxRxISfIkW2pLiX8D7YFxK7kpzUSOTo2dUW6NlfH5rGTY678rhNWk05WC5ldE2htZl16I9/ld21jO+9hkWRfDftnNqDSj30UNyGbuHUjuLmQDaj5jbjbzPtgam4OTijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKGOrbMDy8dYK4faDcXhsEuAlbrjPOi+lQPRKPoX3LM=;
 b=bo5DtK+9FROqL8ZRtRNt0XHEnpNPGYaFu1CGY8C0JODmjIMwHwJEsmAoYdwV1z5SqD00/OytkBbPM6aTdaLEuCNXToJgDlGZO6DcMH7JaX4UiH9oLURrBz/tUQ4Iw5qbDnxsv98ElYzJalvhTIMOi/ijtY3rOnj5euux5kovobyg16DqTQqcSMQ/T303V+0UQ/UScofrT+ePMjqg7hPg3SLIxsFGqMyzFm/Mfc2XcvXkYqBNq8LC8B1n+e3aIH9odB2/N7gbYkUkuf/iD0A99jBZ6c5HQL20GnwBwbazSWgs+NdLlC3IwZs/dvTYppDU0WqDvLVpUl+3fOm4CLddJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKGOrbMDy8dYK4faDcXhsEuAlbrjPOi+lQPRKPoX3LM=;
 b=XC9Yc8Uy+DlVZjsHwq1nPXS2AQfX6rkEgUltrTD5ThfGRKhSzm/czHUO/M/NxTSMBpqP/NJg9qvDTqro9rc+b4zlA7DiR5edPgB1ohxfWpYj9AykusR1VlZNVkVo4ow3lgAVSLeJvoViClycTfGB2Y0S7lypwi0OmNXpgi++QsHj3Rb1Nh8X3cJlKRzf6aNdtDbaMJW78Ip96SRGt0Xk+tAkGG2RNeEkvbNgK6/TvnQkcYGyWeV6rhz3Lz+Knwi89c71PGW9P7So1Lnl+att5+l46qteqqaXs25BCwiZ/+IqaodIo7iElL37ND1PuNTd9OwgZUMHflMDuocgvcJ/sA==
Received: from DS7PR03CA0350.namprd03.prod.outlook.com (2603:10b6:8:55::27) by
 CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Tue, 5 Oct 2021 12:55:52 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::3e) by DS7PR03CA0350.outlook.office365.com
 (2603:10b6:8:55::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 12:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 12:55:52 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 12:55:50 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 12:55:50 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 5 Oct 2021 12:55:47 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <jonathanh@nvidia.com>
CC:     <akhilrajeev@nvidia.com>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v9 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Tue, 5 Oct 2021 18:25:33 +0530
Message-ID: <1633438536-11399-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633438536-11399-1-git-send-email-akhilrajeev@nvidia.com>
References: <1633438536-11399-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb3ad990-75cc-4cbc-0d56-08d987ff76b9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5137:
X-Microsoft-Antispam-PRVS: <CH0PR12MB51374751070A4B6FEC0CDE12C0AF9@CH0PR12MB5137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUDhu3jZuxOumx2daVLlK8EAjIF9E9xd7/sU3NrgKU9UUMjKV0lIn6EfqKC7b/QSYWardI3FHgSRXoyZDuVAG3rVPE7qahsAeEwordSyADIjqHiWrzVoXpdrfU4UX7jM4jfitLyFZxinwjfwJDulj5V60bshLUbypa0fT3MJeKEFg/fF9/zVA2aTENkFbWnE6ud90ob6G/PDH2LrkF47gUlNjG59yIUUUaTVcDm6j99rFFNAhMY/YPqcCLnZJKFIs/gtTGLUWk76oHJy4AiQNqpVVqkAAiciJv7lAC94OgcZQ8lewYyG4URyVSckoykRVUGRdWFeAvYcDSLAWYcmumELJEOBfXMBR+3jCEQDcWlOYd/vq35xySohrIu6kmdwXoKwt4pEY0NTHuGSK3tqae1WxohHC8DXAGbwvJY5k5KqpGjHvJljYKSrhshg6LbmyaZFsWrV0fsrduQ5wS6GYlLrcXChX5MI2jnSTsM8F0/ZGJIYYIgYM8THSnHnsPWqS8rELkbA3zZ26CBlhlwtbkni79sz5qShZqNuZCgwQz7k+ZUXMgVrWw537vG81HuaXYzF2kjHEaeluhHMnGtzgeso66dPr+fG8WxMjFsdGRPeexNoYpoaY9tGxPy79XbqzEZXjFCMkDLAuF4/miS8nhhGW+umqzEVmx2INNb8MSqU1PRHPStlbe0nS3hzwyFz2wQ8BotIJqMyeYNZgdY0tXNWzOYV6S/oWvYE/PnZxiztNaw9Z8XyVNCp9viGaoHMFS6K8mmcAxund+6Aqw05BfjnCaq/bD5iQw+eKTFwRoxYJ6RSM0urpHPui8nB4KFQC7wLOD6N17D4YS2YqVQEKA==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(336012)(36756003)(186003)(7636003)(26005)(6636002)(2906002)(356005)(7696005)(70206006)(6666004)(70586007)(966005)(508600001)(2616005)(426003)(37006003)(8936002)(4326008)(36860700001)(82310400003)(36906005)(316002)(6862004)(54906003)(47076005)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 12:55:52.6792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3ad990-75cc-4cbc-0d56-08d987ff76b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for NVIDIA Tegra GPCDMA controller.

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

