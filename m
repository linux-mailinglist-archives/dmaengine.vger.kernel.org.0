Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176644A30BF
	for <lists+dmaengine@lfdr.de>; Sat, 29 Jan 2022 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiA2Qnq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Jan 2022 11:43:46 -0500
Received: from mail-bn1nam07on2052.outbound.protection.outlook.com ([40.107.212.52]:2976
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352789AbiA2Qmj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 29 Jan 2022 11:42:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyiChtEY/70+7m1pMENFguPyOLunfsiE91v5WTHrFoZucCSJWuhcwM8pEShMRE5gAc/idXH/yoQW/2TOYqH/S9WJlZergCC5MTT1qDGySuDfEEbil0I2kvL9GuQka6EGok8YvJseelVqJkn80xM66bKEZBFK6lyX5nEqEjLxjmge1plZrLpOo7T0tLwiu+Eerd5TZrglc11376125n1xKjkQxUVLWVY4LfI3uWKttDZZaYN74VGOFiWe45R4mSQKG7mZotum2g1dUX2Qy/DPQPmBTmNospEtWwwucWNgpa0Imgn6u788uweh+lDCSwDUB5DDQqeyE3rXIBTuhbetSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3weae6E5nQBoB0LGDG/0vXVPrfai6CFzHIANdwm+U4I=;
 b=KV3j6OplgAUMuS1cMIJM0P0dLVDssegS9tWE7ME2uQL1nB7oAcIfNLTi+yY0KwRXiWXIKo3S2FFI+N8e2vN7Il33r0x+x5Blwqf/AEDfMGBjTswrsO2V75l0ganBcYQsv7l4pM2AP29KX/pZGmt6bkQa8Iq+M9CNnslniuTXZc5V8T1kt9YVZv5rUmrED9Co7kfCL918U7fb/4Zag1/6BIrJanDrB/QoJ3XzZmCn3CbmgMj0KsoHS1wqJjsqMyM0YzTsHb28ZFUCP9u2OqhK7of1aCg/O7UWVZMALu5+o4fQ8mha6XP8UtL5zdwFtldr+WARADH5qQS4k1O4wtNOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3weae6E5nQBoB0LGDG/0vXVPrfai6CFzHIANdwm+U4I=;
 b=t5Z0DnIl5+eIxH3UWmqN7R0Pbwo7j4XwqPt4O1H1rxaqGuhwSORAqFCzC05eyMu6I7juiMNqbKJseFkH/mRhFxiiOx94xWaV6PKXvGtIm58/Y4Qtxy0nRcTOhOsQAHB8LxDMh+CQQLNls+nfB0NCxQe8Yl4+zIDbi9wsb43JP36P1R+uIo0tvENrATJoTtKty46OWDvCXrsxxeJE87OLlgYS8IOWUDFwkQbbtjtosyNWHNA4NM347J4lza1ONh2G+CS0Fe2ZRqvPGK2odpMkB3RMi1GaU9UulSzIKsC1s1QIJRpQYx0Df+v2Onwnkfm02Vm0Oz8k0piYBrSoSc9dFQ==
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by CY4PR1201MB0166.namprd12.prod.outlook.com (2603:10b6:910:24::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Sat, 29 Jan
 2022 16:42:34 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::63) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Sat, 29 Jan 2022 16:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Sat, 29 Jan 2022 16:42:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sat, 29 Jan 2022 16:42:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sat, 29 Jan 2022 08:42:31 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 29 Jan 2022 08:42:28 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v17 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Sat, 29 Jan 2022 22:10:53 +0530
Message-ID: <1643474453-32619-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8bedc09-f11f-44fc-2967-08d9e3465994
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0166:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01666C44F78445148B5911BFC0239@CY4PR1201MB0166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzuNVaNjZLhMhztmehKmhaJXpgw3h3XIvNd2fThquN96g1cJv9k1e4Oa/4giaE55rNWXYJysp34rJYSQOuhhZLQNXZMC83l2iB+jcZfwxDWepgleuLrAqh6eI2e8C0X7P/NwNTCXt2CzPa4bFayBhrj86uxF/8+wHmsoOKJ1sgQclBU+UkEk4EcWiEsoNorw1iH4RBsqa5S/dqxOwbfBTKdRgve1cQnj0DZ5xntvkrma/V9famPwUfSmmVa6eDX9ddIAZJnj4FnY4m4wvtf6rnXAa/JiU1QIBCqfQFWABpvCYEf/HEqA/7Wejn3xhqjuFSz7Mty/WvLkmFQu21ZArYi/TIwMsOAnVLeU82znM3GiBcFqA6W7TW73FAEdpW8Q5ZinKCKfhmPye9vQofkOoIJDfWmT21961+ea3H53HsecLBVUJyaMFyu5NSkJUrL+X0RAG7eXF0rD2ZfC9XpCVcXsaiAT/aGgRKBCek8+5uZWgT9TjfTeH59qfxAnJzbEj2z5qDByZGlBwXUSE07VffNGEv+CXuo+mtXv1b+50Nx6O4RbMelxwYn/yIFb4pDXvpgbPT2Ztt6Rcw102OcCRCbzcuWTEtJoCIbDDRJozNSUxViDQZJc7ldNBJdN96707lDX9sFXj6AtcSVSG/CmKAJq/kx8+fAAL+EsL/MDUy7xXmuM6l+SjKMkoTMZN8NH5kq631WkcK7mrXSzhIMVxZjMTMLdOZUI6HA3xWJJJ6KHjI6KxEghh4s/0RRz8KZsNFWggLIx6JkCmTFHKlHrAQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(110136005)(508600001)(70206006)(70586007)(8936002)(8676002)(4326008)(5660300002)(81166007)(921005)(316002)(356005)(36756003)(82310400004)(107886003)(7696005)(6666004)(36860700001)(2906002)(47076005)(426003)(2616005)(336012)(186003)(26005)(36900700001)(2101003)(83996005)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 16:42:33.7858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bedc09-f11f-44fc-2967-08d9e3465994
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0166
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
index 2d48c37..196d680 100644
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

