Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA794AC312
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 16:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbiBGPYO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 10:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345227AbiBGPCn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 10:02:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C5C0401C2;
        Mon,  7 Feb 2022 07:02:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQXuzhKMrvZHSsXxpXmwUdmbnqq6TJXMVjgmRT1v5EA4WGe+lPStCup2KBYefJ/3Ou4rjrD2sNVl1PipokWKqOFxWLvo14FwnDq+Ms3KCmPzC3OB8y1dfboCUUnnPu1Aj6MZhX8vIUjMmf39KuJIULuq6ni1i5Ww1fDckRX72csLNDWKqqzfQuY7cKui8W81GhiV6vk3QcAv6KdCMogkYAuA3Zkt94qfLxFfYKhaEWwfsCVuuLcOIW7EvApLD5pib2H5p1YDD5lfMvBPWw/Z+sDp1Xc+1CiiLlsXMApy5WiT6nfAC6ENa+Tewfdo5ZMNhJPxG3fveyMZBawf06aOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=RzcPTUpI+JW95vuy7P2tqsUc1zuTGmzfwDeO6MjKdYWykRxtW5PTbXJzoJSqYg1wbYv+p16ANTZwRapAlJ1lMphcHq3UWBhOMBYA4VcBjK1G/eDmmbWvgRebaNQ4MRy67JNAJzIssXMN8/0EwUqOHTDHtJEXdv4Zw5D2ek9lRJ+Faj6TauBlrM47e1JJNQuuWxTcL5/Moem1lulL/7urvKXtsoFGQHDAMHY4GgU3/g7qLjMhgg96EDkPdKGJvzuQ16O5CBFI7u3ZFSPFFlod2Ajngxg5JXSuXxNSzyHCP6gJhGOUcM/p9xRVRqGcVdLvGtFhFKx6MGDeAjOYwGQAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WndexYVCK98d38b2fVEzcBXyUysSWHywX1VgnTCHrA=;
 b=p9RB7PCe+jvReXpZteUmMixmTNJrETcTHzh7l8aVNMMHc4sIez0emNIFw1+LOcpC/FtPeaY1HaWKzM7TjWmrXuoXzYX+xDUmbF5lxkxKCGJgNwBEw/4H7qP6CAQDz6w0R854VlfMwnhwytxLNaXBVgqjE2yYWse/MlyZbixj2wmCBeHu4E+lMUhmKRUDGKWgFrPaE7Y5D0X4lXE44Sl/GBGBhx9hNxR8skW7GewvZyLPwJDnNcGH2VgkANnLi8P5JX90grC9AyOZXKlGZ4w7RNkKr5qEl4Z0qe2tmCuIObRo1SBaqoWCXAFatAjvNA+B639YiidG/fEWXq92N6wyfg==
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:02:36 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::52) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 15:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 15:02:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 15:02:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Feb 2022
 07:02:33 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Feb 2022 07:02:29 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v19 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Mon, 7 Feb 2022 20:31:31 +0530
Message-ID: <1644246094-29423-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
References: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2416ac9a-da18-4ede-d13c-08d9ea4ae003
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4289EEBC6ACB413FCA714EA4C02C9@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDmqMV15gB6UAmFso7o7vp55LXIi2xrOs0i6U8Oi1S7yfkGJLEfE5yc2AzNVGmItJINM9m+lkNvtJQY+7/qfnPaSM8pI3aPFklIMi1s4N3phnj4Jn59iE6WrGc04g3BKPCS6C88v5euJCARJq4V2wkK7kwrdSK1vrYY0SDcBWEXOOQaKWCwo1eg4VH4R5ZzWixqyatR2SiXr2sETL6HDYmP9LMxoFIJXye7VRIY9WjQKqrci2ObiyBJf4TJndpmpuYSHMMsypV7tIG/nlCyCl8xqCKa/AingbW01Jlmf+YMf6Q+WWar/ufuoTfxhJZ92ospUPKZJKhT3thP+PPHl3ftvVyhdaJ0nFXZIZFvwry3gyzemPSkGvcEEkVnkfwvcUGqg8fY37/sfcsSQT+SaxFs9mDqRfvjbJmDDRu7BYmWzKewJN6CoAjB3eMg8+l5540tjhcL1DmO+9LwQfc95Qu54VqQ31u+UcW8mB0IYiiXhz+YF1KZREzisNXQmplmNwV6Vi54wqWQpggpbjurvLJvKvdBrS+Zz0U1eP27YVr3pqjDKRrJHqjU+huqzDfHKvPI+eOa5jOYZmI2wDie3DEGx1dcAp0zXQ6Wdv/7vYnFj6SRvTsmPQHTlsNJckHwaUxPnTvutL+0E1CVDC6QnoZY3e3W47SEg5bLBeips1TrsjFIvTfUU5WU5Cd76wWhQa7avZvctM8gOG/fLWEaMdlkEum2pwpr8dVks5kveKaio94DXNPZ1IWSH2XsYsFUDgsqNRn4twx+MqUwZ4E+ZKqNemgQZ0/jqcSnSAIy1HfUIpQByo+DBQA2c7tJlP5CMbkfZKNtqsHIib6EqiDAEL9OYaZpgD0EGF/bgEwY48K33x+8A5c+9CvlLqnu7uO5Qj1atFNajzTgjByAcgEXxDw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(107886003)(36860700001)(83380400001)(26005)(36756003)(426003)(186003)(336012)(2616005)(47076005)(5660300002)(508600001)(6666004)(7696005)(40460700003)(82310400004)(86362001)(110136005)(316002)(70586007)(966005)(70206006)(356005)(921005)(81166007)(4326008)(8936002)(8676002)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:02:35.4743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2416ac9a-da18-4ede-d13c-08d9ea4ae003
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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

