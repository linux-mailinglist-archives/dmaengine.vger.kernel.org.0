Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA4F403BA5
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351951AbhIHOer (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 10:34:47 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:61505
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351948AbhIHOen (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 10:34:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkQuJPTBy5Wz2hD7YXGQYfhBejrlT4N9oAyVn8/4uG10xNpDX2btaGiqvTx5lyCjEk91zBnvWYKcRkdOXxP/95FEoRlfjXAOCJdM+VORjJOSrT0PKovciJD4v+42YsoYqbXFVh5Ex9TMt+DFijZO01fI8SBJQaCNI+0b2nqmEDCQfgDY8bI7IXN8isgqqg6D6CAoKYBdKIjW4IiSQ/UNExoXxBVmciJXV7U5iZn/egujjoii22BgyZOM1pwoWlJI/mntfSHvIfBBGVHUEBXqfNCX6242GmIFx8i3Qmx1Ysk5QPcJET99izOhJaZRTm0W8G39Q+pSwVOOLGQoJBYl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YEMh7l+K0YZkxvgzpcdhd1JtL3ir8C5TthBS5DNxUmU=;
 b=jTUpIqMf3SqlczIo1V3RP6j0H+bji5RSQJ40cu1Cbj5rxjtykMNLqbMkY8ONUiN8QS12144oIAVSPH2gsbRN1PEJSZePdguUcRezTdsQ9xMKK4lDsKOEsP7XRn3YfGGCAd10th4EUQ22gX97KR8boRFwhG21W/sZwfYBKRAh3wHM5lSpgmgItLtxTAfHzq7jfqjaXI3TbzAYdTOKcIL0HlbPPTG1pcgyrZXzDMHbe/ZTiU38OpMoKTJY+Qnly1o2DJFbZa/0+KEk1iFd0VBEYU3cU9se39hDnWV4dDlORVn9uSHx4vW2KfI0xG8edGVnVPgnLcIVyWB2qyQ5DovVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEMh7l+K0YZkxvgzpcdhd1JtL3ir8C5TthBS5DNxUmU=;
 b=gLOrqabMNk2nw/y1i6cL7H7K+2bJLWnb2C2Wdb3x6rzfdayhyUTC1/hZfBQprT3BWAFq6PpvmUprB6hEaGrTU77hJC+bhWWMM387tMnfK3GEySmj26a5Q0cxW2FiKTQ2oHSxJIipp544bBIOcJkPQ/Gpo7o/GEIi0X0Gwet5emH6Ozzkgxc2ymKDzYQ/6mymDZIrMh9XORmZo8zxIqtAk8gDqDWNV6m3uPaeFEjTj/2gdP2MGDe0V6+9FwTii8rPc0D7rgJiuRdnukaAXVfDfzPgB8oAiHjOKB+hcOG5y7vJj+YhrZCcBZaCsS+5fwCfKSq8ZReWMr8kElo9b6OMYQ==
Received: from MWHPR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:301:15::20) by MN2PR12MB3024.namprd12.prod.outlook.com
 (2603:10b6:208:cb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 14:33:34 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::4a) by MWHPR2001CA0010.outlook.office365.com
 (2603:10b6:301:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:33:32 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 14:33:31 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 14:33:28 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v4 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Wed, 8 Sep 2021 20:02:18 +0530
Message-ID: <1631111538-31467-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9463728-229f-49d7-6eb1-08d972d5a234
X-MS-TrafficTypeDiagnostic: MN2PR12MB3024:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30241DC0C61E21A5268BD6FDC0D49@MN2PR12MB3024.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmUzkotlXlomzmvgZbkeRlNBUe769Pp/eYlFV8CqElpedxhO/tViqkbKaP0Mc8aNK1dJeehk884tCBTCpcrzPEKOtHiQtVTfHLiTVoE3vm0RZRW92F1ambSUsZ9IMcbfOOwPCaKTgMKVVdf6wSTxdPw8B+Xe+fkQ75QmnWvOiW7AAPxlG0CR25cByWeNVXHH46yRAeCjTeNvIpkQwWEF0L2nuSN0eyUvEIAlD5PHz6kOaph1v/t1CUzkNYUIFwRYUp6Yfbe4a4tgkbGTziedGeP1DZ4m8gEOG1H+a/sltERjBX1zP3BJk5haLHkN1Aw/47NOCVlnGdvOAD6cEZj44DqWwMaQ4p9T7pKEEB/HzJmXDSOdwY9nbM5f8lFC//jZ14pHkJPu2pPdU/zTPz/Ox+7gATe+srItoajz+A++/q+Xe87HUZG8++FkFiGuavwNFmhZBZV6Y9d3PMrMqUAJH+MBdCwnQkNBNhJLmI9EYF0I7jLCebQtIClAcSqUX3SenyWIjzPXVrBP9wCLMphbpeMmyeJPEd7Qa3de/YEFdcPIdjlyz3r7YPu61m6/ckfs/k/CWHkoIK88vakUUTaaD1T/eMvK3qcH3KT6fR6ivsMtPqv1UZSrJowR/1YfelNtR64sV6pJmXvDBQnClWKiFzZuzIt1zmjofc3eCkVj3cfJSAZ+avSpI3olSq1khDbkDcdYfrSiM93Z+brm1ruREiEy034F9MZtuySVyjoTvwQ=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(36860700001)(2906002)(36756003)(356005)(37006003)(7696005)(81166007)(86362001)(82310400003)(6666004)(8676002)(70586007)(6862004)(26005)(4326008)(47076005)(82740400003)(7049001)(5660300002)(186003)(336012)(478600001)(316002)(2616005)(426003)(8936002)(70206006)(83380400001)(6200100001)(54906003)(36906005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:33:32.3462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9463728-229f-49d7-6eb1-08d972d5a234
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device tree node for GPCDMA controller on Tegra186 target
and Tegra194 target.

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  4 +++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi       | 46 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 46 ++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

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
index d02f6bf..f68291c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -73,6 +73,52 @@
 		snps,rxpbl = <8>;
 	};
 
+	gpcdma: dma@2600000 {
+			compatible = "nvidia,tegra186-gpcdma";
+			reg = <0x2600000 0x210000>;
+			resets = <&bpmp TEGRA186_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
+			dma-coherent;
+			nvidia,start-dma-channel-index = <1>;
+			dma-channels = <31>;
+			status = "disabled";
+		};
+
 	aconnect@2900000 {
 		compatible = "nvidia,tegra186-aconnect",
 			     "nvidia,tegra210-aconnect";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index b7d5328..bc85c91 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -72,6 +72,52 @@
 			snps,rxpbl = <8>;
 		};
 
+	gpcdma: dma@2600000 {
+			compatible = "nvidia,tegra194-gpcdma";
+			reg = <0x2600000 0x210000>;
+			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+
+			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
+			dma-coherent;
+
+			status = "disabled";
+		};
+
 		aconnect@2900000 {
 			compatible = "nvidia,tegra194-aconnect",
 				     "nvidia,tegra210-aconnect";
-- 
2.7.4

