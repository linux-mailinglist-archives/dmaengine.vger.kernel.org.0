Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0065F3F944B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Aug 2021 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbhH0GG1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Aug 2021 02:06:27 -0400
Received: from mail-mw2nam08on2055.outbound.protection.outlook.com ([40.107.101.55]:59745
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244293AbhH0GG1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Aug 2021 02:06:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpeitRKwv/IhbFoX5zuz1xd6pY78n48MM0p1e6bbGAreuGKG/RCmTGMyHHuHl/rMHW6eIK6a0Qo2G8BwfZmAgUwNesA84QbwN45RtTRRnzU52dZMS+aViHsIunUCOJmVcJjc+JqO9BOK6OV6tnW8KLOHBS4mrpdANOW66wM3SHori052yn1Bq3l73SReyn7M5yGtlXLbZkhYjdbYnLh0uv3jzuoBA2c8T3pgnAYbGn92Kp4w6zL6k09sMXwF2Qo0uqKA83QhWsS7q9Y+Uf1JL0+X7PimZK8n0GpKcImBbmnQmfOV+0R5uMtsOKcpztlqh8KhadrnUue4fcw2FqNg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibptzu+sT+PkghrqkdFgc+gwermjkvNwrlArLUVyJ3c=;
 b=lidwV7Vt3+4oP+tB/KV/8w+rkYXI454sAJVG+S9gRpvc3HkvAxx8zOiStsZa6IwoHvAEEXKf6aUSpM9fkC62L7iqCoMN6yCVygdpvPxMRpxa7jWal/lWRCUzu2w4H1QBcX0W/aQyrwxGouM0vwtKJtJKrGM6xh8j+PUDEzT2gzerXXOSDp4YE0DBFW43Zmd54LxQ9M1ApZqCNvUeDSGSpOQVSO+2ggrr3yfyjwX8K7hVCh3KdWsCylGDQ3l//fBRpHAmBiJRmpIsr5Y1FhFmrQ1vaXJ3iu2N+uK8Xt6IMfFy8/zz1mHYYOxGAZegxFo9Zw/Ej51GUkSbLmxn+6wdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibptzu+sT+PkghrqkdFgc+gwermjkvNwrlArLUVyJ3c=;
 b=SMN0nb81ks3XkZ5FhHgSfEd3/6Z+zfYCRzDCnrYI13X8DMHahQYQt5MO2jY/NaEgov4DD+SZGZ76iZUW8plv7Eqf0djzplDH29dZ3xUJ/LYdwEdRgWVo48nyJ/rIa/4W5wCnuYlhbm6XGQdNpDwYGIC+dA+AHC+mcouXCUvDkF62LlTsNDqhL0+RKiPbTPvxpa4woUGZTn97DLFs0oJ3TdiZZMzZA30a5Np2H44kS3W+Bt0KfJoBAqA/X7buVfmi2kx0UUbASjgecnbXRaty/f2MNSkOMwv5oczl5YWRP05h9CGOWH2xTRpfYrxKP6oHHp11PZv5DVT/rjvs3o88pQ==
Received: from BN8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:408:c0::20)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Fri, 27 Aug
 2021 06:05:34 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::fb) by BN8PR15CA0007.outlook.office365.com
 (2603:10b6:408:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 06:05:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Aug
 2021 06:05:33 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Aug
 2021 06:05:33 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Aug 2021 06:05:29 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <rgumasta@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Fri, 27 Aug 2021 11:34:54 +0530
Message-ID: <1630044294-21169-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
References: <MN2PR12MB41438B94148A6D522C056771A2A70@MN2PR12MB4143.namprd12.prod.outlook.com>
 <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 967effe5-35fd-4b79-85e6-08d96920aec3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4565:
X-Microsoft-Antispam-PRVS: <MN2PR12MB456529A90651979FE88B2FEDC0C89@MN2PR12MB4565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qc+/9rHRY9DkMaT6Fi1MuVtj+q/L/gyQKyT5Rmx30Z56qzTENW/SB+UubddFH3QFpgf6XUb1QUlsQDM3KeJIexsO5F3tpsPjj2pGS0s5s+StqPoa7F8wF2ytItECOAoH7RDY/TxUtha3/J2CMS3qXWyrRwaa3cdy3mzk+oTe3i+SyQShB3W42h8gcySVwY+mmyvjXauNhCHBIBEKovSxGcJYpMhpE6oUHWXeYN4f7/c1IY6gcpeXXQ80fqKi+skIhRo2O1/5jEF8V44cEZ0/hg47EYbs8EX5449/xqX0/M2x3EoTJK57WLL5JTKkI3cNb1nrodqXm+PD2TiYWKY36UdJLnd+1nBAz2DbwfH3Bq+AopLt7Jf5AG3BfLGja2rLGK7no4bntsig5O0cjQK7eQ0Mo3aHcbeZsmvLQjwAKeA5+RBpDxy0qP5OgRUkSK7ooI4HztZ0oDTuW7OO2MAOa+215ni8T6sOHM9GFHlhQl+yPdzlSgUhWFhHWVnkYOGDT0z9D774ayQQ2SnzhP+oLYYBf4beHCLdhfIq1LtrVyjC3sBjaHfGWiDkpV01h2YVOn0INT+HfisUXASzwpmQy/so4XH5v75MhWqB4X7sJaYCfVUaCKfM/xVBtyYFcaQN0fGBX39sEvY6iE3jYgqI5n4nnFVvFQhz6uh4nEGfBqpKkklffgVXtKV/ac+oaRZA2ybmUoTXYMGyGQrf0lVV5w==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(8676002)(36860700001)(356005)(186003)(6636002)(82310400003)(4326008)(36906005)(8936002)(37006003)(508600001)(7696005)(7636003)(83380400001)(107886003)(426003)(2906002)(316002)(6666004)(36756003)(54906003)(2616005)(5660300002)(70586007)(6862004)(70206006)(26005)(86362001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 06:05:33.9846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967effe5-35fd-4b79-85e6-08d96920aec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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
index d02f6bf..9b565155 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -73,6 +73,52 @@
 		snps,rxpbl = <8>;
 	};
 
+	gpcdma: dma@2600000 {
+			compatible = "nvidia,tegra186-gpcdma";
+			reg = <0x0 0x2600000 0x0 0x210000>;
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

