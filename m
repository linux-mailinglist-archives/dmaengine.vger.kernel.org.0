Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3C44AF93
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhKIOjQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 09:39:16 -0500
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:41250
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235169AbhKIOjP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Nov 2021 09:39:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+cDds/sra/jx+foH50hPFmTmO+UjTRe4iiN8oSZJWwd0HfoidHAUm8+BMd8OZuyA/181SwQ0Alpmn6lGQwctDoI2TzU6UnlTyVJz+eJtroWPekkvcErs/d2/o5MM8wckjLy313z7sqJ8XckUDA00RjF3Mgaw4jr80uXDd5fN0UoNBNlgP4U4c6NsMFe4wxpDKL1lnEZJ/22HzGKOLWtM9g3Au7kl6aPRcruIRcRAlHOAG1b9bSUwK20HDp7Jvz7ukNHxlfRKaghZsB+9Ga9sNVgTo1XL2+Zkq3jIfnDJmHItC2QGI791Ab4S+ckCxQBb5UdLFUhRKFXxAuzEnf7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72p7juey8kJDNc6AziMYKNMaHGcrWD+4C9TqASjnVDc=;
 b=NKY8gthJJD6ZJS58XSd5wKjKyEYVO9zi2Rze/Xa94lS6y0LuYZu/nrG0Qxj4yzg4UppVco3BNgmkZPU/V+9S9218WY9s3Kh7DvmbLZyMgEaczadPrf9UrdrjEYpRY/RjIhwmLUgWPfqBy6mC+2yGAQfoD/IaW+7BRzZ+C3fbx+lYy7I86D8e5kUv/jLTCAD8vyS7p2GJU49NZACXgyYEmwiF8LT8y1DsZdi4fOWVth8cVym6KVUjJv2WgjhnSz4Ky/OSW96DdMCTt1Pp+S7RFTAGos6fyLNTVZORPA3EWhJ7+VBV7Rnxz68ycxEQIHuLLn2pupjunT4Wsb8maMFbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72p7juey8kJDNc6AziMYKNMaHGcrWD+4C9TqASjnVDc=;
 b=mZ1fOZA1KgGHNHPYXZSEpf1xPzlmW5HuBLaoN/sE7q5y6/3YVQWZYLYEX7YY0jISo5ZpPF+sbw/+rvwTVAeHV8EeRPZxbxMiYKUQluuaFJlHatQpRIW28V1OOVUyjBSdu8Eb94i52XH4KOmkXWDonJ9sMwTGB3N7VP62fAtAqOm+iQ8Qzp6HzR7pIIWWamFen6h4b9ZLMMuExxN52vzvUoJVdeCnvdPymjuMJPQ+RCUESYE/+X6SC8mxmLu75E8hpnxsH5xQWEuLGfzu+3afmyG5IFGINGMii27tH2x2rw0uFMrh827qS1a54cFquFdDeDTlwDbHQLCUSqfPI0DXHw==
Received: from BN8PR04CA0007.namprd04.prod.outlook.com (2603:10b6:408:70::20)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 14:36:27 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::be) by BN8PR04CA0007.outlook.office365.com
 (2603:10b6:408:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Tue, 9 Nov 2021 14:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 14:36:27 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 9 Nov
 2021 06:36:26 -0800
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 9 Nov 2021 14:36:23 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v12 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Tue, 9 Nov 2021 20:05:49 +0530
Message-ID: <1636468552-1120-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636468552-1120-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
 <1636468552-1120-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5e0ffdf-2640-42c4-c23a-08d9a38e503d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5385:
X-Microsoft-Antispam-PRVS: <CH0PR12MB53856CBF1E08AC2479F45A96C0929@CH0PR12MB5385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHr7iNH4EJ5iHUg3vKMtXp1lq0aNi+qxsNri2N8FhzL8Yt6+m+undynw0/N32IvqFXhpvjOrQ9TNzpDMWcblA7nfBLzr/IDdjfQnYSa93IfNc2SXqFS/fp8UMOtzATjASPvZmqItSCV6BXm/Rj6Ehpw9ebwIEe6nufbQAJrcybuf0nBBtZJPU14H8R0R8Cku2D/uOSHviKGx28XQQBnN6hV19mnhTdE38uTerDywZ9i6ZqZDIOgBvE90gw0Ow2ag774IRzFkcIW2NjR/LM0CkkArRlj4X0XEVQ8L/FJXYoG9VHPl8bkP6nKoI0xwZR5NBmyl6F1BFNfPohrwrEbY/D8bIMIkB74di2TnEn+FPP7P7RoscgDqafVDs6Qc1cZVhO+G0Alc4u46ziSo/oEmm34qWBkzGKuaHP7YD1hIetTP96d4/ZZE6SwUPbJKXUnM8VjAJsuyXKavLhecXGBD7VbQvXNa3AjSaNfm8hKXKhkd+tb6KHe0EW3rSkCVco4Y9aUp9clKhD5bSjHvmJCMCE9okpBJ46nvAqlSyyItDVvwID8uFm3eHR92lbZ3XcbFsF513ZZ0gSAilkTWgjEuQnq1pcHkHnDNT30upDFfXLI/GgSadqllES3HrlV+1QALb265E/esCCz/De9MQ4ZZ9qOrfeltmI8rrfQQ4e1hFeW8t0QwtVNa2BHA/gcckvbXX+sOEWQZF+OOlW5MXCOAE1GXXVvIE61xbjjnExiMbw7h9SckzIyi24x3HnIVFblBjds+jFy3V1GVkHMhWSFL3W77mP7WxYE7V2qxj5VAqm1kfc1UgTEmZ5vgXBmlXQRu1gPq3L41usrJys8VtyMFag==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(6666004)(6200100001)(86362001)(6862004)(186003)(83380400001)(36756003)(356005)(7636003)(70206006)(37006003)(7049001)(316002)(54906003)(966005)(70586007)(508600001)(47076005)(2906002)(336012)(82310400003)(7696005)(8676002)(8936002)(4326008)(2616005)(36860700001)(426003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 14:36:27.5054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e0ffdf-2640-42c4-c23a-08d9a38e503d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..f2d63d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
+
+description:
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
+          - nvidia,tegra186-gpcdma
+          - nvidia,tegra194-gpcdma
+      - items:
+          - const: nvidia,tegra186-gpcdma
+          - const: nvidia,tegra194-gpcdma
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

