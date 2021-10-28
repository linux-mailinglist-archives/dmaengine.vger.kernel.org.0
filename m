Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3343E227
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 15:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhJ1NaL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 09:30:11 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:14849
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230472AbhJ1NaG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 09:30:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLxQ/sFmA1JFh8qnvgeS54up7+WGJsPXV3Yorr2nP458OcRmaTixjNqn6hTEbt3B0VO8nX4+kcaHugHrstCRoNt5igH+cBZ8ihtr0d58ZNp0isBWeHmE6+AXPkBR0v+DmJ7v2QI0hpGhvJtlFL+666Z9ANFIySq1lzXDkKHjFz2DUaLBJoaJYXbMwj9TAD9ewCASZq0N5CtVtxBK5uKWpSaRssgyUqwoJ8xqKUuaGUWYgt2KjdlvCBSYs+38Xn6SAAQQp4IXvMCLoMgnjx9/ydpgrQBw3ypiWLZ1RMsvQwtvwA0GqivjD96+7mLdkxlc7qTCb8JIyvDfLKAWsZ3tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZgwuVUKDQLSVfmw3luE465Y7T1gg1mJmk5H9UClnvQ=;
 b=jK4G0pQbCqUMHA6E95cmV6Hp6O0L4QNtmKVVYsCrjXhCA0jeDfoCjfXXF7FkBV9LC+kdLMfGgvurb9jGiAPfXhyy5ypG3w3V8J+HRPy2JK2+LG5w0cNnJhrCqrHcJJHVPFMCjWzJb14EdCok/05Di1GSqhwXWkqjrvie7Nr2weCa0TrMWVS9BzMHRsVLaXm6gjWW0K09VwNWp7hDF2Hllc6wh+usqvL2+Fe6/lmK0DWeSLOW4hqH5fvhOa54x+67ADqFmqKUX3kU4Xwk3oQDom4uxtaD/4FEleBREG1/Hr7hMewstyGkSGV2cM3450e8TlwCDQdirKF3fOFfcH9cMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZgwuVUKDQLSVfmw3luE465Y7T1gg1mJmk5H9UClnvQ=;
 b=lrSYl9w9jRLuFKE2Y+az1D9mk/091LPSMl81rnaM6toKiy1z//sJ+iETntpzTzNYEphuhRAwBHQo1oYCMiq4ittvarAiSSDNcBmjAqVdYjKf4dRpbRVWJtftjIpviHisIuV765OP0+zPxUHGKYrZmo/+iBczqf6v5B9N3dqB3uFPIr2ZFpYoOFh6PEVRDSzcJOXMRZmpP1R9VfV3rUn+yJJpRZef2k5vwz1yh/4BncV75mJMwmH1CUgpnGsup11uu2bzV8SRATHYryXv4b0t05gUAQ9A2oRlxNvA+4lkdmwMGuLxD5zu5L+4L4wXCTb/iodkriR+AznuyESMG3Mc6A==
Received: from DM3PR12CA0058.namprd12.prod.outlook.com (2603:10b6:0:56::26) by
 DM6PR12MB3227.namprd12.prod.outlook.com (2603:10b6:5:18d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Thu, 28 Oct 2021 13:27:35 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::e1) by DM3PR12CA0058.outlook.office365.com
 (2603:10b6:0:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 13:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 13:27:35 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 28 Oct
 2021 13:27:35 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 28 Oct
 2021 13:27:35 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 28 Oct 2021 13:27:30 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v11 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Thu, 28 Oct 2021 18:53:36 +0530
Message-ID: <1635427419-22478-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1515321b-f269-4a7f-5566-08d99a16b474
X-MS-TrafficTypeDiagnostic: DM6PR12MB3227:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3227FBC7E60BC00CCD9632DEC0869@DM6PR12MB3227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFJFHzR6m8VKY9CL+TuMBJc6ei17PJgdG8wjKq2uIZu+IL7bY5fkWOs1+134hUCXMVms4tO9+ghmdPdxHYZdgOzr2fgQ41BJTtoC5UScemolncNhwqkKgaIWeRPe3i6BXsp4GfATlOFf44pUdEBb5xdKbF4GgMVDrSmQhOAQNIaLDkj+0bJgeQAZsQpXRSv/KMhoNX9mguKHzRwfpeJfh7DIekHIrOlhMbdnt0oudK22FeMoirmWxUEJxdF8PQt3fPd9wA7Nyl30NkEGOQYxfBVjN+jer1uqdycI4sN6slXJNsatrC0bRd41x8LmnoE+7/2yNhQ2aEUzJMzfxHtp9KkvpgiFOUX5aZ7o50ICgAfFvf4aBBfd9o0MKRo1SBaHuQBlY4GOs8ykhg4kIgjtZ9LG1GZkFhoLKl2yq9wJqNHtCryvNlIKj5eDbCXY7q91n0oDI/qfPzjeGIv1HIJIy2xudtFQY2GnTMr7giPX8P9gGXVwHCIsrdTS/JwpzpRhCs9KynzgYnqXkqkRWqNEeAk2faraBS5tcUCqRveUYYAKK+MSb6dwt1JvNZk4f1xiK2dKzn9A1WKsME+Myyr9d2sFWEa/rk8DHm82SFKjSMAufFZzg1l6q3Z5G2XVvzFiDtCCNRy9xYJlvBit5cXanpjQ+dinNn/wpzoI9QxHaBOUI15FAXzGSUrJZ59WYDtskOdtpzvNjlX3cHjmJQsaGc25aNt2avheX39PgLlQ/dh6rTgLRWXBg4Nz1Q7IwFk2H8s6ZlaiqNZHlfXg38lRVzq1gNAPxMBD2fRaScEm9npupWMoUdHuXNYsnTk4PfUMr5cnhRfOfLYCUBcuIkFRjHTCmTk5SOSVjPqPvi3CzcY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(508600001)(109986005)(83380400001)(47076005)(336012)(54906003)(5660300002)(316002)(7636003)(82310400003)(2906002)(2616005)(36860700001)(8936002)(426003)(356005)(70586007)(7696005)(86362001)(70206006)(966005)(36906005)(26005)(107886003)(8676002)(36756003)(4326008)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:27:35.6037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1515321b-f269-4a7f-5566-08d99a16b474
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 115 +++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..bc97efc
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,115 @@
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
+    description: |
+      Should contain all of the per-channel DMA interrupts in
+      ascending order with respect to the DMA channel index.
+    minItems: 1
+    maxItems: 32
+
+  resets:
+    description: |
+      Should contain the reset phandle for gpcdma.
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

