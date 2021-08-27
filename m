Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567B53F9446
	for <lists+dmaengine@lfdr.de>; Fri, 27 Aug 2021 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbhH0GGO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Aug 2021 02:06:14 -0400
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:37793
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244234AbhH0GGJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Aug 2021 02:06:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7UBxh7INUUHE1Eq/2l58MyeDSBNBu3BAkSwtcjVa/MRd1IwjLoHP5EvaEML3dr6dyD6ONVIXqtFCnrhNwzVQggxxVfIhLPlgbIhnWwXg9NrJ+6TT26vIYiVq/I7OBD7Nf8QOVITELYvux8MU6qJ+XwobbSgphJWnPQVcsxvA5V5aHXADs0G2Z5tZjDPMID+AzyVQ/vREo+DfdKurW5Vt0eAy+YrI117U9byznYpJp5vjbg4+lBJjPpHPi616qHTfdCyLQJ0iLG+DLZTRXWfmOeK8SdNl8eKBM1jrBqOqbOcBFzS2vn263DiiCPZGc3/s/izPiG3060ECWAz8UxygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdkqEY2XgBshjmmt0oKTEeotL2eCI3f6FMxhSqHdw34=;
 b=NK34/tti/SqF68arJK06Ar0qUnRtXUoXFHCAyvaA3DEm0yv2PiWD4g+OoeYNsKXkNgJ2qFDwhK+WjXP7DCosUx50DLYs+FY8IYZ8Sd42Ky9RZDastEmL+kpeFgp5SBe5PKqYawzA8/cMw5igf5ZS/4x6coWeGs2puIs0FbDdGQxIgygSD00gwtfbDJ+SC5B3hRCVqQjH9ylricUSb/dzO1+NCbLfYazWYnFOTHulcNMV7RQXIFgwa1YY8iL2JPj7bk2tsaop5+eXZjx7yysVxdwWjonzIuWG6CKPhlHJe0A09RTqnIksYx+CVUH4eWCce5Ln9pBbif/5Ym8lxpM7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdkqEY2XgBshjmmt0oKTEeotL2eCI3f6FMxhSqHdw34=;
 b=YW7+SnF50j8Z+h0N9qxmsgBVXnLJ2cS5ayDNCF4kNNMO3/9++lgmHereYZzDgysJLguArJM6xGwN7DJhFd+sBYeL2kHVdD0lzpLjcvVY9sRuBvqVDYmKUdWsBp5rwWVn+syfEsLFMofpZj2KpiSTGNO0lc80wW4mu1jMemmJAPdOQ5bLXSP/vkFSKwzWCVpbUL/6I/7roRRmqtQzXihZYjtI2cXNXQm7OcKCoWAclybHr8Sybo5Dlk1Y0AfRIih4sRoL6KKkdJcYiW5odM9UT5BsVUtCAij3AIdBsIBg+/cJWUx9XYMIzGMj7YYrKrobe7BT31QuFVvo0/a7KcHzdA==
Received: from BN0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:408:e5::24)
 by CH2PR12MB4005.namprd12.prod.outlook.com (2603:10b6:610:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 06:05:18 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::8d) by BN0PR02CA0049.outlook.office365.com
 (2603:10b6:408:e5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 06:05:18 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Aug
 2021 06:05:17 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:14 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Fri, 27 Aug 2021 11:34:51 +0530
Message-ID: <1630044294-21169-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe0f5c50-16fe-488e-ba76-08d96920a598
X-MS-TrafficTypeDiagnostic: CH2PR12MB4005:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40056B1F8620FB5E4869A4EDC0C89@CH2PR12MB4005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6zFCahbERKRX/+nxcdKcbZbaW1uecYXSpj+Wf8ydFqL43EQapNCRFFEXb5naovxeYAXVqh1cQnJbSbneGTo5JGJmDHeI2+PRgSTERi8WajvQFFuP7fvh5J8Ug1XeGPrlV1+b1j0KAa2JQ4ZE4Qp8G8tTo0PXhXFRr75kiqGfviwFYYwVcar6HHIPdVnQA4dmkBn/KaTmvEaWoV9UxxFV+k3ZKGcPG9nm8aTWNvQCjGXzIGzoQVcktgV+J66QmqAt4si7T6yQFWGi/N6QnxJLMV3USZHw7mD6NCTd00O2j8EKretteShR8vh/tPTLbtbnKsE9FlmwSIf4JnUlRaOJ3AyldTU+Y+9KA/BDFPCxPa1yVGLr9T9Zo6Uhu0/njqXIqsbSF+izry0AlWWfbtKxXlRMTbit/GVVn7UlINrnDjm9Xfd2fTAdoqqZ4a/VqIi8T2fLBM4qIbRJFTwOaFo49GP1g6JKJvHbhyIOs/mgmH0SithE67umyvCFbgZDc5lhjZmDO5hjk8qT7e+v1/OT88GfvuY3/GdzRcK9VoHq/bBKMJLYJ73L9XJzz/ACNqE/rHKfwVVp/dK42KwUvfk11g1CcIozBeydgIgpKfgT0BmfB0VAf24egMRzpst00BzFa6aFhaLGO+VpY59cTEVBvM+o/pp4R/TNs44E5cuqM7QpeGlta5Izl/GJtzxR81mPVkP2utSKVnyh9PxlBehEL1xQRB+UXTYN7T0ncaWAjwPze1p6E8+QfuKJuG2euRlHP6Q75zOMeqpSLoCc3N8pcc4YAJuBv6awIsiWRn5dJY=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(6666004)(8936002)(107886003)(6862004)(36860700001)(7696005)(4326008)(70206006)(47076005)(54906003)(2906002)(82740400003)(70586007)(5660300002)(7636003)(37006003)(316002)(6636002)(82310400003)(356005)(2616005)(26005)(36906005)(478600001)(8676002)(966005)(336012)(426003)(186003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 06:05:18.6126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f5c50-16fe-488e-ba76-08d96920a598
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4005
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../bindings/dma/nvidia,tegra-gpc-dma.yaml         | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
new file mode 100644
index 0000000..39827ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra-gpc-dma.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra-gpc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra GPC DMA Controller Device Tree Bindings
+
+description: |
+  Tegra GPC DMA controller is a general purpose dma used for faster data
+  transfers between memory to memory, memory to device and device to memory.
+  Terms 'dma' and 'gpcdma' can be used interchangeably.
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Rajesh Gumasta <rgumasta@nvidia.com>
+
+allOf:
+  - $ref: "dma-controller.yaml#"
+
+properties:
+  "#dma-cells":
+    const: 1
+
+  compatible:
+    - enum:
+      - nvidia,tegra186-gpcdma
+      - nvidia,tegra194-gpcdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+examples:
+  - |
+    gpcdma: dma@2600000 {
+	  compatible = "nvidia,tegra186-gpcdma";
+	  reg = <0x0 0x2600000 0x0 0x210000>;
+	  resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+	  reset-names = "gpcdma";
+	  interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
+	                GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH
+					GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+       #dma-cells = <1>;
+	   iommus = <&smmu TEGRA_SID_GPCDMA_0>;
+	   dma-coherent;
+	};
+
+...
-- 
2.7.4

