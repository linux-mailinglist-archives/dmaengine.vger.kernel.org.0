Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E536840FA09
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 16:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhIQOOG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 10:14:06 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:60160
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242733AbhIQOOD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 10:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9MjCxGSi3kQ364AxOjlSMcAVQSCwM+gxwIJ1h0a+kZn0SP0jibZMsTNYA7Ja4cOSBZEENyi4AfhZWm8kfE/tTieUnUETGRBLpGnC2DdjlBg/4JcVCEm1RAaaUMDf+0SKRG60SYdqDm4Pg74OafWs2ITvjI8jPBR/6apy0qGoHGFo4eLgMN+A4twZYgpwc2Yx42kg9vgylis/Ck/LNpSdoB6xqEbx+7wiODQyQCSiZsNpRMXn0lh5Mrk1DWPpJTlpaJO4knGGeep4wDt/twMAVNc47KioJKIp2MzvGzSU7WVAhTy3Cam6BAN1NQ1xXpjDYIOEbgshEJTF000D0igrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3J1tAZk7DhIvhVQ3FthKnBJ7f38K82GmmmDqVy3jA9E=;
 b=QVbtAY+RQNjW0YTu3q8McM+4A9cVgxYpXJS6zI84D7jxG5miC6KZeGGqToEYgi/0Te3vXAKlR9wZeF2oPWXhVu8ug8tJ7EreHiUno0DCoQRp5760/xt6QaGxDeosM08AysAPhJXBW5eZ1oDLVMtvnHQlTGW4EIWhZN3tMqFJiY/mAK6P2kMYfUzSGkCsLHXPHVCF8ib5qww3hg5uc++1RfIxsSL09Fmg5I3iDiQNVtz4gm6YYKeshLTtWjXi9UlAzFODqfKX4KbhcL9vy5vu9grOzHcUJ6EEXoypmNIUXuEUKO/hWYICHWHLriqOQ0ABgetbGZV54C3idYGvbAn/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J1tAZk7DhIvhVQ3FthKnBJ7f38K82GmmmDqVy3jA9E=;
 b=C8Fbu42gk0mRFPH6l9wNEd09NtxlOgQIF6wF5ubE8A7VpqQmUb1lp8Ka/23hqJXvke/pd5AjSwxp8mvZo2X0kDbAPVXmiNPSjwJ3GeQuc0zZPGnB5tjV/iUfRE22EDLY0WbUAh3QgDCdLZ8V3j16BAKXEewXTYDGFEN3/QooBYxgPZiyq8cL6QAV+HJoTJ7fC9RkAGRoLYoVn/gdwtHggyM0pjWpZB5HJ9sQ8+Kx/LWVEgJjDFRGjj5s5dOnm47kGxzXcQILdll3xs/Mhg0aVdfphxFNuWtWzIJ+eaZvalCCkQGIzxPpYsrRfg5qSeyQanhXKh0l57JQSoNbbe0Wrw==
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by DM5PR12MB1898.namprd12.prod.outlook.com (2603:10b6:3:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 14:12:38 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::f1) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend
 Transport; Fri, 17 Sep 2021 14:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 14:12:38 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 07:12:37 -0700
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Sep 2021 07:12:34 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v6 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Fri, 17 Sep 2021 19:41:27 +0530
Message-ID: <1631887887-18967-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
References: <1631887887-18967-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff24ac67-843d-4014-bf56-08d979e5346e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1898:
X-Microsoft-Antispam-PRVS: <DM5PR12MB189845268C71F22425755E3BC0DD9@DM5PR12MB1898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6m9ophROBrkHr3v3jZ2Mzx9XekNBxRUpDeiujiy3kaK/VZZWWMi5ea1Q+P31mnd4Pze9VXwRL7vIdSlQcqZAoNvwM3wROVlVKeFWPw4BwNoUlYxcucvkEMzzR5WpXInxFC6JG7vyx1nJAs+LtKBCG7/WfIBnizq6PaQDIZh1eCAQdHwzzstHNuJ9AOfrLaN6PtdR0acTnR6t7v865JJX+MozqM1DS6mn6FTd/hLuBhCOU/jySRN9oMJ2xuMR7S1/EyrYDtNEDV0f7otjV9gT3DjJjHz63Bw1cxZ/pfE49Bs302dF+Hd6TRbsGGWi0wgxfWwTpXODLqKemVolYFqqnWYYWQCowHT9sz+5U/q3V495kmMHV2EmuWmpKBNxJi5VpwiHMLDhS/93dDqdKPk6k3p3lzus6qEGalpMHiIS9idQZ3T3Eh/XByOz4/+Tip4m4v+E5YtitUTWn8xK/xHLzDuiyKZb5SiSOrYeFZyd3R1E/IOOoSzMzZg6z//VWY1pkrgiw9KpNRVpWjuT58Wsagn2wsed2yBToVKyyBxOHG0FYoMagQYZEmP5qBSdrJYMr2NgfInbpapNxtHdL7wW8lNoa4v/vSG0cpaCyrRMqXUZBn2+wF9rT+Ao5JGSNq3Wpwjwu2KpAIieBLysyNHiImJGbNXWKxOZuMU6kYSlgHbPwYWunGoTluiPyjeFfa1OMDwLQfruNbQgDdMvulbGw==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(6862004)(356005)(316002)(2906002)(86362001)(83380400001)(7696005)(82310400003)(2616005)(70206006)(70586007)(7049001)(36860700001)(426003)(336012)(8936002)(8676002)(508600001)(6666004)(26005)(37006003)(5660300002)(6200100001)(7636003)(36756003)(4326008)(186003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:12:38.1801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff24ac67-843d-4014-bf56-08d979e5346e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1898
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
index d02f6bf..3f9c4c4 100644
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
index b7d5328..3ce4b8d 100644
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

