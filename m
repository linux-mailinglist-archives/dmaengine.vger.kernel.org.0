Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A21F439BE1
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhJYQoM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 12:44:12 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:12320
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234041AbhJYQoM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 12:44:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E26QcATDbn+co/7UIkbQbJek8CbTwVeSbu+PIs+F3f2OJwd0y88o50KUXk86PIPcE3eAe14NcbRKtj4hJFBY/4nzwCEKQ0aX27RnZFuDHEjwCvkzveQRafNGwPzVnHh1g8yqqmnVpoHfvnbITRnRCyPhszQcpTnRcIW9PBeX7RWqusqOSiUARgHNEMEvMiiGkJh2BfRtyETWkKjIGGXtHqDoKv4HjeM+y5AqMhgnaCyXogdXjVIuTQs3cH1HLfjvgiQ86ok4r/FpPjWqFEfrqxMPIULt5oLa7IYc2f64WyvV3P2fygUAIsCAVWMvuorbgwSifQEKn8C4M+oPk2c3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20MveK7sVwd2JrPI0zpbfnZXP3ZJLMt/qlT0+rA0v/4=;
 b=YlXXBWNIaJLgA8VbD4khRC8HAGplsytaBh3FAJgGggT4ef+Z7JAff6qf2uQFL7UlMAv2URT0o65vSwbUJPgAU8B1y8JYRDEyPNyT0J9GcOMqO9fA6jFGxRcU7P1bdBM8sNsSJh1wFkyTKBcZfvMcXQfKiavOSGG3qCA5b1slTh2lGl2ll62Jeq5rIYDlODQjCSIXs1F1u60fDv9YcTbHCeOzx9EADtzWaY4HfL2fWOh+zp9yxGyloTAdf2PFoCgMC0p0+0g9PkB5gzCFlPMx64LvsuznLwcDTPIsCyVfCV3bC6+d50JAXj5fliRTcn0t4+0Lu6onFsLVuo27Xr6Ovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20MveK7sVwd2JrPI0zpbfnZXP3ZJLMt/qlT0+rA0v/4=;
 b=CpHVeZoEuDmISQ/jR7+LJiJ50htRHRZL+K6SDGTMoX+pacO/bMIy+xdHv4M2j6tipJ/A4t74SOmiippGAyo0MaL/VH9zkr+5daEoiaQlgDmzrLgRGJMuzwUMfuwbJWtAFGA2uuHVgOMKmh0WqBPZVFKy66Sf2H7kPIs0t/pER6yk7gERZzn9bOF06nZPDsMTfqfUMHv5pSi14WALJdFG9SjR4Ic1kor1vyBFMtAd0VXPOf4YBk0kQfUEex3a0nxw94IWIrD/MIDqi0/gg0nztw/fHcauGeRF4lkULpySw2XxDV4jJ/i37KUmvK4wUEvIOi7WWFfV7QW8fe8s07IzTQ==
Received: from MWHPR04CA0068.namprd04.prod.outlook.com (2603:10b6:300:6c::30)
 by MWHPR1201MB0238.namprd12.prod.outlook.com (2603:10b6:301:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 16:41:38 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::f7) by MWHPR04CA0068.outlook.office365.com
 (2603:10b6:300:6c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 16:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 16:41:35 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct
 2021 16:41:31 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 25 Oct 2021 09:41:26 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Mon, 25 Oct 2021 22:10:46 +0530
Message-ID: <1635180046-15276-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635180046-15276-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f5c450f-2800-4f3c-5283-08d997d64f02
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0238:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0238528741C8DF4191018ABBC0839@MWHPR1201MB0238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MTeOaowm6T0iCZegb4TyZkkI7xXaJsOoWMhvyva7NMtlGIP3IZ8ElPK1QA6zypfhzAUp5EA4HhWjrK/GC792bYCUUiWVCTKNqlN7uwJqyokVW+6y5dokDHKqJYTbD1CM28va1btkep4jKaCbacT+Ik7Z9VNsEZKFtwb2l6+b664xJrF0jVYAXGPrE6U/wseFbx7cyUZ0uDehab/eRjMobjqLmrLHexNy0wri+Fjbpv4SdaSI2IDQtSeRJuxLgTCf+AzXiShHY+oTd4GxErqefjnZmGoeeqQcFU/+QR/IkkTP/+KkSmSvgfpyuGYO+DiqqPoOPj/QHtSLRp6tZAOT2MAzrMjLbB9BTH0brpH+alzET1bBccY+j1T+To2APj7E4ZElSffXFrywjSC/Adh98ESb2TaaDWfsYvY1Hvs9NVcOD0ZV9fMkv6MeOXmM8hSQX6bmzO//WnjTFePOT+RlxbOi9CMILSMLbn6Z02b8SYFT1sHoMRzR778UpRCY3YpaX/ebRfhCWslyTxB3BUW4TX1Wdlu9XN8qNhYvYI/FOm+zfXRZqZJ+w7Z2JmPTg7bGVEsnGgDyxfhoEnGqT2NMROVkVhHHf5NP0LVmrlb3+GqX+v3VNzXMOS20hL0VqQx4596U98UG8nSAshKs7PJLyslzlM6WAhqDXdNiM3BXJVXZQ07mc76txMWXqcve8fjOuI5LYmpsNATVqd5m3BdtQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(6862004)(426003)(83380400001)(7049001)(508600001)(7636003)(336012)(8676002)(6666004)(47076005)(186003)(36860700001)(82310400003)(70206006)(26005)(36756003)(5660300002)(37006003)(4326008)(70586007)(316002)(7696005)(54906003)(86362001)(6200100001)(2906002)(356005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:41:35.2914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5c450f-2800-4f3c-5283-08d997d64f02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0238
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device tree node for GPCDMA controller on Tegra186 target
and Tegra194 target.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  4 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi       | 44 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  4 +++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 44 ++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index fcd71bf..f5ef04d3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -56,6 +56,10 @@
 		};
 	};
 
+	dma-controller@2600000 {
+		status = "okay";
+	};
+
 	memory-controller@2c00000 {
 		status = "okay";
 	};
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index e94f8ad..646efa1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -73,6 +73,50 @@
 		snps,rxpbl = <8>;
 	};
 
+	gpcdma: dma-controller@2600000 {
+		compatible = "nvidia,tegra186-gpcdma";
+		reg = <0x2600000 0x210000>;
+		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+		reset-names = "gpcdma";
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
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
+			     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		#dma-cells = <1>;
+		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+		dma-coherent;
+		status = "disabled";
+	};
+
 	aconnect@2900000 {
 		compatible = "nvidia,tegra186-aconnect",
 			     "nvidia,tegra210-aconnect";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index c4058ee..5bc74af 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -49,6 +49,10 @@
 			};
 		};
 
+		dma-controller@2600000 {
+			status = "okay";
+		};
+
 		memory-controller@2c00000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c8250a3..6627edd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -72,6 +72,50 @@
 			snps,rxpbl = <8>;
 		};
 
+		gpcdma: dma-controller@2600000 {
+			compatible = "nvidia,tegra194-gpcdma";
+			reg = <0x2600000 0x210000>;
+			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
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
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		aconnect@2900000 {
 			compatible = "nvidia,tegra194-aconnect",
 				     "nvidia,tegra210-aconnect";
-- 
2.7.4

