Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA4C40D9BD
	for <lists+dmaengine@lfdr.de>; Thu, 16 Sep 2021 14:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbhIPMU5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Sep 2021 08:20:57 -0400
Received: from mail-dm6nam08on2076.outbound.protection.outlook.com ([40.107.102.76]:52387
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239499AbhIPMUx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Sep 2021 08:20:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afHJ2i9V2Fo/T4s0vinYzuzQ7Y/EYDpc0hFHWFwcATWwJTW0yl1AsPLUJ8YR2iKnI+7xhnzh24UrK6knKWKPQ9Tx5NVANL+uKi01yJ+nlM+LkeBKIZRFSG+5bpiz/fc0cyPDwasCL1R0RwPKzRzUl5cSRDJp+GZmNZLEhlWkF08CPC9623FnYllRovUYbse29IOdn/vxcFzD1Gss7nuVMuGcimJYX+ALeFnzce/eNwjs93WG9w9aTfqrCO74qN2WIWy5tPacj/yDW8hvLGiXPCY9AIHPrwPuNkakIrMatgj8fl4B8bpV2CIkgDDeJwp1UP9Dy+rdVhzWtmCKFvo1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hpyJJCPF9dLhCidg/qgMTEQvQwlM0kZGW91hkZfE2b8=;
 b=A9HmJqTgU21ot0D/uIIn+6WuYxqWiSJokXa4gGkiQtfjvLP1As31KiSdene75uwzbO+PIEa29vM4tWLp2WCMZJ7Te5LGTQ/BBTnsegdL5pZco+Y94uJuUBYwp+qKobXvntauBrbkr7XjVkg7aEL6p166tmfIZ8h7Kuj4o8TL6hD2C871e5SeYMNNZh9mFiG1PUIbwzScrdbHY42jh7qILYYwMQ5CwbujVKlFbN/qGf+zGxLXxGyFj6qyf3JdE9ohgc3aTuYH4Q7AH1WFdTBT5KHnQVH5fwUvWiQ/eUOKD9YO8NDl42LWsVtB/6WoBGBLRw1u0fAnB7mMuY1czJhq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpyJJCPF9dLhCidg/qgMTEQvQwlM0kZGW91hkZfE2b8=;
 b=K+jSV3pydskckGlBeCJIbOGfhhuQh1cTIiI8qHZ46aj/i+7a93y6yOPOXc+M/YuwbH2wGew+JSoooViDjsfSucOx8PnbO3A+UCKYa6IU7ZaXXCeHYz8uMbOc8v2lGe3LJiol1W1BzyMTTreTSmFNZyvKQZYPwDenw7AyoKu2Ugfdz8SLIhIl/FcX3e8mKTLUU8HG4XIynSR8b4zjLpSq2hCvXsRbTF6+Xfq8EWUwhbD4OTJtfuvmmBbl/k3ryfwXMyKpnlPuB98vR19Z+X3YIVi2q+GXOKDFU7l8ZvOje499qPm44rhxWCo3Y4LkBy98YXy76QHwNco3yq+8vd6aWg==
Received: from MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::9) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (2603:10b6:3:e1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Thu, 16 Sep 2021 12:19:31 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::7a) by MW4P223CA0004.outlook.office365.com
 (2603:10b6:303:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 12:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:19:31 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 12:19:31 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Sep
 2021 12:19:30 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Sep 2021 12:19:27 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v5 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Thu, 16 Sep 2021 17:48:51 +0530
Message-ID: <1631794731-15226-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <1631794731-15226-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3612e7b3-2fac-4d62-2c89-08d9790c3cda
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2472:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB247285B44B032864FDA1D121C0DC9@DM5PR1201MB2472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FY26hjybZjeTNACvTq2LHtWncJnperIw5xLWttrkHDkj+PoNq3Yz2flfB3FjvlMH06amwJX7bSIJo4SU9I8Ato1u23a7zWoWq+TtHwsbRzjZC22Ia+mTLXPsWV5oOCHrbfLA8BHEL6QOvcr3WNPN+oqOyk8zDiHiyTrz5FB8FVQyjCmQzvkCQhMEB2AozfoeKECSXPk3AIiKGFbZ269Itq1U/JQEO0zP+iEVmH6gN7NmefFgTh8vhhhpkp0yEwrpQ1hmB2+lFn3XPuTIoW1wpf+qKY1PNH7dJsvJIVhFpt271wGAj7nLLxmpOz31rVmfB8B0e8kgQT6zDNIOr2ik/TazGkC2g0uspJ26m4AfRkWDdXGhExmNp/XpdbEHvbIfeelUU6heutjscyKhnIxpKQVJc7Qe1BiDVkx6s/vl2b3l7qJHN1OmUhWPGGuCwszKY8RACe1jRs6bJXDpkyhUsOYA7V9ZBH+6jgoAa8dnTwz9aYY5EFOS+MRyM4BkRse9zYH0MyZfucT/GSlOXHMnrah3V2KdgO4iqsKSan0fnrSueWDpAJJyhxxoARFzAnUjDzlIuQYN0tPkeZC3VlVOjXvcU97+R0NySGipAA2Ea5QoyluRQyYqL1gnuW0rRvqo84MTkJwcqHSEttfBGZQlNwB/w1z71XbaUV2uK91qDZlpsqjQGi9Bxzlcym+AXnssAS3u8nrHcH/LbYNBqXncBw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(26005)(6666004)(6200100001)(186003)(47076005)(82310400003)(4326008)(6862004)(36756003)(5660300002)(7049001)(2906002)(356005)(7696005)(2616005)(7636003)(70206006)(83380400001)(478600001)(70586007)(426003)(82740400003)(336012)(54906003)(36906005)(36860700001)(316002)(37006003)(8676002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:19:31.6046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3612e7b3-2fac-4d62-2c89-08d9790c3cda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device tree node for GPCDMA controller on Tegra186 target
and Tegra194 target.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  4 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi       | 44 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  4 +++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 44 ++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index fcd71bf..71dd10e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -56,6 +56,10 @@
 		};
 	};
 
+	dma@2600000 {
+		status = "okay";
+	};
+
 	memory-controller@2c00000 {
 		status = "okay";
 	};
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index d02f6bf..efa6945 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -73,6 +73,50 @@
 		snps,rxpbl = <8>;
 	};
 
+	gpcdma: dma@2600000 {
+			compatible = "nvidia,tegra186-gpcdma";
+			reg = <0x2600000 0x210000>;
+			resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts =	<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 	aconnect@2900000 {
 		compatible = "nvidia,tegra186-aconnect",
 			     "nvidia,tegra210-aconnect";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 7e7b0eb..2d4ead1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -49,6 +49,10 @@
 			};
 		};
 
+		dma@2600000 {
+			status = "okay";
+		};
+
 		memory-controller@2c00000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index b7d5328..e100606 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -72,6 +72,50 @@
 			snps,rxpbl = <8>;
 		};
 
+	gpcdma: dma@2600000 {
+			compatible = "nvidia,tegra194-gpcdma";
+			reg = <0x2600000 0x210000>;
+			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts =	<GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
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

