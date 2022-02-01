Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE54A6019
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbiBAP20 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 10:28:26 -0500
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:59329
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240363AbiBAP2R (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 10:28:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3hVaRQGlgkUApq8zMjgm1WVxAidz4VXQooOnP9U2m1eo+oc5FLRpmDaNmv8w0+I93DPrIMYJgIkmR28H54yMNDwcnM8+plopW7F1vkyBYlIIkR67rvFbTMPoUdQwTKLN+A4FaAlj2m77//MnHgpFbNEfjsnzrmsTJ4Aoq5uA9TAVK9cbF5SuZJYXqxL62u3NdI+syzzqjQOTc+wHX+JGQx9g6Nny1IKRCsO95PZpnuPyfHxfFrOUyOwLnTUyBWKjyf9g2rdqDE6AZvYV0/7zeUs32V6IsEGYcvv+EwYMC4Cwtl7C1Y1FQGtEdWXiXXgjHk9ROGFZ45wA/ieMJVrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC1XLuJfxHaZgHcbMqAIOauc9UIa0v3oiZRZB7Xznl4=;
 b=Y1QlG69Sk4SThpx7sHvOr/eb1M0dhjAeNVNw8s4wVizXvE7UAMRKCp9uXnT4ebfVQ3xvnzwXYGOag39f1dM94G10w8Vn51IZmPGITIsAqTUakQZAmAlcI8lXmT+Tt7PkC+PHXb22f7HsQ4n8GHtVxj1yIg1kEXrLLYswtOaVMbWFkwCFyR+MG4qTXqQUNrwKTGsQVJYCjuZjS/nchb93PNObXDO/2rzXavwNGG8foyxW8N8fIakXFldgki+TlecwN/x3f2Lctw9juI5R1G7k9pOLDVywkS+MYZPz9mZGQ9bNPVVwK5EMLVaWGFVtJbtav2kM8rozRMIYnxYf4KMKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC1XLuJfxHaZgHcbMqAIOauc9UIa0v3oiZRZB7Xznl4=;
 b=o/4LOSs5EdpODl5BC1BDK8Qo6Z58B4k/EYq2QwSEVM9Q0LFeF5r9tPggAqR6bFAsdTBfHLrm5mrYp7Z/sDwuEhTmFpzOx5p1Oxhn/qQrDZ2LUf+Zo5hQHnhW8Kh4JBV8awlmT92YDCiFjh+6l+A2unneM0XFGfOux9S56gVBpfL3whGXke3mGnMRxhhXgK4RE9JPpSXi3+xcZM18Z6dkjqELOTktx6a90C9zDjYNmKO+bntSTNgovtwTLgWmyNpCz+mV3ADTSau+n/UDbBbh9AVfzrAbIB6tqyYJ57wddfuUZW3Z1EUWNAX/1nCrJ5fQ4jA6gXIGh+o55UR2YJRs+Q==
Received: from DM5PR10CA0021.namprd10.prod.outlook.com (2603:10b6:4:2::31) by
 MN2PR12MB4848.namprd12.prod.outlook.com (2603:10b6:208:1be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 15:28:14 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::a6) by DM5PR10CA0021.outlook.office365.com
 (2603:10b6:4:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20 via Frontend
 Transport; Tue, 1 Feb 2022 15:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 15:28:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 15:28:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 07:28:09 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 07:28:04 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v18 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Tue, 1 Feb 2022 20:56:39 +0530
Message-ID: <1643729199-19161-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
References: <1643729199-19161-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8aca1f-ca5c-48c1-2451-08d9e5977699
X-MS-TrafficTypeDiagnostic: MN2PR12MB4848:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB48486922D119BE0E85ADAF59C0269@MN2PR12MB4848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DgJhBedvSLuEn1jKwIPGIy+m1go2a+M+TMY5BPOjkWgW3zTMiZZtbG4n/U8H8gMAnzDc0DWX7jc4zhwQEMpeo15BQrEVEDfw/NuHaDX5NbElIoRNI4A4AKoXYkpFw2zpmKPO5wZeA7ig/nhPba7qEbJx764zXW0TjrjJhKGt165PQQOqIbwvOgLfzV2j510lVv0l2AbVgvmfvoWTqf4GmTovzSXfY16lVs/IRoOwdOAFAfkGmrpz0mI0m2zueByWj7degB1fPc6ojpTwzmTgoc0qzSOZ/1GS2Tfhc9Ag7MMTeXhH9oYiZGUXn1EQeUHLezB0BJ/B9EbSbjcM18C4fJHFi8dKM8ZHFnF/Dkd0EyWoBLQ6vLoTlRJqQEwHUh6ZCud/Fz+5SVR4ul2ypOy4l5FQiUIOC2fncy2J2zeSEWd2zioNf4iEUiNz03zTSItEYl4GJloZA4Imi1lc3tHKOL40b3l7Jv+pnXVA5wKP+gMWHPEhnFg8lm6fsQUK6ORrXbUE7IynPqKoenUCX4GeN8GCeZfG3PGVYIQ2BnypL9qubrtCF/iiFkEL2DfSUzem1X3PNMcnMM/gBBHrJsO5tE2hp8RviJSlxoueRtSpHIqqN8mloAfQXJysLh2wwekioJWV3eE/LzREC5zIIjTXR93wIhYVrDJXhoXkJyGQJkT1ZoP6RNQCFPV1He2Pms7oY+jGnXz+LNGj4DpaMiS0ZlW8DKr8TZ+OeYdLcXRMK8XkjpZ4ML2MpLz+eIfghRfSL5JL68ZeCXPYRC91TZuDQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(47076005)(40460700003)(316002)(86362001)(4326008)(70206006)(6666004)(356005)(81166007)(8676002)(921005)(70586007)(36756003)(110136005)(508600001)(2616005)(5660300002)(26005)(186003)(426003)(7696005)(36860700001)(107886003)(2906002)(82310400004)(336012)(2101003)(83996005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 15:28:14.1112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8aca1f-ca5c-48c1-2451-08d9e5977699
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4848
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device tree node for GPCDMA controller on Tegra186 target
and Tegra194 target.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 42 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 43 ++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index c91afff..899d7b1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -73,6 +73,48 @@
 		snps,rxpbl = <8>;
 	};
 
+	gpcdma: dma-controller@2600000 {
+		compatible = "nvidia,tegra186-gpcdma";
+		reg = <0x0 0x2600000 0x0 0x210000>;
+		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+		reset-names = "gpcdma";
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		#dma-cells = <1>;
+		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+		dma-coherent;
+		status = "okay";
+	};
+
 	aconnect@2900000 {
 		compatible = "nvidia,tegra186-aconnect",
 			     "nvidia,tegra210-aconnect";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 2d48c37..8b58f5cb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -115,6 +115,49 @@
 			snps,rxpbl = <8>;
 		};
 
+		gpcdma: dma-controller@2600000 {
+			compatible = "nvidia,tegra194-gpcdma",
+				     "nvidia,tegra186-gpcdma";
+			reg = <0x2600000 0x210000>;
+			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
+			dma-coherent;
+			status = "okay";
+		};
+
 		aconnect@2900000 {
 			compatible = "nvidia,tegra194-aconnect",
 				     "nvidia,tegra210-aconnect";
-- 
2.7.4

