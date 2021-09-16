Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEECA40D9B2
	for <lists+dmaengine@lfdr.de>; Thu, 16 Sep 2021 14:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbhIPMUa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Sep 2021 08:20:30 -0400
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:30204
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235737AbhIPMUa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Sep 2021 08:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eX3NVZ1H2tkW3CJnBv7aS9qYNRzwFvHVObMVZngUK5YzTFP+9rmSOLZJWQMRamCvFYUyYwfEweG/zocGj/VgN61Gc1i14fBPvHZcU/ASS7TvWej+07wJpgaZwADPmUNpFjXdUcoAWeN+U9eBeOMb+d0GuBD/rK9HL7e/QGnFRsqzKA+KtLUwO3Chc8ple07mbPSGnNr4h2AzADz8k4NglD3r1vfDgRrfyc945BnXx+QwGsBkFdw0i/BFvIA5Xdsp/FKad1awdowQcuyqEPqswU9C1Q1wFVqINDyCLBj6oSYwfCmEvOyd0WenpeenYsFrVG2dB3EVOUKWfUmuRViVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BjfZjPOh9F8PjGR1huuOYuYwsYki7aDwfoYQpnL0lTU=;
 b=obWN3x3OMaQmVSGR9yG+8dniuQpT1aP/mZ0VxWidHX5xYDX62jOLWeIDypORKQAuu+CUFHFiUEMa3fsU3Mvt8H0SsHnLUHwO/ScmbaqaPexpxe+tc+JGz4LHzGSZxSzDCNQxOekpxnsAkbHbaAy80vJBBJpUdVfP5gcA7YpmQy0jU06keuIrmyZTWcNpzv3ndKygRkmHfDgwMDxDpLRbiJIFbV/tDPWTxscK5Z2GYxDQ7rnX2xld870QG5tsmdSh2UCuqPHBN98saEoobuESLWjlkSIK7aoVJBSVMUgqBb2XRxsPxtm09tXPyK/iebVZOAVZrOUWlezMleFolA6eFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjfZjPOh9F8PjGR1huuOYuYwsYki7aDwfoYQpnL0lTU=;
 b=ESBgwgHPywGLq2t+vc96rApLCq77lRfz1MGgtTmMiuZFyLBIYJvCbAt1FfAyUZMIqKhpYl+5sAck3VwEsRNgMA5ievROULKUkOpy054lUR4iP44Cn+JNClc3i99u3ubwxe/paZ53zJLfgcgkcGwnrZc2eR09UMyWUAA/rDh3eDA1CLgKPbwm3k6Ju8oT4Azh+vwM+OK+G7v5u2qTY18Axhh6WntbA67YcGikzkpgFgx6DgAOx6gtyZBaryKMyDgLkJgyHVkiTfziuphfgQFn7D41RjAXMm2vZS6e5UO/1AZ/Qpp9Fq7vszh54OaX7RvHxfAu6YzrgcFPE3PaRqG7Yw==
Received: from DM5PR07CA0116.namprd07.prod.outlook.com (2603:10b6:4:ae::45) by
 SN6PR12MB4686.namprd12.prod.outlook.com (2603:10b6:805:d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Thu, 16 Sep 2021 12:19:08 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::77) by DM5PR07CA0116.outlook.office365.com
 (2603:10b6:4:ae::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 12:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:19:08 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 05:19:06 -0700
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Sep 2021 12:19:02 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Date:   Thu, 16 Sep 2021 17:48:48 +0530
Message-ID: <1631794731-15226-2-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6315d99b-32cd-4c0c-71b1-08d9790c2f0f
X-MS-TrafficTypeDiagnostic: SN6PR12MB4686:
X-Microsoft-Antispam-PRVS: <SN6PR12MB468635C37F04C974BEF74A35C0DC9@SN6PR12MB4686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pu4w7ClE+TuHffXIs5HP+mmGEdM0EwiY5Tom9dyk5Pwp6iW4jgvVYQa6s9itwvNr+Ja3mRd0+Aa+vRmM8Nvqyu0pCAH3Cy8Dfco2RxrMlVpt0HAob788UboiCnjvim2EPDtlK0Ria4LVfOO2LaPrPqYvcR8svPZ8J+N5sGLsfalo8saCOD4qNwN74ceRdapsRc6QBmRJV0TSJsVBTMrhmzr57yB8w3RNij+tDhD6FlcLzQQqeYIGSrFHSqIO3ujE+HMSiDx5oSBQSk3qzc3iuEc1oiuogyMjymJ9+RJfs8S0WQqn0fre8P+EHBmUiyokDXV1uZD53i+8S3naKSF5IrgWfCZpppxN9N6Hd1WcxVLZt5x3lGJOEPHkW/pxphELr0OBhDm2TQFqDkzDJGmxA5j62UpEfs3ndm9wHx1l7n8D8uxtV7nQvhqqfmtVTHj7+Kg6+0FCMmfIDnqmm8DMeXsahKo0c4ZlTAQcsOdIj/vM+7lM/brkfJsBFrWO3Q5fq46jaOXRnt4uqTkQ3zrTeyF4YAICk4WiV9/CKZ46KXRgPckUclJq3lIgtkw3ND+xKfvawmgtQJViu+I75Q0Kj90z5Bit1NDDYX87cUs9QcN2ANkAtvyHqeGGtOdHWPZmUsclS+LcTb3R2uEGqIIHTSbGfob8SOZ6hM8edh+XbXITc8Rfw/l4y5p/ioGy7HKC3+nXB+mGWn0gqgI/1Ojn5BUgetvm8iJBsdNluk+FmxhJUi2nSBkRyNcvp4gx7ptT7dSznRxJF0tnic19S9ZJxYo3VPHMxbEA9eSYTNLnkhSur2azltj6KxkpzclqVOrAcmPjhTKt6SSC5z+9h21HQg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(36860700001)(4326008)(26005)(6666004)(966005)(8936002)(6200100001)(316002)(426003)(8676002)(7636003)(5660300002)(70586007)(70206006)(356005)(37006003)(54906003)(508600001)(186003)(86362001)(7696005)(82310400003)(6862004)(336012)(7049001)(47076005)(2616005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:19:08.4616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6315d99b-32cd-4c0c-71b1-08d9790c2f0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4686
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DT binding document for Nvidia Tegra GPCDMA controller.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
new file mode 100644
index 0000000..cf76afb
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra GPC DMA Controller Device Tree Bindings
+
+description: |
+  The Tegra Genernal Purpose Central (GPC) DMA controller is used for faster
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
+  nvidia,stream-id:
+    description: |
+      stream-id corresponding to GPC DMA clients.
+      Defaults to TEGRA186_SID_GPCDMA_0 if not given
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
+optional:
+  - nvidia,stream-id
+
+examples:
+  - |
+	gpcdma: dma@2600000 {
+		compatible = "nvidia,tegra186-gpcdma";
+		reg = <0x0 0x2600000 0x0 0x210000>;
+		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+		reset-names = "gpcdma";
+		interrupts = 	<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		#dma-cells = <1>;
+		iommus = <&smmu TEGRA_SID_GPCDMA_0>;
+		dma-coherent;
+	};
+...
-- 
2.7.4

