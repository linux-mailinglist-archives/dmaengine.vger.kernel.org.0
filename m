Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1562481D
	for <lists+dmaengine@lfdr.de>; Thu, 10 Nov 2022 18:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiKJRSs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiKJRSk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 12:18:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B566389E;
        Thu, 10 Nov 2022 09:18:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYpI2ZhAawWlMg1WuX/1EgTI3SWZcfbJupl4a6a3mZTo+y5l7wUeoo84XeSsbbJ1NVjgwDVoBhSUZd9qhbLtZKEMlCX29P4ih3AoHNUpmD8YGZ7hC0IrzJwrU9QUE8BaJ+4pRRRlMRDLVgk7eZJfG7hwmLUfVp20myp5ibzgEuJIctm2a+iGHo0Iti26bx9+G5hGYw0AC7a3J8/Vc/INKCLfDpqNQjzYNVOywXokZVkJpuZiFQdf/Vh0PtD8GouAPWV6hlPz91QyiZ9HrZYbuVgu1tHxpIh239g7F9C+QQp+i0244YFEkMIyd7bk9Crwsx0Zi8BXN0cxvPBnQoYqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9OUoxiAtDFHGh6iYksq1cMzSmXUw/llWUw8o5SxYjQ=;
 b=l96vdMkPa9HqLRhD1SxLGVzPy3PwLN/SRg2iJlVCPXON0cYpeX6nOnEmZ+TOYnzWXdznOQP2kEEIWZXwowSJDrFCN/HoyTwx46rgOpO3yhQ8eFoWc/IF5Is7vLvc4ZKLFmxWoLXgVFKjAVsi+948rP7TrFSmKqqo/Ve9DNz6MofAHJQ3x7bJCaPHLpImUnW1mXZRuI4EnXRMNelAVQSXLca+4SkkitnHbFB5nTiwswQTzbt8N8+Tg6A0EUCJCDf9JRmR57KY9WOTtOcHukIzQeb/r2g2ZWOIdRC2CHKj0KcVYCDh3wDbK5FaIACpsBhKFCb7EJB0ErJSrJ3kv9de3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9OUoxiAtDFHGh6iYksq1cMzSmXUw/llWUw8o5SxYjQ=;
 b=G9nCyEqU788aIIb1TcPbNq09/yBoZf0UPmsl9CX38nh6V93bUnLGna0OIf4wpFif5AP2+mzzX5NtX2E9Sbj5UT6V4UVtc9uC9bTlJsqeaMTj9D0cz90KRqOSvlFSr00V3wy//fa4NmMGATFYQKyEL/SbBGDl2vVK/bYeTkFpJPZOsUSYmQzyCov1UfFA1P2u8ozVeZgz8T/hCdctLQfDu0fD59J09A+IJ0HcZHAs0owv9WpbP1qVjxNI8/Tg4MzsHA26USFZtW1/A2rrof3LWZZ2xZNZJcbl6+J5edmBUd2eEm+NWTvwpNSMLADmSAe/AHVQWJG2SypC6N/0EtMpWg==
Received: from DM6PR11CA0002.namprd11.prod.outlook.com (2603:10b6:5:190::15)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 17:18:35 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::5c) by DM6PR11CA0002.outlook.office365.com
 (2603:10b6:5:190::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:18:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 10 Nov
 2022 09:18:28 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 10 Nov 2022 09:18:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 10 Nov 2022 09:18:24 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sfr@canb.auug.org.au>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v4 2/3] arm64: tegra: Add dma-channel-mask in GPCDMA node
Date:   Thu, 10 Nov 2022 22:47:47 +0530
Message-ID: <20221110171748.40304-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110171748.40304-1-akhilrajeev@nvidia.com>
References: <20221110171748.40304-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cb2831-7d75-451b-64bb-08dac33f99d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMOEStrb9POMUwUssmkphQDjW2Z6+vEZ/A/x9bNUhu7tNq08MAhavbur4H5pivfPGRoDvgGmvAtN30zg23YUCs1JjQnbDztOVAeBx+0IcgjfcZJ5ZXo4y+8ApNad5CHo2oJ3s8qI0X/DBMX4kpLgM5qWg86Tkddvas3z3Y8g1ezhdhggnJNqIutehQgCoEhrv4GEShw9g6L+yIqra9STrfAMElwOyJ7XfxbaqtXrFDyCl0lO7dVmlgeY2utNXAYggrJrlTtuK1eBhIBvSpR+uf9YwEq3cnjQxAh64T/CmiURP6cYM81FJsmEfRwBR9JvJvsIIcVgI0XUXHCWDoyO+UzWgz+2nXXtHDwv/FCRbeVxQZCuxi9vWsSj6hpqtyriF6DdPWFVKHRCxgFJnXMYJI0H96MNAE4FpJuNks+EzT4w2qQ7cqj+2BNXfW3mDR4I67ojdAkfGqdTPkJNq2pVTNkKXheh0uTWI42lx/cp/whcwl99PuFgb6Ac9WKaLiTI2EfA5YSvIuOB7vLj9fFCKKu4p5Q1+0IpCryCqcjm6MkSYWM1M4JYhIVcW++jH+aeKQW3TeMGHQRKf2pEFyEewAMfXhUSmBs6oWietJUgQ4gVZzhp9qiU7k0zug4TS3cI9bQ42JZBelCgNlbXQJq/UkTn+E/mlBYL9das4gQ8HxKMhB6zXuvzu8T+FFUFK2nWGwoWZC0Mi9BDZep5GtH7usYXFcl9m2uCZsBB0Uea/e+ENveNPgQpe5eZ7SoPvp4/bdiOkHZgIcNJWWTWadbAiXVNHF6PqGfgHDm8L2kv/g4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(7636003)(36756003)(36860700001)(82310400005)(40480700001)(921005)(356005)(7696005)(86362001)(40460700003)(82740400003)(316002)(83380400001)(107886003)(8936002)(70586007)(2616005)(110136005)(6666004)(5660300002)(478600001)(26005)(47076005)(426003)(336012)(186003)(70206006)(2906002)(1076003)(7416002)(8676002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:18:35.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cb2831-7d75-451b-64bb-08dac33f99d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channel-mask property in Tegra GPCDMA device tree node.

The property would help to specify the channels to be used in
kernel and reserve few for the firmware. This was previously
achieved by limiting the channel number to 31 in the driver.
This is wrong and does not align with the hardware. Correct this
and update the interrupts property to list all 32 interrupts.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 6602fe421ee8..db479064ff72 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -78,7 +78,8 @@
 		reg = <0x0 0x2600000 0x0 0x210000>;
 		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
 		reset-names = "gpcdma";
-		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -112,6 +113,7 @@
 		#dma-cells = <1>;
 		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
 		dma-coherent;
+		dma-channel-mask = <0xfffffffe>;
 		status = "okay";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 28740c014f1d..fb073c459234 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -142,7 +142,8 @@
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -176,6 +177,7 @@
 			#dma-cells = <1>;
 			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
 			dma-coherent;
+			dma-channel-mask = <0xfffffffe>;
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 5d7df32fd159..e1165b75f708 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -28,7 +28,8 @@
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -61,6 +62,7 @@
 				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
+			dma-channel-mask = <0xfffffffe>;
 			dma-coherent;
 		};
 
-- 
2.17.1

