Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE7B4BDB80
	for <lists+dmaengine@lfdr.de>; Mon, 21 Feb 2022 18:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379369AbiBUPmy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Feb 2022 10:42:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379358AbiBUPms (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Feb 2022 10:42:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2AB22B02;
        Mon, 21 Feb 2022 07:42:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC+ETEfmc3E6Y0/F9V6KASSPFO4iqDkwC67kFwKPzBmVSRKQrDwTLnNzWtJCQGoDhSmW4hzzHSSV0RXKhhuxtX0NsRPSapeHd/QRT1vMuYYOGDY8NmFR8kFPAyjTiRnUdNCChMN2RHadfPkYK9YLhkRfPaDQpexxOmuC4vlBhII9qESnQJJ1+Q4GRtCimI/czdprkLwX+2XFg/cE1m8QcpOzIDx4fphEDfLqWIe0wGBHMni8lhcSZ9dLwT14JN0iCH7ChPQovffqhJumhI0zXTE0NvPF6QeU5kexHVjy9JYX4Y3Bi5JnmNXpM7XgQbpjzymi5eisAHt4ZYWPtWkJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npA9vSPSem5P5nizpnXMtZ2ZdgMqLH6iW8PwR5WwuOY=;
 b=fTKHRqO2DQ8dnpWJmO4rse50emxZmax886eoVphcFFl3S9GIjNeqSxu5+GnnmGhXInnZZmbEzE/Kd1/LwuLHJmVczGZ+mXacg8hHlF9G8gl8QSFghwZgWlcv4+EXXakuxe5W4G75Kqst9WvoMhADuos29xGYLLH8dQ+WdfWWcnP2EAOVMRdP490GNegGjJRQEQdo+NaORapGxxbpL/w7JjevoKPMdRwxNNlBpokvWmqgWSdoGCo+WWMNkPol8sxOQrZ+HP+kZ0LHOsAmECFyRX7SCQaT8w0xZT1c4Z/pq0gvbJpnAZ/JKJigCbxRuSLeLjt2Sq94zk8AperJbGE38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npA9vSPSem5P5nizpnXMtZ2ZdgMqLH6iW8PwR5WwuOY=;
 b=FxYzJoqMGQGJgIi9yFxDcB1u4QXHxY3hMJgYUiKnu8SM05atbaEfjTaT4t5x+vbC6tlfmNnMFW0lE/XXACfsnjykpEK0ptVtenJurvxsSA2Xrr4ZXMG8MLZa0A13WdzPzyAN2i5qZP+XVlo0QriZ7hAE9mEwoqYLewfc57q3sCXdDu/SHqlA+xlcTtuQPTkGROB9k5SgCGAc46NG5DNrt5TKXZWcNRy+Qkshlg8dl4VgvuYRJsw5DgB84MRcwEKAa9ykzro2TyZtN8ncXk3OyqlwtLYsKyQadI4zsnoNExztih4pKX8YGQnrHcTzR4Y/Un1iTnYXfKUlQf/0Gh9I6w==
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 CY4PR12MB1608.namprd12.prod.outlook.com (2603:10b6:910:d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Mon, 21 Feb 2022 15:42:23 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::c) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Mon, 21 Feb 2022 15:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 15:42:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 21 Feb
 2022 15:42:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 21 Feb 2022
 07:42:20 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 21 Feb 2022 07:42:16 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v20 1/2] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Mon, 21 Feb 2022 21:09:33 +0530
Message-ID: <20220221153934.5226-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220221153934.5226-1-akhilrajeev@nvidia.com>
References: <20220221153934.5226-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a71eebc7-73d2-4db0-2f3b-08d9f550c0b4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1608:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1608613DE2B2632EBD50D2F3C03A9@CY4PR12MB1608.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFp71HiXFukk+7aTtqorXU98IxMc6dRTsw86v0rQJ9zEvZsh6W0PSRorrHVEkr8TGMkfSCBjo8wr5gqbbdWo9roxztJdoynGUEoLImq/OuL8wfigDFfadxvQkNRQTKqbMQY/kXDiavRMor0+fqTcU4LHQRgR+XUOlA+AfPIU2bie0tHoMUKAnb8MZmvW8w/jRWSg7aNfL//gTUoyWtrGPjJ9+xnaAmgcjbQtCSLAR0Pyq8InFpedaPBwF66sI8KPj+ydli300CiKK3nRHTS+cuBVWhb2jGI69AWf6KvcXvXMWUrr3v7OB7Vs5zCPdwgoQx6S4wP+ZUru6Q/bNEdOCesNJNRu4dvLRN6QAcsPffs1HMtsgH4fU5wpPhpyMXRbznisJLiYCbIxgragLUWk1+E3nlDNTcLjWTzBBs8WJiTgAaRxTNTUNp65Bd9nSJrMjmJebn/cToG62srTMfL7D68TxtFtsVfLjilPmWT8771wJBb3lyc11bD8m1DDFKMRvIUo3HyL0JEPW0aMTbRzh0a8uZ+VqG74hjLgHw8AlEWujPJBD651MXtpfMlCg+Tk7fA6WrjUM++LIioIch9C/i6tShGcqESkvJXAo5uLLgMpz9Lt2WqnFYUBJZpv4lI3Tjj66sYfu+7m0hwoA+J3i3UJfm2jNv33tUDHby3G08WXIdXAJ+EnaTyQ1nZBZFbJFJoU9+S++HijEIRRG/2D6Hn8QIqlA4aY6ZcWr2XftEG4o5NEhPnsHXxPyI5/1RuMC3eJXJ036D3MQNuj82gXaZxUeb/OtlAXmy4vFdmy4xPjixyN6Vii+EK9NECYa5EVGvHrZyKfsDhB0cEFpgJIkgkgvMyg4kHpeHuHAsvCjSf3/KKzpOx1dZLme2rth3dUuEdhGPSHCjR3T9jUqI7p8g==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(426003)(47076005)(336012)(83380400001)(36756003)(40460700003)(5660300002)(2906002)(8936002)(26005)(2616005)(1076003)(107886003)(36860700001)(110136005)(966005)(7696005)(186003)(70206006)(70586007)(81166007)(356005)(921005)(6666004)(508600001)(316002)(8676002)(86362001)(82310400004)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 15:42:22.7608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a71eebc7-73d2-4db0-2f3b-08d9f550c0b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1608
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

