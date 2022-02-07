Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9E4AC32A
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 16:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbiBGPYr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 10:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358405AbiBGPDD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 10:03:03 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD030C0401C2;
        Mon,  7 Feb 2022 07:03:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUy+D0S8EmLPG4u1375EiTUASssHXOOSawoA6fYWh9mxVKhm/3bkU6K64ZemGY2EoSBXM2v9AkmFiZCUeSekR9HQ3+OLAI1kMt2jIUUqKsJaaC4XIoHCP37piLUDMvIap0UC7Rh2KJVDJGxibGNh3S2vfVrC8eJDQAtd1sXyzee1MW1jkUxi234bY+rwMNdxVap8hwMPQ6SwgXA376AtIOyc7lsMUdIcUvZyB+VHVyhztWBkukxWV4BDKwbgV1YxwxQEX8z+DT2rjdwWUiXWyzF5F/Nw3E2fNKiuspgMwoCQz69NNZDiy4jn/VMsmwv0REe7dMxiKJ1+VlYD4qLKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC1XLuJfxHaZgHcbMqAIOauc9UIa0v3oiZRZB7Xznl4=;
 b=TX62pKOtT767BzVpoGnpUVYYVRzvhJrX/1r+YagrPURIfvrcyNJmSDApGr+XpKeeyxPnyChWmyCSlB9IWjWyuts+hsvceCPg2LR4sTbGz2OW6Y1C82PvQJdAKqdIgdC3BKhbRU+UhhD/DeuTTQGhJEgwR00Aa91Kfxhg5Jzo7EsdWwJXv8+gWyIjRkFN5l/BEgL0OuexVivGpaHGI+l2QAoYdzX7Zxa0l42wRNuFf4wKwINFBSjbvixarqdnhkvLLU10vkgq6osIm28zfP3lGA7bzaZEeh8xD6BVaeJ9ZcEi6NcxQ8hTDKzbOAw9G7w0olQ4umiIc6IqJNI65DMr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC1XLuJfxHaZgHcbMqAIOauc9UIa0v3oiZRZB7Xznl4=;
 b=e0JOkG/UYxFcOSdy4B4+rWGnP2mX+LYupyYjFbNtFsN9wtpDPWVazpEtHJWMeWm88UzOYv5Mm5j8mbXeyTVFndQ9In/++RHnbbKUIj4bqBqb/mIyXy+ed+E8Xf56iIkOGPLMnfOlsZ4swjra4vAUlGbGpGrHtS6IW4S+FwmeZEpxeM94M9ijh31aeydrH4n9sWp1/QwceOY7hjJNCbrXA1XT4ccNCKAfdigOFb5IZRoRJBMitNC7Nye0vsFp4LxqKinG/geAglm9+9NO55MkWpM41z/SV5bWjaJ0KFXd9L5o5uKR3sG7jMt+3rXzb4uUnqJPR7MxUdz/2j5ARNYNfQ==
Received: from BN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:e4::8)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:03:00 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::e5) by BN0PR02CA0003.outlook.office365.com
 (2603:10b6:408:e4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Mon, 7 Feb 2022 15:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 15:03:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 15:02:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Feb 2022
 07:02:58 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Feb 2022 07:02:54 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v19 4/4] arm64: tegra: Add GPCDMA node for tegra186 and tegra194
Date:   Mon, 7 Feb 2022 20:31:34 +0530
Message-ID: <1644246094-29423-5-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
References: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbe41651-721e-477e-d944-08d9ea4aeea2
X-MS-TrafficTypeDiagnostic: PH7PR12MB5620:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5620AE5250BDD67277E6ADF7C02C9@PH7PR12MB5620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXnmmMHL2ID7HhmjXo2Ito9T4XNOLxmbq52UN40FVSJrnMyLu2Ifr0sVOdbQk2NaT2kCQKA/zImySYV88Da5nMfyYMFQOd5/sz+zyV9+PHvLGBGiiO/goypdyIsunIhaAOreYS1PaSnVlhRWCvGTEf2IIoekOzRl+LXDAO6PxGYag4Ks+BnCLAGvB/eQ1+Z9355GbXQ0FNSAp3FDYFi5Zvyd+xjyZaGQSToVIL2PwB/kHufmlv4TaFnwoG0SFvPZ67+HdmJWTe95qT7jeXeBsLIxY5g+EwAW5Tq7cT26wTqjYTkALzeltMGnQg9jJXlxpcghUdNylMbQdeuEI/UYcKaoe6qQ0CzRM4oQ+J/jtMpRdqqnPCr1BwA+MlYFpwaKhxdIx09nmIRyb/+ttVT5ZLQrMS8v5yZfcYrzmYJARvQfZJEkLQe4QAXn5YKbVayj0ToApj62nXzsjsLvtm1YZpODl5clBKs8Mxnc6lF5O+Pq+3tWaJZ+2wWS4piUZM7tWDtLHv/KCnvdO/fQsJNr/exKeYzH76vXZDlKrVK5qOWua0MC6Q0fAA4qP63vTPya11XciPXEMidtSswq984P3OmXXrMi2A3cjjAn/gxHYscibG8wMaIqU69ZUn1Pe6EsoAzsF7LPe5hjD7CgLPVx3SVomgPOupIlZIS4oH5tylGr+c6XYkVDDGgYRs+5HudxTkDk5Bnv4Xi0PZ4hatYfgpWScB21UqFHoKTzX5SUaDBaAXBrFilSEFb/uLFbxiUOfnA4ORdDx12bWL4/iZEdRQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(82310400004)(40460700003)(36756003)(356005)(316002)(110136005)(86362001)(36860700001)(921005)(26005)(5660300002)(7696005)(6666004)(47076005)(70206006)(508600001)(107886003)(70586007)(2616005)(186003)(336012)(8936002)(426003)(8676002)(4326008)(2906002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:03:00.0046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe41651-721e-477e-d944-08d9ea4aeea2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index c91afff..899d7b1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -73,6 +73,48 @@
 		snps,rxpbl = <8>;
 	};
 
+	gpcdma: dma-controller@2600000 {
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
index 2d48c37..8b58f5cb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -115,6 +115,49 @@
 			snps,rxpbl = <8>;
 		};
 
+		gpcdma: dma-controller@2600000 {
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

