Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE8A6030C1
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJRQ3H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 12:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJRQ3A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 12:29:00 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2813BC47B;
        Tue, 18 Oct 2022 09:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnFMS4UzLqmm0/uRiYw4hwB2NMmUw4xKRAT9XXmY+Z5d8G5pk4potm8VpXt2b9FHJPd1lB8/ahvTsp4OtHDTJBMi+HD8YmpeOFEmvu8JHbglfksISkSSohEW+9frERYxIUW1qxBgU0pFkZbLO4e6qbO+Gqd4vDiMuxRV65Ns1cm1Tv2xfmPSQPh2DPLqd8O+64mFgTAuxrEg2Z90TJN9CkxYim2HlBLYIPb9y29nk8BFRt5JrezyGev4eRa6mLD1q8CYt5KBIcm32lqjZGSFtKc6vGWP9bbdqo7pPTDpg0wqyY4unZ7WMucrAJC2F5BjN8t/mALMzzW7I08u6H+RwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQzIWFZ5aH2Zm8fCIT34AMMeWZtJUsHhyL2NPV5hoqc=;
 b=fajK8+XpmSfA+obg0kOFCPzEKvanDonnr8yrfLOVAPU7Kp3MLLUSUeEHnm/I/cPF8IbjGA0OFzFgLDjAkUjh20nGTZUABnS3nklU99n0vyfWQmJLJGEFTxL6WOetV/66gJSKonHIm8zF3OYyIPKGx6qmPjKRiZLozwBJswTFQgQmK2pfq7/A3tTvTNjgrWFrwLahNZfoYoJy4QyG74NeFldRAWJHGDi7qd9O1PZ9i/W2jf5QHdf2NmpfKTHbwD+NYcqGh02T/FDpyRkEtQX++VmqeTLJNYwmmN4p6JK4PYG772iqjqh8WuuRVhv40NhPu5t4ajhAGTnTd7c5jd92og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQzIWFZ5aH2Zm8fCIT34AMMeWZtJUsHhyL2NPV5hoqc=;
 b=PG9RgZbODpl0u+e75cIDrEjU7jTqhPE7e0CoAosd34em4yuHatJYKeOrnawCikUf8bKZrYRpDyEsfbeUMEKVOagvc+1ihw02P4CTRQTpKdLNSrmX2dE49IWlm5Us1ZFDJ7HdrIEV0RMLdyRfNk5BB5TllGkCSz7lp1V/PGGAmupXCg70PJSdF39tjKrI1y66Z31qgSuH1MrzYbqetV78s4g1DC3iycXYTFzwuuJZjxGApSIHxjUzi22fdEFeppHrPewKkJTuL+hMZ+yF5dBy6fyhIsCQZ2+7NLB9OtWGCkA6KK07xUqdlQKF+yYKR2tnu5wQAT5yrv2sClSKrJ7TDA==
Received: from BN9PR03CA0985.namprd03.prod.outlook.com (2603:10b6:408:109::30)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 16:28:53 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::98) by BN9PR03CA0985.outlook.office365.com
 (2603:10b6:408:109::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 16:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=nvidia.com;
Received-SPF: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Tue, 18 Oct 2022 16:28:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 09:28:42 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 09:28:41 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 18 Oct 2022 09:28:38 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH RESEND v2 2/3] arm64: tegra: Add dma-channel-mask in GPCDMA node
Date:   Tue, 18 Oct 2022 21:58:11 +0530
Message-ID: <20221018162812.69673-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221018162812.69673-1-akhilrajeev@nvidia.com>
References: <20221018162812.69673-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: fbebc32c-66be-4e12-9117-08dab125d86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNxaPQhYP5KXEdKh+nnvwwDyHM0zL5QQ4CXo+gbgwVsHESy4tIb9XeX8Ajf2qqwTJUrZ3ZLGsnEtDUvQHA/4e7j0wPUoxnJqbQ6FKuTqTVPywz2wbT368+R3vK09+BnScGtQ6xNZykDtxgfcdjujj5Q/tBdWOPDUXSeKcbE+SRVJga31iTykCSIfbA1hRubPPsLgHvfj7QsvPVOwjI95rCi2HYpspuC7h/o+vbsJ+fbkYvz/vmHRJ/FNnye0oiV2tA8qGQjHrdQ67MSC9g/fmNUM4hrneuONbJuEO9EIianZWynuy8GFDfrWD+BQmlUeQZDjdU2oShHNC4EHnhK+ZPl8EIxlj1fIblV0tsLBPMdgzX9gtQRsQBW4mG+wxG22Ecgu8YFBiQAiL+dvaUwJl1fdXqgPGC4l/QmGUTgeExpmh4IkkGSvFmr0KvG5FLOmm75iG4b1CEaB9VBch3r9WTUKS/BGscLkJdeObSostNT6ozNJOvwif0BBfEteqW4KMjCrCu0JmYG2Msd4yfZiIAzu/4WipydEOjwsRnxYAsLE297xunre7u4fTVRGSkIqWPgSLcR89jEIPxeziVOZUNe46SESNCdbgK6BCLXSN5Wanb0Gv1Ca+DKX/UFMUUnNxyU0yuflh4WvTnVVBWcvBgaHJ2fEGMItZmfgyz6CgffCvO2K7a2k7/Xu9MitrOZXi9rZKm9iRI+0OhRGFiOnqvIIQh53Ya5dawYEGtRLoryzHmtIY+oTnsvPlWe41muot4oEF9l9bIAnGLrO10DkvA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(86362001)(356005)(7636003)(82740400003)(2906002)(6666004)(83380400001)(40460700003)(5660300002)(40480700001)(107886003)(7696005)(336012)(26005)(186003)(2616005)(1076003)(47076005)(426003)(36860700001)(478600001)(82310400005)(110136005)(316002)(70586007)(70206006)(8676002)(4326008)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:28:52.7033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbebc32c-66be-4e12-9117-08dab125d86e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add dma-channel-mask property in Tegra GPCDMA device tree node.

The property would help to specify the channels to be used in
kernel and reserve few for the firmware. This was previously
achieved by limiting the channel number to 31 in the driver.
Now since we can list all 32 channels, update the interrupts
property as well to list all 32 interrupts.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 6602fe421ee8..db479064ff72 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -78,7 +78,8 @@
 		reg = <0x0 0x2600000 0x0 0x210000>;
 		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
 		reset-names = "gpcdma";
-		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -112,6 +113,7 @@
 		#dma-cells = <1>;
 		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
 		dma-coherent;
+		dma-channel-mask = <0xfffffffe>;
 		status = "okay";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 41f3a7e188d0..b009f8145016 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -142,7 +142,8 @@
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -176,6 +177,7 @@
 			#dma-cells = <1>;
 			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
 			dma-coherent;
+			dma-channel-mask = <0xfffffffe>;
 			status = "okay";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 0170bfa8a467..ccc1a4bd094d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -27,7 +27,8 @@
 			reg = <0x2600000 0x210000>;
 			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
 			reset-names = "gpcdma";
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -60,6 +61,7 @@
 				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
+			dma-channel-mask = <0xfffffffe>;
 			dma-coherent;
 		};
 
-- 
2.17.1

