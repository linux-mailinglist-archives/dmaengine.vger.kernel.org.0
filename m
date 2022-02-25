Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3589F4C45FA
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiBYNWS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 08:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiBYNWQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 08:22:16 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7685FF15;
        Fri, 25 Feb 2022 05:21:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOGWBSent5NQhvFacdIQlmgkfIzuLRBmHalKRNYL9yNUZJA3NqAMGkLH4+YXfDI5R36B+CVjSCX03FePp7ZZ/vwc5wu50AzZ3niboWcNbPxf13enJVKIMWZO3sprnr8ROxaSW3aF76lvU30ApAy1f0jq1Wvhk+tSSU65nx+gW8FdJHBGdQuD+P2/nPWaWI+Ig3c8tXvLxz8xUoNxG61rEAxQjqDFU0wKcN9axrNl6KwJX90KkwL2QRIPW3Q4AENBkvNOkprhYK16KBi69ZdSw8TX3FPwsaLKqFZJbCaDuSt+vkf91vVD/PW0GhjN9fbM7uDbLljugZFmdCY4ewGUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZxCPO00v7/Y/9/aDPY+Dgxy/fpyOXvjoxuP9Ogann0=;
 b=VSS5YbAFav+iwWIgfA3aySI7tKzN5SUSjXxX+dl97yeDVuIzj8lhpMa8P5/YcSGUOt38uPqcDdGLwlqarlx/uMxU3VflwxP5cz2Qz6cvDNCx5W0iAmYKaYV1uoFqIH2g//c2SlpPTQkluZ7EYwp10SmcooDJztbPUyflpZCTSyxD7vm41Km9T6/g/XdI+ZNDD8EQ1x5r9d9buzswbgBrhj3CzuSKDWpjpHKyrMvaKUYivYom8vbx0mTrajTL5T6BXw976WKZ8YwOyPPxcVQbpgyiRDJw/opbUtI69gWwmzhkaK9miyyCSSz8Lt01bmSGri+sapFHqqhXMWWzTM1XyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZxCPO00v7/Y/9/aDPY+Dgxy/fpyOXvjoxuP9Ogann0=;
 b=ZMfhYByE/zPk+Hrq7aXtUuQatxb9SktxCsuYRZKW0lK0haMps5ezOTV3aV6wFHWnb9OlvEup647QaDoVyWkyGMNjREBND4LsgEYIu63JmmuMUqSq+C1uZOzWDSwyp5lGc7QotiGF3e5Qr8oDCGLkEhuh0yBo0Xt5UNry1ei4df59uxlCxInCzbtqQQeGmEWIKR6QyLmFa/paqPSDxslmfZC35yNoC829NLnC0LSxIhbGLCCQCka2hSHgkeSdAwyqLyVXJoskFPhdnkK6f1FBOy5YDB/bJucZGoyWnzgiC/sEroJ1p8XXy6vn6cpRa86cm0OpWOUv9irIX7afSfCeTQ==
Received: from DM5PR15CA0033.namprd15.prod.outlook.com (2603:10b6:4:4b::19) by
 BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 13:21:41 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::85) by DM5PR15CA0033.outlook.office365.com
 (2603:10b6:4:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.16 via Frontend
 Transport; Fri, 25 Feb 2022 13:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 13:21:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 25 Feb
 2022 13:21:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 25 Feb 2022
 05:21:38 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 25 Feb 2022 05:21:35 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v22 1/2] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Fri, 25 Feb 2022 18:50:43 +0530
Message-ID: <20220225132044.14478-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225132044.14478-1-akhilrajeev@nvidia.com>
References: <20220225132044.14478-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d762d2b-3bfa-42ab-5725-08d9f861c2cc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4886:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB48865578DF739DBBAADAC3C4C03E9@BY5PR12MB4886.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qcf6R/2LUm20YHU44Iiz3rQYF0ajNwoaAp9dW1W8eFKszC99yC7i8HB1Cbdd8E+yizm8TZ8PO+I6SUb5wI4Lg5XY8YmAmJ4JUT/bzX2AZpIiCbSBmbTx+FDXgo7F0d0e+Xd9DsFkfumqROfqrhmNtw2UkCKrAUHBdt0BHI/Vi7RpaX5F9saqY8xhnsNEJ1xkNTZ7PgL8Ia8HqryRIxaXbj45xe33iVmzwajXbJyhukhKvQ5RcX6X1AyeYk9EG6ph3jl7PbWYZO47BzRyYBr5/8PTSvCLB4HBx5tmWZXs/RrCuKaTG6f2iWuL0PvZU9O9VqAoLeD1E9B4PEFZl/urNxJWsq8kjsv2T9z/qESeCUaEqe/boQGSe/frcnWTU52HLzJ11T4pFigFbZtWzFEx1CvEyqTFqqZObcSWjZNZfmQ1vJalkAHOAcwfd6qhP7+k9ObwmTFxbS9hABu6foYRX3pDgwCfLXplIPbeTx+MRz48rDto981PByoR+dA2XiTjE2GvfSF37UZDYPb3hZTGM9G916EXQP3un5TQ0Zpvk0sMJksPf+q/EqPo/bZY862FaPPOG2o+M7j01A7K1nOs/A5515M7NE8YWHXSfkrAAX5FNwcaUdcHNnWuljg3q2TQI68oJZFnHFf3dLNObJ3iVfJfG1NZkBYg5q4gzfu79dWJpmyfnAq/5yjCq9h5s7K7quXUnE9LtWvE5CHFZXnipqJncKIXrZd7mj5MxavvSGtayrtJbgwFNHhWteZ3OcpzVThHHiTAK8N6F3QBR5M4j1DYEMuT0EskKYMq/TWIJiZy8ga/Oa26/wtzFteLn6KaKcMwxj9HPGwiKcaTqNgyTHJGUd4kPlnZmTECiGIeCzfC8c5qao+oD8UX0MEhF/Q+ItWeM0PLcHekKi636pI11Q==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(70206006)(70586007)(82310400004)(107886003)(26005)(5660300002)(8676002)(8936002)(966005)(316002)(36860700001)(110136005)(426003)(83380400001)(47076005)(81166007)(356005)(921005)(40460700003)(7696005)(2906002)(6666004)(2616005)(508600001)(336012)(36756003)(86362001)(1076003)(186003)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:21:41.1448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d762d2b-3bfa-42ab-5725-08d9f861c2cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
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
Acked-by: Thierry Reding <treding@nvidia.com>

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

