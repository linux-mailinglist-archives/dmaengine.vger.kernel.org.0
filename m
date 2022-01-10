Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603C8489D20
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 17:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiAJQGa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 11:06:30 -0500
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:64032
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236997AbiAJQGU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jan 2022 11:06:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7mvaF7Ow17sPj33w0eTpRHsB2afB4lzYcuzatDDiEwF9zDnqdznWx7zBeSHE22/hxQUdfTFKQGe//rCBskIoFY3U23ZrmEGKO//GHIrcYuHMk/M9nCFbfHOaB8Os1u4o68lzet9RlTxD4IQKYNFjSSGpASShg1HCqIdXzHHsfyir3A9IHye+EklMMLD+bYIK0Wvi/oDuCRA9KgFt6RUeSOuNpTjSWxX+rgtMITGTae/31nlUSZd4yydI4rjqwl82C9IQ4bLVQc6bp+zgXYx2AXWyBxxeyACy2rZUyqZZRBjpAeUgbAnQKg8dQ40Us6BeTMt/4SlK5ZezMBBKAvf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzh1nLibA+eO0657eOj/R3cg5dm3JVUR3NWfL5k6iL8=;
 b=fS3HLikvwoYDL0PTO4BGTgKH2IRs65XRtlyOBxCFq53GA5xJUzUzzVVxK8mB3RybcSReBF8VZAMXVNeuChkkSafCi6lK48wtDUQ6SbuIMPDSsfcLLw03RWqSBkY8fncKXAeIT6rgVV+qiu5EHcbxgsf5EeEHDO9ppZwAEJ/J7bbOTKp+tSSW1yK9S1wRuWmDpzilWShgTnRhN9khFaCo0bJ5pdjucEcZyRIzWCUP+2GmIUFW4+9KO1jZS/ZhgGGlPh1TgapTi8VOHtMTFwBp9WxaPhEjV8hXZaUEmu2TBvREta7EBkh6Pepj1vqHANkFLUXXOlWLnenBFG7Zpnjspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzh1nLibA+eO0657eOj/R3cg5dm3JVUR3NWfL5k6iL8=;
 b=BTURLTfq7OKYNKTkVymcr34oAyNJfgiAKbtVPPtW7WkABrEJWiQ6MYiMq6NFDqxhtO3bbR3LcOWKNaLOOIav1X6z3e7CZ1jo9eL2OKZCumGqtXzTQR0YZ1Xg+NhJHJD016jKAxelq2qhebe/1RTlj7ynBbvnkFZITGj0ZI4lmChMtSKgyh0V2hBvhagCF3tpNTSwWDFCzLJ+mnoZa1iTIXFlhpsAM50wqE9TzJKSYTZh4fEdjm9P3m/b8MoPqgsRwAKesOyixmQKprxHKj0tv1XTHuNH4RTW85CADSInl+93Sv8I/7b8biLcWNXhRbF4inEaoo8WfuhjGzZCFiO4eA==
Received: from BN9PR03CA0464.namprd03.prod.outlook.com (2603:10b6:408:139::19)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 16:06:17 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::6d) by BN9PR03CA0464.outlook.office365.com
 (2603:10b6:408:139::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 16:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 16:06:17 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 16:06:16 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 08:06:16 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 10 Jan 2022 16:06:12 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v16 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Mon, 10 Jan 2022 21:35:18 +0530
Message-ID: <1641830718-23650-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1921bd7-0836-4ec1-0ff4-08d9d4532285
X-MS-TrafficTypeDiagnostic: MN2PR12MB4551:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4551990F261D5DFBB1A853B7C0509@MN2PR12MB4551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mn0KAHIqA3TI5wJiOkiZMXSwI1aIQESR5+lZJh0GHl7k0myOdA/bW8/2cnLugBmQttj+qcZNTKagUqLkn3i6oOWVYaYhppGsvXHgdADs7RyNQ300rU9Gk4xDY6dmCft+IxRVa76HLAePvghbsASQxI2NUkNgoqihf1evJ7NHHpIAwAwkR738PjthS7BW1B3+JfxCKHRPDMA3hp9boxGCLBTz0bkgdo/2gk9kpcbSuLiRuzJlaWGgGfmKlY++cN1vy9v4xkD5JEFeWwHXsmuz0GHHAJ5VH6aohzU+2jGLQxN+rMrLjZFdkgSrjtYXIcBHUmiFF3j9Ab4AwVIdrFmEc8jSupQUAvXBXlEqgOEVT5EtoUE8iY6y+p5UwsPq/EKpi5iaE4uhhqxUp2n4LHYKgbKEFmDPBt8y7UD8R3H0cHLdhAhXIDwdl8BrV7HjPrWsum3Xx7BSQAxMQAqXl1EPlOAKnx/2XlPI7WxTwWnNnE8WcaR4tL36rvK37KcuHq3KPU7NOs74nq0bbAvEmEnTGqQtHtR+0WiqkAQ7xAoijw7XHGz+w01RfxbL02L1/5ihiusK853NFmmRk+JIIwzMpIG3NeNWMgg1PkzaUjPJjVnPMeHfqvqjPwssi1+qQtm14JssayjYm7fTiQxdyiGE3aawT2QOBv6dKkkztNJ+usBwzqqu2etNJ3qK+Fkxtz1rGY81OtGqfAUZ3zWiSWYIfDD9Rcr77xc36G3nFOFq2hvwwsb8ggMlwrsCTpaq6hpK/Zu0uRtiIU6x1BYSTcPscMtPosRzd1AxLp9xaWE/pk9+3tOBKaYJIlC9RpgRwcWUmVsLLe7fygbnBrKx14L7imeZ6ExY6T5chuhl7lUFNVM=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(70586007)(4326008)(921005)(2616005)(7696005)(47076005)(70206006)(36860700001)(2906002)(508600001)(316002)(186003)(26005)(86362001)(107886003)(81166007)(356005)(82310400004)(8936002)(8676002)(40460700001)(5660300002)(336012)(426003)(110136005)(36756003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 16:06:17.4436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1921bd7-0836-4ec1-0ff4-08d9d4532285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
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
index c91afff..6bec977 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -73,6 +73,48 @@
 		snps,rxpbl = <8>;
 	};
 
+	dma-controller@2600000 {
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
index 3c4acfc..491a02f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -115,6 +115,49 @@
 			snps,rxpbl = <8>;
 		};
 
+		dma-controller@2600000 {
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

