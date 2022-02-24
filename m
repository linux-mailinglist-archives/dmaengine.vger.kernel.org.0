Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE74C2BEE
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 13:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiBXMke (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 07:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiBXMkb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 07:40:31 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3F2804DB;
        Thu, 24 Feb 2022 04:40:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7kOTCboysv3cuFaDHqR4tCyuD4M2Q6XVMmU2riOJxtupnWWLMgr+7Lwv9Pz+j6dgic5SdnMwI3llu4h1eZ/StlcK75oEK4ZXEaLhX5nxD2qy/o4IDKE730SJOw+b/bseHTOlT2C0uk6o9WwrVPFsn9WkQA9H51Jr8JEh7j8Xip2HZBmYXpxtH3THfPmNSnvZjPgnGyIkrD++H4f7ugEdqEgBxvgS5wb5kJ7V9m3PabJgK8h5fCtPaKmXeGnQ9qnEUh0RIJ0TDMRXfgJRqnEwzcYk7aWMD2b53m3u01llhtTf7gDvKhhQYCX72OCgJJdn1F1TP+QLhBYK9DUIAUM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npA9vSPSem5P5nizpnXMtZ2ZdgMqLH6iW8PwR5WwuOY=;
 b=J0hOe3JvX4XwJpm7jH41tjm/z9cFml8coSkg5bCXm3jLTh+yWCVWLTGQnBvG5GoToKbxjcZej+HyZTz6jOvsY9nWuPHTegW85qlubJBXM1ay4SldRyNFMZdRAwDCXVH6PfGL4Xl15EVejYlYS0rgQTq2DAtCpVSf7Zrz6SgiEurbOBFpUgOblBKT/B2OD9Tx1NkjxBMc3a9yuQzcYiuCXywdYWKf5p61FX4QEan0kldqbbI67A3b4GWNPPsD6Su89EEeqTmp0Aof4OQvmC14nLBrRGOPx2vGXG2cxBbcTod6Kl4WtIWJCGbDlkSh/qPEI8P2L+7xUqjl1s2trq8FhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npA9vSPSem5P5nizpnXMtZ2ZdgMqLH6iW8PwR5WwuOY=;
 b=sJSOc5TCTpsiTfyCt0H+AXpAt2iTgV//JxQe94ueOdjTlIo/3QmEkBZT44/gnlf8+EgJy6q4E4MZhmkMVYh2ef/bKAR4o7DeCXvBJrCTWqGBOteWHYQqCd74zjP/cbWAs3NwSdgBWonpa9R478bIb6f+C1J16Gg5Sq9Xy9hxEHZXPLhGGaK1ek95xU9yQXVRqYT/UxnWdXrNA7ep8SWStGuYtp831kV7EWiXfqCo6DL9vm1cMNYpj9xfGXesYGKAdj87FYZ01wywYO+Nt6LNzrJYUneQyJ15Hi/05K6ApaJbF/4cs+Masw7z5jHmkcnVEhweZzPwX/1CsMOoObRRvQ==
Received: from CO2PR04CA0160.namprd04.prod.outlook.com (2603:10b6:104:4::14)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 12:39:59 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::f8) by CO2PR04CA0160.outlook.office365.com
 (2603:10b6:104:4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 12:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 12:39:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 24 Feb
 2022 12:39:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 24 Feb 2022
 04:39:43 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 24 Feb 2022 04:39:39 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v21 1/2] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Thu, 24 Feb 2022 18:09:02 +0530
Message-ID: <20220224123903.5020-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224123903.5020-1-akhilrajeev@nvidia.com>
References: <20220224123903.5020-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3059f34c-e9ed-4e94-b713-08d9f792c4d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4303:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB430301536889E45CE8124E88C03D9@MN2PR12MB4303.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ha8ryEibVFKZ+2/DFNKDGmghbJ1IaUgUkj9VCRMA5WDfXz9D4rUDhxmkiSc0mn1MnRWv6jwnMgG5FuPEULI7W7ymgxJOIq4LUswMSHOvR6+eZ717fR/S3X+WlBKR/dsKeFwVpY+i3fsFu3Qr4BicWMuCToVVFOHfWGccl4x9ZBBdDawRdKmJ6DjkHJ2sOZwYqfHuJ3YgvfiF8T/ELBRpDE7CyeKfDH1X2nzBwS3vh/zzr5qFIhE/sK1i/A5eVsE+hCXHJVEgIebiE199EKMh77HlGdTZoSF3NSKbFEw/G+Tz0FhrRJZceFuEMGOxc3ctKvQ+4IHPAXuoVFCJ+MJ/lf+hRY+uPwFQPVsMBsYkvKIbwal1l6+4Reca2TM7DFiw+VmoCRTRzosz1heSDyKdHwu+oDbqymGIYK1aI/j8po81/Avat3Biyd0kSmzpI3eVdbogr6UsgCBy7xAfQVSURhkdCc+pdiwhRa/A6aTYxyE2vvUoYp6ZP/TDFjiWc5UHx/Ev8jP3wS5V7u2HEM01dCa4KMi69TLBZq0clnPwypd8eBPNjHe5uXRgS9iHCbtNb5zX505Vqpz7QQqT1pcYEX3eFN/rjqEIcmd2yA/JkWBejHu0ahou5+FVP5OoRGxrDjFu9tFnhWUkcGK4sV/vMMCU/PrMonuNVOE/+88aRTyOErcLdVIZePMF2Uh9s3cWPTIc+g1pRY06IAJNG4sjV5V+TawByRkxO/yJhPKAlI6oKxXrlTOJGAmIMUW3lndUSf0055zs9BT/JcQoY1iO6dfES09SWJRqZYeGfsalgAFhHOleQ0r7XNwWNxqQL69Zy15gPCwcNun5E2cfStCJe6Li4IalYgJUUC1YHgQnr+XjOmHVGz5lGlmd1RAtxpr6/RF+OuIwnxZpPyRjAJh/w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(966005)(8936002)(110136005)(26005)(40460700003)(1076003)(2616005)(107886003)(86362001)(2906002)(426003)(336012)(36860700001)(5660300002)(36756003)(7696005)(508600001)(6666004)(316002)(82310400004)(47076005)(186003)(81166007)(921005)(356005)(4326008)(8676002)(83380400001)(70586007)(70206006)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 12:39:58.8299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3059f34c-e9ed-4e94-b713-08d9f792c4d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 000000000000..9dd1476d1849
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
2.17.1

