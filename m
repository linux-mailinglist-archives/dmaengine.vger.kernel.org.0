Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D69477A1D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Dec 2021 18:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbhLPRNL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Dec 2021 12:13:11 -0500
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:13889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239701AbhLPRNK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Dec 2021 12:13:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWUdw9ga/t9uEqVqBua2tKxGKRPDFPBVh6wfwtYtaPRiMA5lBnCXzeTYbS+661vv9HFZpGFK+snzFgTZY7/RwiN1SOIipRr2M8pC2l2yMu0lPKmtuj6cyPte91V55bgR5QRbistv57oAQbXf+vHrK1WNh2eGINKUN14LqN/NdmSGu8hoZcC5S7XxskE1OxV25TTGJdoscK5rIFnhsg6acK/x9cTJfTPOp/7rLXnWaanjJJ361ADAhQDCM4bSS5ipPggjKAmcJ0PgZPa8VDw+Ochdpq4rs/DyWgYxqKECN7omoxjXwY6zB/U43UOX2qCH0D4UnYUrmZgiSQoWl70CmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yG6h2mf6+6UcHaHPEzCqvhVMa2u7KLd4Mo/HALfmBY=;
 b=fh7A8xf6+sYryeokmoOLNa+LXo/DjFJXdfkym7dHKFQNJQ7zJDMbEfuMfzb+j4XUQDoNdTtpSflrQPSJTshzndWb1vARsezAewQ5aOFKlsuin64XfIFvZ3QVhut0CplBZCjgRIG8Y98hdUpiLkJcV/IVfkMRfmtOOyIA8c4qXyXRbaVFrszWrgDYXGOnIjr08L0WfRRi7A2FOyEDEW4FeEPs31jRrnK1x1R/VaqWpUI2OjarhKl7RqH6bHQMUTe7GeOmlPR3Qo5oskQCRyewRerHeZ00g/qLupbuxfDwbDSC/6BUEgfDzLeVvqrOdLi84+2Ew4Rpi2ALEsJBv0z7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yG6h2mf6+6UcHaHPEzCqvhVMa2u7KLd4Mo/HALfmBY=;
 b=GcVc2DcPD0QE/sN4A+KajKwj9im+OeCknssS43nwsaq3CP6U6Lx82/zwXixV6pVSMLD4BmJmbf0EsBnOcTlpWVBwIkSMYM/DUxTIUEFh0yBi9qZ5wiz/2iyUaQQsA6x6ntfzO4Wx4Hme7PCKeo9AtvFWZ/ToMzs5oVl2WFaljDJsSPr7Oa1ruOJNTAVh/Cn9puOy5GEtVIWZ6w8M0syEtJuJumzzIfb63nCuOuJwyB7YBKowbxUagqMHI3SmXV5Vb/ImWByJ5aLc4FeCc01u9aU8o8QZxS9gl/VVVRfhoDWloGyFFbyU79bMvC++sUz02N60o1hVa+ikI1+pl0ofIA==
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 17:13:01 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::42) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 17:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:13:00 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 17:12:59 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 17:12:59 +0000
Received: from kyarlagadda-linux.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 16 Dec 2021 17:12:55 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v15 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Thu, 16 Dec 2021 22:42:00 +0530
Message-ID: <1639674720-18930-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
References: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa6b6057-0164-4194-65a0-08d9c0b7506a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB238115B1CDCFEC91AFDD4E4BC0779@SN1PR12MB2381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hftE19XKRFcdbLgfbZYOJaPUzKlXuJl4PHWNfO7oWAX4ieh4lZd8Gnhpakztfq/6v4PDzAwhKqlBkStSvwUVxJehn/20geLw7S58+bhJk3n9Jwnj7k5WmlnuLsv1VSjMilsDT+GjoluVj58XwlD02Cf1vL0QNCHma7bR0XQHimRon1VO7CExvNISpQQEK5M+WBtYUjKmhCiI3Rtxx/DpyUJT8IOjPjXCif3cwPze/Hy45R5Z2a/JpGM4+EnVgTwE5ISgDd4LgBfEMFX7ZBnzJGCqAohyVcYijFC+jeDDMYcYkmzwLRwXwhS0NrEGc+74tBlbyVrkSnm1Z7Uuj0OHvlu5wJb1Qr9JsU6vWIOagybtMjDvvJbWaHR1twYKdhFoK/kYocBhJe5qSrwO0fq2Vw8w/i5ybE+QZtPEjIQFcxU0xbvouodjKa7ZbnS5J5fC7ov0Rn/ua01DquEoL3iOcEiO3qnOu3w65w3q4fUIoyHQ8LRJgqmIIvgJI9YYEOFh9vnUbn2/uXjxT5MXpgCJ2HdM05nDobMJG+9pA28rqK0P7v0QvYuzeLMPybATOZ9W6Fz4kYJVlshqIRSAmwr4ddkwjdnnZk/k2nqg9Nk83LyGtnQ9eF96/hG2tax1Xr6kJ3LU5xVoCHrp21Prgea9ft7/6liyBm5+mVoctOkrC9p9l5S6DpuL3LYHzd09uo0f8muuyarQ95Ac/2Kn8TMnAVIJCb9uDCyhzGmUjwpdvJiRDJZj1XMqUuioZq4X55gp8TD06PBo+gV7cqd3pCPitYdlMp01a0QeMOdR6Maa4mI1d9yXwEGtLUuP0ExcgO5a9Edo0HtpZTMbN2oN1muEibrIDqTrJlpqpRKc0Q8bpJGKIJJzt/ikeCDMz5jJlLE8nqZAlI/iQHkMtOGjf/vn0g==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(8936002)(36860700001)(7696005)(26005)(356005)(81166007)(36756003)(40460700001)(82310400004)(47076005)(4326008)(508600001)(336012)(110136005)(426003)(107886003)(5660300002)(8676002)(70586007)(2616005)(34020700004)(186003)(921005)(6666004)(86362001)(70206006)(316002)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:13:00.9240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6b6057-0164-4194-65a0-08d9c0b7506a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2381
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
index 5f81328..6330fe1 100644
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
index 8d29b7f..135d8a1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -114,6 +114,49 @@
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

