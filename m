Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1844AF9E
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 15:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhKIOjl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 09:39:41 -0500
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:17281
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237689AbhKIOjk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Nov 2021 09:39:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIroTVa/uOEslXj/kja0wmfPrYPX7LYWcv0UtSwlGC3Pk2xW/kxbSFmdCdwFFFJNGi6cIP1+OYV0cijXF9uTzNqsKyirb13a4xhf4nzgO7hHiOGFmi8euWBbDPKFZXu7+IdbjcBToAliUabLDrjHIvY82TZE1c8KTjdjd9ZMnSRdCbkJxzsKlO/ztvUJW6Ne5QSaAuZtp6veIUlp2J+m9pL5kpI1rtZz83J0zLuuSijlFaGLb5x0TZG5kQGUkzTvay9Tv1ZMsvSnyaY4Jnu5pa8z5JeynCbpqipqgzcRxHIKPQitHpGMWC0+FWUXSpe3e0xTd3C616lOlCJiISIDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxUTRP1liNDyjHVFnt3LTW8J+Co3Z9glzukOc0gNp1A=;
 b=I6CbMqCS2cXcl+DX6B47Uu9rOmkv6c6oaPrKMBOUsIGo0UYJOXL27lEm2s+it7lxiR1V1eq1ntgNNpyQj/kw1E0nPv07GDVTtV/jh/Au4zU8qhDcCLI1yMrA5B0iOz/QicHKl8ATzFJ7R5gcOBBrXNoXoBpnMkF/MEqwpmAWrvjWsloU4wKOrvKQLPvhXFzYHGSxV6/MCjxk0QbTNmVQBlAza8n0HOTEXaO74V3etcMOwesvaWRGOAN0MhZW+kWl2Bj8Nbg7nRO3SnURWZSqFdQ0gD90PWxQ8nN/T759qin4n47VBio0L2yZSbJFO4GiUgtzBP5KnHSQ6O9iZylXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxUTRP1liNDyjHVFnt3LTW8J+Co3Z9glzukOc0gNp1A=;
 b=mf5lV7AwuHYUlV8C8kaav3Tkhrq1kDSxhxyQTZoMhRfCRfzJH2WSGSAqi1NiDb6pfJtj2RP0qYS7cG0ovV5r7vMgQpRd0neKoxh3jKoYu/mnf+fcfS5n8qK2/10V9R5V3kC5GaiZm5g7jin0O9lhU3H9Q6/2VBwKB9qHPkOQ6g0fZbquUuaiS9nxgH9iWz7S92D/+ZEFZWr1hcVyRtEGfDqecHFxOVzE92hTm992HbeCmjbEe0g7Y6QbikqDHQXOVu9oy7Wu3mr1k1oLeyb/TWXJl5aoPGdA7AppMnqLGcv4/ilyXBtEtXGLftQP0nRtjP0PHoGfHDUl4j+S11JqNA==
Received: from BN9PR03CA0372.namprd03.prod.outlook.com (2603:10b6:408:f7::17)
 by CY4PR12MB1127.namprd12.prod.outlook.com (2603:10b6:903:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 14:36:52 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::50) by BN9PR03CA0372.outlook.office365.com
 (2603:10b6:408:f7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Tue, 9 Nov 2021 14:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 14:36:51 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 9 Nov
 2021 14:36:50 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 9 Nov 2021 14:36:46 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v12 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Tue, 9 Nov 2021 20:05:52 +0530
Message-ID: <1636468552-1120-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636468552-1120-1-git-send-email-akhilrajeev@nvidia.com>
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
 <1636468552-1120-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f2997d0-aa8c-4c25-34bb-08d9a38e5e76
X-MS-TrafficTypeDiagnostic: CY4PR12MB1127:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1127B2621B2A65A86E97BE44C0929@CY4PR12MB1127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBVlm+vwqjoN1jYYNX4TdMOpRXAqTYMWLbuIgc+87n7eHCPU1AoVFWGPPWIVGiH0eS0cjNaccQbnT2BXeJfJLkgmhnsS9oxNdHm+lISV5eew0RawXC2ENCo9Pek4cCgfXTVIkYacIfY4i0hrNv9++HgM1BwQUhA9OOP/1Rw0tpSpT/zJ+bB/ypU8umyaKg4vffo1LwMDop+hRTSIKkvXtl3ULAG5FfdAAnNYHqEiDuYRehn2/MN7W+i93XJAY1PU89kOvtKGQOVoTt2uYWEI/XAG1bSf6PSlMVS2CLPCT877nAKfrmKdkLpvNluM5Xqwcs+3hKPJCmV+U5NpVAz07gz0j2/3H+DxkZo4/oVKsLbOg32RDtx7lQqY6JLn30PnfNP2EUBbCd5npmz3sg06nmZ1R0WjxsOA+ROaie3cW6S5ML55zrfVh17TUMNl0cJFdkpYl39dj6c64pWOuWC1S52DN0F5tqDkZPDrESd4eWyO4ncjq1hvvgNkd6KbuZWvljlV15qUCXjG373cnTN1IaEKtbpfgZ8xmdMzV5k7XJLkjOJMzOW/PFJ9Qp05kfTX86N3JSeTC9qNaCW3RsftVjYLKK0o1MkimHuVGBDDCgu+AXBEVNq4gdNe2AJwXTrQz7bEf+Bwnxhb6vCgdNPIrk9sj6RhsGRDef1KQTRz/xObmacLeSy5v6JgSC0yilSao0SNXGo/loEC2z8PjtqCUw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(26005)(426003)(8676002)(508600001)(2906002)(70586007)(70206006)(47076005)(7636003)(83380400001)(6666004)(186003)(4326008)(356005)(86362001)(36756003)(8936002)(2616005)(5660300002)(7049001)(6862004)(37006003)(6200100001)(336012)(82310400003)(54906003)(36906005)(316002)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 14:36:51.3605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2997d0-aa8c-4c25-34bb-08d9a38e5e76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1127
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
index e94f8ad..355d53c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -73,6 +73,50 @@
 		snps,rxpbl = <8>;
 	};
 
+	dma-controller@2600000 {
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
index c8250a3..94094f3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -72,6 +72,50 @@
 			snps,rxpbl = <8>;
 		};
 
+		dma-controller@2600000 {
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

