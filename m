Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D14198A0
	for <lists+dmaengine@lfdr.de>; Mon, 27 Sep 2021 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhI0QNj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Sep 2021 12:13:39 -0400
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com ([40.107.243.58]:37281
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235437AbhI0QNd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Sep 2021 12:13:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KENJkIPGXbYMEDN6hezoDjtY2NIlqq/tD5F8wbu+p6fT1rzdjbE2dSU8cSjLUBeCxqLWyZnX5mtGw//EBOg+Zz0AqXiBto5ynFC6FX0DEcER2PE3xjBNl0fNF7/5kYUBd0Ts/9V8liaWhFAKMWRP6hyti8ap66cbJyuqm4rzWM65y0JAvEXogF7DrWHyFNajk6wJXaBBYLT4cmYK2+3MxC7Sb/S8T4h7zSDLInDg83aXhNbKOrneA/UsHr7OBKZHeVFQnHn4eoDCYn/vsqMIzW/0XcHzpNgzivCap3QaA0QYlF5w0GSIP8voqEK/4Clrsrk9IlPcccjgRbmZHXcu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=02/hce3cEnMsivdD0TrYo6gczOKsWBv/Tix4D5wRJT8=;
 b=bsVKFkkviqZK5e4HtFPPP5qq6NgphmN524thz0VLUYmMQHn/1aQ5NUH6e+G7sj2PS0JMvlN7ynIiX4hsdlSH+KWpQkNrg2VsUy9bkXH8IoIWFl27vNvUc34u3H7lq9BG9SqYO8qZVRACPQ4wHuRbRb66V+xclr2gOlbXbVywG9L51wSrt+TnCT0GC3JnR+oAPtZQxqe+6khL8zj2E/2QibAAquEDzAOP3R0v1R2vVpq2S38wwuOut7yBmNhvNvEt3EPnLaqT3zOgfGWnF0XUS1ECpC9uKYDgVm20UqtQ3V0zDdPXrLy0rwuYhteOX9R2jVFyoaxyfLWjK1GS3+6KQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02/hce3cEnMsivdD0TrYo6gczOKsWBv/Tix4D5wRJT8=;
 b=P8jixughIfq5mTVnNRfBwIxUR53BV3hZo368NS5W3+y399dXlGcuOHJvzL6+zxdS5xOnxnNx5zv0klKZbbdDojnyp+GiuHvdyuqbwHkKw9LcIAnO87esFUQP/mhBfZxazFN/nl8wuk0BQGS9ogi7M8MzE36QOF89N/PUMoTieULjkLMPWrG6h8ySSi8XCyGqjDNWrJrIkRS7lcabI5Z7l9w4U32RxJTJQhuYDAkAhpBfX8BbX4GxGkGZPg0L4r2/Xv29uJs2keYCNFChvRvnXJKvDy3tlr/ArBSo7A8zges5AWsim8TkIuU/HDgThv0R5tA2ePsxqnfuv+ZSVMFIyw==
Received: from DM3PR03CA0019.namprd03.prod.outlook.com (2603:10b6:0:50::29) by
 BN6PR12MB1234.namprd12.prod.outlook.com (2603:10b6:404:1b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Mon, 27 Sep 2021 16:11:53 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::7b) by DM3PR03CA0019.outlook.office365.com
 (2603:10b6:0:50::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Mon, 27 Sep 2021 16:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 16:11:53 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep
 2021 16:11:52 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 27 Sep 2021 16:11:49 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
Subject: [PATCH v8 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Mon, 27 Sep 2021 21:41:30 +0530
Message-ID: <1632759090-7965-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
References: <1632759090-7965-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cee38ff-016c-4e4a-9e88-08d981d1855d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1234:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1234AED659800CAE61C9D825C0A79@BN6PR12MB1234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkRvglmAzbgXoqNLpxy9Fbh2yCb0fK5e1hjnVsmpNIJz7bUKglFVnSiMpw2aCjV8zwmw5vFvwTuao2CIhHl8HU2Sb3A6u1V9GfLddqiUiL286k/dyH1K/zBoFlh3xYfe31yPgGM5myHtXbumUIxUxPGBs9uN9xgs5p1nsyIgy7z4PZCSH8zOnbyaXE+vr/ldxjZoJdETq92xpr3QRI08gwEvfjZKaBRg/e9Yux47j4y7tEU41X+Uj5DWRrw2EvUOoNfONXrfXxXsmHGy5tcSoKtDP9GySgdhoK/LM1E6SpPhkP04X6Ju8VTgYpUIfe0HXqbkZEgDKIu5oXKhTt/sutVabS21R/Yv58SRrO8sGekgRU5X8W/z2cqdzlSHzP3D3Kd0vZSHN+gnjqYi+D6zaW9WPWNmz0x77YpvkU5iUh6ZanlsdbhR93jWLKwUNGtvpG6EZzAinKjHqlavfGrE5YWGOjui0bxJQ5HjFOmHuyu3oVwu4X3kdWzYHee+8Sgr5bIK1tJ6j5ukwVdseF5D4Qlde8FNHQcb7eHYwafRSbyQOshRvYrf9PmwSSz3cWJEIaFLP+NE1d90rmup646ygGlXKzXqRX7gQIkN8UTlL+8CevOB5wJ2tx/gWMMgX/q4rRrSz5blQi5iLJtMwZDPOSlUONhWdzWlTxkvgUaVXEnAT7nPMq6czz6CzWKUU0sDebCfF4MyDxY1lknWIQdULg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(2906002)(4326008)(356005)(36860700001)(8936002)(37006003)(6862004)(426003)(36756003)(7636003)(336012)(26005)(83380400001)(36906005)(6200100001)(2616005)(82310400003)(5660300002)(186003)(7696005)(54906003)(508600001)(70206006)(8676002)(70586007)(316002)(47076005)(7049001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 16:11:53.4139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cee38ff-016c-4e4a-9e88-08d981d1855d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1234
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

